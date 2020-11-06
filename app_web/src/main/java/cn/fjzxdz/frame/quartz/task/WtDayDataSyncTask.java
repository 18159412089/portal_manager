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
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.UUIDUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONNull;
import cn.hutool.json.JSONObject;

@Component("wtDayDataSyncTask")
public class WtDayDataSyncTask {

	private static Logger logger = LogManager.getLogger(WtDayDataSyncTask.class);
	private SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

	@Autowired
	private Environment env;

	public void syncData() throws Exception {
		logger.info("同步水检测日数据开始");
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
		paramObject.put("Value", sdfDay.format(DateUtil.getAfterDayDate("-2")));
		paramObject.put("FieldName", "MONITORTIME");
		paramObject.put("Operator", ">=");
		paramArray.add(paramObject);
		queryObject.put("params", paramArray);
		Connection conn = null;
		CallableStatement proc = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			conn.setAutoCommit(false);
			proc = conn.prepareCall("{call P_WT_DAY_DATA(?,?,?,?,?,?,?)}");
			getData(queryObject, conn, proc, endpoint);
			getDataReport(conn, pstmt, rs);
		} catch (Exception e) {
			logger.info("同步水检测日数据失败:" + e.getMessage());
			throw e;
		} finally {
			if (proc != null) {
				proc.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	private void getDataReport(Connection conn, PreparedStatement pstmt, ResultSet rs) throws Exception {
		pstmt = (PreparedStatement) conn.prepareStatement(
				"select monitor_time,point_code,point_name from WT_DAY_DATA where status=0 group by monitor_time,point_code,point_name");
		rs = pstmt.executeQuery();
		List<String[]> list = new ArrayList<String[]>();
		while (rs.next()) {
			String[] temparr = { rs.getString(1), rs.getString(2), rs.getString(3) };
			list.add(temparr);
		}
		pstmt.close();
		rs.close();
		for (String[] arr : list) {
			pstmt = (PreparedStatement) conn.prepareStatement(
					"select point_type,point_quality from wt_city_point where point_code='" + arr[1] + "'");
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
			pstmt = (PreparedStatement) conn.prepareStatement(
					"select pkid,code_pollute,pollute_name,pollute_value from WT_DAY_DATA where monitor_time='" + arr[0]
							+ "' and point_code='" + arr[1] + "'");
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
			pstmt = (PreparedStatement) conn.prepareStatement(
					"delete from WT_DAY_REPORT where MONITOR_TIME='" + arr[0] + "' and POINT_CODE='" + arr[1] + "'");
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = (PreparedStatement) conn.prepareStatement(
					"insert into WT_DAY_REPORT (UUID,MONITOR_TIME,POINT_CODE,POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,EXCESSFACTORSTR) values(?,?,?,?,?,?,?)");
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
			pstmt = (PreparedStatement) conn.prepareStatement(
					"update WT_DAY_DATA set status=1 where pkid in ('" + StringUtils.join(ids, "','") + "')");
			pstmt.executeUpdate();
			pstmt.close();
			conn.commit();
		}
	}

	private void getData(JSONObject queryObject, Connection conn, CallableStatement proc, String endpoint)
			throws Exception {
		Service service = new Service();
		Call call = (Call) service.createCall();
		call.setTargetEndpointAddress(endpoint);
		call.setOperationName("RunJsonResult");// WSDL里面描述的接口名称
		call.addParameter("in0", org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// 接口的参数
		call.addParameter("in1", org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// 接口的参数
		call.addParameter("in2", org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// 接口的参数
		call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);// 设置返回类型
		String result = (String) call
				.invoke(new Object[] { "40288389632efb6301636d6533c051d2", "3506", queryObject.toString() });
		// 给方法传递参数，并且调用方法
		JSONObject jsonObject = new JSONObject(result);
		JSONArray dataArray = !jsonObject.get("data").equals(JSONNull.NULL)?jsonObject.getJSONArray("data"):null;
		if (dataArray != null && dataArray.size() > 0) {
			for (Object object : dataArray) {
				JSONObject tempObject = (JSONObject) object;
				proc.setString(1, getString(tempObject.get("PKID")));
				proc.setString(2, getString(tempObject.get("MONITORTIME")));
				proc.setString(3, getString(tempObject.get("POINTCODE")));
				proc.setString(4, getString(tempObject.get("POINTNAME")));
				proc.setString(5, getString(tempObject.get("CODE_POLLUTE")));
				proc.setString(6, getString(tempObject.get("POLLUTENAME")));
				proc.setBigDecimal(7, getNumber(tempObject.get("POLLUTEVALUE")));
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
