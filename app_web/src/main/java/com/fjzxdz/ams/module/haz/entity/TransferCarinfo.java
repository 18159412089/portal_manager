/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 危废转移车辆信息Entity
 * @author htj
 * @version 2019-02-19
 */
@Entity
@Table(name = "HAZ_TRANSFER_CAR_INFO")
public class TransferCarinfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 车辆方向 */
	private Double DIRECTION;
	/** 车辆所属公司 */
	private String COMPANY;
	/** 车辆所在位置描述 */
	private String LOCATION;
	/** GPS时间 */
	private java.util.Date TIME;
	/** 车牌号 */
	private String VNO;
	/** GPS信息ID */
	@Id
	private Integer momId;
	/** 更新时间 */
	private java.util.Date updatetimeRjwa;
	/** 车辆行驶速度 */
	private Double SPEED;
	/** 车牌颜色 */
	private String VCOLOR;
	/** 车辆状态 */
	private String STATUS;
	/** 车辆位置纬度 */
	private Double Y;
	/** 车辆位置经度 */
	private Double X;
	/** 车辆类型 */
	private String TYPE;
	
	public Double getDIRECTION() {
		return DIRECTION;
	}

	public void setDIRECTION(Double dIRECTION) {
		this.DIRECTION = DIRECTION;
	}
	public String getCOMPANY() {
		return COMPANY;
	}

	public void setCOMPANY(String cOMPANY) {
		this.COMPANY = COMPANY;
	}
	public String getLOCATION() {
		return LOCATION;
	}

	public void setLOCATION(String lOCATION) {
		this.LOCATION = LOCATION;
	}
	public java.util.Date getTIME() {
		return TIME;
	}

	public void setTIME(java.util.Date tIME) {
		this.TIME = TIME;
	}
	public String getVNO() {
		return VNO;
	}

	public void setVNO(String vNO) {
		this.VNO = VNO;
	}
	public Integer getMomId() {
		return momId;
	}

	public void setMomId(Integer momId) {
		this.momId = momId;
	}
	public java.util.Date getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}

	public void setUpdatetimeRjwa(java.util.Date updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public Double getSPEED() {
		return SPEED;
	}

	public void setSPEED(Double sPEED) {
		this.SPEED = SPEED;
	}
	public String getVCOLOR() {
		return VCOLOR;
	}

	public void setVCOLOR(String vCOLOR) {
		this.VCOLOR = VCOLOR;
	}
	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		this.STATUS = STATUS;
	}
	public Double getY() {
		return Y;
	}

	public void setY(Double y) {
		this.Y = Y;
	}
	public Double getX() {
		return X;
	}

	public void setX(Double x) {
		this.X = X;
	}
	public String getTYPE() {
		return TYPE;
	}

	public void setTYPE(String tYPE) {
		this.TYPE = TYPE;
	}
	
}


