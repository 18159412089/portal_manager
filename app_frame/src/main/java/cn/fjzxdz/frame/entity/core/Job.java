package cn.fjzxdz.frame.entity.core;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 岗位实体类 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月14日 下午5:59:07
 */
@Entity
@Table(name = "sys_job")
public class Job extends TrackingEntity {

	private static final long serialVersionUID = 8588453704537937234L;

	private String name;

	private String seq;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dept", referencedColumnName = "uuid")
	private Dept dept;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "sys_job_user", joinColumns = { @JoinColumn(name = "job") }, inverseJoinColumns = {
			@JoinColumn(name = "user_id") })
	private Set<User> users = new HashSet<User>();

	private Integer enable;

	@Lob
	private String remark;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "sys_job_role", joinColumns = { @JoinColumn(name = "job") }, inverseJoinColumns = {
			@JoinColumn(name = "role") })
	private Set<Role> roles = new HashSet<Role>();

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
			for (Role role : roles) {
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
			for (User user : users) {
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

	public Job() {
	}

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

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
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

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Override
	public String toString() {
		return "Job [name=" + name + ", seq=" + seq + ", dept=" + dept + ", users=" + users + ", enable=" + enable
				+ ", remark=" + remark + ", roles=" + roles + ", deptName=" + deptName + ", roleNames=" + roleNames
				+ ", userNames=" + userNames + "]";
	}

}