/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.hutool.core.bean.BeanUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinPlanePData;
import com.fjzxdz.ams.module.enviromonit.water.service.WtBasinPlanePDataService;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlanePDataDao;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinPlanePDataParam;

/**
 * 水系面数据Controller
 * @author ZhangGQ
 * @version 2019-06-28
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/water/WtBasinPlanePData")
@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
public class WtBasinPlanePDataController extends BaseController {

	@Autowired
	private WtBasinPlanePDataDao wtBasinPlanePDataDao;
	@Autowired
	private WtBasinPlanePDataService wtBasinPlanePDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/modules/" + "water/WtBasinPlanePDataList";
	}
	
	/**
	 * 更新或新增
	 * @param wtBasinPlanePData
	 * @return
	 */	
	@RequestMapping("/saveWtBasinPlanePData")
	@ResponseBody
	public R saveWtBasinPlanePData(WtBasinPlanePData wtBasinPlanePData) {
		try {
			wtBasinPlanePDataService.save(wtBasinPlanePData);
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
	@RequestMapping("/deleteWtBasinPlanePData")
	@ResponseBody
	public R deleteWtBasinPlanePData(@RequestParam(value = "uuid") String uuid) {
		try {
			wtBasinPlanePDataService.delete(uuid);
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
	@RequestMapping("/getWtBasinPlanePData")
	@ResponseBody
	public Map<String, Object> getWtBasinPlanePData(@RequestParam(value = "uuid") String uuid) {
		WtBasinPlanePData wtBasinPlanePData = wtBasinPlanePDataDao.getById(uuid);
		return BeanUtil.beanToMap(wtBasinPlanePData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtBasinPlanePData
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtBasinPlanePDataList")
	@ResponseBody
	public PageEU<WtBasinPlanePData> wtBasinPlanePDataList(WtBasinPlanePDataParam wtBasinPlanePDataParam, HttpServletRequest request) {
		Page<WtBasinPlanePData> page = wtBasinPlanePDataService.listByPage(wtBasinPlanePDataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
