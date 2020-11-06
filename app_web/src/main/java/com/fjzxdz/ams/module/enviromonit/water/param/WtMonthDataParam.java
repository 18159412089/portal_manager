package com.fjzxdz.ams.module.enviromonit.water.param;

import java.math.BigDecimal;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtMonthData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class WtMonthDataParam extends BaseQueryParam{

	private static final long serialVersionUID = 7455363615156445239L;
	
	private BigDecimal monthNumber;
	private BigDecimal yearNumber;
	private String pointCode;
	private String pointName;
	private String polluteName;
	private String startTime;
	private String endTime;
	private String pollutes;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public WtMonthDataParam() {
		super(WtMonthData.class);
		this.clazz = WtMonthData.class;
	}
	@Override
	protected void createQueryClauses() {
		addClause("monthNumber",getMonthNumber(), SearchCondition.EQ);
		addClause("yearNumber",getYearNumber(), SearchCondition.EQ);
		addClause("pointCode",getPointCode(), SearchCondition.LIKE);
		addClause("pointName",getPointName(), SearchCondition.LIKE);
		addClause("polluteName",getPolluteName(), SearchCondition.LIKE);
	}

	public BigDecimal getMonthNumber() {
		return monthNumber;
	}

	public void setMonthNumber(BigDecimal monthNumber) {
		this.monthNumber = monthNumber;
	}

	public BigDecimal getYearNumber() {
		return yearNumber;
	}

	public void setYearNumber(BigDecimal yearNumber) {
		this.yearNumber = yearNumber;
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

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getPollutes() {
		return pollutes;
	}

	public void setPollutes(String pollutes) {
		this.pollutes = pollutes;
	}
	
}
