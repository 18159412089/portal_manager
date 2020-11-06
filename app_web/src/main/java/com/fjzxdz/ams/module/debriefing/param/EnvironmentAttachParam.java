package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class EnvironmentAttachParam extends BaseQueryParam {

	private String loginname;

	private String name;

	private String phone;

	private Integer sex;

	private Integer enable;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public EnvironmentAttachParam() {
		super(EnvironmentAttach.class);
		this.clazz = EnvironmentAttach.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("loginname", getLoginname(), SearchCondition.EQ);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("phone", getPhone(), SearchCondition.EQ);
		addClause("sex", getSex(), SearchCondition.EQ);
		addClause("enable", getEnable(), SearchCondition.EQ);
		setOrderBy(" create_date desc");
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getEnable() {
		return enable;
	}

	public void setEnable(Integer enable) {
		this.enable = enable;
	}

}