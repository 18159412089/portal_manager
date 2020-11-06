package com.fjzxdz.ams.module.enviromonit.common.param;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fjzxdz.ams.module.enviromonit.common.entity.PeCommonCode;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class PeCommonCodeParam extends BaseQueryParam {

	private static final long serialVersionUID = 1L;

	private BigDecimal id;

	private String code;
	private String name;
	private BigDecimal parentId;
	private BigDecimal seq;
	private BigDecimal status;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createTime;
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public PeCommonCodeParam() {
		super();
		this.clazz = PeCommonCode.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("id", getId(), SearchCondition.EQ);
		addClause("code", getCode(), SearchCondition.LIKE);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("parentId", getParentId(), SearchCondition.EQ);
		addClause("seq", getSeq(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.EQ);
		addClause("createTime", getCreateTime(), SearchCondition.DEFAULT);
		setOrderBy(" seq asc");
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getParentId() {
		return parentId;
	}

	public void setParentId(BigDecimal parentId) {
		this.parentId = parentId;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Class getClazz() {
		return clazz;
	}

	public void setClazz(Class clazz) {
		this.clazz = clazz;
	}

}
