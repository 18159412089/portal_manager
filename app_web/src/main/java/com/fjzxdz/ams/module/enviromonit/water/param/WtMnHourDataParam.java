package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtMnHourData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class WtMnHourDataParam extends BaseQueryParam{

	private static final long serialVersionUID = -3635023564969557492L;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	
	private String mm;
	private String startTime;
	private String endTime;
	private String paramnames;
	
	public WtMnHourDataParam() {
		super(WtMnHourData.class);
		this.clazz = WtMnHourData.class;
	}
	@Override
	protected void createQueryClauses() {
		addClause("pointCode",getMm(), SearchCondition.LIKE);
	}

	public String getMm() {
		return mm;
	}

	public void setMm(String mm) {
		this.mm = mm;
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

	public String getParamnames() {
		return paramnames;
	}

	public void setParamnames(String paramnames) {
		this.paramnames = paramnames;
	}
	
}
