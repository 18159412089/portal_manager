package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.TrackingEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户实体类，主要用于新增用户需要保存数据，区别于Oracle的User
 * @author   gsq
 * @CreateTime 2019-10-17
 */
@Entity
public class UserOther extends TrackingEntity {

    private static final long serialVersionUID = -3775561167522280151L;

    private String avatar;

    private String loginname;

    private String name;

    private String password;

    private String email;

    private String phone;

    private Integer sex;

    private String idcard;

    private Integer loginTimes;

    private String lastLoginTime;

    private String lastLoginDate;

    private String lastLoginIp;

    private Integer lastLoginTimes;

    @Enumerated(EnumType.ORDINAL)
    private LoginType logintype;

    private Integer enable;

    private String oldSysUuid;

    private String morelogin;

    //老框架岗位ID
    @Transient
    private String positionId;

    //工作牌
    @Transient
    private String workCode;

    @JsonIgnore
    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "users")
    private Set<Job> jobs = new HashSet<Job>();

    // ====================================================DTO===========================================================

    @Transient
    private String jobName;

    @Transient
    private String roleName;

    @Transient
    private String deptName;

    public UserOther() {}

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public LoginType getLogintype() {
        return logintype;
    }

    public void setLogintype(LoginType logintype) {
        this.logintype = logintype;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public String getOldSysUuid() {
        return oldSysUuid;
    }

    public void setOldSysUuid(String oldSysUuid) {
        this.oldSysUuid = oldSysUuid;
    }

    public Set<Job> getJobs() {
        return jobs;
    }

    public void setJobs(Set<Job> jobs) {
        this.jobs = jobs;
    }

    public Integer getLoginTimes() {
        return loginTimes;
    }

    public void setLoginTimes(Integer loginTimes) {
        this.loginTimes = loginTimes;
    }

    public String getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(String lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public Integer getLastLoginTimes() {
        return lastLoginTimes;
    }

    public void setLastLoginTimes(Integer lastLoginTimes) {
        this.lastLoginTimes = lastLoginTimes;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    @Override
    public String toString() {
        return "User [avatar=" + avatar + ", loginname=" + loginname + ", name=" + name + ", password=" + password
                + ", email=" + email + ", phone=" + phone + ", sex=" + sex + ", idcard=" + idcard + ", logintype="
                + logintype + ", enable=" + enable + ", roleName=" + roleName + ", jobName=" + jobName + ", deptName="
                + deptName + "]";
    }

    public String getMorelogin() {
        return morelogin;
    }

    public void setMorelogin(String morelogin) {
        this.morelogin = morelogin;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getWorkCode() {
        return workCode;
    }

    public void setWorkCode(String workCode) {
        this.workCode = workCode;
    }

}
