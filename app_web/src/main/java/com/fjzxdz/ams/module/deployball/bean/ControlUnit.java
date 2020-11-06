package com.fjzxdz.ams.module.deployball.bean;

import java.util.Date;

/**

 * 参考《8200 V3.0 CMS对外接口文档.doc》中的"4.1.ControlUnitDTO字段说明"。
 */

public class ControlUnit implements java.io.Serializable {

	// Fields
	/** 序列化ID*/
	private static final long	serialVersionUID	= 1L;
	private Integer controlUnitId;
	private String indexCode;
	private String name;
	private Integer parentId;
	private Integer unitLevel;
	private Integer sequenceIdx;
	private Integer cmsCascadeId;
	private String strXmlRev;
	private Date createTime;
	private Date updateTime;
	public Integer getControlUnitId() {
		return controlUnitId;
	}
	public void setControlUnitId(Integer controlUnitId) {
		this.controlUnitId = controlUnitId;
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
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getUnitLevel() {
		return unitLevel;
	}
	public void setUnitLevel(Integer unitLevel) {
		this.unitLevel = unitLevel;
	}
	public Integer getSequenceIdx() {
		return sequenceIdx;
	}
	public void setSequenceIdx(Integer sequenceIdx) {
		this.sequenceIdx = sequenceIdx;
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}
