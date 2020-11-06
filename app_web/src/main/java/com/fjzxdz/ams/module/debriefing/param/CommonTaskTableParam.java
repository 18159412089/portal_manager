package com.fjzxdz.ams.module.debriefing.param;

import java.math.BigDecimal;

import com.fjzxdz.ams.module.debriefing.entity.CommonTaskTable;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class CommonTaskTableParam extends BaseQueryParam {

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	private BigDecimal status;

	private String startTime;

	private String endTime;
	
	private String queryTime;

	public CommonTaskTableParam() {
		super(CommonTaskTable.class);
		this.clazz = CommonTaskTable.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("create_date", getStartTime(), SearchCondition.GE);
		addClause("create_date", getEndTime(), SearchCondition.LE);
		setOrderBy(" create_date desc");
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public String getStartTime() {
		return "TO_DATE('"+startTime+"','yyyy-mm-dd')";
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return "TO_DATE('"+endTime+"','yyyy-mm-dd')";
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getQueryTime() {
		return queryTime;
	}

	public void setQueryTime(String queryTime) {
		this.queryTime = queryTime;
	}

	
}