/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.param;

import com.fjzxdz.ams.module.sea.entity.SeaSiteInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 海洋与渔业点位信息Entity
 * @author lilongan
 * @version 2019-02-19
 */
public class SeaSiteInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 站点编号 */
	private String zdbh;
	/** 原站点编号 */
	private String yzdbh;
	/** 站点名称 */
	private String zdmc;
	/** 经度 */
	private Double jd;
	/** 纬度 */
	private Double wd;
	/** 行政区划代码 */
	private Double xzqhbm;
	/** 行政区划名称 */
	private String xzqhmc;
	/** 监测频次 */
	private String jcpc;
	/** 更新时间 */
	private java.util.Date updatetimeRjwa;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public SeaSiteInfoParam() {
		super(SeaSiteInfo.class);
		this.clazz = SeaSiteInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("zdbh", getZdbh(), SearchCondition.LIKE);
		addClause("yzdbh", getYzdbh(), SearchCondition.LIKE);
		addClause("zdmc", getZdmc(), SearchCondition.LIKE);
		addClause("jd", getJd(), SearchCondition.LIKE);
		addClause("wd", getWd(), SearchCondition.LIKE);
		addClause("xzqhbm", getXzqhbm(), SearchCondition.LIKE);
		addClause("xzqhmc", getXzqhmc(), SearchCondition.LIKE);
		addClause("jcpc", getJcpc(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
	}

	public String getZdbh() {
		return zdbh;
	}

	public void setZdbh(String zdbh) {
		this.zdbh = zdbh;
	}

	public String getYzdbh() {
		return yzdbh;
	}

	public void setYzdbh(String yzdbh) {
		this.yzdbh = yzdbh;
	}

	public String getZdmc() {
		return zdmc;
	}

	public void setZdmc(String zdmc) {
		this.zdmc = zdmc;
	}

	public Double getJd() {
		return jd;
	}

	public void setJd(Double jd) {
		this.jd = jd;
	}

	public Double getWd() {
		return wd;
	}

	public void setWd(Double wd) {
		this.wd = wd;
	}

	public Double getXzqhbm() {
		return xzqhbm;
	}

	public void setXzqhbm(Double xzqhbm) {
		this.xzqhbm = xzqhbm;
	}

	public String getXzqhmc() {
		return xzqhmc;
	}

	public void setXzqhmc(String xzqhmc) {
		this.xzqhmc = xzqhmc;
	}

	public String getJcpc() {
		return jcpc;
	}

	public void setJcpc(String jcpc) {
		this.jcpc = jcpc;
	}

	public java.util.Date getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(java.util.Date updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	
	
}


