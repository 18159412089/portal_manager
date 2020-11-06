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
import com.fjzxdz.ams.module.haz.dao.JointOrderInfoDao;
import com.fjzxdz.ams.module.haz.entity.JointOrderInfo;
import com.fjzxdz.ams.module.haz.param.JointOrderInfoParam;
import com.fjzxdz.ams.module.haz.service.JointOrderInfoService;
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
 * 联单转移联单信息Controller
 * @author htj
 * @version 2019-02-19
 */
@Controller
 
@RequestMapping(value = "/haz/jointOrderInfo")
 
public class JointOrderInfoController extends BaseController {

	@Autowired
	private JointOrderInfoDao jointOrderInfoDao;
	@Autowired
	private JointOrderInfoService jointOrderInfoService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "haz/jointOrderInfoList";
	}
	
	/**
	 * 更新或新增
	 * @param jointOrderInfo
	 * @return
	 */	
	@RequestMapping("/saveJointOrderInfo")
	@ResponseBody
	public R saveJointOrderInfo(JointOrderInfo jointOrderInfo) {
		try {
			jointOrderInfoService.save(jointOrderInfo);
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
	@RequestMapping("/deleteJointOrderInfo")
	@ResponseBody
	public R deleteJointOrderInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			jointOrderInfoService.delete(uuid);
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
	@RequestMapping("/getJointOrderInfo")
	@ResponseBody
	public Map<String, Object> getJointOrderInfo(@RequestParam(value = "uuid") String uuid) {
		JointOrderInfo jointOrderInfo = jointOrderInfoDao.getById(uuid);
		return BeanUtil.beanToMap(jointOrderInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param jointOrderInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/jointOrderInfoList")
	@ResponseBody
	public PageEU<JointOrderInfo> jointOrderInfoList(JointOrderInfoParam jointOrderInfoParam, HttpServletRequest request) {
		Page<JointOrderInfo> page = jointOrderInfoService.listByPage(jointOrderInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(JointOrderInfoParam param, HttpServletResponse response){
		List<JointOrderInfo> lists = jointOrderInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (JointOrderInfo jointOrderInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("ldbh", jointOrderInfo.getLDBH());
			map.put("chuchang", jointOrderInfo.getCHUCHANG());
			map.put("ccsj", jointOrderInfo.getCCSJ());
			map.put("qrcjRemark", jointOrderInfo.getQrcjRemark());
			map.put("ldzt",jointOrderInfo.getLDZT());
			map.put("ysqyDriver", jointOrderInfo.getYsqyDriver());
			map.put("qrsj", jointOrderInfo.getQRSJ());
			map.put("qrcjRemark", jointOrderInfo.getQrcjRemark());
			map.put("cjsj",jointOrderInfo.getCJSJ());
			map.put("updatetime", jointOrderInfo.getUPDATETIME());
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
		columnMap.put("title", "联单转移联单数据表");

		columnMap.put("ldbh", "联单编号");
		columnMap.put("chuchang", "出厂");
		columnMap.put("ccsj", "出厂时间");
		columnMap.put("qrcjRemark", "创建备注");
		columnMap.put("ldzt", "联单状态：");
		columnMap.put("ysqyDriver", "司机");
		columnMap.put("qrsj", "确认时间");
		columnMap.put("qrcjRemark", "确认备注");
		columnMap.put("cjsj", "创建时间");
		columnMap.put("updatetime", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
