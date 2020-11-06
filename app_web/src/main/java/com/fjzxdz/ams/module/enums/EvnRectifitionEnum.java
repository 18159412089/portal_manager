package com.fjzxdz.ams.module.enums;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public enum EvnRectifitionEnum implements EnumMessage{
	NOTSTART("NOTSTART","尚未启动",0),
	NOTREACH("NOTREACH","未达到序时进度",1),
	ONTIME("ONTIME","达到序时进度",2),
	PASS("PASS","超过序时进度",3),
	OVER("OVER","完成整改",4),
	SENDACCOUNT("SENDACCOUNT","完成交账销号",5);
	
	private String key;
	private String value;
	private Integer num;
	
	EvnRectifitionEnum(String key, String value, Integer num) {
		this.key = key;
		this.value = value;
		this.num = num;
	}
	
	public Integer getNum() {
		return num;
	}
	
	public void setNum(Integer num) {
		this.num = num;
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
		for(EvnRectifitionEnum element : EvnRectifitionEnum.values()) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", element.getKey());
			jsonObject.put("text", element.getValue());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
}
