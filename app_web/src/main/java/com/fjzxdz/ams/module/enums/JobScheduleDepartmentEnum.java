package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum JobScheduleDepartmentEnum implements EnumMessage {
	VEHICLE("VEHICLE", "车辆污染"),
	DMBZRZ("DMBZRZ", "党建目标责任制");

	private String key;
	private String value;

	private JobScheduleDepartmentEnum(String key, String value) {
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
		for (JobScheduleDepartmentEnum element : JobScheduleDepartmentEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
}
