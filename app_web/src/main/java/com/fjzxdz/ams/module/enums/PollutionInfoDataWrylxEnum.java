package com.fjzxdz.ams.module.enums;

public enum PollutionInfoDataWrylxEnum {
    涉水工业企业 ("涉水工业企业", "WadingIndustrialEnterprise", "水", 1),
    涉海工业固废  ("涉海工业固废", "SeaIndustrySolidWaste", "海洋", 2),
    海洋排污口("海洋排污口", "SeaSewageOutlet", "海洋", 3),
    VOCs企业 ("VOCs企业", "VOCsEnterprise", "大气", 4),
    高架源企业 ("高架源企业", "ElevatedSourceEnterprise", "大气", 5),
    散乱污企业 ("散乱污企业", "ScatteredEnterprise", "大气", 6),
    非道路移动源 ("非道路移动源", "NonRoadMobileSource", "大气", 12),
    工业固废  ("工业固废", "IndustrialSolidWaste", "土壤", 7),
    工业危险废物 ("工业危险废物", "IndustrialHazardousWaste","土壤", 8),
    三格化粪池 ("三格化粪池", "ThreeSepticTank","土壤", 11),
    持证矿山 ("持证矿山", "LicensedMine","生态", 10),
    石板材行业 ("石板材行业", "StonePlateIndustry","生态", 9),
    生态污染源企业 ("生态污染源企业", "EcologicalPollutionSourceEnterprise","生态", 99);

    private String key;

    private String value;

    private String parant;

    private int index;

    PollutionInfoDataWrylxEnum(String key, String value, String parant, int index) {
        this.key = key;
        this.value = value;
        this.index = index;
        this.parant = parant;
    }

    public String getParant() {
        return parant;
    }

    public void setParant(String parant) {
        this.parant = parant;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public static void main(String[] args) {
        System.out.println(PollutionInfoDataWrylxEnum.涉水工业企业.getIndex());

    }
}
