package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="WT_CITY_MINUTE_DATA")
public class WtCityMinuteData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String uuid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datatime;

	@Column(name="POINT_CODE")
	private String pointCode;
	
	@Column(name="POINT_NAME")
	private String pointName;
	
	@Column(name="CODE_POLLUTE")
	private String codePollute;
	
	private String paramname;
	
	private String datavalue;

	private BigDecimal status;
	
	public WtCityMinuteData() {
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Date getDatatime() {
		return datatime;
	}

	public void setDatatime(Date datatime) {
		this.datatime = datatime;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getCodePollute() {
		return codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public String getParamname() {
		return paramname;
	}

	public void setParamname(String paramname) {
		this.paramname = paramname;
	}

	public String getDatavalue() {
		return datavalue;
	}

	public void setDatavalue(String datavalue) {
		this.datavalue = datavalue;
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

}