package com.fjzxdz.ams.module.enviromonit.resource.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;
import cn.fjzxdz.frame.entity.core.Role;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "res_data")
public class ResData extends TrackingEntity {

	private static final long serialVersionUID = -4472692204211650257L;

	@Column(name = "pid", insertable = false, updatable = false)
	private String pid;

	private String pids;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pid")
	private ResData parent;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	@Cascade({ org.hibernate.annotations.CascadeType.ALL })
	@OrderBy("num ASC")
	private Set<ResData> children = new HashSet<ResData>();

	private String name;

	private String icon;

	private Integer num;

	private String url;

	private Integer levels;

	@Lob
	private String remark;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "menus")
	private Set<Role> roles = new HashSet<Role>();

	public ResData() {
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPids() {
		return pids;
	}

	public void setPids(String pids) {
		this.pids = pids;
	}

	public ResData getParent() {
		return parent;
	}

	public void setParent(ResData parent) {
		this.parent = parent;
	}

	public Set<ResData> getChildren() {
		return children;
	}

	public void setChildren(Set<ResData> children) {
		this.children = children;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getLevels() {
		return levels;
	}

	public void setLevels(Integer levels) {
		this.levels = levels;
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
		return "Menu [pid=" + pid + ", pids=" + pids + ", parent=" + parent + ", children=" + children + ", name="
				+ name + ", icon=" + icon + ", num=" + num + ", url=" + url + ", levels=" + levels + ", remark="
				+ remark + ", roles=" + roles + "]";
	}

}