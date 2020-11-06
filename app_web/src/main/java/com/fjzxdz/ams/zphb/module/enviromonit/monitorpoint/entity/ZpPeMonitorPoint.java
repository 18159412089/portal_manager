/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.entity;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.entity.ZpPollutionEnterpriseData;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;

/**
 * monitorPointEntity
 * @author htj
 * @date 2019-02-11
 */
@Entity
@Table(name = "ZP_POLLUTION_MONITOR_POINT")
public class ZpPeMonitorPoint implements Serializable  {
	
	private static final long serialVersionUID = 1L;
	/** 主键 */
	@Id
	private String outputId;
	/** 排放口类型 */
	private String outfallType;
	/** 排污口编号 */
	private String code;
	/** 排污口名称 */
	private String name;
	/** 排污口位置 */
	@Column(name = "POS_")
	private String pos;
	/** 功能区类别 */
	private String gafTypeCode;
	/** 排放规律 */
	private String gorCode;
	/** 燃料分类 */
	private String fuelCode;
	/** 燃料方式 */
	private String burnCode;
	/** 标志牌安装形式 */
	private String symbolStyle;
	
	/** 企业ID */
	@Column(name = "PE_ID")
	private String peId;
	
	@ManyToOne(cascade=CascadeType.PERSIST)
	@JoinColumn(name = "PE_ID" ,insertable =false, updatable = false )
	@NotFound(action = NotFoundAction.IGNORE)
	private ZpPollutionEnterpriseData zpPeEnterpriseData;

	@Column(name = "MN_POINTS")
	private String mnPoints;
	
	public ZpPollutionEnterpriseData getZpPeEnterpriseData() {
		return zpPeEnterpriseData;
	}

	public void setZpPeEnterpriseData(ZpPollutionEnterpriseData zpPeEnterpriseData) {
		this.zpPeEnterpriseData = zpPeEnterpriseData;
	}

	/** 显示顺序 */
	private String seqNo;
	/** 排污许可证编号 */
	private String licenceCode;
	/** 允许污染物的排放量 */
	private String allowPluLet;
	/** 状态 */
	private String status;
	/** 监控显示 */
	private String hiddenOutput;
	/** 是否导出 */
	private String isexport;
	/** 股票显示 */
	private String stockShow;
	/** 经度 */
	private String longitude;
	/** 纬度 */
	private String latitude;
	/** 标准空气过剩系数 */
	private String airCoefficient;
	/** 单台出力 */
	private String singleOutput;
	/** 锅炉类型 */
	private String boilerType;
	/** MN号 */
	private String csn;
	/** 访问密码 */
	private String pwd;
	/** IP地址 */
	private String ipAddress;
	/** 端口号 */
	private String port;
	/** 上传周期 */
	private String cyc;
	/** 生产厂家 */
	private String product;
	/** 联系人 */
	private String contact;
	/** 联系方式 */
	private String contactNum;
	/** 是否上传日数据 */
	private String isPutDaily;
	/** 是否上传小时数据 */
	private String isPutHour;
	/** 是否上传分钟数据 */
	private String isPutMin;
	/** 上传 */
	private String upTran;
	/** 下发 */
	private String downTran;
	/** 是否发住E通平台 */
	private String etongTran;
	/** 流量上传单位 */
	private String unitTranslate;
	/** 更新时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date updateTime;
	/** 更新用户id */
	private String updateUserId;
	/** 插入时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date insertTime;
	/** 插入用户id */
	private String insertUserId;
	/** 流域 */
	@Column(name = "RIVER_")
	private String river;
	/** 流向方向 */
	private String direction;
	/** 运营商 */
	private String operator;
	/** 是否省关注 */
	private String isProvinceConcerned;
	/** 报备停产 */
	private String reportStop;
	/** 启用状态 */
	private String enableStatus;
	/** 安装位置类型 */
	private String siteType;
	/** 实际日处理量 */
	private String actualDailyCapacity;
	/** 第一次上传数据时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date firstUploadData;
	/** 是否市关注 */
	private String isCityConcerned;
	/** 是否区关注 */
	private String isAreaConcerned;
	
	public String getOutputId() {
		return outputId;
	}

	public void setOutputId(String outputId) {
		this.outputId = outputId;
	}
	public String getOutfallType() {
		return outfallType;
	}

	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getPos() {
		return pos;
	}

	public void setPos(String pos) {
		this.pos = pos;
	}
	public String getGafTypeCode() {
		return gafTypeCode;
	}

	public void setGafTypeCode(String gafTypeCode) {
		this.gafTypeCode = gafTypeCode;
	}
	public String getGorCode() {
		return gorCode;
	}

	public void setGorCode(String gorCode) {
		this.gorCode = gorCode;
	}
	public String getFuelCode() {
		return fuelCode;
	}

	public void setFuelCode(String fuelCode) {
		this.fuelCode = fuelCode;
	}
	public String getBurnCode() {
		return burnCode;
	}

	public void setBurnCode(String burnCode) {
		this.burnCode = burnCode;
	}
	public String getSymbolStyle() {
		return symbolStyle;
	}

	public void setSymbolStyle(String symbolStyle) {
		this.symbolStyle = symbolStyle;
	}
	public String getPeId() {
		return peId;
	}

	public void setPeId(String peId) {
		this.peId = peId;
	}
	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getLicenceCode() {
		return licenceCode;
	}

	public void setLicenceCode(String licenceCode) {
		this.licenceCode = licenceCode;
	}
	public String getAllowPluLet() {
		return allowPluLet;
	}

	public void setAllowPluLet(String allowPluLet) {
		this.allowPluLet = allowPluLet;
	}
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public String getHiddenOutput() {
		return hiddenOutput;
	}

	public void setHiddenOutput(String hiddenOutput) {
		this.hiddenOutput = hiddenOutput;
	}
	public String getIsexport() {
		return isexport;
	}

	public void setIsexport(String isexport) {
		this.isexport = isexport;
	}
	public String getStockShow() {
		return stockShow;
	}

	public void setStockShow(String stockShow) {
		this.stockShow = stockShow;
	}
	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getAirCoefficient() {
		return airCoefficient;
	}

	public void setAirCoefficient(String airCoefficient) {
		this.airCoefficient = airCoefficient;
	}
	public String getSingleOutput() {
		return singleOutput;
	}

	public void setSingleOutput(String singleOutput) {
		this.singleOutput = singleOutput;
	}
	public String getBoilerType() {
		return boilerType;
	}

	public void setBoilerType(String boilerType) {
		this.boilerType = boilerType;
	}
	public String getCsn() {
		return csn;
	}

	public void setCsn(String csn) {
		this.csn = csn;
	}
	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}
	public String getCyc() {
		return cyc;
	}

	public void setCyc(String cyc) {
		this.cyc = cyc;
	}
	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}
	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getContactNum() {
		return contactNum;
	}

	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getIsPutDaily() {
		return isPutDaily;
	}

	public void setIsPutDaily(String isPutDaily) {
		this.isPutDaily = isPutDaily;
	}
	public String getIsPutHour() {
		return isPutHour;
	}

	public void setIsPutHour(String isPutHour) {
		this.isPutHour = isPutHour;
	}
	public String getIsPutMin() {
		return isPutMin;
	}

	public void setIsPutMin(String isPutMin) {
		this.isPutMin = isPutMin;
	}
	public String getUpTran() {
		return upTran;
	}

	public void setUpTran(String upTran) {
		this.upTran = upTran;
	}
	public String getDownTran() {
		return downTran;
	}

	public void setDownTran(String downTran) {
		this.downTran = downTran;
	}
	public String getEtongTran() {
		return etongTran;
	}

	public void setEtongTran(String etongTran) {
		this.etongTran = etongTran;
	}
	public String getUnitTranslate() {
		return unitTranslate;
	}

	public void setUnitTranslate(String unitTranslate) {
		this.unitTranslate = unitTranslate;
	}
	public java.util.Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getUpdateUserId() {
		return updateUserId;
	}

	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}
	public java.util.Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(java.util.Date insertTime) {
		this.insertTime = insertTime;
	}
	public String getInsertUserId() {
		return insertUserId;
	}

	public void setInsertUserId(String insertUserId) {
		this.insertUserId = insertUserId;
	}
	public String getRiver() {
		return river;
	}

	public void setRiver(String river) {
		this.river = river;
	}
	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getIsProvinceConcerned() {
		return isProvinceConcerned;
	}

	public void setIsProvinceConcerned(String isProvinceConcerned) {
		this.isProvinceConcerned = isProvinceConcerned;
	}
	public String getReportStop() {
		return reportStop;
	}

	public void setReportStop(String reportStop) {
		this.reportStop = reportStop;
	}
	public String getEnableStatus() {
		return enableStatus;
	}

	public void setEnableStatus(String enableStatus) {
		this.enableStatus = enableStatus;
	}
	public String getSiteType() {
		return siteType;
	}

	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}
	public String getActualDailyCapacity() {
		return actualDailyCapacity;
	}

	public void setActualDailyCapacity(String actualDailyCapacity) {
		this.actualDailyCapacity = actualDailyCapacity;
	}
	public java.util.Date getFirstUploadData() {
		return firstUploadData;
	}

	public void setFirstUploadData(java.util.Date firstUploadData) {
		this.firstUploadData = firstUploadData;
	}
	public String getIsCityConcerned() {
		return isCityConcerned;
	}

	public void setIsCityConcerned(String isCityConcerned) {
		this.isCityConcerned = isCityConcerned;
	}
	public String getIsAreaConcerned() {
		return isAreaConcerned;
	}

	public void setIsAreaConcerned(String isAreaConcerned) {
		this.isAreaConcerned = isAreaConcerned;
	}
	
	public String getMnPoints() {
		return mnPoints;
	}

	public void setMnPoints(String mnPoints) {
		this.mnPoints = mnPoints;
	}

	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		
		obj.put("outputId", getOutputId());
		obj.put("outfallType", getOutfallType());
		obj.put("code", getCode());
		obj.put("name", getName());
		obj.put("pos", getPos());
		obj.put("gafTypeCode", getGafTypeCode());
		obj.put("gorCode", getGorCode());
		obj.put("fuelCode", getFuelCode());
		obj.put("burnCode", getBurnCode());
		obj.put("symbolStyle", getSymbolStyle());
		obj.put("peId", getPeId());
		obj.put("mnPoints", getMnPoints());
		
		return obj;
	}
}


