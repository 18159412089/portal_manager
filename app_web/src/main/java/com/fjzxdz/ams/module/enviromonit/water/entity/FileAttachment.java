package com.fjzxdz.ams.module.enviromonit.water.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Table;


@Entity
@Table(name="FILE_ATTACHMENT")
public class FileAttachment extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * source
	 */
	private String source;

	/**
	 * picture
	 */
	private String picture;

	/**
	 * video
	 */
	private String video;

	/**
	 * picname
	 */
	private String picname;

	/**
	 * vedioname
	 */
	private String vedioname;

	/**
	 * pkid
	 */
	private String pkid;

	/**
	 * describe
	 */
	private String describe;

	public FileAttachment() {
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	@Override
	public String getUuid() {
		return uuid;
	}

	@Override
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
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

	public String getPkid() {
		return pkid;
	}

	public void setPkid(String pkid) {
		this.pkid = pkid;
	}
}