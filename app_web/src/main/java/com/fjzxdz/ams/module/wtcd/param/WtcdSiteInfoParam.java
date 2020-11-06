/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.param;

import com.fjzxdz.ams.module.wtcd.entity.WtcdSiteInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水利厅水文站点Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class WtcdSiteInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 拼音码 */
	private String PHCD;
	/** 启用标志 */
	private String USFL;
	/** 基面修正值 */
	private Double DTPR;
	/** 站类 */
	private String STTP;
	/** 集水面积 */
	private Integer DRNA;
	/** 基面高程 */
	private Double DTMEL;
	/** 始报年月 */
	private String BGFRYM;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 交换管理单位 */
	private String LOCALITY;
	/** 至河口距离 */
	private Double DSTRVM;
	/** 站址 */
	private String STLC;
	/** 行政区划码 */
	private String ADDVCD;
	/** 测站编码 */
	private String STCD;
	/** 纬度 */
	private Double LTTD;
	/** 河流名称 */
	private String RVNM;
	/** 测站方位 */
	private Integer STAZT;
	/** 经度 */
	private Double LGTD;
	/** 备注 */
	private String COMMENTS;
	/** 流域名称 */
	private String BSNM;
	/** 建站年月 */
	private String ESSYM;
	/** 信息管理单位 */
	private String ADMAUTH;
	/** 测站名称 */
	private String STNM;
	/** 隶属行业单位 */
	private String ATCUNIT;
	/** 基面名称 */
	private String DTMNM;
	/** 报汛等级 */
	private String FRGRD;
	/** 水系名称 */
	private String HNNM;
	/** 测站岸别 */
	private String STBK;
	/**  */
	private java.util.Date MODITIME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtcdSiteInfoParam() {
		super(WtcdSiteInfo.class);
		this.clazz = WtcdSiteInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("PHCD", getPHCD(), SearchCondition.LIKE);
		addClause("USFL", getUSFL(), SearchCondition.LIKE);
		addClause("DTPR", getDTPR(), SearchCondition.LIKE);
		addClause("STTP", getSTTP(), SearchCondition.LIKE);
		addClause("DRNA", getDRNA(), SearchCondition.LIKE);
		addClause("DTMEL", getDTMEL(), SearchCondition.LIKE);
		addClause("BGFRYM", getBGFRYM(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("LOCALITY", getLOCALITY(), SearchCondition.LIKE);
		addClause("DSTRVM", getDSTRVM(), SearchCondition.LIKE);
		addClause("STLC", getSTLC(), SearchCondition.LIKE);
		addClause("ADDVCD", getADDVCD(), SearchCondition.LIKE);
		addClause("STCD", getSTCD(), SearchCondition.LIKE);
		addClause("LTTD", getLTTD(), SearchCondition.LIKE);
		addClause("RVNM", getRVNM(), SearchCondition.LIKE);
		addClause("STAZT", getSTAZT(), SearchCondition.LIKE);
		addClause("LGTD", getLGTD(), SearchCondition.LIKE);
		addClause("COMMENTS", getCOMMENTS(), SearchCondition.LIKE);
		addClause("BSNM", getBSNM(), SearchCondition.LIKE);
		addClause("ESSYM", getESSYM(), SearchCondition.LIKE);
		addClause("ADMAUTH", getADMAUTH(), SearchCondition.LIKE);
		addClause("STNM", getSTNM(), SearchCondition.LIKE);
		addClause("ATCUNIT", getATCUNIT(), SearchCondition.LIKE);
		addClause("DTMNM", getDTMNM(), SearchCondition.LIKE);
		addClause("FRGRD", getFRGRD(), SearchCondition.LIKE);
		addClause("HNNM", getHNNM(), SearchCondition.LIKE);
		addClause("STBK", getSTBK(), SearchCondition.LIKE);
		addClause("MODITIME", getMODITIME(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getPHCD() {
		return PHCD;
	}
	
	public void setPHCD(String pHCD) {
		this.PHCD = pHCD;
	}
	public String getUSFL() {
		return USFL;
	}
	
	public void setUSFL(String uSFL) {
		this.USFL = uSFL;
	}
	public Double getDTPR() {
		return DTPR;
	}
	
	public void setDTPR(Double dTPR) {
		this.DTPR = dTPR;
	}
	public String getSTTP() {
		return STTP;
	}
	
	public void setSTTP(String sTTP) {
		this.STTP = sTTP;
	}
	public Integer getDRNA() {
		return DRNA;
	}
	
	public void setDRNA(Integer dRNA) {
		this.DRNA = dRNA;
	}
	public Double getDTMEL() {
		return DTMEL;
	}
	
	public void setDTMEL(Double dTMEL) {
		this.DTMEL = dTMEL;
	}
	public String getBGFRYM() {
		return BGFRYM;
	}
	
	public void setBGFRYM(String bGFRYM) {
		this.BGFRYM = bGFRYM;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}
	
	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public String getLOCALITY() {
		return LOCALITY;
	}
	
	public void setLOCALITY(String lOCALITY) {
		this.LOCALITY = lOCALITY;
	}
	public Double getDSTRVM() {
		return DSTRVM;
	}
	
	public void setDSTRVM(Double dSTRVM) {
		this.DSTRVM = dSTRVM;
	}
	public String getSTLC() {
		return STLC;
	}
	
	public void setSTLC(String sTLC) {
		this.STLC = sTLC;
	}
	public String getADDVCD() {
		return ADDVCD;
	}
	
	public void setADDVCD(String aDDVCD) {
		this.ADDVCD = aDDVCD;
	}
	public String getSTCD() {
		return STCD;
	}
	
	public void setSTCD(String sTCD) {
		this.STCD = sTCD;
	}
	public Double getLTTD() {
		return LTTD;
	}
	
	public void setLTTD(Double lTTD) {
		this.LTTD = lTTD;
	}
	public String getRVNM() {
		return RVNM;
	}
	
	public void setRVNM(String rVNM) {
		this.RVNM = rVNM;
	}
	public Integer getSTAZT() {
		return STAZT;
	}
	
	public void setSTAZT(Integer sTAZT) {
		this.STAZT = sTAZT;
	}
	public Double getLGTD() {
		return LGTD;
	}
	
	public void setLGTD(Double lGTD) {
		this.LGTD = lGTD;
	}
	public String getCOMMENTS() {
		return COMMENTS;
	}
	
	public void setCOMMENTS(String cOMMENTS) {
		this.COMMENTS = cOMMENTS;
	}
	public String getBSNM() {
		return BSNM;
	}
	
	public void setBSNM(String bSNM) {
		this.BSNM = bSNM;
	}
	public String getESSYM() {
		return ESSYM;
	}
	
	public void setESSYM(String eSSYM) {
		this.ESSYM = eSSYM;
	}
	public String getADMAUTH() {
		return ADMAUTH;
	}
	
	public void setADMAUTH(String aDMAUTH) {
		this.ADMAUTH = aDMAUTH;
	}
	public String getSTNM() {
		return STNM;
	}
	
	public void setSTNM(String sTNM) {
		this.STNM = sTNM;
	}
	public String getATCUNIT() {
		return ATCUNIT;
	}
	
	public void setATCUNIT(String aTCUNIT) {
		this.ATCUNIT = aTCUNIT;
	}
	public String getDTMNM() {
		return DTMNM;
	}
	
	public void setDTMNM(String dTMNM) {
		this.DTMNM = dTMNM;
	}
	public String getFRGRD() {
		return FRGRD;
	}
	
	public void setFRGRD(String fRGRD) {
		this.FRGRD = fRGRD;
	}
	public String getHNNM() {
		return HNNM;
	}
	
	public void setHNNM(String hNNM) {
		this.HNNM = hNNM;
	}
	public String getSTBK() {
		return STBK;
	}
	
	public void setSTBK(String sTBK) {
		this.STBK = sTBK;
	}
	public java.util.Date getMODITIME() {
		return MODITIME;
	}
	
	public void setMODITIME(java.util.Date mODITIME) {
		this.MODITIME = mODITIME;
	}
	
}


