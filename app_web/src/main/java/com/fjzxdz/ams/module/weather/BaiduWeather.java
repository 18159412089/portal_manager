package com.fjzxdz.ams.module.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.json.JSONException;
import org.json.JSONObject;
/**
 * 
 * 百度天气查询
 * @Author   李龙安 
 * @Version   1.0 
 * @CreateTime 2017年5月26日 下午5:35:29
 */
public class BaiduWeather {

	// 根据城市获取天气信息的java代码
	// cityName 是你要取得天气信息的城市的中文名字，如“北京”，“深圳”
	public String getWeatherInform() {
		String cityName = getCity();//获取城市信息
		// 百度天气API
		String baiduUrl = null;
		try {
			baiduUrl = "http://api.map.baidu.com/telematics/v3/weather?location=" + URLEncoder.encode(cityName, "utf-8")
			+ "&output=json&ak=1bPCSYMA8WEgUd8HuxrvKGi8uRnGEZ1T";
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		StringBuffer strBuf;

		strBuf = new StringBuffer();

		try {
			URL url = new URL(baiduUrl);
			URLConnection conn = url.openConnection();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));// 转码。
			String line = null;
			while ((line = reader.readLine()) != null)
				strBuf.append(line + " ");
			reader.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return strBuf.toString();
	}

	/**
	 * 
	 * @Title:  getCity
	 * @Description:   百度通过当前IP获取城市   
	 * @CreateBy: 李龙安	
	 * @CreateTime: 2017年5月26日 下午5:36:08
	 * @UpdateBy: 李龙安
	 * @UpdateTime:  2017年5月26日 下午5:36:08    
	 * @return  String 
	 * @throws
	 */
	public String getCity() {
		String city = "";
		// 普通IP定位API
		String baiduUrl = "https://api.map.baidu.com/location/ip?ak=1bPCSYMA8WEgUd8HuxrvKGi8uRnGEZ1T&coor=bd09ll";
		StringBuffer strBuf;

		strBuf = new StringBuffer();

		try {
			URL url = new URL(baiduUrl);
			URLConnection conn = url.openConnection();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));// 转码。
			String line = null;
			while ((line = reader.readLine()) != null)
				strBuf.append(line + " ");
			reader.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String cityInfo = strBuf.toString();
		JSONObject jsonObject,jsonObject1;
		try {
			jsonObject = new JSONObject(cityInfo);
			String content = jsonObject.get("content").toString();
			jsonObject1 = new JSONObject(content);
			city = jsonObject1.get("address").toString();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return city;
	}
	public static void main(String[] args) throws JSONException {
		BaiduWeather baidu = new BaiduWeather();
		String city = baidu.getWeatherInform();
		System.out.println(city);
	}
}