/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.common.utils;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import com.fjzxdz.ams.module.area.dao.SiteInfoDao;
import com.fjzxdz.ams.module.area.entity.SiteInfo;
import com.fjzxdz.ams.module.area.param.SiteInfoParam;
import com.fjzxdz.ams.module.area.service.SiteInfoService;
import org.apache.catalina.LifecycleState;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@org.springframework.stereotype.Controller
 
@RequestMapping(value = "/ExportExcel")
 
public class ExcelExportUtilController extends BaseController {
	
	@Autowired
	private SiteInfoDao siteInfoDao;
	@Autowired
	private SiteInfoService siteInfoService;
	@Autowired
	private SimpleDao simpleDao;


	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/doExcelExport")
	@ResponseBody
	public R doExcelExport(Array columnEnglishName,Array columnName, List result, HttpServletResponse response) {
		try {
			//ExcelExportUtil.exportExcel(response, columnMap, result);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	

}
