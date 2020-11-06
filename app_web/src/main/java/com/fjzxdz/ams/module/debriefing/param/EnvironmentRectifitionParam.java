package com.fjzxdz.ams.module.debriefing.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@SuppressWarnings("serial")
public class EnvironmentRectifitionParam extends BaseQueryParam {

	private String name;

	private String timelimitStr;

	private Date timelimit;

	private String status;

	private String dutyDepartment;

	private String areaCode;

	private String cityCode;
	private String mark;
	private BigDecimal num;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public EnvironmentRectifitionParam() {
		super(EnvironmentRectifition.class);
		this.clazz = EnvironmentRectifition.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("project.name", getName(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("timelimit", getTimelimit(), SearchCondition.EQ);
		addClause("dutyDepartment", getDutyDepartment(), SearchCondition.LIKE);
		addClause("areaCode", getAreaCode(), SearchCondition.LIKE);
		addClause("cityCode", getCityCode(), SearchCondition.LIKE);
		addClause("mark", getMark(), SearchCondition.EQ);
		addClause("num", getNum(), SearchCondition.EQ);
		setOrderBy(" project.createDate desc");
	}

	public String getMark() {
		return mark;
	}

	public BigDecimal getNum() {
		return num;
	}

	public void setNum(BigDecimal num) {
		this.num = num;
	}

	public void setMark(String mark) {
		this.mark = mark;
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

	public String getLimitStr() {
		return timelimitStr;
	}
	
	public void setLimitStr(String timelimitStr) throws ParseException {
		this.timelimitStr = timelimitStr;
		if(ToolUtil.isNotEmpty(timelimitStr)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			setTimelimit(sdf.parse(timelimitStr));
		}
	}

	public Date getTimelimit() {
		return timelimit;
	}
	
	public void setTimelimit(Date timelimit) {
		this.timelimit = timelimit;
	}

	public String getDutyDepartment() {
		return dutyDepartment;
	}

	public void setDutyDepartment(String dutyDepartment) {
		this.dutyDepartment = dutyDepartment;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
}