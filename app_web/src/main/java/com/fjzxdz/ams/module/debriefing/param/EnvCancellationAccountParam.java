package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.EnvCancellationAccount;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class EnvCancellationAccountParam extends BaseQueryParam {

    private String projectName;

    private String describleName;

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public EnvCancellationAccountParam() {
        super(EnvCancellationAccount.class);
        this.clazz = EnvCancellationAccount.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("project.name", getProjectName(), SearchCondition.LIKE);
        addClause("describle.name", getDescribleName(), SearchCondition.LIKE);
        setOrderBy(" createDate desc");
    }

    public String getDescribleName() {
        return describleName;
    }

    public void setDescribleName(String describleName) {
        this.describleName = describleName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }


}