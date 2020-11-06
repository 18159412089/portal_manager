package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "CITY_DIRECT_POLLUTION_DATA")
public class CityDirectPollutionData extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	/**
	 * 单位
	 */
	private String dw;

	/**
	 * 污染源类型
	 */
	private String wrylx;

	/**
	 * 污染源种类
	 */
	private String wryzl;

	/**
	 * 名称
	 */
	private String mc;

	/**
	 * 存在问题
	 */
	private String czwt;

	/**
	 * 整改措施
	 */
	private String zgcs;

	/**
	 * 治理项目
	 */
	private String zlxm;

	/**
	 * 完成目标_2019年12月底
	 */
	@Column(name = "WCMB_201912")
	private String wcmb201912;

	/**
	 * 完成目标_2020年6月底
	 */
	@Column(name = "WCMB_202006")
	private String wcmb202006;

	/**
	 * 完成目标_2020年12月底
	 */
	@Column(name = "WCMB_202012")
	private String wcmb202012;

	/**
	 * 属地责任_责任单位
	 */
	@Column(name = "SDZR_ZRDW")
	private String sdzrZrdw;

	/**
	 * 属地责任_责任人及联系方式
	 */
	@Column(name = "SDZRDW_ZRRLXFS")
	private String sdzrdwZrrlxfs;

	/**
	 * 部门责任_责任单位
	 */
	@Column(name = "BMZR_ZRDW")
	private String bmzrZrdw;

	/**
	 * 部门责任_责任人及联系方式
	 */
	@Column(name = "BMZRDW_ZRRLXFS")
	private String bmzrdwZrrlxfs;

	/**
	 * 部门责任_配合责任单位
	 */
	@Column(name = "BMZR_PHZRDW")
	private String bmzrPhzrdw;

	/**
	 * 部门责任_责任人及联系方式
	 */
	@Column(name = "PHZRDW_ZRRLXFS")
	private String phzrdwZrrlxfs;

	/**
	 * 乡镇
	 */
	private String xz;

	/**
	 * 地址
	 */
	private String dz;

	/**
	 * 经纬度
	 */
	private String jwd;

	/**
	 * 经度
	 */
	private String jd;

	/**
	 * 纬度
	 */
	private String wd;

	/**
	 * 备注
	 */
	private String bz;

	/**
	 * 录入部门
	 */
	@Column(name = "ENTRY_DEPARTMENT")
	private String entryDepartment;

	/**
	 * 数据审核状态
	 */
	@Column(name = "AUDIT_STATE")
	private String auditState;

	/**
	 * 数据有效状态
	 */
	@Column(name = "DATA_STATE")
	private String dataState;

	/**
	 * 部门路径
	 */
	@Column(name = "DEPT_PATH")
	private String deptPath;

	public CityDirectPollutionData() {
	}

	public String getDeptPath() {
		return deptPath;
	}

	public void setDeptPath(String deptPath) {
		this.deptPath = deptPath;
	}

	public String getAuditState() {
		return auditState;
	}

	public void setAuditState(String auditState) {
		this.auditState = auditState;
	}

	public String getDataState() {
		return dataState;
	}

	public void setDataState(String dataState) {
		this.dataState = dataState;
	}

	public String getEntryDepartment() {
		return entryDepartment;
	}

	public void setEntryDepartment(String entryDepartment) {
		this.entryDepartment = entryDepartment;
	}

	public String getDw() {
		return dw;
	}

	public void setDw(String dw) {
		this.dw = dw;
	}

	public String getWrylx() {
		return wrylx;
	}

	public void setWrylx(String wrylx) {
		this.wrylx = wrylx;
	}

	public String getWryzl() {
		return wryzl;
	}

	public void setWryzl(String wryzl) {
		this.wryzl = wryzl;
	}

	public String getMc() {
		return mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	public String getCzwt() {
		return czwt;
	}

	public void setCzwt(String czwt) {
		this.czwt = czwt;
	}

	public String getZgcs() {
		return zgcs;
	}

	public void setZgcs(String zgcs) {
		this.zgcs = zgcs;
	}

	public String getZlxm() {
		return zlxm;
	}

	public void setZlxm(String zlxm) {
		this.zlxm = zlxm;
	}

	public String getWcmb201912() {
		return wcmb201912;
	}

	public void setWcmb201912(String wcmb201912) {
		this.wcmb201912 = wcmb201912;
	}

	public String getWcmb202006() {
		return wcmb202006;
	}

	public void setWcmb202006(String wcmb202006) {
		this.wcmb202006 = wcmb202006;
	}

	public String getWcmb202012() {
		return wcmb202012;
	}

	public void setWcmb202012(String wcmb202012) {
		this.wcmb202012 = wcmb202012;
	}

	public String getSdzrZrdw() {
		return sdzrZrdw;
	}

	public void setSdzrZrdw(String sdzrZrdw) {
		this.sdzrZrdw = sdzrZrdw;
	}

	public String getSdzrdwZrrlxfs() {
		return sdzrdwZrrlxfs;
	}

	public void setSdzrdwZrrlxfs(String sdzrdwZrrlxfs) {
		this.sdzrdwZrrlxfs = sdzrdwZrrlxfs;
	}

	public String getBmzrZrdw() {
		return bmzrZrdw;
	}

	public void setBmzrZrdw(String bmzrZrdw) {
		this.bmzrZrdw = bmzrZrdw;
	}

	public String getBmzrdwZrrlxfs() {
		return bmzrdwZrrlxfs;
	}

	public void setBmzrdwZrrlxfs(String bmzrdwZrrlxfs) {
		this.bmzrdwZrrlxfs = bmzrdwZrrlxfs;
	}

	public String getBmzrPhzrdw() {
		return bmzrPhzrdw;
	}

	public void setBmzrPhzrdw(String bmzrPhzrdw) {
		this.bmzrPhzrdw = bmzrPhzrdw;
	}

	public String getPhzrdwZrrlxfs() {
		return phzrdwZrrlxfs;
	}

	public void setPhzrdwZrrlxfs(String phzrdwZrrlxfs) {
		this.phzrdwZrrlxfs = phzrdwZrrlxfs;
	}

	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	public String getDz() {
		return dz;
	}

	public void setDz(String dz) {
		this.dz = dz;
	}

	public String getJwd() {
		return jwd;
	}

	public void setJwd(String jwd) {
		this.jwd = jwd;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}

	public String getWd() {
		return wd;
	}

	public void setWd(String wd) {
		this.wd = wd;
	}

	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}
}
