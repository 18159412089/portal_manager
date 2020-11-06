package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;


public class WtptWastewaterPlant implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * 单位详细名称
	 */
	private String dwmc;

	/**
	 * 详细地址_县(区、市、旗)
	 */
	private String qx;

	/**
	 * 详细地址_乡(镇)
	 */
	private String xz;

	/**
	 * 详细地址_街(村)、门牌号
	 */
	private String jd;

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
	 * 联系方式_联系人
	 */
	private String lxr;

	/**
	 * 联系方式_联系电话
	 */
	private String lxdh;

	/**
	 * 排水去向类型
	 */
	private String psqxlx;

	/**
	 * 受纳水体-名称
	 */
	private String snstmc;

	/**
	 * 是否安装在线监测-出口
	 */
	private String sfazzxjxCk;

	/**
	 * 污水实际处理量(万立方米)
	 */
	private String wssjcll;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	
	public String getUuid() {
		return uuid;
	}

	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getDwmc() {
		return dwmc;
	}

	public void setDwmc(String dwmc) {
		this.dwmc = dwmc;
	}

	public String getQx() {
		return qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}

	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
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

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getPsqxlx() {
		return psqxlx;
	}

	public void setPsqxlx(String psqxlx) {
		this.psqxlx = psqxlx;
	}

	public String getSnstmc() {
		return snstmc;
	}

	public void setSnstmc(String snstmc) {
		this.snstmc = snstmc;
	}

	public String getSfazzxjxCk() {
		return sfazzxjxCk;
	}

	public void setSfazzxjxCk(String sfazzxjxCk) {
		this.sfazzxjxCk = sfazzxjxCk;
	}

	public String getWssjcll() {
		return wssjcll;
	}

	public void setWssjcll(String wssjcll) {
		this.wssjcll = wssjcll;
	}

	public WtptWastewaterPlant() {
	}
}