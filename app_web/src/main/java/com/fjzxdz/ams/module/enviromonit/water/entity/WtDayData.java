package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="WT_DAY_DATA")
public class WtDayData implements Serializable{

	private static final long serialVersionUID = 8611492090944413294L;

	@Id
	private String pkid;

	@Column(name="CODE_POLLUTE")
	private String codePollute;

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

	public WtDayData() {
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
	
}
