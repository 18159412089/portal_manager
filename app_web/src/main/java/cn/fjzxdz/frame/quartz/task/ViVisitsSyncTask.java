package cn.fjzxdz.frame.quartz.task;


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

@Component("viVisitsSyncTask")
public class ViVisitsSyncTask {

    private static Logger logger = LogManager.getLogger(ViVisitsSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步信访投诉开始");
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
		/*paramObject.put("Value", sdfDay.format(DateUtil.getAfterDayDate("-2"))+" 00:00:00");
		paramObject.put("FieldName", "UPDATETIME_RJWA");
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
		queryObject.put("params", paramArray);*/
        Connection conn = null;
        CallableStatement proc = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            conn.setAutoCommit(false);
            proc = conn.prepareCall("{call P_VI_VISITS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            getData(queryObject, conn, proc, endpoint);
        } catch (Exception e) {
            logger.info("同步信访投诉失败:" + e.getMessage());
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
        String result = (String) call.invoke(new Object[]{"8a1e8dbc5b66b092015bccf96ee75194", "3506", queryObject.toString()});
        // 给方法传递参数，并且调用方法
        JSONObject jsonObject = new JSONObject(result);
        if (jsonObject.getStr("data") == null
                || "".equals(jsonObject.getStr("data"))
                || "null".equals(jsonObject.getStr("data"))) {
            logger.info("同步信访投诉数据为空:" + result);
            return;
        }
        JSONArray dataArray = jsonObject.getJSONArray("data");
        if (dataArray != null && dataArray.size() > 0) {
            for (Object object : dataArray) {
                JSONObject tempObject = (JSONObject) object;
                proc.setString(1, getString(tempObject.get("ISFIGHT")));
                proc.setString(2, getString(tempObject.get("HANLDTYPE")));
                proc.setString(3, getString(tempObject.get("PETITIONTIME")));
                proc.setString(4, getString(tempObject.get("NOTACCEPTREASON")));
                proc.setString(5, getString(tempObject.get("UPDATETIME_RJWA")));
                proc.setString(6, getString(tempObject.get("FEEDBACKSTATUS")));
                proc.setString(7, getString(tempObject.get("LETTERCODE")));
                proc.setString(8, getString(tempObject.get("POLLUTIONTYPE")));
                proc.setString(9, getString(tempObject.get("INDUSTRYTYPE")));
                proc.setString(10, getString(tempObject.get("ATTRIBUTE")));
                proc.setString(11, getString(tempObject.get("SOURCE")));
                proc.setString(12, getString(tempObject.get("POLLUTIONCOUNTY")));
                proc.setString(13, getString(tempObject.get("PETITIONER")));
                proc.setString(14, getString(tempObject.get("ISREPEAT")));
                proc.setString(15, getString(tempObject.get("PETITIONACCEPTPERSON")));
                proc.setString(16, getString(tempObject.get("EVENTADDR")));
                proc.setString(17, getString(tempObject.get("PETICONTENT")));
                proc.setString(18, getString(tempObject.get("ISACCEPT")));
                proc.setString(19, getString(tempObject.get("INSERTTIME")));
                proc.setString(20, getString(tempObject.get("PETITIONERADDR")));
                proc.setString(21, getString(tempObject.get("PETIID")));
                proc.setString(22, getString(tempObject.get("POLLUTIONCITY")));
                proc.setString(23, getString(tempObject.get("ISVALID")));
                proc.setString(24, getString(tempObject.get("MANAGEMENTPERIOD")));
                proc.setString(25, getString(tempObject.get("PENAME")));
                proc.setString(26, getString(tempObject.get("PEADDR")));
                proc.setString(27, getString(tempObject.get("RESOURCEL")));
                proc.setString(28, getString(tempObject.get("PETITIONERTEL")));
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
