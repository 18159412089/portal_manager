/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 联单转移联单信息Entity
 * @author htj
 * @version 2019-02-19
 */
@Entity
@Table(name = "HAZ_JOINT_ORDER_INFO")
public class JointOrderInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 司机 */
	private String CHUCHANG;
	/** 备注 */
	private java.util.Date CCSJ;
	/** 确认接收时间 */
	private String confirmRemark;
	/** 联单状态：a 新建待处置确认，1 创建成功，2 已出厂，c 接收量不一致协商解决产废企业确认，3 已确认签收，5 已退回 */
	private String LDZT;
	/** 出厂时间 */
	private String ysqyDriver;
	/** 创建时间 */
	private String QRCJSJ;
	/** 转移联单id */
	private String zyldId;
	/** 系统企业id */
	private String ID;
	/** 备注 */
	private java.util.Date QRSJ;
	/** 确认时间 */
	private String qrcjRemark;
	/**  */
	private java.util.Date CJSJ;
	/** 备注 */
	private java.util.Date UPDATETIME;
	/** 联单编号 */
	@Id
	private String LDBH;
	public String getCHUCHANG() {
		return CHUCHANG;
	}
	public void setCHUCHANG(String cHUCHANG) {
		CHUCHANG = cHUCHANG;
	}
	public java.util.Date getCCSJ() {
		return CCSJ;
	}
	public void setCCSJ(java.util.Date cCSJ) {
		CCSJ = cCSJ;
	}
	public String getConfirmRemark() {
		return confirmRemark;
	}
	public void setConfirmRemark(String confirmRemark) {
		this.confirmRemark = confirmRemark;
	}
	public String getLDZT() {
		return LDZT;
	}
	public void setLDZT(String lDZT) {
		LDZT = lDZT;
	}
	public String getYsqyDriver() {
		return ysqyDriver;
	}
	public void setYsqyDriver(String ysqyDriver) {
		this.ysqyDriver = ysqyDriver;
	}
	public String getQRCJSJ() {
		return QRCJSJ;
	}
	public void setQRCJSJ(String qRCJSJ) {
		QRCJSJ = qRCJSJ;
	}
	public String getZyldId() {
		return zyldId;
	}
	public void setZyldId(String zyldId) {
		this.zyldId = zyldId;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public java.util.Date getQRSJ() {
		return QRSJ;
	}
	public void setQRSJ(java.util.Date qRSJ) {
		QRSJ = qRSJ;
	}
	public String getQrcjRemark() {
		return qrcjRemark;
	}
	public void setQrcjRemark(String qrcjRemark) {
		this.qrcjRemark = qrcjRemark;
	}
	public java.util.Date getCJSJ() {
		return CJSJ;
	}
	public void setCJSJ(java.util.Date cJSJ) {
		CJSJ = cJSJ;
	}
	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}
	public void setUPDATETIME(java.util.Date uPDATETIME) {
		UPDATETIME = uPDATETIME;
	}
	public String getLDBH() {
		return LDBH;
	}
	public void setLDBH(String lDBH) {
		LDBH = lDBH;
	}
	
 
	
}


