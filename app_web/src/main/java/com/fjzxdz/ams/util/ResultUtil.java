package com.fjzxdz.ams.util;

import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;

public class ResultUtil {

	public static Result getOkResult() {
		return new Result().ok();
	}

	public static Result getOkResult(String msg) {
		return new Result().ok(msg);
	}

	public static Result getOkResult(Object data) {
		return new Result().ok(data);
	}

	public static Result getOkResult(String msg, Object data) {
		return new Result().ok(data);
	}

	public static Result getOkResult(ReturnEum returnEum) {
		return new Result().ok(returnEum);
	}
	
	public static Result getFailResult() {
		return new Result().fail();
	}

	public static Result getFailResult(Object data) {
		return new Result().fail(data);
	}

	public static Result getFailResult(int code, String msg) {
		return new Result().fail(code, msg);
	}

	public static Result getFailResult(ReturnEum returnEum) {
		return new Result().fail(returnEum.getCode(), returnEum.getMsg());
	}

	public static Result convertResult(R r) {
		Result result = new Result();
		if ("S".equals(r.get("type").toString())) {
			result.ok(r.get("message").toString());
		} else {
			result.fail(r.get("message").toString());
		}
		return result;
	}
	
	public static Result convertResult(R r,String msg) {
		Result result = new Result();
		if ("S".equals(r.get("type").toString())) {
			result.ok(msg);
		} else {
			result.fail(msg);
		}
		return result;
	}
	
	public static Result convertResult(R r,Object data) {
		Result result = new Result();
		if ("S".equals(r.get("type").toString())) {
			result.ok(data);
		} else {
			result.fail(data);
		}
		return result;
	}
	
	public static Result convertResult(R r,ReturnEum returnEum,Object data) {
		Result result = new Result();
		if ("S".equals(r.get("type").toString())) {
			result.ok(returnEum.getMsg(),data);
			result.setCode(returnEum.getCode());
		} else {
			result.fail(returnEum.getCode(),returnEum.getMsg());
			result.setData(data);
		}
		return result;
	}
	
	public static Result convertResult(R r,int code,String msg,Object data) {
		Result result = new Result();
		if ("S".equals(r.get("type").toString())) {
			result.ok(msg,data);
			result.setCode(code);
		} else {
			result.fail(code,msg);
			result.setData(data);
		}
		return result;
	}

}
