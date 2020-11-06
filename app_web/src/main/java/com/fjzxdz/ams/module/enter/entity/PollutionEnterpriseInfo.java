/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enter.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 污染源档案企业信息Entity
 * @author lilongan
 * @version 2019-02-26
 */
@Entity
@Table(name = "POLLUTION_ENTERPRISE_INFO")
public class PollutionEnterpriseInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 关注程度 */
	private String codeAttentiondegree;
	/** 污染源编码 */
	private String entercode;
	/** 环保总投资币种 */
	private String envinvestmoneytype;
	/** 企业类型 */
	private String codeEntertype;
	/** 污染源环保部门 */
	private String psenvironmentdept;
	/** 单位类别编码 */
	private String codeUnittypecode;
	/** 开业时间（投产日期） */
	private String createtime;
	/** 纬度 */
	private String latitude;
	/** 网址 */
	private String website;
	/** 污染源监管类型 */
	private String codeControllevel;
	/** 总投资币种类型 */
	private String moneytype;
	/** 所在工业园区名称 */
	private String codeIndustryareaname;
	/** 主键uuid */
	@Id
	private String standenterid;
	/** 邮编 */
	private String postalcode;
	/** 污染源规模编码 */
	private String codeEntersize;
	/** 企业地址 */
	private String enteraddress;
	/** 标准污染源名称 */
	private String entername;
	/** 环保联系人电话 */
	private String environtel;
	/** 银行名称 */
	private String bankname;
	/** 邮箱地址 */
	private String email;
	/** 环保联系人手机 */
	private String environphone;
	/** 法人代码，格式 */
	private String corpcode;
	/** 曾用名 */
	private String historyentername;
	/** 环保投资（万元） */
	private String environinvest;
	/** 传真 */
	private String fax;
	/** 专职环保人员数 */
	private String environmentmans;
	/** 银行账户 */
	private String bankcode;
	/** 企业名称 */
	private String companyname;
	/** 通讯地址 */
	private String communicateaddr;
	/** 所属行业 */
	private String trade;
	/** 污染源责任人 */
	private String dutyperson;
	/** 环保联系人 */
	private String environlinkmen;
	/** 行政区名称 */
	private String regionname;
	/** 电话 */
	private String telephone;
	/** 总投资（万元） */
	private String totalinvest;
	/** 行业代码 */
	private String codeTrade;
	/** 行政区代码 */
	private String codeRegion;
	/** 法人代表姓名 */
	private String corpname;
	/** 登记注册类型 */
	private String codeRegistertype;
	/** 联系人 */
	private String linkman;
	/** 隶属关系 */
	private String codeEnterrelation;
	/** 简称 */
	private String shortname;
	/** 单位资质 */
	private String codeQualification;
	/** 经度 */
	private String longitude;
	/**  */
	private String wsystem;
	/** 环保联系人传真 */
	private String environfax;
	/** 所属流域 */
	private String codeWsystem;
	/** 最后更新时间 */
	private java.util.Date updatetime;

	@Override
	public String toString() {
		return "PollutionEnterpriseInfo{" +
				"codeAttentiondegree='" + codeAttentiondegree + '\'' +
				", entercode='" + entercode + '\'' +
				", envinvestmoneytype='" + envinvestmoneytype + '\'' +
				", codeEntertype='" + codeEntertype + '\'' +
				", psenvironmentdept='" + psenvironmentdept + '\'' +
				", codeUnittypecode='" + codeUnittypecode + '\'' +
				", createtime='" + createtime + '\'' +
				", latitude='" + latitude + '\'' +
				", website='" + website + '\'' +
				", codeControllevel='" + codeControllevel + '\'' +
				", moneytype='" + moneytype + '\'' +
				", codeIndustryareaname='" + codeIndustryareaname + '\'' +
				", standenterid='" + standenterid + '\'' +
				", postalcode='" + postalcode + '\'' +
				", codeEntersize='" + codeEntersize + '\'' +
				", enteraddress='" + enteraddress + '\'' +
				", entername='" + entername + '\'' +
				", environtel='" + environtel + '\'' +
				", bankname='" + bankname + '\'' +
				", email='" + email + '\'' +
				", environphone='" + environphone + '\'' +
				", corpcode='" + corpcode + '\'' +
				", historyentername='" + historyentername + '\'' +
				", environinvest='" + environinvest + '\'' +
				", fax='" + fax + '\'' +
				", environmentmans='" + environmentmans + '\'' +
				", bankcode='" + bankcode + '\'' +
				", companyname='" + companyname + '\'' +
				", communicateaddr='" + communicateaddr + '\'' +
				", trade='" + trade + '\'' +
				", dutyperson='" + dutyperson + '\'' +
				", environlinkmen='" + environlinkmen + '\'' +
				", regionname='" + regionname + '\'' +
				", telephone='" + telephone + '\'' +
				", totalinvest='" + totalinvest + '\'' +
				", codeTrade='" + codeTrade + '\'' +
				", codeRegion='" + codeRegion + '\'' +
				", corpname='" + corpname + '\'' +
				", codeRegistertype='" + codeRegistertype + '\'' +
				", linkman='" + linkman + '\'' +
				", codeEnterrelation='" + codeEnterrelation + '\'' +
				", shortname='" + shortname + '\'' +
				", codeQualification='" + codeQualification + '\'' +
				", longitude='" + longitude + '\'' +
				", wsystem='" + wsystem + '\'' +
				", environfax='" + environfax + '\'' +
				", codeWsystem='" + codeWsystem + '\'' +
				", updatetime=" + updatetime +
				'}';
	}

	public String getCodeAttentiondegree() {
		return codeAttentiondegree;
	}

	public void setCodeAttentiondegree(String codeAttentiondegree) {
		this.codeAttentiondegree = codeAttentiondegree;
	}
	public String getEntercode() {
		return entercode;
	}

	public void setEntercode(String entercode) {
		this.entercode = entercode;
	}
	public String getEnvinvestmoneytype() {
		return envinvestmoneytype;
	}

	public void setEnvinvestmoneytype(String envinvestmoneytype) {
		this.envinvestmoneytype = envinvestmoneytype;
	}
	public String getCodeEntertype() {
		return codeEntertype;
	}

	public void setCodeEntertype(String codeEntertype) {
		this.codeEntertype = codeEntertype;
	}
	public String getPsenvironmentdept() {
		return psenvironmentdept;
	}

	public void setPsenvironmentdept(String psenvironmentdept) {
		this.psenvironmentdept = psenvironmentdept;
	}
	public String getCodeUnittypecode() {
		return codeUnittypecode;
	}

	public void setCodeUnittypecode(String codeUnittypecode) {
		this.codeUnittypecode = codeUnittypecode;
	}
	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}
	public String getCodeControllevel() {
		return codeControllevel;
	}

	public void setCodeControllevel(String codeControllevel) {
		this.codeControllevel = codeControllevel;
	}
	public String getMoneytype() {
		return moneytype;
	}

	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	public String getCodeIndustryareaname() {
		return codeIndustryareaname;
	}

	public void setCodeIndustryareaname(String codeIndustryareaname) {
		this.codeIndustryareaname = codeIndustryareaname;
	}
	public String getStandenterid() {
		return standenterid;
	}

	public void setStandenterid(String standenterid) {
		this.standenterid = standenterid;
	}
	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	public String getCodeEntersize() {
		return codeEntersize;
	}

	public void setCodeEntersize(String codeEntersize) {
		this.codeEntersize = codeEntersize;
	}
	public String getEnteraddress() {
		return enteraddress;
	}

	public void setEnteraddress(String enteraddress) {
		this.enteraddress = enteraddress;
	}
	public String getEntername() {
		return entername;
	}

	public void setEntername(String entername) {
		this.entername = entername;
	}
	public String getEnvirontel() {
		return environtel;
	}

	public void setEnvirontel(String environtel) {
		this.environtel = environtel;
	}
	public String getBankname() {
		return bankname;
	}

	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	public String getEnvironphone() {
		return environphone;
	}

	public void setEnvironphone(String environphone) {
		this.environphone = environphone;
	}
	public String getCorpcode() {
		return corpcode;
	}

	public void setCorpcode(String corpcode) {
		this.corpcode = corpcode;
	}
	public String getHistoryentername() {
		return historyentername;
	}

	public void setHistoryentername(String historyentername) {
		this.historyentername = historyentername;
	}
	public String getEnvironinvest() {
		return environinvest;
	}

	public void setEnvironinvest(String environinvest) {
		this.environinvest = environinvest;
	}
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEnvironmentmans() {
		return environmentmans;
	}

	public void setEnvironmentmans(String environmentmans) {
		this.environmentmans = environmentmans;
	}
	public String getBankcode() {
		return bankcode;
	}

	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}
	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getCommunicateaddr() {
		return communicateaddr;
	}

	public void setCommunicateaddr(String communicateaddr) {
		this.communicateaddr = communicateaddr;
	}
	public String getTrade() {
		return trade;
	}

	public void setTrade(String trade) {
		this.trade = trade;
	}
	public String getDutyperson() {
		return dutyperson;
	}

	public void setDutyperson(String dutyperson) {
		this.dutyperson = dutyperson;
	}
	public String getEnvironlinkmen() {
		return environlinkmen;
	}

	public void setEnvironlinkmen(String environlinkmen) {
		this.environlinkmen = environlinkmen;
	}
	public String getRegionname() {
		return regionname;
	}

	public void setRegionname(String regionname) {
		this.regionname = regionname;
	}
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getTotalinvest() {
		return totalinvest;
	}

	public void setTotalinvest(String totalinvest) {
		this.totalinvest = totalinvest;
	}
	public String getCodeTrade() {
		return codeTrade;
	}

	public void setCodeTrade(String codeTrade) {
		this.codeTrade = codeTrade;
	}
	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}
	public String getCorpname() {
		return corpname;
	}

	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public String getCodeRegistertype() {
		return codeRegistertype;
	}

	public void setCodeRegistertype(String codeRegistertype) {
		this.codeRegistertype = codeRegistertype;
	}
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getCodeEnterrelation() {
		return codeEnterrelation;
	}

	public void setCodeEnterrelation(String codeEnterrelation) {
		this.codeEnterrelation = codeEnterrelation;
	}
	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}
	public String getCodeQualification() {
		return codeQualification;
	}

	public void setCodeQualification(String codeQualification) {
		this.codeQualification = codeQualification;
	}
	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getWsystem() {
		return wsystem;
	}

	public void setWsystem(String wsystem) {
		this.wsystem = wsystem;
	}
	public String getEnvironfax() {
		return environfax;
	}

	public void setEnvironfax(String environfax) {
		this.environfax = environfax;
	}
	public String getCodeWsystem() {
		return codeWsystem;
	}

	public void setCodeWsystem(String codeWsystem) {
		this.codeWsystem = codeWsystem;
	}
	public java.util.Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(java.util.Date updatetime) {
		this.updatetime = updatetime;
	}
	
}


