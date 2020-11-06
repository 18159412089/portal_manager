/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 水系面数据Entity
 * @author ZhangGQ
 * @version 2019-06-28
 */
@Entity
@Table(name = "WT_BASIN_PLANE_P_DATA")
public class WtBasinPlanePData extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;
	/** 主键 */
	private String id;
	/** 面数据 */
	private String geom;
	/** 河流名称 */
	private String name;
	/** 0代表不是水库，1代表是水库 */
	private String status;
	/** 水质等级 */
	private String grade;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getGeom() {
		return geom;
	}

	public void setGeom(String geom) {
		this.geom = geom;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	
}


