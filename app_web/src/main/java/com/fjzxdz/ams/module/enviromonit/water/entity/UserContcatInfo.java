package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "USER_CONTACT_INFO")
public class UserContcatInfo extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	@Column(name="user_name")
	private String userName;

	private String phone;

	private String address;

	public UserContcatInfo() {
		// TODO Auto-generated constructor stub
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	

}