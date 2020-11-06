package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtPolicy;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class WtPolicyParam extends BaseQueryParam{

	private static final long serialVersionUID = -1592027072795838675L;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	private String name;
	
	public WtPolicyParam() {
		super(WtPolicy.class);
		this.clazz = WtPolicy.class;
	}
	@Override
	protected void createQueryClauses() {
		addClause("name",getName(), SearchCondition.LIKE);
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
	

}
