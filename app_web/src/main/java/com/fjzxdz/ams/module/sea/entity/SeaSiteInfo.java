/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 海洋与渔业点位信息Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "SEA_SITE_INFO")
public class SeaSiteInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 站点编号 */
	@Id
	private String zdbh;
	/** 原站点编号 */
	private String yzdbh;
	/** 站点名称 */
	private String zdmc;
	/** 经度 */
	private Double jd;
	/** 纬度 */
	private Double wd;
	/** 行政区划代码 */
	private Double xzqhbm;
	/** 行政区划名称 */
	private String xzqhmc;
	/** 监测频次 */
	private String jcpc;
	/** 更新时间 */
	private java.util.Date updatetimeRjwa;
	public String getZdbh() {
		return zdbh;
	}
	public void setZdbh(String zdbh) {
		this.zdbh = zdbh;
	}
	public String getYzdbh() {
		return yzdbh;
	}
	public void setYzdbh(String yzdbh) {
		this.yzdbh = yzdbh;
	}
	public String getZdmc() {
		return zdmc;
	}
	public void setZdmc(String zdmc) {
		this.zdmc = zdmc;
	}
	public Double getJd() {
		return jd;
	}
	public void setJd(Double jd) {
		this.jd = jd;
	}
	public Double getWd() {
		return wd;
	}
	public void setWd(Double wd) {
		this.wd = wd;
	}
	public Double getXzqhbm() {
		return xzqhbm;
	}
	public void setXzqhbm(Double xzqhbm) {
		this.xzqhbm = xzqhbm;
	}
	public String getXzqhmc() {
		return xzqhmc;
	}
	public void setXzqhmc(String xzqhmc) {
		this.xzqhmc = xzqhmc;
	}
	public String getJcpc() {
		return jcpc;
	}
	public void setJcpc(String jcpc) {
		this.jcpc = jcpc;
	}
	public java.util.Date getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}
	public void setUpdatetimeRjwa(java.util.Date updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	
	
}


