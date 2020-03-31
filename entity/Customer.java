package uuu.s2k.entity;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Customer {
	public static final char MALE ='M';
	public static final char FEMALE ='F';
	public static final int PASSWORD_MIN_LENGTH =6;
	public static final int PASSWORD_MAX_LENGTH =20;

	//TODO 用FACEBOOK登入
	//TODO 增加訂閱電子報功能
	private String email; //以email當帳號
	private String password;
	private String name;
	private LocalDate birthday;
	private char gender; //M:Male, F:Female
	private String address;
	
	public Customer() {}
	
	public Customer(String email,String password,String name, LocalDate birthday
			, char gender, String country, String address) {
		this.setEmail(email);
		this.setPassword(password);
		this.setName(name);
		this.setBirthday(birthday);
		this.setGender(gender);
		this.setAddress(address);
	}
	public Customer(String email, String password, String name){		
		this.setEmail(email);
		this.setPassword(password);
		this.setName(name);
	}
	
	public String getEmail() {
		return email;
	}
	private static final String EMAIL_PATTERN = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
	public void setEmail(String email) {
		if(email != null && email.matches(EMAIL_PATTERN)) {
			this.email = email;
		}else {
			throw new DataInvalidException("Email格式不正確");
		}
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		if(name!=null && (name=name.trim()).length()>0) {
			this.name = name;
		}else {
			throw new DataInvalidException("必須輸入姓名");
		}
		
	}
	public void setBirthday(String dateStr) {
		try {
			LocalDate dateObj = LocalDate.parse(dateStr);
			setBirthday(dateObj);
		}catch(DateTimeParseException ex) {
			throw new DataInvalidException("客戶生日資料不正確，必須符合iso 8601格式(如: 2000-01-01)");
		}
	}
	public LocalDate getBirthday() {
		return birthday;
	}
	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String toString() {
		return this.getClass().getName()+"[Email: "+email+",密碼: "+password
				+",姓名: "+name+",生日: "+birthday+",性別: "+gender
				+",地址: "+address+"]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Customer other = (Customer) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		return true;
	}
	
	
	
}
