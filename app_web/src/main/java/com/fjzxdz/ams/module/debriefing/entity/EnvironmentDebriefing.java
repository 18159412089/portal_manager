package com.fjzxdz.ams.module.debriefing.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "ENVIRONMEENT_DEBRIEFING")
public class EnvironmentDebriefing extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	private String name;

	private BigDecimal latitude;

	private BigDecimal longitude;

	private String status;

	private Boolean enable;
	
	private Boolean isover;

	private String picture;

	private String code;

	private String city;

	@Column(name="TIME_LIMIT")
	private String timelimit;

	@Column(name="PLAN_CITY_TIME")
	private String pctime;

	@Column(name="AC_CITY_TIME")
	private String actime;

	@Column(name="PLAN_TRADE_TIME")
	private String pttime;

	@Column(name="ACTUAL_TRADE_TIME")
	private String attime;

	@Column(name="OVER_TIME")
	private String overtime;

	// ====================================================DTO===========================================================

	public EnvironmentDebriefing() {
	}
	
	public String getOvertime() {
		return overtime;
	}
	
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	
	public Boolean getIsover() {
		return isover;
	}
	
	public void setIsover(Boolean isover) {
		this.isover = isover;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getTimelimit() {
		return timelimit;
	}

	public void setTimelimit(String timelimit) {
		this.timelimit = timelimit;
	}

	public String getPctime() {
		return pctime;
	}

	public void setPctime(String pctime) {
		this.pctime = pctime;
	}

	public String getActime() {
		return actime;
	}

	public void setActime(String actime) {
		this.actime = actime;
	}

	public String getPttime() {
		return pttime;
	}

	public void setPttime(String pttime) {
		this.pttime = pttime;
	}

	public String getAttime() {
		return attime;
	}

	public void setAttime(String attime) {
		this.attime = attime;
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