package com.fjzxdz.ams.module.enums;

public enum CityEnum {
    //漳州城市枚举
    芗城区("xcq", "芗城区",1),龙文区("lw","龙文区",2),龙海市("lhs","龙海市",3),漳浦县("zpx","漳浦县",4)
    ,南靖县("njx","南靖县",5),云霄县("yxx","云霄县",6),诏安县("zax","诏安县",7),东山县("dsx","东山县",8)
    ,平和县("phx","平和县",9),华安县("hax","华安县",10),长泰县("ctx","长泰县",11);


    private String key;
    private String value;
    private int index;

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

    CityEnum(String key, String value, int index) {
        this.key = key;
        this.value = value;
        this.index = index;
    }
}
