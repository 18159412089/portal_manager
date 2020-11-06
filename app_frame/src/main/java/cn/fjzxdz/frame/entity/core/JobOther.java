package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.commons.lang.StringUtils;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 用户岗位实体类，主要用于新增用户需要保存数据，区别于Oracle的Job
 * @author   gsq
 * @CreateTime 2019-10-21
 */
@Entity
public class JobOther extends TrackingEntity {

    private static final long serialVersionUID = 8588453704537937234L;

    private String name;

    private String seq;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dept", referencedColumnName = "uuid")
    private DeptOther dept;

    @JsonIgnore
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "job_user", joinColumns = { @JoinColumn(name = "job") }, inverseJoinColumns = {
            @JoinColumn(name = "user") })
    private Set<UserOther> users = new HashSet<UserOther>();

    private Integer enable;

    @Lob
    private String remark;

    private String oldSysUuid;

    @JsonIgnore
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "job_role", joinColumns = { @JoinColumn(name = "job") }, inverseJoinColumns = {
            @JoinColumn(name = "role") })
    private Set<RoleOther> roles = new HashSet<RoleOther>();

    // ====================================================DTO===========================================================

    @Transient
    private String deptName;

    @Transient
    private String roleNames;

    @Transient
    private String userNames;

    public String getDeptName() {
        if (null == dept) {
            return "";
        }
        return dept.getName();
    }

    public String getRoleNames() {
        String roleNames = "";
        if (ToolUtil.isNotEmpty(roles)) {
            List<String> tempList = new ArrayList<String>();
            for (RoleOther role : roles) {
                tempList.add(role.getName());
            }
            roleNames = StringUtils.join(tempList, ",");
            return roleNames;
        }
        return null;
    }

    public void setRoleNames(String roleNames) {
        this.roleNames = roleNames;
    }

    public String getUserNames() {
        String userNames = "";
        if (ToolUtil.isNotEmpty(users)) {
            List<String> tempList = new ArrayList<String>();
            for (UserOther user : users) {
                tempList.add(user.getName());
            }
            userNames = StringUtils.join(tempList, ",");
            return userNames;
        }
        return null;
    }

    public void setUserNames(String userNames) {
        this.userNames = userNames;
    }

    public JobOther() {}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public DeptOther getDept() {
        return dept;
    }

    public void setDept(DeptOther dept) {
        this.dept = dept;
    }

    public Set<UserOther> getUsers() {
        return users;
    }

    public void setUsers(Set<UserOther> users) {
        this.users = users;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
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

    public Set<RoleOther> getRoles() {
        return roles;
    }

    public void setRoles(Set<RoleOther> roles) {
        this.roles = roles;
    }

    @Override
    public String toString() {
        return "Job [name=" + name + ", seq=" + seq + ", dept=" + dept + ", users=" + users + ", enable=" + enable
                + ", remark=" + remark + ", roles=" + roles + ", deptName=" + deptName + ", roleNames=" + roleNames
                + ", userNames=" + userNames + "]";
    }

}
