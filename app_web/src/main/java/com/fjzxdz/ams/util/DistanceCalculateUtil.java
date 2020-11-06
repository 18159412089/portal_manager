package com.fjzxdz.ams.util;

public class DistanceCalculateUtil {

	static double EARTH_RADIUS = 6371.0;// km 地球半径 平均值，千米

	public static double distanceCalculate(double lon1, double lat1, double lon2, double lat2) {
		// 用haversine公式计算球面两点间的距离。
		// 经纬度转换成弧度
		lat1 = convertDegreesToRadians(lat1);
		lon1 = convertDegreesToRadians(lon1);
		lat2 = convertDegreesToRadians(lat2);
		lon2 = convertDegreesToRadians(lon2);
		// 差值
		double vLon = Math.abs(lon1 - lon2);
		double vLat = Math.abs(lat1 - lat2);
		double h = HaverSin(vLat) + Math.cos(lat1) * Math.cos(lat2) * HaverSin(vLon);
		double distance = 2 * EARTH_RADIUS * Math.asin(Math.sqrt(h));
		return distance;
	}

	private static double HaverSin(double theta) {
		double v = Math.sin(theta / 2);
		return v * v;
	}

	/// <summary>
	/// 将角度换算为弧度。
	/// </summary>
	/// <param name="degrees">角度</param>
	/// <returns>弧度</returns>
	private static double convertDegreesToRadians(double degrees) {
		return degrees * Math.PI / 180;
	}

//	private static double convertRadiansToDegrees(double radian) {
//		return radian * 180.0 / Math.PI;
//	}

	public static void main(String[] args) {
		System.out.println(distanceCalculate(25.1441, 117.5135, 24.5653, 117.5328));
	}
}
