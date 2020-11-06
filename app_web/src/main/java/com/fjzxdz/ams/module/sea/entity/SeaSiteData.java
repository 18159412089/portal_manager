/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 省海洋与渔业厅数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "SEA_SITE_DATA")
public class SeaSiteData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 湿度 */
	private Double SD;
	/** 叶绿素 */
	private String YLS;
	/** 磷酸盐浓度 */
	private String PSYND;
	/** 雨量_ENC */
	private Double rhEnc;
	/**  */
	private Double wdEdc;
	/** 溶解氧 */
	private String LJY;
	/** 盐度 千分 */
	private String YD;
	/** 风向 */
	private Double FX;
	/** 导电率mmho/cm */
	private String DDL;
	/**  */
	private String ZD;
	/** 站点编号 */
	@Id
	private String ZDBH;
	/** 硝酸盐浓度 */
	private String XSYND;
	/** 气温 */
	private Double QW;
	/** 风速 */
	private Double FS;
	/** 站点名称 */
	private String ZDMC;
	/** 溶解氧饱和度mg/l */
	private String LJYBHD;
	/** PH */
	private String PH;
	/** 亚硝酸盐浓度 */
	private String YXSYND;
	/** 水温 */
	private Double SW;
	/**  */
	private Double BCSD;
	/** 采样时间 */
	@Id
	private String JCSJ;
	/** 气压 */
	private Double QY;
	/** 表层盐度 */
	private String BCYD;
	/**  */
	private java.util.Date updatetimeRjw;
	/**  */
	private java.util.Date RKSJ;
	
	public Double getSD() {
		return SD;
	}

	public void setSD(Double sD) {
		this.SD = SD;
	}
	public String getYLS() {
		return YLS;
	}

	public void setYLS(String yLS) {
		this.YLS = YLS;
	}
	public String getPSYND() {
		return PSYND;
	}

	public void setPSYND(String pSYND) {
		this.PSYND = PSYND;
	}
	public Double getRhEnc() {
		return rhEnc;
	}

	public void setRhEnc(Double rhEnc) {
		this.rhEnc = rhEnc;
	}
	public Double getWdEdc() {
		return wdEdc;
	}

	public void setWdEdc(Double wdEdc) {
		this.wdEdc = wdEdc;
	}
	public String getLJY() {
		return LJY;
	}

	public void setLJY(String lJY) {
		this.LJY = LJY;
	}
	public String getYD() {
		return YD;
	}

	public void setYD(String yD) {
		this.YD = YD;
	}
	public Double getFX() {
		return FX;
	}

	public void setFX(Double fX) {
		this.FX = FX;
	}
	public String getDDL() {
		return DDL;
	}

	public void setDDL(String dDL) {
		this.DDL = DDL;
	}
	public String getZD() {
		return ZD;
	}

	public void setZD(String zD) {
		this.ZD = ZD;
	}
	public String getZDBH() {
		return ZDBH;
	}

	public void setZDBH(String zDBH) {
		this.ZDBH = ZDBH;
	}
	public String getXSYND() {
		return XSYND;
	}

	public void setXSYND(String xSYND) {
		this.XSYND = XSYND;
	}
	public Double getQW() {
		return QW;
	}

	public void setQW(Double qW) {
		this.QW = QW;
	}
	public Double getFS() {
		return FS;
	}

	public void setFS(Double fS) {
		this.FS = FS;
	}
	public String getZDMC() {
		return ZDMC;
	}

	public void setZDMC(String zDMC) {
		this.ZDMC = ZDMC;
	}
	public String getLJYBHD() {
		return LJYBHD;
	}

	public void setLJYBHD(String lJYBHD) {
		this.LJYBHD = LJYBHD;
	}
	public String getPH() {
		return PH;
	}

	public void setPH(String pH) {
		this.PH = PH;
	}
	public String getYXSYND() {
		return YXSYND;
	}

	public void setYXSYND(String yXSYND) {
		this.YXSYND = YXSYND;
	}
	public Double getSW() {
		return SW;
	}

	public void setSW(Double sW) {
		this.SW = SW;
	}
	public Double getBCSD() {
		return BCSD;
	}

	public void setBCSD(Double bCSD) {
		this.BCSD = BCSD;
	}
	public String getJCSJ() {
		return JCSJ;
	}

	public void setJCSJ(String jCSJ) {
		this.JCSJ = JCSJ;
	}
	public Double getQY() {
		return QY;
	}

	public void setQY(Double qY) {
		this.QY = QY;
	}
	public String getBCYD() {
		return BCYD;
	}

	public void setBCYD(String bCYD) {
		this.BCYD = BCYD;
	}
	public java.util.Date getUpdatetimeRjw() {
		return updatetimeRjw;
	}

	public void setUpdatetimeRjw(java.util.Date updatetimeRjw) {
		this.updatetimeRjw = updatetimeRjw;
	}
	public java.util.Date getRKSJ() {
		return RKSJ;
	}

	public void setRKSJ(java.util.Date rKSJ) {
		this.RKSJ = RKSJ;
	}
	
}


