package com.fjzxdz.ams.zphb.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.fjzxdz.frame.utils.OtherDBSimpleCurdUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.hourdata.service.PeHourFluxService;
import com.fjzxdz.ams.module.enviromonit.water.entity.PollutionWaterData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtMnPoint;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtPolicy;
import com.fjzxdz.ams.module.enviromonit.water.param.WtMnHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import com.fjzxdz.ams.util.WaterSeriesUtil;
import io.netty.util.internal.StringUtil;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Clob;
import java.text.ParseException;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

/**
 * 水环境服务，水环境数据服务
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:06:49
 */
@Controller
@RequestMapping("/zphb/enviromonit/water/nationalSurfaceWater")
@Secured({"ROLE_USER"})
public class ZpNationalSurfaceWaterController extends BaseController {

    @Autowired
    private WtMnHourDataService wtMnHourDataService;
    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private PeHourFluxService peHourFluxService;
    /**
     * @param polluteCode
     * @param category
     * @return R
     * @throws
     * @Title: list
     * @Description: 获取地图上坐标点的点位信息，流域信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:32:41
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:32:41
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/listNoPage")
    @ResponseBody
    public R list(String polluteCode, String category) {
        String sql = "";
        if (StringUtils.isNull(polluteCode)) {
            sql = "SELECT p.POINT_CODE,p.POINT_NAME,p.WSYSTEM_NAME,p.LONGITUDE,p.LATITUDE,TO_CHAR(r.DATATIME,'yyyy-mm-dd hh24:mi:ss'),"
                    + "p.POINT_QUALITY,r.RESULT_QUALITY,r.EXCESSFACTORSTR,category,lines,polygon FROM WT_CITY_POINT p"
                    + " LEFT JOIN WT_CITY_HOUR_REPORT r ON p.POINT_CODE = r.POINT_CODE AND r.DATATIME>=SYSDATE-2 AND r.DATATIME<=SYSDATE"
                    + " AND (r.POINT_CODE,r.DATATIME) IN (SELECT wp.point_code,MAX(wd.DATATIME) FROM WT_CITY_POINT wp INNER JOIN WT_CITY_HOUR_REPORT wd"
                    + " ON wp.POINT_CODE = wd.POINT_CODE WHERE wd.DATATIME>= SYSDATE-2 AND wd.DATATIME<=SYSDATE GROUP BY wp.point_code)"
                    + " WHERE p.status = 1 ";
            if ("3".equals(category)) {
                sql += " and p.CATEGORY=3";
            } else if ("all".equals(category)) {
                // sql += " and p.CATEGORY in (1,2,3)";
            } else {
                sql += " and p.CATEGORY in (1,2)";
            }
        } else {
            sql = "SELECT t.POINT_CODE,t.POINT_NAME,t.WSYSTEM_NAME,t.LONGITUDE,t.LATITUDE,a.DATATIME,t.POINT_QUALITY,a.DATAVALUE,'' as col,t.category,t.lines,t.polygon"
                    + " FROM WT_CITY_POINT t left join (SELECT cp.POINT_CODE,TO_CHAR(hd.DATATIME,'yyyy-mm-dd hh24:mi:ss') as DATATIME,hd.DATAVALUE"
                    + " FROM WT_CITY_POINT cp inner JOIN WT_CITY_HOUR_DATA hd on cp.POINT_CODE = hd.POINT_CODE  and UPPER(hd.CODE_POLLUTE)='"
                    + polluteCode
                    + "' and (hd.POINT_CODE,hd.DATATIME) in (SELECT p.POINT_CODE,MAX(r.DATATIME) FROM WT_CITY_POINT p"
                    + " INNER JOIN WT_CITY_HOUR_DATA r ON p.POINT_CODE = r.POINT_CODE WHERE UPPER(r.CODE_POLLUTE)='"
                    + polluteCode
                    + "' and r.DATATIME>= SYSDATE-2 AND r.DATATIME<= SYSDATE GROUP BY p.POINT_CODE ) where cp.status = 1 and UPPER(hd.CODE_POLLUTE)='"
                    + polluteCode + "' ) a on t.point_code=a.point_code where t.status=1 ";
            if ("3".equals(category)) {
                sql += " and t.CATEGORY=3";
            }
        }
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("mn", StringUtils.nullToString(objects[0]));
            json.put("mnname", StringUtils.nullToString(objects[1]));
            json.put("rivername", StringUtils.nullToString(objects[2]));
            json.put("lng", StringUtils.nullToString(objects[3]));
            json.put("lat", StringUtils.nullToString(objects[4]));
            json.put("datatime", StringUtils.nullToString(objects[5]));
            json.put("pointQuality", StringUtils.nullToString(objects[6]));
            json.put("resultQuality", StringUtils.nullToString(objects[7]));
            json.put("excessfactorstr", StringUtils.ClobToString((Clob) objects[8]));
            json.put("category", objects[9].toString());

            if (StringUtils.isNull(polluteCode)) {
                if (StringUtils.isNull(StringUtils.nullToString(objects[7]))) {
                    json.put("value", WaterQualityEnum.NONE.getKey());
                    json.put("quality", WaterQualityEnum.NONE.getKey());
                } else {
                    json.put("value", WaterQualityEnum.valueOf(objects[7].toString()).getKey());
                    json.put("quality", WaterQualityEnum.valueOf(objects[7].toString()).getKey());
                }
            } else if ("W01001".equals(polluteCode) || "W01009".equals(polluteCode) || "W01019".equals(polluteCode)
                    || "W21003".equals(polluteCode) || "W21011".equals(polluteCode)) {
                if (StringUtils.isNull(StringUtils.nullToString(objects[7]))) {
                    json.put("value", "-");
                    json.put("quality", "-");
                } else {
                    json.put("value", new BigDecimal(objects[7].toString()));
                    json.put("quality",
                            WaterQualityUtil
                                    .calQualityBySingleFactor(polluteCode, objects[7].toString(),
                                            WaterQualityEnum.valueOf(StringUtils.nullToString(objects[6])), "0")
                                    .getKey());
                }
            } else {
                if (StringUtils.isNull(StringUtils.nullToString(objects[7]))) {
                    json.put("value", "-");
                } else {
                    json.put("value", new BigDecimal(objects[7].toString()));
                }
                json.put("quality", "-");
            }
            jsonAry.add(json);
            json.put("lines", StringUtils.ClobToString((Clob) objects[10]));
            json.put("polygon", StringUtils.ClobToString((Clob) objects[11]));

        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param pointCode
     * @return R
     * @throws
     * @Title: getListByPointCode
     * @Description: 根据站点code获取点位信息
     * @CreateBy: chenbingke
     * @CreateTime: 2019年7月23日 下午4:27:37
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年7月23日 下午4:27:37
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getListByPointCode")
    @ResponseBody
    public R getListByPointCode(String pointCode) {

        String sql = "SELECT p.POINT_CODE,p.POINT_NAME,p.WSYSTEM_NAME,p.LONGITUDE,p.LATITUDE,TO_CHAR(r.DATATIME,'yyyy-mm-dd hh24:mi:ss'),"
                + "p.POINT_QUALITY,r.RESULT_QUALITY,r.EXCESSFACTORSTR,category,lines,polygon FROM WT_CITY_POINT p"
                + " LEFT JOIN WT_CITY_HOUR_REPORT r ON p.POINT_CODE = r.POINT_CODE AND r.DATATIME>=SYSDATE-2 AND r.DATATIME<=SYSDATE"
                + " AND (r.POINT_CODE,r.DATATIME) IN (SELECT wp.point_code,MAX(wd.DATATIME) FROM WT_CITY_POINT wp INNER JOIN WT_CITY_HOUR_REPORT wd"
                + " ON wp.POINT_CODE = wd.POINT_CODE WHERE wd.DATATIME>= SYSDATE-2 AND wd.DATATIME<=SYSDATE GROUP BY wp.point_code)"
                + " WHERE p.status = 1 and p.POINT_CODE='" + pointCode + "'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("mn", StringUtils.nullToString(objects[0]));
            json.put("mnname", StringUtils.nullToString(objects[1]));
            json.put("rivername", StringUtils.nullToString(objects[2]));
            json.put("lng", StringUtils.nullToString(objects[3]));
            json.put("lat", StringUtils.nullToString(objects[4]));
            json.put("datatime", StringUtils.nullToString(objects[5]));
            json.put("pointQuality", StringUtils.nullToString(objects[6]));
            json.put("resultQuality", StringUtils.nullToString(objects[7]));
            json.put("excessfactorstr", StringUtils.ClobToString((Clob) objects[8]));
            json.put("category", objects[9].toString());
            if (StringUtils.isNull(StringUtils.nullToString(objects[7]))) {
                json.put("value", WaterQualityEnum.NONE.getKey());
                json.put("quality", WaterQualityEnum.NONE.getKey());
            } else {
                json.put("value", WaterQualityEnum.valueOf(objects[7].toString()).getKey());
                json.put("quality", WaterQualityEnum.valueOf(objects[7].toString()).getKey());
            }
            json.put("lines", StringUtils.ClobToString((Clob) objects[10]));
            json.put("polygon", StringUtils.ClobToString((Clob) objects[11]));
            jsonAry.add(json);

        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param absinCode
     * @return R
     * @throws
     * @Title: getListByBasinCode
     * @Description: 根据小河流域basin_code获取点位信息
     * @CreateBy: 吴登淋
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getListByBasinCode")
    @ResponseBody
    public R getListByBasinCode(String basinCode) {
        String sql = "select a.monitor_code,a.monitor_name,a.longitude,a.latitude,b.PH_VALUE,b.PH_LEVEL,b.RJY_VALUE,"
                + "b.RJY_LEVEL,GMSY_VALUE,b.GMSY_LEVEL,b.BOD_VALUE,b.BOD_LEVEL,b.ZL_VALUE,b.ZL_LEVEL,b.ANDAN_VALUE,"
                + "b.ANDAN_LEVEL,b.TARGET_QUALITY,b.RESULT_QUALITY,a.lines,b.YEAR_NUMBER,b.MONTH_NUMBER,a.analysis"
                + " from wt_basin_monitor a inner join ("
                + "select t.*,row_number() over(partition by basin_code order by year_number desc,month_number desc)"
                + " as rn from wt_basin_month_data t) b on a.monitor_code = b.basin_code and b.rn=1 where a.monitor_code=" + basinCode
                + " order by a.monitor_code";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("code", StringUtils.nullToString(objects[0]));
            json.put("name", StringUtils.nullToString(objects[1]));
            json.put("lng", StringUtils.nullToString(objects[2]));
            json.put("lat", StringUtils.nullToString(objects[3]));
            json.put("phValue", StringUtils.nullToString(objects[4]));
            json.put("phLevel", WaterQualityEnum.valueOf(objects[5] == null ? "NONE" : objects[5].toString()).getKey());
            json.put("rjyValue", StringUtils.nullToString(objects[6]));
            json.put("rjyLevel", WaterQualityEnum.valueOf(objects[7] == null ? "NONE" : objects[7].toString()).getKey());
            json.put("gmsyValue", StringUtils.nullToString(objects[8]));
            json.put("gmsyLevel", WaterQualityEnum.valueOf(objects[9] == null ? "NONE" : objects[9].toString()).getKey());
            json.put("bodValue", StringUtils.nullToString(objects[10]));
            json.put("bodLevel", WaterQualityEnum.valueOf(objects[11] == null ? "NONE" : objects[11].toString()).getKey());
            json.put("zlValue", StringUtils.nullToString(objects[12]));
            json.put("zlLevel", WaterQualityEnum.valueOf(objects[13] == null ? "NONE" : objects[13].toString()).getKey());
            json.put("andanValue", StringUtils.nullToString(objects[14]));
            json.put("andanLevel", WaterQualityEnum.valueOf(objects[15] == null ? "NONE" : objects[15].toString()).getKey());
            json.put("targetQuality", WaterQualityEnum.valueOf(objects[16] == null ? "NONE" : objects[16].toString()).getKey());
            json.put("resultQuality", WaterQualityEnum.valueOf(objects[17] == null ? "NONE" : objects[17].toString()).getKey());
            if (StringUtils.isNull(StringUtils.nullToString(objects[18]))) {
                json.put("lines", "");
            } else {
                json.put("lines", StringUtils.ClobToString((Clob) objects[18]));
            }
            json.put("yearNumber", objects[19].toString());
            json.put("monthNumber", objects[20].toString());
            if (StringUtils.isNull(StringUtils.nullToString(objects[21]))) {
                json.put("analysis", "");
            } else {
                json.put("analysis", StringUtils.ClobToString((Clob) objects[21]));
            }
            jsonAry.add(json);
        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param page
     * @param rows
     * @param pointName
     * @param request
     * @return PageEU<WtCityPoint>
     * @throws
     * @Title: getMiniMonitorList
     * @Description: 获取微型自动监测站信息
     * @CreateBy: chenbingke
     * @CreateTime: 2019年6月12日 下午5:26:26
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年6月12日 下午5:26:26
     */
    @RequestMapping("/getMiniMonitorList")
    @ResponseBody
    public PageEU<WtCityPoint> getMiniMonitorList(@RequestParam(value = "page", required = false) Integer page,
                                                  @RequestParam(value = "rows", required = false) Integer rows,
                                                  @RequestParam(value = "pointName", required = false) String pointName, HttpServletRequest request) {

        Page<WtCityPoint> dataPage = new Page<>();
        if (page != null) {
            dataPage.setCurrentPage(page - 1);
        }
        if (rows != null) {
            dataPage.setLimit(rows);
        }

        String sql = "SELECT p.POINT_CODE mn,p.POINT_NAME mnname,p.WSYSTEM_NAME rivername,p.LONGITUDE lng,p.LATITUDE lat,"
                + "TO_CHAR(r.DATATIME,'yyyy-mm-dd hh24:mi:ss') DATATIME,p.POINT_QUALITY,r.RESULT_QUALITY,"
                + "r.EXCESSFACTORSTR,category,lines,polygon FROM WT_CITY_POINT p"
                + " LEFT JOIN WT_CITY_HOUR_REPORT r ON p.POINT_CODE = r.POINT_CODE"
                + " AND r.DATATIME>=SYSDATE-2 AND r.DATATIME<=SYSDATE"
                + " AND (r.POINT_CODE,r.DATATIME) IN ("
                + "SELECT wp.point_code,MAX(wd.DATATIME) FROM WT_CITY_POINT wp"
                + " INNER JOIN WT_CITY_HOUR_REPORT wd ON wp.POINT_CODE = wd.POINT_CODE"
                + " WHERE wd.DATATIME>= SYSDATE-2 AND wd.DATATIME<=SYSDATE GROUP BY wp.point_code)"
                + " WHERE p.status = 1  and p.CATEGORY=3";
        if (!StringUtils.isNull(pointName)) {
            sql += "and p.POINT_NAME like '%" + pointName + "%'";
        }
        simpleDao.listNativeByPage(sql, dataPage);
        return new PageEU<>(dataPage);
    }

    /**
     * @param peType
     * @return R
     * @throws
     * @Title: getPeMonitorPoints
     * @Description: 污水处理厂点位信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:34:19
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:34:19
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPeMonitorPoints")
    @ResponseBody
    public R getPeMonitorPoints(String peType) {
        String sql = "select distinct e.PE_ID,e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.ADDRESS,e.ENV_PRINCIPAL,e.TEL,p.cameraid, " +
                " b.VIDEO,b.PICTURE,b.PICNAME,b.VEDIONAME "
                + " from PE_MONITOR_POINT p inner join PE_ENTERPRISE_DATA e"
                + " on p.PE_ID=e.PE_ID left join FILE_ATTACHMENT B ON e.PE_NAME = B.PKID where p.OUTFALL_TYPE=1 AND e.LONG_VALUE IS NOT NULL AND e.LAT_VALUE IS NOT NULL" ;
        if ("type1".equals(peType)) {
            sql += " AND e.pe_type = 'peType1'";
        } else {
            sql += " AND e.pe_type <> 'peType1'";
        }
        sql+=" and e.qx like '%漳浦%'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        JSONArray jsonArray = new JSONArray();
        for (Object[] objects : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("peId", StringUtils.nullToString(objects[0]));
            jsonObject.put("name", StringUtils.nullToString(objects[1]));
            jsonObject.put("lng", StringUtils.nullToString(objects[2]));
            jsonObject.put("lat", StringUtils.nullToString(objects[3]));
            jsonObject.put("address", StringUtils.nullToString(objects[4]));
            jsonObject.put("principal", StringUtils.nullToString(objects[5]));
            jsonObject.put("tel", StringUtils.nullToString(objects[6]));
            jsonObject.put("cameraid", StringUtils.nullToString(objects[7]));
            jsonObject.put("video", StringUtils.nullToString(objects[8]));
            jsonObject.put("picture", StringUtils.nullToString(objects[9]));
            jsonObject.put("videoname", StringUtils.nullToString(objects[10]));
            jsonObject.put("picname", StringUtils.nullToString(objects[11]));
            jsonArray.add(jsonObject);
        }
        return R.ok().put("data", jsonArray);

    }

    /**
     * @param page
     * @param rows
     * @param peType
     * @param request
     * @return PageEU<?>
     * @throws
     * @Title: getPeMonitorPointsList
     * @Description: 污水处理厂点位信息
     * @CreateBy: chenbingke
     * @CreateTime: 2019年6月11日 下午4:15:03
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年6月11日 下午4:15:03
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPeMonitorPointsList")
    @ResponseBody
    public PageEU<?> getPeMonitorPointList(@RequestParam(value = "page", required = false) Integer page,
                                           @RequestParam(value = "rows", required = false) Integer rows,
                                           @RequestParam(value = "peType", required = false) String peType,
                                           @RequestParam(value = "peName", required = false) String peName,
                                           @RequestParam(value = "discharge", required = false) String discharge, HttpServletRequest request) {

        Page dataPage = new Page<>();
        if (page != null) {
            dataPage.setCurrentPage(page - 1);
        }
        if (rows != null) {
            dataPage.setLimit(rows);
        }

        String sql = "select distinct e.PE_ID,e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.ADDRESS,e.ENV_PRINCIPAL,e.TEL,p.cameraid," +
                "b.VIDEO,b.PICTURE,b.PICNAME,b.VEDIONAME "
                + " from PE_MONITOR_POINT p inner join PE_ENTERPRISE_DATA e"
                + " on p.PE_ID=e.PE_ID left join FILE_ATTACHMENT B ON e.PE_NAME = B.PKID where p.OUTFALL_TYPE=1 AND e.LONG_VALUE IS NOT NULL AND e.LAT_VALUE IS NOT NULL";
        if ("type1".equals(peType)) {
            sql += " AND e.pe_type = 'peType1'";
        } else {
            sql += " AND e.pe_type <> 'peType1'";
            if ("1".equals(discharge)) {
                sql += " and p.ALLOW_PLU_LET < 500";
            } else if ("2".equals(discharge)) {
                sql += " and p.ALLOW_PLU_LET > 500 and p.ALLOW_PLU_LET < 2000";
            } else if ("3".equals(discharge)) {
                sql += " and p.ALLOW_PLU_LET > 2000";
            }
        }
        if (!StringUtil.isNullOrEmpty(peName)) {
            sql += " AND e.PE_NAME like '%" + peName + "%'";
        }
        sql+=" and e.qx like '%漳浦%'";
        simpleDao.listNativeByPage(sql, dataPage);
        return new PageEU<>(dataPage);
    }

    /**
     * 巡河流域
     *
     * @return
     * @author huangyl 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolPoints")
    @ResponseBody
    public R getPeMonitorPoints() throws Exception {
        //cn.hutool.json.JSONArray patrolPoints = OtherDBSimpleCurdUtil.findByTableName("ZZProblemProcessing", "web_xproject_problem_processing_river_patrol");
        cn.hutool.json.JSONArray patrolPoints = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_dayBefore", new HashMap<>());
        return R.ok().put("data", patrolPoints);

    }

    /**
     * 获取所属漳浦的问题受理系统中的水环保事件
     * @return
     * @author gsq
     */
    @RequestMapping("/getWaterCaseList")
    @ResponseBody
    public JSONObject getWaterCaseList(HttpServletRequest request) throws Exception {
        String des = request.getParameter("des");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        Integer rows = Integer.parseInt(request.getParameter("rows"));
        Integer page = Integer.parseInt(request.getParameter("page"));

        StringBuilder typeWhere = new StringBuilder("SELECT id FROM dbo.web_xproject_problem_processing_problem_type where name LIKE '%水污染%' AND (parentId IS NULL OR parentId='')");
        StringBuilder whereStr = new StringBuilder("");
        StringBuilder whereStr2 = new StringBuilder(" where a.rn > " + page * rows + " and a.rn <= " + (page + 1) * rows);

        if (!StringUtils.isNull(des)) {
            whereStr.append(" and (describe like '%" + des + "%') ");
        }
        if (!StringUtils.isNull(startTime)) {
            whereStr.append(" and ('" + startTime + "'<=[reportTime]) ");
        }
        if (!StringUtils.isNull(endTime)) {
            whereStr.append(" and ([reportTime]<'" + endTime + "') ");
        }
        //添加漳浦查询过滤条件
        //vVPUlBmGVGdL9u70oUp0Ii为漳浦网格ID
        whereStr.append(" and (c.id in (select id from dbo.fn_web_xproject_joint_service_base_get_all_department_by_dept_id('vVPUlBmGVGdL9u70oUp0Ii'))) ");

        String columnStr = " b.*," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_SOURCE_NAME', b.[source]) AS [sourceName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[majorTypeId]) AS [majorTypeIdName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[smallTypeId]) AS [smallTypeIdName]," +
                "dbo.fjzx_frame_fn_format_date_time(b.[reportTime]) AS [reportFormatTime]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_OPERATION', b.[status]) AS [statusName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('CASE_OVER_TIME_STATUS', b.[overTimeStatus]) AS [overTimeStatusName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_CASE_TYPE', b.[caseType]) AS [caseTypeName]," +
                "dbo.[fjzx_frame_fn_get_system_code_name]('USER', b.[createBy]) AS  createByName," +
                "dbo.fn_web_common_get_department_of_organization_by_department(c.id) AS departmentIdName," +
                "dbo.fjzx_frame_fn_get_system_code_name('USER_LEVEL', c.departmentType) AS userLevel," +
                "COUNT(1) OVER() AS resultTotalCount " +
                "FROM web_xproject_problem_processing_case b " +
                "LEFT JOIN dbo.web_common_department_position d ON b.positionId=d.id " +
                "LEFT JOIN dbo.web_common_department c ON c.id=d.departmentId ";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("typeWhere", typeWhere.toString());
        paramMap.put("column", columnStr);
        paramMap.put("where", whereStr.toString());
        paramMap.put("where2", whereStr2.toString());

        cn.hutool.json.JSONArray waterCaseList = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "problemProcessing_commonly_case_list", paramMap);

        JSONObject data = new JSONObject();
        data.put("data", waterCaseList);
        if(waterCaseList.size()>0){
            data.put("maxSize", waterCaseList.getJSONObject(0).get("resultTotalCount"));
        }else{
            data.put("maxSize", 0);
        }
        data.put("page", page + 1);
        data.put("pageSize", rows);

        return data;
    }

    /**
     * 获取网格水事件的附件
     *
     * @param caseId
     * @throws Exception
     * @author gsq
     */
    @RequestMapping("/getCaseFiles")
    @ResponseBody
    public R getCaseFiles(String caseId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        String referenceId = " and a.referenceId='" + caseId + "'";
        paramMap.put("referenceId", referenceId);
        cn.hutool.json.JSONArray files = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "problemProcessing_commonly_case_files", paramMap);

        JSONObject data = new JSONObject();
        data.put("list", files);
        return R.ok(data);
    }

    @RequestMapping("/getPatrolPointsList")
    @ResponseBody
    public JSONObject getPatrolPointsList(@RequestParam(value = "page", required = false) Integer page,
                                          @RequestParam(value = "rows", required = false) Integer rows,
                                          @RequestParam(value = "riverName", required = false) String riverName, HttpServletRequest request) throws Exception {

        StringBuilder whereStr = new StringBuilder(" where riverName is not null ");
        StringBuilder whereStr2 = new StringBuilder(" where a.rn > " + page * rows + " and a.rn <= " + (page + 1) * rows);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        cn.hutool.json.JSONArray riverPatrol = new cn.hutool.json.JSONArray();
        cn.hutool.json.JSONArray riverPatrolCount = new cn.hutool.json.JSONArray();

        paramMap.clear();
        whereStr.append(" and SUBSTRING(convert(char(10),createtime,120), 1, 10)= SUBSTRING(convert(char(10),dateadd(day, -1, getdate()),120) , 1, 10)");
        if (!StringUtils.isNull(riverName)) {
            whereStr.append(" AND riverName like '%" + riverName + "%'");
        }
        paramMap.put("where", whereStr.toString());
        paramMap.put("where2", whereStr2.toString());
        riverPatrol = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_data_list", paramMap);
        riverPatrolCount = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_data_count", paramMap);

        JSONObject data = new JSONObject();
        data.put("riverPatrol", riverPatrol);

        JSONArray dataAry = new JSONArray();
        for (int i = 0; i < riverPatrol.size(); i++) {
            JSONObject obj = new JSONObject();
            obj.put("id", riverPatrol.getJSONObject(i).get("id"));
            obj.put("riverName", riverPatrol.getJSONObject(i).get("riverName"));
            obj.put("lng", riverPatrol.getJSONObject(i).get("startLng"));
            obj.put("lat", riverPatrol.getJSONObject(i).get("startLat"));
            obj.put("startPosition", riverPatrol.getJSONObject(i).get("startPosition"));
            obj.put("endPosition", riverPatrol.getJSONObject(i).get("endPosition"));
            obj.put("duration", riverPatrol.getJSONObject(i).get("duration"));
            obj.put("distance", riverPatrol.getJSONObject(i).get("distance"));
            obj.put("startTime", riverPatrol.getJSONObject(i).get("startTime"));
            dataAry.add(obj);
        }

        JSONObject result = new JSONObject();
        result.put("data", dataAry);
        result.put("maxSize", riverPatrolCount.getJSONObject(0).get("count"));
        result.put("page", page);
        result.put("pageSize", rows);

        return result;

    }

    /**
     * 根据巡河记录ID获取所有相关数据（上报记录、附件、巡河轨迹）
     *
     * @return
     * @author ZhangGQ 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolInfo")
    @ResponseBody
    public R getPatrolInfo(String patrolId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        StringBuilder whereStr = new StringBuilder(" where 1=1 ");

        cn.hutool.json.JSONArray riverPatrol = new cn.hutool.json.JSONArray();
        cn.hutool.json.JSONArray riverPatrolReports = new cn.hutool.json.JSONArray();
        cn.hutool.json.JSONArray riverPatrolReportFiles = new cn.hutool.json.JSONArray();
        cn.hutool.json.JSONArray riverPatrolTracks = new cn.hutool.json.JSONArray();

        //获取巡河记录数据
        whereStr = new StringBuilder(" where 1=1 ");
        whereStr.append(" AND id = '" + patrolId + "'");
        paramMap.clear();
        paramMap.put("where", whereStr.toString());
        riverPatrol = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_data", paramMap);

        //获取上报记录数据
        paramMap.clear();
        paramMap.put("patrolId", patrolId);
        riverPatrolReports = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_reports", paramMap);

        //获取巡河上报附件
        for (int i = 0; i < riverPatrolReports.size(); i++) {
            cn.hutool.json.JSONObject report = riverPatrolReports.getJSONObject(i);
            String patrolReportId = report.getStr("id");

            whereStr = new StringBuilder(" where 1=1 ");
            whereStr.append(" AND referenceTableName = 'web_xproject_problem_processing_river_patrol_report'");
            whereStr.append(" AND referenceId = '" + patrolReportId + "'");

            paramMap.clear();
            paramMap.put("where", whereStr.toString());
            cn.hutool.json.JSONArray files = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_report_files", paramMap);

            riverPatrolReports.getJSONObject(i).put("reportFiles", files);
            riverPatrolReportFiles.addAll(files);
        }

        //获取巡河轨迹数据
        whereStr = new StringBuilder(" where 1=1 ");
        whereStr.append(" AND patrolId = '" + patrolId + "'");
        paramMap.clear();
        paramMap.put("where", whereStr.toString());
        riverPatrolTracks = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_tracks", paramMap);

        JSONObject data = new JSONObject();
        data.put("riverPatrol", riverPatrol);
        data.put("riverPatrolReports", riverPatrolReports);
        data.put("riverPatrolReportFiles", riverPatrolReportFiles);
        data.put("riverPatrolTracks", riverPatrolTracks);
        return R.ok(data);

    }

    /**
     * 根据巡河记录ID获取巡河上报数据
     *
     * @return
     * @author ZhangGQ 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolReport")
    @ResponseBody
    public R getPatrolReport(String patrolId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        StringBuilder whereStr = new StringBuilder(" where 1=1 ");
        whereStr.append(" id = '" + patrolId + "'");
        paramMap.put("where", whereStr.toString());
        cn.hutool.json.JSONArray fileIds = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_data", paramMap);

        return R.ok().put("data", fileIds);

    }

    /**
     * 根据巡河记录ID获取巡河上报数据
     *
     * @return
     * @author ZhangGQ 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolReportList")
    @ResponseBody
    public R getPatrolReportList(String patrolId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("patrolId", patrolId);
        cn.hutool.json.JSONArray fileIds = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_reports", paramMap);

        return R.ok().put("data", fileIds);

    }

    /**
     * 根据巡河上报记录ID获取附件数据
     *
     * @return
     * @author ZhangGQ 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolReportFileList")
    @ResponseBody
    public R getPatrolReportFileList(String patrolReportId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        StringBuilder whereStr = new StringBuilder(" where 1=1 ");
        whereStr.append(" AND referenceTableName = 'web_xproject_problem_processing_river_patrol_report'");
        whereStr.append(" AND referenceId = '" + patrolReportId + "'");
        paramMap.put("where", whereStr.toString());
        cn.hutool.json.JSONArray fileIds = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_report_files", paramMap);

        return R.ok().put("data", fileIds);

    }

    /**
     * 根据巡河ID获取轨迹数据
     *
     * @return
     * @author ZhangGQ 2019年4月29日11:19:51
     */
    @RequestMapping("/getPatrolTrackList")
    @ResponseBody
    public R getPatrolTrackList(String patrolId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        StringBuilder whereStr = new StringBuilder(" where 1=1 ");
        whereStr.append(" AND patrolId = '" + patrolId + "'");
        paramMap.put("where", whereStr.toString());
        cn.hutool.json.JSONArray fileIds = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "patrol_tracks", paramMap);

        return R.ok().put("data", fileIds);

    }


    /**
     * @param mn
     * @param hours
     * @param polluteCode
     * @return Map<String, Object>
     * @throws
     * @Title: getTrendChart
     * @Description: 水环境服务，点击地图上检测站点弹出框的数据分析echarts
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:12:53
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:12:53
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getTrendChart")
    @ResponseBody
    public Map<String, Object> getTrendChart(String mn, Integer hours, String polluteCode) {
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis = new ArrayList<String>();
        Map<String, Object> timeMap = new HashMap<String, Object>();
        if ("W01019".equals(polluteCode) || "W21003".equals(polluteCode) || "W21011".equals(polluteCode)
                || "W21001".equals(polluteCode)) {
            timeMap = DateUtil.getSomeHours(hours, 4);
        } else {
            timeMap = DateUtil.getSomeHours(hours, 1);
        }

        String startTime = timeMap.get("startTime").toString();
        String endTime = timeMap.get("endTime").toString();
        xAxis = (List<String>) timeMap.get("xList");
        Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        String[] mns = mn.split(",");
        String mnStr = "'" + StringUtils.join(mns, "','") + "'";

        String sqlString = "select POINT_CODE,POINT_NAME,to_char(DATATIME,'yyyy-mm-dd hh24') as DATATIME,CODE_POLLUTE,"
                + "DATAVALUE from WT_CITY_HOUR_DATA where POINT_CODE in (" + mnStr + ") and UPPER(CODE_POLLUTE) ='"
                + polluteCode + "' and DATATIME>=TO_DATE( '" + startTime + "','yyyy-mm-dd hh24:mi:ss')"
                + " and DATATIME<=TO_DATE('" + endTime + "', 'yyyy-mm-dd hh24:mi:ss') order by POINT_CODE,DATATIME asc";
        List<Object[]> list = simpleDao.createNativeQuery(sqlString).getResultList();

        Map<String, Object[]> series = new HashMap<String, Object[]>();
        Map<String, String> keyMap = new HashMap<String, String>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                keyMap.put(obj[0].toString(), obj[1].toString());
                if (series.containsKey(obj[0].toString())) {
                    if (indexmap.get(obj[2]) != null) {
                        if ("".equals(StringUtils.nullToString(obj[4]))) {
                            series.get(obj[0].toString())[indexmap.get(obj[2])] = "";
                        } else {
                            series.get(obj[0].toString())[indexmap.get(obj[2])] = new BigDecimal(obj[4].toString());
                        }
                    }
                } else {
                    if (indexmap.get(obj[2]) != null) {
                        Object[] tempList = new Object[indexmap.size()];
                        if ("".equals(StringUtils.nullToString(obj[4]))) {
                            tempList[indexmap.get(obj[2])] = "";
                        } else {
                            tempList[indexmap.get(obj[2])] = new BigDecimal(obj[4].toString());
                        }
                        series.put(obj[0].toString(), tempList);
                    }
                }
            }
        }
        List<String> legendList = new ArrayList<String>();
        JSONArray xArray = new JSONArray();
        result.put("xAxis", xAxis);
        String[] colors = {"#f74e4e", "#9f5be4", "#2b6ee9", "#138f30"};
        int i = 0;
        for (Object key : series.keySet()) {
            legendList.add(keyMap.get(key));
            JSONObject xObject = new JSONObject();
            xObject.put("data", series.get(key));
            xObject.put("type", "line");
            if (i < 4) {
                xObject.put("itemStyle", JSONObject.parse("{normal:{color:'" + colors[i] + "'}}"));
            }
            i++;
            if (!mns[0].equals(key)) {
                xObject.put("symbol", "circle");
            }
            xObject.put("symbolSize", 8);
            xObject.put("name", keyMap.get(key));
            xArray.add(xObject);
        }
        result.put("legend", legendList);
        //result.put("series", xArray);
        result.putAll(WaterSeriesUtil.getSeriesData(xArray, polluteCode));
        return result;
    }

    /**
     * @param peId
     * @return R
     * @throws
     * @Title: getOutfallInfo
     * @Description: //获取排口详细信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:48:30
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:48:30
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getOutfallInfo")
    @ResponseBody
    public R getOutfallInfo(String peId) {
        List<Object[]> list = simpleDao.createNativeQuery(
                "select p.POS_,e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.ADDRESS,e.ENV_PRINCIPAL,e.TEL,p.cameraid, p.OUTPUT_ID " +
                        "from PE_MONITOR_POINT p inner join PE_ENTERPRISE_DATA e"
                        + " on p.PE_ID=e.PE_ID where p.OUTFALL_TYPE=1 AND p.PE_ID=?",
                peId).getResultList();

        Map<String, Object> map = new HashMap<String, Object>();
        String outputId = null;
        for (Object[] objects : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("pos", StringUtils.nullToString(objects[0]));
            jsonObject.put("name", StringUtils.nullToString(objects[1]));
            jsonObject.put("lng", StringUtils.nullToString(objects[2]));
            jsonObject.put("lat", StringUtils.nullToString(objects[3]));
            jsonObject.put("address", StringUtils.nullToString(objects[4]));
            jsonObject.put("principal", StringUtils.nullToString(objects[5]));
            jsonObject.put("tel", StringUtils.nullToString(objects[6]));
            jsonObject.put("cameraid", StringUtils.nullToString(objects[7]));
            map.put("data", jsonObject);
            outputId = StringUtils.nullToString(objects[8]);
        }

        Future dayData = peHourFluxService.getDaySumFlux(outputId);

        Future monthData = peHourFluxService.getMonthSumFlux(outputId);

        Future yearData = peHourFluxService.getYearSumFlux(outputId);
        try {
            while (true){
                if(dayData.isDone()&&yearData.isDone()&&monthData.isDone()){
                    map.put("dayData", dayData.get());
                    map.put("yearData", yearData.get());
                    map.put("monthData", monthData.get());
                    break;
                }
                Thread.sleep(100);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
        return R.ok(map);
    }

    /**
     * @param mn
     * @return R
     * @throws
     * @Title: getFactorCounts
     * @Description: //近一年各因子超标次数
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:49:52
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:49:52
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getFactorCount")
    @ResponseBody
    public R getFactorCounts(String mn) {
        Calendar curr = Calendar.getInstance();
        curr.set(Calendar.YEAR, curr.get(Calendar.YEAR) - 1);
        String startTime = DateUtil.getTime(curr.getTime());
        String endTime = DateUtil.getTime();
        String sqlWhere = " and mn ='" + mn + "' and DATATIME > TO_DATE('" + startTime
                + "', 'yyyy-mm-dd hh24:mi:ss') and DATATIME < TO_DATE('" + endTime + "', 'yyyy-mm-dd hh24:mi:ss')";
        List<Object[]> list = simpleDao.createNativeQuery(
                "select 'PH值' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W01001%' "
                        + sqlWhere + " union all\r\n"
                        + " select '溶解氧' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W01009%' "
                        + sqlWhere + " union all\r\n"
                        + " select '高锰酸盐指数' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W01019%' "
                        + sqlWhere + " union all\r\n"
                        + " select '化学需氧量' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W01018%' "
                        + sqlWhere + " union all\r\n"
                        + " select '五日生化需氧量' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W01017%' "
                        + sqlWhere + " union all\r\n"
                        + " select '氨氮（NH3-N）' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W21003%' "
                        + sqlWhere + " union all\r\n"
                        + " select '总磷' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W21011%' "
                        + sqlWhere + " union all\r\n"
                        + " select '总氮' as name ,count(*) from WT_MN_HOUR_REPORT a  where dbms_lob.substr(a.EXCESSFACTORSTR) like '%W21001%' "
                        + sqlWhere)
                .getResultList();

        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray names = new JSONArray();
        JSONArray values = new JSONArray();
        for (Object[] objects : list) {
            names.add(objects[0]);
            values.add(objects[1]);
        }
        map.put("names", names);
        map.put("values", values);
        return R.ok(map);
    }

    /**
     * @param pointCode
     * @param monitorTime
     * @return R
     * @throws
     * @Title: getOtherPollute
     * @Description: 获取不参与计算的因子 (W01010水温，W01014电导率，W01003浊度)
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:11:40
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:11:40
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPolluteList")
    @ResponseBody
    public R getOtherPollute(String pointCode, String monitorTime) {
        if (StringUtils.isNull(monitorTime)) {
            return R.ok();
        } else {
            String pollute = "'W01001','W01009','W01019','W21003','W21011','W21001','W01010','W01014','W01003'";
            String sql = "SELECT CODE_POLLUTE,PARAMNAME,TO_CHAR(DATAVALUE) FROM WT_CITY_HOUR_DATA"
                    + " WHERE UPPER(CODE_POLLUTE) in (" + pollute + ") AND POINT_CODE = '" + pointCode + "'"
                    + " AND datatime =TO_DATE('" + monitorTime + "','yyyy-mm-dd hh24:mi:ss')";
            List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
            Map<String, Object> map = new HashMap<String, Object>();
            JSONArray ary = new JSONArray();
            for (Object[] objects : list) {
                JSONObject obj = new JSONObject();
                obj.put("code", objects[0]);
                obj.put("name", objects[1]);
                if ("".equals(StringUtils.nullToString(objects[2]))) {
                    obj.put("value", "-");
                } else {
                    obj.put("value", new BigDecimal(objects[2].toString()));
                }
                ary.add(obj);
            }
            map.put("data", ary);
            return R.ok(map);
        }
    }

    /**
     * @return R
     * @throws
     * @Title: getBasinMonitor
     * @Description: 获取小流域站点信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:11:27
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:11:27
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getBasinMonitor")
    @ResponseBody
    public R getBasinMonitor() {
        String sql = "select a.monitor_code,a.monitor_name,a.longitude,a.latitude,b.PH_VALUE,b.PH_LEVEL,b.RJY_VALUE,"
                + "b.RJY_LEVEL,GMSY_VALUE,b.GMSY_LEVEL,b.BOD_VALUE,b.BOD_LEVEL,b.ZL_VALUE,b.ZL_LEVEL,b.ANDAN_VALUE,"
                + "b.ANDAN_LEVEL,b.TARGET_QUALITY,b.RESULT_QUALITY,a.lines,b.YEAR_NUMBER,b.MONTH_NUMBER,a.analysis"
                + " from wt_basin_monitor a inner join ("
                + "select t.*,row_number() over(partition by basin_code order by year_number desc,month_number desc)"
                + " as rn from wt_basin_month_data t) b on a.monitor_code = b.basin_code and b.rn=1 and a.county like '%漳浦%'"
                + " order by a.monitor_code";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("code", StringUtils.nullToString(objects[0]));
            json.put("name", StringUtils.nullToString(objects[1]));
            json.put("lng", StringUtils.nullToString(objects[2]));
            json.put("lat", StringUtils.nullToString(objects[3]));
            json.put("phValue", StringUtils.nullToString(objects[4]));
            json.put("phLevel", WaterQualityEnum.valueOf(objects[5] == null ? "NONE" : objects[5].toString()).getKey());
            json.put("rjyValue", StringUtils.nullToString(objects[6]));
            json.put("rjyLevel", WaterQualityEnum.valueOf(objects[7] == null ? "NONE" : objects[7].toString()).getKey());
            json.put("gmsyValue", StringUtils.nullToString(objects[8]));
            json.put("gmsyLevel", WaterQualityEnum.valueOf(objects[9] == null ? "NONE" : objects[9].toString()).getKey());
            json.put("bodValue", StringUtils.nullToString(objects[10]));
            json.put("bodLevel", WaterQualityEnum.valueOf(objects[11] == null ? "NONE" : objects[11].toString()).getKey());
            json.put("zlValue", StringUtils.nullToString(objects[12]));
            json.put("zlLevel", WaterQualityEnum.valueOf(objects[13] == null ? "NONE" : objects[13].toString()).getKey());
            json.put("andanValue", StringUtils.nullToString(objects[14]));
            json.put("andanLevel", WaterQualityEnum.valueOf(objects[15] == null ? "NONE" : objects[15].toString()).getKey());
            json.put("targetQuality", WaterQualityEnum.valueOf(objects[16] == null ? "NONE" : objects[16].toString()).getKey());
            json.put("resultQuality", WaterQualityEnum.valueOf(objects[17] == null ? "NONE" : objects[17].toString()).getKey());
            if (StringUtils.isNull(StringUtils.nullToString(objects[18]))) {
                json.put("lines", "");
            } else {
                json.put("lines", StringUtils.ClobToString((Clob) objects[18]));
            }
            json.put("yearNumber", objects[19].toString());
            json.put("monthNumber", objects[20].toString());
            if (StringUtils.isNull(StringUtils.nullToString(objects[21]))) {
                json.put("analysis", "");
            } else {
                json.put("analysis", StringUtils.ClobToString((Clob) objects[21]));
            }
            jsonAry.add(json);
        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param page
     * @param rows
     * @param monitorName
     * @param request
     * @return PageEU<?>
     * @throws
     * @Title: getBasinMonitorList
     * @Description: 获取小流域站点信息列表
     * @CreateBy: chenbingke
     * @CreateTime: 2019年6月12日 下午5:38:03
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年6月12日 下午5:38:03
     */
    @RequestMapping("/getBasinMonitorList")
    @ResponseBody
    public PageEU<?> getBasinMonitorList(@RequestParam(value = "page", required = false) Integer page,
                                         @RequestParam(value = "rows", required = false) Integer rows,
                                         @RequestParam(value = "monitorName", required = false) String monitorName, HttpServletRequest request) {

        Page<?> dataPage = new Page<>();
        if (page != null) {
            dataPage.setCurrentPage(page - 1);
        }
        if (rows != null) {
            dataPage.setLimit(rows);
        }

        String sql = "select a.monitor_code code,a.monitor_name name,a.longitude lng,a.latitude lat,b.PH_VALUE,b.PH_LEVEL,b.RJY_VALUE,"
                + "b.RJY_LEVEL,GMSY_VALUE,b.GMSY_LEVEL,b.BOD_VALUE,b.BOD_LEVEL,b.ZL_VALUE,b.ZL_LEVEL,b.ANDAN_VALUE,"
                + "b.ANDAN_LEVEL,b.TARGET_QUALITY,b.RESULT_QUALITY,a.lines,b.YEAR_NUMBER,b.MONTH_NUMBER,a.analysis"
                + " from wt_basin_monitor a inner join ("
                + "select t.*,row_number() over(partition by basin_code order by year_number desc,month_number desc)"
                + " as rn from wt_basin_month_data t) b on a.monitor_code = b.basin_code and b.rn=1 and a.COUNTY like '%漳浦%'";
        if (!StringUtils.isNull(monitorName)) {
            sql += " where a.monitor_name like '%" + monitorName + "%'";
        }
        sql += " order by a.monitor_code";

        simpleDao.listNativeByPage(sql, dataPage);
        List<?> result = dataPage.getResult();
        String val = "";
        for (Object o : result) {
            Map map = (Map) o;
            val = MapUtils.getString(map, "targetQuality", "");
            map.put("targetQuality", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "resultQuality", "");
            map.put("resultQuality", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "phLevel", "");
            map.put("phLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "rjyLevel", "");
            map.put("rjyLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "gmsyLevel", "");
            map.put("gmsyLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "bodLevel", "");
            map.put("bodLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "zlLevel", "");
            map.put("zlLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
            val = MapUtils.getString(map, "andanLevel", "");
            map.put("andanLevel", WaterQualityEnum.valueOf(val == null ? "NONE" : val).getKey());
        }

        return new PageEU<>(dataPage);
    }

    /**
     * @param monitorName
     * @return R
     * @throws
     * @Title: getOtherBasinMonitorInfo
     * @Description: 获取小流域站点信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:11:15
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:11:15
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getOtherBasinMonitorInfo")
    @ResponseBody
    public R getOtherBasinMonitorInfo(String monitorName) {
        String sql = "select RIVER,BASIN,BASIN_AREA,INSIDE_BASIN_AREA,RIVER_LENGTH,INSIDE_RIVER_LENGTH,AVERAGE_FLOW,SLOPE_RATIO,BASIN_SHAPE_COEFFICIENT"
                + " from wt_basin_monitor where MONITOR_NAME = '" + monitorName + "'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONObject json = new JSONObject();
        for (Object[] objects : list) {
            json.put("river", StringUtils.nullToString(objects[0]));
            json.put("basin", StringUtils.nullToString(objects[1]));
            json.put("basinArea", StringUtils.nullToString(objects[2]));
            json.put("insideBasinArea", StringUtils.nullToString(objects[3]));
            json.put("riverLength", StringUtils.nullToString(objects[4]));
            json.put("insideRiverLength", StringUtils.nullToString(objects[5]));
            json.put("flow", StringUtils.nullToString(objects[6]));
            json.put("slopeRatio", StringUtils.nullToString(objects[7]));
            json.put("basinShapeCoefficient", StringUtils.nullToString(objects[8]));
        }
        map.put("data", json);
        return R.ok(map);
    }

    /**
     * @return R
     * @throws
     * @Title: getPolluteWaterData
     * @Description: 污普废水企业
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:11:01
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:11:01
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPolluteWaterData")
    @ResponseBody
    public R getPolluteWaterData() {
        String sql = "SELECT DISTINCT A.QYMC,A.LONGITUDE,A.LATITUDE,b.VIDEO,b.PICTURE,b.PICNAME,b.VEDIONAME FROM POLLUTION_WATER_DATA A LEFT JOIN FILE_ATTACHMENT B ON A.QYMC = B.PKID WHERE LONGITUDE IS NOT NULL";
        sql+=" and a.qx like '%漳浦%'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("qymc", StringUtils.nullToString(objects[0]));
            json.put("longitude", StringUtils.nullToString(objects[1]));
            json.put("latitude", StringUtils.nullToString(objects[2]));
            json.put("video", StringUtils.nullToString(objects[3]));
            json.put("picture", StringUtils.nullToString(objects[4]));
            jsonAry.add(json);
        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param qymc
     * @return R
     * @throws
     * @Title: getPolluteWaterDataDetail
     * @Description: 污普废水企业
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:10:28
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:10:28
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPolluteWaterDataDetail")
    @ResponseBody
    public R getPolluteWaterDataDetail(String qymc) {
        String sql = "SELECT LXR,QX,DS,LXDH,WRWNAME,PFL,ADDRESS, en.CAMERAID " +
                "FROM POLLUTION_WATER_DATA d left join POLLUTION_ENTERPRISE_INFO en on en.ENTERNAME=d.QYMC "
                + " WHERE (d.QYMC,d.YEAR) in (SELECT QYMC,MAX(YEAR) FROM POLLUTION_WATER_DATA GROUP BY QYMC)"
                + " and QYMC = '" + qymc + "' and qx like '%漳浦%'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("lxr", StringUtils.nullToString(objects[0]));
            json.put("qx", StringUtils.nullToString(objects[1]));
            json.put("ds", StringUtils.nullToString(objects[2]));
            json.put("lxdh", StringUtils.nullToString(objects[3]));
            json.put("wrw", StringUtils.nullToString(objects[4]));
            json.put("pfl", StringUtils.nullToString(objects[5]));
            json.put("address", StringUtils.nullToString(objects[6]));
            json.put("cameraid", StringUtils.nullToString(objects[7]));
            jsonAry.add(json);
        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param uuid
     * @return R
     * @throws
     * @Title: getPolicyInfo
     * @Description: 流域信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:10:46
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:10:46
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getPolicyInfo")
    @ResponseBody
    public R getPolicyInfo(String uuid) {
        String sql = "select name,remark,analysis from wt_policy where uuid='" + uuid + "'";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray jsonAry = new JSONArray();
        for (Object[] objects : list) {
            JSONObject json = new JSONObject();
            json.put("name", objects[0]);
            json.put("remark", StringUtils.ClobToString((Clob) objects[1]));
            json.put("analysis", StringUtils.ClobToString((Clob) objects[2]));
            jsonAry.add(json);
        }
        map.put("data", jsonAry);
        return R.ok(map);
    }

    /**
     * @param page
     * @param rows
     * @param name
     * @param request
     * @return PageEU<WtPolicy>
     * @throws
     * @Title: getWpfsqyList
     * @Description: 污普废水企业
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:54:28
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:54:28
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping("getWpfsqyList")
    @ResponseBody
    public PageEU<WtPolicy> getWpfsqyList(@RequestParam(value = "page", required = false) Integer page,
                                          @RequestParam(value = "rows", required = false) Integer rows,
                                          @RequestParam(value = "name", required = false) String name, HttpServletRequest request) {

        Page dataPage = new Page<>();
        if (page != null) {
            dataPage.setCurrentPage(page - 1);
        }
        if (rows != null) {
            dataPage.setLimit(rows);
        }
        String sqlStr = "SELECT DISTINCT A.QYMC,A.LONGITUDE,A.LATITUDE,B.* FROM POLLUTION_WATER_DATA A LEFT JOIN FILE_ATTACHMENT B ON A.QYMC = B.PKID WHERE LONGITUDE IS NOT NULL ";
                sqlStr+=" and a.qx like '%漳浦%'";
        if (StringUtils.isNotEmpty(name)) {
            sqlStr += " and QYMC like '%" + name + "%' ";
        }
        sqlStr += " order by QYMC DESC";
        simpleDao.listNativeByPage(sqlStr, dataPage);
        return new PageEU<>(dataPage);
    }

    /**
     * 获取废水企业附件列表
     *
     * @param name
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getFileAttachPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getFileAttachPage(String name, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sb = new StringBuilder("SELECT DISTINCT A.QYMC,B.* FROM POLLUTION_WATER_DATA A ");
        sb.append(" LEFT JOIN FILE_ATTACHMENT B ON A.QYMC = B.PKID ");
        sb.append("  and B.SOURCE = ").append(SqlUtil.toSqlStr("wastewater"));
        sb.append("  WHERE a.qx = '漳浦县' ");
        if (StringUtils.isNotEmpty(name)) {
            sb.append("  and  a.qymc like '%").append(name.trim()).append("%'");
        }
        simpleDao.listNativeByPage(sb.toString(), page);
        return new PageEU<>(page);
    }

    /**
     * 获取污水处理厂附件列表
     * @param name
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getwastewaterPlantFileAttachPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getwastewaterPlantFileAttachPage(String name, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sb = new StringBuilder("select DISTINCT e.PE_NAME qymc, f.* from PE_MONITOR_POINT p ");
        sb.append("inner join PE_ENTERPRISE_DATA e on p.PE_ID = e.PE_ID left join FILE_ATTACHMENT f on e.PE_NAME = f.PKID ");
        sb.append("  and f.SOURCE = ").append(SqlUtil.toSqlStr("wastewaterPlant"));
        sb.append("  WHERE e.QX like '%漳浦%'  AND e.pe_type = 'peType1' ");
        if (StringUtils.isNotEmpty(name)) {
            sb.append(" and e.PE_NAME like '%").append(name.trim()).append("%'");
        }
        simpleDao.listNativeByPage(sb.toString(), page);
        return new PageEU<>(page);
    }


    /**
     * @return JSONArray
     * @throws
     * @Title: getPointList
     * @Description: 获取站点信息
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午1:55:07
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午1:55:07
     */
    @RequestMapping("/getPointList")
    @ResponseBody
    public JSONArray getPointList() {
        List<WtMnPoint> list = simpleDao.find("from WtMnPoint where status=1 and mc like '%漳浦%' order by mn asc");
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray array = new JSONArray();
            for (WtMnPoint point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point.getMn());
                temp.put("text", point.getMnname());
                array.add(temp);
            }
            return array;
        }
        return new JSONArray();
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: getPageList
     * @Description: 数据服务国家水表格数据
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午1:55:32
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午1:55:32
     */
    @RequestMapping("/getPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getPageList(WtMnHourDataParam param, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtHourDataPage = wtMnHourDataService.getPageList(param, page);
        return new PageEU<>(wtHourDataPage);
    }

    /**
     * @param param
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getPassYearAnalysis
     * @Description: 数据服务-国家水质环比
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午2:09:12
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午2:09:12
     */
    @RequestMapping("/getPassYearAnalysis")
    @ResponseBody
    public Map<String, Object> getPassYearAnalysis(WtMnHourDataParam param) throws ParseException {
        return wtMnHourDataService.getPassYearAnalysis(param);
    }

    /**
     * @return R
     * @throws
     * @Title: getReservoirPoints
     * @Description: 水库点位
     * @CreateBy:
     * @CreateTime: 2019年5月9日 下午2:09:39
     * @UpdateBy:
     * @UpdateTime: 2019年5月9日 下午2:09:39
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getReservoirPoints")
    @ResponseBody
    public R getReservoirPoints() {
        String sql = "SELECT max(p.EQP_ID),D.NAME AS ,D.MAX_WATER_LEVEL AS ,D.MIN_WATER_LEVEL AS ,D.ADDR AS ,D.LONGITUDE AS ,D.LATITUDE as "
                + "FROM HYD_POSITION_INFO P " + "INNER JOIN HYD_DEV_INFO D ON P.HYDROPOWER_ID=D.HYDROPOWER_ID "
                + "WHERE P.IS_USED='1' and D.LONGITUDE is not null and D.LATITUDE is not null "
                + "group by P.HYDROPOWER_ID,D.NAME,D.MAX_WATER_LEVEL,D.MIN_WATER_LEVEL,D.ADDR,D.LONGITUDE,D.LATITUDE";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        JSONArray jsonArray = new JSONArray();
        for (Object[] objects : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("eqpID", StringUtils.nullToString(objects[0]));
            jsonObject.put("name", StringUtils.nullToString(objects[1]));

            jsonObject.put("address", StringUtils.nullToString(objects[4]));
            jsonObject.put("lng", StringUtils.nullToString(objects[5]));
            jsonObject.put("lat", StringUtils.nullToString(objects[6]));
            jsonArray.add(jsonObject);
        }
        return R.ok().put("data", jsonArray);

    }

    /**
     * @param page
     * @param rows
     * @param name
     * @param request
     * @return PageEU<?>
     * @throws
     * @Title: getReservoirPointsList
     * @Description: 水库信息列表
     * @CreateBy: chenbingke
     * @CreateTime: 2019年6月12日 下午4:36:32
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年6月12日 下午4:36:32
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getReservoirPointsList")
    @ResponseBody
    public PageEU<?> getReservoirPointsList(@RequestParam(value = "page", required = false) Integer page,
                                            @RequestParam(value = "rows", required = false) Integer rows,
                                            @RequestParam(value = "name", required = false) String name, HttpServletRequest request) {

        Page dataPage = new Page<>();
        if (page != null) {
            dataPage.setCurrentPage(page - 1);
        }
        if (rows != null) {
            dataPage.setLimit(rows);
        }

        String sql = "SELECT max(p.EQP_ID) EQP_ID, D.NAME, D.MAX_WATER_LEVEL, D.MIN_WATER_LEVEL, D.ADDR, D.LONGITUDE, D.LATITUDE"
                + " FROM HYD_POSITION_INFO P INNER JOIN HYD_DEV_INFO D ON P.HYDROPOWER_ID=D.HYDROPOWER_ID "
                + " WHERE P.IS_USED='1' and D.LONGITUDE is not null and D.LATITUDE is not null ";
        if (!StringUtils.isNull(name)) {
            sql += "and D.NAME like '%" + name + "%'";
        }
        sql += "group by P.HYDROPOWER_ID,D.NAME,D.MAX_WATER_LEVEL,D.MIN_WATER_LEVEL,D.ADDR,D.LONGITUDE,D.LATITUDE";
        simpleDao.listNativeByPage(sql, dataPage);
        return new PageEU<>(dataPage);
    }

    /**
     * @param eqpID
     * @return R
     * @throws
     * @Title: getReservoirInfo
     * @Description: 水库详细信息
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午2:10:04
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午2:10:04
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/getReservoirInfo")
    @ResponseBody
    public R getReservoirInfo(String eqpID) {
        String sql = "SELECT D.NAME  ,D.NORMAL_WATER_LEVEL ,D.MAX_WATER_LEVEL ,D.MIN_WATER_LEVEL "
                + ",D.ADDR ,D.LONGITUDE ,D.LATITUDE n " + "FROM HYD_POSITION_INFO P "
                + "INNER JOIN HYD_DEV_INFO D ON P.HYDROPOWER_ID=D.HYDROPOWER_ID "
                + "WHERE P.IS_USED='1' and p.EQP_ID = ? AND D.LONGITUDE is not null and D.LATITUDE is not null "
                + "group by P.HYDROPOWER_ID,D.NAME,D.NORMAL_WATER_LEVEL,D.MAX_WATER_LEVEL,D.MIN_WATER_LEVEL,D.ADDR,D.LONGITUDE,D.LATITUDE";
        List<Object[]> list = simpleDao.createNativeQuery(sql, eqpID).getResultList();
        Map<String, Object> map = new HashMap<String, Object>();
        for (Object[] objects : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", StringUtils.nullToString(objects[0]));
            jsonObject.put("normal", StringUtils.nullToString(objects[1]));
            jsonObject.put("max", StringUtils.nullToString(objects[2]));
            jsonObject.put("min", StringUtils.nullToString(objects[3]));
            jsonObject.put("address", StringUtils.nullToString(objects[4]));
            jsonObject.put("lng", StringUtils.nullToString(objects[5]));
            jsonObject.put("lat", StringUtils.nullToString(objects[6]));

            map.put("data", jsonObject);
        }
        return R.ok(map);
    }

    /**
     * @param name
     * @param polluteCode
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getBasinYearAnalysis
     * @Description: 水环境服务-小流域-环比分析
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午1:56:56
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午1:56:56
     */
    @RequestMapping("/getBasinYearAnalysis")
    @ResponseBody
    public Map<String, Object> getBasinYearAnalysis(String name, String polluteCode) throws ParseException {
        return wtMnHourDataService.getBasinYearAnalysis(name, polluteCode);
    }

    /**
     * @param name
     * @param polluteCode
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getBasinYearAnalysis_tb
     * @Description: 水环境服务-小流域-同比
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午1:57:01
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午1:57:01
     */
    @RequestMapping("/getBasinYearAnalysis_tb")
    @ResponseBody
    public Map<String, Object> getBasinYearAnalysisTb(String name, String polluteCode) throws ParseException {
        return wtMnHourDataService.getBasinYearAnalysisTb(name, polluteCode);
    }

    /**
     * @param name
     * @param thisYear
     * @param lastYear
     * @param polluteCode
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getBasinYearAnalysis_njdb
     * @Description: 水环境服务-小流域-年均对比
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午1:57:04
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午1:57:04
     */
    @RequestMapping("/getBasinYearAnalysis_njdb")
    @ResponseBody
    public Map<String, Object> getBasinYearAnalysisNjdb(String name, int thisYear, int lastYear, String polluteCode)
            throws ParseException {
        return wtMnHourDataService.getBasinYearAnalysisNjdb(name, thisYear, lastYear, polluteCode);
    }


    /**
     * 获取废水企业信息分页
     * @param name
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/getWasteCompanyInfoPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getWasteCompanyInfoPage(String name, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sb = new StringBuilder(" SELECT * FROM POLLUTION_WATER_DATA A WHERE a.qx = '漳浦县' ");
        if (StringUtils.isNotEmpty(name)) {
            sb.append("  and  a.qymc like '%").append(name.trim()).append("%'");
        }
        simpleDao.listNativeByPage(sb.toString(), page);
        return new PageEU<>(page);
    }

    /**
     * 新增修改废水企业信息
     *
     * @param pollutionWaterData 污水企业对象
     * @return
     */
    @RequestMapping(value = "/saveWasteCompanyInfo")
    @ResponseBody
    public R saveCompanyInfo(PollutionWaterData pollutionWaterData) {
        try {
            StringBuilder checkSql = new StringBuilder(" select count(1) from POLLUTION_WATER_DATA  ");
            checkSql.append(" WHERE QYMC = ? AND  WRWNAME=? AND YEAR = ? AND PFL = ? ");
            List resultList = simpleDao.createNativeQuery(checkSql.toString(), pollutionWaterData.getQymc(), pollutionWaterData.getWrwname()
                    , pollutionWaterData.getYear(), pollutionWaterData.getPfl()).getResultList();
            if (ToolUtil.isNotEmpty(resultList) && !"0".equals(resultList.get(0).toString())) {
                return R.error("已存在相同企业名称，年度，污染物名称，排放量相同的数据！");
            }

            wtMnHourDataService.addWasteCompanyInfo(pollutionWaterData);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }


    /**
     * 修改废水企业信息
     * @param pollutionWaterData
     * @return
     */
    @RequestMapping(value = "/updateWastCompanyInfo")
    @ResponseBody
    public R updateWastCompanyInfo(PollutionWaterData pollutionWaterData) {
        try {

            wtMnHourDataService.updateWastCompanyInfo(pollutionWaterData);
            return R.ok();
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }

    /**
     * 删除废水企业信息
     *
     * @param qymc    企业名称
     * @param wrwname 污染物名称
     * @param year    年度
     * @param pfl     排放量
     * @return
     */
    @RequestMapping(value = "/deleteWasteCompanyInfo")
    @ResponseBody
    public R deleteWasteCompanyInfo(String qymc, String wrwname, String year, String pfl) {
        try {
            wtMnHourDataService.deleteWasteCompanyInfo(qymc,wrwname,year,pfl);
            return R.ok();
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }
//=============================漳浦数据汇聚平台===============================
    //污染源数据统计;
}
