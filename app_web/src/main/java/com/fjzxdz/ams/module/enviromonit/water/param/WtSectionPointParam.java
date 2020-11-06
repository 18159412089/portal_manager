package com.fjzxdz.ams.module.enviromonit.water.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * @author shenliuyuan
 * @title: WtSectionPointParam
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/7/115:13
 */
public class WtSectionPointParam extends BaseQueryParam {

    private String pointCode;

    private String pointName;

    private String category;

    private String targetQuality;

    private String isPromoting;

    private String isTargetProject;

    private String status;

    @Override
    protected void createQueryClauses() {
        addClause("pointCode",getPointCode(), SearchCondition.LIKE);
        addClause("pointName",getPointName(), SearchCondition.LIKE);
        addClause("category",getCategory(), SearchCondition.LIKE);
        addClause("targetQuality",getTargetQuality(), SearchCondition.LIKE);
    }
    public String getPointCode() {
        return pointCode;
    }

    public void setPointCode(String pointCode) {
        this.pointCode = pointCode;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTargetQuality() {
        return targetQuality;
    }

    public void setTargetQuality(String targetQuality) {
        this.targetQuality = targetQuality;
    }

    public String getIsPromoting() {
        return isPromoting;
    }

    public void setIsPromoting(String isPromoting) {
        this.isPromoting = isPromoting;
    }

    public String getIsTargetProject() {
        return isTargetProject;
    }

    public void setIsTargetProject(String isTargetProject) {
        this.isTargetProject = isTargetProject;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
