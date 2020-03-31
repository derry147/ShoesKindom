package uuu.s2k.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import uuu.s2k.entity.Outlet;
import uuu.s2k.entity.Product;
import uuu.s2k.entity.VGBException;

class ProductsDAO {
	private static final String SELECT_ALL_PRODUCT = "SELECT * FROM products";
	
	List<Product> selectAllProducts() throws VGBException {
		List<Product> list = new ArrayList<>();
		try (
				Connection connection = RDBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCT);
				ResultSet rs = pstmt.executeQuery();
				) {
			while(rs.next()) {
				Product p;
				String className = rs.getString("class_name");
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setBrand(rs.getString("brand"));
				p.setName(rs.getString("name"));
				p.setUnitPrice(rs.getDouble("unit_price"));
				p.setStock(rs.getInt("stock"));
				p.setPhotoUrl(rs.getString("photo_url"));
				p.setDescription(rs.getString("description"));
				list.add(p);
			}
			return list;		
		} catch (SQLException ex) {
			throw new VGBException("查詢全部產品失敗", ex);
		}		
	}

	private static final String SELECT_PRODUCTS_BY_KEYWORDS = "SELECT id, brand, name, unit_price, stock, photo_url, description, discount, class_name"
			+ " FROM products WHERE name LIKE ? OR description LIKE ?";
	
	List<Product> selectProductsByKeyword(String keyword) throws VGBException {
		List<Product> list = new ArrayList<>();
		try (Connection connection = RDBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_KEYWORDS);
		){
		pstmt.setString(1, '%' + keyword + '%'); // 3.1傳入?的值
		pstmt.setString(2, '%' + keyword + '%'); // 3.1傳入?的值

		ResultSet rs = pstmt.executeQuery(); //4.執行指令
			
			//5.處理rs
			while (rs.next()) {
				Product p;
				String className = rs.getString("class_name");
				if("Outlet".equals(className)) {
					p = new Outlet();
					((Outlet)p).setDiscount(rs.getInt("discount"));
				}else {
					p = new Product();
				}
				p.setId(rs.getInt("id"));
				p.setBrand(rs.getString("brand"));
				p.setName(rs.getString("name"));
				p.setUnitPrice(rs.getDouble("unit_price"));
				p.setStock(rs.getInt("stock"));
				p.setPhotoUrl(rs.getString("photo_url"));
				p.setDescription(rs.getString("description"));
				
				list.add(p);
			}
			return list;
		}catch (SQLException ex) {
			throw new VGBException("查詢全部產品失敗", ex);
		}
	}

	private static final String SELECT_PRODUCT_BY_ID="SELECT id, brand, name, unit_price, stock, photo_url, description, discount, class_name"
			+ " FROM products WHERE id=?";
	
	Product selectProductsById(String productId) throws VGBException{
		Product p =null;
		try(
			Connection connection = RDBConnection.getConnection();//1.2取得連線
			PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_BY_ID);//3.準備指令		
		){
			pstmt.setString(1, productId);//3.1傳入?值
			ResultSet rs=pstmt.executeQuery();//4.執行指令
			
			while(rs.next()) {
				if(p==null) {
					String className = rs.getString("class_name");
					if("Outlet".equals(className)) {
						p=new Outlet();
						((Outlet)p).setDiscount(rs.getInt("discount"));
					}else {
						p=new Product();
					}
					
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setDescription(rs.getString("description"));
				}
			}
		}catch (SQLException e) {
			throw new VGBException("查詢產品失敗", e);
		}
		return p;
		
		
	}
}	