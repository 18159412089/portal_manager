/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.param;

import com.fjzxdz.ams.module.rivers.entity.RiversSiteMonitorData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 入海河流监测数据Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiversSiteMonitorDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	private String POINTCODE;
	/** 污染物名称 */
	private String POLLUTENAME;
	/** 污染物编码 */
	private String codePollute;
	/** 监测时间 */
	private String MONITORTIME;
	/** 污染物浓度 */
	private String POLLUTEVALUE;
	/** 站点名称 */
	private String POINTNAME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiversSiteMonitorDataParam() {
		super(RiversSiteMonitorData.class);
		this.clazz = RiversSiteMonitorData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("POINTCODE", getPOINTCODE(), SearchCondition.LIKE);
		addClause("POLLUTENAME", getPOLLUTENAME(), SearchCondition.LIKE);
		addClause("codePollute", getCodePollute(), SearchCondition.LIKE);
		addClause("MONITORTIME", getMONITORTIME(), SearchCondition.LIKE);
		addClause("POLLUTEVALUE", getPOLLUTEVALUE(), SearchCondition.LIKE);
		addClause("POINTNAME", getPOINTNAME(), SearchCondition.LIKE);
		setOrderBy(" MONITORTIME desc");
	}

	public String getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(String pOINTCODE) {
		POINTCODE = pOINTCODE;
	}

	public String getPOLLUTENAME() {
		return POLLUTENAME;
	}

	public void setPOLLUTENAME(String pOLLUTENAME) {
		POLLUTENAME = pOLLUTENAME;
	}

	public String getCodePollute() {
		return codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public String getMONITORTIME() {
		return MONITORTIME;
	}

	public void setMONITORTIME(String mONITORTIME) {
		MONITORTIME = mONITORTIME;
	}

	public String getPOLLUTEVALUE() {
		return POLLUTEVALUE;
	}

	public void setPOLLUTEVALUE(String pOLLUTEVALUE) {
		POLLUTEVALUE = pOLLUTEVALUE;
	}

	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		POINTNAME = pOINTNAME;
	}
	
	 
	
}


