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

@Component("radXRayAccountSyncTask")
public class RadXRayAccountSyncTask {

    private static Logger logger = LogManager.getLogger(RadXRayAccountSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步射线装置台账开始");
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
		paramObject.put("Value", sdfDay.format(DateUtil.getAfterDayDate("-2"))+" 00:00:00");
		paramObject.put("FieldName", "UPDATETIME_RJWA");
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
		queryObject.put("params", paramArray);
		Connection  conn=null;
		CallableStatement proc=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			proc = conn.prepareCall("{call P_RAD_X_RAY_ACCOUNT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			getData(queryObject,conn,proc,endpoint);
		} catch (Exception e) {
			logger.info("同步射线装置台账失败:"+e.getMessage());
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
		String result = (String) call.invoke(new Object[] { "8a1e8dbc5b66b092015bd790813d61e0","3506",queryObject.toString() });
		// 给方法传递参数，并且调用方法
		JSONObject jsonObject = new JSONObject(result);
        if (jsonObject.getStr("data") == null
                || "".equals(jsonObject.getStr("data"))
                || "null".equals(jsonObject.getStr("data"))) {
            logger.info("同步射线装置台账为空:" + result);
            return;
        }
		JSONArray dataArray = jsonObject.getJSONArray("data");
		if(dataArray!=null&&dataArray.size()>0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setString(1, getString(tempObject.get("ENTERID")));
				proc.setString(2, getString(tempObject.get("ZZLX")));
				proc.setString(3, getString(tempObject.get("SHR")));
				proc.setString(4, getString(tempObject.get("LY")));
				proc.setString(5, getString(tempObject.get("CS")));
				proc.setString(6, getString(tempObject.get("PKID")));
				proc.setString(7, getString(tempObject.get("GGXH")));
				proc.setString(8, getString(tempObject.get("UPDATETIME_RJWA")));
				proc.setString(9, getString(tempObject.get("SHRQ")));
				proc.setString(10, getString(tempObject.get("QXSHRQ")));
				proc.setString(11, getString(tempObject.get("BZ")));
				proc.setString(12, getString(tempObject.get("DY")));
				proc.setString(13, getString(tempObject.get("QXSHR")));
				proc.setString(14, getString(tempObject.get("QX")));
				proc.setString(15, getString(tempObject.get("DL")));
				proc.setString(16, getString(tempObject.get("SFLSTZ")));
				proc.setString(17, getString(tempObject.get("GL")));
				proc.setString(18, getString(tempObject.get("ZZMC")));
				proc.setString(19, getString(tempObject.get("YT")));
				proc.addBatch();
			}
			proc.executeBatch();
			conn.commit();
			proc.clearBatch();
		}
		Integer page = queryObject.getJSONObject("pager").getInt("page");
		Integer pageSize = queryObject.getJSONObject("pager").getInt("pageSize");
		Integer total = jsonObject.getJSONObject("head").getInt("total");
		if(page*pageSize<total) {
			queryObject.getJSONObject("pager").put("page", page+1);
			getData(queryObject,conn,proc,endpoint);
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
