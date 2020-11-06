/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.vi.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 信访投诉Entity
 * @author htj
 * @version 2019-02-19
 */
@Entity
@Table(name = "VI_VISITS")
public class Visits implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 是否群体事件（1是；0否） */
	private String ISFIGHT;
	/** 转办状态（0，转办；1，市级督办；2，省级督办） */
	private String HANLDTYPE;
	/** 办理时间 */
	private String PETITIONTIME;
	/** 不办理原因 */
	private String NOTACCEPTREASON;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 处理反馈状态（0：反馈；1：市级督办反馈；2：省级督办反馈） */
	private String FEEDBACKSTATUS;
	/** 信件编号 */
	private String LETTERCODE;
	/** 污染类别 */
	private String POLLUTIONTYPE;
	/** 行业类别 */
	private String INDUSTRYTYPE;
	/** 案件属性 */
	private String ATTRIBUTE;
	/** 来源系统（1本系统登记；2厅长信箱；3历史数据；4:12369） */
	private String SOURCE;
	/** 被举报单位所在区县 */
	private String POLLUTIONCOUNTY;
	/** 举报人 */
	private String PETITIONER;
	/** 是否重复件（2是；0否） */
	private String ISREPEAT;
	/** 受信人 */
	private String PETITIONACCEPTPERSON;
	/** 事发地 */
	private String EVENTADDR;
	/** 举报内容 */
	private String PETICONTENT;
	/** 是否办理（1是；0否） */
	private String ISACCEPT;
	/** 登记时间 */
	private String INSERTTIME;
	/** 举报人地址 */
	private String PETITIONERADDR;
	/** 信件Id（信件表主键） */
	@Id
	private String PETIID;
	/** 被举报单位所在地级市 */
	private String POLLUTIONCITY;
	/** 是否有效件（1是；0否） */
	private String ISVALID;
	/** 办理期限 */
	private String MANAGEMENTPERIOD;
	/** 被举报单位名称 */
	private String PENAME;
	/** 被举报单位地址 */
	private String PEADDR;
	/** 案件来源 */
	private String RESOURCEL;
	/** 举报人电话 */
	private String PETITIONERTEL;
	
	public String getISFIGHT() {
		return ISFIGHT;
	}

	public void setISFIGHT(String iSFIGHT) {
		this.ISFIGHT = ISFIGHT;
	}
	public String getHANLDTYPE() {
		return HANLDTYPE;
	}

	public void setHANLDTYPE(String hANLDTYPE) {
		this.HANLDTYPE = HANLDTYPE;
	}
	public String getPETITIONTIME() {
		return PETITIONTIME;
	}

	public void setPETITIONTIME(String pETITIONTIME) {
		this.PETITIONTIME = PETITIONTIME;
	}
	public String getNOTACCEPTREASON() {
		return NOTACCEPTREASON;
	}

	public void setNOTACCEPTREASON(String nOTACCEPTREASON) {
		this.NOTACCEPTREASON = NOTACCEPTREASON;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public String getFEEDBACKSTATUS() {
		return FEEDBACKSTATUS;
	}

	public void setFEEDBACKSTATUS(String fEEDBACKSTATUS) {
		this.FEEDBACKSTATUS = FEEDBACKSTATUS;
	}
	public String getLETTERCODE() {
		return LETTERCODE;
	}

	public void setLETTERCODE(String lETTERCODE) {
		this.LETTERCODE = LETTERCODE;
	}
	public String getPOLLUTIONTYPE() {
		return POLLUTIONTYPE;
	}

	public void setPOLLUTIONTYPE(String pOLLUTIONTYPE) {
		this.POLLUTIONTYPE = POLLUTIONTYPE;
	}
	public String getINDUSTRYTYPE() {
		return INDUSTRYTYPE;
	}

	public void setINDUSTRYTYPE(String iNDUSTRYTYPE) {
		this.INDUSTRYTYPE = INDUSTRYTYPE;
	}
	public String getATTRIBUTE() {
		return ATTRIBUTE;
	}

	public void setATTRIBUTE(String aTTRIBUTE) {
		this.ATTRIBUTE = ATTRIBUTE;
	}
	public String getSOURCE() {
		return SOURCE;
	}

	public void setSOURCE(String sOURCE) {
		this.SOURCE = SOURCE;
	}
	public String getPOLLUTIONCOUNTY() {
		return POLLUTIONCOUNTY;
	}

	public void setPOLLUTIONCOUNTY(String pOLLUTIONCOUNTY) {
		this.POLLUTIONCOUNTY = POLLUTIONCOUNTY;
	}
	public String getPETITIONER() {
		return PETITIONER;
	}

	public void setPETITIONER(String pETITIONER) {
		this.PETITIONER = PETITIONER;
	}
	public String getISREPEAT() {
		return ISREPEAT;
	}

	public void setISREPEAT(String iSREPEAT) {
		this.ISREPEAT = ISREPEAT;
	}
	public String getPETITIONACCEPTPERSON() {
		return PETITIONACCEPTPERSON;
	}

	public void setPETITIONACCEPTPERSON(String pETITIONACCEPTPERSON) {
		this.PETITIONACCEPTPERSON = PETITIONACCEPTPERSON;
	}
	public String getEVENTADDR() {
		return EVENTADDR;
	}

	public void setEVENTADDR(String eVENTADDR) {
		this.EVENTADDR = EVENTADDR;
	}
	public String getPETICONTENT() {
		return PETICONTENT;
	}

	public void setPETICONTENT(String pETICONTENT) {
		this.PETICONTENT = PETICONTENT;
	}
	public String getISACCEPT() {
		return ISACCEPT;
	}

	public void setISACCEPT(String iSACCEPT) {
		this.ISACCEPT = ISACCEPT;
	}
	public String getINSERTTIME() {
		return INSERTTIME;
	}

	public void setINSERTTIME(String iNSERTTIME) {
		this.INSERTTIME = INSERTTIME;
	}
	public String getPETITIONERADDR() {
		return PETITIONERADDR;
	}

	public void setPETITIONERADDR(String pETITIONERADDR) {
		this.PETITIONERADDR = PETITIONERADDR;
	}
	public String getPETIID() {
		return PETIID;
	}

	public void setPETIID(String pETIID) {
		this.PETIID = PETIID;
	}
	public String getPOLLUTIONCITY() {
		return POLLUTIONCITY;
	}

	public void setPOLLUTIONCITY(String pOLLUTIONCITY) {
		this.POLLUTIONCITY = POLLUTIONCITY;
	}
	public String getISVALID() {
		return ISVALID;
	}

	public void setISVALID(String iSVALID) {
		this.ISVALID = ISVALID;
	}
	public String getMANAGEMENTPERIOD() {
		return MANAGEMENTPERIOD;
	}

	public void setMANAGEMENTPERIOD(String mANAGEMENTPERIOD) {
		this.MANAGEMENTPERIOD = MANAGEMENTPERIOD;
	}
	public String getPENAME() {
		return PENAME;
	}

	public void setPENAME(String pENAME) {
		this.PENAME = PENAME;
	}
	public String getPEADDR() {
		return PEADDR;
	}

	public void setPEADDR(String pEADDR) {
		this.PEADDR = PEADDR;
	}
	public String getRESOURCEL() {
		return RESOURCEL;
	}

	public void setRESOURCEL(String rESOURCEL) {
		this.RESOURCEL = RESOURCEL;
	}
	public String getPETITIONERTEL() {
		return PETITIONERTEL;
	}

	public void setPETITIONERTEL(String pETITIONERTEL) {
		this.PETITIONERTEL = PETITIONERTEL;
	}
	
}


