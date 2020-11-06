package com.fjzxdz.ams.module.datamonitor.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * @author shenliuyuan
 * @title: 信息汇报实体类
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/8/1914:57
 */
@Entity
@Table(name = "INFORMATION_REPORTING")
public class Reporting extends TrackingEntity {

    private static final long serialVersionUID = 1L;

    @Column(name = "CONTENT")
    private String content;

    @Column(name = "USER_ID")
    private String userId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Column(name = "CREATE_TIME")
    private Date createTime;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
