package com.fjzxdz.ams.zphb.module.hbdc.service.impl;


import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.util.CountUtil;
import com.fjzxdz.ams.util.MapUtil;
import com.fjzxdz.ams.util.PercentileUtil;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpMonthsDebriefService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor=Exception.class)
public class ZpMonthsDebriefServiceImpl implements ZpMonthsDebriefService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpMonthsDebriefServiceImpl.class);
	
	@Autowired
	private SimpleDao simpleDao;
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getSixFactoryQualityRate(String start,String end, String start2, String end2) {
		List<Object[]> list = simpleDao.createNativeQuery("select to_char(MONITOR_TIME,'yyyy'),ROUND(avg(SO2),0),"
				+ "ROUND(avg(NO2),0),ROUND(avg(PM10),0),ROUND(avg(PM25),0) from (select a.MONITOR_TIME,"
				+ "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, "
				+ "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 "
				+ "from AIR_DAY_DATA a LEFT JOIN AIR_MONITOR_POINT b on a.POINT_CODE=b.POINT_CODE where ((MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') "
				+ "and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd')) or (MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd'))) "
				+ "and b.POINT_TYPE=1 and a.POINT_NAME='漳州市' group BY a.MONITOR_TIME) group by to_char(MONITOR_TIME,'yyyy')"
				+ "ORDER BY to_char(MONITOR_TIME,'yyyy')", start, end, start2, end2).getResultList();
		if(ToolUtil.isNotEmpty(list)) {
			Map<String, Object> map = new HashMap<>();
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);

			Map<String, Map<String, Object>> map_f = new HashMap<>();
			Map<String, Map<String, Object>> map_s = new HashMap<>();
			Map<String, Object> color = new HashMap<>(6);
			
			Map<String, Object> index = new HashMap<>();
			index.put("name", "二级标准限值");
			index.put("SO2", 60);
			index.put("NO2", 40);
			index.put("PM10", 70);
			index.put("PM25", 35);
			index.put("O3", 160);
			index.put("CO", 4);
			map_f.put("二级标准限值", index);
			map_s.put("二级标准限值", index);
			
			for(Object[] obj : list) {
				String startTime="";
				String endTime="";
				if(obj[0].equals(fyear)) {
					startTime = start;
					endTime = end;
				}else {
					startTime = start2;
					endTime = end2;
				}
				Map<String, Object> temp = new HashMap<>();
				temp.put("SO2", obj[1]);
				temp.put("NO2", obj[2]);
				temp.put("PM10", obj[3]);
				temp.put("PM25", obj[4]);
				
				Map<String, Object> temp2 = new HashMap<>();
				temp2.put("SO2", CountUtil.getDivide(obj[1], index.get("SO2"), "#0.000"));
				temp2.put("NO2", CountUtil.getDivide(obj[2], index.get("NO2"), "#0.000"));
				temp2.put("PM10", CountUtil.getDivide(obj[3], index.get("PM10"), "#0.000"));
				temp2.put("PM25", CountUtil.getDivide(obj[4], index.get("PM25"), "#0.000"));
				List<Object[]> oth_list = simpleDao.createNativeQuery("select MONITOR_TIME,sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO,"
						+ "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3 from AIR_DAY_DATA where MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') "
						+ "and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd') and POINT_CODE='350600' group BY MONITOR_TIME ORDER BY MONITOR_TIME", startTime,endTime).getResultList();
				double[] co_data = new double[oth_list.size()];
				double[] o3_data = new double[oth_list.size()];
				for(int i=0;i<oth_list.size();i++) {
					co_data[i]=Double.parseDouble(oth_list.get(i)[1].toString());
					o3_data[i]=Double.parseDouble(oth_list.get(i)[2].toString());
				}
				
				String o3_c = CountUtil.getDoubleFormat(PercentileUtil.getPercentile(o3_data, 0.9), "#0");
				String co_c = CountUtil.getDoubleFormat(PercentileUtil.getPercentile(co_data, 0.95),"#0.0");
				
				temp.put("O3", o3_c);
				temp.put("CO", co_c);
				temp2.put("O3", CountUtil.getDivide(o3_c, index.get("O3"), "#0.000"));
				temp2.put("CO", CountUtil.getDivide(co_c, index.get("CO"), "#0.000"));
				temp2.put("name", "单项质量指数");
				if(obj[0].equals(fyear)) {
					temp.put("name", fyear+"年浓度");
					map_f.put(fyear, temp);
					map_f.put("AQI", temp2);
					color.put("NO2", getColor(new BigDecimal(temp.get("NO2").toString()), 4));
					color.put("CO", getColor(new BigDecimal(temp.get("CO").toString()), 3));
					color.put("SO2", getColor(new BigDecimal(temp.get("SO2").toString()), 6));
					color.put("PM10", getColor(new BigDecimal(temp.get("PM10").toString()), 2));
					color.put("PM25", getColor(new BigDecimal(temp.get("PM25").toString()), 1));
					color.put("O3", getColor(new BigDecimal(temp.get("O3").toString()), 5));
					map_f.put("color", color);
				}else {
					temp.put("name", syear+"年浓度");
					map_s.put(syear, temp);
					map_s.put("AQI", temp2);
				}
			}
			Map<String, Object> aqi_map_f = map_f.get("AQI");
			aqi_map_f.put("total", CountUtil.getDoubleFormat(CountUtil.getTotal(aqi_map_f.get("O3"), aqi_map_f.get("SO2"), aqi_map_f.get("CO"),
					aqi_map_f.get("PM25"), aqi_map_f.get("PM10"), aqi_map_f.get("NO2")),"#0.000"));
			
			Map<String, Object> aqi_map_s = map_s.get("AQI");
			aqi_map_s.put("total", CountUtil.getDoubleFormat(CountUtil.getTotal(aqi_map_s.get("O3"), aqi_map_s.get("SO2"), aqi_map_s.get("CO"),
					aqi_map_s.get("PM25"), aqi_map_s.get("PM10"), aqi_map_s.get("NO2")),"#0.000"));
			
			map.put(start, map_f);
			map.put(start2, map_s);
			
			return map;
		}
		return new HashMap<>();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getCompareCounty(String start,String end,String start2,String end2) {
		List<Object[]> list1 = simpleDao.createNativeQuery("select to_char(MONITOR_TIME,'yyyy'), POINT_NAME,ROUND(avg(SO2),0),"
				+ "ROUND(avg(NO2),0),ROUND(avg(PM10),0),ROUND(avg(PM25),0) from (select a.MONITOR_TIME,a.POINT_NAME,"
				+ "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, "
				+ "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 "
				+ "from AIR_DAY_DATA a LEFT JOIN AIR_MONITOR_POINT b on a.POINT_CODE=b.POINT_CODE where ((MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') "
				+ "and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd')) or (MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd'))) "
				+ "and b.POINT_TYPE=1 and a.POINT_NAME not in('漳州市') group BY a.MONITOR_TIME,a.POINT_NAME) group by to_char(MONITOR_TIME,'yyyy'),"
				+ "POINT_NAME ORDER BY to_char(MONITOR_TIME,'yyyy')", start, end, start2, end2).getResultList();
		List<Object[]> list2 = simpleDao.createNativeQuery("select to_char(MONITOR_TIME,'yyyy'), POINT_NAME,ROUND(avg(SO2),0),ROUND(avg(NO2),0),"
				+ "ROUND(avg(PM10),0),ROUND(avg(PM25),0) from (select a.MONITOR_TIME,a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, "
				+ "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
				+ "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 from AIR_HOUR_DATA a LEFT JOIN AIR_MONITOR_POINT b on a.POINT_CODE=b.POINT_CODE "
				+ "where ((MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd')) or (MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') "
				+ "and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd'))) and b.POINT_TYPE=0 and a.POINT_CODE in('600602','600603') group BY a.MONITOR_TIME,a.POINT_NAME) "
				+ "group by to_char(MONITOR_TIME,'yyyy'),POINT_NAME ORDER BY to_char(MONITOR_TIME,'yyyy')", start, end, start2, end2).getResultList();
		List<Object[]> list = new ArrayList<>();
		list.addAll(list1);
		list.addAll(list2);
		if(ToolUtil.isNotEmpty(list)) {
			Map<String, Object> map = new HashMap<>();
			
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);
			Map<String, Object> map_f = new HashMap<>();
			Map<String, Object> map_s = new HashMap<>();
			for(Object[] obj : list) {
				String startTime="";
				String endTime="";
				String table="";
				String name="";
				if(obj[0].equals(fyear)) {
					startTime = start;
					endTime = end;
				}else {
					startTime = start2;
					endTime = end2;
				}
				if(obj[1].equals("蓝田镇")||obj[1].equals("漳州三中")) {
					table = "AIR_HOUR_DATA";
					if(obj[1].equals("蓝田镇")) {
						name = "龙文区";
					}else {
						name = "芗城区";
					}
				}else {
					table = "AIR_DAY_DATA";
					name = obj[1].toString();
				}
				Map<String, Object> temp = new HashMap<>();
				temp.put("name", name);
				temp.put("SO2C", obj[2]);
				temp.put("NO2C", obj[3]);
				temp.put("PM10C", obj[4]);
				temp.put("PM25C", obj[5]);
				temp.put("SO2IAQI", CountUtil.getDivide(obj[2], 40, "#0.000"));
				temp.put("NO2IAQI", CountUtil.getDivide(obj[3], 40, "#0.000"));
				temp.put("PM10IAQI", CountUtil.getDivide(obj[4], 50, "#0.000"));
				temp.put("PM25IAQI", CountUtil.getDivide(obj[5], 35, "#0.000"));
				String sql = "select MONITOR_TIME,sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO,"
						+ "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3 from "+table+" where MONITOR_TIME>=TO_DATE(?, 'yyyy-mm-dd') "
						+ "and MONITOR_TIME<=TO_DATE(?, 'yyyy-mm-dd') and POINT_NAME=? group BY MONITOR_TIME ORDER BY MONITOR_TIME";
				
				List<Object[]> other = simpleDao.createNativeQuery(sql, startTime, endTime, obj[1]).getResultList();
				double[] co_data = new double[other.size()];
				double[] o3_data = new double[other.size()];
				for(int i=0;i<other.size();i++) {
					co_data[i]=Double.parseDouble(other.get(i)[1].toString());
					o3_data[i]=Double.parseDouble(other.get(i)[2].toString());
				}
				String o3_c = CountUtil.getDoubleFormat(PercentileUtil.getPercentile(o3_data, 0.9), "#0");
				String co_c = CountUtil.getDoubleFormat(PercentileUtil.getPercentile(co_data, 0.95),"#0.0");
				temp.put("O3C", o3_c);
				temp.put("COC", co_c);
				temp.put("O3IAQI", CountUtil.getDivide(o3_c, 100, "#0.000"));
				temp.put("COIAQI", CountUtil.getDivide(co_c, 2, "#0.000"));
				
				temp.put("totalIAQI", CountUtil.getDoubleFormat(CountUtil.getTotal(temp.get("SO2IAQI"), temp.get("NO2IAQI"), 
						temp.get("PM10IAQI"), temp.get("PM25IAQI"), temp.get("O3IAQI"), temp.get("COIAQI")),"#0.00"));
				if(obj[0].equals(fyear)) {
					map_f.put((String) obj[1], temp);
				}else {
					map_s.put((String) obj[1], temp);
				}
			}
			
			//计算高年份的同比
			for (Map.Entry<String, Object> entry : map_f.entrySet()) {
				Map<String, Object> temp = (Map<String, Object>) entry.getValue();
				Map<String, Object> temp2 = (Map<String, Object>) map_s.get(entry.getKey());
				temp.put("COTB", CountUtil.getTB(temp.get("COC"), temp2.get("COC"), "#0.0"));
				temp.put("O3TB", CountUtil.getTB(temp.get("O3C"), temp2.get("O3C"), "#0.0"));
				temp.put("SO2TB", CountUtil.getTB(temp.get("SO2C"), temp2.get("SO2C"), "#0.0"));
				temp.put("NO2TB", CountUtil.getTB(temp.get("NO2C"), temp2.get("NO2C"), "#0.0"));
				temp.put("PM10TB", CountUtil.getTB(temp.get("PM10C"), temp2.get("PM10C"), "#0.0"));
				temp.put("PM25TB", CountUtil.getTB(temp.get("PM25C"), temp2.get("PM25C"), "#0.0"));
				temp.put("totalTB", CountUtil.getTB(temp.get("totalIAQI"), temp2.get("totalIAQI"), "#0.0"));
			}
			
			map_f = sortMap(map_f);

			Map<String, Object> avg_f = CountVag(map_f);
			Map<String, Object> avg_s = CountVag(map_s);
			avg_f.put("COTB", CountUtil.getTB(avg_f.get("COC"), avg_s.get("COC"), "#0.0"));
			avg_f.put("O3TB", CountUtil.getTB(avg_f.get("O3C"), avg_s.get("O3C"), "#0.0"));
			avg_f.put("SO2TB", CountUtil.getTB(avg_f.get("SO2C"), avg_s.get("SO2C"), "#0.0"));
			avg_f.put("NO2TB", CountUtil.getTB(avg_f.get("NO2C"), avg_s.get("NO2C"), "#0.0"));
			avg_f.put("PM10TB", CountUtil.getTB(avg_f.get("PM10C"), avg_s.get("PM10C"), "#0.0"));
			avg_f.put("PM25TB", CountUtil.getTB(avg_f.get("PM25C"), avg_s.get("PM25C"), "#0.0"));
			avg_f.put("totalTB", CountUtil.getTB(avg_f.get("totalIAQI"), avg_s.get("totalIAQI"), "#0.0"));
			avg_f.put("name", "均值");
			
			map_f.put("均值", avg_f);
			
			map.put(fyear, map_f);
			map.put(syear, map_s);
			return map_f;
		}
		return new HashMap<>();
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> CountVag(Map<String, Object> map){
		int i=1;
		double total_sum = 0;
		double so2_sum = 0;
		double no2_sum = 0;
		double pm10_sum = 0;
		double pm25_sum = 0;
		double co_sum = 0;
		double o3_sum = 0;
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			Map<String, Object> temp = (Map<String, Object>) entry.getValue();
			double total_temp = Double.valueOf(temp.get("totalIAQI").toString());
			total_sum += total_temp;
			double so2_temp =  Double.valueOf(temp.get("SO2C").toString());
			so2_sum += so2_temp;
			double no2_temp = Double.valueOf(temp.get("NO2C").toString());
			no2_sum += no2_temp;
			double pm10_temp = Double.valueOf(temp.get("PM10C").toString());
			pm10_sum += pm10_temp;
			double pm25_temp = Double.valueOf(temp.get("PM25C").toString());
			pm25_sum += pm25_temp;
			double co_temp = Double.valueOf(temp.get("COC").toString());
			co_sum += co_temp;
			double o3_temp = Double.valueOf(temp.get("O3C").toString());
			o3_sum += o3_temp;
			i++;
		}
		Map<String, Object> result = new HashMap<>();
		result.put("totalIAQI",CountUtil.getDivide(total_sum, i, "#0.0"));
		result.put("SO2C", CountUtil.getDivide(so2_sum, i, "#0.0"));
		result.put("NO2C", CountUtil.getDivide(no2_sum, i, "#0.0"));
		result.put("PM10C", CountUtil.getDivide(pm10_sum, i, "#0.0"));
		result.put("PM25C", CountUtil.getDivide(pm25_sum, i, "#0.0"));
		result.put("COC", CountUtil.getDivide(co_sum, i, "#0.0"));
		result.put("O3C", CountUtil.getDivide(o3_sum, i, "#0.0"));
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> sortMap(Map<String, Object> map){
		//计算高年份指数统计
		Map<String, Double> aqi_map = new HashMap<>();
		Map<String, Double> so2_map = new HashMap<>();
		Map<String, Double> no2_map = new HashMap<>();
		Map<String, Double> pm10_map = new HashMap<>();
		Map<String, Double> pm25_map = new HashMap<>();
		Map<String, Double> co_map = new HashMap<>();
		Map<String, Double> o3_map = new HashMap<>();
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			Map<String, Object> temp = (Map<String, Object>) entry.getValue();
			aqi_map.put(entry.getKey(), Double.valueOf((String)temp.get("totalIAQI")));
			so2_map.put(entry.getKey(), Double.valueOf((String) temp.get("SO2IAQI")));
			no2_map.put(entry.getKey(), Double.valueOf((String)temp.get("NO2IAQI")));
			pm10_map.put(entry.getKey(), Double.valueOf((String)temp.get("PM10IAQI")));
			pm25_map.put(entry.getKey(), Double.valueOf((String)temp.get("PM25IAQI")));
			co_map.put(entry.getKey(), Double.valueOf((String)temp.get("COIAQI")));
			o3_map.put(entry.getKey(), Double.valueOf((String)temp.get("O3IAQI")));
		}

		aqi_map = MapUtil.sortByValueAscending(aqi_map);
		so2_map = MapUtil.sortByValueAscending(so2_map);
		no2_map = MapUtil.sortByValueAscending(no2_map);
		pm10_map = MapUtil.sortByValueAscending(pm10_map);
		pm25_map = MapUtil.sortByValueAscending(pm25_map);
		co_map = MapUtil.sortByValueAscending(co_map);
		o3_map = MapUtil.sortByValueAscending(o3_map);

		map = insertIndex(map,aqi_map,"totalINDEX");
		map = insertIndex(map,so2_map,"SO2INDEX");
		map = insertIndex(map,no2_map,"NO2INDEX");
		map = insertIndex(map,pm10_map,"PM10INDEX");
		map = insertIndex(map,pm25_map,"PM25INDEX");
		map = insertIndex(map,co_map,"COINDEX");
		map = insertIndex(map,o3_map,"O3INDEX");
		return map;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> insertIndex(Map<String, Object> parent, Map<String, Double> map,String key) {
		int i = 1;
		for(Map.Entry<String, Double> entry : map.entrySet()) {
			Map<String, Object> temp = (Map<String, Object>) parent.get(entry.getKey());
			if(i==0) {
				temp.put(key, "-");
			}else {
				temp.put(key, i);
			}
			i++;
		}
		return parent;
	}
	
	private String getColor(BigDecimal value, int r) {
		Double perIaqi = AqiUtil.countPerIaqi(value.doubleValue(), r);
		if(perIaqi <= 50) {
			return "green";
		} else if(perIaqi <= 100) {
			return "blue";
		} else if(perIaqi <= 150) {
			return "yellow";
		} else if(perIaqi <= 200) {
			return "orange";
		} else if(perIaqi <= 300) {
			return "red";
		} else {
			return "purple";
		}
	}
	
}
