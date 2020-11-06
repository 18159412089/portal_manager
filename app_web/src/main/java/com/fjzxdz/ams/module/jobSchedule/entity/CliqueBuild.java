package com.fjzxdz.ams.module.jobSchedule.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 党建实体类
 * 
 * @Author caibai
 * @Version 1.0
 * @CreateTime 2019年4月30日 下午3:16:42
 */
@Entity
@Table(name = "CLIQUE_BUILD")
public class CliqueBuild extends TrackingEntity {
    private static final long serialVersionUID = 1L;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DEPARTMENT_ID")

    private JobScheduleDepartment department;

    @Column(name = "FILE_NAME")
    private String fileName;

    private String mongoid;

    private String name;

    private BigDecimal status;

    private String type;

    // ====================================================DTO===========================================================

    public CliqueBuild() {
    }

    public CliqueBuild(String uuid, String name, String mongoid, String departmentId, String departmentName,
            String type, BigDecimal status, Date updateDate, String fileName) {
        this.uuid = uuid;
        this.name = name;
        this.mongoid = mongoid;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.type = type;
        this.status = status;
        this.updateDate = updateDate;
        this.fileName = fileName;
    }

    @Transient
    private String departmentId;
    @Transient
    private String departmentName;
    @Transient
    private String deptUserID;

    public void setTransient() {
        if (ToolUtil.isNotEmpty(getDepartment())) {
            this.departmentId = department.getUuid();
            this.departmentName = department.getName();
            this.deptUserID = department.getUserId();
        }
    }

    public JobScheduleDepartment getDepartment() {
        return department;
    }

    public void setDepartment(JobScheduleDepartment department) {
        this.department = department;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getDeptUserID() {
        return deptUserID;
    }

    public void setDeptUserID(String deptUserID) {
        this.deptUserID = deptUserID;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getMongoid() {
        return this.mongoid;
    }

    public void setMongoid(String mongoid) {
        this.mongoid = mongoid;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getStatus() {
        return this.status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}