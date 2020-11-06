/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.param;

import com.fjzxdz.ams.module.rad.entity.RadEnterpriseInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 辐射企业信息Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class RadEnterpriseInfoParam extends BaseQueryParam {
	
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
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RadEnterpriseInfoParam() {
		super(RadEnterpriseInfo.class);
		this.clazz = RadEnterpriseInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("XKZFZJG", getXKZFZJG(), SearchCondition.LIKE);
		addClause("XKZH", getXKZH(), SearchCondition.LIKE);
		addClause("LXR", getLXR(), SearchCondition.LIKE);
		addClause("FSGLJGCZ", getFSGLJGCZ(), SearchCondition.LIKE);
		addClause("JDD", getJDD(), SearchCondition.LIKE);
		addClause("ZCDZ", getZCDZ(), SearchCondition.LIKE);
		addClause("HYLB", getHYLB(), SearchCondition.LIKE);
		addClause("JDF", getJDF(), SearchCondition.LIKE);
		addClause("LXDH", getLXDH(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("TXDYB", getTXDYB(), SearchCondition.LIKE);
		addClause("SZSQ", getSZSQ(), SearchCondition.LIKE);
		addClause("BZ", getBZ(), SearchCondition.LIKE);
		addClause("FSYSCHDZL", getFSYSCHDZL(), SearchCondition.LIKE);
		addClause("SXZZSCHDZL", getSXZZSCHDZL(), SearchCondition.LIKE);
		addClause("XKZBFTJ", getXKZBFTJ(), SearchCondition.LIKE);
		addClause("SY", getSY(), SearchCondition.LIKE);
		addClause("YXSHD", getYXSHD(), SearchCondition.LIKE);
		addClause("FDDBR", getFDDBR(), SearchCondition.LIKE);
		addClause("ENTERNAME", getENTERNAME(), SearchCondition.LIKE);
		addClause("WDM", getWDM(), SearchCondition.LIKE);
		addClause("JDM", getJDM(), SearchCondition.LIKE);
		addClause("FRDH", getFRDH(), SearchCondition.LIKE);
		addClause("SZQX", getSZQX(), SearchCondition.LIKE);
		addClause("ENTERID", getENTERID(), SearchCondition.LIKE);
		addClause("WDF", getWDF(), SearchCondition.LIKE);
		addClause("SXZZSYHDZL", getSXZZSYHDZL(), SearchCondition.LIKE);
		addClause("TXDZ", getTXDZ(), SearchCondition.LIKE);
		addClause("SZSF", getSZSF(), SearchCondition.LIKE);
		addClause("WDD", getWDD(), SearchCondition.LIKE);
		addClause("DWZT", getDWZT(), SearchCondition.LIKE);
		addClause("SXZZSYIL", getSXZZSYIL(), SearchCondition.LIKE);
		addClause("ZCDYB", getZCDYB(), SearchCondition.LIKE);
		addClause("XKZSXRQ", getXKZSXRQ(), SearchCondition.LIKE);
		addClause("ZZJGDM", getZZJGDM(), SearchCondition.LIKE);
		addClause("FSGLJGFZRDH", getFSGLJGFZRDH(), SearchCondition.LIKE);
		addClause("XKZASXRQ", getXKZASXRQ(), SearchCondition.LIKE);
		addClause("SXZZXSHDZL", getSXZZXSHDZL(), SearchCondition.LIKE);
		addClause("FSGLJGLXR", getFSGLJGLXR(), SearchCondition.LIKE);
		addClause("FSGLJGMC", getFSGLJGMC(), SearchCondition.LIKE);
		addClause("FMFFSWZHDZL", getFMFFSWZHDZL(), SearchCondition.LIKE);
		addClause("FSGLJGLXRSJ", getFSGLJGLXRSJ(), SearchCondition.LIKE);
		addClause("FMFFSWZHDFW", getFMFFSWZHDFW(), SearchCondition.LIKE);
		addClause("FSYSYHD", getFSYSYHD(), SearchCondition.LIKE);
		addClause("FRZJLX", getFRZJLX(), SearchCondition.LIKE);
		addClause("FRZJHM", getFRZJHM(), SearchCondition.LIKE);
		addClause("FSGLJGLXRDZYJ", getFSGLJGLXRDZYJ(), SearchCondition.LIKE);
		addClause("ZYYYLY", getZYYYLY(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getXKZFZJG() {
		return XKZFZJG;
	}
	
	public void setXKZFZJG(String xKZFZJG) {
		this.XKZFZJG = xKZFZJG;
	}
	public String getXKZH() {
		return XKZH;
	}
	
	public void setXKZH(String xKZH) {
		this.XKZH = xKZH;
	}
	public String getLXR() {
		return LXR;
	}
	
	public void setLXR(String lXR) {
		this.LXR = lXR;
	}
	public String getFSGLJGCZ() {
		return FSGLJGCZ;
	}
	
	public void setFSGLJGCZ(String fSGLJGCZ) {
		this.FSGLJGCZ = fSGLJGCZ;
	}
	public String getJDD() {
		return JDD;
	}
	
	public void setJDD(String jDD) {
		this.JDD = jDD;
	}
	public String getZCDZ() {
		return ZCDZ;
	}
	
	public void setZCDZ(String zCDZ) {
		this.ZCDZ = zCDZ;
	}
	public String getHYLB() {
		return HYLB;
	}
	
	public void setHYLB(String hYLB) {
		this.HYLB = hYLB;
	}
	public String getJDF() {
		return JDF;
	}
	
	public void setJDF(String jDF) {
		this.JDF = jDF;
	}
	public String getLXDH() {
		return LXDH;
	}
	
	public void setLXDH(String lXDH) {
		this.LXDH = lXDH;
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
		this.TXDYB = tXDYB;
	}
	public String getSZSQ() {
		return SZSQ;
	}
	
	public void setSZSQ(String sZSQ) {
		this.SZSQ = sZSQ;
	}
	public String getBZ() {
		return BZ;
	}
	
	public void setBZ(String bZ) {
		this.BZ = bZ;
	}
	public String getFSYSCHDZL() {
		return FSYSCHDZL;
	}
	
	public void setFSYSCHDZL(String fSYSCHDZL) {
		this.FSYSCHDZL = fSYSCHDZL;
	}
	public String getSXZZSCHDZL() {
		return SXZZSCHDZL;
	}
	
	public void setSXZZSCHDZL(String sXZZSCHDZL) {
		this.SXZZSCHDZL = sXZZSCHDZL;
	}
	public String getXKZBFTJ() {
		return XKZBFTJ;
	}
	
	public void setXKZBFTJ(String xKZBFTJ) {
		this.XKZBFTJ = xKZBFTJ;
	}
	public String getSY() {
		return SY;
	}
	
	public void setSY(String sY) {
		this.SY = sY;
	}
	public String getYXSHD() {
		return YXSHD;
	}
	
	public void setYXSHD(String yXSHD) {
		this.YXSHD = yXSHD;
	}
	public String getFDDBR() {
		return FDDBR;
	}
	
	public void setFDDBR(String fDDBR) {
		this.FDDBR = fDDBR;
	}
	public String getENTERNAME() {
		return ENTERNAME;
	}
	
	public void setENTERNAME(String eNTERNAME) {
		this.ENTERNAME = eNTERNAME;
	}
	public String getWDM() {
		return WDM;
	}
	
	public void setWDM(String wDM) {
		this.WDM = wDM;
	}
	public String getJDM() {
		return JDM;
	}
	
	public void setJDM(String jDM) {
		this.JDM = jDM;
	}
	public String getFRDH() {
		return FRDH;
	}
	
	public void setFRDH(String fRDH) {
		this.FRDH = fRDH;
	}
	public String getSZQX() {
		return SZQX;
	}
	
	public void setSZQX(String sZQX) {
		this.SZQX = sZQX;
	}
	public String getENTERID() {
		return ENTERID;
	}
	
	public void setENTERID(String eNTERID) {
		this.ENTERID = eNTERID;
	}
	public String getWDF() {
		return WDF;
	}
	
	public void setWDF(String wDF) {
		this.WDF = wDF;
	}
	public String getSXZZSYHDZL() {
		return SXZZSYHDZL;
	}
	
	public void setSXZZSYHDZL(String sXZZSYHDZL) {
		this.SXZZSYHDZL = sXZZSYHDZL;
	}
	public String getTXDZ() {
		return TXDZ;
	}
	
	public void setTXDZ(String tXDZ) {
		this.TXDZ = tXDZ;
	}
	public String getSZSF() {
		return SZSF;
	}
	
	public void setSZSF(String sZSF) {
		this.SZSF = sZSF;
	}
	public String getWDD() {
		return WDD;
	}
	
	public void setWDD(String wDD) {
		this.WDD = wDD;
	}
	public String getDWZT() {
		return DWZT;
	}
	
	public void setDWZT(String dWZT) {
		this.DWZT = dWZT;
	}
	public String getSXZZSYIL() {
		return SXZZSYIL;
	}
	
	public void setSXZZSYIL(String sXZZSYIL) {
		this.SXZZSYIL = sXZZSYIL;
	}
	public String getZCDYB() {
		return ZCDYB;
	}
	
	public void setZCDYB(String zCDYB) {
		this.ZCDYB = zCDYB;
	}
	public String getXKZSXRQ() {
		return XKZSXRQ;
	}
	
	public void setXKZSXRQ(String xKZSXRQ) {
		this.XKZSXRQ = xKZSXRQ;
	}
	public String getZZJGDM() {
		return ZZJGDM;
	}
	
	public void setZZJGDM(String zZJGDM) {
		this.ZZJGDM = zZJGDM;
	}
	public String getFSGLJGFZRDH() {
		return FSGLJGFZRDH;
	}
	
	public void setFSGLJGFZRDH(String fSGLJGFZRDH) {
		this.FSGLJGFZRDH = fSGLJGFZRDH;
	}
	public String getXKZASXRQ() {
		return XKZASXRQ;
	}
	
	public void setXKZASXRQ(String xKZASXRQ) {
		this.XKZASXRQ = xKZASXRQ;
	}
	public String getSXZZXSHDZL() {
		return SXZZXSHDZL;
	}
	
	public void setSXZZXSHDZL(String sXZZXSHDZL) {
		this.SXZZXSHDZL = sXZZXSHDZL;
	}
	public String getFSGLJGLXR() {
		return FSGLJGLXR;
	}
	
	public void setFSGLJGLXR(String fSGLJGLXR) {
		this.FSGLJGLXR = fSGLJGLXR;
	}
	public String getFSGLJGMC() {
		return FSGLJGMC;
	}
	
	public void setFSGLJGMC(String fSGLJGMC) {
		this.FSGLJGMC = fSGLJGMC;
	}
	public String getFMFFSWZHDZL() {
		return FMFFSWZHDZL;
	}
	
	public void setFMFFSWZHDZL(String fMFFSWZHDZL) {
		this.FMFFSWZHDZL = fMFFSWZHDZL;
	}
	public String getFSGLJGLXRSJ() {
		return FSGLJGLXRSJ;
	}
	
	public void setFSGLJGLXRSJ(String fSGLJGLXRSJ) {
		this.FSGLJGLXRSJ = fSGLJGLXRSJ;
	}
	public String getFMFFSWZHDFW() {
		return FMFFSWZHDFW;
	}
	
	public void setFMFFSWZHDFW(String fMFFSWZHDFW) {
		this.FMFFSWZHDFW = fMFFSWZHDFW;
	}
	public String getFSYSYHD() {
		return FSYSYHD;
	}
	
	public void setFSYSYHD(String fSYSYHD) {
		this.FSYSYHD = fSYSYHD;
	}
	public String getFRZJLX() {
		return FRZJLX;
	}
	
	public void setFRZJLX(String fRZJLX) {
		this.FRZJLX = fRZJLX;
	}
	public String getFRZJHM() {
		return FRZJHM;
	}
	
	public void setFRZJHM(String fRZJHM) {
		this.FRZJHM = fRZJHM;
	}
	public String getFSGLJGLXRDZYJ() {
		return FSGLJGLXRDZYJ;
	}
	
	public void setFSGLJGLXRDZYJ(String fSGLJGLXRDZYJ) {
		this.FSGLJGLXRDZYJ = fSGLJGLXRDZYJ;
	}
	public String getZYYYLY() {
		return ZYYYLY;
	}
	
	public void setZYYYLY(String zYYYLY) {
		this.ZYYYLY = zYYYLY;
	}
	
}


