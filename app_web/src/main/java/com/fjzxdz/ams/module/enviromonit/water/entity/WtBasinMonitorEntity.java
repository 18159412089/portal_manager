package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * 
 * @author wudenglin 小河流域列表未修改的数据表
 */
@Entity
@Table(name = "WT_BASIN_MONITOR")
public class WtBasinMonitorEntity extends BaseWtBasinMonitorEntity {

	/**
	 * @Fields serialVersionUID :
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "UUID")
	private String uuid;

	@Column(name = "MONITOR_CODE")
	private String monitorCode;

	@Column(name = "MONITOR_NAME")
	private String monitorName;

	@Column(name = "LONGITUDE")
	private BigDecimal longitude;

	@Column(name = "LATITUDE")
	private BigDecimal latitude;

	@Column(name = "LINES")
	@Lob
	private String lines;

	@Column(name = "ANALYSIS")
	@Lob
	private String analysis;

	@Column(name = "RIVER")
	private String river;

	@Column(name = "BASIN")
	private String basin;

	@Column(name = "BASIN_AREA")
	private BigDecimal basinArea;

	@Column(name = "INSIDE_BASIN_AREA")
	private BigDecimal insideBasinArea;

	@Column(name = "RIVER_LENGTH")
	private BigDecimal riverLength;

	@Column(name = "INSIDE_RIVER_LENGTH")
	private BigDecimal insideRiverLength;

	@Column(name = "AVERAGE_FLOW")
	private BigDecimal averageFlow;

	@Column(name = "SLOPE_RATIO")
	private BigDecimal slopeRatio;

	@Column(name = "BASIN_SHAPE_COEFFICIENT")
	private String basinShapeCoefficient;

	@Column(name = "COUNTY")
	private String county;

	@Column(name = "TYPE")
	private String type;
	@Column(name = "BORDOR_CITY")
	private String bordorCity;

	@Column(name = "LIVESTOCK")
	@Lob
	private String livestock;
	@Column(name = "AFRICULTURE")
	@Lob
	private String africulture;
	@Column(name = "LIVE_SEWAGE")
	@Lob
	private String liveSewage;
	@Column(name = "INDUSTRY_SOURCE")
	@Lob
	private String industrySource;

	public String getIndustrySource() {
		return industrySource;
	}

	public void setIndustrySource(String industrySource) {
		this.industrySource = industrySource;
	}

	@Column(name = "OTHER")
	@Lob
	private String other;

	@Column(name = "UPDATETIME")
	private String updateTime;

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "STATE")
	private int state;

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getLivestock() {
		return livestock;
	}

	public void setLivestock(String livestock) {
		this.livestock = livestock;
	}

	public String getAfriculture() {
		return africulture;
	}

	public void setAfriculture(String africulture) {
		this.africulture = africulture;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "USERID")
	@Lob
	private String userid;

	public String getRiver() {
		return river;
	}

	public String getLines() {
		return lines;
	}

	public void setLines(String lines) {
		this.lines = lines;
	}

	public String getAnalysis() {
		return analysis;
	}

	public void setAnalysis(String analysis) {
		this.analysis = analysis;
	}

	public void setRiver(String river) {
		this.river = river;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
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

	public String getBasin() {
		return basin;
	}

	public void setBasin(String basin) {
		this.basin = basin;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMonitorCode() {
		return monitorCode;
	}

	public void setMonitorCode(String monitorCode) {
		this.monitorCode = monitorCode;
	}

	public String getMonitorName() {
		return monitorName;
	}

	public void setMonitorName(String monitorName) {
		this.monitorName = monitorName;
	}

	public BigDecimal getBasinArea() {
		return basinArea;
	}

	public void setBasinArea(BigDecimal basinArea) {
		this.basinArea = basinArea;
	}

	public BigDecimal getInsideBasinArea() {
		return insideBasinArea;
	}

	public void setInsideBasinArea(BigDecimal insideBasinArea) {
		this.insideBasinArea = insideBasinArea;
	}

	public BigDecimal getRiverLength() {
		return riverLength;
	}

	public void setRiverLength(BigDecimal riverLength) {
		this.riverLength = riverLength;
	}

	public BigDecimal getInsideRiverLength() {
		return insideRiverLength;
	}

	public void setInsideRiverLength(BigDecimal insideRiverLength) {
		this.insideRiverLength = insideRiverLength;
	}

	public BigDecimal getAverageFlow() {
		return averageFlow;
	}

	public void setAverageFlow(BigDecimal averageFlow) {
		this.averageFlow = averageFlow;
	}

	public BigDecimal getSlopeRatio() {
		return slopeRatio;
	}

	public void setSlopeRatio(BigDecimal slopeRatio) {
		this.slopeRatio = slopeRatio;
	}

	public String getBasinShapeCoefficient() {
		return basinShapeCoefficient;
	}

	public void setBasinShapeCoefficient(String basinShapeCoefficient) {
		this.basinShapeCoefficient = basinShapeCoefficient;
	}

	public String getBordorCity() {
		return bordorCity;
	}

	public void setBordorCity(String bordorCity) {
		this.bordorCity = bordorCity;
	}

	public String getLiveSewage() {
		return liveSewage;
	}

	public void setLiveSewage(String liveSewage) {
		this.liveSewage = liveSewage;
	}

}
