package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;
@Entity
@Table(name="USER_TASK_DETAILS")
public class TaskDetalis extends TrackingEntity {
	private static final long serialVersionUID = 1L;
	
	@Lob
	@Column(name="USER_NAME" ,columnDefinition="CLOB", nullable=true)
	private String userName;
	
	private String content;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	

}
