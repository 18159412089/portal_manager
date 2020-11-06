package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;
import com.fjzxdz.ams.module.enviromonit.pollution.param.PointParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PointService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/env/pollution/point")
public class PointController extends BaseController{

	@Autowired
	private PointService pointService;
	
	@RequestMapping("/pointList.do")
	public String index() {
		return "/moudles/enviromonit/pollution/pointList";
	}
	
	@RequestMapping("/dataread.do")
	public String index2() {
		return "/moudles/enviromonit/pollution/dataread";
	}
	
	/**
	 * 公司点位树
	 */
	@RequestMapping(value = "/pointTree")
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_USER')")
	public String getPointTree() {
		JSONArray jsonArray = pointService.getCompanyTree();
		return jsonArray.toString();
	}
	
	/**
	 * 查看
	 */
	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		Point point;
		try {
			point = pointService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("point", point);
	}
	
	/**
	 * 查询列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Point> list(PointParam pointParam, HttpServletRequest request) {
		Page<Point> page = pageQuery(request);
		Page<Point> pointPage = pointService.listByPage(pointParam, page);
		return new PageEU<>(pointPage);
	}
	
}
