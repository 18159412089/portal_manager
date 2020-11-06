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

import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPointBasin;
import com.fjzxdz.ams.module.enviromonit.water.service.impl.WtSectionPointBasinServiceImpl;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtSectionPointBasinDao;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionPointBasinParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * 水系站点Controller
 * @author ZhangGQ
 * @version 2019-06-25
 */
@Controller
@RequestMapping("/enviromonit/water/wtSectionPointBasin")
@Secured({ "ROLE_USER" })
public class WtSectionPointBasinController extends BaseController {

	@Autowired
	private WtSectionPointBasinDao wtSectionPointBasinDao;
	@Autowired
	private WtSectionPointBasinServiceImpl wtSectionPointBasinService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index(ModelAndView modelAndView) {
        modelAndView.setViewName("/moudles/enviromonit/water/wtSectionPointBasinList");
        return modelAndView;
	}
	
	/**
	 * 更新或新增
	 * @param wtSectionPointBasin
	 * @return
	 */	
	@RequestMapping("/saveWtSectionPointBasin")
	@ResponseBody
	public R saveWtSectionPointBasin(WtSectionPointBasin wtSectionPointBasin) {
		try {
			wtSectionPointBasinService.save(wtSectionPointBasin);
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
	@RequestMapping("/deleteWtSectionPointBasin")
	@ResponseBody
	public R deleteWtSectionPointBasin(@RequestParam(value = "uuid") String uuid) {
		try {
			wtSectionPointBasinService.delete(uuid);
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
	@RequestMapping("/getWtSectionPointBasin")
	@ResponseBody
	public Map<String, Object> getWtSectionPointBasin(@RequestParam(value = "uuid") String uuid) {
		WtSectionPointBasin wtSectionPointBasin = wtSectionPointBasinDao.getById(uuid);
		return BeanUtil.beanToMap(wtSectionPointBasin,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtSectionPointBasin
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtSectionPointBasinList")
	@ResponseBody
	public PageEU<WtSectionPointBasin> wtSectionPointBasinList(WtSectionPointBasinParam wtSectionPointBasinParam, HttpServletRequest request) {
		Page<WtSectionPointBasin> page = wtSectionPointBasinService.listByPage(wtSectionPointBasinParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
