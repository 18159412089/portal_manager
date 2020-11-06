/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fjzxdz.ams.module.wtcd.entity.WtcdRiverwayData;

/**
 * 风险源基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RISK_BASE_INFO")
public class RiskBaseInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 是否编制风险评估报告：是、否 */
	private String fkIsriskreport;
	/** 是否有突发环境事件应急预案：是、否 */
	private String fkIsplan;
	/** 行业类别 */
	private String fkTrade;
	/** 企业ID */
	@Id
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
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "riskBaseInfo")
	private Set<RiskBaseUnitInfo> riskBaseUnitInfoSet  = new HashSet<RiskBaseUnitInfo>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "riskBaseInfo")
	private Set<RiskProductAccessData> riskProductAccessDataSet  = new HashSet<RiskProductAccessData>();
	public Set<RiskBaseUnitInfo> getRiskBaseUnitInfoSet() {
		return riskBaseUnitInfoSet;
	}

	public void setRiskBaseUnitInfoSet(Set<RiskBaseUnitInfo> riskBaseUnitInfoSet) {
		this.riskBaseUnitInfoSet = riskBaseUnitInfoSet;
	}

	public Set<RiskProductAccessData> getRiskProductAccessDataSet() {
		return riskProductAccessDataSet;
	}

	public void setRiskProductAccessDataSet(Set<RiskProductAccessData> riskProductAccessDataSet) {
		this.riskProductAccessDataSet = riskProductAccessDataSet;
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
		this.GUID = GUID;
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
		this.EMERGENCYEVENTSCOUNT = EMERGENCYEVENTSCOUNT;
	}
	public Double getLATITUDE() {
		return LATITUDE;
	}

	public void setLATITUDE(Double lATITUDE) {
		this.LATITUDE = LATITUDE;
	}
	public java.util.Date getAPPROVALTIME() {
		return APPROVALTIME;
	}

	public void setAPPROVALTIME(java.util.Date aPPROVALTIME) {
		this.APPROVALTIME = APPROVALTIME;
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
		this.INTRODUCTION = INTRODUCTION;
	}
	public String getENTERADDRESS() {
		return ENTERADDRESS;
	}

	public void setENTERADDRESS(String eNTERADDRESS) {
		this.ENTERADDRESS = ENTERADDRESS;
	}
	public String getENTERNAME() {
		return ENTERNAME;
	}

	public void setENTERNAME(String eNTERNAME) {
		this.ENTERNAME = ENTERNAME;
	}
	public String getCREATEYEAR() {
		return CREATEYEAR;
	}

	public void setCREATEYEAR(String cREATEYEAR) {
		this.CREATEYEAR = CREATEYEAR;
	}
	public String getAPPROVALDOCUMENTNUMBER() {
		return APPROVALDOCUMENTNUMBER;
	}

	public void setAPPROVALDOCUMENTNUMBER(String aPPROVALDOCUMENTNUMBER) {
		this.APPROVALDOCUMENTNUMBER = APPROVALDOCUMENTNUMBER;
	}
	public String getPOSTALADDRESS() {
		return POSTALADDRESS;
	}

	public void setPOSTALADDRESS(String pOSTALADDRESS) {
		this.POSTALADDRESS = POSTALADDRESS;
	}
	public String getAPPROVALDEPARTMENT() {
		return APPROVALDEPARTMENT;
	}

	public void setAPPROVALDEPARTMENT(String aPPROVALDEPARTMENT) {
		this.APPROVALDEPARTMENT = APPROVALDEPARTMENT;
	}
	public String getFAX() {
		return FAX;
	}

	public void setFAX(String fAX) {
		this.FAX = FAX;
	}
	public String getGRAPHICALPLAN() {
		return GRAPHICALPLAN;
	}

	public void setGRAPHICALPLAN(String gRAPHICALPLAN) {
		this.GRAPHICALPLAN = GRAPHICALPLAN;
	}
	public String getREQUESTNUMBER() {
		return REQUESTNUMBER;
	}

	public void setREQUESTNUMBER(String rEQUESTNUMBER) {
		this.REQUESTNUMBER = REQUESTNUMBER;
	}
	public java.util.Date getTHREETIME() {
		return THREETIME;
	}

	public void setTHREETIME(java.util.Date tHREETIME) {
		this.THREETIME = THREETIME;
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
		this.TELEPHONE = TELEPHONE;
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
		this.DUTYCALLS = DUTYCALLS;
	}
	public String getLATEUPYEAR() {
		return LATEUPYEAR;
	}

	public void setLATEUPYEAR(String lATEUPYEAR) {
		this.LATEUPYEAR = LATEUPYEAR;
	}
	public String getTHREEDOCUMENTNUMBER() {
		return THREEDOCUMENTNUMBER;
	}

	public void setTHREEDOCUMENTNUMBER(String tHREEDOCUMENTNUMBER) {
		this.THREEDOCUMENTNUMBER = THREEDOCUMENTNUMBER;
	}
	public String getINDUSTRYAREANAME() {
		return INDUSTRYAREANAME;
	}

	public void setINDUSTRYAREANAME(String iNDUSTRYAREANAME) {
		this.INDUSTRYAREANAME = INDUSTRYAREANAME;
	}
	public String getCORPNAME() {
		return CORPNAME;
	}

	public void setCORPNAME(String cORPNAME) {
		this.CORPNAME = CORPNAME;
	}
	public String getEMERGENCYTRAINING() {
		return EMERGENCYTRAINING;
	}

	public void setEMERGENCYTRAINING(String eMERGENCYTRAINING) {
		this.EMERGENCYTRAINING = EMERGENCYTRAINING;
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
		this.FLOORSPACE = FLOORSPACE;
	}
	public String getTHREEDEPARTMENT() {
		return THREEDEPARTMENT;
	}

	public void setTHREEDEPARTMENT(String tHREEDEPARTMENT) {
		this.THREEDEPARTMENT = THREEDEPARTMENT;
	}
	public Double getLONGITUDE() {
		return LONGITUDE;
	}

	public void setLONGITUDE(Double lONGITUDE) {
		this.LONGITUDE = LONGITUDE;
	}
	public java.util.Date getSUBMITTEDTIME() {
		return SUBMITTEDTIME;
	}

	public void setSUBMITTEDTIME(java.util.Date sUBMITTEDTIME) {
		this.SUBMITTEDTIME = SUBMITTEDTIME;
	}
	public String getEMERGENCYDRILLS() {
		return EMERGENCYDRILLS;
	}

	public void setEMERGENCYDRILLS(String eMERGENCYDRILLS) {
		this.EMERGENCYDRILLS = EMERGENCYDRILLS;
	}
	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}

	public void setUPDATETIME(java.util.Date uPDATETIME) {
		this.UPDATETIME = UPDATETIME;
	}
	
}


