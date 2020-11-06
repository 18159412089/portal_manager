/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 水电站设备出口Entity
 * @author htj
 * @version 2019-02-18
 */
@Entity
@Table(name = "HYD_DEV_EXIT_DATA")
public class Hyddevexitdata implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 环评要求最小下泄流量(立方米/秒) */
	private Double minFlow;
	/** 点位ID */
	@Column(name="eqp_id")
	private Integer eqpId;
	/** 出口ID */
	@Id
	private Long outputId;
	/** 设备ID */
	private Integer hydropowerId;
	/** 状态 */
	private String STATUS;
	/** 出口名称 */
	private String outputName;
	/** 出口编码 */
	private String outputCode;
	
	@JoinColumn(name="eqp_id", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private Hydpositoninfo hydpositoninfo;
	
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hyddevexitdata")
	private Set<Hydddraindaydata> hydddraindaydatasSet  = new HashSet<Hydddraindaydata>();
	
	
	public Double getMinFlow() {
		return minFlow;
	}

	public void setMinFlow(Double minFlow) {
		this.minFlow = minFlow;
	}
	public Integer getEqpId() {
		return eqpId;
	}

	public void setEqpId(Integer eqpId) {
		this.eqpId = eqpId;
	}
	public Long getOutputId() {
		return outputId;
	}

	public void setOutputId(Long outputId) {
		this.outputId = outputId;
	}
	public Integer getHydropowerId() {
		return hydropowerId;
	}

	public void setHydropowerId(Integer hydropowerId) {
		this.hydropowerId = hydropowerId;
	}
	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		this.STATUS = sTATUS;
	}
	public String getOutputName() {
		return outputName;
	}

	public void setOutputName(String outputName) {
		this.outputName = outputName;
	}
	public String getOutputCode() {
		return outputCode;
	}

	public void setOutputCode(String outputCode) {
		this.outputCode = outputCode;
	}

	public Hydpositoninfo getHydpositoninfo() {
		return hydpositoninfo;
	}

	public void setHydpositoninfo(Hydpositoninfo hydpositoninfo) {
		this.hydpositoninfo = hydpositoninfo;
	}

	public Set<Hydddraindaydata> getHydddraindaydatasSet() {
		return hydddraindaydatasSet;
	}

	public void setHydddraindaydatasSet(Set<Hydddraindaydata> hydddraindaydatasSet) {
		this.hydddraindaydatasSet = hydddraindaydatasSet;
	}
	
}


