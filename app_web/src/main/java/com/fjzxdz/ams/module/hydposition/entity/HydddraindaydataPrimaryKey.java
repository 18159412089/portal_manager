package com.fjzxdz.ams.module.hydposition.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
@Embeddable
public class HydddraindaydataPrimaryKey  implements Serializable {
 
	private static final long serialVersionUID = 1L;
	@Column(name = "OUTPUT_ID")
	private Integer outputId;
	
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date measureTime;
	public Integer getOutputId() {
		return outputId;
	}
	public void setOutputId(Integer outputId) {
		this.outputId = outputId;
	}
	public java.util.Date getMeasureTime() {
		return measureTime;
	}
	public void setMeasureTime(java.util.Date measureTime) {
		this.measureTime = measureTime;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		          int result = 1;
		          result = prime * result + ((outputId == null) ? 0 : outputId.hashCode());
		          result = prime * result
		                  + ((measureTime == null) ? 0 : measureTime.hashCode());
		          return result;
	}
	@Override
	public boolean equals(Object obj) {
		 if (this == obj)
             return true;
         if (obj == null)
             return false;
         if (getClass() != obj.getClass())
             return false;
         HydddraindaydataPrimaryKey other = (HydddraindaydataPrimaryKey) obj;
         if (outputId == null) {
             if (other.outputId != null)
                 return false;
         } else if (!outputId.equals(other.outputId))
             return false;
         if (measureTime == null) {
             if (other.measureTime != null)
                 return false;
         } else if (!measureTime.equals(other.measureTime))
             return false;
         return true;
	}
	
	
}
