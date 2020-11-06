package cn.fjzxdz.frame.quartz.task;


import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.redis.RedisUtils;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("peDayConcentrationDataSyncTask")
public class PeDayConcentrationDataSyncTask {

    private static Logger logger = LogManager.getLogger(PeDayConcentrationDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    @Autowired
    private Environment env;
    @Autowired
    private RedisUtils redisUtils;

    public void syncData() throws Exception {
        logger.info("同步污染源日浓度监测数据开始");
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
//		String nowTime = sdfTime.format(new Date());
//		String startTime = redisUtils.get("sync:peDayConcentrationData")==null?sdfTime.format(DateUtil.addDate(new Date(), -10)):redisUtils.get("sync:peDayConcentrationData");
		paramObject.put("Value", sdfTime.format(DateUtil.addDate(new Date(), -3)));
		paramObject.put("FieldName", "MEASURE_TIME");
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
//		JSONObject paramObject2 = new JSONObject();
//		paramObject2.put("Value", nowTime);
//		paramObject2.put("FieldName", "INSERT_TIME");
//		paramObject2.put("Operator", "<=");
//		paramArray.add(paramObject2);
		queryObject.put("params", paramArray);
		Connection  conn=null;
		CallableStatement proc=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			proc = conn.prepareCall("{call P_PE_CON_DAY_DATA(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			getData(queryObject,conn,proc,endpoint);
//			redisUtils.set("sync:peDayConcentrationData", nowTime,-1);
		} catch (Exception e) {
			logger.info("同步污染源日浓度监测数据失败:"+e.getMessage());
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
		String result = (String) call.invoke(new Object[] { "40288389623c746a0162426c079e0314","3506",queryObject.toString() });  
		// 给方法传递参数，并且调用方法  
		JSONObject jsonObject = new JSONObject(result);
		JSONArray dataArray = !jsonObject.get("data").equals(JSONNull.NULL)?jsonObject.getJSONArray("data"):null;
		if(dataArray!=null&&dataArray.size()>0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setBigDecimal(1, getNumber(tempObject.get("PE_ID")));
				proc.setBigDecimal(2, getNumber(tempObject.get("OUTPUT_ID")));
				proc.setTimestamp(3, getTimestamp(tempObject.get("MEASURE_TIME")));
				proc.setString(4, getString(tempObject.get("PLU_CODE")));
				proc.setBigDecimal(5, getNumber(tempObject.get("CHROMA_MIN")));
				proc.setBigDecimal(6, getNumber(tempObject.get("CHROMA_AVG")));
				proc.setBigDecimal(7, getNumber(tempObject.get("CHROMA_MAX")));
				proc.setBigDecimal(8, getNumber(tempObject.get("OUTPUT_MIN")));
				proc.setBigDecimal(9, getNumber(tempObject.get("OUTPUT_AVG")));
				proc.setBigDecimal(10, getNumber(tempObject.get("OUTPUT_MAX")));
				proc.setString(11, getString(tempObject.get("OUTFALL_TYPE")));
				proc.setString(12, getString(tempObject.get("IS_MEASURE")));
				proc.setTimestamp(13, getTimestamp(tempObject.get("INSERT_TIME")));
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
