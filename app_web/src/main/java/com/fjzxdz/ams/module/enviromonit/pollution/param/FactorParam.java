package com.fjzxdz.ams.module.enviromonit.pollution.param;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class FactorParam extends BaseQueryParam {

	private String code;
	
	private String name;
	
	private String type;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public FactorParam() {
		super(Factor.class);
		this.clazz = Factor.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("code", getCode(), SearchCondition.LIKE);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("type", getType(), SearchCondition.LIKE);
		addNativeClause(" and enable=1");
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}