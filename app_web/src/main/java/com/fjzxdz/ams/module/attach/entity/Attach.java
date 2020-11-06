package com.fjzxdz.ams.module.attach.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Lob;
import javax.persistence.Table;

import com.fjzxdz.ams.common.AttachEnum;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "ATTACH")
public class Attach extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	private String name;

	@Enumerated(EnumType.STRING)
	private AttachEnum category;

	@Lob
	private String remark;

	//=========================================DTO========================================

	public Attach() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public AttachEnum getCategory() {
		return category;
	}

	public void setCategory(AttachEnum category) {
		this.category = category;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}