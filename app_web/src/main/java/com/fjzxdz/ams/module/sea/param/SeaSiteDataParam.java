/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.param;

import com.fjzxdz.ams.module.sea.entity.SeaSiteData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 省海洋与渔业厅数据Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class SeaSiteDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 湿度 */
	private Double SD;
	/** 叶绿素 */
	private String YLS;
	/** 磷酸盐浓度 */
	private String PSYND;
	/** 雨量_ENC */
	private Double rhEnc;
	/**  */
	private Double wdEdc;
	/** 溶解氧 */
	private String LJY;
	/** 盐度 千分 */
	private String YD;
	/** 风向 */
	private Double FX;
	/** 导电率mmho/cm */
	private String DDL;
	/**  */
	private String ZD;
	/** 站点编号 */
	private String ZDBH;
	/** 硝酸盐浓度 */
	private String XSYND;
	/** 气温 */
	private Double QW;
	/** 风速 */
	private Double FS;
	/** 站点名称 */
	private String ZDMC;
	/** 溶解氧饱和度mg/l */
	private String LJYBHD;
	/** PH */
	private String PH;
	/** 亚硝酸盐浓度 */
	private String YXSYND;
	/** 水温 */
	private Double SW;
	/**  */
	private Double BCSD;
	/** 采样时间 */
	private String JCSJ;
	/** 气压 */
	private Double QY;
	/** 表层盐度 */
	private String BCYD;
	/**  */
	private java.util.Date updatetimeRjw;
	/**  */
	private java.util.Date RKSJ;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public SeaSiteDataParam() {
		super(SeaSiteData.class);
		this.clazz = SeaSiteData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("SD", getSD(), SearchCondition.LIKE);
		addClause("YLS", getYLS(), SearchCondition.LIKE);
		addClause("PSYND", getPSYND(), SearchCondition.LIKE);
		addClause("rhEnc", getRhEnc(), SearchCondition.LIKE);
		addClause("wdEdc", getWdEdc(), SearchCondition.LIKE);
		addClause("LJY", getLJY(), SearchCondition.LIKE);
		addClause("YD", getYD(), SearchCondition.LIKE);
		addClause("FX", getFX(), SearchCondition.LIKE);
		addClause("DDL", getDDL(), SearchCondition.LIKE);
		addClause("ZD", getZD(), SearchCondition.LIKE);
		addClause("ZDBH", getZDBH(), SearchCondition.LIKE);
		addClause("XSYND", getXSYND(), SearchCondition.LIKE);
		addClause("QW", getQW(), SearchCondition.LIKE);
		addClause("FS", getFS(), SearchCondition.LIKE);
		addClause("ZDMC", getZDMC(), SearchCondition.LIKE);
		addClause("LJYBHD", getLJYBHD(), SearchCondition.LIKE);
		addClause("PH", getPH(), SearchCondition.LIKE);
		addClause("YXSYND", getYXSYND(), SearchCondition.LIKE);
		addClause("SW", getSW(), SearchCondition.LIKE);
		addClause("BCSD", getBCSD(), SearchCondition.LIKE);
		addClause("JCSJ", getJCSJ(), SearchCondition.LIKE);
		addClause("QY", getQY(), SearchCondition.LIKE);
		addClause("BCYD", getBCYD(), SearchCondition.LIKE);
		addClause("updatetimeRjw", getUpdatetimeRjw(), SearchCondition.LIKE);
		addClause("RKSJ", getRKSJ(), SearchCondition.LIKE);
		setOrderBy(" JCSJ desc");
	}
	
	public Double getSD() {
		return SD;
	}
	
	public void setSD(Double sD) {
		this.SD = sD;
	}
	public String getYLS() {
		return YLS;
	}
	
	public void setYLS(String yLS) {
		this.YLS = yLS;
	}
	public String getPSYND() {
		return PSYND;
	}
	
	public void setPSYND(String pSYND) {
		this.PSYND = pSYND;
	}
	public Double getRhEnc() {
		return rhEnc;
	}
	
	public void setRhEnc(Double rhEnc) {
		this.rhEnc = rhEnc;
	}
	public Double getWdEdc() {
		return wdEdc;
	}
	
	public void setWdEdc(Double wdEdc) {
		this.wdEdc = wdEdc;
	}
	public String getLJY() {
		return LJY;
	}
	
	public void setLJY(String lJY) {
		this.LJY = lJY;
	}
	public String getYD() {
		return YD;
	}
	
	public void setYD(String yD) {
		this.YD = yD;
	}
	public Double getFX() {
		return FX;
	}
	
	public void setFX(Double fX) {
		this.FX = fX;
	}
	public String getDDL() {
		return DDL;
	}
	
	public void setDDL(String dDL) {
		this.DDL = dDL;
	}
	public String getZD() {
		return ZD;
	}
	
	public void setZD(String zD) {
		this.ZD = zD;
	}
	public String getZDBH() {
		return ZDBH;
	}
	
	public void setZDBH(String zDBH) {
		this.ZDBH = zDBH;
	}
	public String getXSYND() {
		return XSYND;
	}
	
	public void setXSYND(String xSYND) {
		this.XSYND = xSYND;
	}
	public Double getQW() {
		return QW;
	}
	
	public void setQW(Double qW) {
		this.QW = qW;
	}
	public Double getFS() {
		return FS;
	}
	
	public void setFS(Double fS) {
		this.FS = fS;
	}
	public String getZDMC() {
		return ZDMC;
	}
	
	public void setZDMC(String zDMC) {
		this.ZDMC = zDMC;
	}
	public String getLJYBHD() {
		return LJYBHD;
	}
	
	public void setLJYBHD(String lJYBHD) {
		this.LJYBHD = lJYBHD;
	}
	public String getPH() {
		return PH;
	}
	
	public void setPH(String pH) {
		this.PH = pH;
	}
	public String getYXSYND() {
		return YXSYND;
	}
	
	public void setYXSYND(String yXSYND) {
		this.YXSYND = yXSYND;
	}
	public Double getSW() {
		return SW;
	}
	
	public void setSW(Double sW) {
		this.SW = sW;
	}
	public Double getBCSD() {
		return BCSD;
	}
	
	public void setBCSD(Double bCSD) {
		this.BCSD = bCSD;
	}
	public String getJCSJ() {
		return JCSJ;
	}
	
	public void setJCSJ(String jCSJ) {
		this.JCSJ = jCSJ;
	}
	public Double getQY() {
		return QY;
	}
	
	public void setQY(Double qY) {
		this.QY = qY;
	}
	public String getBCYD() {
		return BCYD;
	}
	
	public void setBCYD(String bCYD) {
		this.BCYD = bCYD;
	}
	public java.util.Date getUpdatetimeRjw() {
		return updatetimeRjw;
	}
	
	public void setUpdatetimeRjw(java.util.Date updatetimeRjw) {
		this.updatetimeRjw = updatetimeRjw;
	}
	public java.util.Date getRKSJ() {
		return RKSJ;
	}
	
	public void setRKSJ(java.util.Date rKSJ) {
		this.RKSJ = rKSJ;
	}
	
}


