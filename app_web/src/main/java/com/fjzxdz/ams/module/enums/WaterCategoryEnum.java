package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum WaterCategoryEnum implements EnumMessage {
	SEA("SEA", "海洋"), 
	RIVER("RIVER", "入海河流"), 
	GROUND("GROUND", "地下水"), 
	POTABLEWATER("POTABLEWATER", "饮用水"),
	SURFACEWATER("SURFACEWATER", "地表水");

	private String key;
	private String value;

	private WaterCategoryEnum(String key, String value) {
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

	@Override
	public JSONArray getJSONArray() {
		JSONArray jsonArray = new JSONArray();
		for (WaterCategoryEnum element : WaterCategoryEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
}
