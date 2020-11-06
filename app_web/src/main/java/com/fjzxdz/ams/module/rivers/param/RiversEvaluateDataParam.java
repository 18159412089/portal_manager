/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.param;

import com.fjzxdz.ams.module.rivers.entity.RiversEvaluateData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 海河流水质评价结果Entity
 * @author lilongan
 * @version 2019-02-20
 */
public class RiversEvaluateDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	private String POINTCODE;
	/** 水质目标编码 */
	private String codeWaterqualityleveltarget;
	/** 水质现状编码 */
	private String codeWaterqualitylevel;
	/** 年 */
	private String YEARNUMBER;
	/** 行政区名称 */
	private String REGIONNAME;
	/**  */
	private String PRIMPOLLUTE;
	/** 流量 */
	private String TASKWATERS;
	/** 流域名称 */
	private String WATERNAME;
	/** 水质现状 */
	private String WATERQUALITYLEVELNAME;
	/** 行政区编码 */
	private String codeRegion;
	/** 流域编码 */
	private String WATERCODE;
	/** 月 */
	private String MONTHNUMBER;
	/** 水质目标 */
	private String WATERQUALITYLEVELTARGETNAME;
	/** 站点名称 */
	private String POINTNAME;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RiversEvaluateDataParam() {
		super(RiversEvaluateData.class);
		this.clazz = RiversEvaluateData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("POINTCODE", getPOINTCODE(), SearchCondition.LIKE);
		addClause("codeWaterqualityleveltarget", getCodeWaterqualityleveltarget(), SearchCondition.LIKE);
		addClause("codeWaterqualitylevel", getCodeWaterqualitylevel(), SearchCondition.LIKE);
		addClause("YEARNUMBER", getYEARNUMBER(), SearchCondition.LIKE);
		addClause("REGIONNAME", getREGIONNAME(), SearchCondition.LIKE);
		addClause("PRIMPOLLUTE", getPRIMPOLLUTE(), SearchCondition.LIKE);
		addClause("TASKWATERS", getTASKWATERS(), SearchCondition.LIKE);
		addClause("WATERNAME", getWATERNAME(), SearchCondition.LIKE);
		addClause("WATERQUALITYLEVELNAME", getWATERQUALITYLEVELNAME(), SearchCondition.LIKE);
		addClause("codeRegion", getCodeRegion(), SearchCondition.LIKE);
		addClause("WATERCODE", getWATERCODE(), SearchCondition.LIKE);
		addClause("MONTHNUMBER", getMONTHNUMBER(), SearchCondition.LIKE);
		addClause("WATERQUALITYLEVELTARGETNAME", getWATERQUALITYLEVELTARGETNAME(), SearchCondition.LIKE);
		addClause("POINTNAME", getPOINTNAME(), SearchCondition.LIKE);
	}

	public String getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(String pOINTCODE) {
		POINTCODE = pOINTCODE;
	}

	public String getCodeWaterqualityleveltarget() {
		return codeWaterqualityleveltarget;
	}

	public void setCodeWaterqualityleveltarget(String codeWaterqualityleveltarget) {
		this.codeWaterqualityleveltarget = codeWaterqualityleveltarget;
	}

	public String getCodeWaterqualitylevel() {
		return codeWaterqualitylevel;
	}

	public void setCodeWaterqualitylevel(String codeWaterqualitylevel) {
		this.codeWaterqualitylevel = codeWaterqualitylevel;
	}

	public String getYEARNUMBER() {
		return YEARNUMBER;
	}

	public void setYEARNUMBER(String yEARNUMBER) {
		YEARNUMBER = yEARNUMBER;
	}

	public String getREGIONNAME() {
		return REGIONNAME;
	}

	public void setREGIONNAME(String rEGIONNAME) {
		REGIONNAME = rEGIONNAME;
	}

	public String getPRIMPOLLUTE() {
		return PRIMPOLLUTE;
	}

	public void setPRIMPOLLUTE(String pRIMPOLLUTE) {
		PRIMPOLLUTE = pRIMPOLLUTE;
	}

	public String getTASKWATERS() {
		return TASKWATERS;
	}

	public void setTASKWATERS(String tASKWATERS) {
		TASKWATERS = tASKWATERS;
	}

	public String getWATERNAME() {
		return WATERNAME;
	}

	public void setWATERNAME(String wATERNAME) {
		WATERNAME = wATERNAME;
	}

	public String getWATERQUALITYLEVELNAME() {
		return WATERQUALITYLEVELNAME;
	}

	public void setWATERQUALITYLEVELNAME(String wATERQUALITYLEVELNAME) {
		WATERQUALITYLEVELNAME = wATERQUALITYLEVELNAME;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}

	public String getWATERCODE() {
		return WATERCODE;
	}

	public void setWATERCODE(String wATERCODE) {
		WATERCODE = wATERCODE;
	}

	public String getMONTHNUMBER() {
		return MONTHNUMBER;
	}

	public void setMONTHNUMBER(String mONTHNUMBER) {
		MONTHNUMBER = mONTHNUMBER;
	}

	public String getWATERQUALITYLEVELTARGETNAME() {
		return WATERQUALITYLEVELTARGETNAME;
	}

	public void setWATERQUALITYLEVELTARGETNAME(String wATERQUALITYLEVELTARGETNAME) {
		WATERQUALITYLEVELTARGETNAME = wATERQUALITYLEVELTARGETNAME;
	}

	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		POINTNAME = pOINTNAME;
	}
	
	 
	
}


