package com.fjzxdz.ams.module.enviromonit.air.enums;

/**
 * @program: portal_manager
 * @className: AirFactorsNameEnum
 * @description: TODO 大气相关监测因子的化学式、中文名
 * @author: lianhuinan
 * @create: 2019-06-15 17:05
 * @version: 1.0
 */
public enum AirFactorsNameEnum {

    /**
     * 获取大气监测因子的化学式、中文名、单位
     */
    NO2("NO2", "NO₂", "二氧化氮", "微克/立方米", "μg/m³"),
    CO("CO", "CO", "一氧化碳", "毫克/立方米", "mg/m³"),
    SO2("SO2", "SO₂","二氧化硫", "微克/立方米", "μg/m³"),
    O3("O3", "O₃","臭氧", "微克/立方米", "μg/m³"),
    PM25("PM25", "PM2.5","PM2.5", "微克/立方米", "μg/m³"),
    PM10("PM10", "PM10","PM10", "微克/立方米", "μg/m³");

    private String key;

    private String chemicalName;

    private String chnName;

    private String unit;

    private String engUnit;

    AirFactorsNameEnum(String key, String chemicalName, String chnName, String unit, String engUnit){
        this.chemicalName=chemicalName;
        this.key=key;
        this.chnName=chnName;
        this.unit=unit;
        this.engUnit=engUnit;
    }
    
    public String getEngUnit() {
		return engUnit;
	}
    
    public void setEngUnit(String engUnit) {
		this.engUnit = engUnit;
	}
    
    public String getUnit() {
		return unit;
	}
    
    public void setUnit(String unit) {
		this.unit = unit;
	}

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getChemicalName() {
        return chemicalName;
    }

    public void setChemicalname(String chemicalName) {
        this.chemicalName = chemicalName;
    }

    public String getChnName() {
        return chnName;
    }

    public void setChnName(String chnName) {
        this.chnName = chnName;
    }
}
