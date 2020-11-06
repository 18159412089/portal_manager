package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;


@Entity
@Table(name="ENV_COMPANY")
public class EnvCompany extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	@Column(name="A_QUANTITY")
	private String aQuantity;

	private String address;

	private String basin;

	private String category;

	private String code;

	@Column(name="CONTACT_INFO")
	private String contactInfo;

	private String contactor;

	private String corporation;

	private String enabled;

	@Column(name="FOCUS_POINT")
	private String focusPoint;

	private String name;

	private String region;

	@Column(name="USC_CODE")
	private String uscCode;

	@Column(name="W_QUANTITY")
	private String wQuantity;

	public EnvCompany() {
	}

	public String getAQuantity() {
		return this.aQuantity;
	}

	public void setAQuantity(String aQuantity) {
		this.aQuantity = aQuantity;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBasin() {
		return this.basin;
	}

	public void setBasin(String basin) {
		this.basin = basin;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContactInfo() {
		return this.contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public String getContactor() {
		return this.contactor;
	}

	public void setContactor(String contactor) {
		this.contactor = contactor;
	}

	public String getCorporation() {
		return this.corporation;
	}

	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}

	public String getEnabled() {
		return this.enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getFocusPoint() {
		return this.focusPoint;
	}

	public void setFocusPoint(String focusPoint) {
		this.focusPoint = focusPoint;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getUscCode() {
		return this.uscCode;
	}

	public void setUscCode(String uscCode) {
		this.uscCode = uscCode;
	}

	public String getWQuantity() {
		return this.wQuantity;
	}

	public void setWQuantity(String wQuantity) {
		this.wQuantity = wQuantity;
	}

}