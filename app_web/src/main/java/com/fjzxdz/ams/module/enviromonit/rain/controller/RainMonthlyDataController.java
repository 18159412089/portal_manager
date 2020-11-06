package com.fjzxdz.ams.module.enviromonit.rain.controller;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.module.enviromonit.rain.entity.RainMonthlyData;
import com.fjzxdz.ams.module.enviromonit.rain.param.RainMonthlyDataParam;
import com.fjzxdz.ams.module.enviromonit.rain.service.RainMonthlyDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/enviromonit/rainMonthlyData")
@Secured({ "ROLE_USER" })
public class RainMonthlyDataController extends BaseController {

	@Autowired
	private RainMonthlyDataService rainMonthlyDataService;
	
	@RequestMapping(value = "")
	public String index() {
		return "/moudles/enviromonit/rain/rainMonthlyData";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageEU<RainMonthlyData> list(RainMonthlyDataParam param, HttpServletRequest request) {
		Page<RainMonthlyData> page = pageQuery(request);
		Page<RainMonthlyData> rainMonthlyDataPage = rainMonthlyDataService.listByPage(param, page);
		return new PageEU<>(rainMonthlyDataPage);
	}
	
	@RequestMapping("/savaRainMonthlyData")
	@ResponseBody
	public R savaRainMonthlyData(RainMonthlyData rainMonthlyData) {
		
		R r;
		try {
			r = rainMonthlyDataService.save(rainMonthlyData);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}
	
	/**
	 * 查看降雨量信息
	 */
	@RequestMapping(value = "/getRainMonthlyData")
	@ResponseBody
	public R getRainMonthlyData(@RequestParam(value = "uuid") String uuid) {
		RainMonthlyData rainMonthlyData;
		try {
			rainMonthlyData = rainMonthlyDataService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("rainMonthlyData", rainMonthlyData);
	}

	
}
