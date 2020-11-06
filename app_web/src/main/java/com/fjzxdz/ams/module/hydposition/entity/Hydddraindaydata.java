/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 水电站下泄流量日统计数据Entity
 * @author htj
 * @version 2019-02-20
 */
@Entity
@Table(name = "HYD_DRAIN_DAY_DATA")
public class Hydddraindaydata implements Serializable {

 
	private static final long serialVersionUID = 1L;
	/**  */
	private Double maxValue;
	/**  */
	@EmbeddedId
    private HydddraindaydataPrimaryKey hydddraindaydataPrimaryKey;
	public HydddraindaydataPrimaryKey getHydddraindaydataPrimaryKey() {
		return hydddraindaydataPrimaryKey;
	}

	public void setHydddraindaydataPrimaryKey(HydddraindaydataPrimaryKey hydddraindaydataPrimaryKey) {
		this.hydddraindaydataPrimaryKey = hydddraindaydataPrimaryKey;
	}


	@JoinColumn(name="OUTPUT_ID", insertable=false, updatable=false)
    @ManyToOne(cascade = CascadeType.ALL)
	private Hyddevexitdata hyddevexitdata;
	
	
	/**  */
	private Double avgValue;
	/**  */
	private Double minValue;
	
	public Double getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(Double maxValue) {
		this.maxValue = maxValue;
	}
	 
	public Double getAvgValue() {
		return avgValue;
	}

	public void setAvgValue(Double avgValue) {
		this.avgValue = avgValue;
	}
	public Double getMinValue() {
		return minValue;
	}

	public void setMinValue(Double minValue) {
		this.minValue = minValue;
	}

	public Hyddevexitdata getHyddevexitdata() {
		return hyddevexitdata;
	}

	public void setHyddevexitdata(Hyddevexitdata hyddevexitdata) {
		this.hyddevexitdata = hyddevexitdata;
	}
	
}


