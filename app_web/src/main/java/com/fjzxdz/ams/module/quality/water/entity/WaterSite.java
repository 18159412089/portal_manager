package com.fjzxdz.ams.module.quality.water.entity;

import javax.persistence.*;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name="WATER_SITE")
public class WaterSite extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;

	private String basic;

	private String city;

	@Column(name="CONN_STATUS")
	private String connStatus;

	private String county;

	private Boolean enable;

	private String hierarchy;

	@Column(name="LONG_AND_LAT")
	private String lal;

	@Column(name="MONITOR_TYPE")
	private String monitorType;

	private String name;

	public WaterSite() {
	}

	public String getBasic() {
		return this.basic;
	}

	public void setBasic(String basic) {
		this.basic = basic;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getConnStatus() {
		return this.connStatus;
	}

	public void setConnStatus(String connStatus) {
		this.connStatus = connStatus;
	}

	public String getCounty() {
		return this.county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public Boolean getEnable() {
		return this.enable;
	}

	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

	public String getHierarchy() {
		return this.hierarchy;
	}

	public void setHierarchy(String hierarchy) {
		this.hierarchy = hierarchy;
	}

	public String getLAL() {
		return this.lal;
	}

	public void setLAL(String lal) {
		this.lal = lal;
	}

	public String getMonitorType() {
		return this.monitorType;
	}

	public void setMonitorType(String monitorType) {
		this.monitorType = monitorType;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
}