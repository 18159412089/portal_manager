package com.fjzxdz.ams.module.jobSchedule.param;

import com.fjzxdz.ams.module.jobSchedule.entity.CliqueBuild;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
/**
 * 
 * 党建param
 * 
 * @Author caibai
 * @Version 1.0
 * @CreateTime 2019年4月30日 下午3:19:06
 */
public class CliqueBuildParam extends BaseQueryParam {

    private String name;

    private String departmentId;

    private String deptUserID;

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public CliqueBuildParam() {
        super(CliqueBuild.class);
        this.clazz = CliqueBuild.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("name", getName(), SearchCondition.LIKE);
        addClause("department.uuid", getDepartmentId(), SearchCondition.EQ);
        addClause("department.userId", getDeptUserID(), SearchCondition.LIKE);
        setOrderBy(" createDate desc");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDeptUserID() {
        return deptUserID;
    }

    public void setDeptUserID(String deptUserID) {
        this.deptUserID = deptUserID;
    }
}