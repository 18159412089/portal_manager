package com.fjzxdz.ams.module.enviromonit.camera.controller;

import java.io.Serializable;

public class CameraParam implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8763112121218945740L;
	private String appkey;
	private String secret;
	private Long time;
	private Integer pageNo;
	private Integer pageSize;
	private String opUserUuid;
	private String parentUuid;
	private Integer allChildren;
	private String planType;
	private String recordPlanUuid;
	private String netZoneUuid;
	private String cameraUuids;
	private String regionUuids;
	private String subSystemCode;

	public String getAppkey() {
		return appkey;
	}

	public void setAppkey(String appkey) {
		this.appkey = appkey;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getOpUserUuid() {
		return opUserUuid;
	}

	public void setOpUserUuid(String opUserUuid) {
		this.opUserUuid = opUserUuid;
	}

	public String getParentUuid() {
		return parentUuid;
	}

	public void setParentUuid(String parentUuid) {
		this.parentUuid = parentUuid;
	}

	public Integer getAllChildren() {
		return allChildren;
	}

	public void setAllChildren(Integer allChildren) {
		this.allChildren = allChildren;
	}

	public String getPlanType() {
		return planType;
	}

	public void setPlanType(String planType) {
		this.planType = planType;
	}

	public String getRecordPlanUuid() {
		return recordPlanUuid;
	}

	public void setRecordPlanUuid(String recordPlanUuid) {
		this.recordPlanUuid = recordPlanUuid;
	}

	public String getNetZoneUuid() {
		return netZoneUuid;
	}

	public void setNetZoneUuid(String netZoneUuid) {
		this.netZoneUuid = netZoneUuid;
	}

	public String getCameraUuids() {
		return cameraUuids;
	}

	public void setCameraUuids(String cameraUuids) {
		this.cameraUuids = cameraUuids;
	}

	public String getRegionUuids() {
		return regionUuids;
	}

	public void setRegionUuids(String regionUuids) {
		this.regionUuids = regionUuids;
	}

	public String getSubSystemCode() {
		return subSystemCode;
	}

	public void setSubSystemCode(String subSystemCode) {
		this.subSystemCode = subSystemCode;
	}

}
