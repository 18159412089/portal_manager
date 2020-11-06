package com.fjzxdz.ams.zphb.module.enviromonit.air.entity;

import org.apache.tomcat.jni.Poll;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @ClassName PollutionAirAndWaterData
 * @Description TODO
 * @Author Administrator
 * @Date 2019/10/21 0021 下午 3:40
 * @Version 1.0
 */
@Entity
@Table(name = "POLLUTION_AIR_DATA")
public class PollutionAirAndWaterData implements Serializable {

    private static final long serialVersionUID = -753299116150198160L;

    @Id
    @Column(name="QYMC")
    private String QYMC;

    @Column(name="WRWNAME")
    private String WRWNAME;

    @Column(name="YEAR")
    private String YEAR;

    @Column(name="PFL")
    private String PFL;

    @Column(name="LXR")
    private String LXR;

    @Column(name="QX")
    private String QX;

    @Column(name="DS")
    private String DS;

    @Column(name="LXDH")
    private String LXDH;

    @Column(name="ADDRESS")
    private String ADDRESS;

    @Column(name="LONGITUDE")
    private String LONGITUDE;

    @Column(name="LATITUDE")
    private String LATITUDE;

    public String getQYMC() {
        return QYMC;
    }

    public void setQYMC(String QYMC) {
        this.QYMC = QYMC;
    }

    public String getWRWNAME() {
        return WRWNAME;
    }

    public void setWRWNAME(String WRWNAME) {
        this.WRWNAME = WRWNAME;
    }

    public String getYEAR() {
        return YEAR;
    }

    public void setYEAR(String YEAR) {
        this.YEAR = YEAR;
    }

    public String getPFL() {
        return PFL;
    }

    public void setPFL(String PFL) {
        this.PFL = PFL;
    }

    public String getLXR() {
        return LXR;
    }

    public void setLXR(String LXR) {
        this.LXR = LXR;
    }

    public String getQX() {
        return QX;
    }

    public void setQX(String QX) {
        this.QX = QX;
    }

    public String getDS() {
        return DS;
    }

    public void setDS(String DS) {
        this.DS = DS;
    }

    public String getLXDH() {
        return LXDH;
    }

    public void setLXDH(String LXDH) {
        this.LXDH = LXDH;
    }

    public String getADDRESS() {
        return ADDRESS;
    }

    public void setADDRESS(String ADDRESS) {
        this.ADDRESS = ADDRESS;
    }

    public String getLONGITUDE() {
        return LONGITUDE;
    }

    public void setLONGITUDE(String LONGITUDE) {
        this.LONGITUDE = LONGITUDE;
    }

    public String getLATITUDE() {
        return LATITUDE;
    }

    public void setLATITUDE(String LATITUDE) {
        this.LATITUDE = LATITUDE;
    }
}
