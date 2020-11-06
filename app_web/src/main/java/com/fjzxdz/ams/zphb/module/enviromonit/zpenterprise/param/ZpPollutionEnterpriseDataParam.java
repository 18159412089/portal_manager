package com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.entity.ZpPollutionEnterpriseData;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 污染源自动监控企业信息表Entity
 * @author slq
 * @date 2019-02-11
 */
public class ZpPollutionEnterpriseDataParam  extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 污染源主键 */
	private String peId;
	/** 污染源编号 */
	private String peCode;
	/** 污染源名称 */
	private String peName;
	/** 行政区划编码 */
	private String orgCode;
	/** 单位类别编码 */
	private String unitTypeCode;
	/** 企业规模编码 */
	private String sizeCode;
	/** 所有制类型 */
	private String havingName;
	/** 行业类别 */
	private String tradeCode;
	/** 流域编码 */
	private String riverCode;
	/** 地址 */
	private String address;
	/** 法人代码 */
	private String lawCode;
	/** 法人代表 */
	private String lawAgency;
	/** 经度 */
	private String longValue;
	/** 纬度 */
	private String latValue;
	/** 投产日期 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date startDate;
	/** 邮箱 */
	private String email;
	/** 通讯地址 */
	private String mailAddress;
	/** 邮政编码 */
	private String zipCode;
	/** 负责人 */
	private String envPrincipal;
	/** 电话 */
	private String tel;
	/** 传真 */
	private String fax;
	/** 移动电话 */
	private String mobile;
	/** 产生污染物介绍 */
	private String curStatus;
	/** 生产设施情况介绍 */
	private String production;
	/** 特殊类型 */
	private String peType;
	/** 停用启用状态 */
	private String status;
	/** 通讯联系 */
	private String contact;
	/** 污染治理设施介绍 */
	private String pollutionControl;
	/** 其他 */
	private String others;
	/** 更新日期 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date updateTime;
	/** 新增日期 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date insertTime;
	/** 废气控制级别 */
	private String gasType;
	/** 废水控制级别 */
	private String waterType;
	/** 所属区域 */
	private String rgnCode;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public ZpPollutionEnterpriseDataParam() {
		super(ZpPollutionEnterpriseData.class);
		this.clazz = ZpPollutionEnterpriseData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("peId", getPeId(), SearchCondition.EQ);
		addClause("peCode", getPeCode(), SearchCondition.EQ);
		addClause("peName", getPeName(), SearchCondition.LIKE);
		addClause("orgCode", getOrgCode(), SearchCondition.EQ);
		addClause("unitTypeCode", getUnitTypeCode(), SearchCondition.EQ);
		addClause("sizeCode", getSizeCode(), SearchCondition.EQ);
		addClause("havingName", getHavingName(), SearchCondition.EQ);
		addClause("tradeCode", getTradeCode(), SearchCondition.EQ);
		addClause("riverCode", getRiverCode(), SearchCondition.EQ);
		addClause("address", getAddress(), SearchCondition.EQ);
		addClause("lawCode", getLawCode(), SearchCondition.EQ);
		addClause("lawAgency", getLawAgency(), SearchCondition.EQ);
		addClause("longValue", getLongValue(), SearchCondition.EQ);
		addClause("latValue", getLatValue(), SearchCondition.EQ);
		addClause("startDate", getStartDate(), SearchCondition.EQ);
		addClause("email", getEmail(), SearchCondition.EQ);
		addClause("mailAddress", getMailAddress(), SearchCondition.EQ);
		addClause("zipCode", getZipCode(), SearchCondition.EQ);
		addClause("envPrincipal", getEnvPrincipal(), SearchCondition.EQ);
		addClause("tel", getTel(), SearchCondition.EQ);
		addClause("fax", getFax(), SearchCondition.EQ);
		addClause("mobile", getMobile(), SearchCondition.EQ);
		addClause("curStatus", getCurStatus(), SearchCondition.EQ);
		addClause("production", getProduction(), SearchCondition.EQ);
		addClause("peType", getPeType(), SearchCondition.EQ);
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("contact", getContact(), SearchCondition.EQ);
		addClause("pollutionControl", getPollutionControl(), SearchCondition.EQ);
		addClause("others", getOthers(), SearchCondition.EQ);
		addClause("updateTime", getUpdateTime(), SearchCondition.EQ);
		addClause("insertTime", getInsertTime(), SearchCondition.EQ);
		addClause("gasType", getGasType(), SearchCondition.EQ);
		addClause("waterType", getWaterType(), SearchCondition.EQ);
		addClause("rgnCode", getRgnCode(), SearchCondition.EQ);
		setOrderBy(" updateTime desc");
	}
	
	public String getPeId() {
		return peId;
	}
	
	public void setPeId(String peId) {
		this.peId = peId;
	}
	public String getPeCode() {
		return peCode;
	}
	
	public void setPeCode(String peCode) {
		this.peCode = peCode;
	}
	public String getPeName() {
		return peName;
	}
	
	public void setPeName(String peName) {
		this.peName = peName;
	}
	public String getOrgCode() {
		return orgCode;
	}
	
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getUnitTypeCode() {
		return unitTypeCode;
	}
	
	public void setUnitTypeCode(String unitTypeCode) {
		this.unitTypeCode = unitTypeCode;
	}
	public String getSizeCode() {
		return sizeCode;
	}
	
	public void setSizeCode(String sizeCode) {
		this.sizeCode = sizeCode;
	}
	public String getHavingName() {
		return havingName;
	}
	
	public void setHavingName(String havingName) {
		this.havingName = havingName;
	}
	public String getTradeCode() {
		return tradeCode;
	}
	
	public void setTradeCode(String tradeCode) {
		this.tradeCode = tradeCode;
	}
	public String getRiverCode() {
		return riverCode;
	}
	
	public void setRiverCode(String riverCode) {
		this.riverCode = riverCode;
	}
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLawCode() {
		return lawCode;
	}
	
	public void setLawCode(String lawCode) {
		this.lawCode = lawCode;
	}
	public String getLawAgency() {
		return lawAgency;
	}
	
	public void setLawAgency(String lawAgency) {
		this.lawAgency = lawAgency;
	}
	public String getLongValue() {
		return longValue;
	}
	
	public void setLongValue(String longValue) {
		this.longValue = longValue;
	}
	public String getLatValue() {
		return latValue;
	}
	
	public void setLatValue(String latValue) {
		this.latValue = latValue;
	}
	public java.util.Date getStartDate() {
		return startDate;
	}
	
	public void setStartDate(java.util.Date startDate) {
		this.startDate = startDate;
	}
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMailAddress() {
		return mailAddress;
	}
	
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}
	public String getZipCode() {
		return zipCode;
	}
	
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getEnvPrincipal() {
		return envPrincipal;
	}
	
	public void setEnvPrincipal(String envPrincipal) {
		this.envPrincipal = envPrincipal;
	}
	public String getTel() {
		return tel;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getCurStatus() {
		return curStatus;
	}
	
	public void setCurStatus(String curStatus) {
		this.curStatus = curStatus;
	}
	public String getProduction() {
		return production;
	}
	
	public void setProduction(String production) {
		this.production = production;
	}
	public String getPeType() {
		return peType;
	}
	
	public void setPeType(String peType) {
		this.peType = peType;
	}
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	public String getContact() {
		return contact;
	}
	
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getPollutionControl() {
		return pollutionControl;
	}
	
	public void setPollutionControl(String pollutionControl) {
		this.pollutionControl = pollutionControl;
	}
	public String getOthers() {
		return others;
	}
	
	public void setOthers(String others) {
		this.others = others;
	}
	public java.util.Date getUpdateTime() {
		return updateTime;
	}
	
	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}
	public java.util.Date getInsertTime() {
		return insertTime;
	}
	
	public void setInsertTime(java.util.Date insertTime) {
		this.insertTime = insertTime;
	}
	public String getGasType() {
		return gasType;
	}
	
	public void setGasType(String gasType) {
		this.gasType = gasType;
	}
	public String getWaterType() {
		return waterType;
	}
	
	public void setWaterType(String waterType) {
		this.waterType = waterType;
	}
	public String getRgnCode() {
		return rgnCode;
	}
	
	public void setRgnCode(String rgnCode) {
		this.rgnCode = rgnCode;
	}
	
}


