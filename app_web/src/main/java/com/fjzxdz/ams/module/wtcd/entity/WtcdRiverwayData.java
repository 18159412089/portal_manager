/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 河道数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "WTCD_RIVERWAY_DATA")
public class WtcdRiverwayData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 流量   立方米 */
	private Double Q;
	/** 入库时间 */
	private java.util.Date RKSJ;
	/** 测站编码 */
	@Id
	@Column(name="STCD")
	private String STCD;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 时间 */
	@Id
	private java.util.Date YMDHM;
	/** 水位  米 */
	private Double ZR;
	
	@JoinColumn(name="STCD", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private WtcdSiteInfo wtcdSiteInfo;
	
	public WtcdSiteInfo getWtcdSiteInfo() {
		return wtcdSiteInfo;
	}

	public void setWtcdSiteInfo(WtcdSiteInfo wtcdSiteInfo) {
		this.wtcdSiteInfo = wtcdSiteInfo;
	}

	public Double getQ() {
		return Q;
	}

	public void setQ(Double q) {
		this.Q = Q;
	}
	public java.util.Date getRKSJ() {
		return RKSJ;
	}

	public void setRKSJ(java.util.Date rKSJ) {
		this.RKSJ = RKSJ;
	}
	public String getSTCD() {
		return STCD;
	}

	public void setSTCD(String sTCD) {
		this.STCD = STCD;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public java.util.Date getYMDHM() {
		return YMDHM;
	}

	public void setYMDHM(java.util.Date yMDHM) {
		this.YMDHM = YMDHM;
	}
	public Double getZR() {
		return ZR;
	}

	public void setZR(Double zR) {
		this.ZR = ZR;
	}
	
}


