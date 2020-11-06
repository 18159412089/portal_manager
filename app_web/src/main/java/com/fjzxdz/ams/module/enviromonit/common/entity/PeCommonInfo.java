package com.fjzxdz.ams.module.enviromonit.common.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.databind.ser.std.SerializableSerializer;

@Entity
@Table(name = "PE_COMMON_INFO")
public class PeCommonInfo extends SerializableSerializer {

	private static final long serialVersionUID = 1L;

	@Id
	private Long pluId;
	private String pluCode;
	private String pluName;
	private String outfallType;
	private String unit;

	public PeCommonInfo() {
		super();
	}

	public Long getPluId() {
		return pluId;
	}

	public void setPluId(Long pluId) {
		this.pluId = pluId;
	}

	public String getPluCode() {
		return pluCode;
	}

	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}

	public String getPluName() {
		return pluName;
	}

	public void setPluName(String pluName) {
		this.pluName = pluName;
	}

	public String getOutfallType() {
		return outfallType;
	}

	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}
