package uuu.s2k.service;

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.Order;
import uuu.s2k.entity.OrderItem;
import uuu.s2k.entity.PaymentType;
import uuu.s2k.entity.Product;
import uuu.s2k.entity.ShippingType;
import uuu.s2k.entity.VGBException;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

class OrdersDAO {
	private static final String INSERT_ORDERS="INSERT INTO orders " + 
			"	(id, customer_id, order_date, order_time, status, \r\n" + 
			"	payment_type, payment_fee,\r\n" + 
			"	shipping_type, shipping_fee, \r\n" + 
			"	recipientName, recipientEmail, recipientPhone, shippingAddress)\r\n" + 
			"VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);";
	
	private static final String INSERT_ORDER_ITEMS="INSERT INTO order_items\r\n" + 
			"(order_id, product_id, size, price, quantity)\r\n" + 
			"VALUES(?,?,?,?,?);";
	
	public void insert(Order order) throws VGBException{
		 try(Connection connection = RDBConnection.getConnection();//1.2取得連線
			 PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDERS,Statement.RETURN_GENERATED_KEYS);//3.準備INSERT_ORDERS指令
			 PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS);//3.準備INSERT_ORDER_ITEMS指令
			 ){
			 
			 connection.setAutoCommit(false);//取得transaction(交易)的控制權
			 try{
			 	//3-1傳入pstmt1,?的值
			 	pstmt1.setInt(1, order.getId());
			 	pstmt1.setString(2, order.getMember().getEmail());
			 	pstmt1.setString(3, order.getOrderDate().toString());//DATE,TIME都用字串傳值即可
			 	pstmt1.setString(4, order.getOrderTime().toString());
			 	pstmt1.setInt(5, order.getStatus());
			 	pstmt1.setString(6, order.getPaymentType().name());
			 	pstmt1.setDouble(7, order.getPaymentFee());
			 	pstmt1.setString(8, order.getShippingType().name());
			 	pstmt1.setDouble(9, order.getShippingFee());
			 	pstmt1.setString(10,order.getRecipientName());
			 	pstmt1.setString(11,order.getRecipientEmail());
			 	pstmt1.setString(12,order.getRecipientPhone());
			 	pstmt1.setString(13,order.getShippingAddress());
			 	//4執行pstmt1
				pstmt1.executeUpdate();	
				
				//取得自動給號的值
				try(ResultSet rs = pstmt1.getGeneratedKeys()){
					while(rs.next()) {
						int id = rs.getInt(1);
						order.setId(id);
					}
				}
				for(OrderItem item:order.getorderItemsList()) {
					//3-1傳入pstmt2,?的值
					pstmt2.setInt(1, order.getId());
					pstmt2.setInt(2, item.getProduct().getId());
					pstmt2.setString(3, item.getSize()!=null?item.getSize().getSizeCode():"");
					pstmt2.setDouble(4, item.getPrice());
					pstmt2.setInt(5, item.getQuantity());
					
					//4執行pstmt2
					pstmt2.executeUpdate();
				}
				
					connection.commit();
				 }catch(Exception ex) {
					 connection.rollback();
					 throw ex;
				 }finally {  //調整效能用的，在本專案感覺不出來
					 connection.setAutoCommit(true);
				 }
			
		} catch (SQLException ex) {
			throw new VGBException("新增訂單失敗", ex);
		}
		 
	 }

	private static final String SELECT_ORDER_HISTORY="SELECT id, customer_id, order_date, order_time, status," 
			+ " payment_type, payment_fee, payment_note," 
			+ " shipping_type, shipping_fee, shipping_note," 
			+ " recipientName, recipientEmail, recipientPhone, shippingAddress," 
			+ " SUM(order_items.price*order_items.quantity) as total_amount" 
			+ "	 FROM orders JOIN order_items ON orders.id = order_items.order_id" 
			+ "	  WHERE customer_id=? " 
			+ "   GROUP BY orders.id ORDER BY order_date desc,order_time desc"; //訂單分組(明細/金額) 小計
	List<Order> selectOrderHistory(String customerId)throws VGBException {
		List<Order> list = new ArrayList<>();
		try(Connection connection = RDBConnection.getConnection(); //1.2 取得連線
				 PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_HISTORY); //3.準備SELECT_ORDER_HISTORY指令				
		){
			//3.1 傳入pstmt的?的值
			pstmt.setString(1, customerId);
			
			//4 執行pstmt
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {					
					Order order = new Order();
					order.setId(rs.getInt("id"));
					order.setOrderDate(LocalDate.parse(rs.getString("order_date")));
					order.setOrderTime(LocalTime.parse(rs.getString("order_time")));
					order.setStatus(rs.getInt("status"));
					
					order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
					order.setPaymentFee(rs.getDouble("payment_fee"));
					order.setPaymentNote(rs.getString("payment_note"));
					
					order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
					order.setShippingFee(rs.getDouble("shipping_fee"));
					order.setShippingNote(rs.getString("shipping_note"));
					
					order.setRecipientName(rs.getString("recipientName"));
					order.setRecipientEmail(rs.getString("recipientEmail"));
					order.setRecipientPhone(rs.getString("recipientPhone"));
					order.setShippingAddress(rs.getString("shippingAddress"));
					order.setTotalAmount(rs.getDouble("total_amount"));
					list.add(order);
				}
			}
			
		}catch(SQLException ex) {
			throw new VGBException("查詢歷史訂單失敗", ex);
		}
		return list;
	}
	
	private static final String SELECT_ORDER_BY_ID="SELECT orders.*, order_items.*, " 
			+ "	products.name, products.photo_url as photo_url" 
			+ "	FROM orders JOIN order_items ON orders.id = order_items.order_id" 
			+ "		JOIN products ON order_items.product_id=products.id" 
			+ " WHERE orders.id=?";
	Order selectOrderById(String orderId) throws VGBException{
		Order order = null;
		try(Connection connection = RDBConnection.getConnection(); //1.2 取得連線
				 PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_BY_ID); //3.準備SELECT_ORDER_BY_ID指令				
		){
			//3.1 傳入pstmt的?的值
			pstmt.setString(1, orderId);
			
			//4 執行pstmt
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {		
					if(order==null) {
						order = new Order();
						order.setId(rs.getInt("id"));
						order.setOrderDate(LocalDate.parse(rs.getString("order_date")));
						order.setOrderTime(LocalTime.parse(rs.getString("order_time")));
						order.setStatus(rs.getInt("status"));
						/*
						Customer c = new Customer();
						c.setEmail(rs.getString("email"));
						order.setMember(c);
						*/
						order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
						order.setPaymentFee(rs.getDouble("payment_fee"));
						order.setPaymentNote(rs.getString("payment_note"));
						
						order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
						order.setShippingFee(rs.getDouble("shipping_fee"));
						order.setShippingNote(rs.getString("shipping_note"));
						
						order.setRecipientName(rs.getString("recipientName"));
						order.setRecipientEmail(rs.getString("recipientEmail"));
						order.setRecipientPhone(rs.getString("recipientPhone"));
						order.setShippingAddress(rs.getString("shippingAddress"));
					}
					OrderItem item = new OrderItem();
					item.setOrderId(order.getId());
					
					Product p = new Product();
					p.setId(rs.getInt("product_id"));
					p.setName(rs.getString("name"));
					p.setPhotoUrl(rs.getString("photo_url"));
					item.setProduct(p);
					
					String sizeCode = rs.getString("size");
					item.setPrice(rs.getDouble("price"));
					item.setQuantity(rs.getInt("quantity"));					
					order.add(item);
					
				}
				return order;
			}
			
		}catch(SQLException ex) {
			throw new VGBException("查詢歷史訂單失敗", ex);
		}
		
	}
	private static final String UPDATE_STATUS_TO_ENTERED = "UPDATE orders SET status=2" //狀態設定為已付款

            + ", payment_note=? WHERE id=? AND customer_id=?"

            + " AND status=0" + " AND payment_type='" + PaymentType.CARD.name() + "'";

 

    public void updateStatusToPAID(int orderId, String customerId, String paymentNote) throws VGBException {

        try (Connection connection = RDBConnection.getConnection(); //2. 建立連線

                PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_ENTERED) //3. 準備指令

                ) {

            //3.1 傳入?的值

            pstmt.setString(1, paymentNote);

            pstmt.setInt(2, orderId);

            pstmt.setString(3, customerId);

 

            //4. 執行指令

            pstmt.executeUpdate();

        } catch (SQLException ex) {

            System.out.println("修改信用卡付款入帳狀態失敗-" + ex);

            throw new VGBException("修改信用卡付款入帳狀態失敗!", ex);

        }

    }
}
