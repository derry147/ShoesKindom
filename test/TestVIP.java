package uuu.s2k.test;

import uuu.s2k.entity.VIP;

public class TestVIP {
	public static void main(String[] args) {
		VIP vip = new VIP();
		vip.setEmail("jeff1001tw@gmail.com");
		vip.setPassword("123456");
		vip.setName("陳坦杰");
		vip.setBirthday("1992-10-01");
		vip.setGender('M');
		vip.setAddress("桃園市");
		vip.setDiscount(15);
		
		System.out.println(vip.getEmail());
		System.out.println(vip.getPassword());
		System.out.println(vip.getName());
		System.out.println(vip.getBirthday());
		System.out.println(vip.getGender());
		System.out.println(vip.getAddress());
		System.out.println(vip.getDiscountString());
	}
	
	
}
