package uuu.s2k.entity;

public enum PaymentType {//列舉型別，原本寫法是public static final SHOP=0
	SHOP("到店付款"), ATM("ATM轉帳"), HOME("貨到付款",100), 
	STORE("超商付款"), CARD("信用卡付款");
	
	private final String description;
	private final double fee;
	
	
	
	private PaymentType(String description) {//只給desc,fee不給值就預設0
		this(description,0);
	}
	private PaymentType(String description, double fee) {//兩個屬性都給值
		this.description = description;
		this.fee = fee;
	}
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}
	
	
	
	
	
}
