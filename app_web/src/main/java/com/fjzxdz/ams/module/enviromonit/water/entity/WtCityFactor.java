package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.math.BigDecimal;

import javax.persistence.*;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name="WT_CITY_FACTOR")
public class WtCityFactor extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;

	@Column(name="POINT_CODE")
	private String pointCode;
	
	@Column(name="CODE_POLLUTE")
	private String codePollte;
	
	@Column(name="POLLUTENAME")
	private String polluteName;

	private String unit;
	
	private BigDecimal rate;

	public WtCityFactor() {
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getCodePollte() {
		return codePollte;
	}

	public void setCodePollte(String codePollte) {
		this.codePollte = codePollte;
	}

	public String getPolluteName() {
		return polluteName;
	}

	public void setPolluteName(String polluteName) {
		this.polluteName = polluteName;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	

}