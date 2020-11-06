/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.rubbish.param;

import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.entity.ZpTransferStation;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

import javax.persistence.Id;

/**
 * 垃圾处理厂Entity
 * @author queherong
 * @version 2019-10-14
 */
public class ZpTransferStationParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** ID */
	@Id
	private String id;
	/** 污染源编码 */
	private String wrybm;
	/** 标准污染源名称 */
	private String wrymc;
	/** 简称 */
	private String jc;
	/** 规模编码 */
	private String gmbm;
	/** 企业名称 */
	private String qymc;
	/** 曾用名 */
	private String cym;
	/** 企业类型 */
	private String qylx;
	/** 登记注册类型 */
	private String zclx;
	/** 所属行业 */
	private String sshy;
	/** 行业代码 */
	private String hydm;
	/** 企业地址 */
	private String qydz;
	/** 法人代码 */
	private String frdm;
	/** 法人代表姓名 */
	private String dbmc;
	/** 电话 */
	private String dh;
	/** 污染源环保部门 */
	private String hbbm;
	/** 单位类别编码 */
	private String lbbm;
	/** 所属流域 */
	private String ssly;
	/** 所属流域编码 */
	private String lybm;
	/** 关注程度 */
	private String gzcd;
	/** 开业时间（投产日期） */
	private String kysj;
	/** 经度 */
	private String jd;
	/** 纬度 */
	private String wd;
	/** 网址 */
	private String wz;
	/** 污染源监管类型 */
	private String jglx;
	/** 所在工业园区名称 */
	private String gyyqmc;
	/** 邮编 */
	private String yb;
	/** 环保联系人 */
	private String hblxr;
	/** 环保联系人电话 */
	private String hblxrdh;
	/** 环保联系人手机 */
	private String hblxrsj;
	/** 环保联系人传真 */
	private String hblxrcz;
	/** 银行名称 */
	private String yhmc;
	/** 银行账户 */
	private String yhzh;
	/** 邮箱地址 */
	private String yxdz;
	/** 传真 */
	private String cz;
	/** 专职环保人员数 */
	private String zzhbrys;
	/** 通讯地址 */
	private String txdz;
	/** 污染源责任人 */
	private String wryzrr;
	/** 联系人 */
	private String lxr;
	/** 隶属关系 */
	private String lsgx;
	/** 单位资质 */
	private String dwzz;
	/** 总投资币种类型 */
	private String bzlx;
	/** 总投资（万元） */
	private String ztz;
	/** 环保总投资币种 */
	private String hbztzbz;
	/** 环保投资（万元） */
	private String hbtz;
	/** 行政区名称 */
	private String xzqmc;
	/** 行政区代码 */
	private String xzqdm;
	/** 企业编码 */
	private String epCode;
	/** 监控通道ID */
	private String channelIds;
	/** 序号 */
	private Long seqno;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public ZpTransferStationParam() {
		super(ZpTransferStation.class);
		this.clazz = ZpTransferStation.class;
	}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWrybm() {
        return wrybm;
    }

    public void setWrybm(String wrybm) {
        this.wrybm = wrybm;
    }

    public String getWrymc() {
        return wrymc;
    }

    public void setWrymc(String wrymc) {
        this.wrymc = wrymc;
    }

    public String getJc() {
        return jc;
    }

    public void setJc(String jc) {
        this.jc = jc;
    }

    public String getGmbm() {
        return gmbm;
    }

    public void setGmbm(String gmbm) {
        this.gmbm = gmbm;
    }

    public String getQymc() {
        return qymc;
    }

    public void setQymc(String qymc) {
        this.qymc = qymc;
    }

    public String getCym() {
        return cym;
    }

    public void setCym(String cym) {
        this.cym = cym;
    }

    public String getQylx() {
        return qylx;
    }

    public void setQylx(String qylx) {
        this.qylx = qylx;
    }

    public String getZclx() {
        return zclx;
    }

    public void setZclx(String zclx) {
        this.zclx = zclx;
    }

    public String getSshy() {
        return sshy;
    }

    public void setSshy(String sshy) {
        this.sshy = sshy;
    }

    public String getHydm() {
        return hydm;
    }

    public void setHydm(String hydm) {
        this.hydm = hydm;
    }

    public String getQydz() {
        return qydz;
    }

    public void setQydz(String qydz) {
        this.qydz = qydz;
    }

    public String getFrdm() {
        return frdm;
    }

    public void setFrdm(String frdm) {
        this.frdm = frdm;
    }

    public String getDbmc() {
        return dbmc;
    }

    public void setDbmc(String dbmc) {
        this.dbmc = dbmc;
    }

    public String getDh() {
        return dh;
    }

    public void setDh(String dh) {
        this.dh = dh;
    }

    public String getHbbm() {
        return hbbm;
    }

    public void setHbbm(String hbbm) {
        this.hbbm = hbbm;
    }

    public String getLbbm() {
        return lbbm;
    }

    public void setLbbm(String lbbm) {
        this.lbbm = lbbm;
    }

    public String getSsly() {
        return ssly;
    }

    public void setSsly(String ssly) {
        this.ssly = ssly;
    }

    public String getLybm() {
        return lybm;
    }

    public void setLybm(String lybm) {
        this.lybm = lybm;
    }

    public String getGzcd() {
        return gzcd;
    }

    public void setGzcd(String gzcd) {
        this.gzcd = gzcd;
    }

    public String getKysj() {
        return kysj;
    }

    public void setKysj(String kysj) {
        this.kysj = kysj;
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

    public String getWz() {
        return wz;
    }

    public void setWz(String wz) {
        this.wz = wz;
    }

    public String getJglx() {
        return jglx;
    }

    public void setJglx(String jglx) {
        this.jglx = jglx;
    }

    public String getGyyqmc() {
        return gyyqmc;
    }

    public void setGyyqmc(String gyyqmc) {
        this.gyyqmc = gyyqmc;
    }

    public String getYb() {
        return yb;
    }

    public void setYb(String yb) {
        this.yb = yb;
    }

    public String getHblxr() {
        return hblxr;
    }

    public void setHblxr(String hblxr) {
        this.hblxr = hblxr;
    }

    public String getHblxrdh() {
        return hblxrdh;
    }

    public void setHblxrdh(String hblxrdh) {
        this.hblxrdh = hblxrdh;
    }

    public String getHblxrsj() {
        return hblxrsj;
    }

    public void setHblxrsj(String hblxrsj) {
        this.hblxrsj = hblxrsj;
    }

    public String getHblxrcz() {
        return hblxrcz;
    }

    public void setHblxrcz(String hblxrcz) {
        this.hblxrcz = hblxrcz;
    }

    public String getYhmc() {
        return yhmc;
    }

    public void setYhmc(String yhmc) {
        this.yhmc = yhmc;
    }

    public String getYhzh() {
        return yhzh;
    }

    public void setYhzh(String yhzh) {
        this.yhzh = yhzh;
    }

    public String getYxdz() {
        return yxdz;
    }

    public void setYxdz(String yxdz) {
        this.yxdz = yxdz;
    }

    public String getCz() {
        return cz;
    }

    public void setCz(String cz) {
        this.cz = cz;
    }

    public String getZzhbrys() {
        return zzhbrys;
    }

    public void setZzhbrys(String zzhbrys) {
        this.zzhbrys = zzhbrys;
    }

    public String getTxdz() {
        return txdz;
    }

    public void setTxdz(String txdz) {
        this.txdz = txdz;
    }

    public String getWryzrr() {
        return wryzrr;
    }

    public void setWryzrr(String wryzrr) {
        this.wryzrr = wryzrr;
    }

    public String getLxr() {
        return lxr;
    }

    public void setLxr(String lxr) {
        this.lxr = lxr;
    }

    public String getLsgx() {
        return lsgx;
    }

    public void setLsgx(String lsgx) {
        this.lsgx = lsgx;
    }

    public String getDwzz() {
        return dwzz;
    }

    public void setDwzz(String dwzz) {
        this.dwzz = dwzz;
    }

    public String getBzlx() {
        return bzlx;
    }

    public void setBzlx(String bzlx) {
        this.bzlx = bzlx;
    }

    public String getZtz() {
        return ztz;
    }

    public void setZtz(String ztz) {
        this.ztz = ztz;
    }

    public String getHbztzbz() {
        return hbztzbz;
    }

    public void setHbztzbz(String hbztzbz) {
        this.hbztzbz = hbztzbz;
    }

    public String getHbtz() {
        return hbtz;
    }

    public void setHbtz(String hbtz) {
        this.hbtz = hbtz;
    }

    public String getXzqmc() {
        return xzqmc;
    }

    public void setXzqmc(String xzqmc) {
        this.xzqmc = xzqmc;
    }

    public String getXzqdm() {
        return xzqdm;
    }

    public void setXzqdm(String xzqdm) {
        this.xzqdm = xzqdm;
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

    public Class getClazz() {
        return clazz;
    }

    public void setClazz(Class clazz) {
        this.clazz = clazz;
    }

    /**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("id", getId(), SearchCondition.LIKE);
		addClause("wrybm", getWrybm(), SearchCondition.LIKE);
		addClause("wrymc", getWrymc(), SearchCondition.LIKE);
		addClause("jc", getJc(), SearchCondition.LIKE);
		addClause("gmbm", getGmbm(), SearchCondition.LIKE);
		addClause("qymc", getQymc(), SearchCondition.LIKE);
		addClause("cym", getCym(), SearchCondition.LIKE);
		addClause("qylx", getQylx(), SearchCondition.LIKE);
		addClause("zclx", getZclx(), SearchCondition.LIKE);
		addClause("sshy", getSshy(), SearchCondition.LIKE);
		addClause("hydm", getHydm(), SearchCondition.LIKE);
		addClause("qydz", getQydz(), SearchCondition.LIKE);
		addClause("frdm", getFrdm(), SearchCondition.LIKE);
		addClause("dbmc", getDbmc(), SearchCondition.LIKE);
		addClause("dh", getDh(), SearchCondition.LIKE);
		addClause("hbbm", getHbbm(), SearchCondition.LIKE);
		addClause("lbbm", getLbbm(), SearchCondition.LIKE);
		addClause("ssly", getSsly(), SearchCondition.LIKE);
		addClause("lybm", getLybm(), SearchCondition.LIKE);
		addClause("gzcd", getGzcd(), SearchCondition.LIKE);
		addClause("kysj", getKysj(), SearchCondition.LIKE);
		addClause("jd", getJd(), SearchCondition.LIKE);
		addClause("wd", getWd(), SearchCondition.LIKE);
		addClause("wz", getWz(), SearchCondition.LIKE);
		addClause("jglx", getJglx(), SearchCondition.LIKE);
		addClause("gyyqmc", getGyyqmc(), SearchCondition.LIKE);
		addClause("yb", getYb(), SearchCondition.LIKE);
		addClause("hblxr", getHblxr(), SearchCondition.LIKE);
		addClause("hblxrdh", getHblxrdh(), SearchCondition.LIKE);
		addClause("hblxrsj", getHblxrsj(), SearchCondition.LIKE);
		addClause("hblxrcz", getHblxrcz(), SearchCondition.LIKE);
		addClause("yhmc", getYhmc(), SearchCondition.LIKE);
		addClause("yhzh", getYhzh(), SearchCondition.LIKE);
		addClause("yxdz", getYxdz(), SearchCondition.LIKE);
		addClause("cz", getCz(), SearchCondition.LIKE);
		addClause("zzhbrys", getZzhbrys(), SearchCondition.LIKE);
		addClause("txdz", getTxdz(), SearchCondition.LIKE);
		addClause("wryzrr", getWryzrr(), SearchCondition.LIKE);
		addClause("lxr", getLxr(), SearchCondition.LIKE);
		addClause("lsgx", getLsgx(), SearchCondition.LIKE);
		addClause("dwzz", getDwzz(), SearchCondition.LIKE);
		addClause("bzlx", getBzlx(), SearchCondition.LIKE);
		addClause("ztz", getZtz(), SearchCondition.LIKE);
		addClause("hbztzbz", getHbztzbz(), SearchCondition.LIKE);
		addClause("hbtz", getHbtz(), SearchCondition.LIKE);
		addClause("xzqmc", getXzqmc(), SearchCondition.LIKE);
		addClause("xzqdm", getXzqdm(), SearchCondition.LIKE);
		addClause("epCode", getEpCode(), SearchCondition.LIKE);
		addClause("channelIds", getChannelIds(), SearchCondition.LIKE);
		addClause("seqno", getSeqno(), SearchCondition.LIKE);
	}

	
}


