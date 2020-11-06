package com.fjzxdz.ams.module.enviromonit.water.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtHourData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;

public class WtSectionMonthDataParam extends BaseQueryParam{

	private static final long serialVersionUID = -3635023564969557492L;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	private String monitorTime;

	private String pointCode;

	private String pointName;

	private String polluteName;

	private String startTime;

	private String endTime;

	private String pollutes;

	public WtSectionMonthDataParam() {
		super(WtSectionMonthData.class);
		this.clazz = WtSectionMonthData.class;
	}
	@Override
	protected void createQueryClauses() {
		addClause("monitorTime",getMonitorTime(), SearchCondition.LIKE);
		addClause("pointCode",getPointCode(), SearchCondition.LIKE);
		addClause("pointName",getPointName(), SearchCondition.LIKE);
		addClause("polluteName",getPolluteName(), SearchCondition.LIKE);
	}
	
	public String getMonitorTime() {
		return monitorTime;
	}

	public void setMonitorTime(String monitorTime) {
		this.monitorTime = monitorTime;
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
