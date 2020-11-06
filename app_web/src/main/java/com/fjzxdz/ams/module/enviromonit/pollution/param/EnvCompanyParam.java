package com.fjzxdz.ams.module.enviromonit.pollution.param;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class EnvCompanyParam extends BaseQueryParam {

	private String name;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public EnvCompanyParam() {
		super(EnvCompany.class);
		this.clazz = EnvCompany.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("name", getName(), SearchCondition.LIKE);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}