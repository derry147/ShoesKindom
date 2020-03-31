package uuu.s2k.test;

import java.time.LocalDate;
import java.util.Scanner;

import uuu.s2k.entity.Customer;

public class TestCustomer {

	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		Customer c = new Customer();
		System.out.println("請輸入Email: ");
		c.setEmail(scanner.next());
		System.out.println("請輸入密碼:  ");
		c.setPassword(scanner.next());
		System.out.println("請輸入姓名:  ");
		c.setName(scanner.next());
		System.out.println("請輸入出生年份:  ");
		int year = scanner.nextInt();
		System.out.println("請輸入出生月分: ");
		int month = scanner.nextInt();
		System.out.println("請輸入出生日:  ");		
		int day = scanner.nextInt();

		LocalDate theDay = LocalDate.of(year,month,day);
		c.setBirthday(theDay);
		System.out.println("請輸入姓別(M/F):  ");
		c.setGender(scanner.next().charAt(0));
		System.out.println("請輸入所在地址:  ");
		c.setAddress(scanner.next());
		
		System.out.println(c);
		
	}

}
