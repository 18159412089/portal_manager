package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum RegionCodeEnum implements EnumMessage {

    NJX("350627","南靖县"),
    ZPX("350623","漳浦县"),
    LWQ("350603","龙文区"),
    LHS("350681","龙海市"),
    HAX("350629","华安县"),
    PHX("350628","平和县"),
    YXX("350622","云霄县"),
    ZZS("350600","漳州市"),
    ZAX("350624","诏安县"),
    CTX("350625","长泰县"),
    DSX("350626","东山县"),
    XCQ("350602","芗城区");

    private String key;
	private String value;

	private RegionCodeEnum(String key, String value) {
		this.key = key;
		this.value = value;
	}

	@Override
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

	@Override
	public JSONArray getJSONArray() {
		JSONArray jsonArray = new JSONArray();
		for (RegionCodeEnum element : RegionCodeEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("code", element.getKey());
			jsonObject.put("name", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	public static Boolean containKey(String key){
        Boolean result = false;
        for(RegionCodeEnum codeEnum : RegionCodeEnum.values()){
            if(codeEnum.key.equals(key)){
                result = true;
                break;
            }
        }
        return result;
    }

	public static RegionCodeEnum getRegionCodeEnum(String key){
        RegionCodeEnum result = null;
        for(RegionCodeEnum codeEnum : RegionCodeEnum.values()){
            if(codeEnum.key.equals(key)){
                result = codeEnum;
                break;
            }
        }
        return result;
	}

	public static String getRegionCodeEnumValue(String key){
	    String result = "";
	    RegionCodeEnum codeEnum = RegionCodeEnum.getRegionCodeEnum(key);
	    if(codeEnum != null){
	        result = codeEnum.getValue();
        }
        return result;
    }

	public final static void main(String[] args){
	    String token = "350629";
	    System.out.println(RegionCodeEnum.getRegionCodeEnumValue(token));
    }
}
