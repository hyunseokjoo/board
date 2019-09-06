package com.java.board;

public class UserInfo {
	
	private String id;
	private String password;
	private String passwordCheck;
	private String b_year;
	private String b_month;
	private String b_day;
	private String email;
	private String gender;
	private String phone;
	
	public UserInfo(String id, String password, String email, String gender,String phone,  String passwordCheck,String b_year,String b_month,String b_day) {
		this.id = id;
		this.password = password;
		this.b_year = b_year;
		this.b_month = b_month;
		this.b_day = b_day;
		this.email = email;
		this.gender = gender;
		this.phone = phone;
		this.passwordCheck = passwordCheck;
	}
	public UserInfo() {}	
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPasswordCheck() {
		return passwordCheck;
	}
	public void setPasswordCheck(String passwordCheck) {
		this.passwordCheck = passwordCheck;
	}
	
	public String getB_year() {
		return b_year;
	}
	public void setB_year(String b_year) {
		this.b_year = b_year;
	}
	public String getB_month() {
		return b_month;
	}
	public void setB_month(String b_month) {
		this.b_month = b_month;
	}
	public String getB_day() {
		return b_day;
	}
	public void setB_day(String b_day) {
		this.b_day = b_day;
	}
	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", password=" + password + ", passwordCheck=" + passwordCheck + ", b_year="
				+ b_year + ", b_month=" + b_month + ", b_day=" + b_day + ", email=" + email + ", gender=" + gender
				+ ", phone=" + phone + "]";
	}
	
}
