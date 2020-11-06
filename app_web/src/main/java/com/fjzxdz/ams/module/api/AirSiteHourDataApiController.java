/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.api;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.annotation.ApiValid;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirSiteHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * 空气站点气象小时数据Controller 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:53:22
 */
@Controller
@RequestMapping(value = "/api/air/airSiteHourData")
//@Secured({ "ROLE_USER" })
public class AirSiteHourDataApiController extends BaseController {

	@Autowired
	private AirSiteHourDataService airSiteHourDataService;
	@Autowired
	private AirSiteHourDataDao airSiteHourDataDao;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 查询列表
	 * @param airSiteHourDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/airSiteHourDataList")
    @ApiValid(value = "350629")
	@ResponseBody
	public  R airSiteHourDataList(String token,AirSiteHourDataParam airSiteHourDataParam, HttpServletRequest request) {
		WebServiceMessage msg = new WebServiceMessage();
		try {
			String startTime = airSiteHourDataParam.getStartTime();
			String endTime =   airSiteHourDataParam.getEndTime();
            if( DateUtil.getDiffHour(startTime,endTime) <0) {
                msg.setMessage("时间格式出错,请输入YYYY-MM-DD HH:MM:SS格式！！！");
                return R.error(msg.toString());
            }
			if( DateUtil.getDiffHour(startTime,endTime) >24){
				msg.setMessage("查询间隔不能超过24小时！！！");
				return R.error(msg.toString());
			}
			airSiteHourDataParam.setPOSCODE(token);
			Page<AirSiteHourData> pageData = airSiteHourDataService.alllistByPage(airSiteHourDataParam, pageQuery(request));
			int page = pageQuery(request).getCurrentPage() + 1;
			int rows = pageQuery(request).getLimit();
			int total = (int) pageData.getTotalCount();
			msg.setList(pageData.getResult());
			msg.setPageInfo(page, rows, total);
		}catch (Exception e){
			return R.error(e.getMessage());
		}
		return R.ok().put("data", msg);
	}
}
