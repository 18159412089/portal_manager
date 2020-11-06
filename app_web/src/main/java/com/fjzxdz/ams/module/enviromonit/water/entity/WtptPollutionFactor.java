package com.fjzxdz.ams.module.enviromonit.water.entity;

import java.io.Serializable;
import java.math.BigDecimal;


public class WtptPollutionFactor implements Serializable {

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * 单位详细名称
	 */
	private String dwmc;

	/**
	 * 详细地址_县(区、市、旗)
	 */
	private String qx;

	/**
	 * 详细地址_乡(镇)
	 */
	private String xz;

	/**
	 * 详细地址_街(村)、门牌号
	 */
	private String jd;

	/**
	 * 中心经度(度)
	 */
	private BigDecimal longitude1;

	/**
	 * 中心经度(分)
	 */
	private BigDecimal longitude2;

	/**
	 * 中心经度(秒)
	 */
	private BigDecimal longitude3;

	/**
	 * 中心纬度(度)
	 */
	private BigDecimal latitude1;

	/**
	 * 中心纬度(分)
	 */
	private BigDecimal latitude2;

	/**
	 * 中心纬度(秒)
	 */
	private BigDecimal latitude3;

	/**
	 * 联系人
	 */
	private String lxr;

	/**
	 * 联系电话
	 */
	private String lxdh;

	/**
	 * 受纳水体-名称
	 */
	private String snstmc;

	/**
	 * 企业运行状态
	 */
	private String qyyxzt;

	/**
	 * 产生工业废水
	 */
	private String csgyfs;

	/**
	 * 有锅炉/燃气轮机
	 */
	private String glRqlj;

	/**
	 * 有工业炉窑
	 */
	private String gyhy;

	/**
	 * 污染物名称
	 */
	private String wrwmc;

	/**
	 * 污染物产污系数
	 */
	private String wrwcwxs;

	/**
	 * 污染物产污系数中参数取值
	 */
	private String wrwcwxsCsqz;

	/**
	 * 污染物产生量
	 */
	private String wrwcsl;

	/**
	 * 污染物产生量的计量单位
	 */
	private String wrwcslJldw;

	/**
	 * 污染物排放量
	 */
	private String wrwpfl;

	/**
	 * 污染物排放量计量单位
	 */
	private String wrwpflJldw;

	/**
	 * 排污许可证执行报告排放量
	 */
	private String pwxkzzxbgpfl;

	
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

	public String getQx() {
		return qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}

	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
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

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getSnstmc() {
		return snstmc;
	}

	public void setSnstmc(String snstmc) {
		this.snstmc = snstmc;
	}

	public String getQyyxzt() {
		return qyyxzt;
	}

	public void setQyyxzt(String qyyxzt) {
		this.qyyxzt = qyyxzt;
	}

	public String getCsgyfs() {
		return csgyfs;
	}

	public void setCsgyfs(String csgyfs) {
		this.csgyfs = csgyfs;
	}

	public String getGlRqlj() {
		return glRqlj;
	}

	public void setGlRqlj(String glRqlj) {
		this.glRqlj = glRqlj;
	}

	public String getGyhy() {
		return gyhy;
	}

	public void setGyhy(String gyhy) {
		this.gyhy = gyhy;
	}

	public String getWrwmc() {
		return wrwmc;
	}

	public void setWrwmc(String wrwmc) {
		this.wrwmc = wrwmc;
	}

	public String getWrwcwxs() {
		return wrwcwxs;
	}

	public void setWrwcwxs(String wrwcwxs) {
		this.wrwcwxs = wrwcwxs;
	}

	public String getWrwcwxsCsqz() {
		return wrwcwxsCsqz;
	}

	public void setWrwcwxsCsqz(String wrwcwxsCsqz) {
		this.wrwcwxsCsqz = wrwcwxsCsqz;
	}

	public String getWrwcsl() {
		return wrwcsl;
	}

	public void setWrwcsl(String wrwcsl) {
		this.wrwcsl = wrwcsl;
	}

	public String getWrwcslJldw() {
		return wrwcslJldw;
	}

	public void setWrwcslJldw(String wrwcslJldw) {
		this.wrwcslJldw = wrwcslJldw;
	}

	public String getWrwpfl() {
		return wrwpfl;
	}

	public void setWrwpfl(String wrwpfl) {
		this.wrwpfl = wrwpfl;
	}

	public String getWrwpflJldw() {
		return wrwpflJldw;
	}

	public void setWrwpflJldw(String wrwpflJldw) {
		this.wrwpflJldw = wrwpflJldw;
	}

	public String getPwxkzzxbgpfl() {
		return pwxkzzxbgpfl;
	}

	public void setPwxkzzxbgpfl(String pwxkzzxbgpfl) {
		this.pwxkzzxbgpfl = pwxkzzxbgpfl;
	}

	public WtptPollutionFactor() {
	}
}