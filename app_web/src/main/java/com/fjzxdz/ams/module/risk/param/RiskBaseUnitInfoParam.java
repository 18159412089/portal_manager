/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.param;

import com.fjzxdz.ams.module.risk.entity.RiskBaseUnitInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 风险单元基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiskBaseUnitInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 企业ID */
	private String GUID;
	/** 风险特征其他 */
	private String RISKCHARACTERISTICSOTHER;
	/** 泄漏气体紧急处置装置 */
	private String EMERGENCYDEVICE;
	/** 是否有污水排放口监控及关闭设施 */
	private String fkIsfacilities;
	/** 防渗具体措施：若有，注明材料名称，如高密度聚乙烯防渗膜、低密度聚乙烯防渗膜、线性低密度聚乙烯防渗膜、土工布等。 */
	private String SEEPAGECONTROLMEASURES;
	/** 风险特征化学物质易泄露 */
	private String RISKCHARACTERISTICSLEAKAGE;
	/** 是否有事故应急池：有，无 */
	private String fkIsalarmpool;
	/** 贮存方式 */
	private String fkStoremode;
	/** 主要化学物质年现存量（吨） */
	private Double CHEMISTRYCONTENT;
	/** 风险单元名称 */
	private String DISCHARGEPORTNAME;
	/** 风险特征反应条件高温高压 */
	private String RISKCHARACTERISTICSTEMPERATURE;
	/** 唯一标识 */
	private Long ID;
	/** 是否有清污分流切换阀门：有，无 */
	private String fkIsswitch;
	/** 事故应急池容积（立方米） */
	private Double ALARMPOOLSIZE;
	/** 是否有清净下水排放缓冲池或雨水收集池 */
	private String fkIsclean;
	/** 事故应急池是否是自流式 */
	private String WHETHERTHESCOOP;
	/** 风险特征毒性 */
	private String RISKCHARACTERISTICSPOISON;
	/** 是否有泄露报警装置：是否在有毒有害、易燃易爆气体贮存区、使用点等处设置气体泄漏探测器，探测有毒有害、可燃气体的泄漏，当气体泄漏达到报警浓度时，气体监视系统发出声光报警信号。 */
	private String fkIsalarmdevice;
	/** 事故应急池配套导流管网是否健全 */
	private String fkIswhethernetworksound;
	/** 是否有地面防渗材料：在风险单元区域内是否铺设防渗材料。有，无 */
	private String fkIsleakage;
	/** 围堰高度（米） */
	private Double COFFERDAMHEIGHT;
	/** 围堰有效容积（立方米） */
	private Double COFFERDAMSIZE;
	/** 是否接入远程监控网：厂内的气/液体泄漏侦测、报警系统接入何级环保部门的远程监控网络系统联网，并给出联网终端名称、级别。 */
	private String fkIscontrol;
	/** 事故废水排放去向：1、进入厂区的污水处理系统；2、进入事故应急池；3、进入清净下水系统或雨水排水系统；4 其他 */
	private String fkDischarge;
	/** 风险特征易燃易爆 */
	private String RISKCHARACTERISTICSEXPLOSIVE;
	/** 远程监控网说明 */
	private String CONTROLREMARKS;
	/** 主要化学物质单日最大贮存量（吨） */
	private Double CHEMISTRYMAX;
	/** 是否由雨污分流切换阀 */
	private String fkIsrainshuntswitchvalve;
	/** 风险单元类型：罐区、装置区、其他设施 */
	private String fkDischargeporttype;
	/** 雨水收集池配套导流管网是否健全 */
	private String fkIssane;
	/** 雨水收集池容积（立方米） */
	private Double CUSHIONPOOLSIZE;
	/** 是否有围堰：有，无 */
	private String fkIscofferdam;
	/** 提交时间 */
	private java.util.Date SUBMITTEDTIME;
	/** 是否有有毒有害气体 */
	private String fkIspoisonousgases;
	/** 更新时间 */
	private java.util.Date UPDATETIME;
	/** 主要化学物质名称 */
	private String CHEMISTRYNAME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiskBaseUnitInfoParam() {
		super(RiskBaseUnitInfo.class);
		this.clazz = RiskBaseUnitInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("GUID", getGUID(), SearchCondition.LIKE);
		addClause("RISKCHARACTERISTICSOTHER", getRISKCHARACTERISTICSOTHER(), SearchCondition.LIKE);
		addClause("EMERGENCYDEVICE", getEMERGENCYDEVICE(), SearchCondition.LIKE);
		addClause("fkIsfacilities", getFkIsfacilities(), SearchCondition.LIKE);
		addClause("SEEPAGECONTROLMEASURES", getSEEPAGECONTROLMEASURES(), SearchCondition.LIKE);
		addClause("RISKCHARACTERISTICSLEAKAGE", getRISKCHARACTERISTICSLEAKAGE(), SearchCondition.LIKE);
		addClause("fkIsalarmpool", getFkIsalarmpool(), SearchCondition.LIKE);
		addClause("fkStoremode", getFkStoremode(), SearchCondition.LIKE);
		addClause("CHEMISTRYCONTENT", getCHEMISTRYCONTENT(), SearchCondition.LIKE);
		addClause("DISCHARGEPORTNAME", getDISCHARGEPORTNAME(), SearchCondition.LIKE);
		addClause("RISKCHARACTERISTICSTEMPERATURE", getRISKCHARACTERISTICSTEMPERATURE(), SearchCondition.LIKE);
		addClause("ID", getID(), SearchCondition.LIKE);
		addClause("fkIsswitch", getFkIsswitch(), SearchCondition.LIKE);
		addClause("ALARMPOOLSIZE", getALARMPOOLSIZE(), SearchCondition.LIKE);
		addClause("fkIsclean", getFkIsclean(), SearchCondition.LIKE);
		addClause("WHETHERTHESCOOP", getWHETHERTHESCOOP(), SearchCondition.LIKE);
		addClause("RISKCHARACTERISTICSPOISON", getRISKCHARACTERISTICSPOISON(), SearchCondition.LIKE);
		addClause("fkIsalarmdevice", getFkIsalarmdevice(), SearchCondition.LIKE);
		addClause("fkIswhethernetworksound", getFkIswhethernetworksound(), SearchCondition.LIKE);
		addClause("fkIsleakage", getFkIsleakage(), SearchCondition.LIKE);
		addClause("COFFERDAMHEIGHT", getCOFFERDAMHEIGHT(), SearchCondition.LIKE);
		addClause("COFFERDAMSIZE", getCOFFERDAMSIZE(), SearchCondition.LIKE);
		addClause("fkIscontrol", getFkIscontrol(), SearchCondition.LIKE);
		addClause("fkDischarge", getFkDischarge(), SearchCondition.LIKE);
		addClause("RISKCHARACTERISTICSEXPLOSIVE", getRISKCHARACTERISTICSEXPLOSIVE(), SearchCondition.LIKE);
		addClause("CONTROLREMARKS", getCONTROLREMARKS(), SearchCondition.LIKE);
		addClause("CHEMISTRYMAX", getCHEMISTRYMAX(), SearchCondition.LIKE);
		addClause("fkIsrainshuntswitchvalve", getFkIsrainshuntswitchvalve(), SearchCondition.LIKE);
		addClause("fkDischargeporttype", getFkDischargeporttype(), SearchCondition.LIKE);
		addClause("fkIssane", getFkIssane(), SearchCondition.LIKE);
		addClause("CUSHIONPOOLSIZE", getCUSHIONPOOLSIZE(), SearchCondition.LIKE);
		addClause("fkIscofferdam", getFkIscofferdam(), SearchCondition.LIKE);
		addClause("SUBMITTEDTIME", getSUBMITTEDTIME(), SearchCondition.LIKE);
		addClause("fkIspoisonousgases", getFkIspoisonousgases(), SearchCondition.LIKE);
		addClause("UPDATETIME", getUPDATETIME(), SearchCondition.LIKE);
		addClause("CHEMISTRYNAME", getCHEMISTRYNAME(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME desc");
	}

	public String getGUID() {
		return GUID;
	}

	public void setGUID(String gUID) {
		GUID = gUID;
	}

	public String getRISKCHARACTERISTICSOTHER() {
		return RISKCHARACTERISTICSOTHER;
	}

	public void setRISKCHARACTERISTICSOTHER(String rISKCHARACTERISTICSOTHER) {
		RISKCHARACTERISTICSOTHER = rISKCHARACTERISTICSOTHER;
	}

	public String getEMERGENCYDEVICE() {
		return EMERGENCYDEVICE;
	}

	public void setEMERGENCYDEVICE(String eMERGENCYDEVICE) {
		EMERGENCYDEVICE = eMERGENCYDEVICE;
	}

	public String getFkIsfacilities() {
		return fkIsfacilities;
	}

	public void setFkIsfacilities(String fkIsfacilities) {
		this.fkIsfacilities = fkIsfacilities;
	}

	public String getSEEPAGECONTROLMEASURES() {
		return SEEPAGECONTROLMEASURES;
	}

	public void setSEEPAGECONTROLMEASURES(String sEEPAGECONTROLMEASURES) {
		SEEPAGECONTROLMEASURES = sEEPAGECONTROLMEASURES;
	}

	public String getRISKCHARACTERISTICSLEAKAGE() {
		return RISKCHARACTERISTICSLEAKAGE;
	}

	public void setRISKCHARACTERISTICSLEAKAGE(String rISKCHARACTERISTICSLEAKAGE) {
		RISKCHARACTERISTICSLEAKAGE = rISKCHARACTERISTICSLEAKAGE;
	}

	public String getFkIsalarmpool() {
		return fkIsalarmpool;
	}

	public void setFkIsalarmpool(String fkIsalarmpool) {
		this.fkIsalarmpool = fkIsalarmpool;
	}

	public String getFkStoremode() {
		return fkStoremode;
	}

	public void setFkStoremode(String fkStoremode) {
		this.fkStoremode = fkStoremode;
	}

	public Double getCHEMISTRYCONTENT() {
		return CHEMISTRYCONTENT;
	}

	public void setCHEMISTRYCONTENT(Double cHEMISTRYCONTENT) {
		CHEMISTRYCONTENT = cHEMISTRYCONTENT;
	}

	public String getDISCHARGEPORTNAME() {
		return DISCHARGEPORTNAME;
	}

	public void setDISCHARGEPORTNAME(String dISCHARGEPORTNAME) {
		DISCHARGEPORTNAME = dISCHARGEPORTNAME;
	}

	public String getRISKCHARACTERISTICSTEMPERATURE() {
		return RISKCHARACTERISTICSTEMPERATURE;
	}

	public void setRISKCHARACTERISTICSTEMPERATURE(String rISKCHARACTERISTICSTEMPERATURE) {
		RISKCHARACTERISTICSTEMPERATURE = rISKCHARACTERISTICSTEMPERATURE;
	}

	public Long getID() {
		return ID;
	}

	public void setID(Long iD) {
		ID = iD;
	}

	public String getFkIsswitch() {
		return fkIsswitch;
	}

	public void setFkIsswitch(String fkIsswitch) {
		this.fkIsswitch = fkIsswitch;
	}

	public Double getALARMPOOLSIZE() {
		return ALARMPOOLSIZE;
	}

	public void setALARMPOOLSIZE(Double aLARMPOOLSIZE) {
		ALARMPOOLSIZE = aLARMPOOLSIZE;
	}

	public String getFkIsclean() {
		return fkIsclean;
	}

	public void setFkIsclean(String fkIsclean) {
		this.fkIsclean = fkIsclean;
	}

	public String getWHETHERTHESCOOP() {
		return WHETHERTHESCOOP;
	}

	public void setWHETHERTHESCOOP(String wHETHERTHESCOOP) {
		WHETHERTHESCOOP = wHETHERTHESCOOP;
	}

	public String getRISKCHARACTERISTICSPOISON() {
		return RISKCHARACTERISTICSPOISON;
	}

	public void setRISKCHARACTERISTICSPOISON(String rISKCHARACTERISTICSPOISON) {
		RISKCHARACTERISTICSPOISON = rISKCHARACTERISTICSPOISON;
	}

	public String getFkIsalarmdevice() {
		return fkIsalarmdevice;
	}

	public void setFkIsalarmdevice(String fkIsalarmdevice) {
		this.fkIsalarmdevice = fkIsalarmdevice;
	}

	public String getFkIswhethernetworksound() {
		return fkIswhethernetworksound;
	}

	public void setFkIswhethernetworksound(String fkIswhethernetworksound) {
		this.fkIswhethernetworksound = fkIswhethernetworksound;
	}

	public String getFkIsleakage() {
		return fkIsleakage;
	}

	public void setFkIsleakage(String fkIsleakage) {
		this.fkIsleakage = fkIsleakage;
	}

	public Double getCOFFERDAMHEIGHT() {
		return COFFERDAMHEIGHT;
	}

	public void setCOFFERDAMHEIGHT(Double cOFFERDAMHEIGHT) {
		COFFERDAMHEIGHT = cOFFERDAMHEIGHT;
	}

	public Double getCOFFERDAMSIZE() {
		return COFFERDAMSIZE;
	}

	public void setCOFFERDAMSIZE(Double cOFFERDAMSIZE) {
		COFFERDAMSIZE = cOFFERDAMSIZE;
	}

	public String getFkIscontrol() {
		return fkIscontrol;
	}

	public void setFkIscontrol(String fkIscontrol) {
		this.fkIscontrol = fkIscontrol;
	}

	public String getFkDischarge() {
		return fkDischarge;
	}

	public void setFkDischarge(String fkDischarge) {
		this.fkDischarge = fkDischarge;
	}

	public String getRISKCHARACTERISTICSEXPLOSIVE() {
		return RISKCHARACTERISTICSEXPLOSIVE;
	}

	public void setRISKCHARACTERISTICSEXPLOSIVE(String rISKCHARACTERISTICSEXPLOSIVE) {
		RISKCHARACTERISTICSEXPLOSIVE = rISKCHARACTERISTICSEXPLOSIVE;
	}

	public String getCONTROLREMARKS() {
		return CONTROLREMARKS;
	}

	public void setCONTROLREMARKS(String cONTROLREMARKS) {
		CONTROLREMARKS = cONTROLREMARKS;
	}

	public Double getCHEMISTRYMAX() {
		return CHEMISTRYMAX;
	}

	public void setCHEMISTRYMAX(Double cHEMISTRYMAX) {
		CHEMISTRYMAX = cHEMISTRYMAX;
	}

	public String getFkIsrainshuntswitchvalve() {
		return fkIsrainshuntswitchvalve;
	}

	public void setFkIsrainshuntswitchvalve(String fkIsrainshuntswitchvalve) {
		this.fkIsrainshuntswitchvalve = fkIsrainshuntswitchvalve;
	}

	public String getFkDischargeporttype() {
		return fkDischargeporttype;
	}

	public void setFkDischargeporttype(String fkDischargeporttype) {
		this.fkDischargeporttype = fkDischargeporttype;
	}

	public String getFkIssane() {
		return fkIssane;
	}

	public void setFkIssane(String fkIssane) {
		this.fkIssane = fkIssane;
	}

	public Double getCUSHIONPOOLSIZE() {
		return CUSHIONPOOLSIZE;
	}

	public void setCUSHIONPOOLSIZE(Double cUSHIONPOOLSIZE) {
		CUSHIONPOOLSIZE = cUSHIONPOOLSIZE;
	}

	public String getFkIscofferdam() {
		return fkIscofferdam;
	}

	public void setFkIscofferdam(String fkIscofferdam) {
		this.fkIscofferdam = fkIscofferdam;
	}

	public java.util.Date getSUBMITTEDTIME() {
		return SUBMITTEDTIME;
	}

	public void setSUBMITTEDTIME(java.util.Date sUBMITTEDTIME) {
		SUBMITTEDTIME = sUBMITTEDTIME;
	}

	public String getFkIspoisonousgases() {
		return fkIspoisonousgases;
	}

	public void setFkIspoisonousgases(String fkIspoisonousgases) {
		this.fkIspoisonousgases = fkIspoisonousgases;
	}

	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}

	public void setUPDATETIME(java.util.Date uPDATETIME) {
		UPDATETIME = uPDATETIME;
	}

	public String getCHEMISTRYNAME() {
		return CHEMISTRYNAME;
	}

	public void setCHEMISTRYNAME(String cHEMISTRYNAME) {
		CHEMISTRYNAME = cHEMISTRYNAME;
	}
	
	
}


