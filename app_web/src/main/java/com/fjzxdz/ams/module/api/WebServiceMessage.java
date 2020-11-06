package com.fjzxdz.ams.module.api;


import com.alibaba.fastjson.JSONObject;

import java.util.List;
import java.util.Map;

public class WebServiceMessage extends JSONObject {

	private static final String MESSAGE = "msg";
	public static final String LIST = "list";
	public static final String RECORD = "record";

	public WebServiceMessage(){
		super();
	}

	public void setMessage(String msg) throws Exception {
		this.put(MESSAGE, msg);
	}

	public void setRecord(Map<String, Object> record) throws Exception {
		this.put(RECORD, record);
	}

	public void setList(List list) throws Exception {
		this.put(LIST, list);
	}

	public void setPageInfo(int page, int rows, int total)
			throws Exception {
		JSONObject sizeInfo = new JSONObject();

		int maxPage = total / rows;
		if (total % rows > 0) {
            maxPage++;
        }
        sizeInfo.put("page", page);
        sizeInfo.put("maxPage", maxPage);
		sizeInfo.put("rows", rows);
		sizeInfo.put("total", total);

		this.put("pageInfo", sizeInfo);
	}
}