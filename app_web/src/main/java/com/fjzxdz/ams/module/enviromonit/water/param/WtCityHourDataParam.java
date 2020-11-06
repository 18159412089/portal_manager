package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityHourData;

import cn.fjzxdz.frame.common.BaseQueryParam;

public class WtCityHourDataParam  extends BaseQueryParam{

	private static final long serialVersionUID = 8876863512335811532L;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	private String startTime;
	
	private String endTime;
	
	private String pointName;
	
	private String pointCode;
	
	private String paramname;

	private Integer type;

	private String regionName;

	private Integer category;

	public Integer getCategory() {
		return category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public WtCityHourDataParam() {
		super(WtCityHourData.class);
		this.clazz = WtCityHourData.class;
	}
	@Override
	protected void createQueryClauses() {
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

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getParamname() {
		return paramname;
	}

	public void setParamname(String paramname) {
		this.paramname = paramname;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
