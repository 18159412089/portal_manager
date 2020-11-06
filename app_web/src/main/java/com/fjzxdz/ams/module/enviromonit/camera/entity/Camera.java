package com.fjzxdz.ams.module.enviromonit.camera.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.json.JSONObject;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "CAMERA")
public class Camera extends TrackingEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "CAMERA_UUID")
	private String cameraUuid;
	
	@Column(name = "UNIT_UUID")
	private String unitUuid;
	
	@Column(name = "REGION_UUID")
	private String regionUuid;
	
	@Column(name = "ENCODER_UUID")
	private String encoderUuid;
	
	@Column(name = "CAMERA_NAME")
	private String cameraName;
	
	@Column(name = "CAMERA_TYPE")
	private String cameraType;
	
	@Column(name = "SMART_TYPE")
	private String smartType;
	
	@Column(name = "CAMERA_CHANNEL_NUM")
	private String cameraChannelNum;
	
	@Column(name = "SMART_SUPPORT")
	private String smartSupport;
	
	@Column(name = "RES_AUTHS")
	private String resAuths;
	
	@Column(name = "ORDER_NUM")
	private String orderNum;
	
	@Column(name = "KEY_BOARD_CODE")
	private String keyBoardCode;
	
	@Column(name = "UPDATE_TIME")
	private Long updateTime;
	
	@Column(name = "ON_LINE_STATUS")
	private Boolean onLineStatus;

	public Camera() {
		this.cameraUuid = "";
		this.unitUuid = "";
		this.regionUuid = "";
		this.encoderUuid = "";
		this.cameraName = "";
		this.cameraType = "";
		this.smartType = "";
		this.cameraChannelNum = "";
		this.smartSupport = "";
		this.resAuths = "";
		this.orderNum = "";
		this.keyBoardCode = "";
		this.updateTime = new Long(0);
		this.onLineStatus = false;
	}

	public String getCameraUuid() {
		return cameraUuid;
	}

	public void setCameraUuid(String cameraUuid) {
		this.cameraUuid = cameraUuid;
	}

	public String getUnitUuid() {
		return unitUuid;
	}

	public void setUnitUuid(String unitUuid) {
		this.unitUuid = unitUuid;
	}

	public String getRegionUuid() {
		return regionUuid;
	}

	public void setRegionUuid(String regionUuid) {
		this.regionUuid = regionUuid;
	}

	public String getEncoderUuid() {
		return encoderUuid;
	}

	public void setEncoderUuid(String encoderUuid) {
		this.encoderUuid = encoderUuid;
	}

	public String getCameraName() {
		return cameraName;
	}

	public void setCameraName(String cameraName) {
		this.cameraName = cameraName;
	}

	public String getCameraType() {
		return cameraType;
	}

	public void setCameraType(String cameraType) {
		this.cameraType = cameraType;
	}

	public String getSmartType() {
		return smartType;
	}

	public void setSmartType(String smartType) {
		this.smartType = smartType;
	}

	public String getCameraChannelNum() {
		return cameraChannelNum;
	}

	public void setCameraChannelNum(String cameraChannelNum) {
		this.cameraChannelNum = cameraChannelNum;
	}

	public String getSmartSupport() {
		return smartSupport;
	}

	public void setSmartSupport(String smartSupport) {
		this.smartSupport = smartSupport;
	}

	public String getResAuths() {
		return resAuths;
	}

	public void setResAuths(String resAuths) {
		this.resAuths = resAuths;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getKeyBoardCode() {
		return keyBoardCode;
	}

	public void setKeyBoardCode(String keyBoardCode) {
		this.keyBoardCode = keyBoardCode;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public Boolean getOnLineStatus() {
		return onLineStatus;
	}

	public void setOnLineStatus(Boolean onLineStatus) {
		this.onLineStatus = onLineStatus;
	}
	
	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("cameraUuid", this.getCameraUuid());
		obj.put("unitUuid", this.getUnitUuid());
		obj.put("regionUuid", this.regionUuid);
		obj.put("encoderUuid", this.encoderUuid);
		obj.put("cameraName", this.cameraName);
		obj.put("cameraType", this.cameraType);
		obj.put("smartType", this.smartType);
		obj.put("cameraChannelNum", this.cameraChannelNum);
		obj.put("smartSupport", this.smartSupport);
		obj.put("resAuths", this.resAuths);
		obj.put("orderNum", this.orderNum);
		obj.put("keyBoardCode", this.keyBoardCode);
		obj.put("updateTime", this.updateTime);
		obj.put("onLineStatus", this.onLineStatus);
		
		return obj;
	}
	
	public JSONObject toTreeNodeJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("id", this.getCameraUuid());
		obj.put("pId", this.getUnitUuid());
		obj.put("nodeType", "CAMERA");
		obj.put("name", this.cameraName);
		
		/*obj.put("cameraUuid", this.getCameraUuid());
		obj.put("unitUuid", this.getUnitUuid());
		obj.put("regionUuid", this.regionUuid);
		obj.put("encoderUuid", this.encoderUuid);
		obj.put("cameraName", this.cameraName);
		obj.put("cameraType", this.cameraType);
		obj.put("smartType", this.smartType);
		obj.put("cameraChannelNum", this.cameraChannelNum);
		obj.put("smartSupport", this.smartSupport);
		obj.put("resAuths", this.resAuths);
		obj.put("orderNum", this.orderNum);
		obj.put("keyBoardCode", this.keyBoardCode);
		obj.put("updateTime", this.updateTime);
		obj.put("onLineStatus", this.onLineStatus);*/
		
		return obj;
	}
}
