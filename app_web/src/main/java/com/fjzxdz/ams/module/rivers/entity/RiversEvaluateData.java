/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 海河流水质评价结果Entity
 * @author lilongan
 * @version 2019-02-20
 */
@Entity
@Table(name = "RIVERS_EVALUATE_DATA")
public class RiversEvaluateData implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 站点编码 */
	@Id
	private Double POINTCODE;
	/** 水质目标编码 */
	private String codeWaterqualityleveltarget;
	/** 水质现状编码 */
	private String codeWaterqualitylevel;
	/** 年 */
	@Id
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
	@Id
	private String MONTHNUMBER;
	/** 水质目标 */
	private String WATERQUALITYLEVELTARGETNAME;
	/** 站点名称 */
	private String POINTNAME;
	
	public Double getPOINTCODE() {
		return POINTCODE;
	}

	public void setPOINTCODE(Double pOINTCODE) {
		this.POINTCODE = POINTCODE;
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
		this.YEARNUMBER = YEARNUMBER;
	}
	public String getREGIONNAME() {
		return REGIONNAME;
	}

	public void setREGIONNAME(String rEGIONNAME) {
		this.REGIONNAME = REGIONNAME;
	}
	public String getPRIMPOLLUTE() {
		return PRIMPOLLUTE;
	}

	public void setPRIMPOLLUTE(String pRIMPOLLUTE) {
		this.PRIMPOLLUTE = PRIMPOLLUTE;
	}
	public String getTASKWATERS() {
		return TASKWATERS;
	}

	public void setTASKWATERS(String tASKWATERS) {
		this.TASKWATERS = TASKWATERS;
	}
	public String getWATERNAME() {
		return WATERNAME;
	}

	public void setWATERNAME(String wATERNAME) {
		this.WATERNAME = WATERNAME;
	}
	public String getWATERQUALITYLEVELNAME() {
		return WATERQUALITYLEVELNAME;
	}

	public void setWATERQUALITYLEVELNAME(String wATERQUALITYLEVELNAME) {
		this.WATERQUALITYLEVELNAME = WATERQUALITYLEVELNAME;
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
		this.WATERCODE = WATERCODE;
	}
	public String getMONTHNUMBER() {
		return MONTHNUMBER;
	}

	public void setMONTHNUMBER(String mONTHNUMBER) {
		this.MONTHNUMBER = MONTHNUMBER;
	}
	public String getWATERQUALITYLEVELTARGETNAME() {
		return WATERQUALITYLEVELTARGETNAME;
	}

	public void setWATERQUALITYLEVELTARGETNAME(String wATERQUALITYLEVELTARGETNAME) {
		this.WATERQUALITYLEVELTARGETNAME = WATERQUALITYLEVELTARGETNAME;
	}
	public String getPOINTNAME() {
		return POINTNAME;
	}

	public void setPOINTNAME(String pOINTNAME) {
		this.POINTNAME = POINTNAME;
	}
	
}


