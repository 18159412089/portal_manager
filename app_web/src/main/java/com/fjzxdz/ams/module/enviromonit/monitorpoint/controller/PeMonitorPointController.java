/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.monitorpoint.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.factormanual.entity.PeFactorManual;
import com.fjzxdz.ams.module.enviromonit.factormanual.service.PeFactorManualService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.factor.dao.PeFactorDao;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.dao.PeMonitorPointDao;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.entity.PeMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.param.PeMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.service.PeMonitorPointService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.utils.ValidateUtil;

/**
 * monitorPointController
 * @author htj
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/monitorPoint/pemonitorpoint")
@Secured({ "ROLE_USER"})
public class PeMonitorPointController extends BaseController {

	@Autowired
	private PeMonitorPointDao peMonitorPointDao;
	@Autowired
	private PeMonitorPointService peMonitorPointService;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private PeFactorDao peFactorDao;
    @Autowired
    private PeFactorManualService peFactorManualService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/modules/enviromonit/monitorPoint/pemonitorpointList";
	}
	
	/**
	 * 更新或新增
	 * @param peMonitorPoint
	 * @return
	 */	
	@RequestMapping("/savePeMonitorPoint")
	@ResponseBody
	public R savePeMonitorPoint(PeMonitorPoint peMonitorPoint) {
		try {
			String validateResult=ValidateUtil.validate(peMonitorPoint);
			if(validateResult!=null) {
				return R.error(validateResult);
			}
			peMonitorPointService.save(peMonitorPoint);
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
	@RequestMapping("/deletePeMonitorPoint")
	@ResponseBody
	public R deletePeMonitorPoint(@RequestParam(value = "uuid") String uuid) {
		try {
			peMonitorPointService.delete(uuid);
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
	@RequestMapping("/getPeMonitorPoint")
	@ResponseBody
	public Map<String, Object> getPeMonitorPoint(@RequestParam(value = "uuid") String uuid) {
		PeMonitorPoint peMonitorPoint;
		try {
			peMonitorPoint = peMonitorPointDao.getById(uuid);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peMonitorPoint", peMonitorPoint);
	}
	
	/**
	 * 查询列表
	 * @param peMonitorPointParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/peMonitorPointList")
	@ResponseBody
	public PageEU<PeMonitorPoint> peMonitorPointList(PeMonitorPointParam peMonitorPointParam, HttpServletRequest request) {
		Page<PeMonitorPoint> page = peMonitorPointService.listByPage(peMonitorPointParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<PeMonitorPoint> list(@RequestParam(value = "page",required=false) Integer page,@RequestParam(value = "rows",required=false) Integer rows,@RequestParam(value = "outType") String outType,@RequestParam(value = "outName",required=false) String outName, HttpServletRequest request) {
		Page dataPage = new Page<>();
		if (page != null) {
			dataPage.setCurrentPage(page-1);
		}
		if (rows != null) {
			dataPage.setLimit(rows);
		}
		String sqlStr = "select distinct e.PE_ID,e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE from PE_MONITOR_POINT p inner join PE_ENTERPRISE_DATA e on p.PE_ID=e.PE_ID where p.OUTFALL_TYPE="+outType;
		if (StringUtils.isNotEmpty(outName)) {
			sqlStr += " and e.PE_NAME like '%"+outName+"%'";
		}
		simpleDao.listNativeByPage(sqlStr, dataPage);
		return new PageEU<>(dataPage);
	}
	
	/**
	 * 获取排口的id与名称 不分页
	 */
	@RequestMapping("/listNoPage")
	@ResponseBody
	public List<Object[]> listNoPage(String outType,String peId) {
		String sqlStr = "select p.OUTPUT_ID,p.name from PE_MONITOR_POINT p"
				+ " inner join PE_ENTERPRISE_DATA e on p.PE_ID=e.PE_ID"
				+ " where p.OUTFALL_TYPE="+outType +" and p.PE_ID='"+peId+"'";
		return simpleDao.createNativeQuery(sqlStr).getResultList();
	}
	
	/**
	 * 根据企业获取排口列表信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeMonitorPointListByPeId")
	@ResponseBody
	public List<PeMonitorPoint> getPeMonitorPointListByPeId(String peId) {
		List<PeMonitorPoint> peMonitorPointsList;
		peMonitorPointsList = peMonitorPointService.getPeMonitorPointListByPeId(peId);
		return peMonitorPointsList;
	}
	
	@RequestMapping("/getPeMonitorPointInfo")
	@ResponseBody
	public String getPeMonitorPointInfo(@RequestParam(value = "outType") String outType) {
		
		String sqlStr = "select p.OUTPUT_ID,p.name,e.PE_NAME,p.LONGITUDE,p.LATITUDE from PE_MONITOR_POINT p "
				+ "inner join PE_ENTERPRISE_DATA e on p.PE_ID=e.PE_ID where p.OUTFALL_TYPE= "+outType;
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		List<Object[]> list = simpleDao.createNativeQuery(sqlStr).getResultList();
		int i = 0;
		for (Object[] objects : list) {
			jsonObject.put("outputId", objects[0]);
			jsonObject.put("name", objects[1]);
			jsonObject.put("peName", (objects[2]));
			if (null != objects[3]&& null != objects[4]) {
				jsonObject.put("longitude", Double.valueOf(String.valueOf(objects[3])));
				jsonObject.put("latitude", Double.valueOf(String.valueOf(objects[4])));
				jsonArray.put(jsonObject);
				i++;
			}
			
		}
		System.out.println(i);
		return jsonArray.toString();
	}
	
	@RequestMapping("/getPeMonitorPointInfoForCompare")
	@ResponseBody
	public String getPeMonitorPointInfoForCompare(@RequestParam(value = "outType") String outType) {
		
		String sqlStr = "select p.OUTPUT_ID,p.name,e.PE_NAME,p.LONGITUDE,p.LATITUDE from PE_MONITOR_POINT p "
				+ "inner join PE_ENTERPRISE_DATA e on p.PE_ID=e.PE_ID where p.OUTFALL_TYPE= "+outType;
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		List<Object[]> list = simpleDao.createNativeQuery(sqlStr).getResultList();
		int i = 0;
		for (Object[] objects : list) {
			jsonObject.put("outputId", objects[0]);
			jsonObject.put("name", objects[1]);
			jsonObject.put("peName", (objects[2]));
			jsonArray.put(jsonObject);
			i++;
			
		}
		System.out.println(i);
		return jsonArray.toString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getConHourchart")
	@ResponseBody
	public Map<String, Object> getConHourchart(String outputId, String outType, Integer hours ,String code) throws Exception {
		Map<String, Object> result = new HashMap<>();
		List<String> xAxis = new ArrayList<String>();
		Map<String, Object> timeMap = DateUtil.getSomeHours(hours,1);
		String startTime = timeMap.get("startTime").toString();
		String endTime = timeMap.get("endTime").toString();
		xAxis = (List<String>) timeMap.get("xList");
		Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
		String[] outputIds = outputId.split(",");
		String outputIdStr="'" + StringUtils.join(outputIds,"','") +"'";
		String sqlString ;
		String unit = "";
		
		if (code.equals("FLUX_AVG") ||code.equals("FLUX_SUM") ) {
			sqlString = "select c.OUTPUT_ID,m.NAME,to_char(c.MEASURE_TIME,'yyyy-mm-dd hh24'),c.OUTFALL_TYPE,c."+code
					+ " from PE_MONITOR_POINT m inner join PE_HOUR_FLUX_DATA c on m.OUTPUT_ID=c.OUTPUT_ID "
					+ "and c.MEASURE_TIME>=TO_DATE( '" + startTime+"', 'yyyy-mm-dd hh24:mi:ss' ) "
							+ "and c.MEASURE_TIME<=TO_DATE( '" + endTime+"', 'yyyy-mm-dd hh24:mi:ss' )  where c.OUTFALL_TYPE = "+ outType
					+ " and m.OUTPUT_ID in(" + outputIdStr + ") order by c.OUTPUT_ID,c.MEASURE_TIME  asc";
			if(code.equals("FLUX_AVG")) {
				unit = "(立方米/小时)";
			} else {
				unit = "(千立方米)";
			}
		}else {
			sqlString = "select c.OUTPUT_ID,m.NAME,to_char(c.MEASURE_TIME,'yyyy-mm-dd hh24'),c.PLU_CODE,c.CHROMA_AVG"
					+ " from PE_MONITOR_POINT m inner join PE_CON_HOUR_DATA c on m.OUTPUT_ID=c.OUTPUT_ID "
					+ "and c.MEASURE_TIME>=TO_DATE( '" + startTime+"', 'yyyy-mm-dd hh24:mi:ss' ) "
							+ "and c.MEASURE_TIME<=TO_DATE( '" + endTime+"', 'yyyy-mm-dd hh24:mi:ss' ) and c.PLU_CODE = '" + code + "' where c.OUTFALL_TYPE = "+ outType
					+ " and m.OUTPUT_ID in(" + outputIdStr + ") order by c.OUTPUT_ID,c.MEASURE_TIME asc,c.PLU_CODE asc";
			
			String sqlUnit = "select distinct c.name from PE_FACTOR f left join PE_COMMON_CODE c on f.UNIT_CODE=c.id"
					+ " where c.name is not null and f.OUTPUT_ID in(" + outputIdStr + ") and f.PLU_CODE='" + code + "'";
			List<Object> UnitList = simpleDao.createNativeQuery(sqlUnit).getResultList();
			if (!UnitList.isEmpty() && StringUtils.isNotEmpty(UnitList.get(0).toString())) {
				unit = "("+UnitList.get(0).toString()+")";
			}
		}
		List<Object[]> list = simpleDao.createNativeQuery(sqlString).getResultList();
		
		Map<String,Object[]> series = new HashMap<String,Object[]>();
		Map<String,String> keyMap = new	HashMap<String,String>();
		for (Object[] obj : list) {
			if(obj[0]!=null) {
				keyMap.put(obj[0].toString(), obj[1].toString());
				if (series.containsKey(obj[0].toString())) {
					if (obj[4] != null) {
						series.get(obj[0].toString())[indexmap.get(obj[2])]=obj[4];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[4] != null) {
						tempList[indexmap.get(obj[2])]=obj[4];
					}
					series.put(obj[0].toString(), tempList);
				}
			}
		}
		List<String> legendList = new ArrayList<String>();
		JSONArray xArray = new JSONArray();
		result.put("xAxis", xAxis);
		for (Object key : series.keySet()) {
			legendList.add(keyMap.get(key));
			JSONObject xObject = new JSONObject();
			xObject.put("data", series.get(key));
			xObject.put("type", "line");
			xObject.put("name", keyMap.get(key));
			xArray.add(xObject);
		}
		//根据排口ID获取相应排口监测因子上下限值
        Map<String, Map<String, Object>> allPollutantStandardMap = peFactorManualService.getLimitValueByMonitorPointId(outputId.replace(",",""));
        Map<String, Object> pollutantStandardMap = new HashMap<>();
        if(allPollutantStandardMap.containsKey(code)){
            pollutantStandardMap = allPollutantStandardMap.get(code);
        }

		result.put("unit", unit);
		result.put("legend", legendList);
		result.put("series", xArray);
		result.put("pollutantStandardMap", pollutantStandardMap);
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getFactor")
	@ResponseBody
	public List<Object[]> getFactor(String peId, String outType) throws Exception {
		List<Object[]> list = peFactorDao.createNativeQuery("select distinct a.PLU_CODE,a.PLU_NAME from PE_FACTOR a " 
				+ " left join PE_MONITOR_POINT b on a.OUTPUT_ID = b.OUTPUT_ID and b.status=1"
				+ " left join PE_ENTERPRISE_DATA c on b.PE_ID=c.PE_ID and c.status=1"
				+ " where a.STATUS=1 and a.PLU_TYPE=? and a.IS_USED=1 and c.PE_ID=? order by a.PLU_CODE asc",outType,peId).getResultList();
		Object[] lsarr = {"FLUX_AVG","流量均值"}; 
		Object[] llarr = {"FLUX_SUM","累计流量"}; 
		list.add(lsarr);
		list.add(llarr);
		return list;
	}




	/**
	 * 获取下拉排口列表信息
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("/getCompnentPeMonitorPointDatasList")
	@ResponseBody
	public JSONArray getCompnenPeMonitorPointDatasList() {
		JSONArray pePointDatasArray = new JSONArray();
		List<PeMonitorPoint> pePointDatasList;
		pePointDatasList = peMonitorPointService.getCompnentPeMonitorPointDatasList();
		for (PeMonitorPoint peEnterpriseData : pePointDatasList) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", peEnterpriseData.getOutputId());
			jsonObject.put("text", peEnterpriseData.getName());
			pePointDatasArray.add(jsonObject);
		}
		return pePointDatasArray;
	}




}
