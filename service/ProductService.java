package uuu.s2k.service;

import java.util.List;

import uuu.s2k.entity.Product;
import uuu.s2k.entity.VGBException;

public class ProductService {
	private ProductsDAO dao = new ProductsDAO();
	
	public List<Product> getAllProducts() throws VGBException{
		return dao.selectAllProducts();
	}
	public List<Product> getProductsByKeyword(String keyword)throws VGBException{
		return dao.selectProductsByKeyword(keyword);
	}
	
	public Product getProductById(String productId) throws VGBException{
		return dao.selectProductsById(productId);
	}
}
