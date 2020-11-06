package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum EvnRectfCatogoryEnum implements EnumMessage{
	WATER("WATER","水污染防治"),
	AIR("AIR","空气污染防治"),
	SOIL("SOIL","土壤污染防治"),
	VOICE("VOICE","噪声污染防治"),
	矿山整治("矿山整治","矿山整治"),
	基础设施("基础设施","基础设施"),
	饮用水源("饮用水源","饮用水源"),
	流域("流域","流域"),
	大气("大气","大气"),
	企业监管("企业监管","企业监管"),
	石材行业("石材行业","石材行业"),
	污水处理厂("污水处理厂","污水处理厂"),
	固废("固废","固废"),
	自然保护区("自然保护区","自然保护区"),
	产业政策("产业政策","产业政策"),
	工业企业("工业企业","工业企业"),
	工业园区("工业园区","工业园区"),
	矿产("矿产","矿产"),
	黑臭水体("黑臭水体","黑臭水体"),
	农业面源("农业面源","农业面源"),
	垃圾("垃圾","垃圾"),
	排污口("排污口","排污口"),
	施工扬尘("施工扬尘","施工扬尘"),
	水源地("水源地","水源地"),
	污水("污水","污水"),
	小流域("小流域","小流域"),
	渣土("渣土","渣土");

	private String key;
	private String value;
	
	EvnRectfCatogoryEnum(String key, String value) {
		this.key = key;
		this.value = value;
	}
	
	@Override
	public String getKey() {
		return key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public void setKey(String key) {
		this.key = key;
	}
	
	@Override
	public JSONArray getJSONArray() {
		JSONArray jsonArray = new JSONArray();
		for(EvnRectfCatogoryEnum element : EvnRectfCatogoryEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
}
