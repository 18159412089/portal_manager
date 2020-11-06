package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.Transient;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 废水企业实体
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:00:20
 */
public class PollutionWaterData implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 联系人
     */
    private String lxr;

    /**
     * 企业名称
     */
    private String qymc;

    /**
     * 区县
     */
    private String qx;

    /**
     * 污染物名称
     */
    private String wrwname;


    /**
     * 年
     */
    private String year;

    /**
     * 排放量
     */
    private String pfl;


    /**
     * 地市
     */
    private String ds;

    /**
     * 联系电话
     */
    private String lxdh;

    /**
     * 企业地址
     */
    private String address;

    /**
     * 经度
     */
    private BigDecimal longitude;

    /**
     * 纬度
     */
    private BigDecimal latitude;

    /**
     * picture
     */
    @Transient
    private String picture;

    /**
     * video
     */
    @Transient
    private String video;

    public PollutionWaterData() {
    }


	public String getPfl() {
		return pfl;
	}

	public void setPfl(String pfl) {
		this.pfl = pfl;
	}

	public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getQymc() {
        return qymc;
    }

    public String getWrwname() {
        return wrwname;
    }

    public void setWrwname(String wrwname) {
        this.wrwname = wrwname;
    }

    public void setQymc(String qymc) {
        this.qymc = qymc;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getLxr() {
        return lxr;
    }

    public void setLxr(String lxr) {
        this.lxr = lxr;
    }

    public String getQx() {
        return qx;
    }

    public void setQx(String qx) {
        this.qx = qx;
    }

    public String getDs() {
        return ds;
    }

    public void setDs(String ds) {
        this.ds = ds;
    }

    public String getLxdh() {
        return lxdh;
    }

    public void setLxdh(String lxdh) {
        this.lxdh = lxdh;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }
}