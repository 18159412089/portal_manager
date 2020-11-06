package com.fjzxdz.ams.util;

import java.math.BigDecimal;

import cn.hutool.json.JSONObject;


public class CodeUtil {
	public static JSONObject codeJson = new JSONObject("{\"温度\":\"W01010\",\"浊度\":\"W01003\",\"电导率\":\"W01014\",\"水温\":\"W01010\",\"总磷\":\"W21011\",\"氨氮\":\"W21003\",\"高锰酸盐指数\":\"W01019\",\"溶解氧\":\"W01009\",\"pH\":\"W01001\",\"总氮\":\"W21001\"}");
	public static void main(String[] args) {
//		{"总磷":"W21011","氨氮":"W21003","高锰酸盐指数":"W01019","溶解氧":"W01009","pH":"W01001"}
		System.out.println("========="+CodeUtil.getCode("总磷"));
		System.out.println("========="+new BigDecimal(".3"));
		

	}
	public static String getCode(String key) {
		if(codeJson.containsKey(key)) {
			return codeJson.getStr(key);
		}
        return "-";
    }

}
