package cn.fjzxdz.frame.quartz.task;


import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.util.CodeUtil;
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.UUIDUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("wtMnHourDataSyncTask")
public class WtMnHourDataSyncTask {

    private static Logger logger = LogManager.getLogger(WtMnHourDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
    
    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步国家自动水检测小时数据开始");
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
		paramObject.put("Value", sdfTime.format(DateUtil.getAfterDayDate("-1")));
		paramObject.put("FieldName", "DATATIME");
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
		queryObject.put("params", paramArray);
		Connection  conn=null;
		CallableStatement proc=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			proc = conn.prepareCall("{call P_WT_CITY_HOUR_DATA(?,?,?,?,?,?,?)}");
			getData(queryObject,conn,proc,endpoint);
//			getDataReport(conn, pstmt, rs);
		} catch (Exception e) {
			logger.info("同步国家自动水检测小时数据失败:"+e.getMessage());
			throw e;
		} finally {
			if(proc!=null) {
				proc.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
			if(conn!=null) {
				conn.close();
			}
		}
    }
    
    private void getDataReport(Connection conn, PreparedStatement pstmt, ResultSet rs) throws Exception {
    	pstmt = (PreparedStatement) conn.prepareStatement("update wt_mn_hour_data set status=1 where datatime<=sysdate-10 and datatime>=sysdate-20 and status=0");
        pstmt.executeUpdate();
        pstmt.close();
        conn.commit();
    	pstmt = (PreparedStatement)conn.prepareStatement("select to_char(DATATIME,'yyyy-mm-dd hh24:mi:ss'),MN,MNNAME from WT_MN_HOUR_DATA where status=0 group by DATATIME,MN,MNNAME");
        rs = pstmt.executeQuery();
        List<String[]> list = new ArrayList<String[]>();
        while (rs.next()) {
        	String[] temparr = {rs.getString(1),rs.getString(2),rs.getString(3)}; 
        	list.add(temparr);
        }
        pstmt.close();
        rs.close();
        for (String[] arr : list) {
        	pstmt = (PreparedStatement)conn.prepareStatement("select point_type,point_quality from WT_MN_POINT where MN='"+arr[1]+"'");
	        rs = pstmt.executeQuery();
	        String pointType = "0";
			WaterQualityEnum targetQuality = WaterQualityEnum.NONE;
			while (rs.next()) {
				pointType = rs.getString(1); 
				if (rs.getObject(2) != null) {
					targetQuality = WaterQualityEnum.valueOf(rs.getString(2));
				}
	        }
			pstmt.close();
			rs.close();
        	pstmt = (PreparedStatement)conn.prepareStatement("select UUID,CODE_POLLUTE,PARAMNAME,DATAVALUE from WT_MN_HOUR_DATA where DATATIME=to_date('"+arr[0]+"','yyyy-mm-dd hh24:mi:ss') and MN='"+arr[1]+"'");
	        rs = pstmt.executeQuery();
	        JSONArray dataArray = new JSONArray();
	        List<String> ids = new ArrayList<String>();
	        while (rs.next()) {
	        	ids.add(rs.getString(1));
	        	JSONObject temp = new JSONObject();
				temp.put("codePollute", rs.getObject(2));
				temp.put("polluteName", rs.getObject(3));
				if(rs.getObject(4)!=null) {
					temp.put("polluteValue", new BigDecimal(rs.getObject(4).toString()));
				}else {
					temp.put("polluteValue", null);
				}
				dataArray.add(temp);
	        }
	        pstmt.close();
	        rs.close();
	        if(!WaterQualityUtil.isCalWaterQuality(dataArray)) {
	        	continue;
	        }
	        JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, pointType, targetQuality);
	        pstmt = (PreparedStatement) conn.prepareStatement("delete from WT_MN_HOUR_REPORT where DATATIME=to_date('"+arr[0]+"','yyyy-mm-dd hh24:mi:ss') and MN='"+arr[1]+"'");
	        pstmt.executeUpdate();
	        pstmt.close();
	        pstmt = (PreparedStatement) conn.prepareStatement("insert into WT_MN_HOUR_REPORT (UUID,DATATIME,MN,MNNAME,TARGET_QUALITY,RESULT_QUALITY,EXCESSFACTORSTR) values(?,?,?,?,?,?,?)");
	        pstmt.setString(1, UUIDUtil.randomUUID());
	        pstmt.setTimestamp(2, new java.sql.Timestamp(sdfTime.parse(arr[0].toString()).getTime()));
	        pstmt.setString(3, arr[1]);
	        pstmt.setString(4, arr[2]);
	        pstmt.setString(5, targetQuality.toString());
	        pstmt.setString(6, resultQuality.getStr("resultQuality"));
	        Clob clob = conn.createClob();
	        clob.setString(1, resultQuality.getJSONArray("excessFactor").toString());
	        pstmt.setClob(7, clob);
	        pstmt.executeUpdate();
	        pstmt.close();
	        pstmt = (PreparedStatement) conn.prepareStatement("update WT_MN_HOUR_DATA set status=1 where UUID in ('"+StringUtils.join(ids, "','")+"')");
	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.commit();
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
		String result = (String) call.invoke(new Object[] { "4028838966d006300166e6beb189552d","3506",queryObject.toString() });  
		// 给方法传递参数，并且调用方法  
		JSONObject jsonObject = new JSONObject(result);
		JSONArray dataArray = !jsonObject.get("data").equals(JSONNull.NULL)?jsonObject.getJSONArray("data"):null;
		if(dataArray!=null&&dataArray.size()>0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setString(1, UUIDUtil.randomUUID());
				proc.setTimestamp(2, getTimestamp(tempObject.get("DATATIME")));
				proc.setString(3, getString(tempObject.get("MN")));
				proc.setString(4, getString(tempObject.get("MNNAME")));
				proc.setString(5, CodeUtil.getCode(getString(tempObject.get("PARAMNAME"))));
				proc.setString(6, getString(tempObject.get("PARAMNAME")));
				proc.setString(7, getString(tempObject.get("DATAVALUE")));
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
