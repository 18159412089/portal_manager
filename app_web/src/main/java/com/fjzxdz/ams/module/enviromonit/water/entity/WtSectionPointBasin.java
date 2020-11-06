/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 水系站点Entity
 * @author ZhangGQ
 * @version 2019-06-25
 */
@Entity
@Table(name = "WT_SECTION_POINT_BASIN")
public class WtSectionPointBasin{
	
	private static final long serialVersionUID = 1L;
    /** 断面ID */
    @Id
    private String uuid;
	/** 断面ID */
	private String sectionPointId;
	/** 水系ID */
	private String basinId;
	/** 类型（1面数据，2线数据） */
	private String basinType;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getSectionPointId() {
		return sectionPointId;
	}

	public void setSectionPointId(String sectionPointId) {
		this.sectionPointId = sectionPointId;
	}
	public String getBasinId() {
		return basinId;
	}

	public void setBasinId(String basinId) {
		this.basinId = basinId;
	}
	public String getBasinType() {
		return basinType;
	}

	public void setBasinType(String basinType) {
		this.basinType = basinType;
	}
	
}


