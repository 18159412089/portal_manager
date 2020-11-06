package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name="POINT")
public class Point extends TrackingEntity {
	private static final long serialVersionUID = 1L;
	
	private String code;

	@Column(name="ACCESS_TIME")
	@Temporal(TemporalType.TIMESTAMP)
	private Date accessTime;
	
	private String name;

	private String city;

	private String region;

	@Column(name = "ENV_COMPANY")
	private String envCompany;

	@Column(name="MN_CODE")
	private String mn_code;

	private String type;

	@Column(name="SPECIAL_TYPE")
	private String special_type;

	@Column(name="UPLOAD_CYCLE")
	private String uploadCycle;

	private String entrust;

	private String operator;

	@Column(name="ENABLE_CLOSE")
	private String enableClose;

	@Column(name="CONCERN_TYPE")
	private String concernType;

	public Point() {
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getAccessTime() {
		return accessTime;
	}

	public void setAccessTime(Date accessTime) {
		this.accessTime = accessTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getEnvCompany() {
		return envCompany;
	}

	public void setEnvCompany(String envCompany) {
		this.envCompany = envCompany;
	}

	public String getMn_code() {
		return mn_code;
	}

	public void setMn_code(String mn_code) {
		this.mn_code = mn_code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSpecial_type() {
		return special_type;
	}

	public void setSpecial_type(String special_type) {
		this.special_type = special_type;
	}

	public String getUploadCycle() {
		return uploadCycle;
	}

	public void setUploadCycle(String uploadCycle) {
		this.uploadCycle = uploadCycle;
	}

	public String getEntrust() {
		return entrust;
	}

	public void setEntrust(String entrust) {
		this.entrust = entrust;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getEnableClose() {
		return enableClose;
	}

	public void setEnableClose(String enableClose) {
		this.enableClose = enableClose;
	}

	public String getConcernType() {
		return concernType;
	}

	public void setConcernType(String concernType) {
		this.concernType = concernType;
	}
	
}