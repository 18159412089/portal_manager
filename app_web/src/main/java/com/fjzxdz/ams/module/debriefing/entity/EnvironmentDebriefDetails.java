package com.fjzxdz.ams.module.debriefing.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "ENVIRONMEENT_DEBRIEF_DETAILS")
public class EnvironmentDebriefDetails extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	private String name;
	
	private String debriefing;

	@Column(name="ATTACH_VIDEO")
	private String video;

	private Boolean enable;
	
	private String status;

	// ====================================================DTO===========================================================

	public EnvironmentDebriefDetails() {
	}

	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public void setVideo(String video) {
		this.video = video;
	}
	
	public String getVideo() {
		return video;
	}

	public void setDebriefing(String debriefing) {
		this.debriefing = debriefing;
	}
	
	public String getDebriefing() {
		return debriefing;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getEnable() {
		return enable;
	}

	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

}