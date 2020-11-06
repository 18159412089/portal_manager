/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.param;

import com.fjzxdz.ams.module.wtcd.entity.WtcdRiverwayData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水利厅水文站点Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class WtcdRiverwayDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 流量   立方米 */
	private Double Q;
	/** 入库时间 */
	private java.util.Date RKSJ;
	/** 测站编码 */
	private String STCD;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 时间 */
	private java.util.Date YMDHM;
	/** 水位  米 */
	private Double ZR;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtcdRiverwayDataParam() {
		super(WtcdRiverwayData.class);
		this.clazz = WtcdRiverwayData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("Q", getQ(), SearchCondition.LIKE);
		addClause("RKSJ", getRKSJ(), SearchCondition.LIKE);
		addClause("STCD", getSTCD(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("YMDHM", getYMDHM(), SearchCondition.LIKE);
		addClause("ZR", getZR(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public Double getQ() {
		return Q;
	}
	
	public void setQ(Double q) {
		this.Q = q;
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
	public java.util.Date getYMDHM() {
		return YMDHM;
	}
	
	public void setYMDHM(java.util.Date yMDHM) {
		this.YMDHM = yMDHM;
	}
	public Double getZR() {
		return ZR;
	}
	
	public void setZR(Double zR) {
		this.ZR = zR;
	}
	
}


