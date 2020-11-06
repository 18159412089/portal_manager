package com.fjzxdz.ams.module.enviromonit.water.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name="WT_SECTION_FACTOR")
public class WtSectionFactor extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	@Column(name="POINT_CODE")
	private String pointCode;

	@Column(name="CODE_POLLUTE")
	private String codePollte;

	@Column(name="POLLUTENAME")
	private String polluteName;

	private String unit;

	private BigDecimal rate;

	public WtSectionFactor() {
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
	

	public static final String WT_SECTION_FACTOR_MAP_FROM_JEDIS = "WT_SECTION_FACTOR_MAP_FROM_JEDIS";
}