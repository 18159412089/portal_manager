/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.param;

import com.fjzxdz.ams.module.hydposition.entity.Hydddraindaydata;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水电站下泄流量日统计数据Entity
 * @author htj
 * @version 2019-02-18
 */
public class HydddraindaydataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 当日最大下泄流量(立方米/秒) */
	private Double maxValue;
	/** 出口ID */
	private Integer output_Id;
	/** 监测时间 */
	private java.util.Date measureTime;
	/** 日均下泄流量(立方米/秒) */
	private Double avgValue;
	/** 当日最小下泄流量(立方米/秒) */
	private Double minValue;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public HydddraindaydataParam() {
		super(Hydddraindaydata.class);
		this.clazz = Hydddraindaydata.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("maxValue", getMaxValue(), SearchCondition.LIKE);
		addClause("output_Id", getOutputId(), SearchCondition.EQ);
		addClause("measureTime", getMeasureTime(), SearchCondition.LIKE);
		addClause("avgValue", getAvgValue(), SearchCondition.LIKE);
		addClause("minValue", getMinValue(), SearchCondition.LIKE);
		setOrderBy(" MEASURE_TIME desc");
	}
	
	public Double getMaxValue() {
		return maxValue;
	}
	
	public void setMaxValue(Double maxValue) {
		this.maxValue = maxValue;
	}
	public Integer getOutputId() {
		return output_Id;
	}
	
	public void setOutputId(Integer outid) {
		this.output_Id = outid;
	}
	public java.util.Date getMeasureTime() {
		return measureTime;
	}
	
	public void setMeasureTime(java.util.Date measureTime) {
		this.measureTime = measureTime;
	}
	public Double getAvgValue() {
		return avgValue;
	}
	
	public void setAvgValue(Double avgValue) {
		this.avgValue = avgValue;
	}
	public Double getMinValue() {
		return minValue;
	}
	
	public void setMinValue(Double minValue) {
		this.minValue = minValue;
	}
	
}


