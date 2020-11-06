/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.distributeMap.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * 地图 分布Entity
 * @author huangyl
 * @version 2019年7月23日14:44:44
 */
@Entity
@Table(name = "ENVIRONMEENT_MAP_DISTRIBUTION")
public class EnvironmeentMapDistribution extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;
	/** 纬度 */
	private Double latitude;
	/** 经度 */
	private Double longitude;
	/**  项目id*/
	private String name;
	/** 图片id */
	private String picture;
	/** 视频id */
	private String video;
	/** 图片名称 */
	private String picname;
	/** 视频名称 */
	private String vedioname;
	/**
	 * 项目名称
	 */
	private String projname;

	/** 备注 */
	private String remark;
	/** 区分漳浦还是漳州市 */
	private String mark;
	/** 描述 */
	@Lob
	private String disgribe;
	private String qx;

	public String getQx() {
		return qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getPicname() {
		return picname;
	}

	public void setPicname(String picname) {
		this.picname = picname;
	}

	public String getVedioname() {
		return vedioname;
	}

	public void setVedioname(String vedioname) {
		this.vedioname = vedioname;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDisgribe() {
		return disgribe;
	}

	public void setDisgribe(String disgribe) {
		this.disgribe = disgribe;
	}

	public String getProjname() {
		return projname;
	}

	public void setProjname(String projname) {
		this.projname = projname;
	}
}


