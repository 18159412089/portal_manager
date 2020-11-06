/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirSiteHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;

/**
 * 
 * 空气站点气象小时数据Controller 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:53:22
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/air/airSiteHourData")
//@Secured({ "ROLE_USER" })
public class AirSiteHourDataController extends BaseController {

	@Autowired
	private AirSiteHourDataService airSiteHourDataService;
	@Autowired
	private AirSiteHourDataDao airSiteHourDataDao;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 
	 * @Title:  index
	 * @Description:    数据服务 空气环境质量 空气站点气象小时数据页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:53:33
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:53:33    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/enviromonit/air/airSiteHourDataList";
	}
	
	/**
	 * 更新或新增
	 * @param airSiteHourData
	 * @return
	 */	
/*	@RequestMapping("/saveAirSiteHourData")
	@ResponseBody
	public R saveAirSiteHourData(AirSiteHourData airSiteHourData) {
		try {
			airSiteHourDataService.save(airSiteHourData);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
/*	@RequestMapping("/deleteAirSiteHourData")
	@ResponseBody
	public R deleteAirSiteHourData(@RequestParam(value = "uuid") String uuid) {
		try {
			airSiteHourDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/

	/**
	 * 
	 * @Title:  getCity
	 * @Description:    TODO(获取气象数据的区县数据)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月19日 上午10:37:54
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月19日 上午10:37:54    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getCity")
	@ResponseBody
	public JSONArray getCity(){
		List<String> list = simpleDao.createNativeQuery("select distinct areaname from air_site_hour_data").getResultList();
		JSONArray array = new JSONArray();
		if (list != null) {
			for (String str : list) {
				JSONObject area = new JSONObject();
				area.put("uuid", str);
				area.put("name", str);
				array.add(area);
			}
		}
		return array;
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/getAirSiteHourData")
	@ResponseBody
	public Map<String, Object> getAirSiteHourData(String uuid) throws ParseException {
		String str[] = uuid.split("_");
		String potCode = str[0];
		String time = str[1];
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long lt = new Long(time);
        Date date = new Date(lt);
        String checkTime = simpleDateFormat.format(date);
		AirSiteHourData airSiteHourData = simpleDao.findUnique("from AirSiteHourData where POTCODE=? and to_char(CHECKTIME,'yyyy-mm-dd hh24:mi:ss')=?",potCode,checkTime);
		return BeanUtil.beanToMap(airSiteHourData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param airSiteHourDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/airSiteHourDataList")
	@ResponseBody
	public PageEU<AirSiteHourData> airSiteHourDataList(AirSiteHourDataParam airSiteHourDataParam, HttpServletRequest request) {
		Page<AirSiteHourData> page = airSiteHourDataService.listByPage(airSiteHourDataParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(AirSiteHourDataParam param, HttpServletResponse response){
		List<AirSiteHourData> lists = airSiteHourDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (AirSiteHourData airSiteHourData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("potcode", airSiteHourData.getPOTCODE());
			map.put("potname", airSiteHourData.getPOTNAME());
			map.put("checktime", airSiteHourData.getCHECKTIME());
			map.put("winddirt", airSiteHourData.getWINDDIRT());
			map.put("windspd", airSiteHourData.getWINDSPD());
			map.put("temp", airSiteHourData.getTEMP());
			map.put("humi", airSiteHourData.getHUMI());
			map.put("pressure", airSiteHourData.getPRESSURE());
			map.put("rainfall", airSiteHourData.getRAINFALL());
			map.put("state", airSiteHourData.getSTATE());
			result.add(map);
		}
		return exportEnvironmentNativeWtHourDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportEnvironmentNativeWtHourDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "气象小时数据表");
		columnMap.put("potcode", "点位代码");
		columnMap.put("potname", "点位名称");
		columnMap.put("checktime", "监测时间");
		columnMap.put("winddirt", "风向");
		columnMap.put("windspd", "风速(m/s)");
		columnMap.put("temp", "温度(°C)");
		columnMap.put("humi", "湿度(RH)");
		columnMap.put("pressure", "气压(Pa)");
		columnMap.put("rainfall", "降雨量(mm)");
		columnMap.put("state", "状态");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
