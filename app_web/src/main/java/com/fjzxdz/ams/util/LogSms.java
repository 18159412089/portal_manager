package com.fjzxdz.ams.util;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 
 * 短信日志表实体
 * @Author   hyl
 * @Version   1.0 
 * @CreateTime 2019年11月8日15:02:27
 */
@Entity
@Table(name = "LOG_SMS")
public class LogSms extends TrackingEntity {

	private static final long serialVersionUID = -1956770825084215679L;

	/**
	 * 主键id
	 */
	private String uuid;

	/**
	 * 短信内容
	 */
	private String msg;

	/**
	 * 号码
	 */
	private String phone;

	/**
	 * 业务类型
	 */
	private String mark;

	public LogSms() {
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}
}
