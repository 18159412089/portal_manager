/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinPlaneLData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水系线数据Entity
 * @author ZhangGQ
 * @version 2019-06-28
 */
public class WtBasinPlaneLDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 主键 */
	private String id;
	/** 线数据 */
	private String geom;
	/** 河流名称 */
	private String name;
	/** 0代表不是水库，1是水库 */
	private String status;
	/** 水质的分级 */
	private String grade;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtBasinPlaneLDataParam() {
		super(WtBasinPlaneLData.class);
		this.clazz = WtBasinPlaneLData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("id", getId(), SearchCondition.LIKE);
		addClause("geom", getGeom(), SearchCondition.LIKE);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.LIKE);
		addClause("grade", getGrade(), SearchCondition.LIKE);
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	public String getGeom() {
		return geom;
	}
	
	public void setGeom(String geom) {
		this.geom = geom;
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
	public String getGrade() {
		return grade;
	}
	
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
}


