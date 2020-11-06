/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.vi.param;

import com.fjzxdz.ams.module.vi.entity.Visits;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 信访投诉Entity
 * @author htj
 * @version 2019-02-20
 */
public class VisitsParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 是否群体事件（1是；0否） */
	private String isfight;
	/** 转办状态（0，转办；1，市级督办；2，省级督办） */
	private String hanldtype;
	/** 办理时间 */
	private String petitiontime;
	/** 不办理原因 */
	private String notacceptreason;
	/** 更新时间 */
	private String updatetimeRjwa;
	/** 处理反馈状态（0：反馈；1：市级督办反馈；2：省级督办反馈） */
	private String feedbackstatus;
	/** 信件编号 */
	private String lettercode;
	/** 污染类别 */
	private String pollutiontype;
	/** 行业类别 */
	private String industrytype;
	/** 案件属性 */
	private String attribute;
	/** 来源系统（1本系统登记；2厅长信箱；3历史数据；4:12369） */
	private String source;
	/** 被举报单位所在区县 */
	private String pollutioncounty;
	/** 举报人 */
	private String petitioner;
	/** 是否重复件（2是；0否） */
	private String isrepeat;
	/** 受信人 */
	private String petitionacceptperson;
	/** 事发地 */
	private String eventaddr;
	/** 举报内容 */
	private String peticontent;
	/** 是否办理（1是；0否） */
	private String isaccept;
	/** 登记时间 */
	private String inserttime;
	/** 举报人地址 */
	private String petitioneraddr;
	/** 信件Id（信件表主键） */
	private String petiid;
	/** 被举报单位所在地级市 */
	private String pollutioncity;
	/** 是否有效件（1是；0否） */
	private String isvalid;
	/** 办理期限 */
	private String managementperiod;
	/** 被举报单位名称 */
	private String pename;
	/** 被举报单位地址 */
	private String peaddr;
	/** 案件来源 */
	private String resourcel;
	/** 举报人电话 */
	private String petitionertel;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public VisitsParam() {
		super(Visits.class);
		this.clazz = Visits.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("isfight", getIsfight(), SearchCondition.LIKE);
		addClause("hanldtype", getHanldtype(), SearchCondition.LIKE);
		addClause("petitiontime", getPetitiontime(), SearchCondition.LIKE);
		addClause("notacceptreason", getNotacceptreason(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("feedbackstatus", getFeedbackstatus(), SearchCondition.LIKE);
		addClause("lettercode", getLettercode(), SearchCondition.LIKE);
		addClause("pollutiontype", getPollutiontype(), SearchCondition.LIKE);
		addClause("industrytype", getIndustrytype(), SearchCondition.LIKE);
		addClause("attribute", getAttribute(), SearchCondition.LIKE);
		addClause("source", getSource(), SearchCondition.LIKE);
		addClause("pollutioncounty", getPollutioncounty(), SearchCondition.LIKE);
		addClause("petitioner", getPetitioner(), SearchCondition.LIKE);
		addClause("isrepeat", getIsrepeat(), SearchCondition.LIKE);
		addClause("petitionacceptperson", getPetitionacceptperson(), SearchCondition.LIKE);
		addClause("eventaddr", getEventaddr(), SearchCondition.LIKE);
		addClause("peticontent", getPeticontent(), SearchCondition.LIKE);
		addClause("isaccept", getIsaccept(), SearchCondition.LIKE);
		addClause("inserttime", getInserttime(), SearchCondition.LIKE);
		addClause("petitioneraddr", getPetitioneraddr(), SearchCondition.LIKE);
		addClause("petiid", getPetiid(), SearchCondition.LIKE);
		addClause("pollutioncity", getPollutioncity(), SearchCondition.LIKE);
		addClause("isvalid", getIsvalid(), SearchCondition.LIKE);
		addClause("managementperiod", getManagementperiod(), SearchCondition.LIKE);
		addClause("pename", getPename(), SearchCondition.LIKE);
		addClause("peaddr", getPeaddr(), SearchCondition.LIKE);
		addClause("resourcel", getResourcel(), SearchCondition.LIKE);
		addClause("petitionertel", getPetitionertel(), SearchCondition.LIKE);
		setOrderBy(" PETITIONTIME desc");
	}
	
	public String getIsfight() {
		return isfight;
	}
	
	public void setIsfight(String isfight) {
		this.isfight = isfight;
	}
	public String getHanldtype() {
		return hanldtype;
	}
	
	public void setHanldtype(String hanldtype) {
		this.hanldtype = hanldtype;
	}
	public String getPetitiontime() {
		return petitiontime;
	}
	
	public void setPetitiontime(String petitiontime) {
		this.petitiontime = petitiontime;
	}
	public String getNotacceptreason() {
		return notacceptreason;
	}
	
	public void setNotacceptreason(String notacceptreason) {
		this.notacceptreason = notacceptreason;
	}
	public String getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}
	
	public void setUpdatetimeRjwa(String updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public String getFeedbackstatus() {
		return feedbackstatus;
	}
	
	public void setFeedbackstatus(String feedbackstatus) {
		this.feedbackstatus = feedbackstatus;
	}
	public String getLettercode() {
		return lettercode;
	}
	
	public void setLettercode(String lettercode) {
		this.lettercode = lettercode;
	}
	public String getPollutiontype() {
		return pollutiontype;
	}
	
	public void setPollutiontype(String pollutiontype) {
		this.pollutiontype = pollutiontype;
	}
	public String getIndustrytype() {
		return industrytype;
	}
	
	public void setIndustrytype(String industrytype) {
		this.industrytype = industrytype;
	}
	public String getAttribute() {
		return attribute;
	}
	
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getSource() {
		return source;
	}
	
	public void setSource(String source) {
		this.source = source;
	}
	public String getPollutioncounty() {
		return pollutioncounty;
	}
	
	public void setPollutioncounty(String pollutioncounty) {
		this.pollutioncounty = pollutioncounty;
	}
	public String getPetitioner() {
		return petitioner;
	}
	
	public void setPetitioner(String petitioner) {
		this.petitioner = petitioner;
	}
	public String getIsrepeat() {
		return isrepeat;
	}
	
	public void setIsrepeat(String isrepeat) {
		this.isrepeat = isrepeat;
	}
	public String getPetitionacceptperson() {
		return petitionacceptperson;
	}
	
	public void setPetitionacceptperson(String petitionacceptperson) {
		this.petitionacceptperson = petitionacceptperson;
	}
	public String getEventaddr() {
		return eventaddr;
	}
	
	public void setEventaddr(String eventaddr) {
		this.eventaddr = eventaddr;
	}
	public String getPeticontent() {
		return peticontent;
	}
	
	public void setPeticontent(String peticontent) {
		this.peticontent = peticontent;
	}
	public String getIsaccept() {
		return isaccept;
	}
	
	public void setIsaccept(String isaccept) {
		this.isaccept = isaccept;
	}
	public String getInserttime() {
		return inserttime;
	}
	
	public void setInserttime(String inserttime) {
		this.inserttime = inserttime;
	}
	public String getPetitioneraddr() {
		return petitioneraddr;
	}
	
	public void setPetitioneraddr(String petitioneraddr) {
		this.petitioneraddr = petitioneraddr;
	}
	public String getPetiid() {
		return petiid;
	}
	
	public void setPetiid(String petiid) {
		this.petiid = petiid;
	}
	public String getPollutioncity() {
		return pollutioncity;
	}
	
	public void setPollutioncity(String pollutioncity) {
		this.pollutioncity = pollutioncity;
	}
	public String getIsvalid() {
		return isvalid;
	}
	
	public void setIsvalid(String isvalid) {
		this.isvalid = isvalid;
	}
	public String getManagementperiod() {
		return managementperiod;
	}
	
	public void setManagementperiod(String managementperiod) {
		this.managementperiod = managementperiod;
	}
	public String getPename() {
		return pename;
	}
	
	public void setPename(String pename) {
		this.pename = pename;
	}
	public String getPeaddr() {
		return peaddr;
	}
	
	public void setPeaddr(String peaddr) {
		this.peaddr = peaddr;
	}
	public String getResourcel() {
		return resourcel;
	}
	
	public void setResourcel(String resourcel) {
		this.resourcel = resourcel;
	}
	public String getPetitionertel() {
		return petitionertel;
	}
	
	public void setPetitionertel(String petitionertel) {
		this.petitionertel = petitionertel;
	}
	
}


