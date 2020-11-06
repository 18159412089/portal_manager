package com.fjzxdz.ams.module.debriefing.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fjzxdz.ams.module.enums.EvnRectifitionEnum;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ENVIRONMEENT_DUTY_USER")
public class EnvironmentDutyUser extends TrackingEntity {

	private static final long serialVersionUID = -1769925538835340337L;


	private String projectId;
	private String dutyPerson;
	private String dutyDepartment;
	private String dutyUnit;
	private String involveDepartment;
	private String involvePerson;
	private String leadPerson;
	private String leadUnit;
	private String matchUnit;
	private String dutyPersonPhone;

	public String getDutyPersonPhone() {
		return dutyPersonPhone;
	}

	public void setDutyPersonPhone(String dutyPersonPhone) {
		this.dutyPersonPhone = dutyPersonPhone;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getDutyPerson() {
		return dutyPerson;
	}

	public void setDutyPerson(String dutyPerson) {
		this.dutyPerson = dutyPerson;
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

	public String getMatchUnit() {
		return matchUnit;
	}

	public void setMatchUnit(String matchUnit) {
		this.matchUnit = matchUnit;
	}
}