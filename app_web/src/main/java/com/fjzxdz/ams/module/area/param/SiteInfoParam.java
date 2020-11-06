/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.param;

import com.fjzxdz.ams.module.area.entity.SiteInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 近岸海域点位信息Entity
 * @author htj
 * @version 2019-02-20
 */
public class SiteInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 年份 */
	private java.util.Date GXSJ;
	/** 纬度 */
	private Double NF;
	/**  */
	private String XZQH;
	/**  */
	private String KDMC;
	/**  */
	private Double WD;
	/** 经度 */
	private Double JD;
	/** 国控点位编码 */
	private String GKBM;
	/** 省控点位编码 */
	private String SKBM;
	/**  */
	private String GW;
	/**  */
	private String ZT;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public SiteInfoParam() {
		super(SiteInfo.class);
		this.clazz = SiteInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("GXSJ", getGXSJ(), SearchCondition.LIKE);
		addClause("NF", getNF(), SearchCondition.LIKE);
		addClause("XZQH", getXZQH(), SearchCondition.LIKE);
		addClause("KDMC", getKDMC(), SearchCondition.LIKE);
		addClause("WD", getWD(), SearchCondition.LIKE);
		addClause("JD", getJD(), SearchCondition.LIKE);
		addClause("GKBM", getGKBM(), SearchCondition.LIKE);
		addClause("SKBM", getSKBM(), SearchCondition.LIKE);
		addClause("GW", getGW(), SearchCondition.LIKE);
		addClause("ZT", getZT(), SearchCondition.LIKE);
		setOrderBy(" GXSJ desc");
	}

	public java.util.Date getGXSJ() {
		return GXSJ;
	}

	public void setGXSJ(java.util.Date gXSJ) {
		GXSJ = gXSJ;
	}

	public Double getNF() {
		return NF;
	}

	public void setNF(Double nF) {
		NF = nF;
	}

	public String getXZQH() {
		return XZQH;
	}

	public void setXZQH(String xZQH) {
		XZQH = xZQH;
	}

	public String getKDMC() {
		return KDMC;
	}

	public void setKDMC(String kDMC) {
		KDMC = kDMC;
	}

	public Double getWD() {
		return WD;
	}

	public void setWD(Double wD) {
		WD = wD;
	}

	public Double getJD() {
		return JD;
	}

	public void setJD(Double jD) {
		JD = jD;
	}

	public String getGKBM() {
		return GKBM;
	}

	public void setGKBM(String gKBM) {
		GKBM = gKBM;
	}

	public String getSKBM() {
		return SKBM;
	}

	public void setSKBM(String sKBM) {
		SKBM = sKBM;
	}

	public String getGW() {
		return GW;
	}

	public void setGW(String gW) {
		GW = gW;
	}

	public String getZT() {
		return ZT;
	}

	public void setZT(String zT) {
		ZT = zT;
	}
	
	 
}


