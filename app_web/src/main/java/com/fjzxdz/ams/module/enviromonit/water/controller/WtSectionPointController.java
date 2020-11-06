package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.*;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionPointParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionPointService;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * 监测站点
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:30:31
 */
@Controller     
@RequestMapping("/enviromonit/water/wtSectionPoint")
@Secured({ "ROLE_USER" })
public class WtSectionPointController extends BaseController{
	
	@Autowired
	private WtSectionPointService wtSectionPointService;
	@Autowired
	public SimpleDao simpleDao;
    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView) {

        modelAndView.setViewName("/moudles/enviromonit/water/wtSectionPointList");
        return modelAndView;
    }
	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtSectionPointList")
	@ResponseBody
	public PageEU<WtSectionPoint> wtSectionPointList(WtSectionPointParam wtSectionPointParam, HttpServletRequest request) {
		Page<WtSectionPoint> page = wtSectionPointService.listByPage(wtSectionPointParam, pageQuery(request));
		return new PageEU<>(page);
	}
	/**
	 * 导出
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/export")
	@ResponseBody
	public void export(HttpServletRequest request, HttpServletResponse response) {
		WtSectionPointParam wtSectionPointParam=new WtSectionPointParam();
		String pointCode=request.getParameter("pointCode");
		String pointName=request.getParameter("pointName");
		String category=request.getParameter("category");
		String targetQuality=request.getParameter("targetQuality");
		wtSectionPointParam.setPointCode(pointCode);
		wtSectionPointParam.setPointName(pointName);
		wtSectionPointParam.setCategory(category);
		wtSectionPointParam.setTargetQuality(targetQuality);
		Page<WtSectionPoint> page = wtSectionPointService.listByPage(wtSectionPointParam, pageQuery(request));
		List<WtSectionPoint> list=page.getResult();
		if(list.size()!=0) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			columnMap.put("title", "手工监测水质站点");
			columnMap.put("pointCode", "断面编码");
			columnMap.put("pointName", "断面名称");
			columnMap.put("category", "断面类型");
			columnMap.put("targetQuality", "目标水质");
			List<Map<String, Object>> result = new ArrayList<>();
			for (WtSectionPoint wtSectionPoint : list) {
				Map<String, Object> tempMap = new HashMap<>();
				tempMap.put("pointCode",wtSectionPoint.getPointCode());
				tempMap.put("pointName",wtSectionPoint.getPointName());
				tempMap.put("category",wtSectionPoint.getCategory());
				tempMap.put("targetQuality",wtSectionPoint.getTargetQuality());
				result.add(tempMap);
			}
			ExcelExportUtil.exportExcel(response, columnMap, result);
		}
	}
	
	/**
	 * 
	 * @Title:  getPointList
	 * @Description:    获取站点列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:05:54
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:05:54    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPointList")
	@ResponseBody
	public JSONArray getPointList(int type) {
		return wtSectionPointService.getPointList(type);
	}
	
	/**
	 * 
	 * @Title:  getPointsList
	 * @Description:   获取站点列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:07:19
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:07:19    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPointsList")
	@ResponseBody
	public JSONArray getPointsList(int type) {
		return wtSectionPointService.getPointsList(type);
	}
	
	
	/**
	 * 获取国控，省控 目标水质比例
	 * @return
	 */
	@RequestMapping("/getSectionSuccessRate")
	@ResponseBody
	public JSONObject getSectionTargetRate(){
		JSONObject jsonObject = new JSONObject();
		String[] typeArr = {"1","2","3"}; 
		int tagetAllCountry  = 0;
		int tagetallProvince = 0;
		int tagetOkCountry =   0;
		int tagetOkProvince =  0;
	    String sql = "select  TARGET_QUALITY ,CATEGORY from WT_SECTION_POINT ";
	    List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
		if (resultList.size() > 0) {
			for (Object[] objects : resultList) {
				 if(objects[1].equals(typeArr[0])){
					 tagetAllCountry++;
					if(isSuccess(objects[0].toString())){
						tagetOkCountry++;
					}
				  }else if(objects[1].equals(typeArr[1])){
					  tagetallProvince++;
					 if(isSuccess(objects[0].toString())){
						 tagetOkProvince++;
					  }
				  }
		    }
		}
		float targetCountyRate =  Float.valueOf(tagetOkCountry)/tagetAllCountry;
		float targetProviceRate = Float.valueOf(tagetOkProvince)/tagetallProvince;
		jsonObject.put("targetCountyRate", targetCountyRate) ;
		jsonObject.put("targetProviceRate", targetProviceRate) ;
		return jsonObject ;
	}
	private boolean isSuccess(String levelStr) {
		String[] successLevel = {"FIRSR","SECOND","THIRD"}; 
		for (String string : successLevel) {
			 if(string.equals(levelStr))
			 {
				 return true ;
			 }		
	   }
		return false ;
	}
	
}
