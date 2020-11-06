package com.fjzxdz.ams.task;


import cn.fjzxdz.frame.toolbox.util.NumberUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONNull;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @author Administrator
 */
@Component
@Configurable
@EnableScheduling
public class PollutionMonitorMinDataSyncTask {

    private static Logger logger = LogManager.getLogger(PollutionMonitorMinDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Value("${pollution.monitor:null}")
    private String monitor;

    //每10分钟执行一次
    @Scheduled(cron = "0 */10 * * * ?")
    public void syncData() throws Exception {
        if ("null".equals(monitor)) {
            return;
        }
        logger.info("污染源数据同步空气数据开始");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
        Connection conn = null;
        CallableStatement proc = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            conn.setAutoCommit(false);
            proc = conn.prepareCall("{call P_POLLUTION_MONITOR_MIN_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            getData(conn, proc);
        } catch (Exception e) {
            logger.info("污染源数据同步空气数据开始:" + e.getMessage());
            throw e;
        } finally {
            if (proc != null) {
                proc.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    private void getData(Connection conn, CallableStatement proc) throws Exception {
        String url = "http://222.78.9.186:4502/DataAPI.ashx?api=api.crlib.lastdata&ver=1.0&data={%22uname%22:%22dsj%22,%22pwd%22:%22e10adc3949ba59abbe56e057f20f883e%22}";
        String s = HttpUtil.get(url);
        JSONArray dataArray = (JSONArray) JSONArray.parse(s);
        if (dataArray != null && dataArray.size() > 0) {
            for (Object object : dataArray) {
                JSONObject tempObject = (JSONObject) object;
                proc.setString(1, getString(tempObject.get("EP_Code")));
                proc.setString(2, getString(tempObject.get("EP_Name")));
                proc.setString(3, getString(tempObject.get("StationCode")));
                proc.setString(4, getString(tempObject.get("StationSubName")));
                proc.setString(5, getString(tempObject.get("TargetCode")));
                proc.setString(6, getString(tempObject.get("CNName")));
                proc.setTimestamp(7, getTimestamp(getString(tempObject.get("DataTime")).replace("T", " ")));
                proc.setString(8, getString(tempObject.get("AvgVal")));
                proc.setString(9, getString(tempObject.get("ZsAvgVal")));
                proc.setString(10, getString(tempObject.get("D_Overproof")));
                proc.setString(11, getString(tempObject.get("U_Overproof")));
                proc.setString(12, getString(tempObject.get("Precision")));
                proc.setString(13, getString(tempObject.get("DataUnit")));
                String ISOVER = isOver(getString(tempObject.get("AvgVal")), getString(tempObject.get("U_Overproof")), getString(tempObject.get("D_Overproof")));
                proc.setString(14, ISOVER);
                proc.addBatch();
               //updateOverFlag(ISOVER, getString(tempObject.get("StationCode")));
            }
            proc.executeBatch();
            conn.commit();
            proc.clearBatch();
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
                return new Timestamp(sdfTime.parse(object.toString()).getTime());
            } catch (ParseException e) {
                return null;
            }
        }
        return null;
    }


    private String getString(Object object) {
        if (object != null && !object.equals(JSONNull.NULL)) {
            return object.toString();
        }
        return "";
    }

    private String isOver(String AvgVal, String U_Overproof, String D_Overproof) {
        String isOver = "false";
        if (NumberUtil.isNumber(AvgVal) && NumberUtil.isNumber(U_Overproof) && NumberUtil.isNumber(D_Overproof)) {
            if (NumberUtil.toDouble(AvgVal) < NumberUtil.toDouble(D_Overproof) || NumberUtil.toDouble(AvgVal) > NumberUtil.toDouble(U_Overproof)) {
                isOver = "true";
            }
        }
        return isOver;
    }

    private void updateOverFlag(String ISOVER, String code) {
        //Map<String, Object> stringObjectMap = jdbcTemplate.queryForMap("select  * from ZP_POLLUTION_MONITOR_POINT where code =" + code);
        //System.out.println(stringObjectMap);
        jdbcTemplate.update("update ZP_POLLUTION_MONITOR_POINT set ISOVER = '" + ISOVER + "' where code =" + code);
    }


    public static void main(String[] args) throws Exception {
        /*String url = "http://222.78.9.186:4502/DataAPI.ashx?api=api.crlib.lastdata&ver=1.0&data={%22uname%22:%22dsj%22,%22pwd%22:%22e10adc3949ba59abbe56e057f20f883e%22}";
        String s = HttpUtil.get(url);
        JSONArray dataArray = (JSONArray) JSONArray.parse(s);
        System.out.println(dataArray);*/
        PollutionMonitorMinDataSyncTask pollutionMonitorMinDataSyncTask = new PollutionMonitorMinDataSyncTask();
        pollutionMonitorMinDataSyncTask.syncData();

    }

}
