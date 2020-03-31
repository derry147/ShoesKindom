package uuu.s2k.entity;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class ShoppingCart {
	private Customer member;
	private Map<CartItem, Integer> cartMap = new HashMap<>();
	public Customer getMember() {
		return member;
	}
	public void setMember(Customer member) {
		this.member = member;
	}
	
	//cartMap's mutator(s)
	public void addCart(Product p, String sizeCode, int quantity) {
		if(p==null) {
			throw new IllegalArgumentException("加入購物車產品不得為null");
		}
		
		if(quantity<0) {
			throw new IllegalArgumentException("加入購物車時數量必須大於0");
		}		
		//準備好cartItem物件
		CartItem item = new CartItem();
		item.setProduct(p);
		Size size = new Size();
		size.setSizeCode(sizeCode);
		item.setSize(size);
		//先在cart中找找有無已存在的同一產品同一顏色的舊資料
		Integer oldQuantity = cartMap.get(item);
		if(oldQuantity==null) {
			cartMap.put(item, quantity);
		}else {
			cartMap.put(item, oldQuantity+quantity);
		}
	}
	
	public void updateCart(CartItem item, int quantity) {
		if(item==null) {
			throw new IllegalArgumentException("修改購物車時購物明細item不得為null");
		}
		if(quantity<0) {
			throw new IllegalArgumentException("修改購物車時數量必須大於0");
		}
		cartMap.put(item, quantity);		
	}
	
	public void remove(CartItem item) {
		cartMap.remove(item);
	}
	
	
	//cartMap's accessors, delegate methods
	public int size() {
		return cartMap.size();
	}
	public boolean isEmpty() {
		return cartMap.isEmpty();
	}
	
	/**
	 * 取得該購物明細的購買數量
	 * @param item
	 * @return
	 */
	public Integer getQuantity(CartItem item) { 
		return cartMap.get(item);
	}
	
	/**
	 * 取得該購物車的購物明細集合(Set)
	 * @return
	 */
	public Set<CartItem> getCartItemSet() {
		return cartMap.keySet();
	}
	
	//cartMap's accessors, business methods
	/**
	 * 計算購物車中的總購買件數
	 * @return
	 */
	public int getTotalQuantity() {
		int sum = 0;
		//Collection<Integer> values = cartMap.values();
		for(Integer quantity:cartMap.values()) {
			sum+=(quantity==null?0:quantity);
		}		
		return sum;
	}
	
	/**
	 * 計算購物車中的未折扣總金額
	 * @return
	 */
	public double getTotalAmount() {
		double sum = 0;
		for(CartItem item:cartMap.keySet()) {
			int quantity = cartMap.get(item);
			sum += item.getProduct().getUnitPrice() * quantity;
		}		
		
		return sum;
	}
	
	@Override
	public String toString() {
		return "購物車 [會員=" + member + ",\n 購物車內容=" + cartMap + "]";
	}
	
	

}
