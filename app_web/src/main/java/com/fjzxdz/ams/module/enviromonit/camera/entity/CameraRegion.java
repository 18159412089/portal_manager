package com.fjzxdz.ams.module.enviromonit.camera.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.json.JSONObject;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "CAMERA_REGION")
public class CameraRegion extends TrackingEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "REGION_UUID")
	private String regionUuid;
	@Column(name = "PARENT_UUID")
	private String parentUuid;
	@Column(name = "PARENT_NODE_TYPE")
	private String parentNodeType;
	@Column(name = "NAME")
	private String name;
	@Column(name = "IS_PARENT")
	private Boolean isParent;
	@Column(name = "CREATE_TIME")
	private Long createTime;
	@Column(name = "UPDATE_TIME")
	private Long updateTime;
	@Column(name = "REMARK")
	private String remark;

	public CameraRegion() {
		this.regionUuid = "";
		this.parentUuid = "";
		this.parentNodeType = "";
		this.name = "";
		this.isParent = false;
		this.remark = "";
		this.createTime = new Long(0);
		this.updateTime = new Long(0);
	}

	public String getRegionUuid() {
		return regionUuid;
	}

	public void setRegionUuid(String regionUuid) {
		this.regionUuid = regionUuid;
	}

	public String getParentUuid() {
		return parentUuid;
	}

	public void setParentUuid(String parentUuid) {
		this.parentUuid = parentUuid;
	}

	public String getParentNodeType() {
		return parentNodeType;
	}

	public void setParentNodeType(String parentNodeType) {
		this.parentNodeType = parentNodeType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("regionUuid", this.getRegionUuid());
		obj.put("parentUuid", this.getParentUuid());
		obj.put("parentNodeType", this.getParentNodeType());
		obj.put("name", this.getName());
		obj.put("isParent", this.getIsParent());
		obj.put("remark", this.getRemark());
		obj.put("createTime", this.getCreateTime());
		obj.put("updateTime", this.getUpdateTime());
		
		return obj;
	}
	
	public JSONObject toTreeNodeJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("id", this.getRegionUuid());
		obj.put("pId", this.getParentUuid());
		obj.put("nodeType", "REGION");
		obj.put("name", this.getName());
		
		/*obj.put("regionUuid", this.getRegionUuid());
		obj.put("parentUuid", this.getParentUuid());
		obj.put("parentNodeType", this.getParentNodeType());
		obj.put("name", this.getName());
		obj.put("isParent", this.getIsParent());
		obj.put("remark", this.getRemark());
		obj.put("createTime", this.getCreateTime());
		obj.put("updateTime", this.getUpdateTime());*/
		
		return obj;
	}
}
