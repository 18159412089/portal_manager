package com.fjzxdz.ams.module.deployball.bean;

/**
 * 参考《8200 V3.0 CMS对外接口文档.doc》中的"4.7.RegionInfoDTO字段说明"。
 */

public class RegionInfo implements java.io.Serializable{

	private static final long	serialVersionUID	= 1L;
	private Integer regionId;
	private Integer controlUnilId;
	private String indexCode;
	private String name;
	private Integer parentRegionId;
	private Integer regionLevel;
	private Integer cmsCascadeId;
	private String strXmlRev;
	public Integer getRegionId() {
		return regionId;
	}
	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}
	public Integer getControlUnilId() {
		return controlUnilId;
	}
	public void setControlUnilId(Integer controlUnilId) {
		this.controlUnilId = controlUnilId;
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
	public Integer getParentRegionId() {
		return parentRegionId;
	}
	public void setParentRegionId(Integer parentRegionId) {
		this.parentRegionId = parentRegionId;
	}
	public Integer getRegionLevel() {
		return regionLevel;
	}
	public void setRegionLevel(Integer regionLevel) {
		this.regionLevel = regionLevel;
	}
	public Integer getCmsCascadeId() {
		return cmsCascadeId;
	}
	public void setCmsCascadeId(Integer cmsCascadeId) {
		this.cmsCascadeId = cmsCascadeId;
	}
	public String getStrXmlRev() {
		return strXmlRev;
	}
	public void setStrXmlRev(String strXmlRev) {
		this.strXmlRev = strXmlRev;
	}


	







}