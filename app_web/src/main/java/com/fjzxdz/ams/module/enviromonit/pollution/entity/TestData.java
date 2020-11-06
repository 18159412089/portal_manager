package com.fjzxdz.ams.module.enviromonit.pollution.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "TEST_DATA")
public class TestData extends TrackingEntity {
	private static final long serialVersionUID = 1L;

	@Column(name = "MN_NUMBER")
	private String mnNumber;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPLOAD_TIME")
	private Date uploadTime;

	@Column(name = "TEST_TYPE")
	private String test_type;

	@Lob
	@Column(name = "T_DATA")
	private String tData;

	public TestData() {
	}

	public String getMnNumber() {
		return mnNumber;
	}

	public void setMnNumber(String mnNumber) {
		this.mnNumber = mnNumber;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getTest_type() {
		return test_type;
	}

	public void setTest_type(String test_type) {
		this.test_type = test_type;
	}

	public String gettData() {
		return tData;
	}

	public void settData(String tData) {
		this.tData = tData;
	}

}