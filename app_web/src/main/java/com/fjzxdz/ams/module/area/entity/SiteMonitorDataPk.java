package com.fjzxdz.ams.module.area.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
@Embeddable
public class SiteMonitorDataPk implements Serializable {
	/** 省控站位编码 */
	@Column(name = "SK_CODE")
	private String skCode;
	/** 监测时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date JCSJ;
	public String getSkCode() {
		return skCode;
	}
	public void setSkCode(String skCode) {
		this.skCode = skCode;
	}
	public java.util.Date getJCSJ() {
		return JCSJ;
	}
	public void setJCSJ(java.util.Date jCSJ) {
		JCSJ = jCSJ;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		          int result = 1;
		          result = prime * result + ((skCode == null) ? 0 : skCode.hashCode());
		          result = prime * result
		                  + ((JCSJ == null) ? 0 : JCSJ.hashCode());
		          return result;
	}
	@Override
	public boolean equals(Object obj) {
		 if (this == obj) {
			return true;
		}
         if (obj == null) {
			return false;
		}
         if (getClass() != obj.getClass()) {
			return false;
		}
         SiteMonitorDataPk other = (SiteMonitorDataPk) obj;
         if (skCode == null) {
             if (other.skCode != null) {
				return false;
			}
         } else if (!skCode.equals(other.skCode)) {
			return false;
		}
         if (JCSJ == null) {
             if (other.JCSJ != null) {
				return false;
			}
         } else if (!JCSJ.equals(other.JCSJ)) {
			return false;
		}
         return true;
	}
}
