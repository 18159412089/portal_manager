/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.param;

import com.fjzxdz.ams.module.wtcd.entity.WtcdRainfallData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水利厅水文站点Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class WtcdRainfallDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/**  */
	private java.util.Date RKSJ;
	/** 测站编码 */
	private String STCD;
	/**  */
	private String updatetimeRjwa;
	/**  */
	private String DTRN;
	/**  */
	private java.util.Date YMDHM;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtcdRainfallDataParam() {
		super(WtcdRainfallData.class);
		this.clazz = WtcdRainfallData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("RKSJ", getRKSJ(), SearchCondition.LIKE);
		addClause("STCD", getSTCD(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("DTRN", getDTRN(), SearchCondition.LIKE);
		addClause("YMDHM", getYMDHM(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public java.util.Date getRKSJ() {
		return RKSJ;
	}
	
	public void setRKSJ(java.util.Date rKSJ) {
		this.RKSJ = rKSJ;
	}
	public String getSTCD() {
		return STCD;
	}
	
	public void setSTCD(String sTCD) {
		this.STCD = sTCD;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}
	
	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public String getDTRN() {
		return DTRN;
	}
	
	public void setDTRN(String dTRN) {
		this.DTRN = dTRN;
	}
	public java.util.Date getYMDHM() {
		return YMDHM;
	}
	
	public void setYMDHM(java.util.Date yMDHM) {
		this.YMDHM = yMDHM;
	}
	
}


