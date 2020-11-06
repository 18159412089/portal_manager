package com.fjzxdz.ams.module.enviromonit.air.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 
 * 公共编码实体
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:59:23
 */
@Entity
@Table(name = "COMMON_CODE")
public class CommonCode implements Serializable {

	private static final long serialVersionUID = 8588453704537937234L;

	@Id
	@Column(name="ID")
	private BigDecimal id;
	
	private String code;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_TIME")
	private Date createTime;

	private String name;
	
	private BigDecimal seq;

	private BigDecimal status;
	
	@Column(name = "PARENT_ID")
	private BigDecimal parentId;

	// ====================================================DTO===========================================================

//	@Transient
//	private String parentName;

	public CommonCode() {
	}

	public BigDecimal getId() {
		return id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getSeq() {
		return seq;
	}

	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public BigDecimal getParentId() {
		return parentId;
	}

	public void setParentId(BigDecimal parentId) {
		this.parentId = parentId;
	}

}