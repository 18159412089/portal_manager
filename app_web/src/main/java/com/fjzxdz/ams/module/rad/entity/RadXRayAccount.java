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
 * 射线装置台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "RAD_X_RAY_ACCOUNT")
public class RadXRayAccount implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 单位自动编号 */
	@Column(name="ENTERID")
	private String ENTERID;
	/** 装置类型 */
	private String ZZLX;
	/** 审核人 */
	private String SHR;
	/** 来源 */
	private String LY;
	/** 场所 */
	private String CS;
	/** 自动编号 */
	@Id
	private String PKID;
	/** 规格型号 */
	private String GGXH;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 审核日期 */
	private String SHRQ;
	/** 去向审核日期 */
	private String QXSHRQ;
	/** 备注 */
	private String BZ;
	/** 电压 */
	private String DY;
	/** 去向审核人 */
	private String QXSHR;
	/** 去向 */
	private String QX;
	/** 电流 */
	private String DL;
	/** 是否历史台帐 */
	private String SFLSTZ;
	/** 功率 */
	private String GL;
	/** 装置名称 */
	private String ZZMC;
	/** 用途 */
	private String YT;
	@JoinColumn(name="ENTERID", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private RadEnterpriseInfo radEnterpriseInfo;
	public RadEnterpriseInfo getRadEnterpriseInfo() {
		return radEnterpriseInfo;
	}

	public void setRadEnterpriseInfo(RadEnterpriseInfo radEnterpriseInfo) {
		this.radEnterpriseInfo = radEnterpriseInfo;
	}

	public String getENTERID() {
		return ENTERID;
	}

	public void setENTERID(String eNTERID) {
		this.ENTERID = ENTERID;
	}
	public String getZZLX() {
		return ZZLX;
	}

	public void setZZLX(String zZLX) {
		this.ZZLX = ZZLX;
	}
	public String getSHR() {
		return SHR;
	}

	public void setSHR(String sHR) {
		this.SHR = SHR;
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
	public String getGGXH() {
		return GGXH;
	}

	public void setGGXH(String gGXH) {
		this.GGXH = GGXH;
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
	public String getBZ() {
		return BZ;
	}

	public void setBZ(String bZ) {
		this.BZ = BZ;
	}
	public String getDY() {
		return DY;
	}

	public void setDY(String dY) {
		this.DY = DY;
	}
	public String getQXSHR() {
		return QXSHR;
	}

	public void setQXSHR(String qXSHR) {
		this.QXSHR = QXSHR;
	}
	public String getQX() {
		return QX;
	}

	public void setQX(String qX) {
		this.QX = QX;
	}
	public String getDL() {
		return DL;
	}

	public void setDL(String dL) {
		this.DL = DL;
	}
	public String getSFLSTZ() {
		return SFLSTZ;
	}

	public void setSFLSTZ(String sFLSTZ) {
		this.SFLSTZ = SFLSTZ;
	}
	public String getGL() {
		return GL;
	}

	public void setGL(String gL) {
		this.GL = GL;
	}
	public String getZZMC() {
		return ZZMC;
	}

	public void setZZMC(String zZMC) {
		this.ZZMC = ZZMC;
	}
	public String getYT() {
		return YT;
	}

	public void setYT(String yT) {
		this.YT = YT;
	}
	
}


