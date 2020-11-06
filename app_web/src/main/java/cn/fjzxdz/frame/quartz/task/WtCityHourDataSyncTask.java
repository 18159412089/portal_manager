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

@Component("wtCityHourDataSyncTask")
public class WtCityHourDataSyncTask {

    private static Logger logger = LogManager.getLogger(WtCityHourDataSyncTask.class);
    private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
    
    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("同步自建水检测小时数据开始");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
		Connection  conn=null;
		CallableStatement proc=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			getDataReport(conn, pstmt, rs);
		} catch (Exception e) {
			logger.info("同步自建水检测小时数据失败:"+e.getMessage());
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
    	pstmt = (PreparedStatement) conn.prepareStatement("update wt_city_hour_data set status=1 where datatime<=sysdate-10 and datatime>=sysdate-20 and status=0");
        pstmt.executeUpdate();
        pstmt.close();
        conn.commit();
    	pstmt = (PreparedStatement)conn.prepareStatement("select to_char(DATATIME,'yyyy-mm-dd hh24:mi:ss'),POINT_CODE,POINT_NAME from WT_CITY_HOUR_DATA where status=0 group by DATATIME,POINT_CODE,POINT_NAME");
        rs = pstmt.executeQuery();
        List<String[]> list = new ArrayList<String[]>();
        while (rs.next()) {
        	String[] temparr = {rs.getString(1),rs.getString(2),rs.getString(3)}; 
        	list.add(temparr);
        }
        pstmt.close();
        rs.close();
        for (String[] arr : list) {
        	pstmt = (PreparedStatement)conn.prepareStatement("select point_type,point_quality from WT_CITY_POINT where POINT_CODE='"+arr[1]+"'");
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
        	pstmt = (PreparedStatement)conn.prepareStatement("select UUID,CODE_POLLUTE,PARAMNAME,DATAVALUE from WT_CITY_HOUR_DATA where DATATIME=to_date('"+arr[0]+"','yyyy-mm-dd hh24:mi:ss') and POINT_CODE='"+arr[1]+"'");
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
	        pstmt = (PreparedStatement) conn.prepareStatement("delete from WT_CITY_HOUR_REPORT where DATATIME=to_date('"+arr[0]+"','yyyy-mm-dd hh24:mi:ss') and POINT_CODE='"+arr[1]+"'");
	        pstmt.executeUpdate();
	        pstmt.close();
	        pstmt = (PreparedStatement) conn.prepareStatement("insert into WT_CITY_HOUR_REPORT (UUID,DATATIME,POINT_CODE,POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,EXCESSFACTORSTR) values(?,?,?,?,?,?,?)");
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
	        pstmt = (PreparedStatement) conn.prepareStatement("update WT_CITY_HOUR_DATA set status=1 where UUID in ('"+StringUtils.join(ids, "','")+"')");
	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.commit();
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
