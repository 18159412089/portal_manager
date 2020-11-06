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

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinPlaneLData;
import com.fjzxdz.ams.module.enviromonit.water.service.WtBasinPlaneLDataService;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlaneLDataDao;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinPlaneLDataParam;

/**
 * 水系线数据Controller
 * @author ZhangGQ
 * @version 2019-06-28
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/water/WtBasinPlaneLData")
@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
public class WtBasinPlaneLDataController extends BaseController {

	@Autowired
	private WtBasinPlaneLDataDao wtBasinPlaneLDataDao;
	@Autowired
	private WtBasinPlaneLDataService wtBasinPlaneLDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/modules/" + "water/WtBasinPlaneLDataList";
	}
	
	/**
	 * 更新或新增
	 * @param wtBasinPlaneLData
	 * @return
	 */	
	@RequestMapping("/saveWtBasinPlaneLData")
	@ResponseBody
	public R saveWtBasinPlaneLData(WtBasinPlaneLData wtBasinPlaneLData) {
		try {
			wtBasinPlaneLDataService.save(wtBasinPlaneLData);
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
	@RequestMapping("/deleteWtBasinPlaneLData")
	@ResponseBody
	public R deleteWtBasinPlaneLData(@RequestParam(value = "uuid") String uuid) {
		try {
			wtBasinPlaneLDataService.delete(uuid);
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
	@RequestMapping("/getWtBasinPlaneLData")
	@ResponseBody
	public Map<String, Object> getWtBasinPlaneLData(@RequestParam(value = "uuid") String uuid) {
		WtBasinPlaneLData wtBasinPlaneLData = wtBasinPlaneLDataDao.getById(uuid);
		return BeanUtil.beanToMap(wtBasinPlaneLData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtBasinPlaneLData
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtBasinPlaneLDataList")
	@ResponseBody
	public PageEU<WtBasinPlaneLData> wtBasinPlaneLDataList(WtBasinPlaneLDataParam wtBasinPlaneLDataParam, HttpServletRequest request) {
		Page<WtBasinPlaneLData> page = wtBasinPlaneLDataService.listByPage(wtBasinPlaneLDataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
