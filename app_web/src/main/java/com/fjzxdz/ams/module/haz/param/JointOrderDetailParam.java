package com.fjzxdz.ams.module.haz.param;

import com.fjzxdz.ams.module.haz.entity.JointOrderDetail;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 联单详细信息Entity
 * @author htj
 * @version 2019-02-20
 */
public class JointOrderDetailParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 容器数量 */
	private String guigexinghao;
	/** 规格型号 */
	private String caizhi;
	/** 转移危废重量单位 */
	private String wxcf;
	/** 材质 */
	private Integer zyl;
	/** 容器类型 */
	private Integer rongqisl;
	/** 危废名称 */
	private String sucheng;
	/** 危险成分 */
	private String wxtx;
	/**  */
	private String rongqilx;
	/** 处置方式代码 */
	private String czfsName;
	/** 转移联单id */
	private String zyldId;
	/** 转移量 */
	private String czJsl;
	/**  */
	private java.util.Date updatetime;
	/** 危废代码 */
	private String code;
	/** 处置单位接收量 */
	private String danwei;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public JointOrderDetailParam() {
		super(JointOrderDetail.class);
		this.clazz = JointOrderDetail.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("guigexinghao", getGuigexinghao(), SearchCondition.LIKE);
		addClause("caizhi", getCaizhi(), SearchCondition.LIKE);
		addClause("wxcf", getWxcf(), SearchCondition.LIKE);
		addClause("zyl", getZyl(), SearchCondition.LIKE);
		addClause("rongqisl", getRongqisl(), SearchCondition.LIKE);
		addClause("sucheng", getSucheng(), SearchCondition.LIKE);
		addClause("wxtx", getWxtx(), SearchCondition.LIKE);
		addClause("rongqilx", getRongqilx(), SearchCondition.LIKE);
		addClause("czfsName", getCzfsName(), SearchCondition.LIKE);
		addClause("zyldId", getZyldId(), SearchCondition.LIKE);
		addClause("czJsl", getCzJsl(), SearchCondition.LIKE);
		addClause("updatetime", getUpdatetime(), SearchCondition.LIKE);
		addClause("code", getCode(), SearchCondition.LIKE);
		addClause("danwei", getDanwei(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME desc");
	}
	
	public String getGuigexinghao() {
		return guigexinghao;
	}
	
	public void setGuigexinghao(String guigexinghao) {
		this.guigexinghao = guigexinghao;
	}
	public String getCaizhi() {
		return caizhi;
	}
	
	public void setCaizhi(String caizhi) {
		this.caizhi = caizhi;
	}
	public String getWxcf() {
		return wxcf;
	}
	
	public void setWxcf(String wxcf) {
		this.wxcf = wxcf;
	}
	public Integer getZyl() {
		return zyl;
	}
	
	public void setZyl(Integer zyl) {
		this.zyl = zyl;
	}
	public Integer getRongqisl() {
		return rongqisl;
	}
	
	public void setRongqisl(Integer rongqisl) {
		this.rongqisl = rongqisl;
	}
	public String getSucheng() {
		return sucheng;
	}
	
	public void setSucheng(String sucheng) {
		this.sucheng = sucheng;
	}
	public String getWxtx() {
		return wxtx;
	}
	
	public void setWxtx(String wxtx) {
		this.wxtx = wxtx;
	}
	public String getRongqilx() {
		return rongqilx;
	}
	
	public void setRongqilx(String rongqilx) {
		this.rongqilx = rongqilx;
	}
	public String getCzfsName() {
		return czfsName;
	}
	
	public void setCzfsName(String czfsName) {
		this.czfsName = czfsName;
	}
	public String getZyldId() {
		return zyldId;
	}
	
	public void setZyldId(String zyldId) {
		this.zyldId = zyldId;
	}
	public String getCzJsl() {
		return czJsl;
	}
	
	public void setCzJsl(String czJsl) {
		this.czJsl = czJsl;
	}
	public java.util.Date getUpdatetime() {
		return updatetime;
	}
	
	public void setUpdatetime(java.util.Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	public String getDanwei() {
		return danwei;
	}
	
	public void setDanwei(String danwei) {
		this.danwei = danwei;
	}
	
}


