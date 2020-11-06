/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.factormanual.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.module.enviromonit.factormanual.dao.PeFactorManualDao;
import com.fjzxdz.ams.module.enviromonit.factormanual.entity.PeFactorManual;
import com.fjzxdz.ams.module.enviromonit.factormanual.param.PeFactorManualParam;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 污染源手动监控点位采集因子Service
 * @author gsq
 * @version 2019-09-30
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ZpPeFactorManualService {
	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpPeFactorManualService.class);

	@Autowired
	private PeFactorManualDao peFactorManualDao;

	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param
	 * @param page
	 * @return
	 */
	public Page<PeFactorManual> listByPage(PeFactorManualParam peFactorManualParam, Page<PeFactorManual> page) {
		Page<PeFactorManual> listPage = peFactorManualDao.listByPage(peFactorManualParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peFactorManual
	 */
	public void save(PeFactorManual peFactorManual) {
		if (StringUtils.isNotEmpty(peFactorManual.getPluEqpId())) {
			PeFactorManual peFactorTemp = getPeFactorManualByPluEqlId(peFactorManual.getPluEqpId());
			BeanUtil.copyProperties(peFactorManual, peFactorTemp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			try {
				peFactorManualDao.update(peFactorTemp);
			}catch (Exception e){
				e.printStackTrace();
			}
		}else{
			peFactorManual.setPluEqpId(String.valueOf( RandomUtils.nextInt()));
			peFactorManual = (PeFactorManual) EmptyStringToNullUtil.emptyStringToNull(peFactorManual);
			peFactorManualDao.save(peFactorManual);
		}
	}

	 /**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peFactorManualDao.deleteById(uuid);
	}

	/**
	 * 根据 污染物设备id 删除记录
	 * @param pluEqpId
	 */
	public void deleteByPluEqpId(String pluEqpId){
		String sql = "delete from PE_FACTOR_MANUAL where PLU_EQP_ID= '"+pluEqpId+"'";
 		simpleDao.createNativeQuery(sql).executeUpdate();
	}

	/**
	 * 获取污染物因子列表
	 * @param peFactorManualParam
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<PeFactorManual> getPeFactorManualList(PeFactorManualParam peFactorManualParam, int page, int pageSize) {
		List<PeFactorManual> peFactorManualList = new ArrayList<>();
		Long outputId = peFactorManualParam.getOutputId();
		String pluCode = peFactorManualParam.getPluCode();
		String pluName = peFactorManualParam.getPluName();
		String csn = peFactorManualParam.getUnitCode();

		String outPutStr = "" ;
		if (outputId != null){
			outPutStr = "and P.OUTPUT_ID = :outputId \n";
		}
		if (!StringUtils.isBlank(pluCode)){
			outPutStr += "and f.PLU_CODE = :pluCode \n";
		}
		if (!StringUtils.isBlank(pluName)){
			outPutStr += "and f.PLU_NAME = :pluName \n";
		}
		if (!StringUtils.isBlank(csn)){
			outPutStr += "and p.CSN like '"+csn+"%'";
		}

		String sql = "SELECT * FROM (" +
							"SELECT ROWNUM rn, t.* " +
							"FROM (" +
								"SELECT " +
									"f.OUTPUT_ID," +
									"P.NAME," +
									"f.PLU_CODE," +
									"f.PLU_NAME," +
									"NULLIF(f.UP_LIMIT, 0) AS UP_LIMIT," +
									"NULLIF(f.LOW_LIMIT, 0) AS LOW_LIMIT," +
									"f.PLU_EQP_ID " +
								"FROM PE_FACTOR_MANUAL f " +
								"LEFT JOIN PE_MONITOR_POINT P ON P.OUTPUT_ID = f.OUTPUT_ID " +
								"WHERE p.OUTPUT_ID is not null " +
								outPutStr +
								"ORDER BY P.NAME DESC " +
							") t" +
				   		") WHERE rn >= :startRecord  AND rn <= :endRecord";

		int startRecord = (page-1) * pageSize + 1;
		int endRecord = (page-1) * pageSize + pageSize;

		Query query = peFactorManualDao.createNativeQuery(sql);
		if (outputId != null){
			query.setParameter("outputId", outputId);
		}
		if (!StringUtils.isBlank(pluCode)){
			query.setParameter("pluCode", pluCode);
		}
		if (!StringUtils.isBlank(pluName)){
			query.setParameter("pluName", pluName);
		}
		query.setParameter("startRecord", startRecord);
		query.setParameter("endRecord", endRecord);
		try {
			List<Object[]> peFactorManualObjList = query.getResultList();
			for(int i=0;i<peFactorManualObjList.size();i++) {
				Object[] obj = peFactorManualObjList.get(i);
				PeFactorManual data = new PeFactorManual();
				data.setOutputId(obj[1].toString());
				data.setOutputName(obj[2].toString());
				data.setPluCode(obj[3].toString());
				data.setPluName(obj[4].toString());
				if ( obj[5] == null){
					obj[5] = '0';
				}
				data.setUpLimit(obj[5].toString());
				if ( obj[6] == null){
					obj[6] = '0';
				}
				data.setLowLimit(obj[6].toString());
				data.setPluEqpId(obj[7].toString());
			    peFactorManualList.add(data);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return peFactorManualList;
	}

	/**
	 * 获取总的污染物因子列表数目
	 * @param peFactorManualParam
	 * @return
	 */
	public int countPeFacotrManualSize(PeFactorManualParam peFactorManualParam ){
		String outPutStr = "" ;
		Long outputId =  peFactorManualParam.getOutputId();
		String pluCode =  peFactorManualParam.getPluCode();
		String pluName =  peFactorManualParam.getPluName();
		String csn = peFactorManualParam.getUnitCode();

		if (outputId != null){
			outPutStr = "and P.OUTPUT_ID = :outputId \n";
		}
		if (!StringUtils.isBlank(pluCode)){
			outPutStr +="and f.PLU_CODE = :pluCode \n";
		}
		if (!StringUtils.isBlank(pluName)){
			outPutStr +="and f.PLU_NAME = :pluName \n";
		}
		if (!StringUtils.isBlank(csn)){
			outPutStr += "and p.CSN like '"+csn+"%'";
		}

		String sql = "SELECT P.NAME " +
					"FROM PE_FACTOR f " +
					"LEFT JOIN PE_MONITOR_POINT P ON P.OUTPUT_ID = f.OUTPUT_ID " +
					"WHERE p.OUTPUT_ID is not null " + outPutStr;

		Query query = peFactorManualDao.createNativeQuery(sql);
		if (outputId != null){
			query.setParameter("outputId", outputId);
		}
		if (!StringUtils.isBlank(pluCode)){
			query.setParameter("pluCode", pluCode);
		}
		if (!StringUtils.isBlank(pluName)){
			query.setParameter("pluName", pluName);
		}
		return query.getResultList().size();
	}

	/**
	 * 根据污染物设备 id 获取污染物因子
	 * @param
	 * @param
	 * @param
	 * @param
	 * @return
	 */
	public  PeFactorManual  getPeFactorManualByPluEqlId(String pluEqlId) {
		PeFactorManual data = new PeFactorManual();
	    String sql = "SELECT\n" +
				" P.OUTPUT_ID,\n" +
				" P.NAME,\n" +
				" f.PLU_CODE,\n" +
				" f.PLU_NAME,\n" +
				" NULLIF(f.UP_LIMIT, 0) AS UP_LIMIT,\n" +
				" NULLIF(f.LOW_LIMIT, 0) AS LOW_LIMIT,\n" +
				"f.PLU_EQP_ID \n" +
				" FROM \n" +
				"PE_FACTOR_MANUAL f \n" +
				"LEFT JOIN PE_MONITOR_POINT P ON P .OUTPUT_ID = f.OUTPUT_ID \n" +
				"WHERE 1=1 and    f.PLU_EQP_ID = :pluEqlId \n" ;
        Query query = peFactorManualDao.createNativeQuery(sql);
		if (pluEqlId != null){
			query.setParameter("pluEqlId", pluEqlId);
		}

     	try {
			List<Object[]> peFactorManualObjList = query.getResultList();
			for(int i=0;i<peFactorManualObjList.size();i++) {
				Object[] obj = peFactorManualObjList.get(i);
	  			data.setOutputId(obj[0].toString());
				data.setOutputName(obj[1].toString());
				data.setPluCode(obj[2].toString());
				data.setPluName(obj[3].toString());
				if ( obj[4] == null){
					obj[4] = '0';
				}
			    if ( obj[5] == null){
					obj[5] = '0';
				}
				data.setUpLimit(obj[4].toString());
				data.setLowLimit(obj[5].toString());
				data.setPluEqpId(obj[6].toString());
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}

	/**
	 * 根据排口ID获取污染物上下限值
	 * @param
	 */
	public Map<String, Map<String, Object>>  getLimitValueByMonitorPointId(String outputId){
		PeFactorManual data = new PeFactorManual();
		String sqlStr = "SELECT\n" +
				" f.OUTPUT_ID AS OUTPUT_ID,\n" +
				" P.NAME AS NAME,\n" +
				" f.PLU_CODE AS PLU_CODE,\n" +
				" f.PLU_NAME AS PLU_NAME,\n" +
				" NULLIF(f.UP_LIMIT, 0) AS UP_LIMIT,\n" +
				" NULLIF(f.LOW_LIMIT, 0) AS LOW_LIMIT,\n" +
				" f.PLU_EQP_ID AS PLU_EQP_ID \n" +
				" FROM PE_FACTOR_MANUAL f \n" +
				" LEFT JOIN PE_MONITOR_POINT P ON P.OUTPUT_ID = f.OUTPUT_ID \n" +
				" WHERE 1=1 and    p.OUTPUT_ID is not null \n" +
				" AND P.OUTPUT_ID = "+outputId+"\n" +
				" ORDER BY \n" +
				" P.NAME DESC \n" ;

		List<PeFactorManual> peFactorManualList = simpleDao.getNativeQueryList(sqlStr,PeFactorManual.class);

		Map<String, Map<String, Object>> result = new HashMap<>();
		for(int i=0;i<peFactorManualList.size();i++){
			PeFactorManual peFactorManual = peFactorManualList.get(i);
			result.put(peFactorManual.getPluCode(), BeanUtil.beanToMap(peFactorManual,false,true));
		}
		return result;
	}

	/**
	 * 根据排口ID ，污染源因子编码判断是否有重复因子信息
	 * @param outputId 排口ID
	 * @param pluCode  污染源因子编码
	 * @return
	 */
	public boolean isSameFactor(String outputId ,String pluCode){
		boolean isFlag = false;
	    String sqlStr = "SELECT  count(*) from PE_FACTOR_MANUAL \n" +
					 	"where OUTPUT_ID = '"+outputId+"' and PLU_CODE = '"+pluCode+"' ";
	    List list = simpleDao.createNativeQuery(sqlStr).getResultList();
		if (list.size() <=0)return false ;
		int sameCount = Integer.valueOf(list.get(0).toString()) ;
		if (sameCount > 0){
			isFlag = true ;
		}
		return isFlag;
	 }

	/**
	 * 获取下拉因子列表
	 * @return
	 */
	public JSONArray getComponentFactorManual(){
		JSONArray factorManualjsonArray = new JSONArray();
		String sql = "SELECT PLU_CODE ,PLU_NAME from PE_DICTIONARY_INFO\n" +
					"where PLU_CODE is not NULL";
		List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
		for(int i=0;i<list.size();i++) {
			Object []  obj = list.get(i);
			JSONObject  jsonObject = new JSONObject();
			jsonObject.put("id",obj[0]);
			jsonObject.put("text",obj[1]);
			factorManualjsonArray.add(jsonObject);
		}
		return factorManualjsonArray;
	}

}
