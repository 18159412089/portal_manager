package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.Id;

import com.fjzxdz.ams.module.hydposition.entity.HydddraindaydataPrimaryKey;

@Embeddable
public class EnterpriseWastePk implements Serializable {
	/** 固废系统企业id */
 
	private String enterpriseId;
	/** 更新时间 */
 
	private java.util.Date UPDATETIME;
	public String getEnterpriseId() {
		return enterpriseId;
	}
	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}
	public void setUPDATETIME(java.util.Date uPDATETIME) {
		UPDATETIME = uPDATETIME;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		          int result = 1;
		          result = prime * result + ((enterpriseId == null) ? 0 : enterpriseId.hashCode());
		          result = prime * result
		                  + ((UPDATETIME == null) ? 0 : UPDATETIME.hashCode());
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
         EnterpriseWastePk other = (EnterpriseWastePk) obj;
         if (enterpriseId == null) {
             if (other.enterpriseId != null)
                 return false;
         } else if (!enterpriseId.equals(other.enterpriseId))
             return false;
         if (UPDATETIME == null) {
             if (other.UPDATETIME != null)
                 return false;
         } else if (!UPDATETIME.equals(other.UPDATETIME))
             return false;
         return true;
	}
}
