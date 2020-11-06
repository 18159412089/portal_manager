/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.basin.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 流域监控Entity
 * @author slq
 * @version 2019-03-12
 */
@Entity
@Table(name = "BASIN_CAMERA")
public class BasinCamera extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;
	/**  */
	private String name;
	/**  */
	private String indexCode;
	/**  */
	private String parentIndexCode;
	/**  */
	private String latitude;
	/**  */
	private String longitude;
	/**  */
	private String place;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}
	public String getParentIndexCode() {
		return parentIndexCode;
	}

	public void setParentIndexCode(String parentIndexCode) {
		this.parentIndexCode = parentIndexCode;
	}
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
}


