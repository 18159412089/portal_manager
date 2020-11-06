/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.param;

import com.fjzxdz.ams.module.hydposition.entity.Hyddevexitdata;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * HYD_DRAIN_DAY_DATAEntity
 * @author htj
 * @version 2019-02-20
 */
public class HyddevexitdataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 环评要求最小下泄流量(立方米/秒) */
	private Double minFlow;
	/** 点位ID */
	private Integer eqpId;
	/** 出口ID */
	private Long outputId;
	/** 设备ID */
	private Integer hydropowerId;
	/** 状态 */
	private String status;
	/** 出口名称 */
	private String outputName;
	/** 出口编码 */
	private String outputCode;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public HyddevexitdataParam() {
		super(Hyddevexitdata.class);
		this.clazz = Hyddevexitdata.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("minFlow", getMinFlow(), SearchCondition.LIKE);
		addClause("eqpId", getEqpId(), SearchCondition.LIKE);
		addClause("outputId", getOutputId(), SearchCondition.LIKE);
		addClause("hydropowerId", getHydropowerId(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.LIKE);
		addClause("outputName", getOutputName(), SearchCondition.LIKE);
		addClause("outputCode", getOutputCode(), SearchCondition.LIKE);
	}
	
	public Double getMinFlow() {
		return minFlow;
	}
	
	public void setMinFlow(Double minFlow) {
		this.minFlow = minFlow;
	}
	public Integer getEqpId() {
		return eqpId;
	}
	
	public void setEqpId(Integer eqpId) {
		this.eqpId = eqpId;
	}
	public Long getOutputId() {
		return outputId;
	}
	
	public void setOutputId(Long outputId) {
		this.outputId = outputId;
	}
	public Integer getHydropowerId() {
		return hydropowerId;
	}
	
	public void setHydropowerId(Integer hydropowerId) {
		this.hydropowerId = hydropowerId;
	}
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOutputName() {
		return outputName;
	}
	
	public void setOutputName(String outputName) {
		this.outputName = outputName;
	}
	public String getOutputCode() {
		return outputCode;
	}
	
	public void setOutputCode(String outputCode) {
		this.outputCode = outputCode;
	}
	
}


