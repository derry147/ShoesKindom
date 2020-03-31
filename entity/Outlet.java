package uuu.s2k.entity;

public class Outlet extends Product {
	private int discount;
	
	public Outlet() {}
	
	public Outlet(int id,String brand,String name,double unitPrice,int stock,int discount) {
		super(id,brand,name,unitPrice,stock);
		this.discount=discount;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if(discount>=0 && discount<=100) {
			this.discount = discount;
		}else {
			System.out.println("Outlet折扣不正確");
		}
	}
	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10 ==0) {
			discount = discount/10;
		}
		return discount+"折";
	}
	
	@Override
	public double getUnitPrice() {//查詢售價
		return super.getUnitPrice() * (100-discount)/100;
	}
	
	public double getListPrice() {//查詢定價
		return super.getUnitPrice();
	}
	
	public String toString() {
		return super.toString()+ "Outlet [折扣=" + discount + "]";
	}

	
}
