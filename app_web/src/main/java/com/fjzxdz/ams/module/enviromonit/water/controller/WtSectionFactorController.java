package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 
 * 监测因子控制器
 * @Author   ZhangGQ
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:36:50
 */
@Controller
@RequestMapping("/enviromonit/water/wtSectionFactor")
@Secured({ "ROLE_USER" })
public class WtSectionFactorController extends BaseController{
	
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 
	 * @Title:  getPointList
	 * @Description:   获取水环境站点列表 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:37:09
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:37:09    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getFactorList")
	@ResponseBody
	public JSONArray getFactorList(int type) {
		String sql="SELECT DISTINCT CODE_POLLUTE,POLLUTENAME FROM WT_SECTION_FACTOR a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.CATEGORY=?";
		List<Object[]> resultList = simpleDao.createNativeQuery(sql, type).getResultList();
		if (ToolUtil.isNotEmpty(resultList)) {
			JSONArray array = new JSONArray();
			for (Object[] object : resultList) {
				JSONObject temp = new JSONObject();
				temp.put("key", object[0]);
				temp.put("text", object[1]);
				array.add(temp);
			}
			return array;
		}
		return new JSONArray();
	}
}