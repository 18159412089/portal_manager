/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 联单详细信息Entity
 * @author htj
 * @version 2019-02-19
 */
@Entity
@Table(name = "HAZ_JOINT_ORDER_DETAIL")
public class JointOrderDetail implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 容器数量 */
	private String GUIGEXINGHAO;
	/** 规格型号 */
	private String CAIZHI;
	/** 转移危废重量单位 */
	private String WXCF;
	/** 材质 */
	private Integer ZYL;
	/** 容器类型 */
	private Integer RONGQISL;
	/** 危废名称 */
	private String SUCHENG;
	/** 危险成分 */
	private String WXTX;
	/**  */
	private String RONGQILX;
	/** 处置方式代码 */
	private String czfsName;
	
	@EmbeddedId
	private JointOrderDetailPk jointOrderDetailPk;
	
	
	public JointOrderDetailPk getJointOrderDetailPk() {
		return jointOrderDetailPk;
	}

	public void setJointOrderDetailPk(JointOrderDetailPk jointOrderDetailPk) {
		this.jointOrderDetailPk = jointOrderDetailPk;
	}

	/** 转移量 */
	private String czJsl;
	/**  */
	private java.util.Date UPDATETIME;

	/** 处置单位接收量 */
	private String DANWEI;
	
	public String getGUIGEXINGHAO() {
		return GUIGEXINGHAO;
	}

	public void setGUIGEXINGHAO(String gUIGEXINGHAO) {
		this.GUIGEXINGHAO = GUIGEXINGHAO;
	}
	public String getCAIZHI() {
		return CAIZHI;
	}

	public void setCAIZHI(String cAIZHI) {
		this.CAIZHI = CAIZHI;
	}
	public String getWXCF() {
		return WXCF;
	}

	public void setWXCF(String wXCF) {
		this.WXCF = WXCF;
	}
	public Integer getZYL() {
		return ZYL;
	}

	public void setZYL(Integer zYL) {
		this.ZYL = ZYL;
	}
	public Integer getRONGQISL() {
		return RONGQISL;
	}

	public void setRONGQISL(Integer rONGQISL) {
		this.RONGQISL = RONGQISL;
	}
	public String getSUCHENG() {
		return SUCHENG;
	}

	public void setSUCHENG(String sUCHENG) {
		this.SUCHENG = SUCHENG;
	}
	public String getWXTX() {
		return WXTX;
	}

	public void setWXTX(String wXTX) {
		this.WXTX = WXTX;
	}
	public String getRONGQILX() {
		return RONGQILX;
	}

	public void setRONGQILX(String rONGQILX) {
		this.RONGQILX = RONGQILX;
	}
	public String getCzfsName() {
		return czfsName;
	}

	public void setCzfsName(String czfsName) {
		this.czfsName = czfsName;
	}
	 
	public String getCzJsl() {
		return czJsl;
	}

	public void setCzJsl(String czJsl) {
		this.czJsl = czJsl;
	}
	public java.util.Date getUPDATETIME() {
		return UPDATETIME;
	}

	public void setUPDATETIME(java.util.Date uPDATETIME) {
		this.UPDATETIME = UPDATETIME;
	}
	 
	public String getDANWEI() {
		return DANWEI;
	}

	public void setDANWEI(String dANWEI) {
		this.DANWEI = DANWEI;
	}
	
}


