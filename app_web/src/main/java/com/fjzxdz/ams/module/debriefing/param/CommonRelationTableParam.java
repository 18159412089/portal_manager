package com.fjzxdz.ams.module.debriefing.param;

import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

import java.math.BigDecimal;

@SuppressWarnings("serial")
public class CommonRelationTableParam extends BaseQueryParam {

    private String code;

    private String relation;
    
    private String name;
    private BigDecimal num;

    @SuppressWarnings({ "rawtypes", "unused" })
    private Class clazz;

    public CommonRelationTableParam() {
        super(CommonRelationTable.class);
        this.clazz = CommonRelationTable.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("code", getCode(), SearchCondition.EQ);
        addClause("num", getNum(), SearchCondition.EQ);
        addClause("relation", getRelation(), SearchCondition.LIKE);
        addClause("name", getName(), SearchCondition.LIKE);
        setOrderBy(" createDate desc");
    }

    public BigDecimal getNum() {
        return num;
    }

    public void setNum(BigDecimal num) {
        this.num = num;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    
    

}