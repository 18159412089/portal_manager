package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="WT_MN_HOUR_DATA")
public class WtMnHourData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String uuid;

	@Column(name="CODE_POLLUTE")
	private String codePollute;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datatime;

	private String datavalue;

	private String mn;

	private String mnname;

	private String paramname;

	private BigDecimal status;

	public WtMnHourData() {
	}

	public String getUuid() {
		return this.uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCodePollute() {
		return this.codePollute;
	}

	public void setCodePollute(String codePollute) {
		this.codePollute = codePollute;
	}

	public Date getDatatime() {
		return this.datatime;
	}

	public void setDatatime(Date datatime) {
		this.datatime = datatime;
	}

	public String getDatavalue() {
		return this.datavalue;
	}

	public void setDatavalue(String datavalue) {
		this.datavalue = datavalue;
	}

	public String getMn() {
		return this.mn;
	}

	public void setMn(String mn) {
		this.mn = mn;
	}

	public String getMnname() {
		return this.mnname;
	}

	public void setMnname(String mnname) {
		this.mnname = mnname;
	}

	public String getParamname() {
		return this.paramname;
	}

	public void setParamname(String paramname) {
		this.paramname = paramname;
	}

	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

}