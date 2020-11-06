/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 放射源台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "RAD_SOURCE_ACCOUNT")
public class RadSourceAccount implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 审核人 */
	private String SHR;
	/** 单位自动编号 */
	@Column(name="ENTERID")
	private String ENTERID;
	/** 来源 */
	private String LY;
	/** 场所 */
	private String CS;
	/** ID */
	@Id
	private String PKID;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 出厂日期 */
	private String CCRQ;
	/** 审核日期 */
	private String SHRQ;
	/** 去向审核日期 */
	private String QXSHRQ;
	/** 放射源用途 */
	private String FSYYT;
	/** 备注 */
	private String BZ;
	/** 去向审核人 */
	private String QXSHR;
	/** 核素名称 */
	private String HSMC;
	/** 去向 */
	private String QX;
	/** 出厂活度 */
	private String CCHD;
	/** 标号 */
	private String BH;
	/** 放射源类别 */
	private String FSYLB;
	/** 是否历史台帐 */
	private String SFLSTZ;
	/** 放射源编码 */
	private String FSYBM;
	/** 状态 */
	private String ZT;
	@JoinColumn(name="ENTERID", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private RadEnterpriseInfo radEnterpriseInfo;
	public RadEnterpriseInfo getRadEnterpriseInfo() {
		return radEnterpriseInfo;
	}

	public void setRadEnterpriseInfo(RadEnterpriseInfo radEnterpriseInfo) {
		this.radEnterpriseInfo = radEnterpriseInfo;
	}

	public String getSHR() {
		return SHR;
	}

	public void setSHR(String sHR) {
		this.SHR = SHR;
	}
	public String getENTERID() {
		return ENTERID;
	}

	public void setENTERID(String eNTERID) {
		this.ENTERID = ENTERID;
	}
	public String getLY() {
		return LY;
	}

	public void setLY(String lY) {
		this.LY = LY;
	}
	public String getCS() {
		return CS;
	}

	public void setCS(String cS) {
		this.CS = CS;
	}
	public String getPKID() {
		return PKID;
	}

	public void setPKID(String pKID) {
		this.PKID = PKID;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public String getCCRQ() {
		return CCRQ;
	}

	public void setCCRQ(String cCRQ) {
		this.CCRQ = CCRQ;
	}
	public String getSHRQ() {
		return SHRQ;
	}

	public void setSHRQ(String sHRQ) {
		this.SHRQ = SHRQ;
	}
	public String getQXSHRQ() {
		return QXSHRQ;
	}

	public void setQXSHRQ(String qXSHRQ) {
		this.QXSHRQ = QXSHRQ;
	}
	public String getFSYYT() {
		return FSYYT;
	}

	public void setFSYYT(String fSYYT) {
		this.FSYYT = FSYYT;
	}
	public String getBZ() {
		return BZ;
	}

	public void setBZ(String bZ) {
		this.BZ = BZ;
	}
	public String getQXSHR() {
		return QXSHR;
	}

	public void setQXSHR(String qXSHR) {
		this.QXSHR = QXSHR;
	}
	public String getHSMC() {
		return HSMC;
	}

	public void setHSMC(String hSMC) {
		this.HSMC = HSMC;
	}
	public String getQX() {
		return QX;
	}

	public void setQX(String qX) {
		this.QX = QX;
	}
	public String getCCHD() {
		return CCHD;
	}

	public void setCCHD(String cCHD) {
		this.CCHD = CCHD;
	}
	public String getBH() {
		return BH;
	}

	public void setBH(String bH) {
		this.BH = BH;
	}
	public String getFSYLB() {
		return FSYLB;
	}

	public void setFSYLB(String fSYLB) {
		this.FSYLB = FSYLB;
	}
	public String getSFLSTZ() {
		return SFLSTZ;
	}

	public void setSFLSTZ(String sFLSTZ) {
		this.SFLSTZ = SFLSTZ;
	}
	public String getFSYBM() {
		return FSYBM;
	}

	public void setFSYBM(String fSYBM) {
		this.FSYBM = FSYBM;
	}
	public String getZT() {
		return ZT;
	}

	public void setZT(String zT) {
		this.ZT = ZT;
	}
	
}


