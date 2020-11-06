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
 * 非密封台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "RAD_UNSERALED_ACCOUNT")
public class RadUnseraledAccount implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 审核人 */
	private String SHR;
	/** 核素名称 */
	private String HSMC;
	/** 单位自动编号 */
	@Column(name="ENTERID")
	private String ENTERID;
	/** 去向 */
	private String QX;
	/** 去向审核人 */
	private String XQSHR;
	/** 活度 */
	private String HD;
	/** 来源 */
	private String LY;
	/** 自动编号 */
	@Id
	private String PKID;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 审核日期 */
	private String SHRQ;
	/** 去向审核日期 */
	private String QXSHRQ;
	/** 用途 */
	private String YT;
	/** 备注 */
	private String BZ;
	/** 频次 */
	private String PC;
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
	public String getHSMC() {
		return HSMC;
	}

	public void setHSMC(String hSMC) {
		this.HSMC = HSMC;
	}
	public String getENTERID() {
		return ENTERID;
	}

	public void setENTERID(String eNTERID) {
		this.ENTERID = ENTERID;
	}
	public String getQX() {
		return QX;
	}

	public void setQX(String qX) {
		this.QX = QX;
	}
	public String getXQSHR() {
		return XQSHR;
	}

	public void setXQSHR(String xQSHR) {
		this.XQSHR = XQSHR;
	}
	public String getHD() {
		return HD;
	}

	public void setHD(String hD) {
		this.HD = HD;
	}
	public String getLY() {
		return LY;
	}

	public void setLY(String lY) {
		this.LY = LY;
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
	public String getYT() {
		return YT;
	}

	public void setYT(String yT) {
		this.YT = YT;
	}
	public String getBZ() {
		return BZ;
	}

	public void setBZ(String bZ) {
		this.BZ = BZ;
	}
	public String getPC() {
		return PC;
	}

	public void setPC(String pC) {
		this.PC = PC;
	}
	
}


