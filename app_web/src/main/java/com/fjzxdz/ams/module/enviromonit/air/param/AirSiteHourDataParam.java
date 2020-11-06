/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.air.param;

import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 空气站点气象小时数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class AirSiteHourDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 风向 */
	private String WINDDIRT;
	/** 区县 */
	private String AREANAME;
	/** 状态 */
	private String STATE;
	/** 降雨量 */
	private String RAINFALL;
	/** 点位名称 */
	private String POSCODE;
	/** 风速 */
	private String WINDSPD;
	/** 点位代码 */
	private String POTCODE;
	/** 所属地市 */
	private String SAREANAME;
	/** 温度 */
	private String TEMP;
	/** 气压 */
	private String PRESSURE;
	/** 点位名称 */
	private String POTNAME;
	/** 湿度 */
	private String HUMI;
	/** 监测时间 */
	private java.util.Date CHECKTIME;


	private String startTime;

	private String endTime;


	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public AirSiteHourDataParam() {
		super(AirSiteHourData.class);
		this.clazz = AirSiteHourData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("WINDDIRT", getWINDDIRT(), SearchCondition.LIKE);
		addClause("AREANAME", getAREANAME(), SearchCondition.LIKE);
		addClause("STATE", getSTATE(), SearchCondition.LIKE);
		addClause("RAINFALL", getRAINFALL(), SearchCondition.LIKE);
		addClause("POSCODE", getPOSCODE(), SearchCondition.LIKE);
		addClause("WINDSPD", getWINDSPD(), SearchCondition.LIKE);
		addClause("POTCODE", getPOTCODE(), SearchCondition.LIKE);
		addClause("SAREANAME", getSAREANAME(), SearchCondition.LIKE);
		addClause("TEMP", getTEMP(), SearchCondition.LIKE);
		addClause("PRESSURE", getPRESSURE(), SearchCondition.LIKE);
		addClause("POTNAME", getPOTNAME(), SearchCondition.LIKE);
		addClause("HUMI", getHUMI(), SearchCondition.LIKE);
		addClause("CHECKTIME", getCHECKTIME(), SearchCondition.LIKE);
		setOrderBy(" CHECKTIME desc");
	}
	
	public String getWINDDIRT() {
		return WINDDIRT;
	}
	
	public void setWINDDIRT(String wINDDIRT) {
		this.WINDDIRT = wINDDIRT;
	}
	public String getAREANAME() {
		return AREANAME;
	}
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setAREANAME(String aREANAME) {
		this.AREANAME = aREANAME;
	}
	public String getSTATE() {
		return STATE;
	}
	
	public void setSTATE(String sTATE) {
		this.STATE = sTATE;
	}
	public String getRAINFALL() {
		return RAINFALL;
	}
	
	public void setRAINFALL(String rAINFALL) {
		this.RAINFALL = rAINFALL;
	}
	public String getPOSCODE() {
		return POSCODE;
	}
	
	public void setPOSCODE(String pOSCODE) {
		this.POSCODE = pOSCODE;
	}
	public String getWINDSPD() {
		return WINDSPD;
	}
	
	public void setWINDSPD(String wINDSPD) {
		this.WINDSPD = wINDSPD;
	}
	public String getPOTCODE() {
		return POTCODE;
	}
	
	public void setPOTCODE(String pOTCODE) {
		this.POTCODE = pOTCODE;
	}
	public String getSAREANAME() {
		return SAREANAME;
	}
	
	public void setSAREANAME(String sAREANAME) {
		this.SAREANAME = sAREANAME;
	}
	public String getTEMP() {
		return TEMP;
	}
	
	public void setTEMP(String tEMP) {
		this.TEMP = tEMP;
	}
	public String getPRESSURE() {
		return PRESSURE;
	}
	
	public void setPRESSURE(String pRESSURE) {
		this.PRESSURE = pRESSURE;
	}
	public String getPOTNAME() {
		return POTNAME;
	}
	
	public void setPOTNAME(String pOTNAME) {
		this.POTNAME = pOTNAME;
	}
	public String getHUMI() {
		return HUMI;
	}
	
	public void setHUMI(String hUMI) {
		this.HUMI = hUMI;
	}
	public java.util.Date getCHECKTIME() {
		return CHECKTIME;
	}
	
	public void setCHECKTIME(java.util.Date cHECKTIME) {
		this.CHECKTIME = cHECKTIME;
	}
	
}


