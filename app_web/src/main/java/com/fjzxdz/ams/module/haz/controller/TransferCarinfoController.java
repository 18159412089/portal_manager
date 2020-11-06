/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.haz.dao.TransferCarinfoDao;
import com.fjzxdz.ams.module.haz.entity.TransferCarinfo;
import com.fjzxdz.ams.module.haz.param.TransferCarinfoParam;
import com.fjzxdz.ams.module.haz.service.TransferCarinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 危废转移车辆信息Controller
 * @author htj
 * @version 2019-02-19
 */
@Controller
 
@RequestMapping(value = "/haz/transferCarinfo")
 
public class TransferCarinfoController extends BaseController {

	@Autowired
	private TransferCarinfoDao transferCarinfoDao;
	@Autowired
	private TransferCarinfoService transferCarinfoService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "haz/transferCarinfoList";
	}
	
	/**
	 * 更新或新增
	 * @param transferCarinfo
	 * @return
	 */	
	@RequestMapping("/saveTransferCarinfo")
	@ResponseBody
	public R saveTransferCarinfo(TransferCarinfo transferCarinfo) {
		try {
			transferCarinfoService.save(transferCarinfo);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deleteTransferCarinfo")
	@ResponseBody
	public R deleteTransferCarinfo(@RequestParam(value = "uuid") String uuid) {
		try {
			transferCarinfoService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getTransferCarinfo")
	@ResponseBody
	public Map<String, Object> getTransferCarinfo(@RequestParam(value = "uuid") String uuid) {
		TransferCarinfo transferCarinfo = transferCarinfoDao.getById(uuid);
		return BeanUtil.beanToMap(transferCarinfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param transferCarinfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/transferCarinfoList")
	@ResponseBody
	public PageEU<TransferCarinfo> transferCarinfoList(TransferCarinfoParam transferCarinfoParam, HttpServletRequest request) {
		Page<TransferCarinfo> page = transferCarinfoService.listByPage(transferCarinfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(TransferCarinfoParam param, HttpServletResponse response){
		List<TransferCarinfo> lists = transferCarinfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (TransferCarinfo transferCarinfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("vno", transferCarinfo.getVNO());
			map.put("company", transferCarinfo.getCOMPANY());
			map.put("direction", transferCarinfo.getDIRECTION());
			map.put("location", transferCarinfo.getLOCATION());
			map.put("speed",transferCarinfo.getSPEED());
			map.put("vcolor", transferCarinfo.getVCOLOR());
			map.put("status", transferCarinfo.getSTATUS());
			map.put("y", transferCarinfo.getY());
			map.put("x", transferCarinfo.getX());
			map.put("type", transferCarinfo.getTYPE());
			map.put("time", transferCarinfo.getTIME());
			map.put("updatetimeRjwa", transferCarinfo.getUpdatetimeRjwa());
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
		columnMap.put("title", "危废转移车辆数据表");

		columnMap.put("vno", "车牌号");
		columnMap.put("company", "车辆所属公司");
		columnMap.put("direction", "车辆方向");
		columnMap.put("location", "车辆所在位置描述");
		columnMap.put("speed", "车辆行驶速度");
		columnMap.put("vcolor", "车牌颜色");
		columnMap.put("status", "车辆状态");
		columnMap.put("y", "车辆位置纬度");
		columnMap.put("x", "车辆位置经度");
		columnMap.put("type", "车辆类型");
		columnMap.put("time", "GPS时间");
		columnMap.put("updatetimeRjwa", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
