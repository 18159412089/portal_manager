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

@Component("pePointDataSyncTask")
public class PePointDataSyncTask {

    private static Logger logger = LogManager.getLogger(PePointDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步污染源监测点位数据开始");
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
			proc = conn.prepareCall("{call P_PE_MONITOR_POINT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			getData(queryObject,conn,proc,endpoint);
		} catch (Exception e) {
			logger.info("同步污染源监测点位数据失败:"+e.getMessage());
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
		String result = (String) call.invoke(new Object[] { "40288389623c746a01624251617601e5","3506",queryObject.toString() });  
		// 给方法传递参数，并且调用方法  
		JSONObject jsonObject = new JSONObject(result);
		JSONArray dataArray = !jsonObject.get("data").equals(JSONNull.NULL)?jsonObject.getJSONArray("data"):null;
		if(dataArray!=null&&dataArray.size()>0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setBigDecimal(1, getNumber(tempObject.get("OUTPUT_ID")));
				proc.setString(2, getString(tempObject.get("OUTFALL_TYPE")));
				proc.setString(3, getString(tempObject.get("CODE")));
				proc.setString(4, getString(tempObject.get("NAME")));
				proc.setString(5, getString(tempObject.get("POS_")));
				proc.setString(6, getString(tempObject.get("GAF_TYPE_CODE")));
				proc.setString(7, getString(tempObject.get("GOR_CODE")));
				proc.setString(8, getString(tempObject.get("FUEL_CODE")));
				proc.setString(9, getString(tempObject.get("BURN_CODE")));
				proc.setString(10, getString(tempObject.get("SYMBOL_STYLE")));
				proc.setBigDecimal(11, getNumber(tempObject.get("PE_ID")));
				proc.setBigDecimal(12, getNumber(tempObject.get("SEQ_NO")));
				proc.setString(13, getString(tempObject.get("LICENCE_CODE")));
				proc.setBigDecimal(14, getNumber(tempObject.get("ALLOW_PLU_LET")));
				proc.setString(15, getString(tempObject.get("STATUS")));
				proc.setString(16, getString(tempObject.get("HIDDEN_OUTPUT")));
				proc.setBigDecimal(17, getNumber(tempObject.get("ISEXPORT")));
				proc.setString(18, getString(tempObject.get("STOCK_SHOW")));
				proc.setBigDecimal(19, getNumber(tempObject.get("LONGITUDE")));
				proc.setBigDecimal(20, getNumber(tempObject.get("LATITUDE")));
				proc.setBigDecimal(21, getNumber(tempObject.get("AIR_COEFFICIENT")));
				proc.setString(22, getString(tempObject.get("SINGLE_OUTPUT")));
				proc.setString(23, getString(tempObject.get("BOILER_TYPE")));
				proc.setString(24, getString(tempObject.get("CSN")));
				proc.setString(25, getString(tempObject.get("PWD")));
				proc.setString(26, getString(tempObject.get("IP_ADDRESS")));
				proc.setBigDecimal(27, getNumber(tempObject.get("PORT")));
				proc.setBigDecimal(28, getNumber(tempObject.get("CYC")));
				proc.setString(29, getString(tempObject.get("PRODUCT")));
				proc.setString(30, getString(tempObject.get("CONTACT")));
				proc.setString(31, getString(tempObject.get("CONTACT_NUM")));
				proc.setString(32, getString(tempObject.get("IS_PUT_DAILY")));
				proc.setString(33, getString(tempObject.get("IS_PUT_HOUR")));
				proc.setString(34, getString(tempObject.get("IS_PUT_MIN")));
				proc.setString(35, getString(tempObject.get("UP_TRAN")));
				proc.setString(36, getString(tempObject.get("DOWN_TRAN")));
				proc.setString(37, getString(tempObject.get("ETONG_TRAN")));
				proc.setBigDecimal(38, getNumber(tempObject.get("UNIT_TRANSLATE")));
				proc.setTimestamp(39, getTimestamp(tempObject.get("UPDATE_TIME")));
				proc.setBigDecimal(40, getNumber(tempObject.get("UPDATE_USER_ID")));
				proc.setTimestamp(41, getTimestamp(tempObject.get("INSERT_TIME")));
				proc.setBigDecimal(42, getNumber(tempObject.get("INSERT_USER_ID")));
				proc.setString(43, getString(tempObject.get("RIVER_")));
				proc.setString(44, getString(tempObject.get("DIRECTION")));
				proc.setBigDecimal(45, getNumber(tempObject.get("OPERATOR")));
				proc.setString(46, getString(tempObject.get("IS_PROVINCE_CONCERNED")));
				proc.setString(47, getString(tempObject.get("REPORT_STOP")));
				proc.setString(48, getString(tempObject.get("ENABLE_STATUS")));
				proc.setString(49, getString(tempObject.get("SITE_TYPE")));
				proc.setBigDecimal(50, getNumber(tempObject.get("ACTUAL_DAILY_CAPACITY")));
				proc.setTimestamp(51, getTimestamp(tempObject.get("FIRST_UPLOAD_DATA")));
				proc.setString(52, getString(tempObject.get("IS_CITY_CONCERNED")));
				proc.setString(53, getString(tempObject.get("IS_AREA_CONCERNED")));
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
