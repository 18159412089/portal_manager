package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;


@Entity
@Table(name="WATER_ATTACHMENTS")
public class WaterAttachment extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	private BigDecimal enable;

	@Column(name="IS_SHOW")
	private String isShow;
	
	private String mongoid;

	private String name;

	@Column(name="POINT_CODE")
	private String pointCode;

	@Column(name="POINT_NAME")
	private String pointName;

	@Lob
	private String remark;
	//来源
	private String source;

	//是否最新
	private String isNew;
	
	private BigDecimal type;

   //	问题描述
	private String description;

	public WaterAttachment() {
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getIsNew() {
		return isNew;
	}

	public void setIsNew(String isNew) {
		this.isNew = isNew;
	}

	public BigDecimal getEnable() {
		return enable;
	}

	public void setEnable(BigDecimal enable) {
		this.enable = enable;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getMongoid() {
		return mongoid;
	}

	public void setMongoid(String mongoid) {
		this.mongoid = mongoid;
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

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getType() {
		return type;
	}

	public void setType(BigDecimal type) {
		this.type = type;
	}

}