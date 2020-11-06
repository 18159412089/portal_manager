package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.debriefing.dao.CommonRelationTableDao;
import com.fjzxdz.ams.module.debriefing.dao.EnvCancellationAccountDao;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentDutyUserDao;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentRectifitionDao;
import com.fjzxdz.ams.module.debriefing.entity.*;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentRectifitionParam;
import com.fjzxdz.ams.module.enums.EvnRectifitionEnum;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentRectifitionService;
import org.apache.commons.collections.MapUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

/**
 * 
 * 环境整治service实现类
 * @author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年4月22日 下午4:39:39
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class ZpEnvironmentRectifitionServiceImpl implements ZpEnvironmentRectifitionService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpEnvironmentRectifitionServiceImpl.class);

	@Autowired
	private EnvironmentRectifitionDao rectifitionDao;
	@Autowired
	private EnvironmentDutyUserDao environmentDutyUserDao;

	@Autowired
	private CommonRelationTableDao relationTableDao;

	@Autowired
	private EnvCancellationAccountDao envCancellationAccountDao;

	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 
	 * <p>Title: listByPage</p>   
	 * <p>Description: 环保督察整改汇总表 - 列表</p>   
	 * @param param
	 * @param page
	 * @return   
	 * @see ZpEnvironmentRectifitionService#listByPage(EnvironmentRectifitionParam, Page)
	 */
	@Override
	public Page<EnvironmentRectifition> listByPage(EnvironmentRectifitionParam param,
												   Page<EnvironmentRectifition> page) {
		//        return rectifitionDao.listByPage(param, page);
		String sql = "select new EnvironmentRectifition(project.uuid,describle.uuid,uuid,question,require,category,status,project.name,describle.name,createTime," +
				"timelimit,dutyDepartment,dutyPerson,dutyUnit,leadPerson,leadUnit,matchUnit,involveDepartment,involvePerson,wornTime," +
				"areaCode, cityCode) ";
		Page<EnvironmentRectifition> result = rectifitionDao.listByPage(sql+param.getQueryString(), param.getParams(),page);
		return result;
	}

	/**
	 * 漳州市环保督察整改汇总图表查询项目数量  【现在是查询出所有项目，时间不控】
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<EnvironmentRectifitionChart> getProjectCountByCity(String status, String startTime, String endTime) {
		//List<EnvironmentRectifitionChart> environmentRectifitionChartList= new ArrayList<EnvironmentRectifitionChart>();
		String sql = "select (" +
				"select COUNT(b.CITY_CODE) " +
				"FROM ENVIRONMEENT_RECTIFITION b" +
				" where b.CITY_CODE=a.POINT_CODE ";
		if(StringUtils.isNotEmpty(status)){
			sql +=	"and status='"+status+"'";
		}
		if(StringUtils.isNotEmpty(startTime)){
			sql +=	" and b.NUM_OF_ROUND_VALUE ='" +startTime+"' ";
		}
		sql +=	") AS COUNT," +
				"a.POINT_CODE," +
				"a.POINT_NAME " +
				"from AIR_MONITOR_POINT a " +
				"where a.POINT_TYPE = 1 " ;
		List<EnvironmentRectifitionChart> environmentRectifitionChartList = simpleDao.getNativeQueryList(sql, EnvironmentRectifitionChart.class);
//		for(Object object:list){
//			EnvironmentRectifitionChart environmentRectifitionChart = BeanUtil.toBean(object,EnvironmentRectifitionChart.class);
//			environmentRectifitionChartList.add(environmentRectifitionChart);
//		}
		return environmentRectifitionChartList;
	}

	/**
	 * 漳州市环保首页 完成销号超过30天验收
	 * @param type
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<EnvCancellationAccount> getCancelNumberTimeoutData(String type, String startTime, String endTime) {
		//List<EnvCancellationAccount> envCancellationAccountList= new ArrayList<EnvCancellationAccount>();
		String sql = "SELECT " +
				" b. NAME AS project_Name, " +
				" A .name as project_id, "  +
				" A .SCHEDULE, "  +
				" A .CREATE_DATE, "  +
				" A .COUNTY_ACTUAL_TIME, "  +
				" A .CITY_ACTUAL_TIME, "  +
				" A .PROFESSION_ACTUAL_TIME, "  +
				" A .PROFESSION_EXAMINE_TIME "  +
				" FROM " +
				" ENV_CANCELLATION_ACCOUNT A " +
				" LEFT JOIN COMMON_RELATION_TABLE b ON A . NAME = b.uuid " +
				" WHERE " +
				" TO_CHAR ( A .CREATE_DATE + 30, 'yyyy-mm-dd')" ;
		if("COUNTY_ACTUAL_TIME".equals(type)){//实际县级验收时间
			sql+=   " < TO_CHAR ( A .COUNTY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("CITY_ACTUAL_TIME".equals(type)){//实际市级验收时间
			sql+=   " < TO_CHAR ( A .CITY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("PROFESSION_ACTUAL_TIME".equals(type)){//实际提交行业验收时间
			sql+=   " < TO_CHAR ( A .PROFESSION_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("PROFESSION_EXAMINE_TIME".equals(type)){//完成行业审查时间
			sql+=   " < TO_CHAR ( A .PROFESSION_EXAMINE_TIME,'yyyy-mm-dd') ";
		}
		sql+=   " AND ROWNUM <= 3 " +
				" ORDER BY " +
				" CREATE_DATE DESC" ;
		List<EnvCancellationAccount> envCancellationAccountList = simpleDao.getNativeQueryList(sql, EnvCancellationAccount.class);
//		for(Object object:list){
//			EnvCancellationAccount envCancellationAccount = BeanUtil.toBean(object,EnvCancellationAccount.class);
//			envCancellationAccountList.add(envCancellationAccount);
//		}
		return envCancellationAccountList;
	}
	/**
	 *
	 * <p>Title: getById</p>
	 * <p>Description: 环保督察整改汇总表 - 获取设置状态列表</p>
	 * @param uuid
	 * @return
	 * @see ZpEnvironmentRectifitionService#getById(String)
	 */
	@Override
	public EnvironmentRectifition getById(String uuid) {
		return rectifitionDao.getById(uuid);
	}

	/**
	 *
	 * <p>Title: save</p>
	 * <p>Description:  环保督察整改汇总表  - 新增任务    </p>
	 * @param rectifition
	 * @see ZpEnvironmentRectifitionService#save(EnvironmentRectifition)
	 */
	@Override
	public String save(EnvironmentRectifition rectifition) {
		//if (checkExistProj(rectifition,false)) return "此项目已经被占用，请重新选择！";
		if(ToolUtil.isEmpty(rectifition.getUuid())) {
			rectifition.setUuid(null);
			rectifition.setWornTime("0");
			if(ToolUtil.isNotEmpty(rectifition.getProjectId())) {
				CommonRelationTable commonRelationTable = relationTableDao.getById(rectifition.getProjectId());
				rectifition.setProject(commonRelationTable);
				//获取num 同步relation table表
				String numOfRoundValue = rectifition.getNumOfRoundValue();
				int length = numOfRoundValue.length();
				List<Map> getNum = simpleDao.getNativeQueryList("SELECT *  FROM COMMON_RELATION_TABLE WHERE RELATION ='NUM_OF_ROUND_ZP' AND  CODE = '" + (length > 4 ? numOfRoundValue.substring(length - 5, length - 1) : numOfRoundValue) + "'");
				Map map = getNum.get(0);
				rectifition.setNum(MapUtils.getString(map, "num"));
				rectifition.setNumOfRoundValue(MapUtils.getString(map, "code"));
				rectifition.setNumOfRoundName(MapUtils.getString(map, "name"));
			}
			if(ToolUtil.isNotEmpty(rectifition.getDescribleId())) {
				rectifition.setDescrible(relationTableDao.getById(rectifition.getDescribleId()));
			}
			if(ToolUtil.isNotEmpty(rectifition.getLimit())) {
				rectifition.setTimelimit(DateUtil.parseDate(rectifition.getLimit()));
			}
			//销号时间  如果是已完成交账销号，则销号时间不为空
			setSendAccountDate(rectifition, rectifition);
			rectifitionDao.save(rectifition);
			if(EvnRectifitionEnum.SENDACCOUNT.equals(rectifition.getStatus())) {
				EnvCancellationAccount account = new EnvCancellationAccount();
				if(ToolUtil.isNotEmpty(rectifition.getProjectId())) {
					account.setProject(relationTableDao.getById(rectifition.getProjectId()));
				}
				if(ToolUtil.isNotEmpty(rectifition.getDescribleId())) {
					account.setDescrible(relationTableDao.getById(rectifition.getDescribleId()));
				}
				if(ToolUtil.isNotEmpty(rectifition.getLimit())) {
					account.setTimeLimit(DateUtil.parseDate(rectifition.getLimit()));
				}
				account.setSchedule("已完成");
				account.setRectifitionUuid(rectifition.getUuid());
				envCancellationAccountDao.save(account);
			}
		}else {
			EnvironmentRectifition temp = rectifitionDao.getById(rectifition.getUuid());
			temp.setTransient();
			temp.setStatus(rectifition.getStatus());
			//销号时间  如果是已完成交账销号，则销号时间不为空
			setSendAccountDate(rectifition, temp);
			rectifitionDao.update(temp);
			if(EvnRectifitionEnum.SENDACCOUNT.equals(rectifition.getStatus())) {
				List<EnvCancellationAccount> selectList = envCancellationAccountDao.selectList("from EnvCancellationAccount where rectifitionUuid=?",temp.getUuid());
				if(selectList.size()!=0) {
					EnvCancellationAccount account = selectList.get(0);
					account.setProject(relationTableDao.getById(temp.getProjectId()));
					account.setDescrible(relationTableDao.getById(temp.getDescribleId()));
					account.setTimeLimit(temp.getTimelimit());
					envCancellationAccountDao.save(account);
				}else {
					EnvCancellationAccount account = new EnvCancellationAccount();
					account.setProject(relationTableDao.getById(temp.getProjectId()));
					account.setDescrible(relationTableDao.getById(temp.getDescribleId()));
					account.setTimeLimit(temp.getTimelimit());
					account.setSchedule("已完成");
					account.setRectifitionUuid(temp.getUuid());
					envCancellationAccountDao.save(account);
				}

			}else {
				String sql="DELETE FROM ENV_CANCELLATION_ACCOUNT WHERE RECTIFITION_UUID=?";
				envCancellationAccountDao.createNativeQuery(sql, temp.getUuid()).executeUpdate();
			}

		}
		return "";
	}

	/**
	 * 设置销号时间：当状态为SENDACCOUNT("SENDACCOUNT","完成交账销号",5);则销号时间不为空
	 * @param rectifition
	 * @param temp
	 */
	private void setSendAccountDate(EnvironmentRectifition rectifition, EnvironmentRectifition temp) {
		if (EvnRectifitionEnum.SENDACCOUNT.equals(rectifition.getStatus())) {
			temp.setTimelimit(new Date());
		} else {
			temp.setTimelimit(null);
		}
	}

	/**
	 *
	 * <p>Title: getEcharts</p>
	 * <p>Description: 环保督察总体情况    - 柱状图</p>
	 * @param startTime
	 * @param endTime
	 * @return
	 * @see ZpEnvironmentRectifitionService#getEcharts(Date, Date)
	 */
	@Override
	public JSONObject getEcharts(String startTime, String endTime) {
		List<EnvironmentRectifition> list = rectifitionDao.selectList("from EnvironmentRectifition where numOfRoundValue=? AND mark = ? ", startTime,"ZP");
		JSONObject result = new JSONObject();
		//未达到序时进度
		int nr = 0;
		//达到序时进度
		int ot = 0;
		//超过序时进度
		int ps = 0;
		//完成整改
		int ov = 0;
		//完成交账销号
		int sa = 0;
		//尚未启动
		int ns = 0;

		List<String> xAxisData = new ArrayList<>();
		List<Integer> seriesDataList= new ArrayList<>();
		String seriesData = "";
		if(ToolUtil.isNotEmpty(list)) {
			List<String> projectIds = new ArrayList<>();
			Map<String, String> projectNames = new HashMap<>();
			Map<String, Map<String,Integer>> map = new HashMap<>();
			String uuid = "";
			for(EnvironmentRectifition account: list) {
				uuid = account.getProject().getUuid();
				if(!projectIds.contains(uuid)) {
					projectIds.add(uuid);
					projectNames.put(uuid,account.getProject().getName());
					Map<String,Integer> mapValue = new HashMap<>();
					mapValue.put("nr", 0);
					mapValue.put("ot", 0);
					mapValue.put("ps", 0);
					mapValue.put("ov", 0);
					mapValue.put("sa", 0);
					mapValue.put("ns", 0);
					map.put(uuid, mapValue);
				}
				if (EvnRectifitionEnum.NOTREACH.equals(account.getStatus())) {
					nr++;
					map.get(uuid).put("nr", map.get(uuid).get("nr")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.NOTREACH.getNum() );//每个项目到达的状态
				} else if (EvnRectifitionEnum.ONTIME.equals(account.getStatus())) {
					ot++;
					map.get(uuid).put("ot", map.get(uuid).get("ot")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.ONTIME.getNum() );//每个项目到达的状态
				} else if (EvnRectifitionEnum.PASS.equals(account.getStatus())) {
					ps++;
					map.get(uuid).put("ps", map.get(uuid).get("ps")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.PASS.getNum() );//每个项目到达的状态
				} else if (EvnRectifitionEnum.OVER.equals(account.getStatus())) {
					ov++;
					map.get(uuid).put("ov", map.get(uuid).get("ov")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.OVER.getNum() );//每个项目到达的状态
				} else if (EvnRectifitionEnum.SENDACCOUNT.equals(account.getStatus())) {
					sa++;
					map.get(uuid).put("sa", map.get(uuid).get("sa")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.SENDACCOUNT.getNum() );//每个项目到达的状态
				} else if (EvnRectifitionEnum.NOTSTART.equals(account.getStatus())) {
					ns++;
					map.get(uuid).put("ns", map.get(uuid).get("ns")+1);
					map.get(uuid).put("status",EvnRectifitionEnum.NOTSTART.getNum() );//每个项目到达的状态
				}
			}

            Integer status ;
			for(int i=0; i<projectIds.size(); i++) {
				//				xAxisData.add(projectNames.get(projectIds.get(i)) + "," + map.get(projectIds.get(i)).get("nr") + "," + map.get(projectIds.get(i)).get("ot")
				//						+ "," + map.get(projectIds.get(i)).get("ps") + "," + map.get(projectIds.get(i)).get("ov") + "," + map.get(projectIds.get(i)).get("sa") + "," + map.get(projectIds.get(i)).get("ns") + "," + projectIds.get(i) + "," + map.get(projectIds.get(i)).get("status"));
                status = map.get(projectIds.get(i)).get("status");
                xAxisData.add(projectNames.get(projectIds.get(i)) + "," + projectIds.get(i) + "," + status);
				seriesDataList.add(status);
			}
			//X轴数据从高到底排序
			Collections.sort(xAxisData, (o1, o2) -> new Integer(Integer.parseInt(o2.split(",")[2])).compareTo(new Integer(Integer.parseInt(o1.split(",")[2]))));
			//状态从高到底排序
			Collections.sort(seriesDataList, Comparator.reverseOrder());
		}
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年M月dd日");
//		SimpleDateFormat paseStr = new SimpleDateFormat("yyyy-MM-dd");
//		String curDay = null;
//		//如果endtime大于当前时间，则取当前时间
//		if (DateUtil.compareDate(paseStr.format(endTime), paseStr.format(new Date()))) {
//			curDay = sdf.format(new Date());
//		} else {
//			curDay = sdf.format(endTime);
//		}
		seriesData=StringUtils.join(seriesDataList,",");
		result.put("time", startTime+"年");
		result.put("xAxisData", xAxisData);
		result.put("seriesData", seriesData);
		result.put("nr", nr);
		result.put("ot", ot);
		result.put("ps", ps);
		result.put("ov", ov);
		result.put("sa", sa);
		result.put("ns", ns);
		return result;
	}

	/**
	 *
	 * <p>Title: getPieEcharts</p>
	 * <p>Description: 环保督察总体情况	-	饼图    </p>
	 * @param startTime
	 * @param endTime
	 * @return
	 * @see ZpEnvironmentRectifitionService#getPieEcharts(String, String)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public JSONObject getPieEcharts(String startTime, String endTime) {
		List<Object[]> list = simpleDao.createNativeQuery("select b.name,a.status,a.UUID from ENVIRONMEENT_RECTIFITION a "
				+ "LEFT JOIN COMMON_RELATION_TABLE b on a.name=b.UUID where A.MARK = 'ZP' AND  a.NUM_OF_ROUND_VALUE = ? ", startTime).getResultList();

		JSONObject result = new JSONObject();
		if(ToolUtil.isNotEmpty(list)) {
			Map<String,String> map = new HashMap<>();
			for(Object[] obj: list) {
				if(obj[0]!=null) {
					map.put(obj[2].toString(), EvnRectifitionEnum.valueOf(obj[1].toString()).getValue());
				}
			}
			Map<String, Integer> val = new HashMap<>();
			JSONArray legend = new JSONArray();
			int i = 0;
			for(EvnRectifitionEnum element : EvnRectifitionEnum.values()) {
				for(Map.Entry<String, String> entry : map.entrySet()) {
					if(element.getValue().equals(entry.getValue())) {
						if(val.containsKey(element.getValue())) {
							int temp = val.get(element.getValue());
							val.put(element.getValue(), temp+1);
						}else {
							val.put(element.getValue(), 1);
						}
					}
				}

				JSONObject temp = new JSONObject();
				temp.put("orient", "horizontal");
				if(i<3) {
					temp.put("x", i*33.3+"%");
					temp.put("y", "10%");
				}else {
					temp.put("x", (i-3)*33.3+"%");
					temp.put("y", "15%");
				}
				temp.put("align", "left");
				String[] data = new String[1];
				data[0] = element.getValue();
				temp.put("data", data);
				temp.put("textStyle", JSONObject.parse("{fontSize:'difSize_legend'}"));
				legend.add(temp);
				i++;
			}
			String[] color = {"#99A3AF","#884FA9","#FFBF26","#F05040","#51A1FA","#65B149"};
			JSONArray josn = new JSONArray();
			for(EvnRectifitionEnum element : EvnRectifitionEnum.values()) {
				JSONObject temp = new JSONObject();
				temp.put("name", element.getValue());
				temp.put("itemStyle", JSONObject.parse("{color:'"+color[element.getNum()]+"'}"));
				if(val.containsKey(element.getValue())) {
					temp.put("value", val.get(element.getValue()));
				}else {
					temp.put("value", 0);
				}
				josn.add(temp);
			}
			result.put("series", josn);
			result.put("legend", legend);
		}
		return result;
	}

	/**
	 * <p>Title: getCount</p>
	 * <p>Description: </p>
	 * @param param
	 * @return
	 * @see ZpEnvironmentRectifitionService#getCount(EnvironmentRectifitionParam)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public JSONObject getCount(EnvironmentRectifitionParam param) {
		JSONObject jsonObject = new JSONObject();
		int sum = 0;
		String sql = "SELECT e.STATUS ,COUNT(e.STATUS)  FROM ENVIRONMEENT_RECTIFITION e INNER JOIN  COMMON_RELATION_TABLE  c ON e.NAME = c.UUID where E.MARK ='ZP' ";
		if (ToolUtil.isNotEmpty(param.getName())) {
			sql += " and c.name like '%"+param.getName()+"%'";
		}
		if (ToolUtil.isNotEmpty(param.getStatus())) {
			sql += " and e.status = '" + param.getStatus() +"'";
		}
		if (ToolUtil.isNotEmpty(param.getTimelimit())) {
			sql += " and TO_CHAR(e.TIMELIMIT,'yyyy-mm-dd') = '" +param.getLimitStr()+"'";
		}
		sql += " GROUP BY e.STATUS";
		List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
		if (ToolUtil.isNotEmpty(list)) {
			for (Object[] objects : list) {
				if(!ToolUtil.isEmpty(objects[0])) {
					jsonObject.put(objects[0].toString(), objects[1]);
					sum += Integer.valueOf(String.valueOf(objects[1]));
				}
			}
			jsonObject.put("time", param.getLimitStr());
			jsonObject.put("size", sum);
		}else {
			jsonObject.put("size", 0);
		}
		return jsonObject;
	}

	/**
	 * <p>Title: getDecription</p>
	 * <p>Description: 环保督察总体情况 - 点击柱状图或者横轴项目名称打开窗口 获取描述列表</p>
	 * @param id
	 * @param status
	 * @return
	 * @see ZpEnvironmentRectifitionService#( String, String)
	 */
	@Override
	public Page<Map<String, Object>> getDecription(String id, String status,String startTime, String endTime, Page<Map<String, Object>> page) {
		String sql = "SELECT a.UUID,a.DESCRIBE,b.NAME FROM ENVIRONMEENT_RECTIFITION a INNER JOIN COMMON_RELATION_TABLE b ON a.DESCRIBE=b.UUID "
				+ "WHERE a.NAME='" + id + "' AND a.NUM_OF_ROUND_VALUE = '" + startTime + "'";
		//点击横轴项目名称显示该项目的描述列表
		if (!"undefined".equals(status)) {
			sql += " AND STATUS='"+status+"'";
		}
		return simpleDao.listNativeByPage(sql,page);
	}

	/**
	 * <p>Title: getDetail</p>
	 * <p>Description: 环保督察总体情况  - 柱状图弹窗  - 查看详情 </p>
	 * @param id
	 * @param page
	 * @return
	 * @see ZpEnvironmentRectifitionService#getDetail(String, Page)
	 */
	@Override
	public Page<Map<String, Object>> getDetail(String id, Page<Map<String, Object>> page) {
		String sql="SELECT c. NAME AS project_name,D . NAME AS describle_name,C.UUID AS project_id,D.UUID AS describle_id, A .*\n" +
				" FROM\n" +
				"(\n" +
				" SELECT\n" +
				"  b.*,\n" +
				"  CEIL ((SYSDATE + b.WORN_TIME - b.TIMELIMIT) * 24 * 60 * 60 * 1000) AS TIMES,\n" +
				"  (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=b.AREA_CODE AND POINT_TYPE='1') AS area_name,\n" +
				"  (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=b.CITY_CODE AND POINT_TYPE='1') AS city_name\n" +
				" FROM\n" +
				"  ENVIRONMEENT_RECTIFITION b\n" +
				") A\n" +
				" LEFT JOIN COMMON_RELATION_TABLE c ON A . NAME = c.UUID\n" +
				" LEFT JOIN COMMON_RELATION_TABLE D ON A .DESCRIBE = D .UUID\n" +
				" WHERE a.UUID='"+id+"'";
		return simpleDao.listNativeByPage(sql,page);
	}

	/**
	 * <p>Title: getDecriptionAll</p>
	 * <p>Description:环保督察总体情况 - 点击饼图打开窗口 </p>
	 * @param status
	 * @param page
	 * @return
	 * @see ZpEnvironmentRectifitionService#( String, Page)
	 */
	@Override
	public Page<Map<String, Object>> getDecriptionAll(String status,String startTime, String endTime, Page<Map<String, Object>> page) {
		String sql="SELECT a.UUID,c.NAME,b.NAME DESCRIBE FROM ENVIRONMEENT_RECTIFITION a INNER JOIN COMMON_RELATION_TABLE b ON a.DESCRIBE=b.UUID INNER JOIN COMMON_RELATION_TABLE c ON a.NAME=c.UUID WHERE a.mark ='ZP' and STATUS='"+status+"' and a.NUM_OF_ROUND_VALUE = '"+startTime+"' ";
		return simpleDao.listNativeByPage(sql,page);
	}

	/**
	 * <p>Title: deleteByUuid</p>
	 * <p>Description:环保督察整改汇总表 - 删除     </p>
	 * @param uuid
	 * @return
	 * @see ZpEnvironmentRectifitionService#deleteByUuid(String)
	 */
	@Override
	public void deleteByUuid(String uuid) {
		String sql1="DELETE FROM ENV_CANCELLATION_ACCOUNT WHERE RECTIFITION_UUID='"+uuid+"'";
		String sql2="DELETE FROM ENVIRONMEENT_RECTIFITION WHERE UUID='"+uuid+"'";
		simpleDao.createNativeQuery(sql1).executeUpdate();
		simpleDao.createNativeQuery(sql2).executeUpdate();
	}

	/**
	 * <p>Title: saveRectifition</p>
	 * <p>Description: 环保督察整改汇总表 - 编辑后的保存</p>
	 * @param rectifition
	 * @see ZpEnvironmentRectifitionService#saveRectifition(EnvironmentRectifition)
	 */
	@Override
	public String saveRectifition(EnvironmentRectifition rectifition) {
		//if (checkExistProj(rectifition, true)) return "此项目已经被占用，请重新选择！";

		if(!StringUtils.isNull(rectifition.getUuid())) {
			EnvironmentRectifition temp = rectifitionDao.getById(rectifition.getUuid());
			temp.setTransient();
			if(ToolUtil.isNotEmpty(rectifition.getProjectId())) {
				CommonRelationTable commonRelationTable = relationTableDao.getById(rectifition.getProjectId());
				temp.setProject(commonRelationTable);
				//获取num 同步relation table表
				String numOfRoundValue = rectifition.getNumOfRoundValue();
				int length = numOfRoundValue.length();
				List<Map> getNum = simpleDao.getNativeQueryList("SELECT *  FROM COMMON_RELATION_TABLE WHERE RELATION ='NUM_OF_ROUND_ZP' AND  CODE = '" + (length > 4 ? numOfRoundValue.substring(length - 5, length - 1) : numOfRoundValue) + "'");
				Map map = getNum.get(0);
				temp.setNum(MapUtils.getString(map, "num"));
				temp.setNumOfRoundValue(MapUtils.getString(map, "code"));
				temp.setNumOfRoundName(MapUtils.getString(map, "name"));
			}
			if(ToolUtil.isNotEmpty(rectifition.getDescribleId())) {
				CommonRelationTable commonRelationTable = relationTableDao.getById(rectifition.getDescribleId());
				temp.setDescrible(commonRelationTable);
			}
			if(ToolUtil.isNotEmpty(rectifition.getLimit())) {
				temp.setTimelimit(DateUtil.parseDate(rectifition.getLimit()));
			}
			if(EvnRectifitionEnum.SENDACCOUNT.equals(rectifition.getStatus())) {
				List<EnvCancellationAccount> selectList = envCancellationAccountDao.selectList("from EnvCancellationAccount where rectifitionUuid=?",temp.getUuid());
				if(selectList.size()!=0) {
					EnvCancellationAccount account=selectList.get(0);
					if(ToolUtil.isNotEmpty(rectifition.getProjectId())) {
						account.setProject(relationTableDao.getById(rectifition.getProjectId()));
					}
					if(ToolUtil.isNotEmpty(rectifition.getDescribleId())) {
						account.setDescrible(relationTableDao.getById(rectifition.getDescribleId()));
					}
					envCancellationAccountDao.update(account);
				}else {
					EnvCancellationAccount account=new EnvCancellationAccount();
					if(ToolUtil.isNotEmpty(rectifition.getProjectId())) {
						account.setProject(relationTableDao.getById(rectifition.getProjectId()));
					}
					if(ToolUtil.isNotEmpty(rectifition.getDescribleId())) {
						account.setDescrible(relationTableDao.getById(rectifition.getDescribleId()));
					}
					if(ToolUtil.isNotEmpty(temp.getTimelimit())) {
						account.setTimeLimit(temp.getTimelimit());
					}
					account.setSchedule("已完成");
					account.setRectifitionUuid(temp.getUuid());
					envCancellationAccountDao.save(account);
				}
			}else {
				String sql="DELETE FROM ENV_CANCELLATION_ACCOUNT WHERE RECTIFITION_UUID=?";
				envCancellationAccountDao.createNativeQuery(sql, temp.getUuid()).executeUpdate();
			}
			setDutyUserInfo(temp);
			temp.setStatus(rectifition.getStatus());
			temp.setCategory(rectifition.getCategory());
			temp.setQuestion(rectifition.getQuestion());
			temp.setRequire(rectifition.getRequire());
			temp.setCreateTime(rectifition.getCreateTime());
			temp.setMark("ZP");

			//销号时间  如果是已完成交账销号，则销号时间不为空
			setSendAccountDate(rectifition, temp);
			rectifitionDao.update(temp);
		}
		return "";

	}

	/**
	 * 判断是否存在项目被占用
	 * @param rectifition
	 * @param b true为编辑的时候验正 false 为新增的时候验正
	 * @return
	 */
	private boolean checkExistProj(EnvironmentRectifition rectifition, boolean b) {
		StringBuilder sb = new StringBuilder(" SELECT COUNT(1) FROM ENVIRONMEENT_RECTIFITION T  WHERE T.NAME = ?  ");
		List resultList = null;
		//判断这个项目是否被占用
		if (b) {
			sb.append(" and t.uuid <> ?");
			resultList = simpleDao.createNativeQuery(sb.toString(), rectifition.getProjectId(), rectifition.getUuid()).getResultList();
		} else {
			resultList = simpleDao.createNativeQuery(sb.toString(), rectifition.getProjectId()).getResultList();
		}
		if ("0".equals(resultList.get(0).toString())) {
			return false;
		}
		return true;
	}

	/**
	 * 汇总表模块编辑同步到责任名单模块
	 * @param temp
	 */
	private void setDutyUserInfo(EnvironmentRectifition temp) {
		StringBuilder sb = new StringBuilder(" update  environmeent_duty_user T  set ");
		sb.append(" t.duty_department= '").append(temp.getDutyDepartment()).append("' ,");
		sb.append(" t.duty_unit= '").append(temp.getDutyUnit()).append("' ,");
		sb.append(" t.duty_person= '").append(temp.getDutyPerson()).append("' ,");
		sb.append(" t.lead_person= '").append(temp.getLeadPerson()).append("' ,");
		sb.append(" t.lead_unit= '").append(temp.getLeadUnit()).append("' ,");
		sb.append(" t.match_unit= '").append(temp.getMatchUnit()).append("' ,");
		sb.append(" t.involve_person= '").append(temp.getInvolvePerson()).append("' ,");
		sb.append(" t.involve_department= '").append(temp.getInvolveDepartment()).append("' ");
		sb.append(" where t.project_id = '").append(temp.getProjectId()).append("' ");
		simpleDao.createNativeQuery(sb.toString()).executeUpdate();
	}

	/**
	 * 【责任名单】导入数据保存
	 * @param result
	 * @return
	 */
	@Override
	public String save(String[][] result) {
		List<EnvironmentDutyUser> list = new ArrayList<EnvironmentDutyUser>();
		for (int i = 0; i < result.length; i++) {
			String[] row = result[i];
			EnvironmentDutyUser dutyUser = new EnvironmentDutyUser();
			dutyUser.setDutyPerson(row[1]);
			dutyUser.setDutyDepartment(row[2]);
			dutyUser.setDutyUnit(row[3]);
			dutyUser.setInvolvePerson(row[4]);
			dutyUser.setInvolveDepartment(row[5]);
			dutyUser.setLeadPerson(row[6]);
			dutyUser.setLeadUnit(row[7]);
			dutyUser.setMatchUnit(row[8]);
			dutyUser.setDutyPersonPhone(row[9]);
			list.add(dutyUser);
		}
		environmentDutyUserDao.saveBatch(list);
		return "";
	}

	/**
	 * 获取未设置项目的数据
	 * @param page
	 * @return
	 */
	@Override
	public Page<Map<String, Object>> getNoSetProjList(Page<Map<String, Object>> page) {
		StringBuilder sb = new StringBuilder(" SELECT t.*,b.name project_Name FROM  ENVIRONMEENT_DUTY_USER T  ");
		sb.append(" LEFT JOIN COMMON_RELATION_TABLE B   ON  B.UUID = T.PROJECT_ID ORDER BY T.CREATE_DATE DESC ");
		return simpleDao.listNativeByPage(sb.toString(),page);
	}


	/**
	 * 通过projectid查找汇总表记录并赋值责任名单上的字段
	 * @param dutyUser
	 * @return
	 */
	@Override
	public String saveDutyUser(EnvironmentDutyUser dutyUser) {

		String message = "";
		setRectifionInfo(dutyUser);//通过projectid查找汇总表记录并赋值责任名单上的字段
		environmentDutyUserDao.update(dutyUser);
		return message;
	}

	/**
	 * 责任名单上的字段同步到汇总表模块
	 * @param dutyUser
	 */
	private void setRectifionInfo(EnvironmentDutyUser dutyUser) {
		StringBuilder sb = new StringBuilder(" update  environmeent_rectifition T  set ");
		sb.append(" t.duty_department= '").append(dutyUser.getDutyDepartment()).append("' ,");
		sb.append(" t.duty_unit= '").append(dutyUser.getDutyUnit()).append("' ,");
		sb.append(" t.duty_person= '").append(dutyUser.getDutyPerson()).append("' ,");
		sb.append(" t.lead_person= '").append(dutyUser.getLeadPerson()).append("' ,");
		sb.append(" t.lead_unit= '").append(dutyUser.getLeadUnit()).append("' ,");
		sb.append(" t.match_unit= '").append(dutyUser.getMatchUnit()).append("' ,");
		sb.append(" t.involve_person= '").append(dutyUser.getInvolvePerson()).append("' ,");
		sb.append(" t.involve_department= '").append(dutyUser.getInvolveDepartment()).append("' ,");
		sb.append(" t.duty_person_phone= '").append(dutyUser.getDutyPersonPhone()).append("' ");
		sb.append(" where t.name = '").append(dutyUser.getProjectId()).append("' ");
		simpleDao.createNativeQuery(sb.toString()).executeUpdate();
	}

	/**
	 * 通过主键删除责任名单数据
	 * @param uuid
	 */
	@Override
	public void deleteDutyUser(String uuid) {
		environmentDutyUserDao.deleteById(uuid);
	}

	/**
	 * 获取预警列表
	 * @param param
	 * @param page
	 * @return
	 */
	@Override
	public Page<EnvironmentRectifition> getWornListByPage(EnvironmentRectifitionParam param, Page<EnvironmentRectifition> page) {
		Page<EnvironmentRectifition> rectifitionPage = null;
		try {
			StringBuilder sql = new StringBuilder("SELECT  commonrela1_.NAME AS project_name,commonrela2_.NAME AS describle_name,commonrela1_.UUID AS project_id,commonrela2_.UUID AS describle_id,a.* ");
			sql.append(" from ( select t.*, ");
			sql.append("        (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=t.CITY_CODE AND POINT_TYPE='1') AS city_name,");//查询行政区划及所属市区
			sql.append("        (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=t.area_CODE AND POINT_TYPE='1') AS area_name ");//查询行政区划及所属市区
			sql.append(" from environmeent_rectifition t where t.mark ='ZP' ) a ");
			sql.append("  CROSS JOIN common_relation_table commonrela1_");
			sql.append("        CROSS JOIN common_relation_table commonrela2_ ");
			sql.append("      WHERE a.name = commonrela1_.uuid AND a.describe = commonrela2_.uuid ");
			if (!"spzs".equals(param.getStatus()))
			sql.append("        and ceil(a.TIMELIMIT  - To_date(to_char(sysdate , 'yyyy-mm-dd hh24-mi-ss'),'yyyy-mm-dd hh24-mi-ss')) <= a.worn_time");
			String areaCode = param.getAreaCode();
			if (StringUtils.isNotEmpty(areaCode)) {
				sql.append(" and a.AREA_CODE =  '").append(areaCode).append("' ");
			}
			if (StringUtils.isNotEmpty(param.getName())) {
				sql.append(" and a.name =  '").append(param.getName()).append("' ");
			}
			if (StringUtils.isNotEmpty(param.getStatus())&&!"spzs".equals(param.getStatus())) {
				sql.append(" and a.status =  '").append(param.getStatus()).append("' ");
			}if (StringUtils.isNotEmpty(param.getStatus())&&"spzs".equals(param.getStatus())) {
				sql.append(" and a.status in ('NOTSTART','NOTREACH','ONTIME','PASS') ");
			}
			if (StringUtils.isNotEmpty(param.getCityCode())) {
				sql.append(" and a.CITY_CODE =  '").append(param.getCityCode()).append("' ");
			}
			if (ObjectUtil.isNotNull(param.getTimelimit())) {
				sql.append(" and to_char(a.TIMELIMIT,'yyyy-MM-dd') = '").append(DateUtil.formatDate(param.getTimelimit(), "yyyy-MM-dd")).append("' ");
			}
			sql.append("      ORDER BY a.create_date,a.uuid desc ");
			rectifitionPage = simpleDao.listNativeByPage(sql.toString(), page);
		} catch (Exception e) {
			logger.info("获取预警列表：{}", e);
			e.printStackTrace();
		}
		return rectifitionPage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public  List<EnvironmentRectifition> allWornList() {
		List<EnvironmentRectifition> list = new ArrayList<EnvironmentRectifition>();
		String sql = "SELECT c.NAME AS project_name,D.NAME AS describle_name,A.*\n" +
				" FROM ENVIRONMEENT_RECTIFITION A\n" +
				" LEFT JOIN COMMON_RELATION_TABLE c ON A.NAME = c.UUID\n" +
				" LEFT JOIN COMMON_RELATION_TABLE D ON A.DESCRIBE = D.UUID\n" +
				" where a.mark ='ZP' and ceil(a.TIMELIMIT  - To_date(to_char(sysdate , 'yyyy-mm-dd hh24-mi-ss'),'yyyy-mm-dd hh24-mi-ss')) <= a.worn_time\n" +
				" ORDER BY A.CREATE_TIME DESC ";
		list = simpleDao.createNativeQuery(sql, EnvironmentRectifition.class);
		return list;
	}
	/**
	 * 设置预警天数
	 * @param warnTime
	 * @return
	 */
	@Override
	public void setWarnDay(String warnTime) {
		try {
			StringBuilder sql = new StringBuilder("UPDATE ENVIRONMEENT_RECTIFITION SET WORN_TIME = ? where mark ='ZP' ");
			simpleDao.createNativeQuery(sql.toString(),warnTime).executeUpdate();
		} catch (Exception e) {
			logger.info("设置预警天数出错：{0}", e);
			e.printStackTrace();
		}

	}

	/**
	 * <p>Title: getProjectDetail</p>
	 * <p>Description: 查看详情 </p>
	 * @param name
	 * @param page
	 * @return
	 * @see ZpEnvironmentRectifitionService#getProdectDetail(String, Page)
	 */  
	@Override
	public Page<Map<String, Object>> getProjectDetail(String id, Page<Map<String, Object>> page) {
		String sql="SELECT c. NAME AS project_name,D . NAME AS describle_name,C.UUID AS project_id,D.UUID AS describle_id, A .*\n" +
				" FROM\n" +
				"(\n" +
				" SELECT\n" +
				"  b.*,\n" +
				"  CEIL ((SYSDATE + b.WORN_TIME - b.TIMELIMIT) * 24 * 60 * 60 * 1000) AS TIMES,\n" +
				"  (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=b.AREA_CODE AND POINT_TYPE='1') AS area_name,\n" +
				"  (select POINT_NAME FROM AIR_MONITOR_POINT where POINT_CODE=b.CITY_CODE AND POINT_TYPE='1') AS city_name\n" +
				" FROM\n" +
				"  ENVIRONMEENT_RECTIFITION b\n" +
				") A\n" +
				" LEFT JOIN COMMON_RELATION_TABLE c ON A . NAME = c.UUID\n" +
				" LEFT JOIN COMMON_RELATION_TABLE D ON A .DESCRIBE = D .UUID\n" +
				" WHERE a.name='"+id+"'";
		return simpleDao.listNativeByPage(sql,page);
	}


    /**
     * 获取轮数：第一轮  第二轮。。。
     * @return
     */
    @Override
    public List getNumOfRound() {
        StringBuilder sql = new StringBuilder(" SELECT T.UUID,T.NAME name ,T.CODE id,T.NUM,T.RELATION  FROM COMMON_RELATION_TABLE  T ");
		sql.append(" WHERE T.RELATION ='NUM_OF_ROUND_ZP' AND  NUM IS NOT NULL ORDER BY NUM ");
		List<Map> numList = simpleDao.getNativeQueryList(sql.toString());
		return numList;
	}

	/**
	 * 获取下一轮轮数或者之前被删除的轮数
	 * @return
	 * @param c
	 */
	@Override
	public List getNextRound(String c) {
		StringBuilder sql = new StringBuilder(" SELECT * FROM COMMON_RELATION_TABLE WHERE RELATION ='NUM_OF_ROUND_ZP' AND  NUM IS NOT NULL ORDER BY NUM DESC ");
		List<Map> list = simpleDao.getNativeQueryList(sql.toString());
		List<Integer> result = new ArrayList();
		if (!ToolUtil.isNotEmpty(list)) {
			return result;
		}
		Map maxNumMap = list.get(0);
		BigDecimal maxNum = (BigDecimal) maxNumMap.get("num");
		boolean flag = false;
		for (int i = 1; i <= maxNum.intValue(); i++) {
			for (int j = 0; j < list.size(); j++) {
				Map map = list.get(j);
				if (i == ((BigDecimal) map.get("num")).intValue()) {
					flag = true;
				}
			}
			if (!flag) {
				result.add(i);
			}
			flag = false;
		}
		result.add(maxNum.intValue() + 1);
		if (ToolUtil.isNotEmpty(c)) {
			result.add(Integer.parseInt(c));
			//从高到底排序
			Collections.sort(result, new Comparator<Integer>() {
				@Override
				public int compare(Integer o1, Integer o2) {
					return o1.compareTo(o2);
				}
			});
		}
		return result;
	}
}

