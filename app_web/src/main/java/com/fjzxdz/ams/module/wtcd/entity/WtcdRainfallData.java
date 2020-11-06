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
 * 实时雨量数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "WTCD_RAINFALL_DATA")
public class WtcdRainfallData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/**  */
	private java.util.Date RKSJ;
	/** 测站编码 */
	@Id
	@Column(name="STCD")
	private String STCD;
	/**  */
	private String updatetimeRjwa;
	/**  */
	private String DTRN;
	/**  */
	@Id
	private java.util.Date YMDHM;
	@JoinColumn(name="STCD", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private WtcdSiteInfo wtcdSiteInfo;
	public WtcdSiteInfo getWtcdSiteInfo() {
		return wtcdSiteInfo;
	}

	public void setWtcdSiteInfo(WtcdSiteInfo wtcdSiteInfo) {
		this.wtcdSiteInfo = wtcdSiteInfo;
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
	public String getDTRN() {
		return DTRN;
	}

	public void setDTRN(String dTRN) {
		this.DTRN = DTRN;
	}
	public java.util.Date getYMDHM() {
		return YMDHM;
	}

	public void setYMDHM(java.util.Date yMDHM) {
		this.YMDHM = YMDHM;
	}
	
}


