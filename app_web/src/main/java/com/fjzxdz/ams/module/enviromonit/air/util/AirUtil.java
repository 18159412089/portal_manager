package com.fjzxdz.ams.module.enviromonit.air.util;

/**
 * 
 * 关于大气计算所需的常用属性、方法工具类
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年6月17日 上午11:02:50
 */
public class AirUtil {
	
	/**
	 * 
	 * @Title:  getColor
	 * @Description:    TODO(根据AQI的值返回该级别所属颜色)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月17日 上午11:01:35
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月17日 上午11:01:35    
	 * @param aqi
	 * @return  String 
	 * @throws
	 */
	public static final String getColor(double aqi) {
		if(aqi <= 50) {
			return "#00E400";
		} else if(aqi <= 100) {
			return "#FFFF00";
		} else if(aqi <= 150) {
			return "#FF7E00";
		} else if(aqi <= 200) {
			return "#FF0000";
		} else if(aqi <= 300) {
			return "#99004C";
		} else {
			return "#7E0023";
		}
	}
	
	/**
	 * 
	 * @Title:  getLevel
	 * @Description:    TODO(根据AQI的值返回该级别)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月17日 上午11:02:22
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月17日 上午11:02:22    
	 * @param aqi
	 * @return  String 
	 * @throws
	 */
	public static final String getLevel(double aqi) {
		if(aqi <= 50) {
			return "优";
		} else if(aqi <= 100) {
			return "良";
		} else if(aqi <= 150) {
			return "轻度污染";
		} else if(aqi <= 200) {
			return "中度污染";
		} else if(aqi <= 300) {
			return "重度污染";
		} else {
			return "严重污染";
		}
	}

}
