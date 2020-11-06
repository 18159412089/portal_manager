/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.sea.dao.SeaSiteDataDao;
import com.fjzxdz.ams.module.sea.entity.SeaSiteData;
import com.fjzxdz.ams.module.sea.param.SeaSiteDataParam;
import com.fjzxdz.ams.module.sea.service.SeaSiteDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 省海洋与渔业厅数据Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/sea/seaSiteData")
@Secured({ "ROLE_USER" })
public class SeaSiteDataController extends BaseController {
	@Autowired
	private SeaSiteDataService seaSiteDataService;
	@Autowired
	private SeaSiteDataDao seaSiteDataDao;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "sea/seaSiteDataList";
	}
	
	/**
	 * 更新或新增
	 * @param seaSiteData
	 * @return
	 */	
/*	@RequestMapping("/saveSeaSiteData")
	@ResponseBody
	public R saveSeaSiteData(SeaSiteData seaSiteData) {
		try {
			seaSiteDataService.save(seaSiteData);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
/*	@RequestMapping("/deleteSeaSiteData")
	@ResponseBody
	public R deleteSeaSiteData(@RequestParam(value = "uuid") String uuid) {
		try {
			seaSiteDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getSeaSiteData")
	@ResponseBody
	public Map<String, Object> getSeaSiteData(String uuid) {
		String str[] = uuid.split("_");
		String zdbh = str[0];
        String jcsj = str[1];
		SeaSiteData seaSiteData = simpleDao.findUnique("from SeaSiteData where ZDBH=? and JCSJ=?",zdbh,jcsj);
		return BeanUtil.beanToMap(seaSiteData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param seaSiteDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/seaSiteDataList")
	@ResponseBody
	public PageEU<SeaSiteData> seaSiteDataList(SeaSiteDataParam seaSiteDataParam, HttpServletRequest request) {
		Page<SeaSiteData> page = seaSiteDataService.listByPage(seaSiteDataParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(SeaSiteDataParam param, HttpServletResponse response){
		List<SeaSiteData> lists = seaSiteDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (SeaSiteData seaSiteData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("zdbh", seaSiteData.getZDBH());
			map.put("zdmc", seaSiteData.getZDMC());
			map.put("sw", seaSiteData.getSW());
			map.put("yls", seaSiteData.getYLS());
			map.put("ljy", seaSiteData.getLJY());
			map.put("ljybhd",seaSiteData.getLJYBHD());
			map.put("ddl", seaSiteData.getDDL());
			map.put("jcsj", seaSiteData.getJCSJ());
			map.put("rksj", seaSiteData.getRKSJ());
			result.add(map);
		}
		return exportEnvironmentNativeWtHourDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportEnvironmentNativeWtHourDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "省海洋与渔业厅数据表");

		columnMap.put("zdbh", "站点编号");
		columnMap.put("zdmc", "站点名称");
		columnMap.put("sw", "水温");
		columnMap.put("yls", "叶绿素");
		columnMap.put("ljy", "溶解氧");
		columnMap.put("ljybhd", "溶解氧饱和度mg/l");
		columnMap.put("ddl", "导电率mmho/cm");
		columnMap.put("jcsj", "采样时间");
		columnMap.put("rksj", "入库时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
