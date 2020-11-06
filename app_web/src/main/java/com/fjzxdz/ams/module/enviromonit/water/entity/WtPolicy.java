package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "WT_POLICY")
public class WtPolicy implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	private String uuid;
	
	private String name;

	@Lob
	private String remark;
	
	@Lob
	private String analysis;
	
	public WtPolicy() {
	}

	// ----------------------------------------------------DTO---------------------------------------------------
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAnalysis() {
		return analysis;
	}

	public void setAnalysis(String analysis) {
		this.analysis = analysis;
	}
	
}