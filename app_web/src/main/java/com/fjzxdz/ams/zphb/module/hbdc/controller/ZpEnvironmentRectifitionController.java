package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.LayuiUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvCancellationAccount;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDutyUser;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifitionChart;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentRectifitionParam;
import com.fjzxdz.ams.module.enums.EvnRectfCatogoryEnum;
import com.fjzxdz.ams.module.enums.EvnRectifitionEnum;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentRectifitionService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * 环境整治controller实现类 ，环保督察总体情况，整改汇总表
 * @author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年4月22日 下午4:36:38
 */
@Controller
@RequestMapping("/zphb/environment/rectifition")
@Secured({ "ROLE_USER" })
public class ZpEnvironmentRectifitionController extends BaseController {

	@Autowired
	private ZpEnvironmentRectifitionService rectifitionService;
	@Autowired
	private SimpleDao simpleDao;
	
	@Secured({ "ROLE_USER" })
	@RequestMapping("")
	public ModelAndView index(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/EnvironmentRectifitionListZp");
		return modelAndView;
	}

	@RequestMapping("/show")
	public ModelAndView show(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/EnvironmentRectifitionIndexZp");
		return modelAndView;
	}

	/**
	 *
	 * @param modelAndView 页面模型
	 * @param authority 判断是否有编辑功能
	 * @param chartIndex 判断退出编辑是显示的页面
	 * @return
	 */
    @RequestMapping("/rectifitionListIntex")
    public ModelAndView rectifitionListIntex(ModelAndView modelAndView,String authority,String chartIndex,String pid) {
        modelAndView.addObject("authority", authority);
        modelAndView.addObject("chartIndex",chartIndex);
        modelAndView.addObject("pid",pid);
        modelAndView.setViewName("/zphb/moudles/hbdc/EnvironmentRectifitionListIntexZp");
        return modelAndView;
    }
	@RequestMapping("/rectifitionListChart")
	public ModelAndView rectifitionListChart(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/EnvironmentRectifitionListChartZp");
		return modelAndView;
	}
	/**
	 * 跳转责任名单页面
	 * @param modelAndView
	 * @return
	 */
    @RequestMapping("/responsibleList")
	public ModelAndView responsibleList(ModelAndView modelAndView,String pid) {
		modelAndView.setViewName("/zphb/moudles/hbdc/responsibleListZp");
		modelAndView.addObject("pid", pid);
		return modelAndView;
	}

//	/**
//	 *
//	 * @Title:  list
//	 * @Description:    环保督察整改汇总表 - 列表
//	 * @CreateBy:
//	 * @CreateTime: 2019年5月10日 上午10:22:29
//	 * @UpdateBy:
//	 * @UpdateTime:  2019年5月10日 上午10:22:29
//	 * @param param
//	 * @param request
//	 * @return  PageEU<EnvironmentRectifition>
//	 * @throws
//	 */
//	@RequestMapping("/list")
//	@ResponseBody
//	public PageEU<EnvironmentRectifition> list(EnvironmentRectifitionParam param, HttpServletRequest request,HttpServletResponse response) {
//		Page<EnvironmentRectifition> page = pageQuery(request);
//		Page<EnvironmentRectifition> rectifitionPage = rectifitionService.listByPage(param, page);
//        //导出
//		if ("yes".equals(request.getParameter("export"))) {
//			List<EnvironmentRectifition> result = new ArrayList<EnvironmentRectifition>();
//			for (int i = 0; i < rectifitionPage.getResult().size(); i++) {
//				EnvironmentRectifition  environmentRectifition =  rectifitionPage.getResult().get(i);
//				environmentRectifition.setCt(environmentRectifition.getCreateTime());
//				for(EvnRectfCatogoryEnum element : EvnRectfCatogoryEnum.values()) {
//					if (element.getKey().equals(environmentRectifition.getCategory())) {
//						environmentRectifition.setCategory(element.getValue());
//						break;
//					}
//				}
//				for(EvnRectifitionEnum el : EvnRectifitionEnum.values()) {
//					if (el.getKey().equals(environmentRectifition.getStatus().getKey())) {
//						environmentRectifition.setStatusName(environmentRectifition.getStatus().getValue());
//						break;
//					}
//				}
//
//				result.add(environmentRectifition);
//			}
//			//定义Excel 字段名称
//			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
//			columnMap.put("title", "漳州市环保督察整改汇总表");
//			columnMap.put("ct", "创建时间");
//			columnMap.put("category", "归类");
//			columnMap.put("projectName", "项目");
//			columnMap.put("areaCode", "行政区划");
//			columnMap.put("cityCode", "所属城市");
//			columnMap.put("describleName", "问题简述");
//			columnMap.put("timelimit", "整改时限");
//			columnMap.put("require", "任务具体整改要求");
//			columnMap.put("question", "目前进展情况及存在问题");
//			columnMap.put("dutyPerson", "责任人");
//			columnMap.put("dutyDepartment", "责任部门");
//			columnMap.put("dutyUnit", "责任单位");
//			columnMap.put("involveDepartment", "涉及部门");
//			columnMap.put("involvePerson", "涉及人员");
//			columnMap.put("leadPerson", "牵头人");
//			columnMap.put("leadUnit", "牵头单位");
//			columnMap.put("matchUnit", "配合单位");
//			ExcelExportUtil.exportExcel(response, columnMap, result);
//			return null;
//		}
//		return new PageEU<>(rectifitionPage);
//	}
//
	/**
	 * 列表查询以及导出查询列表
	 * lilongan
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/listNew")
	@ResponseBody
	public PageEU<EnvironmentRectifition> listNew(EnvironmentRectifitionParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<EnvironmentRectifition> page = pageQuery(request);
		String startTime = request.getParameter("startTime");
		StringBuilder sql = new StringBuilder(" select * from ( ");
		String sqlStr = "SELECT c. NAME AS project_name,D . NAME AS describle_name,C.UUID AS project_id,D.UUID AS describle_id,f.pkid,f.PICTURE,f.picname, A .*\n" +
				"FROM\n" +
				"(\n" +
				" SELECT\n" +
				"  b.*,\n" +
				"  CEIL ((SYSDATE + b.WORN_TIME - b.TIMELIMIT) * 24 * 60 * 60 * 1000) AS TIMES " +
				" FROM\n" +
				"  ENVIRONMEENT_RECTIFITION b\n" +
				") A\n" +
				" LEFT JOIN COMMON_RELATION_TABLE c ON A . NAME = c.UUID\n" +
				" LEFT JOIN COMMON_RELATION_TABLE D ON A .DESCRIBE = D .UUID\n" +
				" LEFT JOIN FILE_ATTACHMENT f ON f.pkid = c.UUID and c.code = 'ENVIRONMEENT_RECTIFITION_03') " +
				" WHERE UUID is not null and mark = 'ZP' ";
		if (StringUtils.isNotEmpty(param.getName())) {
			sqlStr = sqlStr + " and NAME = '" + param.getName() + "'";
		}
		if (StringUtils.isNotEmpty(param.getAreaCode())) {
			sqlStr = sqlStr + " and (describle_name like '%" + param.getAreaCode() + "%' or REQUIRE like '%" + param.getAreaCode() + "%') ";
		}
		if (StringUtils.isNotEmpty(param.getCityCode())) {
			sqlStr = sqlStr + " and A.CITY_CODE ='" + param.getCityCode() + "'";
		}
		if (StringUtils.isNotEmpty(param.getStatus())) {
			sqlStr = sqlStr + " and STATUS ='" + param.getStatus() + "'";
		}
		if (ObjectUtil.isNotNull(param.getTimelimit())) {
			sqlStr = sqlStr + " and TO_CHAR(TIMELIMIT,'yyyy-MM-dd') ='" + DateUtil.formatDate(param.getTimelimit(), "yyyy-MM-dd") + "'";
		}
		//漳浦环保督察整改汇总图表 按照第一轮第二轮查询
		if (StringUtils.isNotEmpty(startTime)) {
			sqlStr = sqlStr + " and NUM_OF_ROUND_VALUE = '"+startTime+"'";

		}
		sqlStr = sqlStr + " ORDER BY TIMES,uuid DESC";
		sql.append(sqlStr);
		Page<EnvironmentRectifition> rectifitionPage = simpleDao.listNativeByPage(sql.toString(), page);
		// 导出所有
		if ("yes".equals(request.getParameter("export"))) {
			return exportEnvironmentRectifitionExl(response, rectifitionPage);
		}

		return new PageEU<>(rectifitionPage);
	}

	/**
	 * 导出Excel 全部 整改时间延期  --整改汇总表
	 * @param response
	 * @param rectifitionPage
	 * @return
	 */
	private PageEU<EnvironmentRectifition> exportEnvironmentRectifitionExl(HttpServletResponse response, Page<EnvironmentRectifition> rectifitionPage) {
		List<EnvironmentRectifition> result = new ArrayList<EnvironmentRectifition>();
		for (int i = 0; i < rectifitionPage.getResult().size(); i++) {
			try {
				EnvironmentRectifition environmentRectifition = BeanUtil.toBean(rectifitionPage.getResult().get(i),
						EnvironmentRectifition.class);
				environmentRectifition.setCt(environmentRectifition.getCreateTime());
				for (EvnRectfCatogoryEnum element : EvnRectfCatogoryEnum.values()) {
					if (element.getKey().equals(environmentRectifition.getCategory())) {
						environmentRectifition.setCategory(element.getValue());
						break;
					}
				}
				for (EvnRectifitionEnum el : EvnRectifitionEnum.values()) {
					if (el.getKey().equals(environmentRectifition.getStatus().getKey())) {
						environmentRectifition.setStatusName(environmentRectifition.getStatus().getValue());
						break;
					}
				}

				result.add(environmentRectifition);
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

		}
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "漳浦环保督察整改汇总表");
		columnMap.put("ct", "创建时间");
//		columnMap.put("category", "归类");
		columnMap.put("projectName", "项目");
		columnMap.put("describleName", "问题简述");
		/*columnMap.put("timelimit", "整改时限");*/
		columnMap.put("require", "任务具体整改要求");
		columnMap.put("question", "目前进展情况及存在问题");
		columnMap.put("areaCode", "行政区划");
		columnMap.put("cityCode", "所属城市");
		columnMap.put("dutyPerson", "责任人");
		columnMap.put("dutyPersonPhone", "责任人电话");
		columnMap.put("dutyDepartment", "责任部门");
		columnMap.put("dutyUnit", "责任单位");
		columnMap.put("involveDepartment", "涉及部门");
		columnMap.put("involvePerson", "涉及人员");
		columnMap.put("leadPerson", "牵头人");
		columnMap.put("leadUnit", "牵头单位");
		columnMap.put("matchUnit", "配合单位");
		ExcelExportUtil.exportExcel(response, columnMap, result);
		return null;
	}

	/**
	 * 获取预警列表
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/wornList")
	@ResponseBody
	public PageEU<EnvironmentRectifition> wornList(EnvironmentRectifitionParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<EnvironmentRectifition> page = pageQuery(request);
		Page<EnvironmentRectifition> rectifitionPage = rectifitionService.getWornListByPage(param,page);
		// 导出所有
		if ("yes".equals(request.getParameter("export"))) {
			return exportEnvironmentRectifitionExl(response, rectifitionPage);
		}
		return new PageEU<>(rectifitionPage);
	}

	/**
	 * 获取所有预警任务
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/allWornList")
	@ResponseBody
	public List<EnvironmentRectifition> allWornList(HttpServletRequest request, HttpServletResponse response) {
		List<EnvironmentRectifition> list = rectifitionService.allWornList();
		return list;
	}
	
	/**
	 * 获取责任名单列表
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getEnvironmentRecitifitionList")
	@ResponseBody
	public PageEU<Map<String, Object>> getEnvironmentRecitifitionList(EnvironmentRectifitionParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> noSetProjList = rectifitionService.getNoSetProjList(page);
		return new PageEU<>(noSetProjList);
	}

	/**
	 * 设置预警时间
	 * @param warnTime
	 */
	@RequestMapping("/setWarnTime")
	@ResponseBody
	public R setWarnDay(String warnTime) {
		try {
			rectifitionService.setWarnDay(warnTime);
		} catch (Exception e) {
			return R.error(e);
		}
		return R.ok("操作成功！");
	}

	/**
	 * 
	 * @Title:  get
	 * @Description:    环保督察整改汇总表 - 获取设置状态列表
	 * @CreateBy:  
	 * @CreateTime: 2019年5月10日 上午10:20:35
	 * @UpdateBy:  
	 * @UpdateTime:  2019年5月10日 上午10:20:35    
	 * @param uuid
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		EnvironmentRectifition rectifition;
		try {
			rectifition = rectifitionService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("result", rectifition);
	}

	/**
	 * 
	 * @Title:  save
	 * @Description:    环保督察整改汇总表  - 新增任务    
	 * @CreateBy:  
	 * @CreateTime: 2019年5月10日 上午10:21:54
	 * @UpdateBy:  
	 * @UpdateTime:  2019年5月10日 上午10:21:54    
	 * @param rectifition
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(EnvironmentRectifition rectifition) {
		try {
			if(ToolUtil.isNotEmpty(rectifition.getCreatetime())) {
				rectifition.setCreateTime(DateUtil.parseDate(rectifition.getCreatetime()));
			}
			String save = rectifitionService.save(rectifition);
			if (StringUtils.isNotEmpty(save)) {
				return R.error(save);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


	/**
	 * 保存责任名单
	 * @param dutyUser
	 * @return
	 */
	@RequestMapping(value = "/saveDutyUser")
	@ResponseBody
	public R saveDutyUser(EnvironmentDutyUser dutyUser) {
		try {
			String s = rectifitionService.saveDutyUser(dutyUser);
			if (StringUtils.isNotEmpty(s)) {
				return R.error(s);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok("操作成功！");
	}

	/**
	 * 通过主键删除责任名单
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value = "/deleteDutyUser")
	@ResponseBody
	public R deleteDutyUser(String uuid) {
		try {
			rectifitionService.deleteDutyUser(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 
	 * @Title:  getEcharts
	 * @Description:    环保督察总体情况    - 柱状图
	 * @CreateBy: 
	 * @CreateTime: 2019年5月10日 上午10:06:36
	 * @UpdateBy: 
	 * @UpdateTime:  2019年5月10日 上午10:06:36    
	 * @param startTime
	 * @param endTime
	 * @return
	 * @throws ParseException  JSONObject 
	 * @throws
	 */
	@RequestMapping(value = "/getEcharts")
	@ResponseBody
	public JSONObject getEcharts(String startTime, String endTime) throws ParseException {
//		startTime = CountUtil.getStartDate(startTime,0);
//		endTime = CountUtil.getEndDate(endTime,0);
//		SimpleDateFormat simpleDateFormat  = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject result = rectifitionService.getEcharts(startTime,endTime);
		return result;
	}
	
	/**
	 * 
	 * @Title:  getPieEcharts
	 * @Description:    环保督察总体情况	-	饼图    
	 * @CreateBy:  
	 * @CreateTime: 2019年5月10日 上午10:06:56
	 * @UpdateBy:  
	 * @UpdateTime:  2019年5月10日 上午10:06:56    
	 * @param startTime
	 * @param endTime
	 * @return  JSONObject 
	 * @throws
	 */
	@RequestMapping(value = "/getPieEcharts")
	@ResponseBody
	public JSONObject getPieEcharts(String startTime, String endTime) {
		//startTime = CountUtil.getStartDate(startTime,0);
		//endTime = CountUtil.getEndDate(endTime,0);
		JSONObject result = rectifitionService.getPieEcharts(startTime, endTime);
		return result;
	}
	
	@RequestMapping(value = "/getCount")
	@ResponseBody
	public JSONObject getCount(EnvironmentRectifitionParam param) {
		
		JSONObject result = rectifitionService.getCount(param);
		return result;
	}

    @RequestMapping(value = "/getProjectCountByCity")
    @ResponseBody
    public List<EnvironmentRectifitionChart> getProjectCountByCity(String status, String startTime, String endTime) {
        List<EnvironmentRectifitionChart> result = rectifitionService.getProjectCountByCity( status,startTime, endTime);
        return result;
    }

	/**
	 * 完成销号超过30天验收
	 * @param type
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/getCancelNumberTimeoutData")
	@ResponseBody
	public List<EnvCancellationAccount> getCancelNumberTimeoutData(String type, String startTime, String endTime) {
		List<EnvCancellationAccount> result = rectifitionService.getCancelNumberTimeoutData(type,startTime, endTime);
		return result;
	}
	/**
	 * 
	 * @Title:  getDecription
	 * @Description:    环保督察总体情况 - 点击柱状图打开窗口      
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午10:19:14
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午10:19:14    
	 * @param id
	 * @param status
	 * @param startTime
	 * @param endTime
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping(value="/getDecription")
	@ResponseBody
	public PageEU<Map<String, Object>> getDecription(String id,String status,String startTime, String endTime, HttpServletRequest request){
//		startTime = CountUtil.getStartDate(startTime,0);
//		endTime = CountUtil.getEndDate(endTime,0);
		status = getStatus(status);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> decription = rectifitionService.getDecription(id,status,startTime,endTime,page);
		return new PageEU<>(decription);
	}
	
	/**
	 * 
	 * @Title:  getDetail
	 * @Description:    环保督察总体情况  - 柱状图弹窗  - 查看详情    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午10:09:17
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午10:09:17    
	 * @param id
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getDetail")
	@ResponseBody
	public PageEU<Map<String, Object>> getDetail(String id,HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> result = rectifitionService.getDetail(id,page);
		return new PageEU<>(result);
	}
	
	/**
	 * 
	 * @Title:  getDecriptionAll
	 * @Description:    环保督察总体情况 - 点击饼图打开窗口    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午10:17:30
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午10:17:30    
	 * @param status
	 * @param startTime
	 * @param endTime
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getDecriptionAll")
	@ResponseBody
	public PageEU<Map<String, Object>> getDecriptionAll(String status,String startTime, String endTime,HttpServletRequest request){
//		startTime = CountUtil.getStartDate(startTime,0);
//		endTime = CountUtil.getEndDate(endTime,0);
		status = getStatus(status);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> decription = rectifitionService.getDecriptionAll(status,startTime,endTime,page);
		return new PageEU<>(decription);
	}
	
	/**
	 * 
	 * @Title:  delete
	 * @Description:    环保督察整改汇总表 - 删除    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午10:08:41
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午10:08:41    
	 * @param uuid
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public R delete(String uuid) {
		try {
			rectifitionService.deleteByUuid(uuid);
			return R.ok("删除成功！");
		}catch (Exception e) {
			return R.error("删除失败！ ");
		}
	}
	
	/**
	 * 
	 * @Title:  saveRectifition
	 * @Description:    环保督察整改汇总表 - 编辑后的保存
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午10:07:37
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午10:07:37    
	 * @param rectifition
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/saveRectifition")
	@ResponseBody
	public R saveRectifition(EnvironmentRectifition rectifition) {
		try {
			String createtime = rectifition.getCreatetime();
			if (ObjectUtil.isNull(createtime)) {
				createtime = DateUtil.getTime(new Date());
			}
			rectifition.setCreateTime(DateUtil.parseDate(createtime));
			String s = rectifitionService.saveRectifition(rectifition);
			if (StringUtils.isNotEmpty(s)) {
				return R.error(s);
			}
		} catch (Exception e) {
			return R.error("修改失败！");
		}
		return R.ok("修改成功！");
	}
	
	public String getStatus(String status) {
		if(status.equals("尚未启动")) {
			status = "NOTSTART";
		}else if(status.equals("未达到序时进度")) {
			status = "NOTREACH";
		}else if(status.equals("达到序时进度")) {
			status = "ONTIME";
		}else if(status.equals("超过序时进度")) {
			status = "PASS";
		}else if(status.equals("完成整改")) {
			status = "OVER";
		}else if(status.equals("完成交账销号")) {
			status = "SENDACCOUNT";
		}
		return status;
	}

	/**
	 * 责任名单导入
	 * @param file
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/importFile")
	@ResponseBody
	public R importFile(@RequestParam(name = "xlsxfile") MultipartFile file, HttpServletRequest request)
			throws Exception {
		if (file.isEmpty()) {
			throw new Exception("文件不存在！");
		}
		String fileName=file.getOriginalFilename();
		String suffix=fileName.substring(fileName.lastIndexOf("."));
		String prefix=fileName.substring(0,fileName.lastIndexOf("."));
		String message="";
		try {
			File excelFile=File.createTempFile(prefix, suffix);
			file.transferTo(excelFile);
			String[][] result = getExcelContent(excelFile);
			deleteFile(excelFile);
			message = rectifitionService.save(result);
		}catch (Exception e) {
			return R.error("导入失败："+e.getMessage());
		}
		if(message!="") {
			return R.error("导入失败："+message);
		}
		return R.ok("导入成功");
	}

	public String[][] getExcelContent(File excelFile) throws Exception{
		List<String[]> result = new ArrayList<String[]>();
		int rowSize = 0;
		Workbook wb = null;
		FileInputStream fileInputStream = null;
		if (excelFile.isFile() && excelFile.exists()) {
			String suffix = excelFile.getName().substring(excelFile.getName().lastIndexOf("."));
			if(".xls".equals(suffix)) {
				fileInputStream = new FileInputStream(excelFile);
				wb = new HSSFWorkbook(fileInputStream);
			}else if(".xlsx".equals(suffix)) {
				wb =new XSSFWorkbook(excelFile);
			}else {
				throw new Exception("文件类型错误！");
			}
		}
		Cell cell = null;
		//检验excel条数
		HSSFSheet sheet = (HSSFSheet) wb.getSheetAt(0);
		int lrowNum = sheet.getLastRowNum();
		int frowNum = sheet.getFirstRowNum();
		int countTotal = lrowNum + 1 - frowNum;
		if (countTotal <= 1) {
			throw new Exception("文件中的第一个sheet没有记录数，请检查！");
		}
		if (countTotal > 1000) {
			throw new Exception("一次导入的记录数不能大于1000条，请分批进行导入！");
		}
		for (int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
			Sheet st = wb.getSheetAt(sheetIndex);
			// 第一行为标题，不取
			for (int rowIndex = 1; rowIndex <= st.getLastRowNum(); rowIndex++) {
				Row row = st.getRow(rowIndex);
				//判断Excel每一行中的列值是否为空
				Cell cell1 = row.getCell(1);
//				if (StringUtils.isNull(row.getCell(1).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第2列责任人不能为空！");
//				}if (StringUtils.isNull(row.getCell(2).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第3列责任部门不能为空！");
//				}if (StringUtils.isNull(row.getCell(3).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第4列责任单位不能为空！");
//				}if (StringUtils.isNull(row.getCell(4).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第4列涉及人员不能为空！");
//				}if (StringUtils.isNull(row.getCell(5).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第5列涉及部门不能为空！");
//				}if (StringUtils.isNull(row.getCell(6).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第6列牵头人不能为空！");
//				}if (StringUtils.isNull(row.getCell(7).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第7列牵头单位不能为空！");
//				}if (StringUtils.isNull(row.getCell(8).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第8列配合单位不能为空！");
//				}
				if (row == null) {
					continue;
				}
				int tempRowSize = row.getLastCellNum() + 1;
				if (tempRowSize > rowSize) {
					rowSize = tempRowSize;
				}
				String[] values = new String[rowSize];
				Arrays.fill(values, "");
				boolean hasValue = false;
				for (short columnIndex = 0; columnIndex <= row.getLastCellNum(); columnIndex++) {
					String value = "";
					cell = row.getCell(columnIndex);
					if (cell != null) {
						// 注意：一定要设成这个，否则可能会出现乱码
						// cell.setEncoding(HSSFCell.ENCODING_UTF_16);
						switch (cell.getCellType()) {
							case HSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue();
								break;
							case HSSFCell.CELL_TYPE_NUMERIC:
								if (HSSFDateUtil.isCellDateFormatted(cell)) {
									Date date = cell.getDateCellValue();
									if (date != null) {
										value = new SimpleDateFormat("yyyy-MM-dd").format(date);
									} else {
										value = "";
									}
								} else {
									value = new DecimalFormat("0").format(cell.getNumericCellValue());
								}
								break;
							case HSSFCell.CELL_TYPE_FORMULA:
								// 导入时如果为公式生成的数据则无值
								if (!"".equals(cell.getStringCellValue())) {
									value = cell.getStringCellValue();
								} else {
									value = cell.getNumericCellValue() + "";
								}
								break;
							case HSSFCell.CELL_TYPE_BLANK:
								break;
							case HSSFCell.CELL_TYPE_ERROR:
								value = "";
								break;
							case HSSFCell.CELL_TYPE_BOOLEAN:
								value = (cell.getBooleanCellValue() == true ? "Y":"N");
								break;
							default:
								value = "";
						}
					}
					values[columnIndex] = value;
					hasValue = true;
				}
				if (hasValue) {
					result.add(values);
				}
			}
		}
		if(fileInputStream!=null) {
			fileInputStream.close();
		}
		wb.close();
		String[][] returnArray = new String[result.size()][rowSize];
		for (int i = 0; i < returnArray.length; i++) {
			returnArray[i] = (String[]) result.get(i);
		}
		return returnArray;

	}

	/**
	 * 删除本地的文件
	 * @param excelFile
	 */
	private void deleteFile(File... excelFile) {
		for (File file : excelFile) {
			if (file.exists()) {
				file.delete();
			}
		}
	}
	
	
	/**
	 * 列表查询
	 * lilongan
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/listNew1")
	@ResponseBody
	public LayuiUtil listNew1(int limit, int page, EnvironmentRectifitionParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<EnvironmentRectifition> page1 = pageQuery(request);
		page1.setLimit(limit);
		page1.setCurrentPage(page-1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		StringBuilder sql = new StringBuilder("");
		String sqlStr = "SELECT c. NAME AS project_name,D . NAME AS describle_name,C.UUID AS project_id,D.UUID AS describle_id, A .*\n" +
				"FROM\n" +
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
				"WHERE a.UUID is not null and a.mark = 'ZP' ";
		if (StringUtils.isNotEmpty(param.getName())) {
			sqlStr = sqlStr + " and A.NAME = '" + param.getName() + "'";
		}
		if (StringUtils.isNotEmpty(param.getAreaCode())) {
			sqlStr = sqlStr + " and A.AREA_CODE ='" + param.getAreaCode() + "'";
		}
		if (StringUtils.isNotEmpty(param.getCityCode())) {
			sqlStr = sqlStr + " and A.CITY_CODE ='" + param.getCityCode() + "'";
		}
		if (StringUtils.isNotEmpty(param.getStatus())) {
			sqlStr = sqlStr + " and A.STATUS ='" + param.getStatus() + "'";
		}
		if (ObjectUtil.isNotNull(param.getTimelimit())) {
			sqlStr = sqlStr + " and TO_CHAR(A.TIMELIMIT,'yyyy-MM-dd') ='" + DateUtil.formatDate(param.getTimelimit(), "yyyy-MM-dd") + "'";
		}
		sqlStr = sqlStr + " ORDER BY A.TIMES,a.uuid DESC";
		sql.append(sqlStr);
		Page<EnvironmentRectifition> rectifitionPage = simpleDao.listNativeByPage(sql.toString(), page1);
		return LayuiUtil.data(rectifitionPage.getTotalCount(), rectifitionPage.getResult());
		//return new PageEU<>(rectifitionPage);
	}
	
	/**
	 * 完成销号超过30天验收
	 * @param type
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/getCancelNumberTimeoutData1")
	@ResponseBody
	public LayuiUtil getCancelNumberTimeoutData1(int limit,int page, HttpServletRequest request, String type,String startTime, String endTime) {
		Page<EnvCancellationAccount> page1 = pageQuery(request);
		page1.setLimit(limit);
		page1.setCurrentPage(page-1);
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
				" LEFT JOIN COMMON_RELATION_TABLE b ON A . NAME = b.uuid " ;
		if(StringUtils.isNotBlank(type)){
         sql+=" WHERE  TO_CHAR ( A .CREATE_DATE + 30, 'yyyy-mm-dd')";
		}
		if("COUNTY_ACTUAL_TIME".equals(type)){//实际县级验收时间
			sql+=   " < TO_CHAR ( A .COUNTY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("CITY_ACTUAL_TIME".equals(type)){//实际市级验收时间
			sql+=   " < TO_CHAR ( A .CITY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("PROFESSION_ACTUAL_TIME".equals(type)){//实际提交行业验收时间
			sql+=   " < TO_CHAR ( A .COUNTY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}else if("PROFESSION_EXAMINE_TIME".equals(type)){//完成行业审查时间
			sql+=   " < TO_CHAR ( A .COUNTY_ACTUAL_TIME,'yyyy-mm-dd') ";
		}
		sql+=   
				//" AND ROWNUM <= 3 " +
				" ORDER BY " +
				" CREATE_DATE DESC" ;
		Page<EnvCancellationAccount> result = simpleDao.listNativeByPage(sql.toString(), page1);
		return LayuiUtil.data(result.getTotalCount(), result.getResult());
	}
	
	
	/**
	 * 
	 * @Title:  getProjectDetail
	 * @Description:    环保督察总体情况  - 柱状图弹窗  - 查看详情    
	 * @CreateBy: lilongan 
	 * @CreateTime: 2019年6月11日 上午09:09:17
	 * @UpdateBy: lilongan 
	 * @UpdateTime:  2019年6月11日 上午09:09:17    
	 * @param id
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getProjectDetail")
	@ResponseBody
	public PageEU<Map<String, Object>> getProjectDetail(String id,HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> result = rectifitionService.getProjectDetail(id,page);
		return new PageEU<>(result);
	}

	/**
	 * 获取轮数：第一轮  第二轮。。。
	 * @return
	 */
    @RequestMapping("/getNumOfRound")
    @ResponseBody
    public List<Map> getNumOfRound() {
        return rectifitionService.getNumOfRound();
    }
    /**
	 * 获取下一轮轮数或者之前被删除的轮数
	 * @return
	 */
    @RequestMapping("/getNextRound")
    @ResponseBody
    public List getNextRound(String num) {
        return rectifitionService.getNextRound(num);
    }


}
