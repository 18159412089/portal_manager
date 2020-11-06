package cn.fjzxdz.frame.entity.core;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 
 * 菜单实体类 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月14日 下午5:57:38
 */
@Entity
@Table(name = "sys_menu")
public class Menu extends TrackingEntity {

	private static final long serialVersionUID = -4472692204211650257L;

	@Column(name = "pid", insertable = false, updatable = false)
	private String pid;

	private String pids;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pid")
	private Menu parent;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	@Cascade({ org.hibernate.annotations.CascadeType.ALL })
	@OrderBy("num ASC")
	private Set<Menu> children = new HashSet<Menu>();

	private String name;

	private String icon;

	private Integer num;

	private String url;

	private Integer levels;

	@Lob
	private String remark;
	
	/**
	 * 0:按钮；1：菜单
	 */
	private String type;
	
	private String permission;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "menus")
	private Set<Role> roles = new HashSet<Role>();

	public Menu() {
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

	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	public Set<Menu> getChildren() {
		return children;
	}

	public void setChildren(Set<Menu> children) {
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
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