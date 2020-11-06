/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 入海河流点位信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RIVERS_SITE_INFO")
public class RiversSiteInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	@Id
	private Double POINTCODE;
	/** 行政区编码 */
	private String codeRegion;
	/** 经度 */
	private String LONGITUDE;
	/** 流域名称 */
	private String WSYSTEMNAME;
	/** 行政区名称 */
	private String REGIONNAME;
	/** 流域编码 */
	private String codeWsystem;
	/** 纬度 */
	private String LATITUDE;
	/** 站点名称 */
	private String POINTNAME;
	
	public Double getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(Double pOINTCODE) {
		this.POINTCODE = POINTCODE;
	}
	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}
	public String getLONGITUDE() {
		return LONGITUDE;
	}

	public void setLONGITUDE(String lONGITUDE) {
		this.LONGITUDE = LONGITUDE;
	}
	public String getWSYSTEMNAME() {
		return WSYSTEMNAME;
	}

	public void setWSYSTEMNAME(String wSYSTEMNAME) {
		this.WSYSTEMNAME = WSYSTEMNAME;
	}
	public String getREGIONNAME() {
		return REGIONNAME;
	}

	public void setREGIONNAME(String rEGIONNAME) {
		this.REGIONNAME = REGIONNAME;
	}
	public String getCodeWsystem() {
		return codeWsystem;
	}

	public void setCodeWsystem(String codeWsystem) {
		this.codeWsystem = codeWsystem;
	}
	public String getLATITUDE() {
		return LATITUDE;
	}

	public void setLATITUDE(String lATITUDE) {
		this.LATITUDE = LATITUDE;
	}
	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		this.POINTNAME = POINTNAME;
	}
	
}


