package com.fjzxdz.ams.module.debriefing.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "COMMON_TASK_TABLE")
public class CommonTaskTable extends TrackingEntity {

    private static final long serialVersionUID = -1769925538835340337L;

    @Column(name="RELATION_CODE")
    private String relationCode;
    
    @Column(name="RELATION_NAME")
    private String relationName;
    
    @Lob
    private String problem;
    
    @Lob
    @Column(name="TARGET_REQUIRE")
    private String targetRequire;
    
    @Lob
    @Column(name="EXISTING_PROBLEM")
    private String existingProblem;
    
    private BigDecimal status;
    
    @Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATE_TIME")
	private Date createTime;
    
    @Transient
	private String createtime;

    // ====================================================DTO===========================================================

    public CommonTaskTable() {
    }

	public String getRelationCode() {
		return relationCode;
	}

	public void setRelationCode(String relationCode) {
		this.relationCode = relationCode;
	}

	public String getRelationName() {
		return relationName;
	}

	public void setRelationName(String relationName) {
		this.relationName = relationName;
	}

	public String getProblem() {
		return problem;
	}

	public void setProblem(String problem) {
		this.problem = problem;
	}

	public String getTargetRequire() {
		return targetRequire;
	}

	public void setTargetRequire(String targetRequire) {
		this.targetRequire = targetRequire;
	}

	public String getExistingProblem() {
		return existingProblem;
	}

	public void setExistingProblem(String existingProblem) {
		this.existingProblem = existingProblem;
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	
    
}