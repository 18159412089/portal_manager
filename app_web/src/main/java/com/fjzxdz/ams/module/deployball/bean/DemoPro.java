package com.fjzxdz.ams.module.deployball.bean;

public class DemoPro implements java.io.Serializable{//对应hikdemo.properties属性值
	/** 序列化ID*/
	private static final long	serialVersionUID	= 1L;
	private String username;
	private String password;
	private String casIpPort;
	private String vasIpPort;
	private String vmsIpPort;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getVasIpPort() {
		return vasIpPort;
	}
	public void setVasIpPort(String vasIpPort) {
		this.vasIpPort = vasIpPort;
	}
	public String getVmsIpPort() {
		return vmsIpPort;
	}
	public void setVmsIpPort(String vmsIpPort) {
		this.vmsIpPort = vmsIpPort;
	}
	public String getCasIpPort() {
		return casIpPort;
	}
	public void setCasIpPort(String casIpPort) {
		this.casIpPort = casIpPort;
	}
	
	

}
