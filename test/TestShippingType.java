package uuu.s2k.test;

import uuu.s2k.entity.PaymentType;
import uuu.s2k.entity.ShippingType;

public class TestShippingType {

	public static void main(String[] args) {
		System.out.println(PaymentType.STORE);
		System.out.println(ShippingType.STORE);

		System.out.println(PaymentType.values().length);
		System.out.println(ShippingType.values().length);
		
		System.out.println(PaymentType.SHOP.getDescription());
		System.out.println(ShippingType.STORE.getDescription());
	}

}
