package com.fjzxdz.ams.module.jobSchedule.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 工作调度-部门管理
 * 
 * @author chenbk
 * @version 2019-04-23
 */
@Entity
@Table(name = "JOB_SCHEDULE_DEPARTMENT")
public class JobScheduleDepartment extends TrackingEntity {
    private static final long serialVersionUID = 1L;

    private String category;

    private BigDecimal enable;

    private String name;

    @Lob
    @Column(name = "USER_ID")
    private String userId;

    @Lob
    @Column(name = "USER_NAME")
    private String userName;

    public JobScheduleDepartment() {
    }

    public String getCategory() {
        return this.category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getEnable() {
        return this.enable;
    }

    public void setEnable(BigDecimal enable) {
        this.enable = enable;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

}