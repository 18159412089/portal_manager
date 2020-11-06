package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="WT_CITY_POINT")
public class WtCityPoint implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="POINT_CODE")
	private String pointCode;

	@Column(name="POINT_NAME")
	private String pointName;

	@Column(name="CODE_WSYSTEM")
	private String codeWsystem;

	@Column(name="WSYSTEM_NAME")
	private String wsystemName;

	@Column(name="CODE_REGION")
	private String codeRegion;

	@Column(name="REGION_NAME")
	private String regionName;

	private BigDecimal longitude;

	private BigDecimal latitude;

	@Column(name="POINT_TYPE")
	private BigDecimal pointType;

	@Column(name="POINT_QUALITY")
	private String pointQuality;

	private BigDecimal status;
	
	@Lob
	private String remark;
	
	@Lob
	private String polygon;
	
	@Lob
	private String lines;
	
	private String category;
	
	private BigDecimal isview;

	public WtCityPoint() {
	}

	public String getPointCode() {
		return pointCode;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public BigDecimal getIsview() {
		return isview;
	}

	public void setIsview(BigDecimal isview) {
		this.isview = isview;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getCodeWsystem() {
		return codeWsystem;
	}

	public void setCodeWsystem(String codeWsystem) {
		this.codeWsystem = codeWsystem;
	}

	public String getWsystemName() {
		return wsystemName;
	}

	public void setWsystemName(String wsystemName) {
		this.wsystemName = wsystemName;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public BigDecimal getLongitude() {
		return longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	public BigDecimal getLatitude() {
		return latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	public BigDecimal getPointType() {
		return pointType;
	}

	public void setPointType(BigDecimal pointType) {
		this.pointType = pointType;
	}

	public String getPointQuality() {
		return pointQuality;
	}

	public void setPointQuality(String pointQuality) {
		this.pointQuality = pointQuality;
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPolygon() {
		return polygon;
	}

	public void setPolygon(String polygon) {
		this.polygon = polygon;
	}

	public String getLines() {
		return lines;
	}

	public void setLines(String lines) {
		this.lines = lines;
	}

}