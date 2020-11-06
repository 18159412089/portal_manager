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
import com.fjzxdz.ams.module.haz.dao.JointOrderDetailDao;
import com.fjzxdz.ams.module.haz.entity.JointOrderDetail;
import com.fjzxdz.ams.module.haz.param.JointOrderDetailParam;
import com.fjzxdz.ams.module.haz.service.JointOrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
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
 * 联单详细信息Controller
 * @author htj
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/haz/jointOrderDetail")
@Secured({ "ROLE_USER" })
public class JointOrderDetailController extends BaseController {

	@Autowired
	private JointOrderDetailDao jointOrderDetailDao;
	@Autowired
	private JointOrderDetailService jointOrderDetailService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "haz/jointOrderDetailList";
	}
	
	/**
	 * 更新或新增
	 * @param jointOrderDetail
	 * @return
	 */	
	@RequestMapping("/saveJointOrderDetail")
	@ResponseBody
	public R saveJointOrderDetail(JointOrderDetail jointOrderDetail) {
		try {
			jointOrderDetailService.save(jointOrderDetail);
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
	@RequestMapping("/deleteJointOrderDetail")
	@ResponseBody
	public R deleteJointOrderDetail(@RequestParam(value = "uuid") String uuid) {
		try {
			jointOrderDetailService.delete(uuid);
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
	@RequestMapping("/getJointOrderDetail")
	@ResponseBody
	public Map<String, Object> getJointOrderDetail(@RequestParam(value = "uuid") String uuid) {
		JointOrderDetail jointOrderDetail = jointOrderDetailDao.getById(uuid);
		return BeanUtil.beanToMap(jointOrderDetail,false,true);
	}
	
	/**
	 * 查询列表
	 * @param jointOrderDetailParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/jointOrderDetailList")
	@ResponseBody
	public PageEU<JointOrderDetail> jointOrderDetailList(JointOrderDetailParam jointOrderDetailParam, HttpServletRequest request) {
		Page<JointOrderDetail> page = jointOrderDetailService.listByPage(jointOrderDetailParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(JointOrderDetailParam param, HttpServletResponse response){
		List<JointOrderDetail> lists = jointOrderDetailDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (JointOrderDetail jointOrderDetail : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("sucheng", jointOrderDetail.getSUCHENG());
			map.put("code", "");//暂时没有对应实体类
			map.put("wxtx", jointOrderDetail.getWXTX());
			map.put("rongqilx", jointOrderDetail.getRONGQILX());
			map.put("rongqisl",jointOrderDetail.getRONGQISL());
			map.put("guigexinghao", jointOrderDetail.getGUIGEXINGHAO());
			map.put("czfsName", jointOrderDetail.getCzfsName());
			map.put("danwei", jointOrderDetail.getDANWEI());
			map.put("czJsl", jointOrderDetail.getCzJsl());
			map.put("caizhi", jointOrderDetail.getCAIZHI());
			map.put("wxcf", jointOrderDetail.getWXCF());
			map.put("zyl", jointOrderDetail.getZYL());
			map.put("updatetime", jointOrderDetail.getUPDATETIME());
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
		columnMap.put("title", "联单详细信息数据表");

		columnMap.put("sucheng", "危废名称");
		columnMap.put("code", "危废代码");
		columnMap.put("wxtx", "危险特性");
		columnMap.put("rongqilx", "容器类型");
		columnMap.put("rongqisl", "容器数量");
		columnMap.put("guigexinghao", "规格型号");
		columnMap.put("czfsName", "处置方式代码");
		columnMap.put("danwei", "处置单位接收量");
		columnMap.put("czJsl", "转移量");
		columnMap.put("caizhi", "材质");
		columnMap.put("wxcf", "危险成分");
		columnMap.put("zyl", "转移量");
		columnMap.put("updatetime", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
