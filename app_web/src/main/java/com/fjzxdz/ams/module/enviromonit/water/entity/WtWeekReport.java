package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import javax.persistence.*;

import com.fjzxdz.ams.module.enums.WaterQualityEnum;

import java.math.BigDecimal;

@Entity
@Table(name = "WT_WEEK_REPORT")
public class WtWeekReport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String uuid;

	@Lob
	private String excessfactorstr;

	@Column(name = "POINT_CODE")
	private String pointCode;

	@Column(name = "POINT_NAME")
	private String pointName;

	@Column(name = "RESULT_QUALITY")
	@Enumerated(EnumType.STRING)
	private WaterQualityEnum resultQuality;

	@Column(name = "TARGET_QUALITY")
	@Enumerated(EnumType.STRING)
	private WaterQualityEnum targetQuality;

	@Column(name = "WEEK_NUMBER")
	private BigDecimal weekNumber;

	@Column(name = "YEAR_NUMBER")
	private BigDecimal yearNumber;

	public WtWeekReport() {
	}

	public String getUuid() {
		return this.uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getExcessfactorstr() {
		return this.excessfactorstr;
	}

	public void setExcessfactorstr(String excessfactorstr) {
		this.excessfactorstr = excessfactorstr;
	}

	public String getPointCode() {
		return this.pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return this.pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public WaterQualityEnum getResultQuality() {
		return this.resultQuality;
	}

	public void setResultQuality(WaterQualityEnum resultQuality) {
		this.resultQuality = resultQuality;
	}

	public WaterQualityEnum getTargetQuality() {
		return this.targetQuality;
	}

	public void setTargetQuality(WaterQualityEnum targetQuality) {
		this.targetQuality = targetQuality;
	}

	public BigDecimal getWeekNumber() {
		return this.weekNumber;
	}

	public void setWeekNumber(BigDecimal weekNumber) {
		this.weekNumber = weekNumber;
	}

	public BigDecimal getYearNumber() {
		return this.yearNumber;
	}

	public void setYearNumber(BigDecimal yearNumber) {
		this.yearNumber = yearNumber;
	}

}