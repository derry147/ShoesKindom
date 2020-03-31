package uuu.s2k.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import com.mysql.cj.protocol.Resultset;
import com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException;

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.VGBException;
import uuu.s2k.entity.VIP;

public class CustomersDAO {
	private static final String SELECT_CUSTOMER_BY_EMAIL =
			"SELECT email,password,name,birthday,gender,address,discount,class_name"
			+ " FROM customers"
			+ " WHERE email=?";
			
	public Customer selectCustomerByEmail(String email)throws VGBException {
		Customer c = null;
		try(	
			Connection connection = RDBConnection.getConnection();// 1,2 取得連線，最後要close
			PreparedStatement pstmt = connection.prepareStatement(SELECT_CUSTOMER_BY_EMAIL);// 3.準備指令，最後要close	
		){
			//3-1 傳入?的值
			pstmt.setString(1, email);
			try(ResultSet rs = pstmt.executeQuery();// 4.執行指令，最後要close rs
			){
				//5.處理rs
				while(rs.next()) {
					String className = rs.getString("class_name");
					if("VIP".equals(className)) {
						c = new VIP();
						((VIP)c).setDiscount(rs.getInt("discount"));
					}else {
						c=new Customer();
					}
					c.setEmail(rs.getString("email"));
					c.setPassword(rs.getString("password"));
					c.setName(rs.getString("name"));
					c.setBirthday(rs.getString("birthday"));
					c.setGender(rs.getString("gender").charAt(0));
					c.setAddress(rs.getString("address"));
				}
			}
		}catch (SQLException e) {
			throw new VGBException("查詢客戶失敗", e);
		}	
		return c;
	}

	private static final String INSERT_CUSTOMER = "INSERT INTO customers\r\n" + 
			"(email, password, name, birthday, gender, address, discount, class_name)\r\n" + 
			"VALUES (?,?,?,?,?,?,?,?)";	
	public void insert(Customer c)throws VGBException {
		try(
			Connection connection = RDBConnection.getConnection();//1.2取得連線,放進()代表之後要關閉
			PreparedStatement pstmt = connection.prepareStatement(INSERT_CUSTOMER);//3.準備指令，最後要關掉
		){//3.1
		pstmt.setString(1, c.getEmail());
		pstmt.setString(2, c.getPassword());//TODO
		pstmt.setString(3, c.getName());
		pstmt.setString(4, c.getBirthday()!=null?c.getBirthday().toString():null);
		pstmt.setString(5, String.valueOf(c.getGender()));
		pstmt.setString(6, c.getAddress());	
		if(c instanceof VIP) {
			pstmt.setInt(7, ((VIP)c).getDiscount());
		}else {
			pstmt.setInt(7, 0);
		}
		pstmt.setString(8, c.getClass().getSimpleName());
		
		
		//4.執行指令
		pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new VGBException("新增客戶失敗", e);
		}
		
	}
	private static final String UPDATE_CUSTOMERS ="UPDATE customers "+
			"SET password=?, name=?, birthday=?, gender=?, address=? "+
			", discount=?, class_name=? WHERE email=?";		
	public void update(Customer c) throws VGBException {
		try(
			Connection connection = RDBConnection.getConnection();//1.2取得連線,放進()代表之後要關閉
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_CUSTOMERS);//3.準備指令，最後要關掉
		){//3.1傳入?的參數
			pstmt.setString(8, c.getEmail());
			pstmt.setString(1, c.getPassword());
			pstmt.setString(2, c.getName());
			pstmt.setString(3, c.getBirthday()!=null?c.getBirthday().toString():null);
			pstmt.setString(4, String.valueOf(c.getGender()));
			pstmt.setString(5, c.getAddress());
			if(c instanceof VIP) {
				pstmt.setInt(6, ((VIP)c).getDiscount());
			}else {
				pstmt.setInt(6, 0);
			}
			pstmt.setString(7, c.getClass().getSimpleName());
			
			//4.執行指令
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new VGBException("修改客戶失敗", e);
		}
		
	}

}
