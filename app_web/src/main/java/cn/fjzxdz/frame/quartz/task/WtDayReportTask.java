package cn.fjzxdz.frame.quartz.task;


import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.toolbox.util.UUIDUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

@Component("wtDayReportTask")
public class WtDayReportTask {

    private static Logger logger = LogManager.getLogger(WtDayReportTask.class);
    
    @Autowired
    private Environment env;

    public void syncData() throws Exception {
        logger.info("计算水检测日数据报表开始");
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
			pstmt = (PreparedStatement)conn.prepareStatement("select monitor_time,point_code,point_name from WT_DAY_DATA where status=0 group by monitor_time,point_code,point_name");
	        rs = pstmt.executeQuery();
	        List<String[]> list = new ArrayList<String[]>();
	        while (rs.next()) {
	        	String[] temparr = {rs.getString(1),rs.getString(2),rs.getString(3)}; 
	        	list.add(temparr);
	        }
	        pstmt.close();
	        rs.close();
	        for (String[] arr : list) {
	        	pstmt = (PreparedStatement)conn.prepareStatement("select point_type,point_quality from wt_city_point where point_code='"+arr[1]+"'");
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
	        	pstmt = (PreparedStatement)conn.prepareStatement("select pkid,code_pollute,pollute_name,pollute_value from WT_DAY_DATA where monitor_time='"+arr[0]+"' and point_code='"+arr[1]+"'");
		        rs = pstmt.executeQuery();
		        JSONArray dataArray = new JSONArray();
		        List<String> ids = new ArrayList<String>();
		        while (rs.next()) {
		        	ids.add(rs.getString(1));
		        	JSONObject temp = new JSONObject();
					temp.put("codePollute", rs.getObject(2));
					temp.put("polluteName", rs.getObject(3));
					temp.put("polluteValue", rs.getObject(4));
					dataArray.add(temp);
		        }
		        pstmt.close();
		        rs.close();
		        if(!WaterQualityUtil.isCalWaterQuality(dataArray)) {
		        	continue;
		        }
		        JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, pointType, targetQuality);
		        pstmt = (PreparedStatement) conn.prepareStatement("delete from WT_DAY_REPORT where MONITOR_TIME='"+arr[0]+"' and POINT_CODE='"+arr[1]+"'");
		        pstmt.executeUpdate();
		        pstmt.close();
		        pstmt = (PreparedStatement) conn.prepareStatement("insert into WT_DAY_REPORT (UUID,MONITOR_TIME,POINT_CODE,POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,EXCESSFACTORSTR) values(?,?,?,?,?,?,?)");
		        pstmt.setString(1, UUIDUtil.randomUUID());
		        pstmt.setString(2, arr[0]);
		        pstmt.setString(3, arr[1]);
		        pstmt.setString(4, arr[2]);
		        pstmt.setString(5, targetQuality.toString());
		        pstmt.setString(6, resultQuality.getStr("resultQuality"));
		        Clob clob = conn.createClob();
		        clob.setString(1, resultQuality.getJSONArray("excessFactor").toString());
		        pstmt.setClob(7, clob);
		        pstmt.executeUpdate();
		        pstmt.close();
		        pstmt = (PreparedStatement) conn.prepareStatement("update WT_DAY_DATA set status=1 where pkid in ('"+StringUtils.join(ids, "','")+"')");
		        pstmt.executeUpdate();
		        pstmt.close();
		        conn.commit();
			}
		} catch (Exception e) {
			logger.info("计算水检测日数据报表失败:"+e.getMessage());
			throw e;
		} finally {
			if(pstmt!=null) {
				pstmt.close();
			}
			if(rs!=null) {
				rs.close();
			}
			if(proc!=null) {
				proc.close();
			}
			if(conn!=null) {
				conn.close();
			}
		}
    }

}
