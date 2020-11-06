package com.fjzxdz.ams.module.enviromonit.camera.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.json.JSONObject;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "CAMERA_DATA")
public class CameraData extends TrackingEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "ID")
	private String id;
	@Column(name = "P_ID")
	private String pId;
	@Column(name = "NAME")
	private String name;
	@Column(name = "NODE_TYPE")
	private String nodeType;
	@Column(name = "IS_PARENT")
	private Boolean isParent;
	@Column(name = "ICON_SKIN")
	private String iconSkin;

	public CameraData() {
		this.id = "";
		this.pId = "";
		this.name = "";
		this.nodeType = "";
		this.iconSkin = "";
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public String getIconSkin() {
		return iconSkin;
	}

	public void setIconSkin(String iconSkin) {
		this.iconSkin = iconSkin;
	}

	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("id", this.getId());
		obj.put("pId", this.getpId());
		obj.put("name", this.getName());
		obj.put("nodeType", this.getNodeType());
		obj.put("iconSkin", this.getIconSkin());
		
		return obj;
	}
}
