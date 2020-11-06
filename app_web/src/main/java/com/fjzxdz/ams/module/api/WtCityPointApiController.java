package com.fjzxdz.ams.module.api;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.annotation.ApiValid;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityPointParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * enviromonit/water/wtCityPoint/getPointRegionList
 * 监测站点
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:30:31
 */
@Controller
@RequestMapping("/api/enviromonit/water/wtCityPoint")
public class WtCityPointApiController extends BaseController{

	@Autowired
	private WtCityPointService wtCityPointService;

	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtCityAllPointList")
    @ApiValid(value = "350629")
	@ResponseBody
	public R wtCityAllPointList(String token,WtCityPointParam wtCityPointParam, HttpServletRequest request, HttpServletResponse response) {
		WebServiceMessage msg = new WebServiceMessage();
		try {
		wtCityPointParam.setCodeRegion("350629000000");
		Page<WtCityPoint> pageData = wtCityPointService.listByPage(wtCityPointParam, pageQuery(request));
		List<WtCityPoint> list=pageData.getResult();
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
