/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fjzxdz.ams.module.wtcd.entity.WtcdRiverwayData;

/**
 * 辐射企业信息Entity
 * 
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "RAD_ENTERPRISE_INFO")
public class RadEnterpriseInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	/** 许可证发证机关 */
	private String XKZFZJG;
	/** 许可证号 */
	private String XKZH;
	/** 联系人 */
	private String LXR;
	/** 辐射管理机构传真 */
	private String FSGLJGCZ;
	/** 经度度 */
	private String JDD;
	/** 注册地址 */
	private String ZCDZ;
	/** 行业类别 */
	private String HYLB;
	/** 经度分 */
	private String JDF;
	/** 联系电话 */
	private String LXDH;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 通讯地邮编 */
	private String TXDYB;
	/** 所在市区 */
	private String SZSQ;
	/** 备注 */
	private String BZ;
	/** 放射源生产活动种类 */
	private String FSYSCHDZL;
	/** 射线装置生产活动种类 */
	private String SXZZSCHDZL;
	/** 许可证颁发条件 */
	private String XKZBFTJ;
	/** 使用（含收贮） */
	private String SY;
	/**  */
	private String YXSHD;
	/** 法定代表人 */
	private String FDDBR;
	/** 单位名称 */
	private String ENTERNAME;
	/** 纬度秒 */
	private String WDM;
	/** 经度秒 */
	private String JDM;
	/** 法人电话 */
	private String FRDH;
	/** 所在区县 */
	private String SZQX;
	/** 自动编号 */
	@Id
	private String ENTERID;
	/** 纬度分 */
	private String WDF;
	/** 射线装置使用活动种类 */
	private String SXZZSYHDZL;
	/** 通讯地址 */
	private String TXDZ;
	/** 所在省份 */
	private String SZSF;
	/** 纬度度 */
	private String WDD;
	/** 单位状态 */
	private String DWZT;
	/** 射线装置使用（含建造）I类 */
	private String SXZZSYIL;
	/** 注册地邮编 */
	private String ZCDYB;
	/** 许可证生效日期 */
	private String XKZSXRQ;
	/** 组织机构代码 */
	private String ZZJGDM;
	/** 辐射管理机构负责人电话 */
	private String FSGLJGFZRDH;
	/** 许可证失效日期 */
	private String XKZASXRQ;
	/** 射线装置销售活动种类 */
	private String SXZZXSHDZL;
	/** 辐射管理机构联系人 */
	private String FSGLJGLXR;
	/** 辐射管理机构名称 */
	private String FSGLJGMC;
	/** 非密封放射物质活动种类 */
	private String FMFFSWZHDZL;
	/** 辐射管理机构联系人手机 */
	private String FSGLJGLXRSJ;
	/** 非密封放射物质活动范围 */
	private String FMFFSWZHDFW;
	/**  */
	private String FSYSYHD;
	/** 法人证件类型 */
	private String FRZJLX;
	/** 法人证件号码 */
	private String FRZJHM;
	/** 辐射管理机构联系人电子邮件 */
	private String FSGLJGLXRDZYJ;
	/** 主要应用领域 */
	private String ZYYYLY;

	@Transient
	private String longitude;
	@Transient
	private String latitude;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "radEnterpriseInfo")
	private Set<RadSourceAccount> radSourceAccountSet  = new HashSet<RadSourceAccount>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "radEnterpriseInfo")
	private Set<RadUnseraledAccount> radUnseraledAccountSet  = new HashSet<RadUnseraledAccount>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "radEnterpriseInfo")
	private Set<RadXRayAccount> radXRayAccountSet  = new HashSet<RadXRayAccount>();
	
	
	public Set<RadSourceAccount> getRadSourceAccountSet() {
		return radSourceAccountSet;
	}

	public void setRadSourceAccountSet(Set<RadSourceAccount> radSourceAccountSet) {
		this.radSourceAccountSet = radSourceAccountSet;
	}

	public Set<RadUnseraledAccount> getRadUnseraledAccountSet() {
		return radUnseraledAccountSet;
	}

	public void setRadUnseraledAccountSet(Set<RadUnseraledAccount> radUnseraledAccountSet) {
		this.radUnseraledAccountSet = radUnseraledAccountSet;
	}

	public Set<RadXRayAccount> getRadXRayAccountSet() {
		return radXRayAccountSet;
	}

	public void setRadXRayAccountSet(Set<RadXRayAccount> radXRayAccountSet) {
		this.radXRayAccountSet = radXRayAccountSet;
	}

	public String getXKZFZJG() {
		return XKZFZJG;
	}

	public void setXKZFZJG(String xKZFZJG) {
		this.XKZFZJG = XKZFZJG;
	}

	public String getXKZH() {
		return XKZH;
	}

	public void setXKZH(String xKZH) {
		this.XKZH = XKZH;
	}

	public String getLXR() {
		return LXR;
	}

	public void setLXR(String lXR) {
		this.LXR = LXR;
	}

	public String getFSGLJGCZ() {
		return FSGLJGCZ;
	}

	public void setFSGLJGCZ(String fSGLJGCZ) {
		this.FSGLJGCZ = FSGLJGCZ;
	}

	public String getJDD() {
		return JDD;
	}

	public void setJDD(String jDD) {
		this.JDD = JDD;
	}

	public String getZCDZ() {
		return ZCDZ;
	}

	public void setZCDZ(String zCDZ) {
		this.ZCDZ = ZCDZ;
	}

	public String getHYLB() {
		return HYLB;
	}

	public void setHYLB(String hYLB) {
		this.HYLB = HYLB;
	}

	public String getJDF() {
		return JDF;
	}

	public void setJDF(String jDF) {
		this.JDF = JDF;
	}

	public String getLXDH() {
		return LXDH;
	}

	public void setLXDH(String lXDH) {
		this.LXDH = LXDH;
	}

	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}

	public String getTXDYB() {
		return TXDYB;
	}

	public void setTXDYB(String tXDYB) {
		this.TXDYB = TXDYB;
	}

	public String getSZSQ() {
		return SZSQ;
	}

	public void setSZSQ(String sZSQ) {
		this.SZSQ = SZSQ;
	}

	public String getBZ() {
		return BZ;
	}

	public void setBZ(String bZ) {
		this.BZ = BZ;
	}

	public String getFSYSCHDZL() {
		return FSYSCHDZL;
	}

	public void setFSYSCHDZL(String fSYSCHDZL) {
		this.FSYSCHDZL = FSYSCHDZL;
	}

	public String getSXZZSCHDZL() {
		return SXZZSCHDZL;
	}

	public void setSXZZSCHDZL(String sXZZSCHDZL) {
		this.SXZZSCHDZL = SXZZSCHDZL;
	}

	public String getXKZBFTJ() {
		return XKZBFTJ;
	}

	public void setXKZBFTJ(String xKZBFTJ) {
		this.XKZBFTJ = XKZBFTJ;
	}

	public String getSY() {
		return SY;
	}

	public void setSY(String sY) {
		this.SY = SY;
	}

	public String getYXSHD() {
		return YXSHD;
	}

	public void setYXSHD(String yXSHD) {
		this.YXSHD = YXSHD;
	}

	public String getFDDBR() {
		return FDDBR;
	}

	public void setFDDBR(String fDDBR) {
		this.FDDBR = FDDBR;
	}

	public String getENTERNAME() {
		return ENTERNAME;
	}

	public void setENTERNAME(String eNTERNAME) {
		this.ENTERNAME = ENTERNAME;
	}

	public String getWDM() {
		return WDM;
	}

	public void setWDM(String wDM) {
		this.WDM = WDM;
	}

	public String getJDM() {
		return JDM;
	}

	public void setJDM(String jDM) {
		this.JDM = JDM;
	}

	public String getFRDH() {
		return FRDH;
	}

	public void setFRDH(String fRDH) {
		this.FRDH = FRDH;
	}

	public String getSZQX() {
		return SZQX;
	}

	public void setSZQX(String sZQX) {
		this.SZQX = SZQX;
	}

	public String getENTERID() {
		return ENTERID;
	}

	public void setENTERID(String eNTERID) {
		this.ENTERID = ENTERID;
	}

	public String getWDF() {
		return WDF;
	}

	public void setWDF(String wDF) {
		this.WDF = WDF;
	}

	public String getSXZZSYHDZL() {
		return SXZZSYHDZL;
	}

	public void setSXZZSYHDZL(String sXZZSYHDZL) {
		this.SXZZSYHDZL = SXZZSYHDZL;
	}

	public String getTXDZ() {
		return TXDZ;
	}

	public void setTXDZ(String tXDZ) {
		this.TXDZ = TXDZ;
	}

	public String getSZSF() {
		return SZSF;
	}

	public void setSZSF(String sZSF) {
		this.SZSF = SZSF;
	}

	public String getWDD() {
		return WDD;
	}

	public void setWDD(String wDD) {
		this.WDD = WDD;
	}

	public String getDWZT() {
		return DWZT;
	}

	public void setDWZT(String dWZT) {
		this.DWZT = DWZT;
	}

	public String getSXZZSYIL() {
		return SXZZSYIL;
	}

	public void setSXZZSYIL(String sXZZSYIL) {
		this.SXZZSYIL = SXZZSYIL;
	}

	public String getZCDYB() {
		return ZCDYB;
	}

	public void setZCDYB(String zCDYB) {
		this.ZCDYB = ZCDYB;
	}

	public String getXKZSXRQ() {
		return XKZSXRQ;
	}

	public void setXKZSXRQ(String xKZSXRQ) {
		this.XKZSXRQ = XKZSXRQ;
	}

	public String getZZJGDM() {
		return ZZJGDM;
	}

	public void setZZJGDM(String zZJGDM) {
		this.ZZJGDM = ZZJGDM;
	}

	public String getFSGLJGFZRDH() {
		return FSGLJGFZRDH;
	}

	public void setFSGLJGFZRDH(String fSGLJGFZRDH) {
		this.FSGLJGFZRDH = FSGLJGFZRDH;
	}

	public String getXKZASXRQ() {
		return XKZASXRQ;
	}

	public void setXKZASXRQ(String xKZASXRQ) {
		this.XKZASXRQ = XKZASXRQ;
	}

	public String getSXZZXSHDZL() {
		return SXZZXSHDZL;
	}

	public void setSXZZXSHDZL(String sXZZXSHDZL) {
		this.SXZZXSHDZL = SXZZXSHDZL;
	}

	public String getFSGLJGLXR() {
		return FSGLJGLXR;
	}

	public void setFSGLJGLXR(String fSGLJGLXR) {
		this.FSGLJGLXR = FSGLJGLXR;
	}

	public String getFSGLJGMC() {
		return FSGLJGMC;
	}

	public void setFSGLJGMC(String fSGLJGMC) {
		this.FSGLJGMC = FSGLJGMC;
	}

	public String getFMFFSWZHDZL() {
		return FMFFSWZHDZL;
	}

	public void setFMFFSWZHDZL(String fMFFSWZHDZL) {
		this.FMFFSWZHDZL = FMFFSWZHDZL;
	}

	public String getFSGLJGLXRSJ() {
		return FSGLJGLXRSJ;
	}

	public void setFSGLJGLXRSJ(String fSGLJGLXRSJ) {
		this.FSGLJGLXRSJ = FSGLJGLXRSJ;
	}

	public String getFMFFSWZHDFW() {
		return FMFFSWZHDFW;
	}

	public void setFMFFSWZHDFW(String fMFFSWZHDFW) {
		this.FMFFSWZHDFW = FMFFSWZHDFW;
	}

	public String getFSYSYHD() {
		return FSYSYHD;
	}

	public void setFSYSYHD(String fSYSYHD) {
		this.FSYSYHD = FSYSYHD;
	}

	public String getFRZJLX() {
		return FRZJLX;
	}

	public void setFRZJLX(String fRZJLX) {
		this.FRZJLX = FRZJLX;
	}

	public String getFRZJHM() {
		return FRZJHM;
	}

	public void setFRZJHM(String fRZJHM) {
		this.FRZJHM = FRZJHM;
	}

	public String getFSGLJGLXRDZYJ() {
		return FSGLJGLXRDZYJ;
	}

	public void setFSGLJGLXRDZYJ(String fSGLJGLXRDZYJ) {
		this.FSGLJGLXRDZYJ = FSGLJGLXRDZYJ;
	}

	public String getZYYYLY() {
		return ZYYYLY;
	}

	public void setZYYYLY(String zYYYLY) {
		this.ZYYYLY = ZYYYLY;
	}

	public String getLongitude() {
		return longitude;
	}

	public void  setLatitude () {
		int londegree = Integer.valueOf(this.getWDD());
		int loncent = Integer.valueOf(this.getWDF());
		int lonsecond = Integer.valueOf(this.getWDM());
		
		this.latitude = String.valueOf(londegree+(loncent*RadEnterpriseInfo.multiplycent/RadEnterpriseInfo.dividecent+lonsecond*RadEnterpriseInfo.multiplysecond/RadEnterpriseInfo.dividesecond)/RadEnterpriseInfo.divide);
	}

	public String getLatitude() {
		return latitude;
	}

	public void  setLongitude() {
		int latdegree = Integer.valueOf(this.getJDD());
		int latcent = Integer.valueOf(this.getJDF());
		int latsecond = Integer.valueOf(this.getJDM());
		
		this.longitude = String.valueOf(latdegree+(latcent*RadEnterpriseInfo.multiplycent/RadEnterpriseInfo.dividecent+latsecond*RadEnterpriseInfo.multiplysecond/RadEnterpriseInfo.dividesecond)/RadEnterpriseInfo.divide);
	}

	public static int multiplycent =1000000;
	public static int multiplysecond = 100000;
	public static int dividecent=6;
	public static int dividesecond=36;
	public static double divide = 10000000.0;
}
