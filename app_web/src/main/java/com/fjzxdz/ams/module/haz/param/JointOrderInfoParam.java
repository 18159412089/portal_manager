/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.param;

import com.fjzxdz.ams.module.haz.entity.JointOrderInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 联单转移联单信息Entity
 * @author htj
 * @version 2019-02-20
 */
public class JointOrderInfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 司机 */
	private String chuchang;
	/** 备注 */
	private java.util.Date ccsj;
	/** 确认接收时间 */
	private String confirmRemark;
	/** 联单状态：a 新建待处置确认，1 创建成功，2 已出厂，c 接收量不一致协商解决产废企业确认，3 已确认签收，5 已退回 */
	private String ldzt;
	/** 出厂时间 */
	private String ysqyDriver;
	/** 创建时间 */
	private String qrcjsj;
	/** 转移联单id */
	private String zyldId;
	/** 系统企业id */
	private String id;
	/** 备注 */
	private java.util.Date qrsj;
	/** 确认时间 */
	private String qrcjRemark;
	/**  */
	private java.util.Date cjsj;
	/** 备注 */
	private java.util.Date updatetime;
	/** 联单编号 */
	private String ldbh;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public JointOrderInfoParam() {
		super(JointOrderInfo.class);
		this.clazz = JointOrderInfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("chuchang", getChuchang(), SearchCondition.LIKE);
		addClause("ccsj", getCcsj(), SearchCondition.LIKE);
		addClause("confirm_Remark", getConfirmRemark(), SearchCondition.LIKE);
		addClause("ldzt", getLdzt(), SearchCondition.LIKE);
		addClause("ysqyDriver", getYsqyDriver(), SearchCondition.LIKE);
		addClause("qrcjsj", getQrcjsj(), SearchCondition.LIKE);
		addClause("zyld_Id", getZyldId(), SearchCondition.LIKE);
		addClause("id", getId(), SearchCondition.LIKE);
		addClause("qrsj", getQrsj(), SearchCondition.LIKE);
		addClause("qrcj_Remark", getQrcjRemark(), SearchCondition.LIKE);
		addClause("cjsj", getCjsj(), SearchCondition.LIKE);
		addClause("updatetime", getUpdatetime(), SearchCondition.LIKE);
		addClause("ldbh", getLdbh(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME desc");
	}
	
	public String getChuchang() {
		return chuchang;
	}
	
	public void setChuchang(String chuchang) {
		this.chuchang = chuchang;
	}
	public java.util.Date getCcsj() {
		return ccsj;
	}
	
	public void setCcsj(java.util.Date ccsj) {
		this.ccsj = ccsj;
	}
	public String getConfirmRemark() {
		return confirmRemark;
	}
	
	public void setConfirmRemark(String confirmRemark) {
		this.confirmRemark = confirmRemark;
	}
	public String getLdzt() {
		return ldzt;
	}
	
	public void setLdzt(String ldzt) {
		this.ldzt = ldzt;
	}
	public String getYsqyDriver() {
		return ysqyDriver;
	}
	
	public void setYsqyDriver(String ysqyDriver) {
		this.ysqyDriver = ysqyDriver;
	}
	public String getQrcjsj() {
		return qrcjsj;
	}
	
	public void setQrcjsj(String qrcjsj) {
		this.qrcjsj = qrcjsj;
	}
	public String getZyldId() {
		return zyldId;
	}
	
	public void setZyldId(String zyldId) {
		this.zyldId = zyldId;
	}
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	public java.util.Date getQrsj() {
		return qrsj;
	}
	
	public void setQrsj(java.util.Date qrsj) {
		this.qrsj = qrsj;
	}
	public String getQrcjRemark() {
		return qrcjRemark;
	}
	
	public void setQrcjRemark(String qrcjRemark) {
		this.qrcjRemark = qrcjRemark;
	}
	public java.util.Date getCjsj() {
		return cjsj;
	}
	
	public void setCjsj(java.util.Date cjsj) {
		this.cjsj = cjsj;
	}
	public java.util.Date getUpdatetime() {
		return updatetime;
	}
	
	public void setUpdatetime(java.util.Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getLdbh() {
		return ldbh;
	}
	
	public void setLdbh(String ldbh) {
		this.ldbh = ldbh;
	}
	
}


