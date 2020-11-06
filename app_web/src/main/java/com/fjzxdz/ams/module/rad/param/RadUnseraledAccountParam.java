/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.param;

import com.fjzxdz.ams.module.rad.entity.RadUnseraledAccount;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 非密封台账Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class RadUnseraledAccountParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 审核人 */
	private String SHR;
	/** 核素名称 */
	private String HSMC;
	/** 单位自动编号 */
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
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RadUnseraledAccountParam() {
		super(RadUnseraledAccount.class);
		this.clazz = RadUnseraledAccount.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("SHR", getSHR(), SearchCondition.LIKE);
		addClause("HSMC", getHSMC(), SearchCondition.LIKE);
		addClause("ENTERID", getENTERID(), SearchCondition.LIKE);
		addClause("QX", getQX(), SearchCondition.LIKE);
		addClause("XQSHR", getXQSHR(), SearchCondition.LIKE);
		addClause("HD", getHD(), SearchCondition.LIKE);
		addClause("LY", getLY(), SearchCondition.LIKE);
		addClause("PKID", getPKID(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("SHRQ", getSHRQ(), SearchCondition.LIKE);
		addClause("QXSHRQ", getQXSHRQ(), SearchCondition.LIKE);
		addClause("YT", getYT(), SearchCondition.LIKE);
		addClause("BZ", getBZ(), SearchCondition.LIKE);
		addClause("PC", getPC(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getSHR() {
		return SHR;
	}
	
	public void setSHR(String sHR) {
		this.SHR = sHR;
	}
	public String getHSMC() {
		return HSMC;
	}
	
	public void setHSMC(String hSMC) {
		this.HSMC = hSMC;
	}
	public String getENTERID() {
		return ENTERID;
	}
	
	public void setENTERID(String eNTERID) {
		this.ENTERID = eNTERID;
	}
	public String getQX() {
		return QX;
	}
	
	public void setQX(String qX) {
		this.QX = qX;
	}
	public String getXQSHR() {
		return XQSHR;
	}
	
	public void setXQSHR(String xQSHR) {
		this.XQSHR = xQSHR;
	}
	public String getHD() {
		return HD;
	}
	
	public void setHD(String hD) {
		this.HD = hD;
	}
	public String getLY() {
		return LY;
	}
	
	public void setLY(String lY) {
		this.LY = lY;
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
	public String getYT() {
		return YT;
	}
	
	public void setYT(String yT) {
		this.YT = yT;
	}
	public String getBZ() {
		return BZ;
	}
	
	public void setBZ(String bZ) {
		this.BZ = bZ;
	}
	public String getPC() {
		return PC;
	}
	
	public void setPC(String pC) {
		this.PC = pC;
	}
	
}


