/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.module.risk.dao.RiskBaseInfoDao;
import com.fjzxdz.ams.module.risk.service.RiskBaseInfoService;
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
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/risk/riskBaseStatistics")
@Secured({ "ROLE_USER" })
public class RiskStatisticsController extends BaseController {
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RiskBaseInfoDao riskBaseInfoDao;
	@Autowired
	private RiskBaseInfoService riskBaseInfoService;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "risk/riskStatistics";
	}

	@RequestMapping("/getRiskStatistics")
	@ResponseBody
	public JSONArray getRiskStatistics() {
		JSONArray jsonArray = new JSONArray();
		Map<String, String> fkRegionMap = getFkRegionMap();
		String sql = "SELECT" +
						" CASE" +
							" WHEN c.FK_REGION = '350690000'" +
								" OR c.FK_REGION = '350681001'" +
								" OR c.FK_REGION = '350681000' THEN" +
								" '350690000'" +
						" ELSE" +
							" c.FK_REGION" +
						" END FK_REGION," +
					" COUNT (*), " +
				" (SELECT COUNT (a.id) from RISK_BASE_UNIT_INFO a  " +
				"  LEFT JOIN RISK_BASE_INFO b on a.GUID = b.GUID  " +
				"  where b.FK_REGION =  " +
				"     (CASE " +
				"      WHEN c.FK_REGION = '350690000' " +
				"      OR c.FK_REGION = '350681001' " +
				"      OR c.FK_REGION = '350681000' THEN " +
				"       '350690000' " +
				"      ELSE " +
				"       c.FK_REGION " +
				"      END))" +
					" FROM" +
					" RISK_BASE_INFO c" +
					" GROUP BY" +
					" CASE" +
						" WHEN c.FK_REGION = '350690000'" +
						" OR c.FK_REGION = '350681001'" +
						" OR c.FK_REGION = '350681000' THEN" +
						" '350690000'" +
					" ELSE" +
						" c.FK_REGION" +
					" END" +
				" HAVING" +
				" COUNT (*) >= 1" +
				"ORDER BY" +
				" CASE" +
					" WHEN c.FK_REGION = '350690000'" +
					" OR c.FK_REGION = '350681001'" +
					" OR c.FK_REGION = '350681000' THEN" +
					" '350690000'" +
				" ELSE" +
					" c.FK_REGION" +
				" END";
		Query queqry = simpleDao.createNativeQuery(sql);
		List<Object[]> resultList = queqry.getResultList();
		for(int i=0; i<resultList.size();i++){
			JSONObject jsonObject = new JSONObject();
			String fkRegion = String.valueOf(resultList.get(i)[0]);
			String fkRegionCount = String.valueOf(resultList.get(i)[1]);
			String riskUnitCount = String.valueOf(resultList.get(i)[2]);
			jsonObject.put("fkRegion",fkRegion);
			jsonObject.put("fkRegionCount",fkRegionCount);
			jsonObject.put("riskUnitCount",riskUnitCount);
			for(String key : fkRegionMap.keySet()){
				if(fkRegion.contains(key)){
					jsonObject.put("fkRegionName",fkRegionMap.get(key));
				}
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}


	public static Map<String, String> getFkRegionMap() {
		Map<String, String> fkRegionMap = new HashMap<String, String>();
		fkRegionMap.put("350600","漳州市");
		fkRegionMap.put("350601","市辖区");
		fkRegionMap.put("350602","芗城区");
		fkRegionMap.put("350603","龙文区");
		fkRegionMap.put("350622","云霄县");
		fkRegionMap.put("350623","漳浦县");
		fkRegionMap.put("350624","诏安县");
		fkRegionMap.put("350625","长泰县");
		fkRegionMap.put("350626","东山县");
		fkRegionMap.put("350627","南靖县");
		fkRegionMap.put("350628","平和县");
		fkRegionMap.put("350629","华安县");
		fkRegionMap.put("350690","龙海市");
		fkRegionMap.put("350699","常山华侨经济开发区");
		fkRegionMap.put("350698","漳州经济开发区");
		fkRegionMap.put("350694","古雷经济开发区");
		return fkRegionMap;
	}
}
