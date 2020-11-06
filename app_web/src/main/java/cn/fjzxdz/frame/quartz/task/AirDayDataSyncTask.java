package cn.fjzxdz.frame.quartz.task;


import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("airDayDataSyncTask")
public class AirDayDataSyncTask {

    private static Logger logger = LogManager.getLogger(AirDayDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步空气日数据开始");
        String endpoint = env.getProperty("env.sync.endpoint");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
        JSONObject queryObject = new JSONObject();
        JSONObject pageObject = new JSONObject();
        pageObject.put("page", "1");
        pageObject.put("pageSize", "1000");
        queryObject.put("pager", pageObject);
        JSONArray paramArray = new JSONArray();
        JSONObject paramObject = new JSONObject();
        paramObject.put("Value", sdfDay.format(DateUtil.getAfterDayDate("-2")) + " 00:00:00");
        paramObject.put("FieldName", "MONITORTIME");
        paramObject.put("Operator", ">=");
        paramArray.add(paramObject);
        queryObject.put("params", paramArray);
        Connection conn = null;
        CallableStatement proc = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            conn.setAutoCommit(false);
            proc = conn.prepareCall("{call P_AIR_DAY_DATA(?,?,?,?,?,?,?,?,?,?,?,?)}");
            getData(queryObject, conn, proc, endpoint);
        } catch (Exception e) {
            logger.info("同步空气日数据失败:" + e.getMessage());
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

    private void getData(JSONObject queryObject, Connection conn, CallableStatement proc, String endpoint) throws Exception {
        Service service = new Service();
        Call call = (Call) service.createCall();
        call.setTargetEndpointAddress(endpoint);
        // WSDL里面描述的接口名称
        call.setOperationName("RunJsonResult");
        // 接口的参数
        call.addParameter("in0",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);
        // 接口的参数
        call.addParameter("in1",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);
        // 接口的参数
        call.addParameter("in2",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);
        // 设置返回类型
        call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
        String result = (String) call.invoke(new Object[]{"4028838963ca04410163fcfda63657d3", "3506", queryObject.toString()});
        // 给方法传递参数，并且调用方法
        JSONObject jsonObject = new JSONObject(result);
        JSONArray dataArray = jsonObject.getJSONArray("data");
        if (dataArray != null && dataArray.size() > 0) {
            for (Object object : dataArray) {
                JSONObject tempObject = (JSONObject) object;
                proc.setString(1, getString(tempObject.get("PKID")));
                proc.setTimestamp(2, getTimestamp(tempObject.get("MONITORTIME")));
                proc.setString(3, getString(tempObject.get("CODE_REGION")));
                proc.setString(4, getString(tempObject.get("REGIONNAME")));
                proc.setString(5, getString(tempObject.get("POINTCODE")));
                proc.setString(6, getString(tempObject.get("POINTNAME")));
                proc.setString(7, getString(tempObject.get("CODE_POLLUTE")));
                proc.setString(8, getString(tempObject.get("POLLUTENAME")));
                proc.setBigDecimal(9, getNumber(tempObject.get("AVERVALUE")));
                proc.setString(10, getString(tempObject.get("AVERVALUESTRING")));
                proc.setTimestamp(11, getTimestamp(tempObject.get("UPDATETIME")));
                proc.setBigDecimal(12, getNumber(tempObject.get("AQI")));
                proc.addBatch();
            }
            proc.executeBatch();
            conn.commit();
            proc.clearBatch();
        }
        Integer page = queryObject.getJSONObject("pager").getInt("page");
        Integer pageSize = queryObject.getJSONObject("pager").getInt("pageSize");
        Integer total = jsonObject.getJSONObject("head").getInt("total");
        if (page * pageSize < total) {
            queryObject.getJSONObject("pager").put("page", page + 1);
            getData(queryObject, conn, proc, endpoint);
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
                return new java.sql.Timestamp(sdfTime.parse(object.toString()).getTime());
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


}
