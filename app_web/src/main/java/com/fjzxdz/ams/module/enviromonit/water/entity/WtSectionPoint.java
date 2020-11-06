package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name="WT_SECTION_POINT")
public class WtSectionPoint implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="SECTION_CODE")
	private String pointCode;

	@Column(name="SECTION_NAME")
	private String pointName;

    /**
     * 断面类型(1:国控,2:省控,3,其他)
     */
	@Column(name = "CATEGORY")
    private String category;

    /**
     * 目标水质
     */
	@Column(name = "TARGET_QUALITY")
    private String targetQuality;

    /**
     * 是否以奖促治项目
     */
    @Column(name = "IS_PROMOTING")
    private BigDecimal isPromoting;

    /**
     * 是否党政目标责任书项目
     */
    @Column(name = "IS_TARGET_PROJECT")
    private BigDecimal isTargetProject;

	private BigDecimal status;

	public WtSectionPoint() {
	}

	public String getPointCode() {
		return pointCode;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public BigDecimal getStatus() {
		return status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

    public String getTargetQuality() {
        return targetQuality;
    }

    public void setTargetQuality(String targetQuality) {
        this.targetQuality = targetQuality;
    }

    public BigDecimal getIsPromoting() {
        return isPromoting;
    }

    public void setIsPromoting(BigDecimal isPromoting) {
        this.isPromoting = isPromoting;
    }

    public BigDecimal getIsTargetProject() {
        return isTargetProject;
    }

    public void setIsTargetProject(BigDecimal isTargetProject) {
        this.isTargetProject = isTargetProject;
    }

    public static final String WT_SECTION_POINT_JEDIS_MAP = "WT_SECTION_POINT_JEDIS_MAP";
}