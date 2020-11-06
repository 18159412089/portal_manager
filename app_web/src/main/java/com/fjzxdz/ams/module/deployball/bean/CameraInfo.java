package com.fjzxdz.ams.module.deployball.bean;

/**
 * 参考《8200 V3.0 CMS对外接口文档.doc》中的"4.5.CameraInfoDTO字段说明"。
 */
public class CameraInfo implements java.io.Serializable{

	private static final long	serialVersionUID	= 4655651627226186601L;
	// Fields
	private Integer			cameraId;
	private String			indexCode;
	private String			name;
	private Integer			chanNum;
	private Integer         regionId;
	private Integer         deviceId;
	private String       deviceIndexCode;
	private Integer       cmsCascadeId;
	private String          xmlRev;
	
	public Integer getCameraId() {
		return cameraId;
	}
	public void setCameraId(Integer cameraId) {
		this.cameraId = cameraId;
	}
	public String getIndexCode() {
		return indexCode;
	}
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getChanNum() {
		return chanNum;
	}
	public void setChanNum(Integer chanNum) {
		this.chanNum = chanNum;
	}
	public Integer getRegionId() {
		return regionId;
	}
	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}
	public Integer getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(Integer deviceId) {
		this.deviceId = deviceId;
	}

	public Integer getCmsCascadeId() {
		return cmsCascadeId;
	}
	public void setCmsCascadeId(Integer cmsCascadeId) {
		this.cmsCascadeId = cmsCascadeId;
	}
	public String getXmlRev() {
		return xmlRev;
	}
	public void setXmlRev(String xmlRev) {
		this.xmlRev = xmlRev;
	}
	public String getDeviceIndexCode() {
		return deviceIndexCode;
	}
	public void setDeviceIndexCode(String deviceIndexCode) {
		this.deviceIndexCode = deviceIndexCode;
	}

}
