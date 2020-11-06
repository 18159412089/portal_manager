/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.daydata.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fjzxdz.ams.module.enviromonit.daydata.dao.PeConDayDataDao;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import com.fjzxdz.ams.module.enviromonit.daydata.param.PeConDayDataParam;

import org.apache.axis.types.Time;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.Query;

/**
 * 自动监控日浓度数据Service
 * @author slq
 * @date 2019-02-12
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PeConDayDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PeConDayDataService.class);

	@Autowired
	private PeConDayDataDao peConDayDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peConDayData
	 * @param page
	 * @return
	 */
	public Page<PeConDayData> listByPage(PeConDayDataParam peConDayDataParam, Page<PeConDayData> page) {
		Page<PeConDayData> listPage = peConDayDataDao.listByPage(peConDayDataParam, page);
		return listPage;
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peConDayDataDao.deleteById(uuid);
	}
	
	/**
	 * 根据outputId查询
	 * @param outputId
	 */
	public List<PeConDayData> getPeConDayDataListByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime,int page,int pageSize) {
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
				"	listagg ( rtrim( to_char( OUTPUT_MIN, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_MIN,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_AVG,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_MAX, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_MAX,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	INSERT_TIME \n" +
				"FROM\n" +
				"	PE_CON_DAY_DATA \n" +
				"WHERE\n" +
				"	OUTPUT_ID = :outputId " +
				"	AND (MEASURE_TIME BETWEEN TO_DATE(to_char(:queryMeasureStartTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS') and TO_DATE(to_char(:queryMeasureEndTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS')) \n" +
				"GROUP BY\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	INSERT_TIME \n" +
				"	ORDER BY MEASURE_TIME DESC \n" +
				") t )) WHERE rn >= :startRecord  AND rn <= :endRecord";
		
		int startRecord = (page-1) * pageSize + 1;
		int endRecord = (page-1) * pageSize + pageSize;
		
		Query query = peConDayDataDao.createNativeQuery(sql);
		query.setParameter("outputId", outputId);
		query.setParameter("queryMeasureStartTime", queryMeasureStartTime);
		query.setParameter("queryMeasureEndTime", queryMeasureEndTime);
		query.setParameter("startRecord", startRecord);
		query.setParameter("endRecord", endRecord);
		
		List<PeConDayData> peConDayDataList = new ArrayList<>();
		try {
			List<Object[]> peConDayDataObjList = query.getResultList();
			for(int i=0;i<peConDayDataObjList.size();i++) {
				int j=1;
				PeConDayData data = new PeConDayData();
				
				data.setPeId(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setOutputId(String.valueOf(peConDayDataObjList.get(i)[j++]));
				
				data.setMeasureTime(Timestamp.valueOf(String.valueOf(peConDayDataObjList.get(i)[j++])));
				data.setPluCode(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setChromaMin(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setChromaAvg(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setChromaMax(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setOutputMin(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setOutputAvg(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setOutputMax(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setOutfallType(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setIsMeasure(String.valueOf(peConDayDataObjList.get(i)[j++]));
				data.setInsertTime(Timestamp.valueOf(String.valueOf(peConDayDataObjList.get(i)[13])));
			
				peConDayDataList.add(data);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return peConDayDataList;
	}
	
	/**
	 *  根据排口ID获取所有记录数
	 * @param outputId
	 * @return
	 */
	public Integer getPeConDayDataListSizeByOutputId(String outputId,Timestamp queryMeasureStartTime,Timestamp queryMeasureEndTime) {
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
				"	listagg ( rtrim( to_char( OUTPUT_MIN, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_MIN,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_AVG, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_AVG,\n" +
				"	listagg ( rtrim( to_char( OUTPUT_MAX, 'fm9999999990.9999999999' ), '.' ), ',' ) within GROUP ( ORDER BY OUTPUT_ID, PLU_CODE ) OUTPUT_MAX,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	INSERT_TIME \n" +
				"FROM\n" +
				"	PE_CON_DAY_DATA \n" +
				"WHERE\n" +
				"	OUTPUT_ID = :outputId " +
				"	AND (MEASURE_TIME BETWEEN TO_DATE(to_char(:queryMeasureStartTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS') and TO_DATE(to_char(:queryMeasureEndTime, 'YYYY-MM-DD HH24-MI-SS'), 'YYYY-MM-DD HH24-MI-SS')) \n" +
				"GROUP BY\n" +
				"	PE_ID,\n" +
				"	OUTPUT_ID,\n" +
				"	MEASURE_TIME,\n" +
				"	OUTFALL_TYPE,\n" +
				"	IS_MEASURE,\n" +
				"	INSERT_TIME \n" +
				"	ORDER BY MEASURE_TIME DESC \n"
				+ ") t ))";
		
		Query query = peConDayDataDao.createNativeQuery(sql);
		query.setParameter("outputId", outputId);
		query.setParameter("queryMeasureStartTime", queryMeasureStartTime);
		query.setParameter("queryMeasureEndTime", queryMeasureEndTime);
		
		return query.getResultList().size();
	}
}
