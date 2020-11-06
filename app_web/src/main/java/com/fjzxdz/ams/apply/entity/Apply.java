package com.fjzxdz.ams.apply.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name="consumable_applylist")
public class Apply extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	/**
	 * 申请单号
	 */
	private String code;

	/**
	 * 申请时间
	 */
	@Temporal(TemporalType.TIMESTAMP)
	private Date applydate;
	/**
	 * 采购人
	 */
	private String applyuse;

	/**
	 * 采购物品
	 */
	private String name;
	/**
	 * 采购数量
	 */
	private Integer applynumber;

	/**
	 * 单位
	 */
	private String applyunit;
	/**
	 * 单价
	 */
	private BigDecimal price;

	/**
	 * 总价
	 */
	private BigDecimal total;
	/**
	 * 备注
	 */
	private String remake;
	
	public Apply() {
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getApplydate() {
		return applydate;
	}

	public void setApplydate(Date applydate) {
		this.applydate = applydate;
	}

	public String getApplyuse() {
		return applyuse;
	}

	public void setApplyuse(String applyuse) {
		this.applyuse = applyuse;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getApplynumber() {
		return applynumber;
	}

	public void setApplynumber(Integer applynumber) {
		this.applynumber = applynumber;
	}

	public String getApplyunit() {
		return applyunit;
	}

	public void setApplyunit(String applyunit) {
		this.applyunit = applyunit;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getRemake() {
		return remake;
	}

	public void setRemake(String remake) {
		this.remake = remake;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

}
