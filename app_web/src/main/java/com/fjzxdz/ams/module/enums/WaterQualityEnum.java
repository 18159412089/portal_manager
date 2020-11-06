package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum WaterQualityEnum implements EnumMessage {
	NONE("-", "未知"),
	FIRSR("Ⅰ", "Ⅰ类"),
	SECOND("Ⅱ", "Ⅱ类"),
	THIRD("Ⅲ", "Ⅲ类"),
	FOURTH("Ⅳ", "Ⅳ类"),
	FIFTH("Ⅴ", "Ⅴ类"),
	OTHER("劣Ⅴ", "劣Ⅴ类");

	private String key;
	private String value;

	private WaterQualityEnum(String key, String value) {
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
		for (WaterQualityEnum element : WaterQualityEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
}
