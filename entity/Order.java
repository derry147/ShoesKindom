package uuu.s2k.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;



public class Order {
	
	private int id;  //pkey auto increment
	private Customer member;
	private LocalDate orderDate=LocalDate.now();
	private LocalTime orderTime=LocalTime.now();
	private int status=0;//{0-新訂單 ,1-已通知, 2-已付款, 3-已出貨}
	
	
	private double paymentFee;
	private PaymentType paymentType; //required
	private String paymentNote="";
	
	private double shippingFee;
	private ShippingType shippingType;//required
	private String shippingNote="";
	
	private String recipientName;
	private String recipientEmail;
	private String recipientPhone;
	private String shippingAddress;
	private double totalAmount;
	
	private List<OrderItem> orderItemsList = new ArrayList<>();

	//mutator
	public void add(ShoppingCart cart) {//給controller把購物車的明細變成訂單的明細
		if(cart==null || cart.isEmpty()) {
			throw new IllegalArgumentException("把購物車的明細變成訂單的明細，購物車不得為null或是必須有明細");
		}
		for(CartItem cartItem:cart.getCartItemSet()) {
			OrderItem orderItem = new OrderItem();
			orderItem.setProduct(cartItem.getProduct());
			orderItem.setSize(cartItem.getSize());
			orderItem.setQuantity(cart.getQuantity(cartItem));
			orderItem.setPrice(cartItem.getProduct().getUnitPrice());;
			
			orderItemsList.add(orderItem);
		}
	}
	
	
	
	//mutator
	public void add(OrderItem item) { //給DAO把訂單明細table中的每一筆訂單明細加入訂單
		orderItemsList.add(item);
	}
	
	//accessor
	public List<OrderItem> getorderItemsList(){
		return new ArrayList<>(orderItemsList);
	}
	public int size() { //訂單長度
		return orderItemsList.size();
	}
	
	public int getTotalQuantity() {
		int sum=0;
		for(OrderItem orderItem:orderItemsList) {
			sum+=orderItem.getQuantity();
		}
		return sum;
	}
	
	public double getTotalAmount() {
		double sum=0;
		if(orderItemsList==null || orderItemsList.isEmpty()) {
			return this.totalAmount;
		}
		
		for(OrderItem orderItem:orderItemsList) {
			sum+=orderItem.getQuantity()*orderItem.getPrice();
		}
		return sum;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Customer getMember() {
		return member;
	}

	public void setMember(Customer member) {
		this.member = member;
	}

	public LocalDate getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}

	public LocalTime getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(LocalTime orderTime) {
		this.orderTime = orderTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public double getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(double paymentFee) {
		this.paymentFee = paymentFee;
	}

	public PaymentType getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}

	public String getPaymentNote() {
		return paymentNote;
	}

	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}

	public double getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(double shippingtFee) {
		this.shippingFee = shippingFee;
	}

	public ShippingType getShippingType() {
		return shippingType;
	}

	public void setShippingType(ShippingType shippingType) {
		this.shippingType = shippingType;
	}

	public String getShippingNote() {
		return shippingNote;
	}

	public void setShippingNote(String pshippingNote) {
		this.shippingNote = shippingNote;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientEmail() {
		return recipientEmail;
	}

	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}

	public String getRecipientPhone() {
		return recipientPhone;
	}

	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public List<OrderItem> getOrderItemsList() {
		return orderItemsList;
	}

	public void setOrderItemsList(List<OrderItem> orderItemsList) {
		this.orderItemsList = orderItemsList;
	}
	public double getTotalAmountWithFee() {

	       return getTotalAmount()+paymentFee+shippingFee;

	    }



	@Override
	public String toString() {
		return "Order [id=" + id + ", member=" + member + ", orderDate=" + orderDate + ", orderTime=" + orderTime
				+ ", status=" + status + ", paymentFee=" + paymentFee + ", paymentType=" + paymentType
				+ ", paymentNote=" + paymentNote + ", shippingFee=" + shippingFee + ", shippingType=" + shippingType
				+ ", shippingNote=" + shippingNote + ", recipientName=" + recipientName + ", recipientEmail="
				+ recipientEmail + ", recipientPhone=" + recipientPhone + ", shippingAddress=" + shippingAddress
				+ ", totalAmount=" + totalAmount + ", orderItemsList=" + orderItemsList + "]";
	}
	
	
	
}
