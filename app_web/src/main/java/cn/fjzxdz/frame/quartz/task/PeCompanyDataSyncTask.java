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

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("peCompanyDataSyncTask")
public class PeCompanyDataSyncTask {

    private static Logger logger = LogManager.getLogger(PeCompanyDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步污染源企业信息开始");
        String endpoint = env.getProperty("env.sync.endpoint");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
    	JSONObject queryObject = new JSONObject();
		JSONObject pageObject = new JSONObject();
		pageObject.put("page", "1");
		pageObject.put("pageSize", "1000");
		queryObject.put("pager", pageObject);
//		JSONArray paramArray = new JSONArray();
//		JSONObject paramObject = new JSONObject();
//		paramObject.put("Value", "2019-01-16 00:00:00");
//		paramObject.put("FieldName", "MONITORTIME");
//		paramObject.put("Operator", ">=");
//		paramArray.add(paramObject);
//		queryObject.put("params", paramArray);
		Connection  conn=null;
		CallableStatement proc=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			proc = conn.prepareCall("{call P_PE_ENTERPRISE_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			getData(queryObject,conn,proc,endpoint);
		} catch (Exception e) {
			logger.info("同步污染源企业信息失败:"+e.getMessage());
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
		String result = (String) call.invoke(new Object[] { "40288389623c746a01624293f8c00489","3506",queryObject.toString() });  
		// 给方法传递参数，并且调用方法  
		System.out.println("========="+result);
		JSONObject jsonObject = new JSONObject(result);
		JSONArray dataArray = !jsonObject.get("data").equals(JSONNull.NULL)?jsonObject.getJSONArray("data"):null;
		if(dataArray!=null&&dataArray.size()>0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setBigDecimal(1, getNumber(tempObject.get("PE_ID")));
				proc.setString(2, getString(tempObject.get("PE_CODE")));
				proc.setString(3, getString(tempObject.get("PE_NAME")));
				proc.setString(4, getString(tempObject.get("ORG_CODE")));
				proc.setString(5, getString(tempObject.get("UNIT_TYPE_CODE")));
				proc.setString(6, getString(tempObject.get("SIZE_CODE")));
				proc.setString(7, getString(tempObject.get("HAVING_NAME")));
				proc.setString(8, getString(tempObject.get("TRADE_CODE")));
				proc.setString(9, getString(tempObject.get("RIVER_CODE")));
				proc.setString(10, getString(tempObject.get("ADDRESS")));
				proc.setString(11, getString(tempObject.get("LAW_CODE")));
				proc.setString(12, getString(tempObject.get("LAW_AGENCY")));
				proc.setBigDecimal(13, getNumber(tempObject.get("LONG_VALUE")));
				proc.setBigDecimal(14, getNumber(tempObject.get("LAT_VALUE")));
				proc.setTimestamp(15, getTimestamp(tempObject.get("START_DATE")));
				proc.setString(16, getString(tempObject.get("EMAIL")));
				proc.setString(17, getString(tempObject.get("MAIL_ADDRESS")));
				proc.setString(18, getString(tempObject.get("ZIP_CODE")));
				proc.setString(19, getString(tempObject.get("ENV_PRINCIPAL")));
				proc.setString(20, getString(tempObject.get("TEL")));
				proc.setString(21, getString(tempObject.get("FAX")));
				proc.setString(22, getString(tempObject.get("MOBILE")));
				proc.setString(23, getString(tempObject.get("CUR_STATUS")));
				proc.setString(24, getString(tempObject.get("PRODUCTION")));
				proc.setString(25, getString(tempObject.get("PE_TYPE")));
				proc.setString(26, getString(tempObject.get("STATUS")));
				proc.setString(27, getString(tempObject.get("CONTACT")));
				proc.setString(28, getString(tempObject.get("POLLUTION_CONTROL")));
				proc.setString(29, getString(tempObject.get("OTHERS")));
				proc.setTimestamp(30, getTimestamp(tempObject.get("UPDATE_TIME")));
				proc.setTimestamp(31, getTimestamp(tempObject.get("INSERT_TIME")));
				proc.setString(32, getString(tempObject.get("GAS_TYPE")));
				proc.setString(33, getString(tempObject.get("WATER_TYPE")));
				proc.setString(34, getString(tempObject.get("RGN_CODE")));
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
