package uuu.s2k.service;

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.VGBException;

public class CustomerService {
	private CustomersDAO dao = new CustomersDAO();
	
	public Customer login(String email, String pwd)throws VGBException {
		if(email==null || email.length()==0 || pwd==null ||pwd.length()==0) {
			throw new IllegalArgumentException("會員登入時帳號密碼必須給值");
		}
		
		Customer c = null;
		c = dao.selectCustomerByEmail(email);
		if(c!=null && c.getPassword().equals(pwd)) {
			return c;			
		}else {
			throw new VGBException("登入失敗，帳號或密碼不正確");
		}
	}

	public void register(Customer c) throws VGBException {
		if(c==null) {
			throw new IllegalArgumentException("會員註冊時會員物件不得為null");
		}
		dao.insert(c);
		
	}

	public void update(Customer c) throws VGBException {
		if(c==null) {
			throw new IllegalArgumentException("修改會員時物件不得為null");
		}
		dao.update(c);
	}

}
