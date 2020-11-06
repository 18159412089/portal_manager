package com.fjzxdz.ams.module.enums;

public enum CityPollutionDirectEnum {
    VOCs企业 ("VOCs企业", "WadingIndustrialEnterprise", "水", 1),
    一般工业固废  ("涉海工业固废", "SeaIndustrySolidWaste", "海洋", 2),
    三格化粪池("三格化粪池", "SeaSewageOutlet", "海洋", 3),
    入河入海排污口 ("入河入海排污口", "VOCsEnterprise", "大气", 4),
    养殖废水 ("养殖废水", "ElevatedSourceEnterprise", "大气", 5),
    农业种植面源 ("农业种植面源", "ScatteredEnterprise", "大气", 6),
    商业活动 ("商业活动", "NonRoadMobileSource", "大气", 12),
    园区基础设施  ("园区基础设施", "IndustrialSolidWaste", "土壤", 7),
    城市生活污水处理厂 ("城市生活污水处理厂", "IndustrialHazardousWaste","土壤", 8),
    小水电站 ("小水电站", "ThreeSepticTank","土壤", 11),
    工业危险废物 ("工业危险废物", "LicensedMine","生态", 10),
    废弃矿山闭矿 ("废弃矿山闭矿", "StonePlateIndustry","生态", 9),
    持证矿山 ("持证矿山", "EcologicalPollutionSourceEnterprise","生态", 99),
    持证矿山环评  ("持证矿山环评", "SeaIndustrySolidWaste", "海洋", 2),
    持证矿山问题("持证矿山问题", "SeaSewageOutlet", "海洋", 3),
    散乱污企业 ("散乱污企业", "VOCsEnterprise", "大气", 4),
    水产养殖污染 ("水产养殖污染", "ElevatedSourceEnterprise", "大气", 5),
    河道问题 ("河道问题", "ScatteredEnterprise", "大气", 6),
    沿海沿江工业固废 ("沿海沿江工业固废", "NonRoadMobileSource", "大气", 12),
    沿海沿江生活垃圾  ("沿海沿江生活垃圾", "IndustrialSolidWaste", "土壤", 7),
    涉水工业企业 ("涉水工业企业", "IndustrialHazardousWaste","土壤", 8),
    渣土车 ("渣土车", "ThreeSepticTank","土壤", 11),
    漂浮垃圾 ("漂浮垃圾", "LicensedMine","生态", 10),
    生活垃圾 ("生活垃圾", "StonePlateIndustry","生态", 9),
    生活污水 ("生活污水", "EcologicalPollutionSourceEnterprise","生态", 99),
    石板材行业改造 ("石板材行业改造", "ThreeSepticTank","土壤", 11),
    石板材行业环评 ("石板材行业环评", "LicensedMine","生态", 10),
    自然保护区功能区保护 ("自然保护区功能区保护", "StonePlateIndustry","生态", 9),
    规划外养殖 ("规划外养殖", "EcologicalPollutionSourceEnterprise","生态", 99),
    道路扬尘  ("道路扬尘", "SeaIndustrySolidWaste", "海洋", 2),
    闭坑矿山水保("闭坑矿山水保", "SeaSewageOutlet", "海洋", 3),
    露天烧烤 ("露天烧烤", "VOCsEnterprise", "大气", 4),
    非法采矿 ("非法采矿", "ElevatedSourceEnterprise", "大气", 5),
    非道路移动源 ("非道路移动源", "ScatteredEnterprise", "大气", 6),
    项目水保监管 ("项目水保监管", "NonRoadMobileSource", "大气", 12),
    餐饮企业  ("餐饮企业", "IndustrialSolidWaste", "土壤", 7),
    高架源企业 ("高架源企业", "ThreeSepticTank","土壤", 11);



























    private String key;

    private String value;

    private String parant;

    private int index;

    CityPollutionDirectEnum(String key, String value, String parant, int index) {
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
        System.out.println(CityPollutionDirectEnum.涉水工业企业.getIndex());

    }
}
