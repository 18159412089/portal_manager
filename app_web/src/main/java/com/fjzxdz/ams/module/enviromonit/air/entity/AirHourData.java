package com.fjzxdz.ams.module.enviromonit.air.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


import com.fasterxml.jackson.annotation.JsonIgnore;
/**
 * 
 * 空气小时数据实体 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:58:49
 */
@Entity
@Table(name = "AIR_HOUR_DATA")
public class AirHourData implements Serializable {

	private static final long serialVersionUID = -2783724562198035279L;
	@Id
	private String pkid;
	
	private BigDecimal aqi;

	private BigDecimal avervalue;

	@Column(name="AVERVALUE_STRING")
	private String avervalueString;
	
	@Column(name="CODE_POLLUTE")
	private String codePollute;

	@Column(name="CODE_REGION")
	private String codeRegion;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="MONITOR_TIME")
	private Date monitorTime;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "POINT_CODE")
	private AirMonitorPoint pointCode;

	@Column(name="POINT_NAME")
	private String pointName;

	@Column(name="POLLUTE_NAME")
	private String polluteName;

	@Column(name="REGION_NAME")
	private String regionName;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="UPDATE_TIME")
	private Date updateTime;
	
	public AirHourData() {
	}

	public String getPkid() {
		return pkid;
	}

	public void setPkid(String pkid) {
		this.pkid = pkid;
	}

	public BigDecimal getAqi() {
		return aqi;
	}

	public void setAqi(BigDecimal aqi) {
		this.aqi = aqi;
	}

	public BigDecimal getAvervalue() {
		return avervalue;
	}

	public void setAvervalue(BigDecimal avervalue) {
		this.avervalue = avervalue;
	}

	public String getAvervalueString() {
		return avervalueString;
	}

	public void setAvervalueString(String avervalueString) {
		this.avervalueString = avervalueString;
	}

	public String getCodePollute() {
		return codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}

	public Date getMonitorTime() {
		return monitorTime;
	}

	public void setMonitorTime(Date monitorTime) {
		this.monitorTime = monitorTime;
	}

	public AirMonitorPoint getPointCode() {
		return pointCode;
	}

	public void setPointCode(AirMonitorPoint pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPolluteName() {
		return polluteName;
	}

	public void setPolluteName(String polluteName) {
		this.polluteName = polluteName;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}
