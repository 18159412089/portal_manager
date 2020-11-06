package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;


public class WtptWastewaterOutlet implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * 排污口名称
	 */
	private String pwkmc;

	/**
	 * 企业地理经度(度)
	 */
	private BigDecimal longitude1;

	/**
	 * 企业地理经度(分)
	 */
	private BigDecimal longitude2;

	/**
	 * 企业地理经度(秒)
	 */
	private BigDecimal longitude3;

	/**
	 * 企业地理纬度(度)
	 */
	private BigDecimal latitude1;

	/**
	 * 企业地理纬度(分)
	 */
	private BigDecimal latitude2;

	/**
	 * 企业地理纬度(秒)
	 */
	private BigDecimal latitude3;

	/**
	 * 排污口类型(其他)
	 */
	private String pwklx;

	/**
	 * 入河(海)方式
	 */
	private String rhfs;

	/**
	 * 受纳水体名称
	 */
	private String snstmc;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPwkmc() {
		return pwkmc;
	}

	public void setPwkmc(String pwkmc) {
		this.pwkmc = pwkmc;
	}

	public BigDecimal getLongitude1() {
		return longitude1;
	}

	public void setLongitude1(BigDecimal longitude1) {
		this.longitude1 = longitude1;
	}

	public BigDecimal getLongitude2() {
		return longitude2;
	}

	public void setLongitude2(BigDecimal longitude2) {
		this.longitude2 = longitude2;
	}

	public BigDecimal getLongitude3() {
		return longitude3;
	}

	public void setLongitude3(BigDecimal longitude3) {
		this.longitude3 = longitude3;
	}

	public BigDecimal getLatitude1() {
		return latitude1;
	}

	public void setLatitude1(BigDecimal latitude1) {
		this.latitude1 = latitude1;
	}

	public BigDecimal getLatitude2() {
		return latitude2;
	}

	public void setLatitude2(BigDecimal latitude2) {
		this.latitude2 = latitude2;
	}

	public BigDecimal getLatitude3() {
		return latitude3;
	}

	public void setLatitude3(BigDecimal latitude3) {
		this.latitude3 = latitude3;
	}

	public String getPwklx() {
		return pwklx;
	}

	public void setPwklx(String pwklx) {
		this.pwklx = pwklx;
	}

	public String getRhfs() {
		return rhfs;
	}

	public void setRhfs(String rhfs) {
		this.rhfs = rhfs;
	}

	public String getSnstmc() {
		return snstmc;
	}

	public void setSnstmc(String snstmc) {
		this.snstmc = snstmc;
	}

	public WtptWastewaterOutlet() {
	}
}