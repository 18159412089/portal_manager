package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name="WT_CITY_HOUR_REPORT")
public class WtCityHourReport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String uuid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datatime;
	
	@Column(name="POINT_CODE")
	private String pointCode;
	
	@Column(name="POINT_NAME")
	private String pointName;

	@Lob
	private String excessfactorstr;

	@Column(name="RESULT_QUALITY")
	private String resultQuality;

	@Column(name="TARGET_QUALITY")
	private String targetQuality;

	public WtCityHourReport() {
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Date getDatatime() {
		return datatime;
	}

	public void setDatatime(Date datatime) {
		this.datatime = datatime;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getExcessfactorstr() {
		return excessfactorstr;
	}

	public void setExcessfactorstr(String excessfactorstr) {
		this.excessfactorstr = excessfactorstr;
	}

	public String getResultQuality() {
		return resultQuality;
	}

	public void setResultQuality(String resultQuality) {
		this.resultQuality = resultQuality;
	}

	public String getTargetQuality() {
		return targetQuality;
	}

	public void setTargetQuality(String targetQuality) {
		this.targetQuality = targetQuality;
	}

}