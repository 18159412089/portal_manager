package com.fjzxdz.ams.module.attach;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Table;


import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "ATTACH")
public class Attach extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	private String name;

	private BigDecimal latitude;

	private BigDecimal longitude;

	private String status;

	private Boolean enable;

	private String picture;

	// ====================================================DTO===========================================================

	public Attach() {
	}
	
	public String getPicture() {
		return picture;
	}
	
	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getLatitude() {
		return latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	public BigDecimal getLongitude() {
		return longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Boolean getEnable() {
		return enable;
	}

	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

}