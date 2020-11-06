/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factor.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.ValidateUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import com.fjzxdz.ams.module.enviromonit.daydata.service.PeConDayDataService;
import com.fjzxdz.ams.module.enviromonit.factor.dao.PeFactorDao;
import com.fjzxdz.ams.module.enviromonit.factor.entity.PeFactor;
import com.fjzxdz.ams.module.enviromonit.factor.param.PeFactorParam;
import com.fjzxdz.ams.module.enviromonit.factor.service.PeFactorService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 * 污染源自动监控点位采集因子Controller
 * @author htj
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/factor/pefactor")
public class PeFactorController extends BaseController {

	@Autowired
	private PeFactorDao peFactorDao;
	@Autowired
	private PeFactorService peFactorService;
	@Autowired
	private PeConDayDataService peConDayDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@PreAuthorize("hasAuthority('factor:pefactor:show')")
	@RequestMapping("")
	public String index() {
		return "/modules/enviromonit/factor/pefactorList";
	}
	
	/**
	 * 更新或新增
	 * @param peFactor
	 * @return
	 */	
	@PreAuthorize("hasAnyAuthority('factor:pefactor:add,factor:pefactor:edit')")
	@RequestMapping("/savePeFactor")
	@ResponseBody
	public R savePeFactor(PeFactor peFactor) {
		try {
			String validateResult=ValidateUtil.validate(peFactor);
			if(validateResult!=null) {
				return R.error(validateResult);
			}
			peFactorService.save(peFactor);
		} catch (Exception e) {
			//return R.error(e.getMessage());
			return R.error(e);
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@PreAuthorize("hasAuthority('factor:pefactor:delete')")
	@RequestMapping("/deletePeFactor")
	@ResponseBody
	public R deletePeFactor(@RequestParam(value = "uuid") String uuid) {
		try {
			peFactorService.delete(uuid);
		} catch (Exception e) {
			return R.error(e);
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getPeFactor")
	@ResponseBody
	public Map<String, Object> getPeFactor(@RequestParam(value = "uuid") String uuid) {
		PeFactor peFactor;
		try {
			peFactor = peFactorDao.getById(uuid);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peFactor", peFactor);
	}
	
	/**
	 * 查询列表
	 * @param peFactor
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAuthority('factor:pefactor:show')")
	@RequestMapping("/peFactorList")
	@ResponseBody
	public PageEU<PeFactor> peFactorList(PeFactorParam peFactorParam, HttpServletRequest request) {
		Page<PeFactor> page = peFactorService.listByPage(peFactorParam, pageQuery(request));
		return new PageEU<>(page);
	}
	/**
	 * 根据排口ID获取列表标题
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeFactorListColumnTitleByOutputId")
	@ResponseBody
	public JSONObject getPeFactorListColumnTitleByOutputId(String outputId, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		
		List<PeFactor> peFactorList = peFactorService.getPeFactorListByOutputId(outputId);
		JSONArray peFactorColumnArray = new JSONArray();
		//标题
		JSONObject jsonStr = new JSONObject();
		Double columnWidth = 100.0;
		jsonStr.put("field","measureTime");
		jsonStr.put("title","监测时间");
		jsonStr.put("width",150);
		peFactorColumnArray.add(jsonStr);
		
		JSONObject peFactorColumnThreshold = new JSONObject();
		for(PeFactor peFactor : peFactorList){
			JSONObject jsonObject = new JSONObject();

			//if("0".equals(peFactor.getIsUsed())){
				jsonObject.put("field",peFactor.getPluCode());
				jsonObject.put("title",peFactor.getPluName());
				jsonObject.put("width",columnWidth);
				
				peFactorColumnArray.add(jsonObject);
				peFactorColumnThreshold.put(peFactor.getPluCode(), peFactor.toJSONObject());
			//}
		}
		result.put("peFactorColumnArray", peFactorColumnArray);
		result.put("peFactorColumnThreshold", peFactorColumnThreshold);
		return result;
	}
}
