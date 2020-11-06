package com.fjzxdz.ams.module.enviromonit.water.entity;

import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Clob;
import java.util.Date;

@Entity
@Table(name = "WT_SECTION_MONTH_REPORT")
public class WtSectionMonthReport implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "UUID")
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "org.hibernate.id.UUIDGenerator")
    private String uuid;

    @Column(name = "SECTION_CODE")
    private String sectionCode;

    @Column(name = "SECTION_NAME")
    private String sectionName;

    @Column(name = "CATEGORY")
    private String category;

    @Column(name = "YEAR_NUMBER")
    private Integer yearNumber;

    @Column(name = "MONTH_NUMBER")
    private Integer monthNumber;

    @Column(name = "TARGET_QUALITY")
    @Enumerated(EnumType.STRING)
    private WaterQualityEnum targetQuality;

    @Column(name = "LAST_YEAR_QUALITY")
    @Enumerated(EnumType.STRING)
    private WaterQualityEnum lastYearQuality;

    @Column(name = "RESULT_QUALITY")
    @Enumerated(EnumType.STRING)
    private WaterQualityEnum resultQuality;

    @Column(name = "AVERAGE_QUALITY")
    @Enumerated(EnumType.STRING)
    private WaterQualityEnum averageQuality;

    @Column(name = "STATUS")
    private Integer status;

    @Column(name = "EXCESSFACTORSTR")
    @Lob
    private String excessfactorstr;


    public WtSectionMonthReport() {
    }

    public Integer getMonthNumber() {
        return monthNumber;
    }

    public void setMonthNumber(Integer monthNumber) {
        this.monthNumber = monthNumber;
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

    public WaterQualityEnum getResultQuality() {
        return resultQuality;
    }

    public void setResultQuality(WaterQualityEnum resultQuality) {
        this.resultQuality = resultQuality;
    }

    public WaterQualityEnum getTargetQuality() {
        return targetQuality;
    }

    public void setTargetQuality(WaterQualityEnum targetQuality) {
        this.targetQuality = targetQuality;
    }

    public Integer getYearNumber() {
        return yearNumber;
    }

    public void setYearNumber(Integer yearNumber) {
        this.yearNumber = yearNumber;
    }

    public WaterQualityEnum getAverageQuality() {
        return averageQuality;
    }

    public void setAverageQuality(WaterQualityEnum averageQuality) {
        this.averageQuality = averageQuality;
    }

    public WaterQualityEnum getLastYearQuality() {
        return lastYearQuality;
    }

    public void setLastYearQuality(WaterQualityEnum lastYearQuality) {
        this.lastYearQuality = lastYearQuality;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getExcessfactorstr() {
        return excessfactorstr;
    }

    public void setExcessfactorstr(String excessfactorstr) {
        this.excessfactorstr = excessfactorstr;
    }
}