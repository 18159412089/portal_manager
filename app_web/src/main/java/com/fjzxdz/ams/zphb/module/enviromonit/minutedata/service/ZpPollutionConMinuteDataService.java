/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.minutedata.service;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.utils.OtherDBSimpleCurdUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.alibaba.druid.util.StringUtils;
import com.fjzxdz.ams.module.enviromonit.hourdata.entity.PeConHourData;
import com.fjzxdz.ams.zphb.module.enviromonit.minutedata.dao.ZpPollutionConMinuteDataDao;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 自动监控小时浓度数据Service
 * @author slq
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ZpPollutionConMinuteDataService {

	private static Logger logger = LogManager.getLogger(ZpPollutionConMinuteDataService.class);
	@Autowired
	private ZpPollutionConMinuteDataDao zpPollutionConMinuteDataDao;
    @Autowired
    private SimpleDao simpleDao;
	/**
	 * 根据deviceId获取监测数据列表及其表头
	 * @param outputId
	 */
	public JSONObject getPollutionConMinuteDataListAndTableMetaByOutputId(String outputId,String queryMeasureStartTime,String queryMeasureEndTime,int page, int pageSize) {
		int startRecord = (page-1) * pageSize + 1;
		int endRecord = (page-1) * pageSize + pageSize;
		String sql = "SELECT *  FROM ((\n" +
				"SELECT ROWNUM\n" +
				"	rn,\n" +
				"	t.* \n" +
				"FROM\n" +
				"	(\n" +
				"select  STATIONCODE,\n" +
				"STATIONSUBNAME,\n" +
				"listagg ( TARGETCODE, ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE ) PLU_CODE,\n" +
				"listagg ( CNNAME ||'</br>('||\td_overproof || '-' || u_overproof ||')', ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE ) PLU_NAME,\n"+
				"listagg ( rtrim( to_char(AVGVAL, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE) OUTPUT_AVG,\n" +
				"DATATIME,\n" +
				"listagg (isover, ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE) overStatus "+
				"from  ZP_POLLUTION_MONITOR_MIN_DATA\n" +
				"where STATIONCODE = '"+outputId+"'\n" +
				"AND (DataTime BETWEEN TO_DATE( '"+queryMeasureStartTime+"' , 'YYYY-MM-DD HH24-MI-SS') and TO_DATE( '"+queryMeasureEndTime+"' , 'YYYY-MM-DD HH24-MI-SS')) "+
                "GROUP BY\n" +
				"\t\t\t\t\tSTATIONCODE,\n" +
				"\t\t\t\t\tSTATIONSUBNAME,\n" +
				"\t\t\t\t\tDATATIME\n" +
				"order by  DATATIME desc "+
				") t )) WHERE rn >= "+startRecord+"  AND rn <= "+endRecord+"";


		JSONObject jsonObject = new JSONObject();
		JSONArray clumnArr = new JSONArray();
		JSONArray clumnNameArr = new JSONArray();
		JSONArray clumnOverStatusArr = new JSONArray();
 		try {
			List<Object[]> peConHourDataObjList =  simpleDao.createNativeQuery(sql).getResultList();
			JSONObject rowObj = new JSONObject();
			rowObj.put("field","rowNum");
			rowObj.put("title","序号");
			rowObj.put("width",50);
			clumnNameArr.put(rowObj);
			for(int i=0;i<peConHourDataObjList.size();i++) {
				Object[] peConHourDataObj = peConHourDataObjList.get(i);
				JSONObject clumnObj = new JSONObject();
				JSONObject clumnOverObj  = new JSONObject();
				clumnObj.put("rowNum",peConHourDataObj[0].toString());
				clumnObj.put("stationCode",peConHourDataObj[1].toString());
				clumnObj.put("stationName",peConHourDataObj[2].toString());
				clumnObj.put("dataTime",peConHourDataObj[6].toString());
 				if (!StringUtils.isEmpty(peConHourDataObj[3].toString()) && !StringUtils.isEmpty(peConHourDataObj[5].toString())){
							String[] clumnIds =	peConHourDataObj[3].toString().split(",");
							String[] clumnNames =	peConHourDataObj[4].toString().split(",");
							String[] clumnValues =	peConHourDataObj[5].toString().split(",");
							String[] clumnOverValues =	peConHourDataObj[7].toString().split(",");
				            for (int b = 0 ;b < clumnValues.length; b++){
								JSONObject clumnNameObj = new JSONObject();
								clumnObj.put(clumnIds[b],clumnValues[b]);

 								if(i == 0){
									clumnNameObj.put("field",clumnIds[b]);
									clumnNameObj.put("title",clumnNames[b]);
									clumnNameObj.put("width",100);
                                    clumnNameArr.put(clumnNameObj);
                                }
 								if(clumnOverValues.length >0){

									clumnOverObj.put(clumnIds[b]+"overStatus",clumnOverValues[b]);

								}
 							 }
					clumnOverStatusArr.put(clumnOverObj);
				    clumnArr.put(clumnObj);
 				}
 			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		JSONObject timeObj = new JSONObject();
		timeObj.put("field","dataTime");
		timeObj.put("title","监测时间");
		timeObj.put("width",150);

		clumnNameArr.put(timeObj);

		jsonObject.put("total",clumnArr.size());
		jsonObject.put("rows",clumnArr);
		jsonObject.put("overStatus",clumnOverStatusArr);
		jsonObject.put("clumnName",clumnNameArr);
		return jsonObject;
		

	}
    /**
	 *  根据排口ID获取所有记录数
	 * @param outputId
	 * @return
	 */
	public Integer getPollutionConMinuteDataListSizeByOutputId(String outputId,String queryMeasureStartTime,String queryMeasureEndTime) {
	    Integer allCount = 0 ;

//		String sql = "select   count(*) as totalSize  from  ZP_POLLUTION_MONITOR_MIN_DATA\n" +
//				"where STATIONCODE = '"+outputId+"'\n"+
//				"AND (DataTime BETWEEN TO_DATE( '"+queryMeasureStartTime+"' , 'YYYY-MM-DD HH24-MI-SS') and TO_DATE( '"+queryMeasureEndTime+"' , 'YYYY-MM-DD HH24-MI-SS')) ";

        String sql = "select count(*)  from (SELECT ROWNUM\n" +
				"	rn,\n" +
				"	t.* \n" +
				"FROM\n" +
				"	(\n" +
				"select  STATIONCODE,\n" +
				"STATIONSUBNAME,\n" +
				"listagg ( TARGETCODE, ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE ) PLU_CODE,\n" +
				"listagg ( CNNAME ||'</br>('||	d_overproof || '-' || u_overproof ||')', ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE ) PLU_NAME,\n" +
				"listagg ( rtrim( to_char(AVGVAL, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE) OUTPUT_AVG,\n" +
				"DATATIME,\n" +
				"listagg (isover, ',' ) within GROUP ( ORDER BY STATIONCODE, TARGETCODE) overStatus from  ZP_POLLUTION_MONITOR_MIN_DATA\n" +
				"where STATIONCODE = '"+outputId+"'\n"+
				"AND (DataTime BETWEEN TO_DATE( '"+queryMeasureStartTime+"' , 'YYYY-MM-DD HH24-MI-SS') and TO_DATE( '"+queryMeasureEndTime+"' , 'YYYY-MM-DD HH24-MI-SS'))  GROUP BY\n" +
				"					STATIONCODE,\n" +
				"					STATIONSUBNAME,\n" +
				"					DATATIME\n" +
				"order by  DATATIME desc ) t )";

		List<BigDecimal> list =  simpleDao.createNativeQuery(sql).getResultList();
		for(BigDecimal count : list){
			String size = count.toString();
			allCount = Integer.valueOf(size);
		}
		return allCount;
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

	/**
	 * 获取某个站点最后一次更新时间
	 * @return
	 */
	public JSONObject getPointInsertDataLastTime(){
		JSONObject  dataObjs = new JSONObject();
		String sqlstr = "SELECT      EP_CODE,STATIONCODE, max(DATATIME)  from ZP_POLLUTION_MONITOR_MIN_DATA \n" +
				 " GROUP BY   EP_CODE,STATIONCODE " ;
		List<Object[]> datas = simpleDao.createNativeQuery(sqlstr).getResultList();
		for (Object[] obj: datas) {
            dataObjs.put(obj[0].toString()+"#"+obj[1].toString(), obj[2].toString()  ) ;

		}
		return dataObjs;
	}

	/**
	 *  指定站点最后一次监测数据是否超标
	 * @param epCode   企业Code
	 * @param stationCode  站点code
	 * @param dataTime   最后一次更新时间
	 * @return    是否超标
	 */
   public boolean isStationOverState(String epCode , String stationCode, Timestamp dataTime){
		 boolean isFlag = false ;
	     String time = dataTime.toString().substring( 0,19);
		 String sqlstr = " SELECT\n" +
				 " \t   ISOVER\n" +
				 "  \t\tFROM\n" +
				 " \t\t\tZP_POLLUTION_MONITOR_MIN_DATA P \n" +
				 "      where p.DATATIME = \"TO_DATE\"('"+time+"' , 'yyyy-mm-dd hh24:mi:ss')\n" +
				 "      and  EP_CODE = '"+epCode+"' and STATIONCODE ='"+stationCode+"'" +
				 "      and p.ISOVER = 'true'";
	    List<Object[]> datas = simpleDao.createNativeQuery(sqlstr).getResultList();
	    if (datas != null){
			if(datas.size() >0){
				isFlag= true;
			}
		}
		 return isFlag;
   }




}
