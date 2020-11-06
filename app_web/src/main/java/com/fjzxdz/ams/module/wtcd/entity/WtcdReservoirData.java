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
 * 水库数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "WTCD_RESERVOIR_DATA")
public class WtcdReservoirData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 蓄水量  百万立方米 */
	private String W;
	/** 入库时间 */
	private String RKSJ;
	/** 测站编码 */
	@Id
	@Column(name="STCD")
	private String STCD;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 时间 */
	@Id
	private String YMDHM;
	/** 水位  米 */
	private String ZI;
	@JoinColumn(name="STCD", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private WtcdSiteInfo wtcdSiteInfo;
	public WtcdSiteInfo getWtcdSiteInfo() {
		return wtcdSiteInfo;
	}

	public void setWtcdSiteInfo(WtcdSiteInfo wtcdSiteInfo) {
		this.wtcdSiteInfo = wtcdSiteInfo;
	}

	public String getW() {
		return W;
	}

	public void setW(String w) {
		this.W = W;
	}
	public String getRKSJ() {
		return RKSJ;
	}

	public void setRKSJ(String rKSJ) {
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
	public String getYMDHM() {
		return YMDHM;
	}

	public void setYMDHM(String yMDHM) {
		this.YMDHM = YMDHM;
	}
	public String getZI() {
		return ZI;
	}

	public void setZI(String zI) {
		this.ZI = ZI;
	}
	
}


