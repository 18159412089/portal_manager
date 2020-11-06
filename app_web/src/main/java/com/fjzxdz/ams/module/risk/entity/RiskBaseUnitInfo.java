/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fjzxdz.ams.module.wtcd.entity.WtcdSiteInfo;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;

/**
 * 风险单元基本信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RISK_BASE_UNIT_INFO")
public class RiskBaseUnitInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 企业ID */
	@Column(name="GUID")
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
	@Id
	private String ID;
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

	@JoinColumn(name="GUID", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	@NotFound(action= NotFoundAction.IGNORE)//这样，当子表中没找到数据时，主表中对应的field就是null，而不会报错了
	private RiskBaseInfo riskBaseInfo;
	public RiskBaseInfo getRiskBaseInfo() {
		return riskBaseInfo;
	}

	public void setRiskBaseInfo(RiskBaseInfo riskBaseInfo) {
		this.riskBaseInfo = riskBaseInfo;
	}

	public String getGUID() {
		return GUID;
	}

	public void setGUID(String gUID) {
		this.GUID = GUID;
	}
	public String getRISKCHARACTERISTICSOTHER() {
		return RISKCHARACTERISTICSOTHER;
	}

	public void setRISKCHARACTERISTICSOTHER(String rISKCHARACTERISTICSOTHER) {
		this.RISKCHARACTERISTICSOTHER = RISKCHARACTERISTICSOTHER;
	}
	public String getEMERGENCYDEVICE() {
		return EMERGENCYDEVICE;
	}

	public void setEMERGENCYDEVICE(String eMERGENCYDEVICE) {
		this.EMERGENCYDEVICE = EMERGENCYDEVICE;
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
		this.SEEPAGECONTROLMEASURES = SEEPAGECONTROLMEASURES;
	}
	public String getRISKCHARACTERISTICSLEAKAGE() {
		return RISKCHARACTERISTICSLEAKAGE;
	}

	public void setRISKCHARACTERISTICSLEAKAGE(String rISKCHARACTERISTICSLEAKAGE) {
		this.RISKCHARACTERISTICSLEAKAGE = RISKCHARACTERISTICSLEAKAGE;
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
		this.CHEMISTRYCONTENT = CHEMISTRYCONTENT;
	}
	public String getDISCHARGEPORTNAME() {
		return DISCHARGEPORTNAME;
	}

	public void setDISCHARGEPORTNAME(String dISCHARGEPORTNAME) {
		this.DISCHARGEPORTNAME = DISCHARGEPORTNAME;
	}
	public String getRISKCHARACTERISTICSTEMPERATURE() {
		return RISKCHARACTERISTICSTEMPERATURE;
	}

	public void setRISKCHARACTERISTICSTEMPERATURE(String rISKCHARACTERISTICSTEMPERATURE) {
		this.RISKCHARACTERISTICSTEMPERATURE = RISKCHARACTERISTICSTEMPERATURE;
	}

	public String getID() {
		return ID;
	}

	public void setID(String ID) {
		this.ID = ID;
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
		this.ALARMPOOLSIZE = ALARMPOOLSIZE;
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
		this.WHETHERTHESCOOP = WHETHERTHESCOOP;
	}
	public String getRISKCHARACTERISTICSPOISON() {
		return RISKCHARACTERISTICSPOISON;
	}

	public void setRISKCHARACTERISTICSPOISON(String rISKCHARACTERISTICSPOISON) {
		this.RISKCHARACTERISTICSPOISON = RISKCHARACTERISTICSPOISON;
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
		this.COFFERDAMHEIGHT = COFFERDAMHEIGHT;
	}
	public Double getCOFFERDAMSIZE() {
		return COFFERDAMSIZE;
	}

	public void setCOFFERDAMSIZE(Double cOFFERDAMSIZE) {
		this.COFFERDAMSIZE = COFFERDAMSIZE;
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
		this.RISKCHARACTERISTICSEXPLOSIVE = RISKCHARACTERISTICSEXPLOSIVE;
	}
	public String getCONTROLREMARKS() {
		return CONTROLREMARKS;
	}

	public void setCONTROLREMARKS(String cONTROLREMARKS) {
		this.CONTROLREMARKS = CONTROLREMARKS;
	}
	public Double getCHEMISTRYMAX() {
		return CHEMISTRYMAX;
	}

	public void setCHEMISTRYMAX(Double cHEMISTRYMAX) {
		this.CHEMISTRYMAX = CHEMISTRYMAX;
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
		this.CUSHIONPOOLSIZE = CUSHIONPOOLSIZE;
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
		this.SUBMITTEDTIME = SUBMITTEDTIME;
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
		this.UPDATETIME = UPDATETIME;
	}
	public String getCHEMISTRYNAME() {
		return CHEMISTRYNAME;
	}

	public void setCHEMISTRYNAME(String cHEMISTRYNAME) {
		this.CHEMISTRYNAME = CHEMISTRYNAME;
	}
	
}


