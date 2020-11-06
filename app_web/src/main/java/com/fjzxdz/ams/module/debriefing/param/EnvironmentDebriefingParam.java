package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefing;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class EnvironmentDebriefingParam extends BaseQueryParam {

	private String name;

	private String status;

	private String enable;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public EnvironmentDebriefingParam() {
		super(EnvironmentDebriefing.class);
		this.clazz = EnvironmentDebriefing.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("enable", getEnable(), SearchCondition.EQ);
		setOrderBy(" update_date desc");
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}

	public String getEnable() {
		return enable;
	}

	public void setEnable(String enable) {
		this.enable = enable;
	}

}