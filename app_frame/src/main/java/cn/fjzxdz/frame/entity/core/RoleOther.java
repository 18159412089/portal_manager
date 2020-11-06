package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.TrackingEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户角色实体类，主要用于新增用户需要保存数据，区别于Oracle的Role
 * @author   gsq
 * @CreateTime 2019-10-21
 */
@Entity
public class RoleOther extends TrackingEntity {

    private static final long serialVersionUID = -4831141570415325624L;

    private String name;

    private String code;

    private Integer num;

    @Lob
    private String remark;

    private String oldSysUuid;

    private String dataAccess;

    @JsonIgnore
    @ManyToMany(mappedBy = "roles")
    private Set<Job> jobs = new HashSet<>();

    @JsonIgnore
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "role_menu", joinColumns = { @JoinColumn(name = "role") }, inverseJoinColumns = {
            @JoinColumn(name = "menu") })
    private Set<Menu> menus = new HashSet<>();

    public RoleOther() {}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOldSysUuid() {
        return oldSysUuid;
    }

    public void setOldSysUuid(String oldSysUuid) {
        this.oldSysUuid = oldSysUuid;
    }

    public String getDataAccess() {
        return dataAccess;
    }

    public void setDataAccess(String dataAccess) {
        this.dataAccess = dataAccess;
    }

    public Set<Job> getJobs() {
        return jobs;
    }

    public void setJobs(Set<Job> jobs) {
        this.jobs = jobs;
    }

    public Set<Menu> getMenus() {
        return menus;
    }

    public void setMenus(Set<Menu> menus) {
        this.menus = menus;
    }

    @Override
    public String toString() {
        return "Role [name=" + name + ", code=" + code + ", num=" + num + ", remark=" + remark + ", menus=" + menus + "]";
    }

}
