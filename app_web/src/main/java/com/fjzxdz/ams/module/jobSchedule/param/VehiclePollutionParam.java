package com.fjzxdz.ams.module.jobSchedule.param;

import javax.persistence.Lob;

import com.fjzxdz.ams.module.jobSchedule.entity.VehiclePollution;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 
 * 车辆污染param
 * 
 * @Author
 * @Version 1.0
 * @CreateTime
 */
@SuppressWarnings("serial")
public class VehiclePollutionParam extends BaseQueryParam {

    private String name;

    private String departmentId;

    @Lob
    private String deptUserID;

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public VehiclePollutionParam() {
        super(VehiclePollution.class);
        this.clazz = VehiclePollution.class;
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