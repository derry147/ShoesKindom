package uuu.s2k.entity;

import java.util.Map;

public class Product {
	private int id;
	private String brand;
	private String name;
	private double unitPrice;
	private int stock;
	private String photoUrl;
	private String description;
	private String type;  //男,女,童
	private String style;
	private Map<Size_list,Integer> sizeMap; //尺寸
	
	public Product() {}
	public Product(int id,String name,double unitPrice, int stock) {
		this.id=id;
		this.name=name;
		this.unitPrice=unitPrice;
		this.stock=stock;
	}
	public Product(int id,String brand,String name,double unitPrice, int stock) {
		this(id,name,unitPrice,stock);
		this.brand=brand;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	@Override
	public String toString() {
		return "Product [型號=" + id + ", 品牌=" + brand + ", 名稱=" + name + ", 定價=" + unitPrice + ", 庫存="
				+ stock + ", 圖片=" + photoUrl + ", 產品描述=" + description + ", 類別=" + type + ", 風格="
				+ style + "]";
	}
	
	
}
