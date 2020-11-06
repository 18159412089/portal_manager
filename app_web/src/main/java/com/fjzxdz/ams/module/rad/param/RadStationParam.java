/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.param;

import com.fjzxdz.ams.module.rad.entity.RadStation;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 辐射基站Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class RadStationParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 发射机型号 */
	private String FSJXH;
	/** 天线下倾角 */
	private String TXXQJ;
	/** 数据分册编号 */
	private String SJFCBH;
	/** 基站名称 */
	private String JZNAME;
	/** 每个扇区的载频数 */
	private String MGSQZPS;
	/** ID */
	private String PKID;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 验收天线架设类型 */
	private String TXJSLX;
	/** 标称功率(W) */
	private String BCGL;
	/** 纬度 */
	private String LATITUDE;
	/** 发射机厂商 */
	private String FSJCS;
	/** 市 */
	private String CODEREGIONSHI;
	/** 区县 */
	private String CODEREGIONXIAN;
	/** 验收共站类型 */
	private String YSGZLX;
	/** 立项时间 */
	private String LXSJ;
	/** 地址 */
	private String ENTERADDRESS;
	/** 天地方向角 */
	private String TXFXJ;
	/** 经度 */
	private String LONGITUDE;
	/** 天线数目 */
	private String TXSM;
	/** 天线离地高度（M） */
	private String TXLDGD;
	/** 区域类型 */
	private String QYLX;
	/** 天线极化方式 */
	private String TXJHFS;
	/** 天线增益(dBi) */
	private String TXZY;
	/** 编号 */
	private String JZBH;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public RadStationParam() {
		super(RadStation.class);
		this.clazz = RadStation.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("FSJXH", getFSJXH(), SearchCondition.LIKE);
		addClause("TXXQJ", getTXXQJ(), SearchCondition.LIKE);
		addClause("SJFCBH", getSJFCBH(), SearchCondition.LIKE);
		addClause("JZNAME", getJZNAME(), SearchCondition.LIKE);
		addClause("MGSQZPS", getMGSQZPS(), SearchCondition.LIKE);
		addClause("PKID", getPKID(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("TXJSLX", getTXJSLX(), SearchCondition.LIKE);
		addClause("BCGL", getBCGL(), SearchCondition.LIKE);
		addClause("LATITUDE", getLATITUDE(), SearchCondition.LIKE);
		addClause("FSJCS", getFSJCS(), SearchCondition.LIKE);
		addClause("CODEREGIONSHI", getCODEREGIONSHI(), SearchCondition.LIKE);
		addClause("CODEREGIONXIAN", getCODEREGIONXIAN(), SearchCondition.LIKE);
		addClause("YSGZLX", getYSGZLX(), SearchCondition.LIKE);
		addClause("LXSJ", getLXSJ(), SearchCondition.LIKE);
		addClause("ENTERADDRESS", getENTERADDRESS(), SearchCondition.LIKE);
		addClause("TXFXJ", getTXFXJ(), SearchCondition.LIKE);
		addClause("LONGITUDE", getLONGITUDE(), SearchCondition.LIKE);
		addClause("TXSM", getTXSM(), SearchCondition.LIKE);
		addClause("TXLDGD", getTXLDGD(), SearchCondition.LIKE);
		addClause("QYLX", getQYLX(), SearchCondition.LIKE);
		addClause("TXJHFS", getTXJHFS(), SearchCondition.LIKE);
		addClause("TXZY", getTXZY(), SearchCondition.LIKE);
		addClause("JZBH", getJZBH(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getFSJXH() {
		return FSJXH;
	}
	
	public void setFSJXH(String fSJXH) {
		this.FSJXH = fSJXH;
	}
	public String getTXXQJ() {
		return TXXQJ;
	}
	
	public void setTXXQJ(String tXXQJ) {
		this.TXXQJ = tXXQJ;
	}
	public String getSJFCBH() {
		return SJFCBH;
	}
	
	public void setSJFCBH(String sJFCBH) {
		this.SJFCBH = sJFCBH;
	}
	public String getJZNAME() {
		return JZNAME;
	}
	
	public void setJZNAME(String jZNAME) {
		this.JZNAME = jZNAME;
	}
	public String getMGSQZPS() {
		return MGSQZPS;
	}
	
	public void setMGSQZPS(String mGSQZPS) {
		this.MGSQZPS = mGSQZPS;
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
	public String getTXJSLX() {
		return TXJSLX;
	}
	
	public void setTXJSLX(String tXJSLX) {
		this.TXJSLX = tXJSLX;
	}
	public String getBCGL() {
		return BCGL;
	}
	
	public void setBCGL(String bCGL) {
		this.BCGL = bCGL;
	}
	public String getLATITUDE() {
		return LATITUDE;
	}
	
	public void setLATITUDE(String lATITUDE) {
		this.LATITUDE = lATITUDE;
	}
	public String getFSJCS() {
		return FSJCS;
	}
	
	public void setFSJCS(String fSJCS) {
		this.FSJCS = fSJCS;
	}
	public String getCODEREGIONSHI() {
		return CODEREGIONSHI;
	}
	
	public void setCODEREGIONSHI(String cODEREGIONSHI) {
		this.CODEREGIONSHI = cODEREGIONSHI;
	}
	public String getCODEREGIONXIAN() {
		return CODEREGIONXIAN;
	}
	
	public void setCODEREGIONXIAN(String cODEREGIONXIAN) {
		this.CODEREGIONXIAN = cODEREGIONXIAN;
	}
	public String getYSGZLX() {
		return YSGZLX;
	}
	
	public void setYSGZLX(String ySGZLX) {
		this.YSGZLX = ySGZLX;
	}
	public String getLXSJ() {
		return LXSJ;
	}
	
	public void setLXSJ(String lXSJ) {
		this.LXSJ = lXSJ;
	}
	public String getENTERADDRESS() {
		return ENTERADDRESS;
	}
	
	public void setENTERADDRESS(String eNTERADDRESS) {
		this.ENTERADDRESS = eNTERADDRESS;
	}
	public String getTXFXJ() {
		return TXFXJ;
	}
	
	public void setTXFXJ(String tXFXJ) {
		this.TXFXJ = tXFXJ;
	}
	public String getLONGITUDE() {
		return LONGITUDE;
	}
	
	public void setLONGITUDE(String lONGITUDE) {
		this.LONGITUDE = lONGITUDE;
	}
	public String getTXSM() {
		return TXSM;
	}
	
	public void setTXSM(String tXSM) {
		this.TXSM = tXSM;
	}
	public String getTXLDGD() {
		return TXLDGD;
	}
	
	public void setTXLDGD(String tXLDGD) {
		this.TXLDGD = tXLDGD;
	}
	public String getQYLX() {
		return QYLX;
	}
	
	public void setQYLX(String qYLX) {
		this.QYLX = qYLX;
	}
	public String getTXJHFS() {
		return TXJHFS;
	}
	
	public void setTXJHFS(String tXJHFS) {
		this.TXJHFS = tXJHFS;
	}
	public String getTXZY() {
		return TXZY;
	}
	
	public void setTXZY(String tXZY) {
		this.TXZY = tXZY;
	}
	public String getJZBH() {
		return JZBH;
	}
	
	public void setJZBH(String jZBH) {
		this.JZBH = jZBH;
	}
	
}


