/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 水电站点位基本信息Entity
 * @author htj
 * @version 2019-02-18
 */
@Entity
@Table(name = "HYD_POSITION_INFO")
public class Hydpositoninfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 是否正在使用 */
	private String isUsed;
	/** 点位ID */
	@Id
	private Integer eqpId;
	/** 设备ID */
	private Integer hydropowerId;
	/** 点位名称 */
	private String eqpName;
	/** 更新频率 */
	private Long CYC;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hydpositoninfo")
	private Set<Hyddevexitdata> hyddevexitdatasSet  = new HashSet<Hyddevexitdata>();
	
	public String getIsUsed() {
		return isUsed;
	}

    	

	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	public Integer getEqpId() {
		return eqpId;
	}

	public void setEqpId(Integer eqpId) {
		this.eqpId = eqpId;
	}
	public Integer getHydropowerId() {
		return hydropowerId;
	}

	public void setHydropowerId(Integer hydropowerId) {
		this.hydropowerId = hydropowerId;
	}
	public String getEqpName() {
		return eqpName;
	}

	public void setEqpName(String eqpName) {
		this.eqpName = eqpName;
	}
	public Long getCYC() {
		return CYC;
	}

	public void setCYC(Long cYC) {
		this.CYC = cYC;
	}

	public Set<Hyddevexitdata> getHyddevexitdatasSet() {
		return hyddevexitdatasSet;
	}

	public void setHyddevexitdatasSet(Set<Hyddevexitdata> hyddevexitdatasSet) {
		this.hyddevexitdatasSet = hyddevexitdatasSet;
	}
}


