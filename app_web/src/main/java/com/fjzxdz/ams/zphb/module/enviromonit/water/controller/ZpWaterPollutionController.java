package com.fjzxdz.ams.zphb.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import com.fjzxdz.ams.module.weather.BaiduWeather;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.water.service.ZpWtCityHourReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * create by: wudenglin
 * description: 污染源数据处理
 * create time: 2019/10/5 0005 8:58
 */
@Controller
@RequestMapping("/zphb/dataShow")
@Secured({"ROLE_USER"})
public class ZpWaterPollutionController extends BaseController {
    @Autowired
    private WtCityHourDataService wtCityHourDataService;
    @Autowired
    private ZpWtCityHourReportService reportService;
    @Autowired
    private WtCityPointService wtCityPointService;

    @Autowired
    private SimpleDao simpleDao;
//==========================水环境=================

    /**
     * create by: wudenglin
     * description: 水环境污染源统计
     * create time: 2019/10/5 0005 10:37
     *
     * @Param year:
     * @return: cn.fjzxdz.frame.pojo.R
     */
    @RequestMapping("/getGkSkShowData")
    @ResponseBody
    public R getGkSkShowData(String year) {
        Map map = new HashMap();
        // 漳州生态云水环境汇总栏
        JSONArray countMonitorSituation = reportService.countMonitorSituation();
        map.put("total", countMonitorSituation);
        return R.ok(map);
    }

    @RequestMapping("/waterBasinList")
    @ResponseBody
    public List<Map<String, Object>> waterBasinList(String year) {
        List<Map<String, Object>> datalist = new ArrayList<>();
        List<Map<String, Object>> resultList = new ArrayList<>();
        Map<String, Object> dataMap = null;
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("select monitor_name,LONGITUDE lng,LATITUDE lat from WT_BASIN_MONITOR where county like '%漳浦%'");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sqlBuilder.toString());//小河流域名称
        for (Map<String, Object> map : nativeQueryList) {
            dataMap = new HashMap<>();

            sqlBuilder = new StringBuilder();
            sqlBuilder.append("select * from (select MONTH_NUMBER monthNum,BASIN_NAME,PH_VALUE ph,")
                    .append("RJY_VALUE rjy, GMSY_VALUE gmsy,ANDAN_VALUE  andan,ZL_VALUE zl ,BOD_VALUE wrshxyl,RESULT_QUALITY result,TARGET_QUALITY targetResult ")
                    .append(", PH_LEVEL phlevel,RJY_LEVEL rjylevel,GMSY_LEVEL gmsylevel, ANDAN_LEVEL andanlevel, ZL_LEVEL zllevel,BOD_LEVEL wrshxyllevel")
                    .append(" from WT_BASIN_MONTH_DATA where YEAR_NUMBER =")
                    .append(year)
                    .append(" and BASIN_NAME = '")
                    .append(map.get("monitorName"))
                    .append("')")
                    .append(" a where  a.monthNum=(select max(MONTH_NUMBER) from  WT_BASIN_MONTH_DATA where YEAR_NUMBER=")
                    .append(year)
                    .append(" and BASIN_NAME ='")
                    .append(map.get("monitorName"))
                    .append("' group by  BASIN_NAME)");
            datalist = simpleDao.getNativeQueryList(sqlBuilder.toString());
            if(datalist.size()==0)
                continue;
            dataMap=  datalist.get(0);
            dataMap.put("lng",map.get("lng"));
            dataMap.put("lat",map.get("lat"));
            dataMap.put("phlevel",dataMap.get("phlevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("phlevel").toString()).getKey());
            dataMap.put("rjylevel",dataMap.get("rjylevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("rjylevel").toString()).getKey());
            dataMap.put("gmsylevel",dataMap.get("gmsylevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("gmsylevel").toString()).getKey());
            dataMap.put("andanlevel",dataMap.get("andanlevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("andanlevel").toString()).getKey());
            dataMap.put("wrshxyllevel",dataMap.get("wrshxyllevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("wrshxyllevel").toString()).getKey());
            dataMap.put("zllevel",dataMap.get("zllevel")==null?"-":WaterQualityEnum.valueOf(dataMap.get("zllevel").toString()).getKey());
            dataMap.put("result",dataMap.get("result")==null?"-":WaterQualityEnum.valueOf(dataMap.get("result").toString()).getKey());
            dataMap.put("targetresult",dataMap.get("targetresult")==null?"-":WaterQualityEnum.valueOf(dataMap.get("targetresult").toString()).getKey());
            resultList.add(dataMap);
        }
        return resultList;
    }


    //=======================================   空气    ================================================================
    @RequestMapping("/getAirCount")
    @ResponseBody
    public Map getAirCount() {
        List<Object[]> list = simpleDao.createNativeQuery(
                "select '废气排口' as name ,count(1) from (select e.PE_ID, e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.address " +
                        "from PE_ENTERPRISE_DATA e inner join PE_MONITOR_POINT p on e.PE_ID=p.PE_ID where p" +
                        ".OUTFALL_TYPE= 2 and e.QX like '%漳浦%' GROUP BY e.PE_NAME,e.PE_ID,e.LONG_VALUE,e.LAT_VALUE,e" +
                        ".address) union all\n" +
                        "select '污普废气排口' as name ,count(1) from (select distinct qymc,LONGITUDE,LATITUDE,ADDRESS from" +
                        " POLLUTION_AIR_DATA where QX like '%漳浦%')")
                .getResultList();

        Map<String, Object> map = new HashMap<String, Object>(5);
        for (Object[] objects : list) {
            map.put(objects[0].toString(), objects[1]);
        }
        return map;
    }

    @RequestMapping("/airList")
    @ResponseBody
    public JSONArray airList(String parent){
        List<Map> list = simpleDao.getNativeQueryList(
                "select distinct mp.POINT_NAME name,\n" +
                        "                mp.POINT_CODE code,\n" +
                        "                hd.aqi,\n" +
                        "                to_char(hd.MONITOR_TIME, 'yyyy-mm-dd hh24') time,\n" +
                        "                mp.LONGITUDE lng,\n" +
                        "                mp.LATITUDE lat,\n" +
                        "                mp.POINT_TYPE type,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A34004', hd.AVERVALUE, 0))  PM25,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A34002', hd.AVERVALUE, 0))  PM10,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A21005', hd.AVERVALUE, 0))  CO,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A21004', hd.AVERVALUE, 0))  NO2,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A050248', hd.AVERVALUE, 0)) O3,\n" +
                        "                sum(DECODE(hd.CODE_POLLUTE, 'A21026', hd.AVERVALUE, 0))  SO2\n" +
                        "from AIR_MONITOR_POINT mp\n" +
                        "         left join AIR_HOUR_DATA hd on mp.POINT_CODE = hd.POINT_CODE and (hd.point_code, " +
                        "hd.MONITOR_TIME) in (select p.point_code, MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p\n" +
                        " inner join AIR_HOUR_DATA d on p.POINT_CODE = d.POINT_CODE and p.PARENT = '"+parent+"'\n" +
                        "        where d.MONITOR_TIME >= sysdate - 7\n" +
                        "          AND d.MONITOR_TIME <= SYSDATE\n" +
                        "        GROUP BY p.point_code)\n" +
                        "where (hd.point_code, hd.MONITOR_TIME) in (select p.point_code, MAX(d.MONITOR_TIME)\n" +
                        " from AIR_MONITOR_POINT p inner join AIR_HOUR_DATA d on p.POINT_CODE = d.POINT_CODE and p" +
                        ".PARENT = '"+parent+"'\n" +
                        "              where d.MONITOR_TIME >= sysdate - 7\n" +
                        "                AND d.MONITOR_TIME <= SYSDATE\n" +
                        "              GROUP BY p.point_code)\n" +
                        "GROUP BY mp.POINT_NAME, mp.POINT_CODE, hd.aqi,\n" +
                        "         to_char(hd.MONITOR_TIME, 'yyyy-mm-dd hh24'),\n" +
                        "         mp.LONGITUDE, mp.LATITUDE, mp.POINT_TYPE\n" +
                        "order by hd.aqi asc");
        JSONArray result = new JSONArray(list.size());
        for (Map map : list) {
            BigDecimal aqi = new BigDecimal(map.get("aqi").toString());
            List<Map> factors = new ArrayList<>(6);
            Map no2 = new HashMap(3);
            no2.put("name", "二氧化氮");
            no2.put("value", map.get("no2"));
            no2.put("color", getColor(new BigDecimal(map.get("no2").toString()), 4));
            factors.add(no2);
            Map co = new HashMap(3);
            co.put("name", "一氧化碳");
            co.put("value", map.get("co"));
            co.put("CO", getColor(new BigDecimal(map.get("co").toString()), 3));
            factors.add(co);
            Map so2 = new HashMap(3);
            so2.put("name", "二氧化硫");
            so2.put("value", map.get("so2"));
            so2.put("SO2", getColor(new BigDecimal(map.get("so2").toString()), 6));
            factors.add(so2);
            Map pm10 = new HashMap(3);
            pm10.put("name", "PM10");
            pm10.put("value", map.get("pm10"));
            pm10.put("PM10", getColor(new BigDecimal(map.get("pm10").toString()), 2));
            factors.add(pm10);
            Map pm25 = new HashMap(3);
            pm25.put("name", "PM2.5");
            pm25.put("value", map.get("pm25"));
            pm25.put("PM25", getColor(new BigDecimal(map.get("pm25").toString()), 1));
            factors.add(pm25);
            Map o3 = new HashMap(3);
            o3.put("name", "臭氧");
            o3.put("value", map.get("o3"));
            o3.put("O3", getColor(new BigDecimal(map.get("o3").toString()), 5));
            factors.add(o3);
            map.put("factor", factors);
            result.add(map);
        }
        return result;
    }

    /***
     *
     * @Title:  getWeather
     * @Description:    获取天气预报信息
     * @CreateBy: chenbingke
     * @CreateTime: 2019年5月30日 下午2:52:29
     * @UpdateBy: chenbingke
     * @UpdateTime:  2019年5月30日 下午2:52:29
     * @return  String
     * @throws
     */
    @RequestMapping("/getWeather")
    @ResponseBody
    public String getWeather() {
        BaiduWeather baidu = new BaiduWeather();
        return baidu.getWeatherInform();
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
