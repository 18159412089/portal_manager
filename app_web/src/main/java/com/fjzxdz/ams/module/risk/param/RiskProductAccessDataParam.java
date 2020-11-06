/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.param;

import com.fjzxdz.ams.module.risk.entity.RiskProductAccessData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 产品及辅料基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiskProductAccessDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 产品名称 */
	private String PRODUCTSNAME;
	/** 企业GUID */
	private String GUID;
	/** 实际年生产量（吨）：该产品上一年实际年产量 */
	private String ACTUALLYPRODUCE;
	/** 设计年产量（吨） */
	private Double DESIGNCAPACITY;
	/** CAS号 */
	private String CAS;
	/** 唯一标识 */
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
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiskProductAccessDataParam() {
		super(RiskProductAccessData.class);
		this.clazz = RiskProductAccessData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("PRODUCTSNAME", getPRODUCTSNAME(), SearchCondition.LIKE);
		addClause("GUID", getGUID(), SearchCondition.LIKE);
		addClause("ACTUALLYPRODUCE", getACTUALLYPRODUCE(), SearchCondition.LIKE);
		addClause("DESIGNCAPACITY", getDESIGNCAPACITY(), SearchCondition.LIKE);
		addClause("CAS", getCAS(), SearchCondition.LIKE);
		addClause("ID", getID(), SearchCondition.LIKE);
		addClause("MATERIALSNAME", getMATERIALSNAME(), SearchCondition.LIKE);
		addClause("SUBMITTEDTIME", getSUBMITTEDTIME(), SearchCondition.LIKE);
		addClause("fkTransportmode", getFkTransportmode(), SearchCondition.LIKE);
		addClause("UPDATETIME", getUPDATETIME(), SearchCondition.LIKE);
		addClause("CONSUMPTION", getCONSUMPTION(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME desc");
	}

	public String getPRODUCTSNAME() {
		return PRODUCTSNAME;
	}

	public void setPRODUCTSNAME(String pRODUCTSNAME) {
		PRODUCTSNAME = pRODUCTSNAME;
	}

	public String getGUID() {
		return GUID;
	}

	public void setGUID(String gUID) {
		GUID = gUID;
	}

	public String getACTUALLYPRODUCE() {
		return ACTUALLYPRODUCE;
	}

	public void setACTUALLYPRODUCE(String aCTUALLYPRODUCE) {
		ACTUALLYPRODUCE = aCTUALLYPRODUCE;
	}

	public Double getDESIGNCAPACITY() {
		return DESIGNCAPACITY;
	}

	public void setDESIGNCAPACITY(Double dESIGNCAPACITY) {
		DESIGNCAPACITY = dESIGNCAPACITY;
	}

	public String getCAS() {
		return CAS;
	}

	public void setCAS(String cAS) {
		CAS = cAS;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getMATERIALSNAME() {
		return MATERIALSNAME;
	}

	public void setMATERIALSNAME(String mATERIALSNAME) {
		MATERIALSNAME = mATERIALSNAME;
	}

	public java.util.Date getSUBMITTEDTIME() {
		return SUBMITTEDTIME;
	}

	public void setSUBMITTEDTIME(java.util.Date sUBMITTEDTIME) {
		SUBMITTEDTIME = sUBMITTEDTIME;
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
		UPDATETIME = uPDATETIME;
	}

	public Double getCONSUMPTION() {
		return CONSUMPTION;
	}

	public void setCONSUMPTION(Double cONSUMPTION) {
		CONSUMPTION = cONSUMPTION;
	}
 
	
}


