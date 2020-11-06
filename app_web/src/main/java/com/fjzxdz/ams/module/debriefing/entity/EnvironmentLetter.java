package com.fjzxdz.ams.module.debriefing.entity;

import cn.fjzxdz.frame.entity.TrackingEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 信访件实体【环保督查】
 */
@Entity
@Table(name = "ENVIRONMENT_LETTER")
public class EnvironmentLetter extends TrackingEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private String uuid;

    /**
     * 原始排序编码
     */
    private String yspxbm;

    /**
     * 受理编号
     */
    private String slbh;

    /**
     * 交办问题基本情况
     */
    private String jbwtjbqk;

    /**
     * 行政区域
     */
    private String xzqy;

    /**
     * 污染类型
     */
    private String wrlx;

    /**
     * 督察期间调查核实情况
     */
    private String dcqjdchsqk;

    /**
     * 是否属实
     */
    private String sfss;

    /**
     * 整改目标及整改措施
     */
    private String zgmbjzgcs;

    /**
     * 督察期间处理情况
     */
    private String dcqjclqk;

    /**
     * 最新整改情况
     */
    private String zxzgqk;

    /**
     * 办结状态
     */
    private String bjzt;

    /**
     * 责令整改（家次）
     */
    private String zlzg;

    /**
     * 罚款金额（万元）
     */
    private String fkje;

    /**
     * 是否重点件
     */
    private String sfzdj;

    /**
     * 挂钩省市县领导情况
     */
    private String ggssxldqk;

    /**
     * 牵头责任单位
     */
    private String qtzrdw;

    /**
     * 联络人
     */
    private String llr;

    /**
     * 联系电话
     */
    private String lxdh;

    /**
     * 所属网格
     */
    private String sswl;

    /**
     * 网格员
     */
    private String wgy;

    /**
     * 网格员手机号码
     */
    private String wgysjhm;

    /**
     * 轮次
     */
    private String lc;

    /**
     * 是否重复
     */
    private String sfcf;

    /**
     * 重复关联件编号
     */
    private String sfgljbh;

    /**
     * 验收情况
     */
    private String ysqk;

    /**
     * 合并编号
     */
    private String hbbh;

    /**
     * 立案处罚（家次）
     */
    private String lacf;
    /**
     * 立案侦查（件次）
     */
    private String lazc;

    /**
     * "	刑事拘留（人次）"
     */
    private String xsjl;

    /**
     * 行政拘留（人次）
     */
    private String xzjl;

    /**
     * 约谈（人次）
     */
    private String yt;

    /**
     * 问责（人次）
     */
    private String wz;

    /**
     * 问责情况
     */
    private String wzqk;

    /**
     * 经度
     */
    private String jd;

    /**
     * 纬度
     */
    private String wd;


    public EnvironmentLetter() {
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

    public String getHbbh() {
        return hbbh;
    }

    public void setHbbh(String hbbh) {
        this.hbbh = hbbh;
    }

	public String getLacf() {
		return lacf;
	}

	public void setLacf(String lacf) {
		this.lacf = lacf;
	}

	public String getLazc() {
		return lazc;
	}

	public void setLazc(String lazc) {
		this.lazc = lazc;
	}

	public String getXsjl() {
		return xsjl;
	}

	public void setXsjl(String xsjl) {
		this.xsjl = xsjl;
	}

	public String getXzjl() {
		return xzjl;
	}

	public void setXzjl(String xzjl) {
		this.xzjl = xzjl;
	}

	public String getYt() {
		return yt;
	}

	public void setYt(String yt) {
		this.yt = yt;
	}

	public String getWz() {
		return wz;
	}

	public void setWz(String wz) {
		this.wz = wz;
	}

	public String getWzqk() {
		return wzqk;
	}

	public void setWzqk(String wzqk) {
		this.wzqk = wzqk;
	}

	public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getYspxbm() {
        return yspxbm;
    }

    public void setYspxbm(String yspxbm) {
        this.yspxbm = yspxbm;
    }

    public String getSlbh() {
        return slbh;
    }

    public void setSlbh(String slbh) {
        this.slbh = slbh;
    }

    public String getJbwtjbqk() {
        return jbwtjbqk;
    }

    public void setJbwtjbqk(String jbwtjbqk) {
        this.jbwtjbqk = jbwtjbqk;
    }

    public String getXzqy() {
        return xzqy;
    }

    public void setXzqy(String xzqy) {
        this.xzqy = xzqy;
    }

    public String getWrlx() {
        return wrlx;
    }

    public void setWrlx(String wrlx) {
        this.wrlx = wrlx;
    }

    public String getDcqjdchsqk() {
        return dcqjdchsqk;
    }

    public void setDcqjdchsqk(String dcqjdchsqk) {
        this.dcqjdchsqk = dcqjdchsqk;
    }

    public String getSfss() {
        return sfss;
    }

    public void setSfss(String sfss) {
        this.sfss = sfss;
    }

    public String getZgmbjzgcs() {
        return zgmbjzgcs;
    }

    public void setZgmbjzgcs(String zgmbjzgcs) {
        this.zgmbjzgcs = zgmbjzgcs;
    }

    public String getDcqjclqk() {
        return dcqjclqk;
    }

    public void setDcqjclqk(String dcqjclqk) {
        this.dcqjclqk = dcqjclqk;
    }

    public String getZxzgqk() {
        return zxzgqk;
    }

    public void setZxzgqk(String zxzgqk) {
        this.zxzgqk = zxzgqk;
    }

    public String getBjzt() {
        return bjzt;
    }

    public void setBjzt(String bjzt) {
        this.bjzt = bjzt;
    }

    public String getZlzg() {
        return zlzg;
    }

    public void setZlzg(String zlzg) {
        this.zlzg = zlzg;
    }

    public String getFkje() {
        return fkje;
    }

    public void setFkje(String fkje) {
        this.fkje = fkje;
    }

    public String getSfzdj() {
        return sfzdj;
    }

    public void setSfzdj(String sfzdj) {
        this.sfzdj = sfzdj;
    }

    public String getGgssxldqk() {
        return ggssxldqk;
    }

    public void setGgssxldqk(String ggssxldqk) {
        this.ggssxldqk = ggssxldqk;
    }

    public String getQtzrdw() {
        return qtzrdw;
    }

    public void setQtzrdw(String qtzrdw) {
        this.qtzrdw = qtzrdw;
    }

    public String getLlr() {
        return llr;
    }

    public void setLlr(String llr) {
        this.llr = llr;
    }

    public String getLxdh() {
        return lxdh;
    }

    public void setLxdh(String lxdh) {
        this.lxdh = lxdh;
    }

    public String getSswl() {
        return sswl;
    }

    public void setSswl(String sswl) {
        this.sswl = sswl;
    }

    public String getWgy() {
        return wgy;
    }

    public void setWgy(String wgy) {
        this.wgy = wgy;
    }

    public String getWgysjhm() {
        return wgysjhm;
    }

    public void setWgysjhm(String wgysjhm) {
        this.wgysjhm = wgysjhm;
    }

    public String getLc() {
        return lc;
    }

    public void setLc(String lc) {
        this.lc = lc;
    }

    public String getSfcf() {
        return sfcf;
    }

    public void setSfcf(String sfcf) {
        this.sfcf = sfcf;
    }

    public String getSfgljbh() {
        return sfgljbh;
    }

    public void setSfgljbh(String sfgljbh) {
        this.sfgljbh = sfgljbh;
    }

    public String getYsqk() {
        return ysqk;
    }

    public void setYsqk(String ysqk) {
        this.ysqk = ysqk;
    }

}