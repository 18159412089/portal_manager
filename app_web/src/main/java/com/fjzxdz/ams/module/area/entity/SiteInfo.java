/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 近岸海域点位信息Entity
 * @author htj
 * @version 2019-02-20
 */
@Entity
@Table(name = "AREA_SITE_INFO")
public class SiteInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 年份 */
	private java.util.Date GXSJ;
	/** 纬度 */
	private Double NF;
	/**  */
	private String XZQH;
	/**  */
	private String KDMC;
	/**  */
	private Double WD;
	/** 经度 */
	private Double JD;
	/** 国控点位编码 */
	private String GKBM;
	/** 省控点位编码 */
	@Id
	private String SKBM;
	/**  */
	private String GW;
	/**  */
	private String ZT;
	
	public java.util.Date getGXSJ() {
		return GXSJ;
	}

	public void setGXSJ(java.util.Date gXSJ) {
		this.GXSJ = GXSJ;
	}
	public Double getNF() {
		return NF;
	}

	public void setNF(Double nF) {
		this.NF = NF;
	}
	public String getXZQH() {
		return XZQH;
	}

	public void setXZQH(String xZQH) {
		this.XZQH = XZQH;
	}
	public String getKDMC() {
		return KDMC;
	}

	public void setKDMC(String kDMC) {
		this.KDMC = KDMC;
	}
	public Double getWD() {
		return WD;
	}

	public void setWD(Double wD) {
		this.WD = WD;
	}
	public Double getJD() {
		return JD;
	}

	public void setJD(Double jD) {
		this.JD = JD;
	}
	public String getGKBM() {
		return GKBM;
	}

	public void setGKBM(String gKBM) {
		this.GKBM = GKBM;
	}
	public String getSKBM() {
		return SKBM;
	}

	public void setSKBM(String sKBM) {
		this.SKBM = SKBM;
	}
	public String getGW() {
		return GW;
	}

	public void setGW(String gW) {
		this.GW = GW;
	}
	public String getZT() {
		return ZT;
	}

	public void setZT(String zT) {
		this.ZT = ZT;
	}
	
}


