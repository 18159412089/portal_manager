/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.param;

import com.fjzxdz.ams.module.risk.entity.RiskBaseInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 风险源基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiskBaseInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 是否编制风险评估报告：是、否 */
	private String fkIsriskreport;
	/** 是否有突发环境事件应急预案：是、否 */
	private String fkIsplan;
	/** 行业类别 */
	private String fkTrade;
	/** 企业ID */
	private String GUID;
	/** 行政区划 */
	private String fkRegion;
	/** 关注程度：国控、省控、市控 */
	private String fkAttention;
	/** 历年发生突发环境事件时间、次数 */
	private String EMERGENCYEVENTSCOUNT;
	/** 中心纬度 */
	private Double LATITUDE;
	/** 环评审批时间 */
	private java.util.Date APPROVALTIME;
	/** 组织结构代码 */
	private String fkEntercode;
	/** 是否有突发环境事件应急预案备案：是、否 */
	private String fkIsplanrrcord;
	/** 简介 */
	private String INTRODUCTION;
	/** 地址 */
	private String ENTERADDRESS;
	/** 单位名称 */
	private String ENTERNAME;
	/** 建厂时间（年月） */
	private String CREATEYEAR;
	/** 环评审批文号 */
	private String APPROVALDOCUMENTNUMBER;
	/** 通讯地址 */
	private String POSTALADDRESS;
	/** 环评审批部门 */
	private String APPROVALDEPARTMENT;
	/** 传真号码 */
	private String FAX;
	/** 图形化预案标记（1：有，其他：无） */
	private String GRAPHICALPLAN;
	/** 审核编码 */
	private String REQUESTNUMBER;
	/** “三同时”环保验收时间 */
	private java.util.Date THREETIME;
	/** 环境风险等级：一般、较大、重大 */
	private String fkEnvironmentalrank;
	/** 联系电话 */
	private String TELEPHONE;
	/** 所在工业园区级别：国家级、省级、省级以下 */
	private String fkIndustryarealevel;
	/** 企业值班电话 */
	private String DUTYCALLS;
	/** 最新改扩建时间（年月） */
	private String LATEUPYEAR;
	/** “三同时”环保验收文号 */
	private String THREEDOCUMENTNUMBER;
	/** 所在工业园区名称 */
	private String INDUSTRYAREANAME;
	/** 法人代表 */
	private String CORPNAME;
	/** 环境应急培训情况 */
	private String EMERGENCYTRAINING;
	/** 所属流域 */
	private String fkWsystem;
	/** 厂区面积（m2）。 */
	private Double FLOORSPACE;
	/** “三同时”环保验收部门 */
	private String THREEDEPARTMENT;
	/** 中心经度 */
	private Double LONGITUDE;
	/** 申报时间 */
	private java.util.Date SUBMITTEDTIME;
	/** 环境应急演练情况 */
	private String EMERGENCYDRILLS;
	/** 更新时间 */
	private java.util.Date UPDATETIME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiskBaseInfoParam() {
		super(RiskBaseInfo.class);
		this.clazz = RiskBaseInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("fkIsriskreport", getFkIsriskreport(), SearchCondition.LIKE);
		addClause("fkIsplan", getFkIsplan(), SearchCondition.LIKE);
		addClause("fkTrade", getFkTrade(), SearchCondition.LIKE);
		addClause("GUID", getGUID(), SearchCondition.LIKE);
		addClause("fkRegion", getFkRegion(), SearchCondition.LIKE);
		addClause("fkAttention", getFkAttention(), SearchCondition.LIKE);
		addClause("EMERGENCYEVENTSCOUNT", getEMERGENCYEVENTSCOUNT(), SearchCondition.LIKE);
		addClause("LATITUDE", getLATITUDE(), SearchCondition.LIKE);
		addClause("APPROVALTIME", getAPPROVALTIME(), SearchCondition.LIKE);
		addClause("fkEntercode", getFkEntercode(), SearchCondition.LIKE);
		addClause("fkIsplanrrcord", getFkIsplanrrcord(), SearchCondition.LIKE);
		addClause("INTRODUCTION", getINTRODUCTION(), SearchCondition.LIKE);
		addClause("ENTERADDRESS", getENTERADDRESS(), SearchCondition.LIKE);
		addClause("ENTERNAME", getENTERNAME(), SearchCondition.LIKE);
		addClause("CREATEYEAR", getCREATEYEAR(), SearchCondition.LIKE);
		addClause("APPROVALDOCUMENTNUMBER", getAPPROVALDOCUMENTNUMBER(), SearchCondition.LIKE);
		addClause("POSTALADDRESS", getPOSTALADDRESS(), SearchCondition.LIKE);
		addClause("APPROVALDEPARTMENT", getAPPROVALDEPARTMENT(), SearchCondition.LIKE);
		addClause("FAX", getFAX(), SearchCondition.LIKE);
		addClause("GRAPHICALPLAN", getGRAPHICALPLAN(), SearchCondition.LIKE);
		addClause("REQUESTNUMBER", getREQUESTNUMBER(), SearchCondition.LIKE);
		addClause("THREETIME", getTHREETIME(), SearchCondition.LIKE);
		addClause("fkEnvironmentalrank", getFkEnvironmentalrank(), SearchCondition.LIKE);
		addClause("TELEPHONE", getTELEPHONE(), SearchCondition.LIKE);
		addClause("fkIndustryarealevel", getFkIndustryarealevel(), SearchCondition.LIKE);
		addClause("DUTYCALLS", getDUTYCALLS(), SearchCondition.LIKE);
		addClause("LATEUPYEAR", getLATEUPYEAR(), SearchCondition.LIKE);
		addClause("THREEDOCUMENTNUMBER", getTHREEDOCUMENTNUMBER(), SearchCondition.LIKE);
		addClause("INDUSTRYAREANAME", getINDUSTRYAREANAME(), SearchCondition.LIKE);
		addClause("CORPNAME", getCORPNAME(), SearchCondition.LIKE);
		addClause("EMERGENCYTRAINING", getEMERGENCYTRAINING(), SearchCondition.LIKE);
		addClause("fkWsystem", getFkWsystem(), SearchCondition.LIKE);
		addClause("FLOORSPACE", getFLOORSPACE(), SearchCondition.LIKE);
		addClause("THREEDEPARTMENT", getTHREEDEPARTMENT(), SearchCondition.LIKE);
		addClause("LONGITUDE", getLONGITUDE(), SearchCondition.LIKE);
		addClause("SUBMITTEDTIME", getSUBMITTEDTIME(), SearchCondition.LIKE);
		addClause("EMERGENCYDRILLS", getEMERGENCYDRILLS(), SearchCondition.LIKE);
		addClause("UPDATETIME", getUPDATETIME(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME desc");
	}

	public String getFkIsriskreport() {
		return fkIsriskreport;
	}

	public void setFkIsriskreport(String fkIsriskreport) {
		this.fkIsriskreport = fkIsriskreport;
	}

	public String getFkIsplan() {
		return fkIsplan;
	}

	public void setFkIsplan(String fkIsplan) {
		this.fkIsplan = fkIsplan;
	}

	public String getFkTrade() {
		return fkTrade;
	}

	public void setFkTrade(String fkTrade) {
		this.fkTrade = fkTrade;
	}

	public String getGUID() {
		return GUID;
	}

	public void setGUID(String gUID) {
		GUID = gUID;
	}

	public String getFkRegion() {
		return fkRegion;
	}

	public void setFkRegion(String fkRegion) {
		this.fkRegion = fkRegion;
	}

	public String getFkAttention() {
		return fkAttention;
	}

	public void setFkAttention(String fkAttention) {
		this.fkAttention = fkAttention;
	}

	public String getEMERGENCYEVENTSCOUNT() {
		return EMERGENCYEVENTSCOUNT;
	}

	public void setEMERGENCYEVENTSCOUNT(String eMERGENCYEVENTSCOUNT) {
		EMERGENCYEVENTSCOUNT = eMERGENCYEVENTSCOUNT;
	}

	public Double getLATITUDE() {
		return LATITUDE;
	}

	public void setLATITUDE(Double lATITUDE) {
		LATITUDE = lATITUDE;
	}

	public java.util.Date getAPPROVALTIME() {
		return APPROVALTIME;
	}

	public void setAPPROVALTIME(java.util.Date aPPROVALTIME) {
		APPROVALTIME = aPPROVALTIME;
	}

	public String getFkEntercode() {
		return fkEntercode;
	}

	public void setFkEntercode(String fkEntercode) {
		this.fkEntercode = fkEntercode;
	}

	public String getFkIsplanrrcord() {
		return fkIsplanrrcord;
	}

	public void setFkIsplanrrcord(String fkIsplanrrcord) {
		this.fkIsplanrrcord = fkIsplanrrcord;
	}

	public String getINTRODUCTION() {
		return INTRODUCTION;
	}

	public void setINTRODUCTION(String iNTRODUCTION) {
		INTRODUCTION = iNTRODUCTION;
	}

	public String getENTERADDRESS() {
		return ENTERADDRESS;
	}

	public void setENTERADDRESS(String eNTERADDRESS) {
		ENTERADDRESS = eNTERADDRESS;
	}

	public String getENTERNAME() {
		return ENTERNAME;
	}

	public void setENTERNAME(String eNTERNAME) {
		ENTERNAME = eNTERNAME;
	}

	public String getCREATEYEAR() {
		return CREATEYEAR;
	}

	public void setCREATEYEAR(String cREATEYEAR) {
		CREATEYEAR = cREATEYEAR;
	}

	public String getAPPROVALDOCUMENTNUMBER() {
		return APPROVALDOCUMENTNUMBER;
	}

	public void setAPPROVALDOCUMENTNUMBER(String aPPROVALDOCUMENTNUMBER) {
		APPROVALDOCUMENTNUMBER = aPPROVALDOCUMENTNUMBER;
	}

	public String getPOSTALADDRESS() {
		return POSTALADDRESS;
	}

	public void setPOSTALADDRESS(String pOSTALADDRESS) {
		POSTALADDRESS = pOSTALADDRESS;
	}

	public String getAPPROVALDEPARTMENT() {
		return APPROVALDEPARTMENT;
	}

	public void setAPPROVALDEPARTMENT(String aPPROVALDEPARTMENT) {
		APPROVALDEPARTMENT = aPPROVALDEPARTMENT;
	}

	public String getFAX() {
		return FAX;
	}

	public void setFAX(String fAX) {
		FAX = fAX;
	}

	public String getGRAPHICALPLAN() {
		return GRAPHICALPLAN;
	}

	public void setGRAPHICALPLAN(String gRAPHICALPLAN) {
		GRAPHICALPLAN = gRAPHICALPLAN;
	}

	public String getREQUESTNUMBER() {
		return REQUESTNUMBER;
	}

	public void setREQUESTNUMBER(String rEQUESTNUMBER) {
		REQUESTNUMBER = rEQUESTNUMBER;
	}

	public java.util.Date getTHREETIME() {
		return THREETIME;
	}

	public void setTHREETIME(java.util.Date tHREETIME) {
		THREETIME = tHREETIME;
	}

	public String getFkEnvironmentalrank() {
		return fkEnvironmentalrank;
	}

	public void setFkEnvironmentalrank(String fkEnvironmentalrank) {
		this.fkEnvironmentalrank = fkEnvironmentalrank;
	}

	public String getTELEPHONE() {
		return TELEPHONE;
	}

	public void setTELEPHONE(String tELEPHONE) {
		TELEPHONE = tELEPHONE;
	}

	public String getFkIndustryarealevel() {
		return fkIndustryarealevel;
	}

	public void setFkIndustryarealevel(String fkIndustryarealevel) {
		this.fkIndustryarealevel = fkIndustryarealevel;
	}

	public String getDUTYCALLS() {
		return DUTYCALLS;
	}

	public void setDUTYCALLS(String dUTYCALLS) {
		DUTYCALLS = dUTYCALLS;
	}

	public String getLATEUPYEAR() {
		return LATEUPYEAR;
	}

	public void setLATEUPYEAR(String lATEUPYEAR) {
		LATEUPYEAR = lATEUPYEAR;
	}

	public String getTHREEDOCUMENTNUMBER() {
		return THREEDOCUMENTNUMBER;
	}

	public void setTHREEDOCUMENTNUMBER(String tHREEDOCUMENTNUMBER) {
		THREEDOCUMENTNUMBER = tHREEDOCUMENTNUMBER;
	}

	public String getINDUSTRYAREANAME() {
		return INDUSTRYAREANAME;
	}

	public void setINDUSTRYAREANAME(String iNDUSTRYAREANAME) {
		INDUSTRYAREANAME = iNDUSTRYAREANAME;
	}

	public String getCORPNAME() {
		return CORPNAME;
	}

	public void setCORPNAME(String cORPNAME) {
		CORPNAME = cORPNAME;
	}

	public String getEMERGENCYTRAINING() {
		return EMERGENCYTRAINING;
	}

	public void setEMERGENCYTRAINING(String eMERGENCYTRAINING) {
		EMERGENCYTRAINING = eMERGENCYTRAINING;
	}

	public String getFkWsystem() {
		return fkWsystem;
	}

	public void setFkWsystem(String fkWsystem) {
		this.fkWsystem = fkWsystem;
	}

	public Double getFLOORSPACE() {
		return FLOORSPACE;
	}

	public void setFLOORSPACE(Double fLOORSPACE) {
		FLOORSPACE = fLOORSPACE;
	}

	public String getTHREEDEPARTMENT() {
		return THREEDEPARTMENT;
	}

	public void setTHREEDEPARTMENT(String tHREEDEPARTMENT) {
		THREEDEPARTMENT = tHREEDEPARTMENT;
	}

	public Double getLONGITUDE() {
		return LONGITUDE;
	}

	public void setLONGITUDE(Double lONGITUDE) {
		LONGITUDE = lONGITUDE;
	}

	public java.util.Date getSUBMITTEDTIME() {
		return SUBMITTEDTIME;
	}

	public void setSUBMITTEDTIME(java.util.Date sUBMITTEDTIME) {
		SUBMITTEDTIME = sUBMITTEDTIME;
	}

	public String getEMERGENCYDRILLS() {
		return EMERGENCYDRILLS;
	}

	public void setEMERGENCYDRILLS(String eMERGENCYDRILLS) {
		EMERGENCYDRILLS = eMERGENCYDRILLS;
	}

	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}

	public void setUPDATETIME(java.util.Date uPDATETIME) {
		UPDATETIME = uPDATETIME;
	}
	
	 
}


