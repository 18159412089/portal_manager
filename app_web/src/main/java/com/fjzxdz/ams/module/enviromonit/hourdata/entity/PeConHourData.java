/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.hourdata.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 自动监控小时浓度数据Entity
 * @author slq
 * @date 2019-02-11
 */
@Entity
@Table(name = "pe_con_hour_data")
public class PeConHourData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 企业ID */
	@Id
	private String peId;
	/** 点位ID */
	private String outputId;
	/** 监测时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date measureTime;
	/** 因子代码 */
	private String pluCode;
	/** 浓度最小值 */
	private String chromaMin;
	/** 浓度均值 */
	private String chromaAvg;
	/** 浓度最大值 */
	private String chromaMax;
	/** 排放量 */
	private String outputAvg;
	/** 点位类型 */
	private String outfallType;
	/** 是否监测 */
	private String isMeasure;
	/** 数据条数 */
	private String dataCount;
	/** 人工认定 */
	private String personalIdentification;
	/** 备注 */
	private String remark;
	/** 报表类型 */
	private String reportType;
	/** 更新时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date updateTime;
	
	public String getPeId() {
		return peId;
	}

	public void setPeId(String peId) {
		this.peId = peId;
	}
	public String getOutputId() {
		return outputId;
	}

	public void setOutputId(String outputId) {
		this.outputId = outputId;
	}
	public java.util.Date getMeasureTime() {
		return measureTime;
	}

	public void setMeasureTime(java.util.Date measureTime) {
		this.measureTime = measureTime;
	}
	public String getPluCode() {
		return pluCode;
	}

	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}
	public String getChromaMin() {
		return chromaMin;
	}

	public void setChromaMin(String chromaMin) {
		this.chromaMin = chromaMin;
	}
	public String getChromaAvg() {
		return chromaAvg;
	}

	public void setChromaAvg(String chromaAvg) {
		this.chromaAvg = chromaAvg;
	}
	public String getChromaMax() {
		return chromaMax;
	}

	public void setChromaMax(String chromaMax) {
		this.chromaMax = chromaMax;
	}
	public String getOutputAvg() {
		return outputAvg;
	}

	public void setOutputAvg(String outputAvg) {
		this.outputAvg = outputAvg;
	}
	public String getOutfallType() {
		return outfallType;
	}

	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}
	public String getIsMeasure() {
		return isMeasure;
	}

	public void setIsMeasure(String isMeasure) {
		this.isMeasure = isMeasure;
	}
	public String getDataCount() {
		return dataCount;
	}

	public void setDataCount(String dataCount) {
		this.dataCount = dataCount;
	}
	public String getPersonalIdentification() {
		return personalIdentification;
	}

	public void setPersonalIdentification(String personalIdentification) {
		this.personalIdentification = personalIdentification;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	public java.util.Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}
	
}


