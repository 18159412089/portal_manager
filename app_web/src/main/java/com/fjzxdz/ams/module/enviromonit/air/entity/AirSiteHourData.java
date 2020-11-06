/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.air.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * 空气站点气象小时数据Entity 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:59:15
 */
@Entity
@Table(name = "AIR_SITE_HOUR_DATA")
public class AirSiteHourData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 风向 */
	private String WINDDIRT;
	/** 区县 */
	private String AREANAME;
	/** 状态 */
	private String STATE;
	/** 降雨量 */
	private String RAINFALL;
	/** 行政区划 */
	private String POSCODE;
	/** 风速 */
	private String WINDSPD;
	/** 点位代码 */
	@Id
	private String POTCODE;
	/** 所属地市 */
	private String SAREANAME;
	/** 温度 */
	private String TEMP;
	/** 气压 */
	private String PRESSURE;
	/** 点位名称 */
	private String POTNAME;
	/** 湿度 */
	private String HUMI;
	/** 监测时间 */
	@Id
	private java.util.Date CHECKTIME;
	public String getWINDDIRT() {
		return WINDDIRT;
	}
	public void setWINDDIRT(String wINDDIRT) {
		WINDDIRT = wINDDIRT;
	}
	public String getAREANAME() {
		return AREANAME;
	}
	public void setAREANAME(String aREANAME) {
		AREANAME = aREANAME;
	}
	public String getSTATE() {
		return STATE;
	}
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	public String getRAINFALL() {
		return RAINFALL;
	}
	public void setRAINFALL(String rAINFALL) {
		RAINFALL = rAINFALL;
	}
	public String getPOSCODE() {
		return POSCODE;
	}
	public void setPOSCODE(String pOSCODE) {
		POSCODE = pOSCODE;
	}
	public String getWINDSPD() {
		return WINDSPD;
	}
	public void setWINDSPD(String wINDSPD) {
		WINDSPD = wINDSPD;
	}
	public String getPOTCODE() {
		return POTCODE;
	}
	public void setPOTCODE(String pOTCODE) {
		POTCODE = pOTCODE;
	}
	public String getSAREANAME() {
		return SAREANAME;
	}
	public void setSAREANAME(String sAREANAME) {
		SAREANAME = sAREANAME;
	}
	public String getTEMP() {
		return TEMP;
	}
	public void setTEMP(String tEMP) {
		TEMP = tEMP;
	}
	public String getPRESSURE() {
		return PRESSURE;
	}
	public void setPRESSURE(String pRESSURE) {
		PRESSURE = pRESSURE;
	}
	public String getPOTNAME() {
		return POTNAME;
	}
	public void setPOTNAME(String pOTNAME) {
		POTNAME = pOTNAME;
	}
	public String getHUMI() {
		return HUMI;
	}
	public void setHUMI(String hUMI) {
		HUMI = hUMI;
	}
	public java.util.Date getCHECKTIME() {
		return CHECKTIME;
	}
	public void setCHECKTIME(java.util.Date cHECKTIME) {
		CHECKTIME = cHECKTIME;
	}
	
	
	
}


