package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="WT_MN_POINT")
public class WtMnPoint implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String mn;

	private String areaid;

	private String areaname;

	private BigDecimal lat;

	private BigDecimal lng;

	private String mnname;

	@Column(name="POINT_QUALITY")
	private String pointQuality;

	@Column(name="POINT_TYPE")
	private BigDecimal pointType;

	private String riverid;

	private String rivername;

	@Column(name="UPPER_POINTS")
	private String upperPoints;

	public WtMnPoint() {
	}

	public String getMn() {
		return this.mn;
	}

	public void setMn(String mn) {
		this.mn = mn;
	}

	public String getAreaid() {
		return this.areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public BigDecimal getLat() {
		return this.lat;
	}

	public void setLat(BigDecimal lat) {
		this.lat = lat;
	}

	public BigDecimal getLng() {
		return this.lng;
	}

	public void setLng(BigDecimal lng) {
		this.lng = lng;
	}

	public String getMnname() {
		return this.mnname;
	}

	public void setMnname(String mnname) {
		this.mnname = mnname;
	}

	public String getPointQuality() {
		return this.pointQuality;
	}

	public void setPointQuality(String pointQuality) {
		this.pointQuality = pointQuality;
	}

	public BigDecimal getPointType() {
		return this.pointType;
	}

	public void setPointType(BigDecimal pointType) {
		this.pointType = pointType;
	}

	public String getRiverid() {
		return this.riverid;
	}

	public void setRiverid(String riverid) {
		this.riverid = riverid;
	}

	public String getRivername() {
		return this.rivername;
	}

	public void setRivername(String rivername) {
		this.rivername = rivername;
	}

	public String getUpperPoints() {
		return this.upperPoints;
	}

	public void setUpperPoints(String upperPoints) {
		this.upperPoints = upperPoints;
	}

}