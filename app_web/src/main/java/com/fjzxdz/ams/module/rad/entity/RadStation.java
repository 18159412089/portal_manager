/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 辐射基站Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "RAD_STATION")
public class RadStation implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 发射机型号 */
	private String FSJXH;
	/** 天线下倾角 */
	private String TXXQJ;
	/** 数据分册编号 */
	private String SJFCBH;
	/** 基站名称 */
	private String JZNAME;
	/** 每个扇区的载频数 */
	private String MGSQZPS;
	/** ID */
	@Id
	private String PKID;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 验收天线架设类型 */
	private String TXJSLX;
	/** 标称功率(W) */
	private String BCGL;
	/** 纬度 */
	private String LATITUDE;
	/** 发射机厂商 */
	private String FSJCS;
	/** 市 */
	private String CODEREGIONSHI;
	/** 区县 */
	private String CODEREGIONXIAN;
	/** 验收共站类型 */
	private String YSGZLX;
	/** 立项时间 */
	private String LXSJ;
	/** 地址 */
	private String ENTERADDRESS;
	/** 天地方向角 */
	private String TXFXJ;
	/** 经度 */
	private String LONGITUDE;
	/** 天线数目 */
	private String TXSM;
	/** 天线离地高度（M） */
	private String TXLDGD;
	/** 区域类型 */
	private String QYLX;
	/** 天线极化方式 */
	private String TXJHFS;
	/** 天线增益(dBi) */
	private String TXZY;
	/** 编号 */
	private String JZBH;
	
	public String getFSJXH() {
		return FSJXH;
	}

	public void setFSJXH(String fSJXH) {
		this.FSJXH = FSJXH.trim();
	}
	public String getTXXQJ() {
		return TXXQJ;
	}

	public void setTXXQJ(String tXXQJ) {
		this.TXXQJ = TXXQJ.trim();
	}
	public String getSJFCBH() {
		return SJFCBH;
	}

	public void setSJFCBH(String sJFCBH) {
		this.SJFCBH = SJFCBH.trim();
	}
	public String getJZNAME() {
		return JZNAME;
	}

	public void setJZNAME(String jZNAME) {
		this.JZNAME = JZNAME.trim();
	}
	public String getMGSQZPS() {
		return MGSQZPS;
	}

	public void setMGSQZPS(String mGSQZPS) {
		this.MGSQZPS = MGSQZPS.trim();
	}
	public String getPKID() {
		return PKID;
	}

	public void setPKID(String pKID) {
		this.PKID = PKID.trim();
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa.trim();
	}
	public String getTXJSLX() {
		return TXJSLX;
	}

	public void setTXJSLX(String tXJSLX) {
		this.TXJSLX = TXJSLX.trim();
	}
	public String getBCGL() {
		return BCGL;
	}

	public void setBCGL(String bCGL) {
		this.BCGL = BCGL.trim();
	}
	public String getLATITUDE() {
		return LATITUDE;
	}

	public void setLATITUDE(String lATITUDE) {
		this.LATITUDE = LATITUDE.trim();
	}
	public String getFSJCS() {
		return FSJCS;
	}

	public void setFSJCS(String fSJCS) {
		this.FSJCS = FSJCS.trim();
	}
	public String getCODEREGIONSHI() {
		return CODEREGIONSHI;
	}

	public void setCODEREGIONSHI(String cODEREGIONSHI) {
		this.CODEREGIONSHI = CODEREGIONSHI.trim();
	}
	public String getCODEREGIONXIAN() {
		return CODEREGIONXIAN;
	}

	public void setCODEREGIONXIAN(String cODEREGIONXIAN) {
		this.CODEREGIONXIAN = CODEREGIONXIAN.trim();
	}
	public String getYSGZLX() {
		return YSGZLX;
	}

	public void setYSGZLX(String ySGZLX) {
		this.YSGZLX = YSGZLX.trim();
	}
	public String getLXSJ() {
		return LXSJ;
	}

	public void setLXSJ(String lXSJ) {
		this.LXSJ = LXSJ.trim();
	}
	public String getENTERADDRESS() {
		return ENTERADDRESS;
	}

	public void setENTERADDRESS(String eNTERADDRESS) {
		this.ENTERADDRESS = ENTERADDRESS.trim();
	}
	public String getTXFXJ() {
		return TXFXJ;
	}

	public void setTXFXJ(String tXFXJ) {
		this.TXFXJ = TXFXJ.trim();
	}
	public String getLONGITUDE() {
		return LONGITUDE;
	}

	public void setLONGITUDE(String lONGITUDE) {
		this.LONGITUDE = LONGITUDE.trim();
	}
	public String getTXSM() {
		return TXSM;
	}

	public void setTXSM(String tXSM) {
		this.TXSM = TXSM.trim();
	}
	public String getTXLDGD() {
		return TXLDGD;
	}

	public void setTXLDGD(String tXLDGD) {
		this.TXLDGD = TXLDGD.trim();
	}
	public String getQYLX() {
		return QYLX;
	}

	public void setQYLX(String qYLX) {
		this.QYLX = QYLX.trim();
	}
	public String getTXJHFS() {
		return TXJHFS;
	}

	public void setTXJHFS(String tXJHFS) {
		this.TXJHFS = TXJHFS.trim();
	}
	public String getTXZY() {
		return TXZY;
	}

	public void setTXZY(String tXZY) {
		this.TXZY = TXZY.trim();
	}
	public String getJZBH() {
		return JZBH;
	}

	public void setJZBH(String jZBH) {
		this.JZBH = JZBH.trim();
	}
	
}


