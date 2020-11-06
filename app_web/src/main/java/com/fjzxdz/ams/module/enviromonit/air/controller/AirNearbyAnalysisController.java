package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.math.BigDecimal;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirConstructionSite;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.util.DistanceCalculateUtil;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;

@Controller
@RequestMapping("/enviromonit/air/nearbyAnalysis")
@Secured({ "ROLE_USER" })
public class AirNearbyAnalysisController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;

	@RequestMapping(value = "")
	public String init(@RequestParam(value = "code")String code,@RequestParam(value = "range")BigDecimal range,Model model) {
		model.addAttribute("code", code);
		model.addAttribute("range", range);
		return "/moudles/enviromonit/air/nearbyAnalysis";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/peList")
	@ResponseBody
	public PageEU<Object> peList(@RequestParam(value = "code")String code,@RequestParam(value = "range")BigDecimal range,@RequestParam(value = "sort")String sort,@RequestParam(value = "order")String order,Model model) {
		AirMonitorPoint point = simpleDao.findUnique("from AirMonitorPoint where pointCode=?", code);
		List<PeEnterpriseData> esList = simpleDao.find("from PeEnterpriseData where longValue is not null and latValue is not null");
		List<String> eids = new ArrayList<String>();
		for (PeEnterpriseData enterprise : esList) {
			Double r = DistanceCalculateUtil.distanceCalculate(point.getLongitude().doubleValue(), point.getLatitude().doubleValue(), Double.parseDouble(enterprise.getLongValue()), Double.parseDouble(enterprise.getLatValue()));
			if((new BigDecimal(r)).compareTo(range)<=0) {
				eids.add(enterprise.getPeId());
			}
		}
		String orderBy=" ";
		if (StringUtils.isNotEmpty(sort)) {
			orderBy += "order by "+sort;
		}
		if (StringUtils.isNotEmpty(order)) {
			orderBy += " "+order;
		}
		
		List<Object> list = new ArrayList<Object>();
		List<Map<String,Object>> tempList = new ArrayList<Map<String,Object>>();
		if(eids.size()>0) {
			String sql = "select * from (select a.output_id,ap.name,ae.pe_name,to_char(a.measure_time,'yyyy-mm-dd hh24'),a.c1,decode(h.flux_sum,null,0,h.flux_sum) as c2,ROUND(a.c1*decode(h.flux_sum,null,0,h.flux_sum)/1000000,2) as c3 from (select d.OUTPUT_ID as output_id,d.MEASURE_TIME as measure_time," + 
					"SUM(DECODE(d.PLU_CODE,'03-Zs',d.CHROMA_AVG,0)) as c1 " + 
					"from PE_CON_HOUR_DATA d " + 
					"where (d.OUTPUT_ID,d.MEASURE_TIME) in  (select t.OUTPUT_ID,MAX(t.MEASURE_TIME) from PE_CON_HOUR_DATA t " + 
					"inner join pe_enterprise_data e on t.pe_id=e.pe_id and e.pe_id in ('"+StringUtils.join(eids, "','")+"') " + 
					"inner join pe_monitor_point p on e.pe_id=p.pe_id and p.outfall_type='2' " + 
					"where t.MEASURE_TIME>=SYSDATE-1 group by t.OUTPUT_ID) group by d.OUTPUT_ID,d.MEASURE_TIME) a " + 
					"inner join pe_monitor_point ap on a.output_id=ap.output_id and ap.outfall_type='2' " + 
					"inner join pe_enterprise_data ae on ap.pe_id=ae.pe_id " + 
					"left join pe_hour_flux_data h on a.output_id=h.output_id and a.measure_time=h.measure_time)"+orderBy;
			list = simpleDao.createNativeQuery(sql).getResultList();
			if (list != null&&list.size()>0) {
				for (Object o : list) {
					Object[] arr = (Object[]) o;
					Map<String,Object> tempMap = new HashMap<String,Object>();
					tempMap.put("outputId", arr[0]);
					tempMap.put("peName", arr[2]);
					tempMap.put("name", arr[1]);
					tempMap.put("measureTime", arr[3]);
					tempMap.put("c1", arr[4]);
					tempMap.put("c2", arr[5]);
					tempMap.put("c3", arr[6]);
					tempList.add(tempMap);
				}
			}
		}
		return new PageEU(tempList);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/projectList")
	@ResponseBody
	public PageEU<Object> projectList(@RequestParam(value = "code")String code,@RequestParam(value = "range")BigDecimal range,@RequestParam(value = "sort")String sort,@RequestParam(value = "order")String order,Model model) {
		AirMonitorPoint point = simpleDao.findUnique("from AirMonitorPoint where pointCode=?", code);
		List<AirConstructionSite> esList = simpleDao.find("from AirConstructionSite where longitude is not null and latitude is not null");
		List<String> eids = new ArrayList<String>();
		for (AirConstructionSite enterprise : esList) {
			Double r = DistanceCalculateUtil.distanceCalculate(point.getLongitude().doubleValue(), point.getLatitude().doubleValue(), enterprise.getLongitude().doubleValue(), enterprise.getLatitude().doubleValue());
			if((new BigDecimal(r)).compareTo(range)<=0) {
				eids.add(enterprise.getPkid());
			}
		}
		String orderBy=" ";
		if (StringUtils.isNotEmpty(sort)) {
			orderBy += "order by TO_NUMBER(BUILT_VALUE)";
		}
		if (StringUtils.isNotEmpty(order)) {
			orderBy += " "+order;
		}
		
		List<Object> list = new ArrayList<Object>();
		List<Map<String,Object>> tempList = new ArrayList<Map<String,Object>>();
		if(eids.size()>0) {
			String sql = "select name,BUILT_VALUE,ADDRESS,REMARK from AIR_CONSTRUCTION_SITE where pkid in ('"+StringUtils.join(eids, "','")+"')"+orderBy;
			list = simpleDao.createNativeQuery(sql).getResultList();
			if (list != null&&list.size()>0) {
				for (Object o : list) {
					Object[] arr = (Object[]) o;
					Map<String,Object> tempMap = new HashMap<String,Object>();
					tempMap.put("name", arr[0]);
					tempMap.put("builtValue", arr[1]);
					tempMap.put("address", arr[2]);
					tempMap.put("remark", StringUtils.ClobToString((Clob) arr[3]));
					tempList.add(tempMap);
				}
			}
		}
		return new PageEU(tempList);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getConHourchart")
	@ResponseBody
	public Map<String, Object> getConHourchart(Long outputId, Integer hours ,Integer codeIndex) throws Exception {
		Map<String, Object> result = new HashMap<>();
		List<String> xAxis = new ArrayList<String>();
		Map<String, Object> timeMap = DateUtil.getSomeHours(hours,1);
		String startTime = timeMap.get("startTime").toString();
		String endTime = timeMap.get("endTime").toString();
		xAxis = (List<String>) timeMap.get("xList");
		Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
		String sqlString="select " + 
				"to_char(a.measure_time,'yyyy-mm-dd hh24')," + 
				"a.c1," + 
				"decode(h.flux_sum,null,0,h.flux_sum) as c2," + 
				"ROUND(a.c1*decode(h.flux_sum,null,0,h.flux_sum),2) as c3 " + 
				"from (select d.OUTPUT_ID,d.MEASURE_TIME,SUM(DECODE(d.PLU_CODE,'03-Zs',d.CHROMA_AVG,0)) as c1 " + 
				"from PE_CON_HOUR_DATA d  " + 
				"inner join pe_enterprise_data e on d.pe_id=e.pe_id " + 
				"inner join pe_monitor_point p on e.pe_id=p.pe_id and p.outfall_type='2' and p.output_id=" + outputId+" "+
				"where d.MEASURE_TIME>=TO_DATE( '" + startTime+"', 'yyyy-mm-dd hh24:mi:ss' ) and d.MEASURE_TIME<=TO_DATE( '" + endTime+"', 'yyyy-mm-dd hh24:mi:ss' ) group by d.OUTPUT_ID,d.MEASURE_TIME) a " + 
				"left join pe_hour_flux_data h on a.output_id=h.output_id and a.measure_time=h.measure_time";
		
		List<Object[]> list = simpleDao.createNativeQuery(sqlString).getResultList();
		String seriesName = "";
		if (codeIndex==1) {
			seriesName = "NOx折算浓度";
		}
		if (codeIndex==2) {
			seriesName = "烟气流量";
		}
		if (codeIndex==3) {
			seriesName = "排放速率";
		}
		Map<String,Object[]> series = new HashMap<String,Object[]>();
		for (Object[] obj : list) {
			if(obj[0]!=null) {
				if (series.containsKey(seriesName)) {
					if (obj[codeIndex] != null) {
						series.get(seriesName)[indexmap.get(obj[0])]=obj[codeIndex];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[codeIndex] != null) {
						tempList[indexmap.get(obj[0])]=obj[codeIndex];
					}
					series.put(seriesName, tempList);
				}
			}
		}
		List<String> legendList = new ArrayList<String>();
		legendList.add(seriesName);
		JSONArray xArray = new JSONArray();
		result.put("xAxis", xAxis);
		for (Object key : series.keySet()) {
			JSONObject xObject = new JSONObject();
			xObject.put("data", series.get(key));
			xObject.put("type", "line");
			xObject.put("name", seriesName);
			xArray.add(xObject);
		}
		result.put("legend", legendList);
		result.put("series", xArray);
		
		return result;
	}
	
}
