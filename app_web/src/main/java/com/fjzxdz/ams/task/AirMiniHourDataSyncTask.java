package com.fjzxdz.ams.task;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.tempuri.IOtherDataService;
import org.tempuri.IOtherDataServiceProxy;

import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.redis.RedisUtils;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;
@Component
@Configurable
@EnableScheduling
/**
 * @author chenbk
 */
public class AirMiniHourDataSyncTask {

	private static Logger logger = LogManager.getLogger(AirMiniHourDataSyncTask.class);
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

	@Autowired
	private Environment env;
	@Autowired
	private RedisUtils redisUtils;

	@Value("${isOpenScheduling}")
	private String isOpenScheduling;

	//每10分钟执行一次
	@Scheduled(cron = "0 */10 * * * ?")
	public void getAirHourDataSyncTask() throws Exception {
		if("true".equals(isOpenScheduling)) {
			logger.info("同步自建站点空气小时数据开始");
			String endpoint = "http://117.78.41.224:8017/webapi/OtherDataService.svc";
			String url = env.getProperty("main.datasource.url");
			String user = env.getProperty("main.datasource.user");
			String pass = env.getProperty("main.datasource.password");
			Long maxid = redisUtils.get("sync:airCityHourData")==null?79805080L:Long.valueOf(redisUtils.get("sync:airCityHourData"));
			Connection  conn=null;
			CallableStatement proc=null;
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, pass);
				conn.setAutoCommit(false);
				maxid = getData(maxid,conn,proc,endpoint);
				redisUtils.set("sync:airCityHourData", maxid,-1);
			} catch (Exception e) {
				logger.info("同步自建站点空气小时数据失败:"+e.getMessage());
				throw e;
			} finally {
				if(proc!=null) {
					proc.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}
		}
	}

	/***
	 * 
	 * @Title:  getData
	 * @Description:    获取漳州空气微型自建站点小时数据接口
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年5月28日 下午8:21:43
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年5月28日 下午8:21:43    
	 * @param maxid
	 * @param conn
	 * @param proc
	 * @param endpoint
	 * @throws Exception  void 
	 * @throws
	 */
	private Long getData(Long maxid, Connection conn, CallableStatement proc, String endpoint) throws Exception {
		IOtherDataServiceProxy proxy = new IOtherDataServiceProxy();
		proxy.setEndpoint(endpoint);
		//换成获取对应的serice
		IOtherDataService service =  proxy.getIOtherDataService();
		//调用web service提供的方法
		String result = service.getHourData("ZZWXZ886043564393", maxid);
		// 给方法传递参数，并且调用方法  
		JSONArray dataArray = new JSONArray(result);
		if (dataArray != null && dataArray.size() > 0) {
			String[] arr = {"PM10", "PM25", "CO", "NO2", "SO2", "O3", "O38H"};
			String[] codes = {"A34002", "A34004", "A21005", "A21004", "A21026", "A05024", "A050248"};
			String[] names = {"PM10", "PM2.5", "一氧化碳", "二氧化氮", "二氧化硫", "臭氧", "臭氧(8h)"};
			Aqi aqi = null;
			for (Object object : dataArray) {
				proc = conn.prepareCall("{call P_AIR_HOUR_DATA(?,?,?,?,?,?,?,?,?,?,?,?)}");
				JSONObject tempObject = (JSONObject) object;
				Long tempId = getLong(tempObject.get("ID"));
				maxid = maxid.compareTo(tempId) < 0 ? tempId : maxid;
				if(!tempObject.get("PM25").equals(null) && !tempObject.get("PM10").equals(null)
						&& !tempObject.get("CO").equals(null) && !tempObject.get("NO2").equals(null)
						&& !tempObject.get("O3").equals(null) && !tempObject.get("SO2").equals(null)) {
					aqi = AqiUtil.CountAqi(getInt(tempObject.get("PM25")), getInt(tempObject.get("PM10")), getInt(tempObject.get("CO")),
							getInt(tempObject.get("NO2")), getInt(tempObject.get("O3")), getInt(tempObject.get("SO2")));
				}

				JSONObject station = getStationInfo(StringUtils.nullToString(tempObject.get("STATIONID")));
				for (int i = 0; i < arr.length; i++) {
					proc.setString(1, getString(UUID.randomUUID()));
					proc.setTimestamp(2, getTimestamp(tempObject.get("RECEIVETIME")));
					proc.setString(3, getString("350600000000"));
					proc.setString(4, station.getStr("address"));
					proc.setString(5, getString(tempObject.get("STATIONID")));
					//站点名称
					proc.setString(6, station.getStr("name"));
					proc.setString(7, codes[i]);
					proc.setString(8, names[i]);
					proc.setBigDecimal(9, getNumber(tempObject.get(arr[i])));
					proc.setString(10, getString(tempObject.get(arr[i])));
					proc.setTimestamp(11, getTimestamp(tempObject.get("RECEIVETIME")));
					proc.setBigDecimal(12, aqi == null ? getNumber(0) : getNumber(aqi.getAqi()));
					proc.addBatch();
				}
				proc.executeBatch();
				conn.commit();
				proc.clearBatch();
				proc.close();

				proc = conn.prepareCall("{call P_AIR_SITE_HOUR_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				proc.setString(1, getString(tempObject.get("WDIRECT")));
				//站点所在县市
				proc.setString(2, station.getStr("address"));
				proc.setString(3, "正常");
				//降雨量
				proc.setString(4, "");
				proc.setString(5, getString(tempObject.get("STATIONID")));
				proc.setString(6, getString(tempObject.get("WSPEED")));
				proc.setString(7, getString(tempObject.get("STATIONID")));
				proc.setString(8, "漳州市");
				proc.setString(9, getString(tempObject.get("TEMPERATURE")));
				proc.setString(10, getString(tempObject.get("APRESS")));
				proc.setString(11, station.getStr("name"));
				proc.setString(12, getString(tempObject.get("HUMIDITY")));
				proc.setTimestamp(13, getTimestamp(tempObject.get("RECEIVETIME")));
				proc.addBatch();
				proc.executeBatch();
				conn.commit();
				proc.clearBatch();
				proc.close();

			}
			if(dataArray.size()==500) {
				getData(maxid,conn,proc,endpoint);
			}
		}
		return maxid;

	}

	private BigDecimal getNumber(Object object) {
		if (!object.equals(JSONNull.NULL)) {
			return new BigDecimal(object.toString());
		}
		return null;
	}

	private Timestamp getTimestamp(Object object) {
		if (!object.equals(JSONNull.NULL)) {
			try {
				return new java.sql.Timestamp(format.parse(object.toString()).getTime());
			} catch (ParseException e) {
				return null;
			}
		}
		return null;
	}

	private String getString(Object object) {
		if (!object.equals(JSONNull.NULL)) {
			return object.toString();
		}
		return "";
	}

	private Long getLong(Object object) {
		if (!object.equals(JSONNull.NULL)) {
			return Long.valueOf(object.toString());
		}
		return null;
	}

	private Integer getInt(Object object) {
		if (!object.equals(JSONNull.NULL)) {
			return  Double.valueOf(object.toString()).intValue();
		}
		return null;
	}

	/***
	 * 
	 * @Title:  getStationInfo
	 * @Description:    根据ID获取该监测点的名称和地址   
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年5月30日 下午2:02:37
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年5月30日 下午2:02:37    
	 * @param pointId
	 * @return  JSONObject 
	 * @throws
	 */
	private static JSONObject getStationInfo(String stationId) {
		JSONObject object = new JSONObject();
		switch (stationId) {
		case "17015":
			object.put("name", "龙文环保局 2179");
			object.put("address", "龙文区");
			break;
		case "17077":
			object.put("name", "金峰管委会 916");
			object.put("address", "龙文区");
			break;
		case "17100":
			object.put("name", "科华公司 2161");
			object.put("address", "龙文区");
			break;
		case "17106":
			object.put("name", "漳州立人学校 2160");
			object.put("address", "龙文区");
			break;
		case "17281":
			object.put("name", "角美镇政府 942");
			object.put("address", "龙文区");
			break;
		case "17359":
			object.put("name", "漳州党校 2165");
			object.put("address", "芗城区");
			break;
		case "17362":
			object.put("name", "漳州三中 2196");
			object.put("address", "芗城区");
			break;
		case "17364":
			object.put("name", "郭坑中学 2155");
			object.put("address", "龙文区");
			break;
		case "17690":
			object.put("name", "朝阳中学 2126");
			object.put("address", "龙文区");
			break;
		case "17702":
			object.put("name", "漳州党校 2176");
			object.put("address", "芗城区");
			break;
		case "17720":
			object.put("name", "漳州党校 887");
			object.put("address", "芗城区");
			break;
		case "25249":
			object.put("name", "漳州党校 2189");
			object.put("address", "芗城区");
			break;
		case "25781":
			object.put("name", "漳州党校 917");
			object.put("address", "芗城区");
			break;
		default:
			object.put("name", "");
			object.put("address", "");
		}
		return object;
	}

}
