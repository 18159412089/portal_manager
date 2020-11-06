package com.fjzxdz.ams.module.weather;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import cn.fjzxdz.frame.license.utils.Utils;

public class BaiduMap {
	private static Log log = LogFactory.getLog(ConfigConnection.class);

	public BaiduMap() {
		super();
		getMapInfo();
	}

	private static String AK;
	private static String SERVICE_ID;
	private static String longitude;
	private static String latitude;

	public static String getAK() {
		if (AK == null || "".equals(AK)) {
			getMapInfo();
		}
		return AK;
	}

	public static void setTEST_AK(String ak) {
		AK = ak;
	}

	public static String getSERVICE_ID() {
		return SERVICE_ID;
	}

	public static void setSERVICE_ID(String sERVICE_ID) {
		SERVICE_ID = sERVICE_ID;
	}

	public static String getLongitude() {
		return longitude;
	}

	public static void setLongitude(String longitude) {
		BaiduMap.longitude = longitude;
		updateProperties("longitude", longitude);
	}

	public static String getLatitude() {
		return latitude;
	}

	public static void setLatitude(String latitude) {
		BaiduMap.latitude = latitude;
		updateProperties("latitude", latitude);
	}

	private static void getMapInfo() {
		Properties config = new Properties();
		FileInputStream fis = null;
		/*
		 * HttpServletRequest request = ControllerContext.getCurrentInstance()
		 * .getRequest(); HttpSession session = request.getSession();
		 */

		try {
			String path = ConfigConnection.class.getResource("/").getPath() + "../baidu_map_key.prop";
			fis = new FileInputStream(URLDecoder.decode(path, "UTF-8"));
			config.load(fis);

			AK = config.getProperty("AK");
			SERVICE_ID = config.getProperty("serviceId");
			longitude = config.getProperty("longitude");
			latitude = config.getProperty("latitude");
			/*
			 * System.out.println(testAk); session.setAttribute("testAk",
			 * testAk); session.setAttribute("serviceId", serviceId);
			 */

		} catch (Exception e) {
			log.error(Utils.getOriginalMessageFromException(e), e);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
					log.error(Utils.getOriginalMessageFromException(e), e);
				}
			}
		}
	}

	/**
	 * 更新properties文件的键值对 如果该主键已经存在，更新该主键的值； 如果该主键不存在，则插件一对键值。
	 * 
	 * @param keyname
	 *            键名
	 * @param keyvalue
	 *            键值
	 */
	public static void updateProperties(String keyname, String keyvalue) {
		Properties props = new Properties();
		FileInputStream fis = null;
		try {
			String profilepath = ConfigConnection.class.getResource("/").getPath() + "../baidu_map_key.prop";
			props.load(new FileInputStream(profilepath));
			// 调用 Hashtable 的方法 put，使用 getProperty 方法提供并行性。
			// 强制要求为属性的键和值使用字符串。返回值是 Hashtable 调用 put 的结果。
			OutputStream fos = new FileOutputStream(profilepath);
			props.setProperty(keyname, keyvalue);
			// 以适合使用 load 方法加载到 Properties 表中的格式，
			// 将此 Properties 表中的属性列表（键和元素对）写入输出流
			props.store(fos, "Update '" + keyname + "' value");
		} catch (IOException e) {
			System.err.println("属性文件更新错误");
		}
	}
}
