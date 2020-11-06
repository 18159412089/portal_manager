package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="WT_HOUR_DATA")
public class WtHourData implements Serializable{

	private static final long serialVersionUID = 2901313657073218029L;
	
	@Id
	private String pkid;

	@Column(name="CODE_POLLUTE")
	private String codePollute;

	@Column(name="IS_STANDARDS")
	private String isStandards;

	@Column(name="MONITOR_TIME")
	private String monitorTime;

//	@JsonIgnore
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name="POINT_CODE")
	@Column(name="POINT_CODE")
	private String pointCode;

	@Column(name="POINT_NAME")
	private String pointName;

	@Column(name="POLLUTE_NAME")
	private String polluteName;

	@Column(name="POLLUTE_VALUE")
	private BigDecimal polluteValue;

	@Column(name="STANDARD_VALUE_MAX")
	private String standardValueMax;

	@Column(name="STANDARD_VALUE_MIN")
	private String standardValueMin;

	@Column(name="VALUE_UNIT")
	private String valueUnit;

	public WtHourData() {
	}

	public String getPkid() {
		return pkid;
	}

	public void setPkid(String pkid) {
		this.pkid = pkid;
	}

	public String getCodePollute() {
		return codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public String getIsStandards() {
		return isStandards;
	}

	public void setIsStandards(String isStandards) {
		this.isStandards = isStandards;
	}

	public String getMonitorTime() {
		return monitorTime;
	}

	public void setMonitorTime(String monitorTime) {
		this.monitorTime = monitorTime;
	}

	public String getPointCode() {
		return pointCode;
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

	public String getPolluteName() {
		return polluteName;
	}

	public void setPolluteName(String polluteName) {
		this.polluteName = polluteName;
	}

	public BigDecimal getPolluteValue() {
		return polluteValue;
	}

	public void setPolluteValue(BigDecimal polluteValue) {
		this.polluteValue = polluteValue;
	}

	public String getStandardValueMax() {
		return standardValueMax;
	}

	public void setStandardValueMax(String standardValueMax) {
		this.standardValueMax = standardValueMax;
	}

	public String getStandardValueMin() {
		return standardValueMin;
	}

	public void setStandardValueMin(String standardValueMin) {
		this.standardValueMin = standardValueMin;
	}

	public String getValueUnit() {
		return valueUnit;
	}

	public void setValueUnit(String valueUnit) {
		this.valueUnit = valueUnit;
	}
	
}
