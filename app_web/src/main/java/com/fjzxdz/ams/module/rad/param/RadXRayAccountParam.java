/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.param;

import com.fjzxdz.ams.module.rad.entity.RadXRayAccount;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 射线装置台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class RadXRayAccountParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 单位自动编号 */
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
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RadXRayAccountParam() {
		super(RadXRayAccount.class);
		this.clazz = RadXRayAccount.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("ENTERID", getENTERID(), SearchCondition.LIKE);
		addClause("ZZLX", getZZLX(), SearchCondition.LIKE);
		addClause("SHR", getSHR(), SearchCondition.LIKE);
		addClause("LY", getLY(), SearchCondition.LIKE);
		addClause("CS", getCS(), SearchCondition.LIKE);
		addClause("PKID", getPKID(), SearchCondition.LIKE);
		addClause("GGXH", getGGXH(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("SHRQ", getSHRQ(), SearchCondition.LIKE);
		addClause("QXSHRQ", getQXSHRQ(), SearchCondition.LIKE);
		addClause("BZ", getBZ(), SearchCondition.LIKE);
		addClause("DY", getDY(), SearchCondition.LIKE);
		addClause("QXSHR", getQXSHR(), SearchCondition.LIKE);
		addClause("QX", getQX(), SearchCondition.LIKE);
		addClause("DL", getDL(), SearchCondition.LIKE);
		addClause("SFLSTZ", getSFLSTZ(), SearchCondition.LIKE);
		addClause("GL", getGL(), SearchCondition.LIKE);
		addClause("ZZMC", getZZMC(), SearchCondition.LIKE);
		addClause("YT", getYT(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getENTERID() {
		return ENTERID;
	}
	
	public void setENTERID(String eNTERID) {
		this.ENTERID = eNTERID;
	}
	public String getZZLX() {
		return ZZLX;
	}
	
	public void setZZLX(String zZLX) {
		this.ZZLX = zZLX;
	}
	public String getSHR() {
		return SHR;
	}
	
	public void setSHR(String sHR) {
		this.SHR = sHR;
	}
	public String getLY() {
		return LY;
	}
	
	public void setLY(String lY) {
		this.LY = lY;
	}
	public String getCS() {
		return CS;
	}
	
	public void setCS(String cS) {
		this.CS = cS;
	}
	public String getPKID() {
		return PKID;
	}
	
	public void setPKID(String pKID) {
		this.PKID = pKID;
	}
	public String getGGXH() {
		return GGXH;
	}
	
	public void setGGXH(String gGXH) {
		this.GGXH = gGXH;
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
		this.SHRQ = sHRQ;
	}
	public String getQXSHRQ() {
		return QXSHRQ;
	}
	
	public void setQXSHRQ(String qXSHRQ) {
		this.QXSHRQ = qXSHRQ;
	}
	public String getBZ() {
		return BZ;
	}
	
	public void setBZ(String bZ) {
		this.BZ = bZ;
	}
	public String getDY() {
		return DY;
	}
	
	public void setDY(String dY) {
		this.DY = dY;
	}
	public String getQXSHR() {
		return QXSHR;
	}
	
	public void setQXSHR(String qXSHR) {
		this.QXSHR = qXSHR;
	}
	public String getQX() {
		return QX;
	}
	
	public void setQX(String qX) {
		this.QX = qX;
	}
	public String getDL() {
		return DL;
	}
	
	public void setDL(String dL) {
		this.DL = dL;
	}
	public String getSFLSTZ() {
		return SFLSTZ;
	}
	
	public void setSFLSTZ(String sFLSTZ) {
		this.SFLSTZ = sFLSTZ;
	}
	public String getGL() {
		return GL;
	}
	
	public void setGL(String gL) {
		this.GL = gL;
	}
	public String getZZMC() {
		return ZZMC;
	}
	
	public void setZZMC(String zZMC) {
		this.ZZMC = zZMC;
	}
	public String getYT() {
		return YT;
	}
	
	public void setYT(String yT) {
		this.YT = yT;
	}
	
}


