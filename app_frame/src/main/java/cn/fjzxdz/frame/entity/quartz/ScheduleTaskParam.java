package cn.fjzxdz.frame.entity.quartz;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;


public class ScheduleTaskParam extends BaseQueryParam {

	private static final long serialVersionUID = 1L;

	private String beanName;

    private String status;

    @SuppressWarnings({ "unused", "rawtypes" })
	private Class clazz;

    public ScheduleTaskParam() {
        super(ScheduleTask.class);
        this.clazz = ScheduleTask.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("bean_name", getBeanName(), SearchCondition.EQ);
        addClause("status", getStatus(), SearchCondition.EQ);
        setOrderBy(" create_date desc");
    }

    public String getBeanName() {
        return beanName;
    }

    public void setBeanName(String beanName) {
        this.beanName = beanName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}