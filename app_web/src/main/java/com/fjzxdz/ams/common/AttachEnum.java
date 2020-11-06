package com.fjzxdz.ams.common;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum AttachEnum implements EnumMessage {
	DEBRIEF("DEBRIEF_TYPE", "整治项目汇报");

	private String key;
	private String value;

	private AttachEnum(String key, String value) {
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
		for (AttachEnum element : AttachEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	
}
