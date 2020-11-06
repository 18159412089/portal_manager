package com.fjzxdz.ams.module.debriefing.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fjzxdz.ams.module.enums.EvnRectifitionEnum;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ENVIRONMEENT_RECTIFITION")
public class EnvironmentRectifition extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="NAME")
	private CommonRelationTable project;	//项目

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="DESCRIBE")
	private CommonRelationTable describle;	//问题描述

	/*@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="AREA_CODE")
	private AirMonitorPoint area;	//行政区划

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="CITY_CODE")
	private AirMonitorPoint city;	//所属城市*/

	@Lob
	private String question;

	@Lob
	private String require;
	private String category;

	private String dutyPerson;
	private String dutyPersonPhone;
	private String dutyDepartment;
	private String dutyUnit;
	private String involveDepartment;
	private String involvePerson;
	private String leadPerson;
	private String leadUnit;
	private String matchUnit;
	private String wornTime;
	private String areaCode;
	/**
	 * 所属轮数  第一轮  第二轮
	 */
	private String numOfRoundValue;
	private String numOfRoundName;
    private String mark;//区分漳州还是漳浦
	@Transient
	private String areaName;
	private String cityCode;
	@Transient
	private String cityName;

	@Enumerated(EnumType.STRING)
	private EvnRectifitionEnum status;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "TIMELIMIT")
	private Date timelimit;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATE_TIME")
	private Date createTime;
	
	@Transient
	private String createtime;
	@Transient
	private String statusName;
	@Transient
	private Date ct;
	private String num;

    //表格创建时间
	public Date getCt() {
		return ct;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public void setCt(Date ct) {
		this.ct = ct;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	// ====================================================DTO===========================================================

	public EnvironmentRectifition() {
	}

	public EnvironmentRectifition(String projectId, String describleId, String uuid, String question,
								  String require, String category, EvnRectifitionEnum status, String projectName, String describleName,
								  Date createTime, Date timelimit, String dutyDepartment, String dutyPerson, String dutyUnit,
								  String leadPerson, String leadUnit, String matchUnit, String involveDepartment, String involvePerson,
								  String wornTime,String areaCode,String cityCode) {
		this.uuid = uuid;
		this.projectId = projectId;
		this.describleId = describleId;

		this.question = question;
		this.require = require;
		this.category = category;
		this.status = status;
		this.projectName = projectName;
		this.describleName = describleName;
		this.createTime = createTime;
		this.timelimit = timelimit;
		this.dutyDepartment = dutyDepartment;
		this.dutyPerson = dutyPerson;
		this.dutyUnit = dutyUnit;
		this.leadPerson = leadPerson;
		this.leadUnit = leadUnit;
		this.matchUnit = matchUnit;
		this.involveDepartment = involveDepartment;
		this.involvePerson = involvePerson;
		this.wornTime = wornTime;
		this.areaCode = areaCode;
		this.cityCode = cityCode;
	}
	
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

	public String getNumOfRoundValue() {
		return numOfRoundValue;
	}

	public void setNumOfRoundValue(String numOfRoundValue) {
		this.numOfRoundValue = numOfRoundValue;
	}

	public String getNumOfRoundName() {
		return numOfRoundName;
	}

	public void setNumOfRoundName(String numOfRoundName) {
		this.numOfRoundName = numOfRoundName;
	}

	public String getWornTime() {
		return wornTime;
	}

	public void setWornTime(String wornTime) {
		this.wornTime = wornTime;
	}

	public void setDutyPerson(String dutyPerson) {
		this.dutyPerson = dutyPerson;
	}

	public String getMatchUnit() {
		return matchUnit;
	}

	public void setMatchUnit(String matchUnit) {
		this.matchUnit = matchUnit;
	}

	public String getDutyPerson() {
		return dutyPerson;
	}


	public String getDutyDepartment() {
		return dutyDepartment;
	}

	public void setDutyDepartment(String dutyDepartment) {
		this.dutyDepartment = dutyDepartment;
	}

	public String getDutyUnit() {
		return dutyUnit;
	}

	public void setDutyUnit(String dutyUnit) {
		this.dutyUnit = dutyUnit;
	}

	public String getInvolveDepartment() {
		return involveDepartment;
	}

	public void setInvolveDepartment(String involveDepartment) {
		this.involveDepartment = involveDepartment;
	}

	public String getInvolvePerson() {
		return involvePerson;
	}

	public void setInvolvePerson(String involvePerson) {
		this.involvePerson = involvePerson;
	}

	public String getLeadPerson() {
		return leadPerson;
	}

	public void setLeadPerson(String leadPerson) {
		this.leadPerson = leadPerson;
	}

	public String getLeadUnit() {
		return leadUnit;
	}

	public void setLeadUnit(String leadUnit) {
		this.leadUnit = leadUnit;
	}

	@Transient
	private String projectId;

	@Transient
	private String projectName;
	
	@Transient
	private String describleId;
	
	@Transient
	private String describleName;
	
	@Transient
	private String limit;
	
	public String getLimit() {
		return limit;
	}
	
	public void setLimit(String limit) {
		this.limit = limit;
	}
	
	public Date getTimelimit() {
		return timelimit;
	}
	
	public void setTimelimit(Date timelimit) {
		this.timelimit = timelimit;
	}

//	public CommonRelationTable getProject() {
//		return project;
//	}
//
//	public void setProject(CommonRelationTable project) {
//		if(ToolUtil.isNotEmpty(project)) {
//			this.projectId = project.getUuid();
//			this.projectName = project.getName();
//		}
//		this.project = project;
//	}
//
//	public CommonRelationTable getDescrible() {
//		if(ToolUtil.isNotEmpty(describle)) {
//			setDescribleId(describle.getUuid());
//			setDescribleName(describle.getName());
//		}
//		return describle;
//	}
//
//	public void setDescrible(CommonRelationTable describle) {
//		this.describle = describle;
//	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getRequire() {
		return require;
	}

	public void setRequire(String require) {
		this.require = require;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public EvnRectifitionEnum getStatus() {
		return status;
	}

	public void setStatus(EvnRectifitionEnum status) {
		this.status = status;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getDutyPersonPhone() {
		return dutyPersonPhone;
	}

	public void setDutyPersonPhone(String dutyPersonPhone) {
		this.dutyPersonPhone = dutyPersonPhone;
	}

	/*public AirMonitorPoint getArea() {
		return area;
	}

	public void setArea(AirMonitorPoint area) {
		this.area = area;
	}

	public AirMonitorPoint getCity() {
		return city;
	}

	public void setCity(AirMonitorPoint city) {
		this.city = city;
	}*/


//	public String getProjectId() {
//		if(null != projectId)
//			return projectId;
//		if (null == project)
//			return "";
//		return project.getUuid();
//	}
//	
//	public void setProjectId(String projectId) {
//		this.projectId = projectId;
//	}
//
//	public String getProjectName() {
//		if(null != projectName)
//			return projectName;
//		if (null == project)
//			return "";
//		return project.getName();
//	}
//
//	public void setProjectName(String projectName) {
//		this.projectName = projectName;
//	}
//	
//	public String getDescribleId() {
//		if(null != describleId)
//			return describleId;
//		if (null == describle)
//			return "";
//		return describle.getUuid();
//	}
//	
//	public void setDescribleId(String describleId) {
//		this.describleId = describleId;
//	}
//
//	public String getDescribleName() {
//		if(null != describleName)
//			return describleName;
//		if (null == describle)
//			return "";
//		return describle.getName();
//	}
//
//	public void setDescribleName(String describleName) {
//		this.describleName = describleName;
//	}
}