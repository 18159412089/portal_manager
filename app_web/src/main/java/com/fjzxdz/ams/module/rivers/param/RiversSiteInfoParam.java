/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.param;

import com.fjzxdz.ams.module.rivers.entity.RiversSiteInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 入海河流点位信息Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiversSiteInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	private Double POINTCODE;
	/** 行政区编码 */
	private String codeRegion;
	/** 经度 */
	private String LONGITUDE;
	/** 流域名称 */
	private String WSYSTEMNAME;
	/** 行政区名称 */
	private String REGIONNAME;
	/** 流域编码 */
	private String codeWsystem;
	/** 纬度 */
	private String LATITUDE;
	/** 站点名称 */
	private String POINTNAME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiversSiteInfoParam() {
		super(RiversSiteInfo.class);
		this.clazz = RiversSiteInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("POINTCODE", getPOINTCODE(), SearchCondition.LIKE);
		addClause("codeRegion", getCodeRegion(), SearchCondition.LIKE);
		addClause("LONGITUDE", getLONGITUDE(), SearchCondition.LIKE);
		addClause("WSYSTEMNAME", getWSYSTEMNAME(), SearchCondition.LIKE);
		addClause("REGIONNAME", getREGIONNAME(), SearchCondition.LIKE);
		addClause("codeWsystem", getCodeWsystem(), SearchCondition.LIKE);
		addClause("LATITUDE", getLATITUDE(), SearchCondition.LIKE);
		addClause("POINTNAME", getPOINTNAME(), SearchCondition.LIKE);
	}

	public Double getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(Double pOINTCODE) {
		POINTCODE = pOINTCODE;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}

	public String getLONGITUDE() {
		return LONGITUDE;
	}

	public void setLONGITUDE(String lONGITUDE) {
		LONGITUDE = lONGITUDE;
	}

	public String getWSYSTEMNAME() {
		return WSYSTEMNAME;
	}

	public void setWSYSTEMNAME(String wSYSTEMNAME) {
		WSYSTEMNAME = wSYSTEMNAME;
	}

	public String getREGIONNAME() {
		return REGIONNAME;
	}

	public void setREGIONNAME(String rEGIONNAME) {
		REGIONNAME = rEGIONNAME;
	}

	public String getCodeWsystem() {
		return codeWsystem;
	}

	public void setCodeWsystem(String codeWsystem) {
		this.codeWsystem = codeWsystem;
	}

	public String getLATITUDE() {
		return LATITUDE;
	}

	public void setLATITUDE(String lATITUDE) {
		LATITUDE = lATITUDE;
	}

	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		POINTNAME = pOINTNAME;
	}
	
	 
	
}


