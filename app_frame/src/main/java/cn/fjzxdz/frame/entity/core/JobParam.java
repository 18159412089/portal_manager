package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class JobParam extends BaseQueryParam {

	private static final long serialVersionUID = -3775561167522280151L;

	private String jobName;

	private String seq;

	private String deptid;

	private Integer enable;

	private String remark;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public JobParam() {
		super(Job.class);
		this.clazz = Job.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("name", getJobName(), SearchCondition.LIKE);
		addClause("seq", getSeq(), SearchCondition.EQ);
		addClause("dept", getDeptid(), SearchCondition.EQ);
        addClause("enable", getEnable(), SearchCondition.EQ);
		addClause("remark", getRemark(), SearchCondition.LIKE);
		setOrderBy(" seq asc");
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public Integer getEnable() {
		return enable;
	}

	public void setEnable(Integer enable) {
		this.enable = enable;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}