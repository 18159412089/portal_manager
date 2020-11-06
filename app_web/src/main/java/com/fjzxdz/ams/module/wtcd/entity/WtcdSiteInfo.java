/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.hutool.json.JSONObject;

/**
 * 水利厅水文站点Entity
 * @author lilongan
 * @version 2019-02-19
 */
@Entity
@Table(name = "WTCD_SITE_INFO")
public class WtcdSiteInfo implements Serializable {
	
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
	@Id
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
	
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "wtcdSiteInfo")
	private Set<WtcdRiverwayData> wtcdRiverwayDatasSet  = new HashSet<WtcdRiverwayData>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "wtcdSiteInfo")
	private Set<WtcdReservoirData> wtcdReservoirDatasSet  = new HashSet<WtcdReservoirData>();
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "wtcdSiteInfo")
	private Set<WtcdRainfallData> wtcdRainfallDatasSet  = new HashSet<WtcdRainfallData>();
	
	public Set<WtcdRiverwayData> getWtcdRiverwayDatasSet() {
		return wtcdRiverwayDatasSet;
	}

	public void setWtcdRiverwayDatasSet(Set<WtcdRiverwayData> wtcdRiverwayDatasSet) {
		this.wtcdRiverwayDatasSet = wtcdRiverwayDatasSet;
	}

	public Set<WtcdReservoirData> getWtcdReservoirDatasSet() {
		return wtcdReservoirDatasSet;
	}

	public void setWtcdReservoirDatasSet(Set<WtcdReservoirData> wtcdReservoirDatasSet) {
		this.wtcdReservoirDatasSet = wtcdReservoirDatasSet;
	}

	public Set<WtcdRainfallData> getWtcdRainfallDatasSet() {
		return wtcdRainfallDatasSet;
	}

	public void setWtcdRainfallDatasSet(Set<WtcdRainfallData> wtcdRainfallDatasSet) {
		this.wtcdRainfallDatasSet = wtcdRainfallDatasSet;
	}

	public String getPHCD() {
		return PHCD;
	}

	public void setPHCD(String pHCD) {
		this.PHCD = PHCD;
	}
	public String getUSFL() {
		return USFL;
	}

	public void setUSFL(String uSFL) {
		this.USFL = USFL;
	}
	public Double getDTPR() {
		return DTPR;
	}

	public void setDTPR(Double dTPR) {
		this.DTPR = DTPR;
	}
	public String getSTTP() {
		return STTP;
	}

	public void setSTTP(String sTTP) {
		this.STTP = STTP;
	}
	public Integer getDRNA() {
		return DRNA;
	}

	public void setDRNA(Integer dRNA) {
		this.DRNA = DRNA;
	}
	public Double getDTMEL() {
		return DTMEL;
	}

	public void setDTMEL(Double dTMEL) {
		this.DTMEL = DTMEL;
	}
	public String getBGFRYM() {
		return BGFRYM;
	}

	public void setBGFRYM(String bGFRYM) {
		this.BGFRYM = BGFRYM;
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
		this.LOCALITY = LOCALITY;
	}
	public Double getDSTRVM() {
		return DSTRVM;
	}

	public void setDSTRVM(Double dSTRVM) {
		this.DSTRVM = DSTRVM;
	}
	public String getSTLC() {
		return STLC;
	}

	public void setSTLC(String sTLC) {
		this.STLC = STLC;
	}
	public String getADDVCD() {
		return ADDVCD;
	}

	public void setADDVCD(String aDDVCD) {
		this.ADDVCD = ADDVCD;
	}
	public String getSTCD() {
		return STCD;
	}

	public void setSTCD(String sTCD) {
		this.STCD = STCD;
	}
	public Double getLTTD() {
		return LTTD;
	}

	public void setLTTD(Double lTTD) {
		this.LTTD = LTTD;
	}
	public String getRVNM() {
		return RVNM;
	}

	public void setRVNM(String rVNM) {
		this.RVNM = RVNM;
	}
	public Integer getSTAZT() {
		return STAZT;
	}

	public void setSTAZT(Integer sTAZT) {
		this.STAZT = STAZT;
	}
	public Double getLGTD() {
		return LGTD;
	}

	public void setLGTD(Double lGTD) {
		this.LGTD = LGTD;
	}
	public String getCOMMENTS() {
		return COMMENTS;
	}

	public void setCOMMENTS(String cOMMENTS) {
		this.COMMENTS = COMMENTS;
	}
	public String getBSNM() {
		return BSNM;
	}

	public void setBSNM(String bSNM) {
		this.BSNM = BSNM;
	}
	public String getESSYM() {
		return ESSYM;
	}

	public void setESSYM(String eSSYM) {
		this.ESSYM = ESSYM;
	}
	public String getADMAUTH() {
		return ADMAUTH;
	}

	public void setADMAUTH(String aDMAUTH) {
		this.ADMAUTH = ADMAUTH;
	}
	public String getSTNM() {
		return STNM;
	}

	public void setSTNM(String sTNM) {
		this.STNM = STNM;
	}
	public String getATCUNIT() {
		return ATCUNIT;
	}

	public void setATCUNIT(String aTCUNIT) {
		this.ATCUNIT = ATCUNIT;
	}
	public String getDTMNM() {
		return DTMNM;
	}

	public void setDTMNM(String dTMNM) {
		this.DTMNM = DTMNM;
	}
	public String getFRGRD() {
		return FRGRD;
	}

	public void setFRGRD(String fRGRD) {
		this.FRGRD = FRGRD;
	}
	public String getHNNM() {
		return HNNM;
	}

	public void setHNNM(String hNNM) {
		this.HNNM = HNNM;
	}
	public String getSTBK() {
		return STBK;
	}

	public void setSTBK(String sTBK) {
		this.STBK = STBK;
	}
	public java.util.Date getMODITIME() {
		return MODITIME;
	}

	public void setMODITIME(java.util.Date mODITIME) {
		this.MODITIME = MODITIME;
	}
	
	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("PHCD", this.getPHCD());
		obj.put("USFL", this.getUSFL());
		obj.put("DTPR", this.getDTPR());
		obj.put("STTP", this.getSTTP());
		obj.put("DRNA", this.getDRNA());
		obj.put("DTMEL", this.getDTMEL());
		obj.put("BGFRYM", this.getBGFRYM());
		obj.put("updatetimeRjwa", this.getUpdatetimeRjwa());
		obj.put("LOCALITY", this.getLOCALITY());
		obj.put("DSTRVM", this.getDSTRVM());
		obj.put("STLC", this.getSTLC());
		obj.put("ADDVCD", this.getADDVCD());
		obj.put("STCD", this.getSTCD());
		obj.put("LTTD", this.getLTTD());
		obj.put("RVNM", this.getRVNM());
		obj.put("STAZT", this.getSTAZT());
		obj.put("LGTD", this.getLGTD());
		obj.put("COMMENTS", this.getCOMMENTS());
		obj.put("BSNM", this.getBSNM());
		obj.put("ESSYM", this.getESSYM());
		obj.put("ADMAUTH", this.getADMAUTH());
		obj.put("STNM", this.getSTNM());
		obj.put("ATCUNIT", this.getATCUNIT());
		obj.put("DTMNM", this.getDTMNM());
		obj.put("FRGRD", this.getFRGRD());
		obj.put("HNNM", this.getHNNM());
		obj.put("STBK", this.getSTBK());
		
		return obj;
	}
}


