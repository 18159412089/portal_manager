package com.fjzxdz.ams.module.debriefing.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Entity
@Table(name="ENV_CANCELLATION_ACCOUNT")
public class EnvCancellationAccount extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="NAME")
	private CommonRelationTable project;    //项目

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="DESCRIBE")
	private CommonRelationTable describle;  //问题描述

	@Temporal(TemporalType.DATE)
	@Column(name="CITY_ACTUAL_TIME")
	private Date cityActualTime;

	@Temporal(TemporalType.DATE)
	@Column(name="CITY_ESTIMATE_TIME")
	private Date cityEstimateTime;

	@Temporal(TemporalType.DATE)
	@Column(name="COUNTY_ACTUAL_TIME")
	private Date countyActualTime;

	@Temporal(TemporalType.DATE)
	@Column(name="COUNTY_ESTIMATE_TIME")
	private Date countyEstimateTime;

	@Temporal(TemporalType.DATE)
	@Column(name="PROFESSION_ACTUAL_TIME")
	private Date professionActualTime;

	@Temporal(TemporalType.DATE)
	@Column(name="PROFESSION_ESTIMATE_TIME")
	private Date professionEstimateTime;

	@Temporal(TemporalType.DATE)
	@Column(name="PROFESSION_EXAMINE_TIME")
	private Date professionExamineTime;

	private String schedule;

	@Temporal(TemporalType.DATE)
	@Column(name="TIME_LIMIT")
	private Date timeLimit;
	
	@Column(name="RECTIFITION_UUID")
	private String rectifitionUuid;

	// ====================================================DTO===========================================================

	public EnvCancellationAccount() {
	}

	public EnvCancellationAccount(String projectName,String describleName, String uuid, Date cityActualTime,Date cityEstimateTime,
			Date countyActualTime,Date countyEstimateTime,Date professionActualTime,Date professionEstimateTime,Date professionExamineTime,
			String schedule, Date timeLimit,String rectifitionUuid) {
		this.projectName = projectName;
		this.describleName = describleName;
		this.uuid = uuid;
		this.cityActualTime = cityActualTime;
		this.cityEstimateTime = cityEstimateTime;
		this.countyActualTime = countyActualTime;
		this.countyEstimateTime = countyEstimateTime;
		this.professionActualTime = professionActualTime;
		this.professionEstimateTime = professionEstimateTime;
		this.professionExamineTime = professionExamineTime;
		this.schedule = schedule;
		this.timeLimit = timeLimit;
		this.rectifitionUuid = rectifitionUuid;
	}

	@Transient
	private String projectId;
	@Transient
	private String projectName;

	@Transient
	private String describleId;
	@Transient
	private String describleName;

	public void setTransient() {
		if(ToolUtil.isNotEmpty(getProject())) {
			this.projectId = project.getUuid();
			this.projectName = project.getName();
		}
		if(ToolUtil.isNotEmpty(getDescrible())) {
			this.describleId = describle.getUuid();
			this.describleName = describle.getName();
		}
	}
	public CommonRelationTable getProject() {
		return project;
	}

	public void setProject(CommonRelationTable project) {
		this.project = project;
	}

	public CommonRelationTable getDescrible() {
		return describle;
	}

	public void setDescrible(CommonRelationTable describle) {
		this.describle = describle;
	}

	public Date getCityActualTime() {
		return this.cityActualTime;
	}

	public void setCityActualTime(Date cityActualTime) {
		this.cityActualTime = cityActualTime;
	}

	public Date getCityEstimateTime() {
		return this.cityEstimateTime;
	}

	public void setCityEstimateTime(Date cityEstimateTime) {
		this.cityEstimateTime = cityEstimateTime;
	}

	public Date getCountyActualTime() {
		return this.countyActualTime;
	}

	public void setCountyActualTime(Date countyActualTime) {
		this.countyActualTime = countyActualTime;
	}

	public Date getCountyEstimateTime() {
		return this.countyEstimateTime;
	}

	public void setCountyEstimateTime(Date countyEstimateTime) {
		this.countyEstimateTime = countyEstimateTime;
	}

	public Date getProfessionActualTime() {
		return this.professionActualTime;
	}

	public void setProfessionActualTime(Date professionActualTime) {
		this.professionActualTime = professionActualTime;
	}

	public Date getProfessionEstimateTime() {
		return this.professionEstimateTime;
	}

	public void setProfessionEstimateTime(Date professionEstimateTime) {
		this.professionEstimateTime = professionEstimateTime;
	}

	public Date getProfessionExamineTime() {
		return this.professionExamineTime;
	}

	public void setProfessionExamineTime(Date professionExamineTime) {
		this.professionExamineTime = professionExamineTime;
	}

	public String getSchedule() {
		return this.schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public Date getTimeLimit() {
		return this.timeLimit;
	}

	public void setTimeLimit(Date timeLimit) {
		this.timeLimit = timeLimit;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getDescribleId() {
		return describleId;
	}

	public void setDescribleId(String describleId) {
		this.describleId = describleId;
	}

	public String getDescribleName() {
		return describleName;
	}

	public void setDescribleName(String describleName) {
		this.describleName = describleName;
	}

	public String getRectifitionUuid() {
		return rectifitionUuid;
	}

	public void setRectifitionUuid(String rectifitionUuid) {
		this.rectifitionUuid = rectifitionUuid;
	}
	
	

}