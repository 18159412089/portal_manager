/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.datamonitor.param;

import com.fjzxdz.ams.module.datamonitor.entity.DataMonitor;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 数据监控Entity
 * @author slq
 * @version 2019-02-27
 */
public class DataMonitorParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 业务名称 */
	private String serviceName;
	/** 表名称 */
	private String tableName;
	/** 来源科室 */
	private String sourceDept;
	/** 来源系统 */
	private String sourceSystem;
	/**  集成方式 */
	private String integratiornWay;
	/** 更新频率 */
	private String updateFreq;
	/** 数据类型 */
	private String dataType;
	/** 省 */
	private String province;
	/** 市 */
	private String city;
	/** 县 */
	private String county;
	/** 备注 */
	private String remark;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public DataMonitorParam() {
		super(DataMonitor.class);
		this.clazz = DataMonitor.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("serviceName", getServiceName(), SearchCondition.LIKE);
		addClause("tableName", getTableName(), SearchCondition.LIKE);
		addClause("sourceDept", getSourceDept(), SearchCondition.LIKE);
		addClause("sourceSystem", getSourceSystem(), SearchCondition.LIKE);
		addClause("integratiornWay", getIntegratiornWay(), SearchCondition.LIKE);
		addClause("updateFreq", getUpdateFreq(), SearchCondition.LIKE);
		addClause("dataType", getDataType(), SearchCondition.LIKE);
		addClause("province", getProvince(), SearchCondition.LIKE);
		addClause("city", getCity(), SearchCondition.LIKE);
		addClause("county", getCounty(), SearchCondition.LIKE);
		addClause("remark", getRemark(), SearchCondition.LIKE);
	}
	
	public String getServiceName() {
		return serviceName;
	}
	
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getTableName() {
		return tableName;
	}
	
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getSourceDept() {
		return sourceDept;
	}
	
	public void setSourceDept(String sourceDept) {
		this.sourceDept = sourceDept;
	}
	public String getSourceSystem() {
		return sourceSystem;
	}
	
	public void setSourceSystem(String sourceSystem) {
		this.sourceSystem = sourceSystem;
	}
	public String getIntegratiornWay() {
		return integratiornWay;
	}
	
	public void setIntegratiornWay(String integratiornWay) {
		this.integratiornWay = integratiornWay;
	}
	public String getUpdateFreq() {
		return updateFreq;
	}
	
	public void setUpdateFreq(String updateFreq) {
		this.updateFreq = updateFreq;
	}
	public String getDataType() {
		return dataType;
	}
	
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getProvince() {
		return province;
	}
	
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	
	public void setCounty(String county) {
		this.county = county;
	}
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}


