package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 污染源根据直属部门/区县的数据录入
 * @Author   chenmingdao
 * @Version   1.0
 * @CreateTime 2019年5月9日 下午2:57:31
 */
@Controller
@RequestMapping("/env/pollution2/data/{type}")
@Secured({ "ROLE_USER" })
public class DataByTypeController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;

	@Autowired
    private DeptService deptService;

	/**
	 * @Author lianhuinan
	 * @Description //TODO(关于直属部门/区县的污染源数据录入页面接口)
	 * @Date 2019/10/15 0015 14:47
	 * @param type：county、dept
	 * @param modelAndView
	 * @param pid
	 * @return org.springframework.web.servlet.ModelAndView
	 * @version 1.0
	 **/
	@RequestMapping("/index")
	public ModelAndView index(@PathVariable("type")String type, ModelAndView modelAndView, String pid) {
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("type", type);
		modelAndView.setViewName("/moudles/pollution/PollutionInfoDataByType");
		return modelAndView;
	}

	/**
	 * 污染源数据信息  --分页
	 * @param pollutionInfoData 参数集合
	 * @param request
	 * @return
	 */
	@RequestMapping("/getInfoPage")
	@ResponseBody
	public PageEU<Map<String, Object>> getBasinNameByArea(@PathVariable("type")String type,String export,
			PollutionInfoData pollutionInfoData,HttpServletResponse response, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		StringBuilder sqlBuilder = new StringBuilder();
		
		List list = new ArrayList();
		for (Dept dept : deptService.getDeptByUserId(getUser().getUuid())){
		    list.add(dept.getName());
		}
		
		sqlBuilder.append(" SELECT * FROM POLLUTION_INFO_DATA WHERE 1=1 ");
		if(type.equals("county")){
			sqlBuilder.append(" and DEPT_PATH like '").append(getUserPidPath()).append("%' ");
		}
		if(type.equals("dept")){
		    sqlBuilder.append(" and WRYLX in (").append(SqlUtil.toSqlIn(list)).append(") ");
		}

		sqlBuilder.append(" or QX in (").append(SqlUtil.toSqlIn(list)).append(") ");
//        if (list.contains("生态环境局")) {
//            sqlBuilder.append(" or WRYZL in ('高架源企业','VOCs企业','散乱污企业','非道路移动源','工业危险废物','三格化粪池'"
//                    + ",'工业固废','涉水工业企业','海洋排污口','涉海工业固废','石板材行业','持证矿山') ");
//        } else if (list.contains("应急局")) {
//            sqlBuilder.append(" or WRYZL in ('持证矿山','石板材行业') ");
//        }

		if (StringUtils.isNotEmpty(pollutionInfoData.getMc())) {
			sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
		}
		sqlBuilder.append(" ORDER BY DECODE(UPDATE_DATE, null, CREATE_DATE,CREATE_DATE) DESC NULLS LAST ");

		if(ToolUtil.isNotEmpty(export) && export.equals("yes")) {
			List<Map> lists=simpleDao.getNativeQueryList(sqlBuilder.toString());
			List<Map> result = new ArrayList<>(lists.size());
			for (Map map : lists) {
				LinkedHashMap<String, Object> temp = new LinkedHashMap<>();
				temp.put("qx",map.get("qx"));
				temp.put("wrylx",map.get("wrylx"));
				temp.put("wryzl",map.get("wryzl"));
				temp.put("mc",map.get("mc"));
				temp.put("czwt",map.get("czwt"));
				temp.put("zgcs",map.get("zgcs"));
				temp.put("zlxm",map.get("zlxm"));
				temp.put("wcmb201912",map.get("wcmb201912"));
				temp.put("wcmb202006",map.get("wcmb202006"));
				temp.put("wcmb202012",map.get("wcmb202012"));
				temp.put("sdzrZrdw",map.get("sdzrZrdw"));
				temp.put("sdzrdwZrrlxfs",map.get("sdzrdwZrrlxfs"));
				temp.put("bmzrZrdw",map.get("bmzrZrdw"));
				temp.put("bmzrdwZrrlxfs",map.get("bmzrdwZrrlxfs"));
				temp.put("bmzrPhzrdw",map.get("bmzrPhzrdw"));
				temp.put("phzrdwZrrlxfs",map.get("phzrdwZrrlxfs"));
				temp.put("xz",map.get("xz"));
				temp.put("dz",map.get("dz"));
				temp.put("jd",map.get("jd"));
				temp.put("wd",map.get("wd"));
				temp.put("bz",map.get("bz"));
				result.add(map);
			}
			return exportExl(response, result);
		}

		Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);
		return new PageEU<>(listPage);
	}


	/**
	 * 导出Excel 全部  --漳州市污染源数据导出表
	 *
	 * @param response
	 * @param list
	 * @return
	 */
	private PageEU<Map<String, Object>> exportExl(HttpServletResponse response, List<Map> list) {
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "漳州市污染源数据导出表");

		columnMap.put("qx","区县");
		columnMap.put("wrylx","污染源类型");
		columnMap.put("wryzl","污染源种类");
		columnMap.put("mc","名称");
		columnMap.put("czwt","存在问题");
		columnMap.put("zgcs","整改措施");
		columnMap.put("zlxm","治理项目");
		columnMap.put("wcmb201912","完成目标2019年12月底");
		columnMap.put("wcmb202006","完成目标2020年06月底");
		columnMap.put("wcmb202012","完成目标2020年12月底");
		columnMap.put("sdzrZrdw","属地责任单位");
		columnMap.put("sdzrdwZrrlxfs","属地责任单位责任人及联系方式");
		columnMap.put("bmzrZrdw","部门责任责任单位");
		columnMap.put("bmzrdwZrrlxfs","部门责任责任单位责任人及联系方式");
		columnMap.put("bmzrPhzrdw","部门责任配合责任单位");
		columnMap.put("phzrdwZrrlxfs","部门责任配合责任单位责任人及联系方式");
		columnMap.put("xz","乡镇");
		columnMap.put("dz","单位");
		columnMap.put("jd","经度");
		columnMap.put("wd","纬度");
		columnMap.put("bz","备注");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}


}
