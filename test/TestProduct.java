package uuu.s2k.test;

import uuu.s2k.entity.Product;

public class TestProduct {

	public static void main(String[] args) {
		Product p = new Product(1,"ADIDAS","YEEZY350",10800,3);
		//p.setId(1);
//		p.setName("YEEZY350");
//		p.setUnitPrice(10800);
//		p.setStock(3);
		
//		System.out.println(p.getId());
//		System.out.println(p.getName());
//		System.out.println(p.getUnitPrice());
//		System.out.println(p.getStock());
		System.out.println(p); //因為有寫TOString
	}
	
	
}
