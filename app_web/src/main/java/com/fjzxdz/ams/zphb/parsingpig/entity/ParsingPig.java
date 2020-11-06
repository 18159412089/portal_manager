/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.parsingpig.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;
import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;

/**
 * 养殖业管理Entity
 * @author shenlongqin
 * @version 2019-10-14
 */
@Entity
@Table(name = "ZP_POLLUTION_RAISING_PIG")
public class ParsingPig implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 农场 */
	private String nc;
	/** 养殖场名称 */
	private String yzc;
	/** 法人代表 */
	private String frdb;
	/** 详细地址 */
	private String xxdz;
	/** 联系电话 */
	private String lxdh;
	/** 环评规模(头) */
	private String hpgm;
	/** 是否办理环评网上备案 */
	private String wsba;
	/** 粪污主要设施 */
	private String zyss;
	/** 畜禽标识代码 */
	private String bsdm;
	/** 畜禽养殖代码 */
	private String yzdm;
	/** 身份证号码 */
	private String sfz;
	/** 统一社会信用代码 */
	private String xydm;
	/** 动物防疫条件合格证号 */
	private String hgzh;
	/** 种畜禽生产经营许可证号 */
	private String xkzh;
	/** 经度 */
	private String jd;
	/** 纬度 */
	private String wd;
	/** ID */
	@Id
	private String id;
	/** 企业编码 */
	private String epCode;
	/** 监控通道ID */
	private String channelIds;
	/** 序号 */
	private Long seqno;
	
	public String getNc() {
		return nc;
	}

	public void setNc(String nc) {
		this.nc = nc;
	}
	public String getYzc() {
		return yzc;
	}

	public void setYzc(String yzc) {
		this.yzc = yzc;
	}
	public String getFrdb() {
		return frdb;
	}

	public void setFrdb(String frdb) {
		this.frdb = frdb;
	}
	public String getXxdz() {
		return xxdz;
	}

	public void setXxdz(String xxdz) {
		this.xxdz = xxdz;
	}
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	public String getHpgm() {
		return hpgm;
	}

	public void setHpgm(String hpgm) {
		this.hpgm = hpgm;
	}
	public String getWsba() {
		return wsba;
	}

	public void setWsba(String wsba) {
		this.wsba = wsba;
	}
	public String getZyss() {
		return zyss;
	}

	public void setZyss(String zyss) {
		this.zyss = zyss;
	}
	public String getBsdm() {
		return bsdm;
	}

	public void setBsdm(String bsdm) {
		this.bsdm = bsdm;
	}
	public String getYzdm() {
		return yzdm;
	}

	public void setYzdm(String yzdm) {
		this.yzdm = yzdm;
	}
	public String getSfz() {
		return sfz;
	}

	public void setSfz(String sfz) {
		this.sfz = sfz;
	}
	public String getXydm() {
		return xydm;
	}

	public void setXydm(String xydm) {
		this.xydm = xydm;
	}
	public String getHgzh() {
		return hgzh;
	}

	public void setHgzh(String hgzh) {
		this.hgzh = hgzh;
	}
	public String getXkzh() {
		return xkzh;
	}

	public void setXkzh(String xkzh) {
		this.xkzh = xkzh;
	}
	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}
	public String getWd() {
		return wd;
	}

	public void setWd(String wd) {
		this.wd = wd;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getEpCode() {
		return epCode;
	}

	public void setEpCode(String epCode) {
		this.epCode = epCode;
	}
	public String getChannelIds() {
		return channelIds;
	}

	public void setChannelIds(String channelIds) {
		this.channelIds = channelIds;
	}
	public Long getSeqno() {
		return seqno;
	}

	public void setSeqno(Long seqno) {
		this.seqno = seqno;
	}
	
}


