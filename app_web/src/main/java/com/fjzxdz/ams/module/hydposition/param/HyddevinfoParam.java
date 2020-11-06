/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.param;

import com.fjzxdz.ams.module.hydposition.entity.Hyddevinfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水电站设备基本信息Entity
 * @author htj
 * @version 2019-02-18
 */
public class HyddevinfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/**  */
	private String riverCode;
	/**  */
	private Double normalWaterLevel;
	/**  */
	private String NAME;
	/**  */
	private Double totalCapacity;
	/**  */
	private String OVERVIEW;
	/**  */
	private String BUILDER;
	/**  */
	private String sysBuilder;
	/**  */
	private Integer hydropowerId;
	/**  */
	private String chargeDept;
	/**  */
	private Double capacity;
	/**  */
	private String contacterTel;
	/**  */
	private String downReservoir;
	/**  */
	private String LATITUDE;
	/**  */
	private Double minWaterLevel;
	/**  */
	private String rgnName;
	/**  */
	private String rgnCode;
	/**  */
	private String upReservoir;
	/**  */
	private String builderTel;
	/**  */
	private String LONGITUDE;
	/**  */
	private String ADDR;
	/**  */
	private String CONTACTER;
	/**  */
	private Double maxWaterLevel;
	/**  */
	private String riverName;
	/**  */
	private String data;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public HyddevinfoParam() {
		super(Hyddevinfo.class);
		this.clazz = Hyddevinfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("riverCode", getRiverCode(), SearchCondition.LIKE);
		addClause("normalWaterLevel", getNormalWaterLevel(), SearchCondition.LIKE);
		addClause("NAME", getNAME(), SearchCondition.LIKE);
		addClause("totalCapacity", getTotalCapacity(), SearchCondition.LIKE);
		addClause("OVERVIEW", getOVERVIEW(), SearchCondition.LIKE);
		addClause("BUILDER", getBUILDER(), SearchCondition.LIKE);
		addClause("sysBuilder", getSysBuilder(), SearchCondition.LIKE);
		addClause("hydropowerId", getHydropowerId(), SearchCondition.LIKE);
		addClause("chargeDept", getChargeDept(), SearchCondition.LIKE);
		addClause("capacity", getCapacity(), SearchCondition.LIKE);
		addClause("contacterTel", getContacterTel(), SearchCondition.LIKE);
		addClause("downReservoir", getDownReservoir(), SearchCondition.LIKE);
		addClause("LATITUDE", getLATITUDE(), SearchCondition.LIKE);
		addClause("minWaterLevel", getMinWaterLevel(), SearchCondition.LIKE);
		addClause("rgnName", getRgnName(), SearchCondition.LIKE);
		addClause("rgnCode", getRgnCode(), SearchCondition.LIKE);
		addClause("upReservoir", getUpReservoir(), SearchCondition.LIKE);
		addClause("builderTel", getBuilderTel(), SearchCondition.LIKE);
		addClause("LONGITUDE", getLONGITUDE(), SearchCondition.LIKE);
		addClause("ADDR", getADDR(), SearchCondition.LIKE);
		addClause("CONTACTER", getCONTACTER(), SearchCondition.LIKE);
		addClause("maxWaterLevel", getMaxWaterLevel(), SearchCondition.LIKE);
		addClause("riverName", getRiverName(), SearchCondition.LIKE);
		addClause("data", getData(), SearchCondition.LIKE);
	}
	
	public String getRiverCode() {
		return riverCode;
	}
	
	public void setRiverCode(String riverCode) {
		this.riverCode = riverCode;
	}
	public Double getNormalWaterLevel() {
		return normalWaterLevel;
	}
	
	public void setNormalWaterLevel(Double normalWaterLevel) {
		this.normalWaterLevel = normalWaterLevel;
	}
	public String getNAME() {
		return NAME;
	}
	
	public void setNAME(String nAME) {
		this.NAME = nAME;
	}
	public Double getTotalCapacity() {
		return totalCapacity;
	}
	
	public void setTotalCapacity(Double totalCapacity) {
		this.totalCapacity = totalCapacity;
	}
	public String getOVERVIEW() {
		return OVERVIEW;
	}
	
	public void setOVERVIEW(String oVERVIEW) {
		this.OVERVIEW = oVERVIEW;
	}
	public String getBUILDER() {
		return BUILDER;
	}
	
	public void setBUILDER(String bUILDER) {
		this.BUILDER = bUILDER;
	}
	public String getSysBuilder() {
		return sysBuilder;
	}
	
	public void setSysBuilder(String sysBuilder) {
		this.sysBuilder = sysBuilder;
	}
	public Integer getHydropowerId() {
		return hydropowerId;
	}
	
	public void setHydropowerId(Integer hydropowerId) {
		this.hydropowerId = hydropowerId;
	}
	public String getChargeDept() {
		return chargeDept;
	}
	
	public void setChargeDept(String chargeDept) {
		this.chargeDept = chargeDept;
	}
	public Double getCapacity() {
		return capacity;
	}
	
	public void setCapacity(Double capacity) {
		this.capacity = capacity;
	}
	public String getContacterTel() {
		return contacterTel;
	}
	
	public void setContacterTel(String contacterTel) {
		this.contacterTel = contacterTel;
	}
	public String getDownReservoir() {
		return downReservoir;
	}
	
	public void setDownReservoir(String downReservoir) {
		this.downReservoir = downReservoir;
	}
	public String getLATITUDE() {
		return LATITUDE;
	}
	
	public void setLATITUDE(String lATITUDE) {
		this.LATITUDE = lATITUDE;
	}
	public Double getMinWaterLevel() {
		return minWaterLevel;
	}
	
	public void setMinWaterLevel(Double minWaterLevel) {
		this.minWaterLevel = minWaterLevel;
	}
	public String getRgnName() {
		return rgnName;
	}
	
	public void setRgnName(String rgnName) {
		this.rgnName = rgnName;
	}
	public String getRgnCode() {
		return rgnCode;
	}
	
	public void setRgnCode(String rgnCode) {
		this.rgnCode = rgnCode;
	}
	public String getUpReservoir() {
		return upReservoir;
	}
	
	public void setUpReservoir(String upReservoir) {
		this.upReservoir = upReservoir;
	}
	public String getBuilderTel() {
		return builderTel;
	}
	
	public void setBuilderTel(String builderTel) {
		this.builderTel = builderTel;
	}
	public String getLONGITUDE() {
		return LONGITUDE;
	}
	
	public void setLONGITUDE(String lONGITUDE) {
		this.LONGITUDE = lONGITUDE;
	}
	public String getADDR() {
		return ADDR;
	}
	
	public void setADDR(String aDDR) {
		this.ADDR = aDDR;
	}
	public String getCONTACTER() {
		return CONTACTER;
	}
	
	public void setCONTACTER(String cONTACTER) {
		this.CONTACTER = cONTACTER;
	}
	public Double getMaxWaterLevel() {
		return maxWaterLevel;
	}
	
	public void setMaxWaterLevel(Double maxWaterLevel) {
		this.maxWaterLevel = maxWaterLevel;
	}
	public String getRiverName() {
		return riverName;
	}
	
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}
	public String getData() {
		return data;
	}
	
	public void setData(String data) {
		this.data = data;
	}
	
}


