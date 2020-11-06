package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "POLLUTION_INFO_DATA_UNUPDATE")
public class PollutionInfoDataUnUpdate extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	private String uuid;


	/**
	 * 联系人联系方式
	 */
	private String lxrLxfs;

	/**
	 * 录入部门
	 */
	private String entryDepartment;

	/**
	 * 杨旺有是否查看
	 */
	private String ywView = "0";

	/**
	 * 李志勇是否查看
	 */
	private String lzyView = "0";



	/**
	 * 污染源大数据上一周未更新的修改时间
	 */
	private Date updateTime;

	/**
	 * 污染源大数据上一周未更新的主键uuid
	 */
	private String uuidUn;


	public PollutionInfoDataUnUpdate() {
	}

	@Override
	public String getUuid() {
		return uuid;
	}

	@Override
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getLxrLxfs() {
		return lxrLxfs;
	}

	public void setLxrLxfs(String lxrLxfs) {
		this.lxrLxfs = lxrLxfs;
	}

	public String getEntryDepartment() {
		return entryDepartment;
	}

	public void setEntryDepartment(String entryDepartment) {
		this.entryDepartment = entryDepartment;
	}

	public String getYwView() {
		return ywView;
	}

	public void setYwView(String ywView) {
		this.ywView = ywView;
	}

	public String getLzyView() {
		return lzyView;
	}

	public void setLzyView(String lzyView) {
		this.lzyView = lzyView;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUuidUn() {
		return uuidUn;
	}

	public void setUuidUn(String uuidUn) {
		this.uuidUn = uuidUn;
	}
}
