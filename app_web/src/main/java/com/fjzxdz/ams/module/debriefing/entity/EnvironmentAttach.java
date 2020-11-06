package com.fjzxdz.ams.module.debriefing.entity;

import javax.persistence.Entity;
import javax.persistence.Table;


import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "ENVIRONMEENT_ATTACH")
public class EnvironmentAttach extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	private String mongoid;

	private String name;

	private String relation;

	// ====================================================DTO===========================================================

	public EnvironmentAttach() {
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
	
	public String getRelation() {
		return relation;
	}
	
	public void setRelation(String relation) {
		this.relation = relation;
	}

}