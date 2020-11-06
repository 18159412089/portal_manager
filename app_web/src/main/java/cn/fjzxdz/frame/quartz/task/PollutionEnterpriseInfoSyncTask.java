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

@Component("pollutionEnterpriseInfoSyncTask")
public class PollutionEnterpriseInfoSyncTask {

    private static Logger logger = LogManager.getLogger(PollutionEnterpriseInfoSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步污染源档案企业信息开始");
        String endpoint = env.getProperty("env.sync.endpoint");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
        JSONObject queryObject = new JSONObject();
        JSONObject pageObject = new JSONObject();
        pageObject.put("page", "1");
        pageObject.put("pageSize", "1000");
        queryObject.put("pager", pageObject);
		/*JSONArray paramArray = new JSONArray();
		JSONObject paramObject = new JSONObject();
		paramObject.put("Value", sdfDay.format(DateUtil.getAfterDayDate("-2"))+" 00:00:00");
		paramObject.put("FieldName", "CHECKTIME");//监测时间
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
		queryObject.put("params", paramArray);*/
        Connection conn = null;
        CallableStatement proc = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            conn.setAutoCommit(false);
            proc = conn.prepareCall("{call P_POLLUTION_ENTERPRISE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            getData(queryObject, conn, proc, endpoint);
        } catch (Exception e) {
            logger.info("同步污染源档案企业信息失败:" + e.getMessage());
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
        String result = (String) call.invoke(new Object[]{"8a1e8dbc5acc46bb015b60316b4b22cb", "3506", queryObject.toString()});
        // 给方法传递参数，并且调用方法
        JSONObject jsonObject = new JSONObject(result);
        if (jsonObject.getStr("data") == null
                || "".equals(jsonObject.getStr("data"))
                || "null".equals(jsonObject.getStr("data"))) {
            logger.info("同步污染源档案企业信息为空:" + result);
            return;
        }
        JSONArray dataArray = jsonObject.getJSONArray("data");
        if (dataArray != null && dataArray.size() > 0) {
            for (Object object : dataArray) {
                JSONObject tempObject = (JSONObject) object;
                proc.setString(1, getString(tempObject.get("CODE_ATTENTIONDEGREE")));
                proc.setString(2, getString(tempObject.get("ENTERCODE")));
                proc.setString(3, getString(tempObject.get("ENVINVESTMONEYTYPE")));
                proc.setString(4, getString(tempObject.get("CODE_ENTERTYPE")));
                proc.setString(5, getString(tempObject.get("PSENVIRONMENTDEPT")));
                proc.setString(6, getString(tempObject.get("CODE_UNITTYPECODE")));
                proc.setString(7, getString(tempObject.get("CREATETIME")));
                proc.setString(8, getString(tempObject.get("LATITUDE")));
                proc.setString(9, getString(tempObject.get("WEBSITE")));
                proc.setString(10, getString(tempObject.get("CODE_CONTROLLEVEL")));
                proc.setString(11, getString(tempObject.get("MONEYTYPE")));
                proc.setString(12, getString(tempObject.get("CODE_INDUSTRYAREANAME")));
                proc.setString(13, getString(tempObject.get("STANDENTERID")));
                proc.setString(14, getString(tempObject.get("POSTALCODE")));
                proc.setString(15, getString(tempObject.get("CODE_ENTERSIZE")));
                proc.setString(16, getString(tempObject.get("ENTERADDRESS")));
                proc.setString(17, getString(tempObject.get("ENTERNAME")));
                proc.setString(18, getString(tempObject.get("ENVIRONTEL")));
                proc.setString(19, getString(tempObject.get("BANKNAME")));
                proc.setString(20, getString(tempObject.get("EMAIL")));
                proc.setString(21, getString(tempObject.get("ENVIRONPHONE")));
                proc.setString(22, getString(tempObject.get("CORPCODE")));
                proc.setString(23, getString(tempObject.get("HISTORYENTERNAME")));
                proc.setString(24, getString(tempObject.get("ENVIRONINVEST")));
                proc.setString(25, getString(tempObject.get("FAX")));
                proc.setString(26, getString(tempObject.get("ENVIRONMENTMANS")));
                proc.setString(27, getString(tempObject.get("BANKCODE")));
                proc.setString(28, getString(tempObject.get("COMPANYNAME")));
                proc.setString(29, getString(tempObject.get("COMMUNICATEADDR")));
                proc.setString(30, getString(tempObject.get("TRADE")));
                proc.setString(31, getString(tempObject.get("DUTYPERSON")));
                proc.setString(32, getString(tempObject.get("ENVIRONLINKMEN")));
                proc.setString(33, getString(tempObject.get("REGIONNAME")));
                proc.setString(34, getString(tempObject.get("TELEPHONE")));
                proc.setString(35, getString(tempObject.get("TOTALINVEST")));
                proc.setString(36, getString(tempObject.get("CODE_TRADE")));
                proc.setString(37, getString(tempObject.get("CODE_REGION")));
                proc.setString(38, getString(tempObject.get("CORPNAME")));
                proc.setString(39, getString(tempObject.get("CODE_REGISTERTYPE")));
                proc.setString(40, getString(tempObject.get("LINKMAN")));
                proc.setString(41, getString(tempObject.get("CODE_ENTERRELATION")));
                proc.setString(42, getString(tempObject.get("SHORTNAME")));
                proc.setString(43, getString(tempObject.get("CODE_QUALIFICATION")));
                proc.setString(44, getString(tempObject.get("LONGITUDE")));
                proc.setString(45, getString(tempObject.get("WSYSTEM")));
                proc.setString(46, getString(tempObject.get("ENVIRONFAX")));
                proc.setString(47, getString(tempObject.get("CODE_WSYSTEM")));
                proc.setTimestamp(48, getTimestamp(tempObject.get("UPDATETIME")));
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
