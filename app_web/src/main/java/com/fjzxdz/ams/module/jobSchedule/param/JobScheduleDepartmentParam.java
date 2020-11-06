package com.fjzxdz.ams.module.jobSchedule.param;

import com.fjzxdz.ams.module.jobSchedule.entity.JobScheduleDepartment;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 
 * 部门管理param
 * 
 * @Author
 * @Version 1.0
 * @CreateTime
 */
@SuppressWarnings("serial")
public class JobScheduleDepartmentParam extends BaseQueryParam {

    private String name;

    private String category;

    private String userId;

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public JobScheduleDepartmentParam() {
        super(JobScheduleDepartment.class);
        this.clazz = JobScheduleDepartment.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("name", getName(), SearchCondition.LIKE);
        addClause("category", getCategory(), SearchCondition.LIKE);
        addClause("userId", getUserId(), SearchCondition.LIKE);
        setOrderBy(" createDate desc");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}