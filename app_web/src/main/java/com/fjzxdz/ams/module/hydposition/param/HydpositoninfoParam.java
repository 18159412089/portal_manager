/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.param;

import com.fjzxdz.ams.module.hydposition.entity.Hydpositoninfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水电站点位基本信息Entity
 * @author htj
 * @version 2019-02-18
 */
public class HydpositoninfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 是否正在使用 */
	private String isUsed;
	/** 点位ID */
	private Integer eqpId;
	/** 设备ID */
	private Integer hydropowerId;
	/** 点位名称 */
	private String eqpName;
	/** 更新频率 */
	private Long CYC;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public HydpositoninfoParam() {
		super(Hydpositoninfo.class);
		this.clazz = Hydpositoninfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("isUsed", getIsUsed(), SearchCondition.LIKE);
		addClause("eqpId", getEqpId(), SearchCondition.LIKE);
		addClause("hydropowerId", getHydropowerId(), SearchCondition.LIKE);
		addClause("eqpName", getEqpName(), SearchCondition.LIKE);
		addClause("CYC", getCYC(), SearchCondition.LIKE);
	}
	
	public String getIsUsed() {
		return isUsed;
	}
	
	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	public Integer getEqpId() {
		return eqpId;
	}
	
	public void setEqpId(Integer eqpId) {
		this.eqpId = eqpId;
	}
	public Integer getHydropowerId() {
		return hydropowerId;
	}
	
	public void setHydropowerId(Integer hydropowerId) {
		this.hydropowerId = hydropowerId;
	}
	public String getEqpName() {
		return eqpName;
	}
	
	public void setEqpName(String eqpName) {
		this.eqpName = eqpName;
	}
	public Long getCYC() {
		return CYC;
	}
	
	public void setCYC(Long cYC) {
		this.CYC = cYC;
	}
	
}


