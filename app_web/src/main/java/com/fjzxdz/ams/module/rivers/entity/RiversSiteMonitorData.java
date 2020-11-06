/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 入海河流监测数据Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RIVERS_SITE_MONITOR_DATA")
public class RiversSiteMonitorData implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	@Id
	private String POINTCODE;
	/** 污染物名称 */
	@Id
	private String POLLUTENAME;
	/** 污染物编码 */
	private String codePollute;
	/** 监测时间 */
	@Id
	private String MONITORTIME;
	/** 污染物浓度 */
	private String POLLUTEVALUE;
	/** 站点名称 */
	private String POINTNAME;
	
	public String getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(String pOINTCODE) {
		this.POINTCODE = POINTCODE;
	}
	public String getPOLLUTENAME() {
		return POLLUTENAME;
	}

	public void setPOLLUTENAME(String pOLLUTENAME) {
		this.POLLUTENAME = POLLUTENAME;
	}
	public String getCodePollute() {
		return codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}
	public String getMONITORTIME() {
		return MONITORTIME;
	}

	public void setMONITORTIME(String mONITORTIME) {
		this.MONITORTIME = MONITORTIME;
	}
	public String getPOLLUTEVALUE() {
		return POLLUTEVALUE;
	}

	public void setPOLLUTEVALUE(String pOLLUTEVALUE) {
		this.POLLUTEVALUE = POLLUTEVALUE;
	}
	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		this.POINTNAME = POINTNAME;
	}
	
}


