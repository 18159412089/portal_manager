package cn.fjzxdz.frame.quartz.task;

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
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.tempuri.IOtherDataService;
import org.tempuri.IOtherDataServiceProxy;

import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.redis.RedisUtils;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("airCityHourDataSyncTask")
public class AirCityHourDataSyncTask {

    private static Logger logger = LogManager.getLogger(AirCityHourDataSyncTask.class);
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;
    @Autowired
    private RedisUtils redisUtils;

    public void syncData() throws Exception {
        logger.info("同步自建站点空气小时数据开始");
        AirCityHourDataSyncTask task = new AirCityHourDataSyncTask();
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
            task.getData(maxid,conn,proc,endpoint);
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

    private void getData(Long maxid, Connection conn, CallableStatement proc, String endpoint) throws Exception {
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
            Aqi aqi;
            for (Object object : dataArray) {
                proc = conn.prepareCall("{call P_AIR_HOUR_DATA(?,?,?,?,?,?,?,?,?,?,?,?)}");
                JSONObject tempObject = (JSONObject) object;
                Long tempId = getLong(tempObject.get("ID"));
                maxid = maxid.compareTo(tempId) < 0 ? tempId : maxid;
                aqi = AqiUtil.CountAqi(getInt(tempObject.get("PM25")), getInt(tempObject.get("PM10")), getInt(tempObject.get("CO")),
                        getInt(tempObject.get("NO2")), getInt(tempObject.get("O3")), getInt(tempObject.get("SO2")));
                
                for (int i = 0; i < arr.length; i++) {
                    proc.setString(1, getString(UUID.randomUUID()));
                    proc.setTimestamp(2, getTimestamp(tempObject.get("RECEIVETIME")));
                    proc.setString(3, getString("350600000000"));
                    proc.setString(4, getString("漳州市"));
                    proc.setString(5, getString(tempObject.get("STATIONID")));
                    proc.setString(6, getString(tempObject.get("STATIONID"))); //站点名称
                    proc.setString(7, codes[i]);
                    proc.setString(8, names[i]);
                    proc.setBigDecimal(9, getNumber(tempObject.get(arr[i])));
                    proc.setString(10, getString(tempObject.get(arr[i])));
                    proc.setTimestamp(11, getTimestamp(tempObject.get("RECEIVETIME")));
                    proc.setBigDecimal(12, getNumber(aqi.getAqi()));
                    proc.addBatch();
                }
                proc.executeBatch();
                conn.commit();
                proc.clearBatch();
                proc.close();
                
                proc = conn.prepareCall("{call P_AIR_SITE_HOUR_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                proc.setString(1, getString(tempObject.get("WDIRECT")));
                proc.setString(2, getString(tempObject.get("STATIONID"))); //站点所在县市
                proc.setString(3, "正常");
                proc.setString(4, getString(tempObject.get("STATIONID")));
                proc.setString(5, getString(tempObject.get("STATIONID")));
                proc.setString(6, getString(tempObject.get("WSPEED")));
                proc.setString(7, getString(tempObject.get("STATIONID"))); //站点所在县市代码
                proc.setString(8, "漳州市");
                proc.setString(9, getString(tempObject.get("TEMPERATURE")));
                proc.setString(10, getString(tempObject.get("APRESS")));
                proc.setString(11, getString(tempObject.get("STATIONID")));
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
            return  Integer.valueOf(object.toString());
        }
        return null;
    }
    
}
