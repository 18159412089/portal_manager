/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

import com.fjzxdz.ams.module.area.entity.SiteMonitorData;
import com.fjzxdz.ams.module.area.dao.SiteMonitorDataDao;
import com.fjzxdz.ams.module.area.param.SiteMonitorDataParam;

/**
 * 近岸海域监测数据Service
 * @author htj
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class SiteMonitorDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(SiteMonitorDataService.class);

	@Autowired
	private SiteMonitorDataDao siteMonitorDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	 
	
	/**
	 * 分页查询
	 * @param siteMonitorData
	 * @param page
	 * @return
	 */
	public Page<SiteMonitorData> listByPage(SiteMonitorDataParam siteMonitorDataParam, Page<SiteMonitorData> page) {
		Page<SiteMonitorData> listPage = siteMonitorDataDao.listByPage(siteMonitorDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param siteMonitorData
	 */
	public void save(SiteMonitorData siteMonitorData) {
		/*if (StringUtils.isNotEmpty(siteMonitorData.getUuid())) {
			siteMonitorDataDao.update(siteMonitorData);
		}else{
			siteMonitorData.setUuid(null);
			siteMonitorDataDao.save(siteMonitorData);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		siteMonitorDataDao.deleteById(uuid);
	}
	
	
	
	/**
	 * 获取左侧列名信息
	 */
	public JSONArray getLeftMenuColumnName(){
		JSONArray jsonArray = new JSONArray() ;
		String queryString  = "select ut.COLUMN_NAME,uc.comments from user_tab_columns  ut inner JOIN user_col_comments uc on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name where ut.Table_Name='AREA_SITE_MONITOR_DATA' and  ut.DATA_TYPE = 'NUMBER'";
		List<Map<String, Object>> list	=  jdbcTemplate.queryForList(queryString);
		jsonArray.add(list);
		  
		return jsonArray;
	}
/**
 * 
 * @param skbm 省控编码
 * @param columnName 列名
 * @return
 */
   public JSONObject getSiteMonitorDataInfo(String skbm ,String columnName){
	   JSONObject siteMonitorDataObject = new JSONObject();
	   siteMonitorDataObject.put("monitorName", columnName);
	   String columnStr = "";
	   if (columnName.contains("_")) {
		  int noChangeIndex = columnName.indexOf("_")+1;
		  for(int i = 0 ; i < columnName.length() ; i++){
			   char simgleName =  columnName.charAt(i);
			   if (i == noChangeIndex) {
				   columnStr = columnStr+ String.valueOf(simgleName);
			   }else{
				   columnStr = columnStr+ String.valueOf(simgleName).toLowerCase();
			   }
		  }
		  columnName = columnStr.replace("_", "");
	   }else{
		  columnName = columnName.toLowerCase();
	   }
	  
	   String queryString = "select  sd.siteMonitorDataPk.JCSJ,sd."+columnName+" from  SiteMonitorData as sd where sd.siteMonitorDataPk.skCode ='"+skbm+"'" +" order by sd.siteMonitorDataPk.JCSJ desc";
	   Query query =  siteMonitorDataDao.createQuery(queryString);
	   List<Object[]> list =  query.getResultList();
	   JSONArray  jcsjArr = new JSONArray();
	   JSONArray  monitorValueArr = new JSONArray();
	   for (Object[] objects : list) {
		    jcsjArr.add(objects[0] == null ? "": new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(objects[0]) );
			 
		    monitorValueArr.add(objects[1] == null ? "":objects[1]);
		    siteMonitorDataObject.put("jcsjArr", jcsjArr);
		    siteMonitorDataObject.put("monitorValueArr", monitorValueArr);
	  }
	   return siteMonitorDataObject;
   }
	
	
	
}
