package cn.fjzxdz.frame.entity.core;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 
 * 角色实体类 
 * @author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月14日 下午5:56:31
 */
@Entity
@Table(name = "sys_role")
public class Role extends TrackingEntity {

	private static final long serialVersionUID = -4831141570415325624L;

	private String name;

	private String code;

	private Integer num;

	@Lob
	private String remark;

	@JsonIgnore
	@ManyToMany(mappedBy = "roles")
	private Set<Job> jobs = new HashSet<>();

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "sys_role_menu", joinColumns = { @JoinColumn(name = "role") }, inverseJoinColumns = {
			@JoinColumn(name = "menu") })
	private Set<Menu> menus = new HashSet<>();

	public Role() {
	}

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