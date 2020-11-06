package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.debriefing.dao.CommonTaskTableDao;
import com.fjzxdz.ams.module.debriefing.entity.CommonTaskTable;
import com.fjzxdz.ams.module.debriefing.param.CommonTaskTableParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpCommonTaskTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Transactional(rollbackFor=Exception.class)
/**
 * 
 * 包含实现八闽快讯（一本账）的业务
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午2:06:28
 */
public class ZpCommonTaskTableServiceImpl implements ZpCommonTaskTableService {

	@Autowired
	private CommonTaskTableDao commonTaskTableDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 
	 * <p>Title: getPageList</p>   
	 * <p>Description:  八闽快讯汇总表   - 分页列表  </p>   
	 * @param param
	 * @param page
	 * @return   
	 * @see ZpCommonTaskTableService#getPageList(CommonTaskTableParam, Page)
	 */
	@Override
	public Page<CommonTaskTable> getPageList(CommonTaskTableParam param, Page<CommonTaskTable> page) {
		String sql="SELECT UUID,RELATION_CODE,RELATION_NAME,PROBLEM,TARGET_REQUIRE,EXISTING_PROBLEM,STATUS,CREATE_TIME FROM COMMON_TASK_TABLE";
		if(!ToolUtil.isEmpty(param.getQueryTime())) {
			String startTime = param.getQueryTime()+"-01";
			String endTime = DateUtil.getLastDayOfMonth(DateUtil.parse(param.getQueryTime(), "yyyy-MM"), "");
			sql+=" WHERE CREATE_TIME>=TO_DATE('"+startTime+"','yyyy-mm-dd') AND CREATE_TIME<=TO_DATE('"+endTime+"', 'yyyy-mm-dd')";
			if(!ToolUtil.isEmpty(param.getStatus())) {
				sql+=" AND STATUS ="+param.getStatus();
			}
		}else if(!ToolUtil.isEmpty(param.getStatus())){
			sql+=" WHERE STATUS ="+param.getStatus();
		}
		sql+=" ORDER BY CREATE_TIME DESC";
		//List<Object[]> resultList = commonTaskTableDao.createNativeQuery(sql).getResultList();
		return simpleDao.listNativeByPage(sql, page);
		//return commonTaskTableDao.listByPage(sql, page);
	}

	/**
	 *
	 * <p>Title: setStatus</p>
	 * <p>Description:  八闽快讯汇总表    - 设置状态</p>
	 * @param uuid
	 * @param status
	 * @return
	 * @see ZpCommonTaskTableService#setStatus(String, BigDecimal)
	 */
	@Override
	public int setStatus(String uuid, BigDecimal status) {
		String sql="UPDATE COMMON_TASK_TABLE SET STATUS=? WHERE UUID=?";
		int i = commonTaskTableDao.createNativeQuery(sql,status,uuid).executeUpdate();
		return i;
	}

	/**
	 *
	 * <p>Title: getRelationNameList</p>
	 * <p>Description: 八闽快讯汇总表 - 获取项目  list   </p>
	 * @param relation
	 * @return
	 * @see ZpCommonTaskTableService#getRelationNameList(String)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getRelationNameList(String relation) {
		String sql="SELECT UUID,NAME FROM COMMON_RELATION_TABLE WHERE RELATION=? ORDER BY CREATE_DATE DESC";
		List<Object[]> resultList = commonTaskTableDao.createNativeQuery(sql, relation).getResultList();
		return resultList;
	}

	/**
	 *
	 * <p>Title: addTask</p>
	 * <p>Description: 八闽快讯  - 新增任务</p>
	 * @param commonTaskTable
	 * @return
	 * @see ZpCommonTaskTableService#addTask(CommonTaskTable)
	 */
	@Override
	public int addTask(CommonTaskTable commonTaskTable) {
		CommonTaskTable update = commonTaskTableDao.update(commonTaskTable);
		if(update!=null) {
			return 1;
		}
		return 0;
	}

	/**
	 *
	 * <p>Title: getChartList</p>
	 * <p>Description:八闽快讯（一本账）总体情况柱状图 和饼图 </p>
	 * @param start
	 * @param end
	 * @return
	 * @see ZpCommonTaskTableService#getChartList(String, String)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public JSONObject getChartList(String start,String end) {
		String sql="SELECT RELATION_CODE,RELATION_NAME,STATUS,COUNT(STATUS) FROM COMMON_TASK_TABLE";
		String sql1="";
		if(ToolUtil.isNotEmpty(start)&&ToolUtil.isNotEmpty(end)) {
			start = start+"-01";
			end = DateUtil.getLastDayOfMonth(DateUtil.parse(end, "yyyy-MM"), "");
			sql+=" WHERE CREATE_TIME>=TO_DATE('"+start+" 00:00:00','yyyy-mm-dd hh24:mi:ss') AND CREATE_TIME<=TO_DATE('"+end+" 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			String start1="";
			String end1="";
			if(start.split("-")[1].equals(end.split("-")[1])) {
				start1=DateUtil.getDay(DateUtil.addMonth(DateUtil.parseDate(start), -1));
				end1 = DateUtil.getLastDayOfMonth(DateUtil.parse(start1, "yyyy-MM-dd"), "yyyy-MM-dd");
			}else {
				start1=start;
				end1 = DateUtil.getLastDayOfMonth(DateUtil.parse(DateUtil.getDay(DateUtil.addMonth(DateUtil.parseDate(end), -1)), "yyyy-MM"), "yyyy-MM-dd");
			}
			sql1="SELECT TO_CHAR(COUNT(*)) FROM COMMON_TASK_TABLE WHERE CREATE_TIME>=TO_DATE('"+start1+" 00:00:00','yyyy-mm-dd hh24:mi:ss') AND CREATE_TIME<=TO_DATE('"+end1+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
		}
		sql+=" GROUP BY RELATION_CODE,RELATION_NAME,STATUS ORDER BY RELATION_CODE";
		JSONObject jsonObject=new JSONObject();
		JSONArray jsonArray=new JSONArray();
		JSONArray jsonArray1=new JSONArray();
		JSONArray jsonArray2=new JSONArray();
		JSONArray jsonArray3=new JSONArray();
		JSONArray count=new JSONArray();
		JSONArray pieData=new JSONArray();
		JSONArray pieName=new JSONArray();
		List<Object[]> list = commonTaskTableDao.createNativeQuery(sql).getResultList();
		if(!"".equals(sql1)) {
			List list1 = commonTaskTableDao.createNativeQuery(sql1).getResultList();
			if(list1!=null) {
				Object o =list1.get(0);
				jsonObject.put("lastSum",o.toString());
			}
		}
		int i=-1;
		int sum=0;
		JSONArray temp=null;
		for(Object[] objects:list) {
			String name=StringUtils.nullToString(objects[1])+","+StringUtils.nullToString(objects[0]);
			if(pieName.contains(StringUtils.nullToString(objects[1])+","+StringUtils.nullToString(objects[0]))) {
				i=pieName.indexOf(StringUtils.nullToString(objects[1])+","+StringUtils.nullToString(objects[0]));
			}else {
				if(i!=-1) {
					String[] tempStr=new String[temp.size()];
					String str = StringUtils.nullToString(jsonArray.get(i));
					tempStr=temp.toArray(tempStr);
					String s = str+","+StringUtils.join(tempStr,",");
					jsonArray.set(i,s);
				}
				temp=new JSONArray(3);
				temp.set(2, "");
				i++;
				jsonArray1.add(i, "");
				jsonArray2.add(i, "");
				jsonArray3.add(i, "");
				count.add(i,0);
				pieName.add(i,StringUtils.nullToString(objects[1])+","+StringUtils.nullToString(objects[0]));
				jsonArray.add(i,name);
			}
			count.set(i,Integer.parseInt(count.get(i).toString())+Integer.parseInt(objects[3].toString()));
			sum+=Integer.parseInt(objects[3].toString());
			if(StringUtils.nullToString(objects[2]).equals("3")) {
				jsonArray1.set(i,StringUtils.nullToString(objects[2]));
				temp.set(0, StringUtils.nullToString(objects[3]));
			}else if(StringUtils.nullToString(objects[2]).equals("2")) {
				jsonArray2.set(i,StringUtils.nullToString(objects[2]));
				temp.set(1, StringUtils.nullToString(objects[3]));
			}else if(StringUtils.nullToString(objects[2]).equals("1")) {
				jsonArray3.set(i,StringUtils.nullToString(objects[2]));
				temp.set(2, StringUtils.nullToString(objects[3]));
			}
		}
		if(temp!=null) {
			String[] tempStr=new String[temp.size()];
			String str = StringUtils.nullToString(jsonArray.get(i));
			tempStr=temp.toArray(tempStr);
			String s = str+","+StringUtils.join(tempStr,",");
			jsonArray.set(i,s);
		}
		jsonObject.put("name", jsonArray);
		jsonObject.put("array1", jsonArray1);
		jsonObject.put("array2", jsonArray2);
		jsonObject.put("array3", jsonArray3);
		for(int j=0;j<count.size();j++) {
			pieName.set(j, pieName.get(j)+"： "+count.get(j)+" 个");
			pieData.add(JSONObject.parse("{value:" + count.get(j) + ",name:'" + pieName.get(j) + "',itemStyle: {normal: {}}}"));
		}
		jsonObject.put("pieData", pieData);
		jsonObject.put("pieName", pieName);
		jsonObject.put("sum", sum);
		return jsonObject;
	}

	/**
	 *
	 * <p>Title: getDescript</p>
	 * <p>Description: 八闽快讯（一本账）总体情况描述 </p>
	 * @param param
	 * @return
	 * @see ZpCommonTaskTableService#getDescript(CommonTaskTableParam)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public R getDescript(CommonTaskTableParam param) {
		JSONObject jsonObject=new JSONObject();

		String sql="SELECT STATUS,COUNT(*) FROM COMMON_TASK_TABLE";
		String sql1="";
		if(ToolUtil.isNotEmpty(param.getQueryTime())) {
			String start1=param.getQueryTime()+"-01";
			String end1=DateUtil.getLastDayOfMonth(DateUtil.parse(start1, "yyyy-MM-dd"), "yyyy-MM-dd");
			sql+=" WHERE CREATE_TIME>=TO_DATE('"+start1+" 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND CREATE_TIME<=TO_DATE('"+end1+" 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			String start2=DateUtil.getDay(DateUtil.addMonth(DateUtil.parseDate(start1), -1));
			String end2 = DateUtil.getLastDayOfMonth(DateUtil.parse(start2, "yyyy-MM-dd"), "yyyy-MM-dd");
			sql1="SELECT COUNT(*) FROM COMMON_TASK_TABLE WHERE CREATE_TIME>=TO_DATE('"+start2+" 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND CREATE_TIME<=TO_DATE('"+end2+" 00:00:00', 'yyyy-mm-dd hh24:mi:ss') ";
			if(ToolUtil.isNotEmpty(param.getStatus())) {
				sql+=" AND STATUS="+param.getStatus();
				sql1+=" AND STATUS="+param.getStatus();
			}
		}else if(ToolUtil.isNotEmpty(param.getStatus())) {
			sql+=" WHERE STATUS="+param.getStatus();
			sql1+=" WHERE STATUS="+param.getStatus();
		}
		sql+=" GROUP BY STATUS";
		List<Object[]> resultList = commonTaskTableDao.createNativeQuery(sql).getResultList();
		List resultList1 = commonTaskTableDao.createNativeQuery(sql1).getResultList();
		if(resultList1!=null) {
			Object o =resultList1.get(0);
			jsonObject.put("lastSum",o.toString());
		}
		int sum=0;
		for(Object[] objects:resultList) {
			jsonObject.put("status"+StringUtils.nullToString(objects[0]), StringUtils.nullToString(objects[1]));
			sum+=Integer.valueOf(StringUtils.nullToString(objects[1]));
		}
		jsonObject.put("sum", sum);
		return R.ok(jsonObject);
	}

	/**
	 * <p>Title: save</p>
	 * <p>Description: 八闽快讯（一本账）汇总表 - 修改任务</p>
	 * @param commonTaskTable
	 * @see ZpCommonTaskTableService#save(CommonTaskTable)
	 */
	@Override
	public void save(CommonTaskTable commonTaskTable) {
		if(ToolUtil.isNotEmpty(commonTaskTable.getUuid())) {
			CommonTaskTable taskTable = commonTaskTableDao.getById(commonTaskTable.getUuid());
			taskTable.setRelationCode(commonTaskTable.getRelationCode());
			taskTable.setRelationName(commonTaskTable.getRelationName());
			taskTable.setProblem(commonTaskTable.getProblem());
			taskTable.setTargetRequire(commonTaskTable.getTargetRequire());
			taskTable.setExistingProblem(commonTaskTable.getExistingProblem());
			taskTable.setCreateTime(DateUtil.parseDate(commonTaskTable.getCreatetime()));
			commonTaskTableDao.update(taskTable);
		}
	}

	/**
	 * <p>Title: delete</p>
	 * <p>Description: 八闽快讯（一本账）汇总表 - 删除任务</p>
	 * @param uuid
	 * @see ZpCommonTaskTableService#delete(String)
	 */  
	@Override
	public void delete(String uuid) {
		if(ToolUtil.isNotEmpty(uuid)) {
			commonTaskTableDao.deleteById(uuid);
		}
		
	}

}
