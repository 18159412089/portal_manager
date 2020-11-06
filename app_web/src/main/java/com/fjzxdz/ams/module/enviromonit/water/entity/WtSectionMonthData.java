package com.fjzxdz.ams.module.enviromonit.water.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="WT_SECTION_MONTH_DATA")//
public class WtSectionMonthData implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "org.hibernate.id.UUIDGenerator")
    private String uuid;

    @Temporal(TemporalType.TIMESTAMP)
    private Date datatime;

    @Column(name="SECTION_CODE")
    private String sectionCode;

    @Column(name="SECTION_NAME")
    private String sectionName;

    @Column(name = "CATEGORY")
    private String category;

    @Column(name = "YEAR_NUMBER")
    private Integer yearNumber;

    @Column(name = "MONTH_NUMBER")
    private Integer monthNumber;

    @Column(name="CODE_POLLUTE")
    private String codePollute;

    @Column(name = "POLLUTE_NAME")
    private String polluteName;

    @Column(name = "POLLUTE_VALUE")
    private BigDecimal polluteValue;

    private BigDecimal status;

    public WtSectionMonthData() {
        this.status = BigDecimal.valueOf(0)
        ;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Date getDatatime() {
        return datatime;
    }

    public void setDatatime(Date datatime) {
        this.datatime = datatime;
    }

    public String getSectionCode() {
        return sectionCode;
    }

    public void setSectionCode(String sectionCode) {
        this.sectionCode = sectionCode;
    }

    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    public String getCodePollute() {
        return codePollute;
    }

    public void setCodePollute(String codePollute) {
        this.codePollute = codePollute;
    }

    public String getPolluteName() {
        return polluteName;
    }

    public void setPolluteName(String polluteName) {
        this.polluteName = polluteName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getYearNumber() {
        return yearNumber;
    }

    public void setYearNumber(Integer yearNumber) {
        this.yearNumber = yearNumber;
    }

    public Integer getMonthNumber() {
        return monthNumber;
    }

    public void setMonthNumber(Integer monthNumber) {
        this.monthNumber = monthNumber;
    }

    public BigDecimal getPolluteValue() {
        return polluteValue;
    }

    public void setPolluteValue(BigDecimal polluteValue) {
        this.polluteValue = polluteValue;
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("uuid:"+this.getUuid());
        sb.append(",codePollute:"+this.getCodePollute());
        sb.append(",polluteName:"+this.getPolluteName());
        sb.append(",polluteValue:"+this.getPolluteValue());
        sb.append(",sectionCode:"+this.getSectionCode());
        sb.append(",datatime:"+this.getDatatime());

        return sb.toString();
    }
}