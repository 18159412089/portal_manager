/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.param;

import com.fjzxdz.ams.module.haz.entity.EnterpriseWasteInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 企业产废贮存信息Entity
 * @author htj
 * @version 2019-02-20
 */
public class EnterpriseWasteInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 贮存仓库名称 */
	private String storageName;
	/** 危废重量单位 */
	private String unit;
	/** 企业名称 */
	private String entname;
	/** 危废俗称 */
	private String wasteName;
	/** 固废系统企业id */
	private String enterpriseId;
	/** 更新时间 */
	private java.util.Date updatetime;
	/** 危废产生贮存量 */
	private String quantity;
	/** 企业创建时间 */
	private String createdTime;
	/** 危废八位代码 */
	private String code;
	/** QYSX_CF 产废企业 */
	private String enterpriseAttribute;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public EnterpriseWasteInfoParam() {
		super(EnterpriseWasteInfo.class);
		this.clazz = EnterpriseWasteInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("storageName", getStorageName(), SearchCondition.LIKE);
		addClause("unit", getUnit(), SearchCondition.LIKE);
		addClause("entname", getEntname(), SearchCondition.LIKE);
		addClause("wasteName", getWasteName(), SearchCondition.LIKE);
		addClause("enterpriseId", getEnterpriseId(), SearchCondition.LIKE);
		addClause("updatetime", getUpdatetime(), SearchCondition.LIKE);
		addClause("quantity", getQuantity(), SearchCondition.LIKE);
		addClause("createdTime", getCreatedTime(), SearchCondition.LIKE);
		addClause("code", getCode(), SearchCondition.LIKE);
		addClause("enterpriseAttribute", getEnterpriseAttribute(), SearchCondition.LIKE);
		setOrderBy(" createdTime desc");
	}
	
	public String getStorageName() {
		return storageName;
	}
	
	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}
	public String getUnit() {
		return unit;
	}
	
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getEntname() {
		return entname;
	}
	
	public void setEntname(String entname) {
		this.entname = entname;
	}
	public String getWasteName() {
		return wasteName;
	}
	
	public void setWasteName(String wasteName) {
		this.wasteName = wasteName;
	}
	public String getEnterpriseId() {
		return enterpriseId;
	}
	
	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	public java.util.Date getUpdatetime() {
		return updatetime;
	}
	
	public void setUpdatetime(java.util.Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getQuantity() {
		return quantity;
	}
	
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getCreatedTime() {
		return createdTime;
	}
	
	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	public String getEnterpriseAttribute() {
		return enterpriseAttribute;
	}
	
	public void setEnterpriseAttribute(String enterpriseAttribute) {
		this.enterpriseAttribute = enterpriseAttribute;
	}
	
}


