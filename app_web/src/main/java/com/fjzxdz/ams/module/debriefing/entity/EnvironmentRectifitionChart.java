package com.fjzxdz.ams.module.debriefing.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;

@Entity
public class EnvironmentRectifitionChart extends TrackingEntity {


    private String count;

	private String pointCode;

	private String pointName;


	// ====================================================DTO===========================================================

	public EnvironmentRectifitionChart() {
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

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
}