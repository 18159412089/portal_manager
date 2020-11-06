package com.fjzxdz.ams.module.enviromonit.camera.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.json.JSONObject;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "CAMERA_UNIT")
public class CameraUnit extends TrackingEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "UNIT_UUID")
	private String unitUuid;
	@Column(name = "PARENT_UUID")
	private String parentUuid;
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

	public CameraUnit() {
		super();
		this.unitUuid = "";
		this.parentUuid = "";
		this.name = "";
		this.isParent = false;
		this.createTime = new Long(0);
		this.updateTime = new Long(0);
		this.remark = "";
	}

	public CameraUnit(String unitUuid, String parentUuid, String name, Boolean isParent, Long createTime,
			Long updateTime, String remark) {
		
		this.unitUuid = unitUuid;
		this.parentUuid = parentUuid;
		this.name = name;
		this.isParent = isParent;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.remark = remark;
	}



	public String getUnitUuid() {
		return unitUuid;
	}

	public void setUnitUuid(String unitUuid) {
		this.unitUuid = unitUuid;
	}

	public String getParentUuid() {
		return parentUuid;
	}

	public void setParentUuid(String parentUuid) {
		this.parentUuid = parentUuid;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public JSONObject toJSONObject() {
		JSONObject obj= new JSONObject();
		
		obj.put("unitUuid", this.getUnitUuid());
		obj.put("name", this.getName());
		obj.put("isParent", this.getIsParent());
		obj.put("parentUuid", this.getParentUuid());
		obj.put("updateTime", this.getUpdateTime());
		obj.put("createTime", this.getCreateTime());

		return obj;
	}
	
	public JSONObject toTreeNodeJSONObject() {
		JSONObject obj= new JSONObject();
		
		obj.put("id", this.getUnitUuid());
		obj.put("pId", this.getParentUuid());
		obj.put("nodeType", "UNIT");
		obj.put("name", this.getName());
		
		/*obj.put("unitUuid", this.getUnitUuid());
		obj.put("name", this.getName());
		obj.put("isParent", this.getIsParent());
		obj.put("parentUuid", this.getParentUuid());
		obj.put("updateTime", this.getUpdateTime());
		obj.put("createTime", this.getCreateTime());*/
		
		return obj;
	}
}
