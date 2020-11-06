package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name="FACTOR")
public class Factor extends TrackingEntity {
	private static final long serialVersionUID = 1L;
	
	private String code;

	private String name;
	
	@Column(name = "POINTCODE")
	private String pointCode;

	@Column(name = "ENABLE")
	private String enable;

	@Column(name = "STANDARD_LOWER_LIMIT")
	private Integer standard_lower_limit;

	@Column(name = "STANDARD_UPPER_LIMIT")
	private Integer standard_upper_limit;
	
	@Column(name = "DAY_STANDARD_LOWER_LIMIT")
	private Integer day_standard_lower_limit;

	@Column(name = "DAY_STANDARD_UPPER_LIMIT")
	private Integer day_standard_upper_limit;
	
	private String accuracy;

	@Column(name="ENVIRONMENTAL_RESTRICTION")
	private String environmental_restriction;

	@Column(name="ULTRA_LOW_LIMIT")
	private String ultra_low_limit;
	
	@Column(name = "LOWER_LIMIT")
	private Integer lower_limit;

	@Column(name = "UPPER_LIMIT")
	private Integer upper_limit;
	
	private String unit;

	private String equipment;

	public Factor() {
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getEnable() {
		return enable;
	}

	public void setEnable(String enable) {
		this.enable = enable;
	}

	public Integer getStandard_lower_limit() {
		return standard_lower_limit;
	}

	public void setStandard_lower_limit(Integer standard_lower_limit) {
		this.standard_lower_limit = standard_lower_limit;
	}

	public Integer getStandard_upper_limit() {
		return standard_upper_limit;
	}

	public void setStandard_upper_limit(Integer standard_upper_limit) {
		this.standard_upper_limit = standard_upper_limit;
	}

	public Integer getDay_standard_lower_limit() {
		return day_standard_lower_limit;
	}

	public void setDay_standard_lower_limit(Integer day_standard_lower_limit) {
		this.day_standard_lower_limit = day_standard_lower_limit;
	}

	public Integer getDay_standard_upper_limit() {
		return day_standard_upper_limit;
	}

	public void setDay_standard_upper_limit(Integer day_standard_upper_limit) {
		this.day_standard_upper_limit = day_standard_upper_limit;
	}

	public String getAccuracy() {
		return accuracy;
	}

	public void setAccuracy(String accuracy) {
		this.accuracy = accuracy;
	}

	public String getEnvironmental_restriction() {
		return environmental_restriction;
	}

	public void setEnvironmental_restriction(String environmental_restriction) {
		this.environmental_restriction = environmental_restriction;
	}

	public String getUltra_low_limit() {
		return ultra_low_limit;
	}

	public void setUltra_low_limit(String ultra_low_limit) {
		this.ultra_low_limit = ultra_low_limit;
	}

	public Integer getLower_limit() {
		return lower_limit;
	}

	public void setLower_limit(Integer lower_limit) {
		this.lower_limit = lower_limit;
	}

	public Integer getUpper_limit() {
		return upper_limit;
	}

	public void setUpper_limit(Integer upper_limit) {
		this.upper_limit = upper_limit;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getEquipment() {
		return equipment;
	}

	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}
	
}