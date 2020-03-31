package uuu.s2k.service;
import java.sql.*;

import uuu.s2k.entity.VGBException;
class RDBConnection {
	private static final String driver="com.mysql.cj.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/s2k?serverTimezone=UTC";
	private static final String userId = "root";
	private static final String pwd = "1234";
	
	public static Connection getConnection()throws VGBException {
		try {
			Class.forName(driver);//1.載入JDBC Driver
			try{		
				Connection connection = 
					DriverManager.getConnection(url,userId, pwd);//2.建立連線
				return connection;
			} catch (SQLException e) {
				throw new VGBException("建立連線失敗", e);
			}
		} catch (ClassNotFoundException e) {
			throw new VGBException("載入JDBC Driver失敗", e);
		}
	}
}
