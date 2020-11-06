package com.fjzxdz.ams.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * 计算api的值
 */
public class AqiUtil {
	public static void main(String[] args) {
					//10
		Aqi aq = CountAqi(56, 76, 0.7 ,45, 10, 5);
		Double aqi = aq.getAqi();
		String aqiName = aq.getName(); 
		DecimalFormat df = new DecimalFormat("#");
		System.out.println("AQI指数："+ aqi);
		System.out.println("最大污染物："+ aqiName);
		System.out.println("====="+AqiUtil.countPerIaqi(100, 5));
	}

	/**
	 * 计算每种污染物项目 P的空气质量分指数
	 * 
	 * @param cp 污染物项目P的质量浓度
	 * @param r  污染物项目P所在数组中的行号
	 * @return
	 */
	public static double countPerIaqi(double cp, int r) {
		double bph = 0; // 与 cp相近的污染物浓度限值的高位值
		double bpl = 0; // 与 cp相近的污染物浓度限值的低位值
		double iaqih = 0; // 与 bph对应的空气质量分指数
		double iaqil = 0; // 与 bpl对应的空气质量分指数
		double iaqip = 0; // 当前污染物项目P的空气质量分指数

		// 空气质量分指数及对应的污染物项目浓度限值
//		int[][] aqiArr = { { 0, 50, 100, 150, 200, 300, 400, 500 },//aqi
//				{ 0, 35, 75, 115, 150, 250, 350, 500 },//PM2.5
//				{ 0, 50, 150, 250, 350, 420, 500, 600 },//PM10
//				{ 0, 2, 4, 14, 24, 36, 48, 60 },//co
//				{ 0, 40, 80, 180, 280, 565, 750, 940 },//no2
//				{ 0, 160, 200, 300, 400, 800, 1000, 1200 },//o3
//				{ 0, 50, 150, 475, 800, 1600, 2100, 2620 }, };//so2
		Integer[][] aqiArr = { { 0, 50, 100, 150, 200, 300, 400, 500 },//aqi
				{ 0, 35, 75, 115, 150, 250, 350, 500 },//PM2.5
				{ 0, 50, 150, 250, 350, 420, 500, 600 },//PM10
				{ 0, 5, 10, 35, 60, 90, 120, 150 },//co
				{ 0, 100, 200, 700, 1200, 2340, 3090, 3840 },//no2
				{ 0, 100, 160, 215, 265, 800, null, null },//o3
				{ 0, 150, 500, 650, 800, null, null, null }, };//so2

		// 对每种污染物的bph、bpl、iaqih、iaqil进行赋值
		for (int i = r; i < r + 1; i++) {
			Boolean isChange = false;
			for (int j = 0; j < aqiArr[0].length; j++) {
				if(aqiArr[i][j]==null) {
					isChange = true;
					break;
				}
				if (cp < aqiArr[i][j]) {
					bph = aqiArr[i][j];
					bpl = aqiArr[i][j - 1];
					iaqih = aqiArr[0][j];
					iaqil = aqiArr[0][j - 1];
					break;
				}
			}
			if(isChange) {
				if(r==5) {
					Integer[] tempArr = {0, 160, 200, 300, 400, 800, 1000, 1200};
					aqiArr[i] = tempArr;
				}
				if(r==6) {
					Integer[] tempArr = {0, 50, 150, 475, 800, 1600, 2100, 2620};
					aqiArr[i] = tempArr;
				}
				for (int j = 0; j < aqiArr[0].length; j++) {
					if(aqiArr[i][j]==null) {
						break;
					}
					if (cp < aqiArr[i][j]) {
						bph = aqiArr[i][j];
						bpl = aqiArr[i][j - 1];
						iaqih = aqiArr[0][j];
						iaqil = aqiArr[0][j - 1];
						break;
					}
				}
			}
		}

		// 计算污染物项目 P的空气质量分指数
		iaqip = (iaqih - iaqil) / (bph - bpl) * (cp - bpl) + iaqil;

		return iaqip;
	}

	/**
	 * 根据提供污染物的各项指标，对AQI进行计算
	 * 
	 * @param pmtw
	 *            PM2.5
	 * @param pmte
	 *            PM10
	 * @param co
	 *            一氧化碳浓度
	 * @param no2
	 *            二氧化碳浓度
	 * @param o3
	 *            臭氧浓度
	 * @param so2
	 *            二氧化硫浓度
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Aqi CountAqi(int pmtw, int pmte, double co, double no2,
			double o3, double so2) {

		double pmtwIaqi = countPerIaqi(pmtw, 1);
		double pmteIaqi = countPerIaqi(pmte, 2);
		double coIaqi = countPerIaqi(co, 3);
		double no2Iaqi = countPerIaqi(no2, 4);
		double o3Iaqi = countPerIaqi(o3, 5);
		double so2Iaqi = countPerIaqi(so2, 6);
		// 初始化对象数组
		List<Aqi> aList = new ArrayList<Aqi>();
		aList.add(new Aqi("PM2.5", pmtwIaqi));
		aList.add(new Aqi("PM10", pmteIaqi));
		aList.add(new Aqi("CO", coIaqi));
		aList.add(new Aqi("NO2", no2Iaqi));
		aList.add(new Aqi("O3", o3Iaqi));
		aList.add(new Aqi("SO2", so2Iaqi));
		Collections.sort(aList,new AqiComparator());
		Aqi aqi = aList.get(aList.size()-1);
		
		return aqi;
	}
}
/**
 * 构造分类器类，对AQI对象链表进行排序
 */
class AqiComparator implements Comparator {

	public int compare(Object o1, Object o2) {
		Aqi a1 = (Aqi) o1;
		Aqi a2 = (Aqi) o2;

		double result = a1.getAqi() - a2.getAqi();
		
		return (int) result;
	}
}

enum PulloteEnum {
	PM10(1, "PM10", "粉尘颗粒物10"),
	PM25(1, "PM25", "粉尘颗粒物2.5"),
	CO(1, "CO", "一氧化碳"),
	NO2(1, "NO2", "二氧化碳"),
	O3(1, "O3", "臭氧"),
	SO2(1, "SO2", "二氧化硫");

	private int key;
	private String factory;
	private String value;
	
	PulloteEnum(int key, String factory, String value) {
		this.factory = factory;
		this.key = key;
		this.value = value;
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public String getFactory() {
		return factory;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
