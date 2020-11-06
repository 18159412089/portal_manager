package cn.fjzxdz.frame.entity.core;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 
 * 用户实体类 
 * @author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月14日 下午5:55:11
 */
@Entity
@Table(name = "sys_user")
public class User extends TrackingEntity {

	private static final long serialVersionUID = -3775561167522280151L;

	private String avatar;

	private String loginname;

	private String name;

	private String password;

	private String email;

	private String phone;

	private Integer sex;

	private String idcard;

	@Enumerated(EnumType.ORDINAL)
	private LoginType logintype;

	private Integer enable;

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

	public User() {
	}

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

	public Set<Job> getJobs() {
		return jobs;
	}

	public void setJobs(Set<Job> jobs) {
		this.jobs = jobs;
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

}