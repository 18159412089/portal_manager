package com.fjzxdz.ams.module.enviromonit.air.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * 空气站点实体 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:59:00
 */
@Entity
@Table(name = "AIR_MONITOR_POINT")
public class AirMonitorPoint implements Serializable {

    private static final long serialVersionUID = -753299116150198160L;

	@Id
	@Column(name="POINT_CODE")
	private String pointCode;

	@Column(name="CODE_AIRLEVEL")
	private String codeAirLevel;

	@Column(name="CODE_REGION")
	private String codeRegion;

	private BigDecimal latitude;

	private BigDecimal longitude;

	@Column(name="POINT_ADDRESS")
	private String pointAddress;

	@Column(name="POINT_NAME")
	private String pointName;

	@Column(name="POINT_TYPE")
	private String pointType;

	@Column(name="REGION_NAME")
	private String regionName;

	@Column(name="YEAR_NUMBER")
	private BigDecimal yearNumber;
	
	private String parent;
	
	public AirMonitorPoint() {
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getCodeAirLevel() {
		return codeAirLevel;
	}

	public void setCodeAirLevel(String codeAirLevel) {
		this.codeAirLevel = codeAirLevel;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
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

	public String getPointAddress() {
		return pointAddress;
	}

	public void setPointAddress(String pointAddress) {
		this.pointAddress = pointAddress;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public BigDecimal getYearNumber() {
		return yearNumber;
	}

	public void setYearNumber(BigDecimal yearNumber) {
		this.yearNumber = yearNumber;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}
	
}
