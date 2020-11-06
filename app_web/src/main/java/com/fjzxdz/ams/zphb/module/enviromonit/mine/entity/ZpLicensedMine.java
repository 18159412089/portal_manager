/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.mine.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 矿山管理Entity
 * @author queherong
 * @version 2019-10-14
 */
@Entity
@Table(name = "ZP_POLLUTION_LICENSED_MINE")
public class ZpLicensedMine  implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/** 序号（ID） */
	@Id
	private String id;
	/** 污染源类型 */
	private String wrylx;
	/** 污染源种类 */
	private String wryzl;
	/** 名称 */
	private String mc;
	/** 存在问题 */
	private String czwt;
	/** 整改措施 */
	private String zgcs;
	/** 治理项目 */
	private String zlxm;
	/** 乡镇 */
	private String xz;
	/** 地址 */
	private String dz;
	/** 备注 */
	private String bz;
	/** 经度 */
	private String jd;
	/** 纬度 */
	private String wd;
	/** 企业编码 */
	private String epCode;
	/** 监控通道ID */
	private String channelIds;
	/** 序号 */
	private Long seqno;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getWrylx() {
		return wrylx;
	}

	public void setWrylx(String wrylx) {
		this.wrylx = wrylx;
	}
	public String getWryzl() {
		return wryzl;
	}

	public void setWryzl(String wryzl) {
		this.wryzl = wryzl;
	}
	public String getMc() {
		return mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}
	public String getCzwt() {
		return czwt;
	}

	public void setCzwt(String czwt) {
		this.czwt = czwt;
	}
	public String getZgcs() {
		return zgcs;
	}

	public void setZgcs(String zgcs) {
		this.zgcs = zgcs;
	}
	public String getZlxm() {
		return zlxm;
	}

	public void setZlxm(String zlxm) {
		this.zlxm = zlxm;
	}
	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}
	public String getDz() {
		return dz;
	}

	public void setDz(String dz) {
		this.dz = dz;
	}
	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
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


