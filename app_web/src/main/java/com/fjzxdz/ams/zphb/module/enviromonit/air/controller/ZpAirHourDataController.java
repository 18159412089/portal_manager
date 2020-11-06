package com.fjzxdz.ams.zphb.module.enviromonit.air.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirHourDataService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirMonitorPointService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 空气小时数据 controller
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:49:26
 */
@Controller
@RequestMapping("/zphb/enviromonit/airHourData")
@Secured({"ROLE_USER"})
public class ZpAirHourDataController extends BaseController {

    @Autowired
    private ZpAirHourDataService airHourDataService;

    @Autowired
    private ZpAirMonitorPointService airMonitorPointService;

    @Autowired
    private SimpleDao simpleDao;

    /**
     * @return String
     * @throws
     * @Title: indexList
     * @Description: 数据服务->空气环境质量->跳转到空气小时监测数据页面
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:28:40
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:28:40
     */
    @RequestMapping("/index")
    public String indexList() {
        return "/moudles/enviromonit/air/airHourDataList";
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: list
     * @Description: 查询空气小时数据
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:28:56
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:28:56
     */
    @RequestMapping("/list")
    @ResponseBody
    public PageEU<Map<String, Object>> list(AirHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> airDataPage = airHourDataService.listByPage(param, page,response);
        if (ToolUtil.isEmpty(airDataPage)) {
            return null;
        }
        return new PageEU<>(airDataPage);
    }


    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: listMonth
     * @Description: 查询月小时数据
     * @CreateBy: huangyl
     * @CreateTime: 2019年6月26日11:42:52
     * @UpdateBy: huangyl
     * @UpdateTime: 2019年6月26日11:42:56
     */
    @RequestMapping("/listMonth")
    @ResponseBody
    public PageEU<Map<String, Object>> listMonth(AirHourDataParam param, HttpServletRequest request,HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> airDataPage = airHourDataService.listMonthByPage(param, page,response);
        if (ToolUtil.isEmpty(airDataPage)) {
            return null;
        }
        return new PageEU<>(airDataPage);
    }


    /**
     * @param pointType
     * @param pointCode
     * @return String
     * @throws
     * @Title: rankingOrderByAQI
     * @Description: 获取最新的城市小时数据
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:33:08
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:33:08
     */
    @RequestMapping("/rankingOrderByAQI")
    @ResponseBody
    public String rankingOrderByAQI(String pointType,
                                    @RequestParam(value = "pointCode", required = false) String pointCode) {

        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        DecimalFormat df = new DecimalFormat("######0");
        List<Object[]> resultList = new ArrayList<Object[]>(); // 返回的结果
        List<AirMonitorPoint> list = new ArrayList<AirMonitorPoint>();// 正常返回的结果数量
        if (pointCode == null) {
            if (pointType != null && pointType.equals("1")) {
                resultList = airHourDataService.rankingOrderByAQI(pointType, pointCode);
                list = airMonitorPointService.getPointByType(pointType);
            } else if ("0".equals(pointType)) {
                resultList = airHourDataService.rankingOrderByAQI(pointType, pointCode);
                list = airMonitorPointService.getPointByType(pointType);
            }
        } else {
            resultList = airHourDataService.rankingOrderByAQI(pointType, pointCode);
            list = airMonitorPointService.getMonitorPointByCity(pointCode);
        }
        if (resultList.size() <= 0) {
        	int num = 1;
            for (AirMonitorPoint airMonitorPoint : list) {
                jsonObject.put("pointName", airMonitorPoint.getPointName());
                jsonObject.put("pointCode", airMonitorPoint.getPointCode());
                jsonObject.put("monitrorTime", "暂无数据");
                jsonObject.put("aqi", "暂无数据");
                jsonObject.put("pollute", "暂无数据");
                jsonObject.put("color", -1);
                jsonObject.put("longitude", airMonitorPoint.getLongitude());
                jsonObject.put("latitude", airMonitorPoint.getLatitude());
                jsonObject.put("num", num++);
                jsonArray.put(jsonObject);
            }
        } else {
        	int num = 1;
            for (Object[] objects : resultList) {
                jsonObject.put("pointName", objects[0]);
                jsonObject.put("pointCode", objects[1]);
                if (objects[2] != null) {
                    jsonObject.put("aqi", Integer.valueOf(df.format(objects[2])));
                    Integer aqInteger = Integer.valueOf(objects[2].toString());
                    if(aqInteger>100) {
                    	double no2 = new BigDecimal(objects[10].toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                    	int pm10 = new BigDecimal(objects[8].toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                    	int pm25 = new BigDecimal(objects[7].toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                    	double so2 = new BigDecimal(objects[12].toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                    	double co = new BigDecimal(objects[9].toString()).setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                    	int o3 = new BigDecimal(objects[11].toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();

                    	Aqi aqi = AqiUtil.CountAqi(pm25, pm10, co, no2, o3, so2);
                    	jsonObject.put("pollute", aqi.getName());
                    }else {
                    	jsonObject.put("pollute", "-");
                    }
                    jsonObject.put("color", aqInteger);
                } else {
                    jsonObject.put("aqi", "暂无数据");
                    jsonObject.put("pollute", "暂无数据");
                    jsonObject.put("color", -1);
                }

                if (objects[3] != null) {
                    jsonObject.put("monitrorTime", objects[3]);
                } else {
                    jsonObject.put("monitrorTime", "暂无数据");
                }
                if (objects[4] != null && objects[5] != null) {
                    jsonObject.put("longitude", Double.valueOf(String.valueOf(objects[4])));
                    jsonObject.put("latitude", Double.valueOf(String.valueOf(objects[5])));
                }
                jsonObject.put("pointType", Double.valueOf(String.valueOf(objects[6])));
                jsonObject.put("num", num++);
                jsonArray.put(jsonObject);
            }
            if (resultList.size() < list.size()) {
                for (AirMonitorPoint airMonitorPoint : list) {
                    int i = 0;
                    for (Object[] objects : resultList) {
                        if (!airMonitorPoint.getPointCode().equals(objects[1])) {
                            i++;
                        }
                        if (i == resultList.size()) {
                            jsonObject.put("pointName", airMonitorPoint.getPointName());
                            jsonObject.put("pointCode", airMonitorPoint.getPointCode());
                            jsonObject.put("aqi", "暂无数据");
                            jsonObject.put("pollute", "暂无数据");
                            jsonObject.put("monitrorTime", "暂无数据");
                            jsonObject.put("color", -1);
                            jsonObject.put("longitude", airMonitorPoint.getLongitude());
                            jsonObject.put("latitude", airMonitorPoint.getLatitude());
                            jsonArray.put(jsonObject);
                        }
                    }

                }
            }
        }

        return jsonArray.toString();

    }

    /**
     * @param pointCode 城市变化
     * @return String
     * @throws
     * @Title: getAirQuantity
     * @Description: 某个城市的最新小时数据
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:35:12
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:35:12
     */
    @RequestMapping("/getAirQuantity")
    @ResponseBody
    public String getAirQuantity(String pointCode) {
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        List<Object[]> list = airHourDataService.getAirQuantity(pointCode);
        if (list.size() <= 0) {
            jsonObject.put("color", -1);
            jsonObject.put("AQI", "-");
            jsonObject.put("city", "-");
            jsonObject.put("time", "-");

            jsonObject.put("PM2", "-");
            jsonObject.put("PM10", "-");
            jsonObject.put("CO", "-");
            jsonObject.put("No2", "-");
            jsonObject.put("O3", "-");
            jsonObject.put("So2", "-");
            jsonObject.put("pollute", "无");
        } else {
            Integer aqInteger = Integer.valueOf(String.valueOf(list.get(0)[2])).intValue();
            jsonObject.put("color", aqInteger);
            jsonObject.put("AQI", list.get(0)[2]);
            jsonObject.put("city", list.get(0)[1]);
            jsonObject.put("time", list.get(0)[0]);

            jsonObject.put("PM2", list.get(0)[3]);
            jsonObject.put("PM10", list.get(0)[4]);
            jsonObject.put("CO", list.get(0)[5]);
            jsonObject.put("No2", list.get(0)[6]);
            jsonObject.put("O3", list.get(0)[7]);
            jsonObject.put("So2", list.get(0)[8]);
            if (aqInteger > 50) {
                Aqi aq = AqiUtil.CountAqi(intValue(list.get(0)[3]), intValue(list.get(0)[4]), intValue(list.get(0)[5]),
                        intValue(list.get(0)[6]), intValue(list.get(0)[7]), intValue(list.get(0)[8]));
                jsonObject.put("pollute", aq.getName());
            } else {
                jsonObject.put("pollute", "无");
            }
        }

        jsonArray.put(jsonObject);
        return jsonArray.toString();
    }

    /**
     * @param pointType 城市类型
     * @param pointCode 城市编号
     * @return String
     * @throws
     * @Title: getCityAirHourData
     * @Description: 获取城市小时数据
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:37:56
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:37:56
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getCityAirHourData")
    @ResponseBody
    public String getCityAirHourData(String pointType, String pointCode) {

        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        DecimalFormat df = new DecimalFormat("######0");
        List<Object[]> resultList = airHourDataService.rankingOrderByAQI(pointType, pointCode);
        for (Object[] objects : resultList) {
            if (objects[2] == null) {
                if (String.valueOf(objects[0]).equals("漳州市")) {
                    jsonObject.put("name", "芗城区");
                    jsonObject.put("value", "-");
                    jsonObject.put("itemStyle", getColor(-1));
                    jsonArray.put(jsonObject);
                    jsonObject.put("name", "龙文区");
                    jsonObject.put("value", "-");
                    jsonObject.put("itemStyle", getColor(-1));
                    jsonArray.put(jsonObject);
                    continue;
                }
                jsonObject.put("name", String.valueOf(objects[0]));
                jsonObject.put("value", "-");
                jsonObject.put("itemStyle", getColor(-1));
            } else {
                Integer value = Integer.valueOf(df.format(objects[2]));
                if (String.valueOf(objects[0]).equals("漳州市")) {
                    List<Object[]> xc = simpleDao.createNativeQuery("select * from (select a.AQI,ROWNUM from AIR_HOUR_DATA a where POINT_CODE='600603' ORDER BY MONITOR_TIME desc) where rownum=1").getResultList();
                    int temp = Integer.parseInt(xc.get(0)[0].toString());
                    jsonObject.put("name", "芗城区");
                    jsonObject.put("value", temp);
                    jsonObject.put("itemStyle", getColor(temp));
                    jsonArray.put(jsonObject);
                    List<Object[]> lw = simpleDao.createNativeQuery("select * from (select a.AQI,ROWNUM from AIR_HOUR_DATA a where POINT_CODE='600602' ORDER BY MONITOR_TIME desc) where rownum=1").getResultList();
                    int temp2 = Integer.parseInt(lw.get(0)[0].toString());
                    jsonObject.put("name", "龙文区");
                    jsonObject.put("value", temp2);
                    jsonObject.put("itemStyle", getColor(temp2));
                    jsonArray.put(jsonObject);
                    continue;
                }
                jsonObject.put("name", String.valueOf(objects[0]));
                jsonObject.put("value", value);
                jsonObject.put("itemStyle", getColor(value));
            }

            jsonArray.put(jsonObject);
        }

        return jsonArray.toString();

    }

    public Integer intValue(Object a) {

        return Double.valueOf(String.valueOf(a)).intValue();
    }

    public Object getColor(int value) {
        if (value < 0) {
            return JSONObject.parse("{normal: {color: '#b8b8b8'}}");
        } else if (value <= 50) {
            return JSONObject.parse("{normal: {color: '#00E400'}}");
        } else if (value <= 100) {
            return JSONObject.parse("{normal: {color: '#FFFF00'}}");
        } else if (value <= 150) {
            return JSONObject.parse("{normal: {color: '##FF7E00'}}");
        } else if (value <= 200) {
            return JSONObject.parse("{normal: {color: '#FF0000'}}");
        } else if (value <= 300) {
            return JSONObject.parse("{normal: {color: '#99004C'}}");
        } else {
            return JSONObject.parse("{normal: {color: '#7E0023'}}");
        }

    }

    /**
     * 添加对应的污染物的名称和值
     *
     * @param jsonObject
     * @param name
     * @param value
     * @return
     */

    public JSONObject add(JSONObject jsonObject, String name, String value) {
        if (name.equals("一氧化碳")) {

            jsonObject.put("CO", value);
        } else if (name.equals("二氧化氮")) {
            jsonObject.put("No2", value);
        } else if (name.equals("臭氧(8h)")) {
            jsonObject.put("O3(8h)", value);
        } else if (name.equals("PM10")) {
            jsonObject.put("PM10", value);
        } else if (name.equals("PM2.5")) {
            jsonObject.put("PM2", value);
        } else if (name.equals("二氧化硫")) {
            jsonObject.put("So2", value);
        } else if (name.equals("臭氧")) {
            jsonObject.put("O3", value);
        }
        return jsonObject;

    }

    @RequestMapping("/getListExport")
    @ResponseBody
    public List<Map<String, Object>> getListExport(AirHourDataParam param,HttpServletResponse response){
//        List<AirHourData> lists = airHourDataDao.selectListByQueryObj(param);
        Page<Map<String, Object>> page = new Page<>();
        page.setLimit(100000);
        Page<Map<String, Object>> airDataPage = airHourDataService.listByPage(param, page,response);
        List<Map<String, Object>> lists = airDataPage.getResult();
        /*List<Map<String, Object>> result = new LinkedList<>();
        for (AirHourData airHourData : lists) {
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("monitorTime", airHourData.getMonitorTime());
            map.put("pointName", airHourData.getPointName());
            map.put("aqi", airHourData.getAqi());
            map.put("pm25", "");
            map.put("pm10", "");
            map.put("so2", "");
            map.put("no2", "");
            map.put("o3", "");
            map.put("co", "");
            result.add(map);
        }*/
        return exportEnvironmentNativeWtHourDataExl(response, lists);
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
        columnMap.put("title", "空气小时监测数据表");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("pointName", "监测站点");
        columnMap.put("aqi", "AQI");
        columnMap.put("pm25", "PM2.5(μg/m3)");
        columnMap.put("pm10", "PM10(μg/m3)");
        columnMap.put("so2", "SO2(μg/m3)");
        columnMap.put("no2", "NO2(μg/m3)");
        columnMap.put("o3", "O3(μg/m3)");
        columnMap.put("co", "CO(mg/m3)");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    @RequestMapping("/getAllPointsDayDataRanking")
    @ResponseBody
    public com.alibaba.fastjson.JSONArray getAllPointsDayDataRanking(String time){
        return airHourDataService.getAllPointsDayDataRanking(time);
    }
}
