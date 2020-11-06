package cn.fjzxdz.frame.entity.core;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "sys_dept")
public class Dept extends TrackingEntity {

	private static final long serialVersionUID = 8588453704537937237L;

	@Column(name = "pid", insertable = false, updatable = false)
	private String pid;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "pid")
	private Dept parent;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	@OrderBy("num ASC")
	private Set<Dept> children = new HashSet<Dept>(0);

	private String name;

	private Integer num;

	private String leaderids;

	private String leadernames;

	private String pidpath;

	private String pnamepath;

	@Lob
	private String remark;

	private Integer enable;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "dept")
	private Set<Job> jobs = new HashSet<Job>();

	// ====================================================DTO===========================================================

	public Dept() {
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Dept getParent() {
		return parent;
	}

	public void setParent(Dept parent) {
		this.parent = parent;
	}

	public Set<Dept> getChildren() {
		return children;
	}

	public void setChildren(Set<Dept> children) {
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

	public String getPidpath() {
		return pidpath;
	}

	public void setPidpath(String pidpath) {
		this.pidpath = pidpath;
	}

	public String getPnamepath() {
		return pnamepath;
	}

	public void setPnamepath(String pnamepath) {
		this.pnamepath = pnamepath;
	}

	@Override
	public String toString() {
		return "Dept [pid=" + pid + ", parent=" + parent + ", children=" + children + ", name=" + name + ", num=" + num
				+ ", leaderids=" + leaderids + ", leadernames=" + leadernames + ", remark=" + remark + ", enable="
				+ enable + "]";
	}

}
