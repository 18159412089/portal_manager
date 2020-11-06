package com.fjzxdz.ams.zphb.module.enviromonit.air.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.OtherDBSimpleCurdUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;

import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirEnvironmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 大气环境 大气环境服务页面 数据
 * @Author   zhongyunlong
 * @Version   1.0
 * @CreateTime 2019年4月29日 上午10:25:06
 */
@Controller
@RequestMapping("/zphb/enviromonit/airEnvironment")
@Secured({ "ROLE_USER" })
public class ZpAirEnvironmentController extends BaseController {

	@Autowired
	private ZpAirEnvironmentService zpAirEnvironmentService;

	@Autowired
	private SimpleDao simpleDao;

	/**
	 *
	 * @Title:  index
	 * @Description:    跳转到大气环境服务页面
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:13:00
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午2:13:00    
	 * @return  String
	 * @param  pid菜单跳转(点击监控情况target跳转),pointName 大屏展示点击行政区跳转
	 * @throws
	 */
	@RequestMapping("")
	public ModelAndView index(String pid,String target,String pointName, ModelAndView modelAndView) {
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("target", target);
		modelAndView.addObject("pointName", pointName);
		modelAndView.setViewName("/zphb/moudles/enviromonit/air/airEnvironment");

		return modelAndView;
	}

	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView modelAndView,String airPointCode,String airPointType,String pid) {
		modelAndView.addObject("airPointCode", airPointCode);
		modelAndView.addObject("airPointType", airPointType);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/enviromonit/air/airEnvironment");
		return modelAndView;
	}

	@RequestMapping("/test")
	public ModelAndView test(ModelAndView modelAndView) {
		modelAndView.addObject("pid", "8cc443b5-53d2-4db0-b2f7-f0901df961ea");
		modelAndView.setViewName("/moudles/enviromonit/air/test_lhn");
		return modelAndView;
	}

	/**
	 *
	 * @Title:  getDataAnalysisCityPoint
	 * @Description:    点击地图上的点显示的窗口中。数据分析的数据显示。    
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:16:04
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午2:16:04    
	 * @param polluteName
	 * @param pointCode
	 * @param time
	 * @return  Map<String,Object>
	 * @throws
	 */
	@RequestMapping("/getDataAnalysisCityPoint")
	@ResponseBody
	public Map<String, Object> getDataAnalysisCityPoint(String polluteName,String pointCode,String time) {
		Map<String, Object> map = zpAirEnvironmentService.getDataAnalysisCityPoint(polluteName, pointCode, time);
		return map;
	}

	/**
	 *
	 * @Title:  getPolluteWaterData
	 * @Description:    污普废气企业基本信息显示
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:19:34
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午2:19:34    
	 * @return  R
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getPolluteAirData")
	@ResponseBody
	public R getPolluteWaterData() {
		String sql = "select distinct QYMC,LONGITUDE,LATITUDE,ADDRESS from POLLUTION_AIR_DATA where LONGITUDE is not null and qx like '%漳浦%'";
		List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
		Map<String, Object> map = new HashMap<String, Object>();
		JSONArray jsonAry = new JSONArray();
		for (Object[] objects : list) {
			JSONObject json = new JSONObject();
			json.put("name", StringUtils.nullToString(objects[0]));
			json.put("lng", StringUtils.nullToString(objects[1]));
			json.put("lat", StringUtils.nullToString(objects[2]));
			json.put("address", StringUtils.nullToString(objects[3]));
			jsonAry.add(json);
		}
		map.put("data", jsonAry);
		return R.ok(map);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/getPolluteList")
	@ResponseBody
	public PageEU<?> getPolluteList(@RequestParam(value = "page", required = false) Integer page,
									@RequestParam(value = "rows", required = false) Integer rows,
									@RequestParam(value = "qymc", required = false) String qymc, HttpServletRequest request) {

		Page dataPage = new Page<>();
		if (page != null) {
			dataPage.setCurrentPage(page - 1);
		}
		if (rows != null) {
			dataPage.setLimit(rows);
		}

		String sql = "select distinct QYMC name,LONGITUDE lng,LATITUDE lat,ADDRESS from POLLUTION_AIR_DATA where qx='漳浦县'";
		if (!StringUtils.isNull(qymc)) {
			sql += " AND QYMC like '%" + qymc + "%'";
		}
		simpleDao.listNativeByPage(sql, dataPage);
		return new PageEU<>(dataPage);
	}

	/**
	 * 	@SuppressWarnings("unchecked")
	 * @Title:  getPolluteWaterDataDetail
	 * @Description:    污普废水企业的详细显示
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:24:09
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午2:24:09    
	 * @param qymc
	 * @return  R
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getPolluteAirDataDetail")
	@ResponseBody
	public R getPolluteWaterDataDetail(String qymc) {
		String sql = "SELECT LXR,QX,DS,LXDH,WRWNAME,PFL FROM POLLUTION_AIR_DATA d"
				+ " WHERE (d.QYMC,d.YEAR) in (SELECT QYMC,MAX(YEAR) FROM POLLUTION_AIR_DATA GROUP BY QYMC)"
				+ " and QYMC = '"+qymc+"'";
		List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
		Map<String, Object> map = new HashMap<String, Object>();
		JSONArray jsonAry = new JSONArray();
		for (Object[] objects : list) {
			JSONObject json = new JSONObject();
			json.put("lxr", StringUtils.nullToString(objects[0]));
			json.put("qx", StringUtils.nullToString(objects[1]));
			json.put("ds", StringUtils.nullToString(objects[2]));
			json.put("lxdh", StringUtils.nullToString(objects[3]));
			json.put("wrw", StringUtils.nullToString(objects[4]));
			json.put("pfl", StringUtils.nullToString(objects[5]));
			jsonAry.add(json);
		}
		map.put("data", jsonAry);
		return R.ok(map);
	}

	/**
	 * 获取问题受理系统中的气环保事件
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAirCaseList")
	@ResponseBody
	public JSONObject getAirCaseList(HttpServletRequest request) throws Exception {
		String des = request.getParameter("des");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Integer rows = Integer.parseInt(request.getParameter("rows"));
		Integer page = Integer.parseInt(request.getParameter("page"));

		StringBuilder typeWhere = new StringBuilder("SELECT id FROM dbo.web_xproject_problem_processing_problem_type where name LIKE '%大气污染%' AND (parentId IS NULL OR parentId='')");
		StringBuilder whereStr = new StringBuilder("");
		StringBuilder whereStr2 = new StringBuilder(" where a.rn > " + page * rows + " and a.rn <= " + (page + 1) * rows);

		if (!StringUtils.isNull(des)) {
			whereStr.append(" and (describe like '%" + des + "%') ");
		}
		if (!StringUtils.isNull(startTime)) {
			whereStr.append(" and ('" + startTime + "'<=[reportTime]) ");
		}
		if (!StringUtils.isNull(endTime)) {
			whereStr.append(" and ([reportTime]<'" + endTime + "') ");
		}
		//添加漳浦查询过滤条件
		//vVPUlBmGVGdL9u70oUp0Ii为漳浦网格ID
		whereStr.append(" and (c.id in (select id from dbo.fn_web_xproject_joint_service_base_get_all_department_by_dept_id('vVPUlBmGVGdL9u70oUp0Ii'))) ");

		String columnStr = " b.*," +
				"dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_SOURCE_NAME', b.[source]) AS [sourceName]," +
				"dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[majorTypeId]) AS [majorTypeIdName]," +
				"dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[smallTypeId]) AS [smallTypeIdName]," +
				"dbo.fjzx_frame_fn_format_date_time(b.[reportTime]) AS [reportFormatTime]," +
				"dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_OPERATION', b.[status]) AS [statusName]," +
				"dbo.fjzx_frame_fn_get_system_code_name('CASE_OVER_TIME_STATUS', b.[overTimeStatus]) AS [overTimeStatusName]," +
				"dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_CASE_TYPE', b.[caseType]) AS [caseTypeName]," +
				"dbo.[fjzx_frame_fn_get_system_code_name]('USER', b.[createBy]) AS  createByName," +
				"dbo.fn_web_common_get_department_of_organization_by_department(c.id) AS departmentIdName," +
				"dbo.fjzx_frame_fn_get_system_code_name('USER_LEVEL', c.departmentType) AS userLevel," +
				"COUNT(1) OVER() AS resultTotalCount " +
				"FROM web_xproject_problem_processing_case b " +
				"LEFT JOIN dbo.web_common_department_position d ON b.positionId=d.id " +
				"LEFT JOIN dbo.web_common_department c ON c.id=d.departmentId ";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("typeWhere", typeWhere.toString());
		paramMap.put("column", columnStr);
		paramMap.put("where", whereStr.toString());
		paramMap.put("where2", whereStr2.toString());

		cn.hutool.json.JSONArray waterCaseList = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "problemProcessing_commonly_case_list", paramMap);

		JSONObject data = new JSONObject();
		data.put("data", waterCaseList);
		if(waterCaseList.size()>0){
			data.put("maxSize", waterCaseList.getJSONObject(0).get("resultTotalCount"));
		}else{
			data.put("maxSize", 0);
		}
		data.put("page", page + 1);
		data.put("pageSize", rows);

		return data;
	}

}
