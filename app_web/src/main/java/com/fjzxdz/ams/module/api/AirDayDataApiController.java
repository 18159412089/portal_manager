package com.fjzxdz.ams.module.api;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.annotation.ApiValid;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirDayDataDao;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/api/enviromonit/airDayData")
public class AirDayDataApiController extends BaseController {

	@Autowired
	private AirDayDataService airDayDataService;
	@Autowired
	private AirDayDataDao airDayDataDao;


	/**
	 * 
	 * @Title:  list
	 * @Description:    查询空气日数据信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:54:44
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:54:44    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
    @ApiValid(value = "350629")
	@ResponseBody
	public R list(String token,AirDayDataParam param, HttpServletRequest request, HttpServletResponse response) {
		WebServiceMessage msg = new WebServiceMessage();
		try {
				String startTime =  param.getStartTime();
				String endTime =  param.getEndTime();
				if( DateUtil.getDiffHour(startTime,endTime) <0) {
					msg.setMessage("时间格式出错,请输入YYYY-MM-DD HH:MM:SS格式！！！");
					return R.error(msg.toString());
				}
				if( DateUtil.getDiffHour(startTime,endTime) >24){
					msg.setMessage("查询间隔不能超过24小时！！！");
					return R.error(msg.toString());
				}
				Page<Map<String, Object>> airDayDataPage = airDayDataService.alllistByPage(param,  pageQuery(request),response);
				int page = pageQuery(request).getCurrentPage() + 1;
				int rows = pageQuery(request).getLimit();
				int total = (int) airDayDataPage.getTotalCount();
				msg.setList(airDayDataPage.getResult());
				msg.setPageInfo(page, rows, total);
		}catch (Exception e){
			return R.error(e.getMessage());
		}
		return R.ok().put("data", msg);

	}

 }
