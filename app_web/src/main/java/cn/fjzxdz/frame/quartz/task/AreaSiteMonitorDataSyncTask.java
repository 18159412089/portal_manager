package cn.fjzxdz.frame.quartz.task;


import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@Component("areaSiteMonitorDataSyncTask")
public class AreaSiteMonitorDataSyncTask {

    private static Logger logger = LogManager.getLogger(AreaSiteMonitorDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步近岸海域监测数据开始");
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
        paramObject.put("FieldName", "CHECKTIME");//监测时间
        paramObject.put("Operator", ">=");
        paramArray.add(paramObject);
        queryObject.put("params", paramArray);
        Connection conn = null;
        CallableStatement proc = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            conn.setAutoCommit(false);
            proc = conn.prepareCall("{call P_AREA_SITE_MONITOR_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            getData(queryObject, conn, proc, endpoint);
        } catch (Exception e) {
            logger.info("同步近岸海域监测数据失败:" + e.getMessage());
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
        call.setOperationName("RunJsonResult");// WSDL里面描述的接口名称
        call.addParameter("in0",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);// 接口的参数
        call.addParameter("in1",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);// 接口的参数
        call.addParameter("in2",
                org.apache.axis.encoding.XMLType.XSD_STRING,
                javax.xml.rpc.ParameterMode.IN);// 接口的参数
        call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);// 设置返回类型
        String result = (String) call.invoke(new Object[]{"40288389632efb630163b51d512e4c63", "3506", queryObject.toString()});
        // 给方法传递参数，并且调用方法
        JSONObject jsonObject = new JSONObject(result);
        if (jsonObject.getStr("data") == null
                || "".equals(jsonObject.getStr("data"))
                || "null".equals(jsonObject.getStr("data"))) {
            logger.info("同步近岸海域监测数据为空:" + result);
            return;
        }
        JSONArray dataArray = jsonObject.getJSONArray("data");
        if (dataArray != null && dataArray.size() > 0) {
            for (Object object : dataArray) {
                JSONObject tempObject = (JSONObject) object;
                proc.setBigDecimal(1, getNumber(tempObject.get("BBP")));
                proc.setBigDecimal(2, getNumber(tempObject.get("DISSOLVED_O2")));
                proc.setBigDecimal(3, getNumber(tempObject.get("MLLL")));
                proc.setBigDecimal(4, getNumber(tempObject.get("HXG")));
                proc.setString(5, getString(tempObject.get("GNLB")));
                proc.setBigDecimal(6, getNumber(tempObject.get("YJLP")));
                proc.setBigDecimal(7, getNumber(tempObject.get("QW")));
                proc.setString(8, getString(tempObject.get("GK_CODE")));
                proc.setBigDecimal(9, getNumber(tempObject.get("ZN")));
                proc.setBigDecimal(10, getNumber(tempObject.get("ME")));
                proc.setBigDecimal(11, getNumber(tempObject.get("YJL")));
                proc.setBigDecimal(12, getNumber(tempObject.get("FLZA")));
                proc.setBigDecimal(13, getNumber(tempObject.get("COD")));
                proc.setString(14, getString(tempObject.get("STATION_NAME")));
                proc.setBigDecimal(15, getNumber(tempObject.get("ZL")));
                proc.setTimestamp(16, getTimestamp(tempObject.get("JCSJ")));
                proc.setBigDecimal(17, getNumber(tempObject.get("YJD")));
                proc.setBigDecimal(18, getNumber(tempObject.get("SYL")));
                proc.setBigDecimal(19, getNumber(tempObject.get("WRSHXYL")));
                proc.setBigDecimal(20, getNumber(tempObject.get("QY")));
                proc.setString(21, getString(tempObject.get("SZMB")));
                proc.setBigDecimal(22, getNumber(tempObject.get("FE")));
                proc.setBigDecimal(23, getNumber(tempObject.get("DDD")));
                proc.setBigDecimal(24, getNumber(tempObject.get("XFW")));
                proc.setBigDecimal(25, getNumber(tempObject.get("YD")));
                proc.setBigDecimal(26, getNumber(tempObject.get("YJT")));
                proc.setBigDecimal(27, getNumber(tempObject.get("JJDLL")));
                proc.setBigDecimal(28, getNumber(tempObject.get("AD")));
                proc.setBigDecimal(29, getNumber(tempObject.get("NI")));
                proc.setBigDecimal(30, getNumber(tempObject.get("CHLOROPHYLL")));
                proc.setBigDecimal(31, getNumber(tempObject.get("TMD")));
                proc.setString(32, getString(tempObject.get("LBDM")));
                proc.setBigDecimal(33, getNumber(tempObject.get("YXSYD")));
                proc.setBigDecimal(34, getNumber(tempObject.get("LJG")));
                proc.setBigDecimal(35, getNumber(tempObject.get("HFF")));
                proc.setBigDecimal(36, getNumber(tempObject.get("DWJB")));
                proc.setBigDecimal(37, getNumber(tempObject.get("FX")));
                proc.setBigDecimal(38, getNumber(tempObject.get("FS")));
                proc.setBigDecimal(39, getNumber(tempObject.get("SS")));
                proc.setString(40, getString(tempObject.get("JCLX")));
                proc.setBigDecimal(41, getNumber(tempObject.get("FDCJQ")));
                proc.setBigDecimal(42, getNumber(tempObject.get("QHW")));
                proc.setBigDecimal(43, getNumber(tempObject.get("SW")));
                proc.setBigDecimal(44, getNumber(tempObject.get("DCJQ")));
                proc.setString(45, getString(tempObject.get("SK_CODE")));
                proc.setBigDecimal(46, getNumber(tempObject.get("HG")));
                proc.setBigDecimal(47, getNumber(tempObject.get("LHW")));
                proc.setString(48, getString(tempObject.get("CX")));
                proc.setBigDecimal(49, getNumber(tempObject.get("SE")));
                proc.setBigDecimal(50, getNumber(tempObject.get("CU")));
                proc.setBigDecimal(51, getNumber(tempObject.get("YLZ")));
                proc.setString(52, getString(tempObject.get("CS")));
                proc.setBigDecimal(53, getNumber(tempObject.get("SI")));
                proc.setString(54, getString(tempObject.get("CBXM")));
                proc.setString(55, getString(tempObject.get("TQMS")));
                proc.setBigDecimal(56, getNumber(tempObject.get("NO3N")));
                proc.setBigDecimal(57, getNumber(tempObject.get("HYL")));
                proc.setString(58, getString(tempObject.get("LB")));
                proc.setBigDecimal(59, getNumber(tempObject.get("PH")));
                proc.setString(60, getString(tempObject.get("SJMC")));
                proc.setBigDecimal(61, getNumber(tempObject.get("CD")));
                proc.setBigDecimal(62, getNumber(tempObject.get("CYSS")));
                proc.setString(63, getString(tempObject.get("SQDM")));
                proc.setBigDecimal(64, getNumber(tempObject.get("PB")));
                proc.setBigDecimal(65, getNumber(tempObject.get("LLL")));
                proc.setString(66, getString(tempObject.get("AS_DWJB")));
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
            if (object.toString().endsWith("L")) {
                return new BigDecimal(object.toString().trim().substring(0, object.toString().trim().length() - 1));
            }
            return new BigDecimal(object.toString().trim());
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
        if (!object.equals(JSONNull.NULL)) {
            return object.toString();
        }
        return "";
    }


}
