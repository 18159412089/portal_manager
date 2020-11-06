package com.fjzxdz.ams.module.enviromonit.hourdata.entity;

import java.io.Serializable;
import javax.persistence.*;

import cn.fjzxdz.frame.entity.TrackingEntity;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="PE_HOUR_FLUX_DATA")
public class PeHourFluxData extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	@Column(name="FLUX_AVG")
	private BigDecimal fluxAvg;

	@Column(name="FLUX_MAX")
	private BigDecimal fluxMax;

	@Column(name="FLUX_MIN")
	private BigDecimal fluxMin;

	@Column(name="FLUX_SUM")
	private BigDecimal fluxSum;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="INSERT_TIME")
	private Date insertTime;

	@Column(name="IS_MEASURE")
	private String isMeasure;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="MEASURE_TIME")
	private Date measureTime;

	@Column(name="OUTFALL_TYPE")
	private String outfallType;

	@Column(name="OUTPUT_ID")
	private BigDecimal outputId;

	@Column(name="PE_ID")
	private BigDecimal peId;

	@Column(name="REPORT_TYPE")
	private String reportType;

	@Column(name="STOP_PRODUCTION")
	private String stopProduction;

	public PeHourFluxData() {
	}

	public BigDecimal getFluxAvg() {
		return this.fluxAvg;
	}

	public void setFluxAvg(BigDecimal fluxAvg) {
		this.fluxAvg = fluxAvg;
	}

	public BigDecimal getFluxMax() {
		return this.fluxMax;
	}

	public void setFluxMax(BigDecimal fluxMax) {
		this.fluxMax = fluxMax;
	}

	public BigDecimal getFluxMin() {
		return this.fluxMin;
	}

	public void setFluxMin(BigDecimal fluxMin) {
		this.fluxMin = fluxMin;
	}

	public BigDecimal getFluxSum() {
		return this.fluxSum;
	}

	public void setFluxSum(BigDecimal fluxSum) {
		this.fluxSum = fluxSum;
	}

	public Date getInsertTime() {
		return this.insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	public String getIsMeasure() {
		return this.isMeasure;
	}

	public void setIsMeasure(String isMeasure) {
		this.isMeasure = isMeasure;
	}

	public Date getMeasureTime() {
		return this.measureTime;
	}

	public void setMeasureTime(Date measureTime) {
		this.measureTime = measureTime;
	}

	public String getOutfallType() {
		return this.outfallType;
	}

	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}

	public BigDecimal getOutputId() {
		return this.outputId;
	}

	public void setOutputId(BigDecimal outputId) {
		this.outputId = outputId;
	}

	public BigDecimal getPeId() {
		return this.peId;
	}

	public void setPeId(BigDecimal peId) {
		this.peId = peId;
	}

	public String getReportType() {
		return this.reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getStopProduction() {
		return this.stopProduction;
	}

	public void setStopProduction(String stopProduction) {
		this.stopProduction = stopProduction;
	}

}