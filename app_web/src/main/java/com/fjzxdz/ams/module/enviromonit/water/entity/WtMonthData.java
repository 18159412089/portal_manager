package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="WT_MONTH_DATA")
public class WtMonthData implements Serializable{

	private static final long serialVersionUID = -5867258294713615197L;
	
	@Id
	private String pkid;

	@Column(name="CODE_POLLUTE")
	private String codePollute;

	@Column(name="MONTH_NUMBER")
	private BigDecimal monthNumber;

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

	@Column(name="YEAR_NUMBER")
	private BigDecimal yearNumber;

	public WtMonthData() {
	}

	public String getPkid() {
		return this.pkid;
	}

	public void setPkid(String pkid) {
		this.pkid = pkid;
	}

	public String getCodePollute() {
		return this.codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public BigDecimal getMonthNumber() {
		return this.monthNumber;
	}

	public void setMonthNumber(BigDecimal monthNumber) {
		this.monthNumber = monthNumber;
	}

	public String getPointCode() {
		return this.pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return this.pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPolluteName() {
		return this.polluteName;
	}

	public void setPolluteName(String polluteName) {
		this.polluteName = polluteName;
	}

	public BigDecimal getPolluteValue() {
		return this.polluteValue;
	}

	public void setPolluteValue(BigDecimal polluteValue) {
		this.polluteValue = polluteValue;
	}

	public BigDecimal getYearNumber() {
		return this.yearNumber;
	}

	public void setYearNumber(BigDecimal yearNumber) {
		this.yearNumber = yearNumber;
	}

}
