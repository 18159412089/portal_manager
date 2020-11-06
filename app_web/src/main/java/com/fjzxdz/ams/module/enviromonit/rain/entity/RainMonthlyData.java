package com.fjzxdz.ams.module.enviromonit.rain.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name = "RAIN_MONTHLY_DATA")
public class RainMonthlyData implements Serializable {

	private static final long serialVersionUID = -2783724562198035279L;
	@Id
	private String uuid;
	
	private String time;
	
	private BigDecimal days;
	
	@Column(name="SUNSHINE_DURATION")
	private BigDecimal sunshineDuration;
	
	@Column(name="RAIN_FALL")
	private BigDecimal rainFall;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public BigDecimal getDays() {
		return days;
	}

	public void setDays(BigDecimal days) {
		this.days = days;
	}

	public BigDecimal getSunshineDuration() {
		return sunshineDuration;
	}

	public void setSunshineDuration(BigDecimal sunshineDuration) {
		this.sunshineDuration = sunshineDuration;
	}

	public BigDecimal getRainFall() {
		return rainFall;
	}

	public void setRainFall(BigDecimal rainFall) {
		this.rainFall = rainFall;
	}

	
	
	
}
