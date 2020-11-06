package com.fjzxdz.ams.module.enums;

public enum PollutionInfoDataWryzlEnum {
    水 ("水", "s"),
    大气  ("大气", "dq"),
    海洋("海洋", "hy"),
    土壤 ("土壤", "tr"),
    生态 ("生态", "st");
    private String key;

    private String value;

    PollutionInfoDataWryzlEnum(String key, String value) {
        this.key = key;
        this.value = value;

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


    public static void main(String[] args) {
    }
}
