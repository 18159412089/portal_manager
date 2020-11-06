package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 有关在线水小时的功能
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午2:12:28
 */
@Controller
@RequestMapping("/enviromonit/water/wtHourData")
@Secured({"ROLE_USER"})
public class WtHourDataController extends BaseController {

    @Autowired
    private WtHourDataService wtHourDataService;
    @Autowired
    private SimpleDao simpleDao;

    /**
     * @param modelAndView
     * @param pointCode
     * @param startTime
     * @param endTime
     * @return ModelAndView
     * @throws
     * @Title: index
     * @Description: 在线水小时数据服务页面
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午2:27:49
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午2:27:49
     */
    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView, String pointCode, String startTime, String endTime,String pid) {
        modelAndView.addObject("pointCode", pointCode);
        modelAndView.addObject("startTime", startTime);
        modelAndView.addObject("endTime", endTime);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/wtHourDataList");
        return modelAndView;
    }

    /**
     * @return String
     * @throws
     * @Title: wtHourDataAnalysis
     * @Description: 在线水小时数据分析
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午2:28:24
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午2:28:24
     */
    @RequestMapping("/wtHourDataAnalysis")
    public String wtHourDataAnalysis() {
        return "/moudles/enviromonit/water/wtHourDataAnalysis";
    }

    /**
     * @return R
     * @throws
     * @Title: waterQuantityForCategory
     * @Description: 实现首页的达标率、水质类别展示
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午2:25:18
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午2:25:18
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/waterQuantityForCategory")
    @ResponseBody
    public R waterQuantityForCategory() {
        String sql = "SELECT mp.POINT_CODE,mp.POINT_NAME,TO_CHAR(mr.DATATIME,'yyyy-mm-dd hh24:mi:ss') AS DATATIME,mp.POINT_QUALITY,mr.RESULT_QUALITY,"
                + "mr.EXCESSFACTORSTR,mp.CATEGORY FROM WT_CITY_POINT mp LEFT JOIN WT_CITY_HOUR_REPORT mr ON mp.POINT_CODE = mr.POINT_CODE "
                + "AND (mr.POINT_CODE, mr.DATATIME) IN ( SELECT p.POINT_CODE,MAX(r.DATATIME) FROM WT_CITY_POINT p INNER JOIN WT_CITY_HOUR_REPORT r "
                + "ON p.POINT_CODE = r.POINT_CODE WHERE r.DATATIME >= SYSDATE - 2 AND r.DATATIME <= SYSDATE GROUP BY p.POINT_CODE ) WHERE mp.status = 1 "
                + "and mp.POINT_NAME <> '华安西陂' AND mp.CATEGORY=1";
        //				+ "	UNION ALL\r\n"
        //				+ "SELECT p.POINT_CODE AS MN,p.POINT_NAME AS MNNAME,r.MONITOR_TIME AS DATATIME,"
        //				+ "p.POINT_QUALITY,r.RESULT_QUALITY,r.EXCESSFACTORSTR,'2' AS category"
        //				+ " FROM WT_MONITOR_POINT p LEFT JOIN WT_HOUR_report r ON p.POINT_CODE = r.POINT_CODE"
        //				+ " AND (r.POINT_CODE, r.MONITOR_TIME) IN ( SELECT wp.point_code,MAX(wd.MONITOR_TIME) FROM WT_MONITOR_POINT wp"
        //				+ " INNER JOIN WT_HOUR_report wd ON wp.POINT_CODE = wd.POINT_CODE"
        //				+ " WHERE wd.MONITOR_TIME>= to_char(SYSDATE-2,'yyyy-mm-dd hh24:mi:ss')"
        //				+ " AND wd.MONITOR_TIME<=to_char(SYSDATE,'yyyy-mm-dd hh24:mi:ss') GROUP BY wp.point_code ) WHERE p.status = 1";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();

        String[] category = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "劣Ⅴ", "-"};
        String[] color = {"#2ba4e9", "#2ba4e9", "#45b97c", "#FFFF00", "#f47920", "#d02032", "#b8b8b8"};
        // 各级别超标站点个数(一级,二级，三级，四级，五级，劣五，未知)
        int[] pointQualityNum = new int[category.length];
        int total = 0;
        int num = 0;

        for (Object[] objects : list) {
            int a = 0, b = 0;
            if (!ToolUtil.isEmpty(objects[4])) {
                for (int i = 0; i < category.length; i++) {
                    if (!ToolUtil.isEmpty(objects[3])) {
                        if (WaterQualityEnum.valueOf(ToolUtil.toStr(objects[3])).getKey().equals(category[i])) {
                            b = i;
                        }
                    } else {
                        // 目标水质为空时 不参与达标率的计算
                        b = -1;
                    }

                    if (WaterQualityEnum.valueOf(ToolUtil.toStr(objects[4])).getKey().equals(category[i])) {
                        pointQualityNum[i]++;
                        a = i;
                    }
                }
                if (a <= b) {
                    num++;
                }
            } else {
                // 等于空时为未知
                pointQualityNum[6]++;
            }
            total++;
        }
        int rate = num * 100 / total;
        JSONArray jsonArray1 = new JSONArray();
        JSONArray jsonArray2 = new JSONArray();
        JSONObject rateJson = new JSONObject();
        JSONObject result = new JSONObject();
        for (int j = 0; j < pointQualityNum.length; j++) {
            JSONObject jsonObject = new JSONObject();
            JSONObject colorObject = new JSONObject();
            JSONObject normalObject = new JSONObject();
            colorObject.put("color", color[j]);
            normalObject.put("normal", colorObject);
            jsonObject.put("value", pointQualityNum[j]);
            jsonObject.put("name", j == 6 ? "未知" : category[j]);
            jsonObject.put("itemStyle", normalObject);
            jsonArray1.add(jsonObject);
        }
        result.put("data1", jsonArray1);
        result.put("monitorTime", "");
        rateJson.put("name", "达标率");
        rateJson.put("value", rate);
        jsonArray2.add(rateJson);
        result.put("data2", jsonArray2);
        return R.ok().put("data", result);
    }

    /**
     * @param pointCode
     * @return R
     * @throws
     * @Title: getPointInfo
     * @Description: 获取站点信息
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:11:49
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:11:49
     */
    @RequestMapping("/getPointInfo")
    @ResponseBody
    public R getPointInfo(String pointCode) {
        List<WtHourData> wtHourDataList = wtHourDataService.getListByCode(pointCode);
        Map<String, Object> map = new HashMap<String, Object>();
        for (WtHourData data : wtHourDataList) {
            if (data.getPolluteName().indexOf("溶解氧") > -1) {
                map.put("doxygen", StringUtils.nullToString(data.getPolluteValue()));
            } else if (data.getPolluteName().indexOf("总氮") > -1) {
                map.put("tn", StringUtils.nullToString(data.getPolluteValue()));
            } else if (data.getPolluteName().indexOf("pH") > -1 || data.getPolluteName().indexOf("PH") > -1) {
                map.put("ph", StringUtils.nullToString(data.getPolluteValue()));
            } else if (data.getPolluteName().indexOf("氨氮") > -1) {
                map.put("nh3", StringUtils.nullToString(data.getPolluteValue()));
            } else if (data.getPolluteName().indexOf("总磷") > -1) {
                map.put("tp", StringUtils.nullToString(data.getPolluteValue()));
            } else if (data.getPolluteName().indexOf("高锰酸盐指数") > -1) {
                map.put("kmno4", StringUtils.nullToString(data.getPolluteValue()));
            }
        }
        map.put("monitorTime", wtHourDataList.get(0).getMonitorTime());
        return R.ok(map);
    }

    /**
     * @return JSONArray
     * @throws
     * @Title: getPollutes
     * @Description: 获取污染物列表
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:13:01
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:13:01
     */
    @RequestMapping("/getPollutes")
    @ResponseBody
    public JSONArray getPollutes() {
        String json = "[{'key':'W01009','text':'溶解氧'},{'key':'W01019','text':'高锰酸盐指数'},{'key':'W21003','text':'氨氮'},"
                + "{'key':'W21011','text':'总磷'},{'key':'W01001','text':'PH值'},{'key':'W21001','text':'总氮'},"
                + "{'key':'W01010','text':'水温'},{'key':'W01014','text':'电导率'},{'key':'W01003','text':'浑浊度'}]";
        return JSONArray.parseArray(json);
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: getPageList
     * @Description: 获取在线水表格数据
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:13:50
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:13:50
     */
    @RequestMapping("/getPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getPageList(WtHourDataParam param, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtHourDataPage = wtHourDataService.getPageList(param, page);
        return new PageEU<>(wtHourDataPage);
    }

    /*
     * 导出Excel
     * @param response
     * @param list
     * @return
     */
    @RequestMapping("/export")
    @ResponseBody
    public List<Map<String, Object>> export(HttpServletRequest request, HttpServletResponse response) {
        WtHourDataParam param = new WtHourDataParam();
        String pointName = request.getParameter("pointName");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        param.setPointName(pointName);
        param.setStartTime(startTime);
        param.setEndTime(endTime);
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtHourDataPage = wtHourDataService.getPageList(param, page);
        List<Map<String, Object>> result = wtHourDataPage.getResult();
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", "在线水小时监测数据");
        columnMap.put("datatime", "监测时间");
        columnMap.put("pointName", "监测站点");
        columnMap.put("w01010", "溶解氧");
        columnMap.put("w01001", "电导率");
        columnMap.put("w01009", "浑浊度");
        columnMap.put("w01014", "高锰酸盐指数");
        columnMap.put("w01003", "氨氮（NH3-N）");
        columnMap.put("w21011", "总磷（以P计）");
        columnMap.put("w21001", "总氮（以氮计）CO(mg/m3)");
        columnMap.put("targetQuality", "目标水质");
        columnMap.put("resultQuality", "测试水质");
        columnMap.put("polluteNames", "超标污染物");
        ExcelExportUtil.exportExcel(response, columnMap, result);
        return null;
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: getPageListNative
     * @Description: 获取国控水质实时监测
     * @CreateBy: lilongan
     * @CreateTime: 2019年6月26日
     * @UpdateBy: lilongan
     * @UpdateTime: 2019年6月26日
     */
    @RequestMapping("/getPageListNative")
    @ResponseBody
    public PageEU<Map<String, Object>> getPageListNative(WtHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
        String regionName = request.getParameter("regionName");
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtHourDataPage = wtHourDataService.getPageListNative(param, page, regionName);
        return new PageEU<>(wtHourDataPage);
    }

    /**
     * 实时动态数据大屏  水质自动实时监测
     *
     * @return
     */
    @RequestMapping("/getWtRealTimeData")
    @ResponseBody
    public List<Map> getWtRealTimeData() {
        return wtHourDataService.getWtRealTimeData();
    }

    /**
     * @param param
     * @param request
     * @return List<Map < String, Object>>
     * @throws
     * @Title: getListExport
     * @Description: 导出国控省控水质实时监测数据报表
     * @CreateBy: lilongan
     * @CreateTime: 2019年6月26日
     * @UpdateBy: lilongan
     * @UpdateTime: 2019年6月26日
     */
    @RequestMapping("/getListExport")
    @ResponseBody
    public List<Map<String, Object>> getListExport(WtHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
        String regionName = request.getParameter("regionName");
        String datatype = request.getParameter("datatype");
        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            } else {
                where = "";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
            } else {
                where = "";
            }
        }
        String sql = "SELECT a.DATATIME, a.POINT_CODE, a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', DATAVALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', DATAVALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', DATAVALUE, 0 )) W01009,"
                + "sum(DECODE( CODE_POLLUTE, 'W01014', DATAVALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', DATAVALUE, 0 )) W01003,"
                + "sum(DECODE( CODE_POLLUTE, 'W01019', DATAVALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', DATAVALUE, 0 )) W21003,"
                + "sum(DECODE( CODE_POLLUTE, 'W21011', DATAVALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', DATAVALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_HOUR_REPORT b ON a.DATATIME=b.DATATIME and a.POINT_CODE=b.POINT_CODE "
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE "
                + where
                + " AND c.CATEGORY=" + datatype
                + " AND c.STATUS=1 "
                + "GROUP BY a.DATATIME, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY DATATIME DESC";
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql);
        for (int i = 0; i < list.size(); i++) {
            JSONArray polluteName = new JSONArray();
            JSONArray polluteCodes = new JSONArray();
            Map<String, Object> map = list.get(i);
            map.put("targetQuality", WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("targetQuality"))).getKey());
            map.put("resultQuality", WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("resultQuality"))).getKey());
            JSONArray parseArray = JSONArray.parseArray(map.get("excessfactorstr").toString());
            map.remove("excessfactorstr");
            for (int j = 0; j < parseArray.size(); j++) {
                JSONObject jsonObject = parseArray.getJSONObject(j);
                if (!jsonObject.containsKey("isExcess")) {
                    polluteName.add(jsonObject.get("polluteName"));
                    polluteCodes.add(jsonObject.get("codePollute").toString().toLowerCase());
                } else if (jsonObject.get("isExcess").equals(true)) {
                    polluteName.add(jsonObject.get("polluteName"));
                    polluteCodes.add(jsonObject.get("codePollute").toString().toLowerCase());
                }
            }
            map.put("polluteNames", polluteName);
            map.put("polluteCodes", polluteCodes);
            list.set(i, map);
        }
        // 导出所有
        return exportEnvironmentNativeWtHourDataExl(response, list,datatype);
    }

    /**
     * 导出Excel 全部 整改时间延期  --整改汇总表
     *
     * @param response
     * @param list
     * @param datatype
     * @return
     */
    private List<Map<String, Object>> exportEnvironmentNativeWtHourDataExl(HttpServletResponse response, List<Map<String, Object>> list,String datatype) {
        // 定义Excel 字段名称
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        if("2".equals(datatype)){
            columnMap.put("title", "漳州市省控断面水质实时监测数据表");
        }else{
            columnMap.put("title", "漳州市国控断面水质实时监测数据表");
        }

        columnMap.put("datatime", "监测时间");
        columnMap.put("pointName", "监测站点");
        columnMap.put("targetQuality", "目标水质");
        columnMap.put("resultQuality", "抽取水质");
        columnMap.put("w01010", "水温");
        columnMap.put("w01001", "PH值");
        columnMap.put("w01009", "溶解氧");
        columnMap.put("w01014", "电导率");
        columnMap.put("w01003", "浑浊度");
        columnMap.put("w01019", "高锰酸盐指数");
        columnMap.put("w21003", "氨氮（NH3-N）");
        columnMap.put("w21011", "总磷（以P计）");
        columnMap.put("w21001", "总氮（以氮计）");
        columnMap.put("polluteNames", "超标污染物");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: getPageListProvince
     * @Description: 获取省控水质实时监测
     * @CreateBy: lilongan
     * @CreateTime: 2019年6月26日
     * @UpdateBy: lilongan
     * @UpdateTime: 2019年6月26日
     */
    @RequestMapping("/getPageListProvince")
    @ResponseBody
    public PageEU<Map<String, Object>> getPageListProvince(WtHourDataParam param, HttpServletRequest request) {
        String regionName = request.getParameter("regionName");
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtHourDataPage = wtHourDataService.getPageListProvince(param, page, regionName);
        return new PageEU<>(wtHourDataPage);
    }

    /**
     * @param param
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getPassMonthAnalysis
     * @Description: 在线水往月环比数据分析
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:14:18
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:14:18
     */
    @RequestMapping("/getPassMonthAnalysis")
    @ResponseBody
    public Map<String, Object> getPassMonthAnalysis(WtHourDataParam param) throws ParseException {

        return wtHourDataService.getPassMonthAnalysis(param);
    }


    /**
     * @param str
     * @return String
     * @throws
     * @Title: toSqlStr
     * @Description: 部分sql语句拼接
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:15:33
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:15:33
     */
    public String toSqlStr(String str) {
        String sqlStr = null;
        if (ToolUtil.isNotEmpty(str)) {
            String[] strs = str.split(",");
            sqlStr = "'" + StringUtils.join(strs, "','") + "'";
        }
        return sqlStr;
    }
}
