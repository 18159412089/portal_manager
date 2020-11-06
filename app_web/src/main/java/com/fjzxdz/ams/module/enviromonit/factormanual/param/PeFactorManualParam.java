/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factormanual.param;

import com.fjzxdz.ams.module.enviromonit.factormanual.entity.PeFactorManual;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 污染源手动监控点位采集因子Entity
 * @author htj
 * @version 2019-09-11
 */
public class PeFactorManualParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 主键ID */
	private Long pluEqpId;
	/** 因子代码 */
	private String pluCode;
	/** 水气类型 */
	private Long pluType;
	/** 量程上限 */
	private Double upLimit;
	/** 量程下限 */
	private Double lowLimit;
	/** 是否启用 */
	private String isUsed;
	/** 标准值上限 */
	private Double stdValue;
	/** 单位 */
	private String unitCode;
	/** 因子名称 */
	private String pluName;
	/** 点位ID */
	private Long outputId;
	/** 精度 */
	private Integer accuracy;
	/** 振幅 */
	private Double amplitude;
	/** 折算浓度 */
	private String convert;
	/** 极大值 */
	private Double maxValue;
	/** 极小值 */
	private Double minValue;
	/** 删除状态 */
	private String status;
	/** 考核限值 */
	private Double testLimit;
	/** 设备ID */
	private Long deviceId;
	/** 标准值下限 */
	private Double stdMinValue;
	/** 日标准值上限 */
	private Double stdDayValue;
	/** 日标准值下限 */
	private Double stdDayMinValue;
	/** 单位名称 */
	private String unitName;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public PeFactorManualParam() {
		super(PeFactorManual.class);
		this.clazz = PeFactorManual.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("pluEqpId", getPluEqpId(), SearchCondition.LIKE);
		addClause("pluCode", getPluCode(), SearchCondition.LIKE);
		addClause("pluType", getPluType(), SearchCondition.LIKE);
		addClause("upLimit", getUpLimit(), SearchCondition.LIKE);
		addClause("lowLimit", getLowLimit(), SearchCondition.LIKE);
		addClause("isUsed", getIsUsed(), SearchCondition.LIKE);
		addClause("stdValue", getStdValue(), SearchCondition.LIKE);
		addClause("unitCode", getUnitCode(), SearchCondition.LIKE);
		addClause("pluName", getPluName(), SearchCondition.LIKE);
		addClause("outputId", getOutputId(), SearchCondition.LIKE);
		addClause("accuracy", getAccuracy(), SearchCondition.LIKE);
		addClause("amplitude", getAmplitude(), SearchCondition.LIKE);
		addClause("convert", getConvert(), SearchCondition.LIKE);
		addClause("maxValue", getMaxValue(), SearchCondition.LIKE);
		addClause("minValue", getMinValue(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.LIKE);
		addClause("testLimit", getTestLimit(), SearchCondition.LIKE);
		addClause("deviceId", getDeviceId(), SearchCondition.LIKE);
		addClause("stdMinValue", getStdMinValue(), SearchCondition.LIKE);
		addClause("stdDayValue", getStdDayValue(), SearchCondition.LIKE);
		addClause("stdDayMinValue", getStdDayMinValue(), SearchCondition.LIKE);
		addClause("unitName", getUnitName(), SearchCondition.LIKE);
	}
	
	public Long getPluEqpId() {
		return pluEqpId;
	}
	
	public void setPluEqpId(Long pluEqpId) {
		this.pluEqpId = pluEqpId;
	}
	public String getPluCode() {
		return pluCode;
	}
	
	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}
	public Long getPluType() {
		return pluType;
	}
	
	public void setPluType(Long pluType) {
		this.pluType = pluType;
	}
	public Double getUpLimit() {
		return upLimit;
	}
	
	public void setUpLimit(Double upLimit) {
		this.upLimit = upLimit;
	}
	public Double getLowLimit() {
		return lowLimit;
	}
	
	public void setLowLimit(Double lowLimit) {
		this.lowLimit = lowLimit;
	}
	public String getIsUsed() {
		return isUsed;
	}
	
	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	public Double getStdValue() {
		return stdValue;
	}
	
	public void setStdValue(Double stdValue) {
		this.stdValue = stdValue;
	}
	public String getUnitCode() {
		return unitCode;
	}
	
	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}
	public String getPluName() {
		return pluName;
	}
	
	public void setPluName(String pluName) {
		this.pluName = pluName;
	}
	public Long getOutputId() {
		return outputId;
	}
	
	public void setOutputId(Long outputId) {
		this.outputId = outputId;
	}
	public Integer getAccuracy() {
		return accuracy;
	}
	
	public void setAccuracy(Integer accuracy) {
		this.accuracy = accuracy;
	}
	public Double getAmplitude() {
		return amplitude;
	}
	
	public void setAmplitude(Double amplitude) {
		this.amplitude = amplitude;
	}
	public String getConvert() {
		return convert;
	}
	
	public void setConvert(String convert) {
		this.convert = convert;
	}
	public Double getMaxValue() {
		return maxValue;
	}
	
	public void setMaxValue(Double maxValue) {
		this.maxValue = maxValue;
	}
	public Double getMinValue() {
		return minValue;
	}
	
	public void setMinValue(Double minValue) {
		this.minValue = minValue;
	}
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	public Double getTestLimit() {
		return testLimit;
	}
	
	public void setTestLimit(Double testLimit) {
		this.testLimit = testLimit;
	}
	public Long getDeviceId() {
		return deviceId;
	}
	
	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}
	public Double getStdMinValue() {
		return stdMinValue;
	}
	
	public void setStdMinValue(Double stdMinValue) {
		this.stdMinValue = stdMinValue;
	}
	public Double getStdDayValue() {
		return stdDayValue;
	}
	
	public void setStdDayValue(Double stdDayValue) {
		this.stdDayValue = stdDayValue;
	}
	public Double getStdDayMinValue() {
		return stdDayMinValue;
	}
	
	public void setStdDayMinValue(Double stdDayMinValue) {
		this.stdDayMinValue = stdDayMinValue;
	}
	public String getUnitName() {
		return unitName;
	}
	
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	
}


