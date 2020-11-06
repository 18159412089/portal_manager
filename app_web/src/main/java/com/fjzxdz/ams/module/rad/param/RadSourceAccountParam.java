/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.param;

import com.fjzxdz.ams.module.rad.entity.RadSourceAccount;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 放射源台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class RadSourceAccountParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 审核人 */
	private String SHR;
	/** 单位自动编号 */
	private String ENTERID;
	/** 来源 */
	private String LY;
	/** 场所 */
	private String CS;
	/** ID */
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
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RadSourceAccountParam() {
		super(RadSourceAccount.class);
		this.clazz = RadSourceAccount.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("SHR", getSHR(), SearchCondition.LIKE);
		addClause("ENTERID", getENTERID(), SearchCondition.LIKE);
		addClause("LY", getLY(), SearchCondition.LIKE);
		addClause("CS", getCS(), SearchCondition.LIKE);
		addClause("PKID", getPKID(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("CCRQ", getCCRQ(), SearchCondition.LIKE);
		addClause("SHRQ", getSHRQ(), SearchCondition.LIKE);
		addClause("QXSHRQ", getQXSHRQ(), SearchCondition.LIKE);
		addClause("FSYYT", getFSYYT(), SearchCondition.LIKE);
		addClause("BZ", getBZ(), SearchCondition.LIKE);
		addClause("QXSHR", getQXSHR(), SearchCondition.LIKE);
		addClause("HSMC", getHSMC(), SearchCondition.LIKE);
		addClause("QX", getQX(), SearchCondition.LIKE);
		addClause("CCHD", getCCHD(), SearchCondition.LIKE);
		addClause("BH", getBH(), SearchCondition.LIKE);
		addClause("FSYLB", getFSYLB(), SearchCondition.LIKE);
		addClause("SFLSTZ", getSFLSTZ(), SearchCondition.LIKE);
		addClause("FSYBM", getFSYBM(), SearchCondition.LIKE);
		addClause("ZT", getZT(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getSHR() {
		return SHR;
	}
	
	public void setSHR(String sHR) {
		this.SHR = sHR;
	}
	public String getENTERID() {
		return ENTERID;
	}
	
	public void setENTERID(String eNTERID) {
		this.ENTERID = eNTERID;
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
		this.CCRQ = cCRQ;
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
	public String getFSYYT() {
		return FSYYT;
	}
	
	public void setFSYYT(String fSYYT) {
		this.FSYYT = fSYYT;
	}
	public String getBZ() {
		return BZ;
	}
	
	public void setBZ(String bZ) {
		this.BZ = bZ;
	}
	public String getQXSHR() {
		return QXSHR;
	}
	
	public void setQXSHR(String qXSHR) {
		this.QXSHR = qXSHR;
	}
	public String getHSMC() {
		return HSMC;
	}
	
	public void setHSMC(String hSMC) {
		this.HSMC = hSMC;
	}
	public String getQX() {
		return QX;
	}
	
	public void setQX(String qX) {
		this.QX = qX;
	}
	public String getCCHD() {
		return CCHD;
	}
	
	public void setCCHD(String cCHD) {
		this.CCHD = cCHD;
	}
	public String getBH() {
		return BH;
	}
	
	public void setBH(String bH) {
		this.BH = bH;
	}
	public String getFSYLB() {
		return FSYLB;
	}
	
	public void setFSYLB(String fSYLB) {
		this.FSYLB = fSYLB;
	}
	public String getSFLSTZ() {
		return SFLSTZ;
	}
	
	public void setSFLSTZ(String sFLSTZ) {
		this.SFLSTZ = sFLSTZ;
	}
	public String getFSYBM() {
		return FSYBM;
	}
	
	public void setFSYBM(String fSYBM) {
		this.FSYBM = fSYBM;
	}
	public String getZT() {
		return ZT;
	}
	
	public void setZT(String zT) {
		this.ZT = zT;
	}
	
}


