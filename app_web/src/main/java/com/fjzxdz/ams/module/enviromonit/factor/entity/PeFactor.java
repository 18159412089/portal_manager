/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factor.entity;

import javax.persistence.*;

import com.alibaba.fastjson.JSONObject;

import java.io.Serializable;

/**
 * 污染源自动监控点位采集因子Entity
 * @author htj
 * @date 2019-02-11
 */
@Entity
@Table(name = "PE_FACTOR")
public class PeFactor implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 主键 */
	@Id
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
	/** 点位名称 */
	@Transient
	private String outputName;
	/** 精度 */
	@Column(name = "ACCURACY_")
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

	public String getOutputName() {
		return outputName;
	}

	public void setOutputName(String outputName) {
		this.outputName = outputName;
	}
	
	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("pluEqpId", this.getPluEqpId());
		obj.put("pluCode", this.getPluCode());
		obj.put("pluType", this.getPluType());
		obj.put("upLimit", this.getUpLimit());
		obj.put("lowLimit", this.getLowLimit());
		obj.put("isUsed", this.getIsUsed());
		obj.put("stdValue", this.getStdValue());
		obj.put("unitCode", this.getUnitCode());
		obj.put("pluName", this.getPluName());
		obj.put("outputId", this.getOutputId());
		obj.put("outputName", this.getOutputName());
		obj.put("accuracy", this.getAccuracy());
		obj.put("amplitude", this.getAmplitude());
		obj.put("convert", this.getConvert());
		obj.put("maxValue", this.getMaxValue());
		obj.put("minValue", this.getMinValue());
		obj.put("status", this.getStatus());
		obj.put("testLimit", this.getTestLimit());
		obj.put("deviceId", this.getDeviceId());
		obj.put("stdMinValue", this.getStdMinValue());
		obj.put("stdDayValue", this.getStdDayValue());
		obj.put("stdDayMinValue", this.getStdDayMinValue());
		
		return obj;
	}
}


