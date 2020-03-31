package uuu.s2k.entity;

public enum ShippingType {
	SHOP("到店取貨",0), HOME("送貨到府",50), STORE("到店取貨",60);
	
	private final String description;//因為不能更改所以加上final,下面就不能加入set
	private final double fee;
	
	
	private ShippingType(String description, double fee) {
		this.description = description;
		this.fee = fee;
	}
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}
	@Override
	public String toString() {
		return this.description + (fee>0?(","+fee+"元"):"");
	}
	
}