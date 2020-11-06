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
import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * 在线水天数据服务
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:32:30
 */
@Controller
@RequestMapping("/api/enviromonit/water/wtDayData")
public class WtDayDataApiController extends BaseController {

	@Autowired
	private WtDayDataService wtDayDataService;


	/**
	 * 
	 * @Title:  list
	 * @Description:    在线水天数据列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:09:35
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:09:35    
	 * @param param
	 * @param request
	 * @return  PageEU<WtDayData> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
    @ApiValid(value = "350629")
	@ResponseBody
	public R getPageList(String token ,WtDayDataParam param, HttpServletRequest request){
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
			Page<Map<String, Object>> wtHourDataPage = wtDayDataService.getPageAllList(param,  pageQuery(request));
			int page = pageQuery(request).getCurrentPage() + 1;
			int rows = pageQuery(request).getLimit();
			int total = (int) wtHourDataPage.getTotalCount();
			msg.setList(wtHourDataPage.getResult());
			msg.setPageInfo(page, rows, total);
		}catch (Exception e){
			return R.error(e.getMessage());
		}
		return R.ok().put("data", msg);
	}


}
