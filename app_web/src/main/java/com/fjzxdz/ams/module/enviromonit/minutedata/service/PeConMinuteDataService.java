/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.minutedata.service;

import cn.fjzxdz.frame.utils.OtherDBSimpleCurdUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;


/**
 * 自动监控小时浓度数据Service
 * @author slq
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PeConMinuteDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PeConMinuteDataService.class);
	
	/**
	 * 根据deviceId获取监测数据列表及其表头
	 * @param outputId
	 */
	public JSONObject getPeConMinuteDataListAndTableMetaByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime,int page, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("queryDeviceId", "'"+outputId+"'");
		paramMap.put("page", page);
		paramMap.put("pageSize", pageSize);
		paramMap.put("monitorDataTimeStart", "'"+queryMeasureStartTime+"'");
		paramMap.put("monitorDataTimeEnd", "'"+queryMeasureEndTime+"'");
		paramMap.put("isOverState", "''");
		paramMap.put("dataType", "2011");
		paramMap.put("pollutantSelect", "''");

        JSONArray columnList = new JSONArray();
        JSONArray recordList = new JSONArray();
		try {
			JSONArray deviceDataList = OtherDBSimpleCurdUtil.findBySQL("ZZRegulatoryWarning","ZZRegulatoryWarning.monitorDeviceData.getRegulotryDeviceDataListAndTableMetaWithDeviceId", paramMap);
			String []  columNameArrStrings = null ;
			String []  collumIdArrStrings = null ;
			
	        if(deviceDataList.size() >0 ){
	        	if( deviceDataList.getJSONObject(0).containsKey("collumName")){
	        		//获取列表表头
	        		columNameArrStrings = deviceDataList.getJSONObject(0).getStr("collumName").replace("[", "").replace("]", "").split(",");
	        		collumIdArrStrings = deviceDataList.getJSONObject(0).getStr("collumId").replace("[", "").replace("]", "").split(",");
					//columnList.put(new JSONObject("{field: seqNo,title:序号,width:40}"));
		        	columnList.put(new JSONObject("{field: measureTime,title:时间 ,width :150}"));
	        		for (int b = 0; b < columNameArrStrings.length; b++) {
	        			String field = collumIdArrStrings[b];
	        			String title = columNameArrStrings[b];
	        			Integer width = 100;
	        			
			        	columnList.put(new JSONObject("{field: '"+field+"',title:'"+title+"' ,width :'"+width+"'}"));
					}
	        		
	        		//获取列表记录
		            for (int y = 0; y < deviceDataList.size(); y++) {
		            	JSONObject columnValue = new JSONObject();
		            	JSONObject deviceDataObj = deviceDataList.getJSONObject(y);
		            	
		                String measureTime = deviceDataObj.getStr("createTime");
		                String seqNo = deviceDataObj.getStr("_ROW_NUMBER");
		                columnValue.put("measureTime",measureTime);
		                columnValue.put("seqNo",seqNo);
		                
		                for (int i = 0; i < collumIdArrStrings.length; i++) {
	        			    String tempColumValue = deviceDataObj.getStr(collumIdArrStrings[i]);
	        				 if(tempColumValue==null || tempColumValue.equals("")){
	        					 tempColumValue ="--";
	        				 }
	        				 columnValue.put(collumIdArrStrings[i],tempColumValue);
	        			}
		                recordList.add(columnValue);
		            }
	        	}else{
					//columnList.put(new JSONObject("{field: seqNo,title:序号,width:40}"));
		        	columnList.put(new JSONObject("{field: measureTime,title:时间 ,width :150}"));
	        	}
	         }
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject result = new JSONObject();
		result.put("cloumnList", columnList);
		result.put("cloumnValueList", recordList);
		
		return result;
	}
	
	/**
	 *  根据排口ID获取所有记录数
	 * @param outputId
	 * @return
	 */
	public Integer getPeConMinuteDataListSizeByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime) {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("queryDeviceId", "'"+outputId+"'");
		paramMap.put("monitorDataTimeStart", "'"+queryMeasureStartTime+"'");
		paramMap.put("monitorDataTimeEnd", "'"+queryMeasureEndTime+"'");
		paramMap.put("isOverState", "''");
		paramMap.put("dataType", "2011");
		paramMap.put("pollutantSelect", "''");

        JSONArray deviceDataList = new JSONArray();
		try {
			deviceDataList = OtherDBSimpleCurdUtil.findBySQL("ZZRegulatoryWarning","ZZRegulatoryWarning.monitorDeviceData.getRegulotryDeviceDataListSizeWithDeviceId", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Integer maxSize = 0;
		if(deviceDataList.size()>0) {
			maxSize = Integer.parseInt(deviceDataList.getJSONObject(0).getStr("size"));
		}
		
		return maxSize;
	}

	/**
	 * 获取在线监测企业点位列表
	 * @return
	 */
	public JSONArray getPeEnterpriseDatasTreeList(String enterpriseName) {
		JSONArray enterpriseTreeArray = new JSONArray();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (StringUtils.isEmpty(enterpriseName)) {
			paramMap.put("extraParams", "''");
		}else{
			paramMap.put("extraParams", enterpriseName);
		}
	
		try {
			enterpriseTreeArray = OtherDBSimpleCurdUtil.findBySQL("ZZRegulatoryWarning","ZZRegulatoryWarning.monitorDevice.getRegulatoryWarningMonitorDeviceTreeList", paramMap);
			for (Object obj : enterpriseTreeArray) {
				Console.log();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return enterpriseTreeArray;
	}
	
	public static void main(String[] args) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("queryDeviceId", "'1heHOIJBd3roXosuTnvXWd'");
		paramMap.put("page", "''");
		paramMap.put("pageSize", "0");
		paramMap.put("monitorDataTimeStart", "'2019-01-01 00:00:00.0'");
		paramMap.put("monitorDataTimeEnd", "'2019-02-21 23:59:00.0'");
		paramMap.put("isOverState", "''");
		paramMap.put("dataType", "2011");
		paramMap.put("pollutantSelect", "''");
		paramMap.put("msg", "0");
		paramMap.put("size", "0");
		
		try {
			JSONArray deviceDataList = OtherDBSimpleCurdUtil.findBySQL("ZZRegulatoryWarning","ZZRegulatoryWarning.monitorDeviceData.getRegulotryDeviceDataAndTableMetaWithDeviceId", paramMap);
			Console.log(deviceDataList);
			String []  collumNameArrStrings = null ;
			String []  collumIdArrStrings = null ;
			
	        JSONArray cloumnList = new JSONArray();
	        JSONArray cloumnValueList = new JSONArray();
	        if(deviceDataList.size() >0 ){
	        	if( deviceDataList.getJSONObject(0).containsKey("collumName")){
	        		//表头 --start--
	        		collumNameArrStrings = deviceDataList.getJSONObject(0).getStr("collumName").replace("[", "").replace("]", "").split(",");
	        		collumIdArrStrings = deviceDataList.getJSONObject(0).getStr("collumId").replace("[", "").replace("]", "").split(",");
					cloumnList.put(new JSONObject("{field: seqNo,title:序号,width:40}"));
		        	cloumnList.put(new JSONObject("{field: measureTime,title:时间 ,width :150}"));
	        		for (int b = 0; b < collumNameArrStrings.length; b++) {
	        			String field = collumIdArrStrings[b];
	        			String title = collumNameArrStrings[b];
	        			Integer width = 100;
	        			
		            	cloumnList.put(new JSONObject("{caption:"+'"'+collumNameArrStrings[b]+'"'+",width:130}"));
					}
	        		//表头 --end--
	        		
	        		
		            for (int y = 0; y < deviceDataList.size(); y++) {
		            	JSONObject deviceDataObj = deviceDataList.getJSONObject(y);
		                String measureTime = deviceDataObj.getStr("createTime");
		                String seqNo = deviceDataObj.getStr("_ROW_NUMBER");
		                cloumnValueList.add(new JSONObject("{measureTime:\""+measureTime+"\"}"));
		                cloumnValueList.add(new JSONObject("{seqNo:\""+seqNo+"\"}"));
		                
		                for (int i = 0; i < collumIdArrStrings.length; i++) {
		                	JSONObject obj = new JSONObject();
		                	
	        			    String tempCollumValue = deviceDataObj.getStr(collumIdArrStrings[i]);
	        				 if(tempCollumValue==null || tempCollumValue.equals("")){
	        					 tempCollumValue ="--";
	        				 }
	        				 obj.put(collumIdArrStrings[i],tempCollumValue);
	        				 cloumnValueList.add(obj);
	        			}
		            }
	        	}else{
	        		collumNameArrStrings = deviceDataList.getJSONObject(0).getStr("collumName").replace("[", "").replace("]", "").split(",");
	        		collumIdArrStrings = deviceDataList.getJSONObject(0).getStr("collumId").replace("[", "").replace("]", "").split(",");
					cloumnList.put(new JSONObject("{field: seqNo,title:序号,width:40}"));
		        	cloumnList.put(new JSONObject("{field: measureTime,title:时间 ,width :150}"));
	        	}
	         }

			/*msg.put("cloumnList", cloumnList);
			msg.put("itemView", itemView.toString());*/
	        System.out.println("cloumnList:"+cloumnList);
	        //System.out.println("cloumnValueList:"+cloumnValueList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
