package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.TrackingEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * 网格部门类，主要用于新增用户需要保存数据，区别于Oracle的Dept
 * @author   gsq
 * @CreateTime 2019-10-18
 */
@Entity
public class DeptOther extends TrackingEntity {

    private static final long serialVersionUID = 8588453704537937237L;

    @Column(name = "pid", insertable = false, updatable = false)
    private String pid;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "pid")
    private DeptOther parent;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
    @OrderBy("num ASC")
    private Set<DeptOther> children = new HashSet<DeptOther>(0);

    private String name;

    private Integer num;

    private String leaderids;

    private String leadernames;

    @Lob
    private String remark;

    private String oldSysUuid;

    private Integer enable;

    private String pids;

    private String code;

    private String departmentType;

    private String oldSysPids;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "dept")
    private Set<Job> jobs = new HashSet<Job>();

    // ====================================================DTO===========================================================

    public DeptOther() {}

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public DeptOther getParent() {
        return parent;
    }

    public void setParent(DeptOther parent) {
        this.parent = parent;
    }

    public Set<DeptOther> getChildren() {
        return children;
    }

    public void setChildren(Set<DeptOther> children) {
        this.children = children;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getLeaderids() {
        return leaderids;
    }

    public void setLeaderids(String leaderids) {
        this.leaderids = leaderids;
    }

    public String getLeadernames() {
        return leadernames;
    }

    public void setLeadernames(String leadernames) {
        this.leadernames = leadernames;
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

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public Set<Job> getJobs() {
        return jobs;
    }

    public void setJobs(Set<Job> jobs) {
        this.jobs = jobs;
    }

    public String getPids() {
        return pids;
    }

    public void setPids(String pids) {
        this.pids = pids;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDepartmentType() {
        return departmentType;
    }

    public void setDepartmentType(String departmentType) {
        this.departmentType = departmentType;
    }

    public String getOldSysPids() {
        return oldSysPids;
    }

    public void setOldSysPids(String oldSysPids) {
        this.oldSysPids = oldSysPids;
    }

    @Override
    public String toString() {
        return "Dept [pid=" + pid + ", parent=" + parent + ", children=" + children + ", name=" + name + ", num=" + num
                + ", leaderids=" + leaderids + ", leadernames=" + leadernames + ", remark=" + remark + ", enable="
                + enable + "]";
    }

}
