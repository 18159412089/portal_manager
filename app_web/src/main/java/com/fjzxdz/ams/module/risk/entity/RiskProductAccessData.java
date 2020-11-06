/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 产品及辅料基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RISK_PRODUCT_ACCESSORIES_DATA")
public class RiskProductAccessData implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 产品名称 */
	private String PRODUCTSNAME;
	/** 企业GUID */
	@Column(name="GUID")
	private String GUID;
	/** 实际年生产量（吨）：该产品上一年实际年产量 */
	private String ACTUALLYPRODUCE;
	/** 设计年产量（吨） */
	private Double DESIGNCAPACITY;
	/** CAS号 */
	private String CAS;
	/** 唯一标识 */
	@Id
	private String ID;
	/** 原辅料名称 */
	private String MATERIALSNAME;
	/** 申请时间 */
	private java.util.Date SUBMITTEDTIME;
	/** 运输方式：铁路运输；公路运输；水上运输；航空运输；管道运输 */
	private String fkTransportmode;
	/** 更新时间 */
	private java.util.Date UPDATETIME;
	/** 原辅料年贮存量（吨）：该原辅料上一年实际年贮存量 */
	private Double CONSUMPTION;
	@JoinColumn(name="GUID", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private RiskBaseInfo riskBaseInfo;
	public RiskBaseInfo getRiskBaseInfo() {
		return riskBaseInfo;
	}

	public void setRiskBaseInfo(RiskBaseInfo riskBaseInfo) {
		this.riskBaseInfo = riskBaseInfo;
	}

	public String getPRODUCTSNAME() {
		return PRODUCTSNAME;
	}

	public void setPRODUCTSNAME(String pRODUCTSNAME) {
		this.PRODUCTSNAME = PRODUCTSNAME;
	}
	public String getGUID() {
		return GUID;
	}

	public void setGUID(String gUID) {
		this.GUID = GUID;
	}
	public String getACTUALLYPRODUCE() {
		return ACTUALLYPRODUCE;
	}

	public void setACTUALLYPRODUCE(String aCTUALLYPRODUCE) {
		this.ACTUALLYPRODUCE = ACTUALLYPRODUCE;
	}
	public Double getDESIGNCAPACITY() {
		return DESIGNCAPACITY;
	}

	public void setDESIGNCAPACITY(Double dESIGNCAPACITY) {
		this.DESIGNCAPACITY = DESIGNCAPACITY;
	}
	public String getCAS() {
		return CAS;
	}

	public void setCAS(String cAS) {
		this.CAS = CAS;
	}
	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		this.ID = ID;
	}
	public String getMATERIALSNAME() {
		return MATERIALSNAME;
	}

	public void setMATERIALSNAME(String mATERIALSNAME) {
		this.MATERIALSNAME = MATERIALSNAME;
	}
	public java.util.Date getSUBMITTEDTIME() {
		return SUBMITTEDTIME;
	}

	public void setSUBMITTEDTIME(java.util.Date sUBMITTEDTIME) {
		this.SUBMITTEDTIME = SUBMITTEDTIME;
	}
	public String getFkTransportmode() {
		return fkTransportmode;
	}

	public void setFkTransportmode(String fkTransportmode) {
		this.fkTransportmode = fkTransportmode;
	}
	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}

	public void setUPDATETIME(java.util.Date uPDATETIME) {
		this.UPDATETIME = UPDATETIME;
	}
	public Double getCONSUMPTION() {
		return CONSUMPTION;
	}

	public void setCONSUMPTION(Double cONSUMPTION) {
		this.CONSUMPTION = CONSUMPTION;
	}
	
}


