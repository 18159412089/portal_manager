package com.fjzxdz.ams.module.debriefing.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

import java.math.BigDecimal;

@Entity
@Table(name = "COMMON_RELATION_TABLE")
public class CommonRelationTable extends TrackingEntity {

    private static final long serialVersionUID = -1769925538835340337L;

    private String code;

    private String name;

    private String relation;
    private BigDecimal num;

    // ====================================================DTO===========================================================

    public CommonRelationTable() {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

}