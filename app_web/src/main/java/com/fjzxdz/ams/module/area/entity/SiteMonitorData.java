/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 近岸海域监测数据Entity
 * @author htj
 * @version 2019-02-20
 */
@Entity
@Table(name = "AREA_SITE_MONITOR_DATA")
public class SiteMonitorData implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private SiteMonitorDataPk siteMonitorDataPk ;
	
	/** 甲基对硫磷 */
	private Double bbp;
	/** 溶解氧 */
	@Column(name = "DISSOLVED_O2")
	private Double dissolvedO2;
	/** 滴滴涕 */
	private Double mlll;
	/** 阴离子表面活性剂 */
	private Double hxg;
	/** 功能类别 */
	private String gnlb;
	/** 透明度 */
	private Double yjlp;
	/** 叶绿素 */
	private Double qw;
	/** 国控站位编码 */
	private String gkCode;
	/** 砷 */
	private Double zn;
	/** 铁 */
	private Double me;
	/** 锰 */
	private Double yjl;
	/** 风速 */
	private Double flza;
	/** 化学需氧量 */
	private Double cod;
	/** 站位名称 */
	private String stationName;
	/** 六价铬 */
	private Double zl;
	/** 监测时间 */
	 
	/** 非离子氨 */
	private Double yjd;
	/** 氨氮 */
	private Double syl;
	/** 粪大肠菌群 */
	private Double wrshxyl;
	/** 气温 */
	private Double qy;
	/** 水质目标 */
	private String szmb;
	/** 有机碳 */
	private Double fe;
	/** 六六六 */
	private Double ddd;
	/** 悬浮物 */
	private Double xfw;
	/** 盐度 */
	private Double yd;
	/** 活性硅酸盐 */
	private Double yjt;
	/** 马拉硫磷, */
	private Double jjdll;
	/** 硝酸盐氮 */
	private Double ad;
	/** 硒 */
	private Double ni;
	/** 有机磷 */
	private Double chlorophyll;
	/** 采样水深 */
	private Double tmd;
	/** 无机氮 */
	private String lbdm;
	/** 亚硝酸盐氮 */
	private Double yxsyd;
	/** 五日生化需氧量 */
	private Double ljg;
	/** 硫化物 */
	private Double hff;
	/** 点位级别 */
	private String dwjb;
	/** 气压 */
	private Double fx;
	/** 风向 */
	private Double fs;
	/** 有机氯 */
	private Double ss;
	/** 监测类型 */
	private String jclx;
	/** 大肠菌群 */
	private Double fdcjq;
	/** 镍 */
	private Double qhw;
	/** 水温 */
	private Double sw;
	/** 锌 */
	private Double dcjq;
 
	/** 石油类 */
	private String hg;
	/** 氰化物 */
	private Double lhw;
	/** 潮汛 */
	private String cx;
	/** 总铬 */
	private Double se;
	/** 汞 */
	private Double cu;
	/** 苯并芘 */
	private Double ylz;
	/** 潮时 */
	private String cs;
	/** 镉 */
	private Double si;
	/** 超标项目 */
	private String cbxm;
	/** 天气描述 */
	private String tqms;
	/** 亚硝酸盐氮 */
	private Double no3n;
	/** 活性磷酸盐 */
	private Double hyl;
	/** 类别 */
	private String lb;
	/** PH */
	private Double ph;
	/** 类别代码 */
	private String sjmc;
	/** 铅 */
	private String cd;
	/** 水深 */
	private Double cyss;
	/** 水期代码 */
	private String sqdm;
	/** 铜 */
	private Double pb;
	/** 挥发酚 */
	private Double lll;
	/**  */
	private String asDwjb;
	
	public Double getBbp() {
		return bbp;
	}

	public void setBbp(Double bbp) {
		this.bbp = bbp;
	}
	public Double getDissolvedO2() {
		return dissolvedO2;
	}

	public void setDissolvedO2(Double dissolvedO2) {
		this.dissolvedO2 = dissolvedO2;
	}
	public Double getMlll() {
		return mlll;
	}

	public void setMlll(Double mlll) {
		this.mlll = mlll;
	}
	public Double getHxg() {
		return hxg;
	}

	public void setHxg(Double hxg) {
		this.hxg = hxg;
	}
	public String getGnlb() {
		return gnlb;
	}

	public void setGnlb(String gnlb) {
		this.gnlb = gnlb;
	}
	public Double getYjlp() {
		return yjlp;
	}

	public void setYjlp(Double yjlp) {
		this.yjlp = yjlp;
	}
	public Double getQw() {
		return qw;
	}

	public void setQw(Double qw) {
		this.qw = qw;
	}
	public String getGkCode() {
		return gkCode;
	}

	public void setGkCode(String gkCode) {
		this.gkCode = gkCode;
	}
	public Double getZn() {
		return zn;
	}

	public void setZn(Double zn) {
		this.zn = zn;
	}
	public Double getMe() {
		return me;
	}

	public void setMe(Double me) {
		this.me = me;
	}
	public Double getYjl() {
		return yjl;
	}

	public void setYjl(Double yjl) {
		this.yjl = yjl;
	}
	public Double getFlza() {
		return flza;
	}

	public void setFlza(Double flza) {
		this.flza = flza;
	}
	public Double getCod() {
		return cod;
	}

	public void setCod(Double cod) {
		this.cod = cod;
	}
	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public Double getZl() {
		return zl;
	}

	public void setZl(Double zl) {
		this.zl = zl;
	}
	 
	public Double getYjd() {
		return yjd;
	}

	public void setYjd(Double yjd) {
		this.yjd = yjd;
	}
	public Double getSyl() {
		return syl;
	}

	public void setSyl(Double syl) {
		this.syl = syl;
	}
	public Double getWrshxyl() {
		return wrshxyl;
	}

	public void setWrshxyl(Double wrshxyl) {
		this.wrshxyl = wrshxyl;
	}
	public Double getQy() {
		return qy;
	}

	public void setQy(Double qy) {
		this.qy = qy;
	}
	public String getSzmb() {
		return szmb;
	}

	public void setSzmb(String szmb) {
		this.szmb = szmb;
	}
	public Double getFe() {
		return fe;
	}

	public void setFe(Double fe) {
		this.fe = fe;
	}
	public Double getDdd() {
		return ddd;
	}

	public void setDdd(Double ddd) {
		this.ddd = ddd;
	}
	public Double getXfw() {
		return xfw;
	}

	public void setXfw(Double xfw) {
		this.xfw = xfw;
	}
	public Double getYd() {
		return yd;
	}

	public void setYd(Double yd) {
		this.yd = yd;
	}
	public Double getYjt() {
		return yjt;
	}

	public void setYjt(Double yjt) {
		this.yjt = yjt;
	}
	public Double getJjdll() {
		return jjdll;
	}

	public void setJjdll(Double jjdll) {
		this.jjdll = jjdll;
	}
	public Double getAd() {
		return ad;
	}

	public void setAd(Double ad) {
		this.ad = ad;
	}
	public Double getNi() {
		return ni;
	}

	public void setNi(Double ni) {
		this.ni = ni;
	}
	public Double getChlorophyll() {
		return chlorophyll;
	}

	public void setChlorophyll(Double chlorophyll) {
		this.chlorophyll = chlorophyll;
	}
	public Double getTmd() {
		return tmd;
	}

	public void setTmd(Double tmd) {
		this.tmd = tmd;
	}
	public String getLbdm() {
		return lbdm;
	}

	public void setLbdm(String lbdm) {
		this.lbdm = lbdm;
	}
	public Double getYxsyd() {
		return yxsyd;
	}

	public void setYxsyd(Double yxsyd) {
		this.yxsyd = yxsyd;
	}
	public Double getLjg() {
		return ljg;
	}

	public void setLjg(Double ljg) {
		this.ljg = ljg;
	}
	public Double getHff() {
		return hff;
	}

	public void setHff(Double hff) {
		this.hff = hff;
	}
	public String getDwjb() {
		return dwjb;
	}

	public void setDwjb(String dwjb) {
		this.dwjb = dwjb;
	}
	public Double getFx() {
		return fx;
	}

	public void setFx(Double fx) {
		this.fx = fx;
	}
	public Double getFs() {
		return fs;
	}

	public void setFs(Double fs) {
		this.fs = fs;
	}
	public Double getSs() {
		return ss;
	}

	public void setSs(Double ss) {
		this.ss = ss;
	}
	public String getJclx() {
		return jclx;
	}

	public void setJclx(String jclx) {
		this.jclx = jclx;
	}
	public Double getFdcjq() {
		return fdcjq;
	}

	public void setFdcjq(Double fdcjq) {
		this.fdcjq = fdcjq;
	}
	public Double getQhw() {
		return qhw;
	}

	public void setQhw(Double qhw) {
		this.qhw = qhw;
	}
	public Double getSw() {
		return sw;
	}

	public void setSw(Double sw) {
		this.sw = sw;
	}
	public Double getDcjq() {
		return dcjq;
	}

	public void setDcjq(Double dcjq) {
		this.dcjq = dcjq;
	}
	 
	public String getHg() {
		return hg;
	}

	public void setHg(String hg) {
		this.hg = hg;
	}
	public Double getLhw() {
		return lhw;
	}

	public void setLhw(Double lhw) {
		this.lhw = lhw;
	}
	public String getCx() {
		return cx;
	}

	public void setCx(String cx) {
		this.cx = cx;
	}
	public Double getSe() {
		return se;
	}

	public void setSe(Double se) {
		this.se = se;
	}
	public Double getCu() {
		return cu;
	}

	public void setCu(Double cu) {
		this.cu = cu;
	}
	public Double getYlz() {
		return ylz;
	}

	public void setYlz(Double ylz) {
		this.ylz = ylz;
	}
	public String getCs() {
		return cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}
	public Double getSi() {
		return si;
	}

	public void setSi(Double si) {
		this.si = si;
	}
	public String getCbxm() {
		return cbxm;
	}

	public void setCbxm(String cbxm) {
		this.cbxm = cbxm;
	}
	public String getTqms() {
		return tqms;
	}

	public void setTqms(String tqms) {
		this.tqms = tqms;
	}
	public Double getNo3n() {
		return no3n;
	}

	public void setNo3n(Double no3n) {
		this.no3n = no3n;
	}
	public Double getHyl() {
		return hyl;
	}

	public void setHyl(Double hyl) {
		this.hyl = hyl;
	}
	public String getLb() {
		return lb;
	}

	public void setLb(String lb) {
		this.lb = lb;
	}
	public Double getPh() {
		return ph;
	}

	public void setPh(Double ph) {
		this.ph = ph;
	}
	public String getSjmc() {
		return sjmc;
	}

	public void setSjmc(String sjmc) {
		this.sjmc = sjmc;
	}
	public String getCd() {
		return cd;
	}

	public void setCd(String cd) {
		this.cd = cd;
	}
	public Double getCyss() {
		return cyss;
	}

	public void setCyss(Double cyss) {
		this.cyss = cyss;
	}
	public String getSqdm() {
		return sqdm;
	}

	public void setSqdm(String sqdm) {
		this.sqdm = sqdm;
	}
	public Double getPb() {
		return pb;
	}

	public void setPb(Double pb) {
		this.pb = pb;
	}
	public Double getLll() {
		return lll;
	}

	public void setLll(Double lll) {
		this.lll = lll;
	}
	public String getAsDwjb() {
		return asDwjb;
	}

	public void setAsDwjb(String asDwjb) {
		this.asDwjb = asDwjb;
	}

	public SiteMonitorDataPk getSiteMonitorDataPk() {
		return siteMonitorDataPk;
	}

	public void setSiteMonitorDataPk(SiteMonitorDataPk siteMonitorDataPk) {
		this.siteMonitorDataPk = siteMonitorDataPk;
	}
	
}


