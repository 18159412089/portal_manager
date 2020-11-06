package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
/**
 * 
 * 优良变化天数controller 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:43:36
 */
@Controller
@RequestMapping("/enviromonit/airQuality")
@Secured({ "ROLE_USER" })
public class AirQualityController extends BaseController {
	
	
	
	@Autowired
	private AirDailyService airDailyService;
	/**
	 * 
	 * @Title:  getAirQualityAQI
	 * @Description:    数据服务 空气环境质量 跳转到优良变化天数页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:43:54
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:43:54    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping(value = "")
	public String getAirQualityAQI() {
		return "/moudles/enviromonit/air/airQuality";
	}
	/**
	 * 
	 * @Title:  getAllLevelsDays
	 * @Description:    该地区各级别天数历年对比    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:49:55
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:49:55    
	 * @param param
	 * @param yearNum
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/getAllLevelsDays")
	@ResponseBody
	public R getAllLevelsDays(AirDayDataParam param,String yearNum) {
		
		Map<String, Object> map = airDailyService.getAllLevelsDays(param.getPointCode(),param.getStartTime(),param.getEndTime(),yearNum);
		return R.ok(map);
	}

	/**
	 * 
	 * @Title:  list
	 * @Description:    获取年度本地区的空气分布信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:50:22
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:50:22    
	 * @param param
	 * @param yearNum
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Map<String, Object>> list(AirDayDataParam param,String yearNum, HttpServletRequest request) {

		Page<Map<String, Object>> page = pageQuery(request);
		try {
			JSONArray jsonArray = airDailyService.getAllLevelsDaysForm(param.getPointCode(),param.getStartTime(),param.getEndTime(),yearNum);
			List<Map<String, Object>> list = new ArrayList<>();
			if (jsonArray != null) {
				page.setTotalCount(jsonArray.size());
				if (page.isNext()) {
					for (int i = page.getLimit() * page.getCurrentPage(); i < page.getLimit() * page.getCurrentPage()
							+ 10; i++) {
						Map<String, Object> tempMap = jsonArray.getJSONObject(i);

						list.add(tempMap);
					}
					page.setResult(list);
				} else {
					for (int i = page.getLimit() * page.getCurrentPage(); i < page.getTotalCount(); i++) {
						Map<String, Object> tempMap = jsonArray.getJSONObject(i);

						list.add(tempMap);
					}
					page.setResult(list);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new PageEU<>(page);
	}
}
