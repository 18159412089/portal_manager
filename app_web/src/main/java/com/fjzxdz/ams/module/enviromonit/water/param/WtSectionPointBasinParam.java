/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPointBasin;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水系站点Entity
 * @author ZhangGQ
 * @version 2019-06-25
 */
public class WtSectionPointBasinParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 断面ID */
	private String sectionPointId;
	/** 水系ID */
	private String basinId;
	/** 类型（1面数据，2线数据） */
	private String basinType;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtSectionPointBasinParam() {
		super(WtSectionPointBasin.class);
		this.clazz = WtSectionPointBasin.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("sectionPointId", getSectionPointId(), SearchCondition.LIKE);
		addClause("basinId", getBasinId(), SearchCondition.LIKE);
		addClause("basinType", getBasinType(), SearchCondition.LIKE);
	}
	
	public String getSectionPointId() {
		return sectionPointId;
	}
	
	public void setSectionPointId(String sectionPointId) {
		this.sectionPointId = sectionPointId;
	}
	public String getBasinId() {
		return basinId;
	}
	
	public void setBasinId(String basinId) {
		this.basinId = basinId;
	}
	public String getBasinType() {
		return basinType;
	}
	
	public void setBasinType(String basinType) {
		this.basinType = basinType;
	}
	
}


