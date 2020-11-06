package com.fjzxdz.ams.module.enviromonit.pollution.param;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class PointParam extends BaseQueryParam {

	private String code;
	
	private String name;

	private String region;
	
	private String mn_code;
	
	private String type;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public PointParam() {
		super(Point.class);
		this.clazz = Point.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("code", getCode(), SearchCondition.LIKE);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("region", getRegion(), SearchCondition.LIKE);
		addClause("mn_code", getMnCode(), SearchCondition.LIKE);
		addClause("type", getType(), SearchCondition.LIKE);
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

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getMnCode() {
		return mn_code;
	}

	public void setMnCode(String mn_code) {
		this.mn_code = mn_code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}