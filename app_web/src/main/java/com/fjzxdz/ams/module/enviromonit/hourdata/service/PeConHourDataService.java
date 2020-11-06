/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.hourdata.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;

import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import com.fjzxdz.ams.module.enviromonit.hourdata.dao.PeConHourDataDao;
import com.fjzxdz.ams.module.enviromonit.hourdata.entity.PeConHourData;
import com.fjzxdz.ams.module.enviromonit.hourdata.param.PeConHourDataParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

/**
 * 自动监控小时浓度数据Service
 * @author slq
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PeConHourDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PeConHourDataService.class);

	@Autowired
	private PeConHourDataDao peConHourDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peConHourDataParam
	 * @param page
	 * @return
	 */
	public Page<PeConHourData> listByPage(PeConHourDataParam peConHourDataParam, Page<PeConHourData> page) {
		Page<PeConHourData> listPage = peConHourDataDao.listByPage(peConHourDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peConHourData
	 */
	public void save(PeConHourData peConHourData) {
		if (StringUtils.isNotEmpty(peConHourData.getPeId())) {
			PeConHourData peConHourDataTemp = peConHourDataDao.getById(peConHourData.getPeId());
			BeanUtil.copyProperties(peConHourData, peConHourDataTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			peConHourDataDao.update(peConHourDataTemp);
		}else{
			//peConHourData.setUuid(null);
			peConHourData = (PeConHourData) EmptyStringToNullUtil.emptyStringToNull(peConHourData);
			peConHourDataDao.save(peConHourData);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peConHourDataDao.deleteById(uuid);
	}
	/**
	 * 根据outputId查询
	 * @param outputId
	 */
	public List<PeConHourData> getPeConHourDataListByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime,int page, int pageSize) {
		String sql = "SELECT *  FROM ((\n" +
				"SELECT ROWNUM\n" +
				"	rn,\n" +
				"	t.* \n" +
				"FROM\n" +
				"	(\n" +
				"SELECT\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	listagg ( PLU_CODE, ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) PLU_CODE,\n" +
				"	listagg ( rtrim( to_char( CHROMA_MIN, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_MIN,\n" +
				"	listagg ( rtrim( to_char( CHROMA_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_AVG,\n" +
				"	listagg ( rtrim( to_char( CHROMA_MAX, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_MAX,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_AVG,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	DATA_COUNT,\n" +
				"	PERSONAL_IDENTIFICATION,\n" +
				"	REMARK,\n" +
				"	REPORT_TYPE,\n" +
				"	UPDATE_TIME\n " +
				"FROM\n" +
				"	PE_CON_HOUR_DATA \n" +
				"WHERE\n" +
				"	OUTPUT_ID = :outputId " +
				"	AND (MEASURE_TIME BETWEEN TO_DATE(to_char(:queryMeasureStartTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS') and TO_DATE(to_char(:queryMeasureEndTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS')) \n" +
				"GROUP BY\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	DATA_COUNT, \n" +
				"	PERSONAL_IDENTIFICATION, \n" +
				"	REMARK, \n" +
				"	REPORT_TYPE, \n" +
				"	UPDATE_TIME \n" +
				"	ORDER BY MEASURE_TIME DESC \n" +
				") t )) WHERE rn >= :startRecord  AND rn <= :endRecord";
		
		int startRecord = (page-1) * pageSize + 1;
		int endRecord = (page-1) * pageSize + pageSize;
		
		Query query = peConHourDataDao.createNativeQuery(sql);
		query.setParameter("outputId", outputId);
		query.setParameter("queryMeasureStartTime", queryMeasureStartTime);
		query.setParameter("queryMeasureEndTime", queryMeasureEndTime);
		query.setParameter("startRecord", startRecord);
		query.setParameter("endRecord", endRecord);
		
		List<PeConHourData> peConHourDataList = new ArrayList<>();
		try {
			List<Object[]> peConHourDataObjList = query.getResultList();
			for(int i=0;i<peConHourDataObjList.size();i++) {
				int j=1;
				PeConHourData data = new PeConHourData();
				
				data.setPeId(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setOutputId(String.valueOf(peConHourDataObjList.get(i)[j++]));
				
				data.setMeasureTime(Timestamp.valueOf(String.valueOf(peConHourDataObjList.get(i)[j++])));
				data.setPluCode(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setChromaMin(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setChromaAvg(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setChromaMax(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setOutputAvg(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setOutfallType(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setIsMeasure(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setDataCount(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setPersonalIdentification(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setRemark(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setReportType(String.valueOf(peConHourDataObjList.get(i)[j++]));
				data.setUpdateTime(peConHourDataObjList.get(i)[j]==null ? Utils.getTimestampZero() : Timestamp.valueOf(String.valueOf(peConHourDataObjList.get(i)[j++])));
	
				peConHourDataList.add(data);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return peConHourDataList;
	}
	
	/**
	 *  根据排口ID获取所有记录数
	 * @param outputId
	 * @return
	 */
	public Integer getPeConHourDataListSizeByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime) {
		String sql = "SELECT *  FROM ((\n" +
				"SELECT ROWNUM\n" +
				"	rn,\n" +
				"	t.* \n" +
				"FROM\n" +
				"	(\n" +
				"SELECT\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	listagg ( PLU_CODE, ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) PLU_CODE,\n" +
				"	listagg ( rtrim( to_char( CHROMA_MIN, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_MIN,\n" +
				"	listagg ( rtrim( to_char( CHROMA_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_AVG,\n" +
				"	listagg ( rtrim( to_char( CHROMA_MAX, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) CHROMA_MAX,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_AVG,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	DATA_COUNT,\n" +
				"	PERSONAL_IDENTIFICATION,\n" +
				"	REMARK,\n" +
				"	REPORT_TYPE,\n" +
				"	UPDATE_TIME\n " +
				"FROM\n" +
				"	PE_CON_HOUR_DATA \n" +
				"WHERE\n" +
				"	OUTPUT_ID = :outputId " +
				"	AND (MEASURE_TIME BETWEEN TO_DATE(to_char(:queryMeasureStartTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS') and TO_DATE(to_char(:queryMeasureEndTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS')) \n" +
				"GROUP BY\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	DATA_COUNT, \n" +
				"	PERSONAL_IDENTIFICATION, \n" +
				"	REMARK, \n" +
				"	REPORT_TYPE, \n" +
				"	UPDATE_TIME \n" +
				"	ORDER BY MEASURE_TIME DESC \n" +
				") t ))";
        Query query = peConHourDataDao.createNativeQuery(sql);
		query.setParameter("outputId", outputId);
		query.setParameter("queryMeasureStartTime", queryMeasureStartTime);
		query.setParameter("queryMeasureEndTime", queryMeasureEndTime);
		
		return query.getResultList().size();
	}

    /**
     * 获取每个站点最后一次更新时间
     * @return
     */
	private JSONArray getPointInsertDataLastTime(){
	        JSONArray  jsonArray = new JSONArray();
	        String sqlstr = "SELECT  OUTPUT_ID , max(MEASURE_TIME)  from PE_CON_HOUR_DATA \n" +
                    "GROUP BY  OUTPUT_ID  " ;
             List<Object[]> datas = peConHourDataDao.createNativeQuery(sqlstr).getResultList();
        for (Object[] obj: datas) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("outputId",  obj[0].toString()) ;
            jsonObject.put("time",  obj[1].toString()) ;
            jsonArray.add(jsonObject);
        }
          return jsonArray;
    }

    /**
     * 判断站点是否超标
     */
    public void isOverPoint(){
    	  JSONArray  pointInsertDataTimeDatas =  getPointInsertDataLastTime();
           if (pointInsertDataTimeDatas.size() > 0 ){
               for (int  i = 0 ;  i<pointInsertDataTimeDatas.size(); i++){

                    JSONObject jsonObject =  pointInsertDataTimeDatas.getJSONObject(i);
                    String outPutId =  jsonObject.get("outputId").toString();
				    String  menureTime = null;
                    try {
						menureTime =	jsonObject.get("time").toString();
                    	menureTime =  menureTime .substring(0,menureTime.indexOf("."));
					}catch (Exception e){
                    	   e.printStackTrace();
					}
                    if(!StringUtils.isBlank(menureTime)){
						upMonitorPointStatusByLimitData(outPutId,menureTime);
					}

                }

           }
    }
    /**
     * 根据上下限值判断当前设备是否超标
     * @return
     */
    private  void upMonitorPointStatusByLimitData(String outPutID ,String menureTime){
      	String    pointStatus = "normal";
        String sqlstr = "\n" +
                "SELECT   count(*) from PE_CON_HOUR_DATA d\n" +
                "LEFT JOIN PE_FACTOR_MANUAL m on   (d.OUTPUT_ID = m.OUTPUT_ID and d.PLU_CODE = m.PLU_CODE)\n" +
                "where  d.OUTPUT_ID = '"+outPutID+"' and  d.MEASURE_TIME =TO_DATE (\n" +
                "'"+menureTime+"',\n" +
                "\t'yyyy-mm-dd hh24:mi:ss'\n" +
                ") and NULLIF (m.UP_LIMIT, 0) <>0   and CHROMA_AVG is not null  and   NULLIF(  d.CHROMA_AVG  ,0)   not BETWEEN   NULLIF(m.LOW_LIMIT,0) and  NULLIF (m.UP_LIMIT, 0)   \n" +
                "ORDER BY  d.MEASURE_TIME DESC  " ;

          List  list = simpleDao.createNativeQuery(sqlstr).getResultList();
          int overCount = 0 ;
          if(list.size()<= 0) return ;

          overCount = Integer.valueOf (list.get(0).toString()) ;

          if (overCount > 0) {
			  pointStatus = "over";
		  }
		  String  updateStr = "update PE_MONITOR_POINT \n" +
				"set OUTPUT_STATUS = '"+pointStatus+"'\n" +
				"where  OUTPUT_ID =  '"+outPutID+"'";
          try {
			  simpleDao.createNativeQuery(updateStr).executeUpdate();
		  }catch (Exception e){
          	e.printStackTrace();
		  }
     }




}
