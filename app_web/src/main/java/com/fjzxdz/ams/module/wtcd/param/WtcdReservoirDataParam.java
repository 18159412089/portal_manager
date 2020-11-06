/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.param;

import com.fjzxdz.ams.module.wtcd.entity.WtcdReservoirData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 水利厅水文站点Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class WtcdReservoirDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 蓄水量  百万立方米 */
	private String W;
	/** 入库时间 */
	private String RKSJ;
	/** 测站编码 */
	private String STCD;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 时间 */
	private String YMDHM;
	/** 水位  米 */
	private String ZI;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public WtcdReservoirDataParam() {
		super(WtcdReservoirData.class);
		this.clazz = WtcdReservoirData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("W", getW(), SearchCondition.LIKE);
		addClause("RKSJ", getRKSJ(), SearchCondition.LIKE);
		addClause("STCD", getSTCD(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("YMDHM", getYMDHM(), SearchCondition.LIKE);
		addClause("ZI", getZI(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public String getW() {
		return W;
	}
	
	public void setW(String w) {
		this.W = w;
	}
	public String getRKSJ() {
		return RKSJ;
	}
	
	public void setRKSJ(String rKSJ) {
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
	public String getYMDHM() {
		return YMDHM;
	}
	
	public void setYMDHM(String yMDHM) {
		this.YMDHM = yMDHM;
	}
	public String getZI() {
		return ZI;
	}
	
	public void setZI(String zI) {
		this.ZI = zI;
	}
	
}


