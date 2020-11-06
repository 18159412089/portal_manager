package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class JointOrderDetailPk implements Serializable {
	/** 转移联单id */
	private String zyldId;
	
	/** 危废代码 */
	private String CODE;

	public String getZyldId() {
		return zyldId;
	}

	public void setZyldId(String zyldId) {
		this.zyldId = zyldId;
	}

	public String getCODE() {
		return CODE;
	}

	public void setCODE(String cODE) {
		CODE = cODE;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		          int result = 1;
		          result = prime * result + ((CODE == null) ? 0 : CODE.hashCode());
		          result = prime * result
		                  + ((zyldId == null) ? 0 : zyldId.hashCode());
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
         JointOrderDetailPk other = (JointOrderDetailPk) obj;
         if (zyldId == null) {
             if (other.zyldId != null)
                 return false;
         } else if (!zyldId.equals(other.zyldId))
             return false;
         if (CODE == null) {
             if (other.CODE != null)
                 return false;
         } else if (!CODE.equals(other.CODE))
             return false;
         return true;
	}
	
}
