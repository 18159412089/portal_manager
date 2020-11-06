package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefDetails;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class EnvironmentDebriefDetailsParam extends BaseQueryParam {

	private String debriefing;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public EnvironmentDebriefDetailsParam() {
		super(EnvironmentDebriefDetails.class);
		this.clazz = EnvironmentDebriefDetails.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("debriefing", getDebriefing(), SearchCondition.EQ);
		setOrderBy(" create_Date desc");
	}

	public String getDebriefing() {
		return debriefing;
	}

	public void setDebriefing(String debriefing) {
		this.debriefing = debriefing;
	}
	
	

}