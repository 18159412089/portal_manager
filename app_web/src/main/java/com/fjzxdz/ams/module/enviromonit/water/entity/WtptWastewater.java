package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;


public class WtptWastewater implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * dwmc
	 */
	private String dwmc;

	/**
	 * psqxlx
	 */
	private String psqxlx;

	/**
	 * prwsclc
	 */
	private String prwsclc;

	/**
	 * longitude1
	 */
	private BigDecimal longitude1;

	/**
	 * longitude2
	 */
	private BigDecimal longitude2;

	/**
	 * longitude3
	 */
	private BigDecimal longitude3;

	/**
	 * latitude1
	 */
	private BigDecimal latitude1;

	/**
	 * latitude2
	 */
	private BigDecimal latitude2;

	/**
	 * latitude3
	 */
	private BigDecimal latitude3;

	/**
	 * fspfl
	 */
	private BigDecimal fspfl;

	/**
	 * hxxylpfl
	 */
	private BigDecimal hxxylpfl;

	/**
	 * adpfl
	 */
	private BigDecimal adpfl;

	/**
	 * zlpfl
	 */
	private BigDecimal zlpfl;

	public WtptWastewater() {
	}

	
	public String getUuid() {
		return uuid;
	}

	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getDwmc() {
		return dwmc;
	}

	public void setDwmc(String dwmc) {
		this.dwmc = dwmc;
	}

	public String getPsqxlx() {
		return psqxlx;
	}

	public void setPsqxlx(String psqxlx) {
		this.psqxlx = psqxlx;
	}

	public String getPrwsclc() {
		return prwsclc;
	}

	public void setPrwsclc(String prwsclc) {
		this.prwsclc = prwsclc;
	}

	public BigDecimal getLongitude1() {
		return longitude1;
	}

	public void setLongitude1(BigDecimal longitude1) {
		this.longitude1 = longitude1;
	}

	public BigDecimal getLongitude2() {
		return longitude2;
	}

	public void setLongitude2(BigDecimal longitude2) {
		this.longitude2 = longitude2;
	}

	public BigDecimal getLongitude3() {
		return longitude3;
	}

	public void setLongitude3(BigDecimal longitude3) {
		this.longitude3 = longitude3;
	}

	public BigDecimal getLatitude1() {
		return latitude1;
	}

	public void setLatitude1(BigDecimal latitude1) {
		this.latitude1 = latitude1;
	}

	public BigDecimal getLatitude2() {
		return latitude2;
	}

	public void setLatitude2(BigDecimal latitude2) {
		this.latitude2 = latitude2;
	}

	public BigDecimal getLatitude3() {
		return latitude3;
	}

	public void setLatitude3(BigDecimal latitude3) {
		this.latitude3 = latitude3;
	}

	public BigDecimal getFspfl() {
		return fspfl;
	}

	public void setFspfl(BigDecimal fspfl) {
		this.fspfl = fspfl;
	}

	public BigDecimal getHxxylpfl() {
		return hxxylpfl;
	}

	public void setHxxylpfl(BigDecimal hxxylpfl) {
		this.hxxylpfl = hxxylpfl;
	}

	public BigDecimal getAdpfl() {
		return adpfl;
	}

	public void setAdpfl(BigDecimal adpfl) {
		this.adpfl = adpfl;
	}

	public BigDecimal getZlpfl() {
		return zlpfl;
	}

	public void setZlpfl(BigDecimal zlpfl) {
		this.zlpfl = zlpfl;
	}
}