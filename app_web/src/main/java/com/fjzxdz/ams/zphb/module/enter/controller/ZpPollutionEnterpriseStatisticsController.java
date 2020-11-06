/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enter.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.Query;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 风险源统计Controller
 * @author gsq
 * @version 2019-09-30
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/enter/pollutionEnterpriseStatistics")
@Secured({ "ROLE_USER" })
public class ZpPollutionEnterpriseStatisticsController extends BaseController {
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/zphb/moudles/enter/pollutionEnterpriseStatistics";
	}

	@RequestMapping("/getPollutionEnterpriseStatisticsByCodeRegion")
	@ResponseBody
	public JSONArray getPollutionEnterpriseStatisticsByCodeRegion() {
		JSONArray jsonArray = new JSONArray();
		Map<String, String> codeRegionMap = getCodeRegionMap();
		String sql = "SELECT" +
						" CASE" +
							" WHEN CODE_REGION = '350690000000'" +
								" OR CODE_REGION = '350681000000' THEN" +
								" '350690000000'" +
							" WHEN CODE_REGION = '35062700'" +
							" OR CODE_REGION = '350627000000' THEN" +
							" '350627000000'" +
						" ELSE" +
							" CODE_REGION" +
						" END CODE_REGION," +
					" COUNT (*),COUNT(CORPCODE)" +
					" FROM POLLUTION_ENTERPRISE_INFO" +
					" WHERE CODE_REGION = '350623000000' " +
					" GROUP BY" +
					" CASE" +
						" WHEN CODE_REGION = '350690000000'" +
						" OR CODE_REGION = '350681000000' THEN" +
						" '350690000000'" +
						" WHEN CODE_REGION = '35062700'" +
						" OR CODE_REGION = '350627000000' THEN" +
						" '350627000000'" +
					" ELSE" +
						" CODE_REGION" +
					" END" +
				" HAVING COUNT (*) >= 1" +
				"ORDER BY" +
				" CASE" +
					" WHEN CODE_REGION = '350690000000'" +
					" OR CODE_REGION = '350681000000' THEN" +
					" '350690000000'" +
					" WHEN CODE_REGION = '35062700'" +
					" OR CODE_REGION = '350627000000' THEN" +
					" '350627000000'" +
				" ELSE" +
					" CODE_REGION" +
				" END";
		Query queqry = simpleDao.createNativeQuery(sql);
		List<Object[]> resultList = queqry.getResultList();

		for(int i=0; i<resultList.size();i++){
			JSONObject jsonObject = new JSONObject();
			String codeRegion = String.valueOf(resultList.get(i)[0]);
			String codeRegionCount = String.valueOf(resultList.get(i)[1]);
			String corpCodeCount = String.valueOf(resultList.get(i)[2]);
			jsonObject.put("codeRegion",codeRegion);
			jsonObject.put("codeRegionCount",codeRegionCount);
			jsonObject.put("corpCodeCount",corpCodeCount);
			for(String key : codeRegionMap.keySet()){
				if(codeRegion.contains(key)){
					jsonObject.put("codeRegionName",codeRegionMap.get(key));
				}
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	@RequestMapping("/getPollutionEnterpriseAllStatisticsListByCodeRegion")
	@ResponseBody
	public JSONArray getPollutionEnterpriseAllStatisticsListByCodeRegion() {
		JSONArray jsonArray = new JSONArray();
		Map<String, String> codeRegionMap = getCodeRegionMap();
		String sql = "SELECT" +
				" CASE WHEN CODE_REGION = '350690000000' OR CODE_REGION = '350681000000' THEN '350690000000' " +
				" WHEN CODE_REGION = '35062700' OR CODE_REGION = '350627000000' THEN '350627000000'" +
				" ELSE CODE_REGION END CODE_REGION," +
				" COUNT (*), COUNT(CORPCODE), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '第三产业' THEN '第三产业' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '小型企业' THEN '小型企业' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '畜禽养殖业' THEN '畜禽养殖业' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '污水处理厂' THEN '污水处理厂' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '一般工业企业' THEN '一般工业企业' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '建筑施工' THEN '建筑施工' END), " +
				" COUNT (CASE WHEN CODE_ENTERTYPE = '' OR CODE_ENTERTYPE IS NULL THEN '其他' END)" +
				" FROM POLLUTION_ENTERPRISE_INFO " +
				" WHERE CODE_REGION='350623000000' " +
				" GROUP BY" +
				" CASE WHEN CODE_REGION = '350690000000' OR CODE_REGION = '350681000000' THEN '350690000000'" +
				" WHEN CODE_REGION = '35062700' OR CODE_REGION = '350627000000' THEN '350627000000'" +
				" ELSE CODE_REGION END " +
				" HAVING COUNT (*) >= 1 " +
				" ORDER BY CASE" +
				" WHEN CODE_REGION = '350690000000' OR CODE_REGION = '350681000000' THEN '350690000000' " +
				" WHEN CODE_REGION = '35062700' OR CODE_REGION = '350627000000' THEN '350627000000' " +
				" ELSE CODE_REGION END";
		Query queqry = simpleDao.createNativeQuery(sql);
		List<Object[]> resultList = queqry.getResultList();
		for(int i=0; i<resultList.size();i++){
			JSONObject jsonObject = new JSONObject();
			String codeRegion = String.valueOf(resultList.get(i)[0]);
			String codeRegionCount = String.valueOf(resultList.get(i)[1]);
			String corpCodeCount = String.valueOf(resultList.get(i)[2]);
			String tertiaryIndustryCount = String.valueOf(resultList.get(i)[3]);
			String smallEnterpriseCount = String.valueOf(resultList.get(i)[4]);
			String livestockBreedingCount = String.valueOf(resultList.get(i)[5]);
			String sewagePlantCount = String.valueOf(resultList.get(i)[6]);
			String generalIndustryCount = String.valueOf(resultList.get(i)[7]);
			String buildingOperationsCount = String.valueOf(resultList.get(i)[8]);
			String otherCount = String.valueOf(resultList.get(i)[9]);
			jsonObject.put("codeRegion",codeRegion);
			jsonObject.put("codeRegionCount",codeRegionCount);
			jsonObject.put("corpCodeCount",corpCodeCount);
			jsonObject.put("tertiaryIndustryCount",tertiaryIndustryCount);
			jsonObject.put("smallEnterpriseCount",smallEnterpriseCount);
			jsonObject.put("livestockBreedingCount",livestockBreedingCount);
			jsonObject.put("sewagePlantCount",sewagePlantCount);
			jsonObject.put("generalIndustryCount",generalIndustryCount);
			jsonObject.put("buildingOperationsCount",buildingOperationsCount);
			jsonObject.put("otherCount",otherCount);
			for(String key : codeRegionMap.keySet()){
				if(codeRegion.contains(key)){
					jsonObject.put("codeRegionName",codeRegionMap.get(key));
				}
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	@RequestMapping("/getPollutionEnterpriseStatisticsByCodeEntertype")
	@ResponseBody
	public JSONArray getPollutionEnterpriseStatisticsByCodeEntertype() {
		JSONArray jsonArray = new JSONArray();
		String sql = "SELECT " +
						"CASE WHEN CODE_ENTERTYPE='' OR CODE_ENTERTYPE IS null THEN '其他' " +
						"ELSE " +
						"CODE_ENTERTYPE " +
						"END AS CODE_ENTERTYPE," +
						"COUNT (*) " +
					"FROM POLLUTION_ENTERPRISE_INFO " +
					//CODE_REGION='350623000000' 过滤出漳浦数据
					"WHERE CODE_REGION='350623000000' " +
					"GROUP BY CODE_ENTERTYPE " +
					"HAVING COUNT (*) >= 1";
		Query queqry = simpleDao.createNativeQuery(sql);
		List<Object[]> resultList = queqry.getResultList();
		for(int i=0; i<resultList.size();i++){
			JSONObject jsonObject = new JSONObject();
			String codeEntertypeName = String.valueOf(resultList.get(i)[0]);
			String codeEntertypeCount = String.valueOf(resultList.get(i)[1]);
			jsonObject.put("codeEntertypeName",codeEntertypeName);
			jsonObject.put("codeEntertypeCount",codeEntertypeCount);
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	public static Map<String, String> getCodeRegionMap() {
		Map<String, String> codeRegionMap = new HashMap<String, String>();
		codeRegionMap.put("350600","漳州市");
		codeRegionMap.put("350601","市辖区");
		codeRegionMap.put("350602","芗城区");
		codeRegionMap.put("350603","龙文区");
		codeRegionMap.put("350622","云霄县");
		codeRegionMap.put("350623","漳浦县");
		codeRegionMap.put("350624","诏安县");
		codeRegionMap.put("350625","长泰县");
		codeRegionMap.put("350626","东山县");
		codeRegionMap.put("350627","南靖县");
		codeRegionMap.put("350628","平和县");
		codeRegionMap.put("350629","华安县");
		codeRegionMap.put("350690","龙海市");
		codeRegionMap.put("350699","常山华侨经济开发区");
		codeRegionMap.put("350698","漳州经济开发区");
		codeRegionMap.put("350694","古雷经济开发区");
		return codeRegionMap;
	}

}
