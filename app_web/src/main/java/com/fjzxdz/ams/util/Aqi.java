package com.fjzxdz.ams.util;

public class Aqi {
	private String name;
	private Double aqi;
	
	public Aqi(String name, double aqi) {
		super();
		this.name = name;
		this.aqi = aqi;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getAqi() {
		return aqi;
	}
	public void setAqi(Double aqi) {
		this.aqi = aqi;
	}
	

}
