/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factor.param;

import com.fjzxdz.ams.module.enviromonit.factor.entity.PeFactor;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 污染源自动监控点位采集因子Entity
 * @author htj
 * @date 2019-02-11
 */
public class PeFactorParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 主键 */
	private String pluEqpId;
	/** 因子代码 */
	private String pluCode;
	/** 水气类型 */
	private String pluType;
	/** 量程上限 */
	private String upLimit;
	/** 量程下限 */
	private String lowLimit;
	/** 是否启用 */
	private String isUsed;
	/** 标准值上限 */
	private String stdValue;
	/** 单位 */
	private String unitCode;
	/** 因子名称 */
	private String pluName;
	/** 点位ID */
	private String outputId;
	/** 精度 */
	private String accuracy;
	/** 振幅 */
	private String amplitude;
	/** 折算浓度 */
	private String convert;
	/** 极大值 */
	private String maxValue;
	/** 极小值 */
	private String minValue;
	/** 删除状态 */
	private String status;
	/** 考核限值 */
	private String testLimit;
	/** 设备ID */
	private String deviceId;
	/** 标准值下限 */
	private String stdMinValue;
	/** 日标准值上限 */
	private String stdDayValue;
	/** 日标准值下限 */
	private String stdDayMinValue;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public PeFactorParam() {
		super(PeFactor.class);
		this.clazz = PeFactor.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("pluEqpId", getPluEqpId(), SearchCondition.EQ);
		addClause("pluCode", getPluCode(), SearchCondition.EQ);
		addClause("pluType", getPluType(), SearchCondition.EQ);
		addClause("upLimit", getUpLimit(), SearchCondition.EQ);
		addClause("lowLimit", getLowLimit(), SearchCondition.EQ);
		addClause("isUsed", getIsUsed(), SearchCondition.EQ);
		addClause("stdValue", getStdValue(), SearchCondition.EQ);
		addClause("unitCode", getUnitCode(), SearchCondition.EQ);
		addClause("pluName", getPluName(), SearchCondition.EQ);
		addClause("outputId", getOutputId(), SearchCondition.EQ);
		addClause("accuracy", getAccuracy(), SearchCondition.EQ);
		addClause("amplitude", getAmplitude(), SearchCondition.EQ);
		addClause("convert", getConvert(), SearchCondition.EQ);
		addClause("maxValue", getMaxValue(), SearchCondition.EQ);
		addClause("minValue", getMinValue(), SearchCondition.EQ);
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("testLimit", getTestLimit(), SearchCondition.EQ);
		addClause("deviceId", getDeviceId(), SearchCondition.EQ);
		addClause("stdMinValue", getStdMinValue(), SearchCondition.EQ);
		addClause("stdDayValue", getStdDayValue(), SearchCondition.EQ);
		addClause("stdDayMinValue", getStdDayMinValue(), SearchCondition.EQ);
		setOrderBy(" create_date desc");
	}
	
	public String getPluEqpId() {
		return pluEqpId;
	}
	
	public void setPluEqpId(String pluEqpId) {
		this.pluEqpId = pluEqpId;
	}
	public String getPluCode() {
		return pluCode;
	}
	
	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}
	public String getPluType() {
		return pluType;
	}
	
	public void setPluType(String pluType) {
		this.pluType = pluType;
	}
	public String getUpLimit() {
		return upLimit;
	}
	
	public void setUpLimit(String upLimit) {
		this.upLimit = upLimit;
	}
	public String getLowLimit() {
		return lowLimit;
	}
	
	public void setLowLimit(String lowLimit) {
		this.lowLimit = lowLimit;
	}
	public String getIsUsed() {
		return isUsed;
	}
	
	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	public String getStdValue() {
		return stdValue;
	}
	
	public void setStdValue(String stdValue) {
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
	public String getOutputId() {
		return outputId;
	}
	
	public void setOutputId(String outputId) {
		this.outputId = outputId;
	}
	public String getAccuracy() {
		return accuracy;
	}
	
	public void setAccuracy(String accuracy) {
		this.accuracy = accuracy;
	}
	public String getAmplitude() {
		return amplitude;
	}
	
	public void setAmplitude(String amplitude) {
		this.amplitude = amplitude;
	}
	public String getConvert() {
		return convert;
	}
	
	public void setConvert(String convert) {
		this.convert = convert;
	}
	public String getMaxValue() {
		return maxValue;
	}
	
	public void setMaxValue(String maxValue) {
		this.maxValue = maxValue;
	}
	public String getMinValue() {
		return minValue;
	}
	
	public void setMinValue(String minValue) {
		this.minValue = minValue;
	}
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTestLimit() {
		return testLimit;
	}
	
	public void setTestLimit(String testLimit) {
		this.testLimit = testLimit;
	}
	public String getDeviceId() {
		return deviceId;
	}
	
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getStdMinValue() {
		return stdMinValue;
	}
	
	public void setStdMinValue(String stdMinValue) {
		this.stdMinValue = stdMinValue;
	}
	public String getStdDayValue() {
		return stdDayValue;
	}
	
	public void setStdDayValue(String stdDayValue) {
		this.stdDayValue = stdDayValue;
	}
	public String getStdDayMinValue() {
		return stdDayMinValue;
	}
	
	public void setStdDayMinValue(String stdDayMinValue) {
		this.stdDayMinValue = stdDayMinValue;
	}
	
}


