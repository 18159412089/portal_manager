/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.Embedded;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 企业产废贮存信息Entity
 * @author htj
 * @version 2019-02-19
 */
@Entity
@Table(name = "HAZ_ENTERPRISE_WASTE_INFO")
public class EnterpriseWasteInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 贮存仓库名称 */
	private String storageName;
	/** 危废重量单位 */
	private String UNIT;
	/** 企业名称 */
	private String ENTNAME;
	/** 危废俗称 */
	private String wasteName;
	@EmbeddedId
	private EnterpriseWastePk  enterpriseWastePk;
	
	public EnterpriseWastePk getEnterpriseWastePk() {
		return enterpriseWastePk;
	}

	public void setEnterpriseWastePk(EnterpriseWastePk enterpriseWastePk) {
		this.enterpriseWastePk = enterpriseWastePk;
	}

	/** 危废产生贮存量 */
	private String QUANTITY;
	/** 企业创建时间 */
	private String createdTime;
	/** 危废八位代码 */
	private String CODE;
	/** QYSX_CF 产废企业 */
	private String enterpriseAttribute;
	
	public String getStorageName() {
		return storageName;
	}

	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}
	public String getUNIT() {
		return UNIT;
	}

	public void setUNIT(String uNIT) {
		this.UNIT = UNIT;
	}
	public String getENTNAME() {
		return ENTNAME;
	}

	public void setENTNAME(String eNTNAME) {
		this.ENTNAME = ENTNAME;
	}
	public String getWasteName() {
		return wasteName;
	}

	public void setWasteName(String wasteName) {
		this.wasteName = wasteName;
	}
	 
	public String getQUANTITY() {
		return QUANTITY;
	}

	public void setQUANTITY(String qUANTITY) {
		this.QUANTITY = QUANTITY;
	}
	public String getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}
	public String getCODE() {
		return CODE;
	}

	public void setCODE(String cODE) {
		this.CODE = CODE;
	}
	public String getEnterpriseAttribute() {
		return enterpriseAttribute;
	}

	public void setEnterpriseAttribute(String enterpriseAttribute) {
		this.enterpriseAttribute = enterpriseAttribute;
	}
	
}


