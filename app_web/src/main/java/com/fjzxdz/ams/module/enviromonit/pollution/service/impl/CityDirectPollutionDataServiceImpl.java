package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.PollutionInfoCountyEnum;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.CityDirectPollutionDataDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.CityDirectPollutionData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.CityDirectPollutionDataService;
import com.fjzxdz.ams.util.PreceedPointInAreaUtil;
import com.fjzxdz.ams.util.ValidatorUtil;
import com.google.common.collect.Maps;
import org.apache.commons.collections.MapUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;
import java.util.regex.Pattern;

/**
 * @version 1.0
 * @Author lianhuinan
 * @Description //TODO(PollutionInfoService接口实现类)
 * @Date 2019/9/11 0011 17:00
 **/
@Service
@Transactional(rollbackFor = Exception.class)
public class CityDirectPollutionDataServiceImpl implements CityDirectPollutionDataService {

    private static Logger logger = LogManager.getLogger(CityDirectPollutionDataServiceImpl.class);

    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private CityDirectPollutionDataDao cityDirectPollutionDataDao;

    @Async
    @Override
    public Future<JSONArray> getIndustrialWasteWaterEnterpriseCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx,count(QYMC) count from (SELECT DISTINCT A.QYMC,A.LONGITUDE,A.LATITUDE,a.QX " +
                "FROM POLLUTION_WATER_DATA A WHERE LONGITUDE IS NOT NULL) group by qx");

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getAirConstructionSiteCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx,count(name) count from (SELECT DISTINCT A.name,A.LONGITUDE,A.LATITUDE,a.QX " +
                "FROM AIR_CONSTRUCTION_SITE A WHERE LONGITUDE IS NOT NULL) group by qx");

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getReservoirCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx, count(1) count\n" +
                "from (SELECT DISTINCT d.UP_RESERVOIR, d.LONGITUDE, d.LATITUDE, d.RGN_NAME qx FROM HYD_POSITION_INFO P INNER JOIN HYD_DEV_INFO D ON P.HYDROPOWER_ID=D.HYDROPOWER_ID WHERE LONGITUDE IS NOT NULL)\n" +
                "where qx is not null\n" +
                "group by qx");
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getBasinMonitorCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx, COUNT(MONITOR_NAME) count from (select  a.COUNTY qx, a.*  from wt_basin_monitor a where a.LONGITUDE is not null and a.COUNTY is not null )\n" +
                "    group by qx");
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getConventionalVentingCountQX(String type) {
        String typeStr = "<>";
        if (StringUtils.equals(type, "peType1")) {
            typeStr = "=";
        }
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx, COUNT(PE_NAME) count from (select distinct\n" +
                "                e.PE_NAME,\n" +
                "                e.LONG_VALUE,\n" +
                "                e.LAT_VALUE,\n" +
                "                e.QX qx\n" +
                "from PE_MONITOR_POINT p\n" +
                "         inner join PE_ENTERPRISE_DATA e on p.PE_ID = e.PE_ID\n" +
                "where p.OUTFALL_TYPE = 1\n" +
                "  AND e.LONG_VALUE IS NOT NULL\n" +
                "  AND e.LAT_VALUE IS NOT NULL AND e.pe_type " + typeStr + " 'peType1')\n" +
                "    group by qx");
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getExhaustGasOutletCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx, COUNT(PE_NAME) count from (select distinct e.PE_NAME, e.LONG_VALUE, e.LAT_VALUE, e.PE_NAME name, e.QX qx " +
                "from PE_ENTERPRISE_DATA e inner  join  PE_MONITOR_POINT p on e.PE_ID=p.PE_ID where p.OUTFALL_TYPE=2 AND e.LONG_VALUE IS NOT NULL) group by qx\n");
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> countPollutionByArea(List deptName, String wrylx, String wryzl) {
        StringBuilder countys = new StringBuilder();
        for (PollutionInfoCountyEnum countyEnum : PollutionInfoCountyEnum.values()) {
            countys.append(countyEnum.getKey()).append(",");
        }
        countys.deleteCharAt(countys.length() - 1);

        StringBuilder sql = new StringBuilder(" select qx, count(1) count from(select distinct p.mc name,p.qx,p.wrylx,p.wryzl,p.jd,p.wd,p.mc,p.czwt,p.zgcs,p.zlxm,")
                .append("p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,")
                .append("p.dz,p.jwd,p.bz from CITY_DIRECT_POLLUTION_DATA p where p.wrylx='")
                .append(wryzl).append("' and p.wryzl='").append(wrylx)
                .append("' and p.jd is not null and p.wryzl is not null and p.wd is not null and p.wrylx is not null ")
                /*.append("and p.qx in(").append(SqlUtil.toSqlStr(countys.toString())).append(")")*/
                .append(" and (p.jd like '%117.%' or p.jd like '%118.0%' or p.jd like '%118.1%')) group by qx ");

        if (deptName != null) {
            sql.append(" and dw in (").append(SqlUtil.toSqlIn(deptName)).append(") ");
        }
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray jsonArray = new JSONArray(list.size());
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
//				temp.put("qx", PollutionInfoCountyEnum.valueOf(map.get("qx").toString()).getKey());
//				temp.put("count", map.get("count"));
                temp.put(map.get("qx").toString(), map.get("count"));
                jsonArray.add(temp);
            }
            return new AsyncResult<JSONArray>(jsonArray);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getIndustrialWasteAirEnterpriseCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select qx,count(QYMC) count from (SELECT DISTINCT A.QYMC,A.LONGITUDE,A.LATITUDE,a.QX " +
                "FROM POLLUTION_AIR_DATA A WHERE LONGITUDE IS NOT NULL) group by qx");

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getAutoWaterQualityMonitorStationCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select REGION_NAME qx, count(*) count from (select *  from WT_CITY_POINT WHERE status = 1 and CATEGORY=3) group by REGION_NAME");

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    @Async
    @Override
    public Future<JSONArray> getAutoAirQualityMonitorStationCountQX() {
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select REGION_NAME qx, count(*) count from (select *  " +
                "from WT_CITY_POINT WHERE status = 1 and CATEGORY=3) group by REGION_NAME");

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray result = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject temp = new JSONObject();
                temp.put(map.get("qx").toString(), map.get("count"));
                result.add(temp);
            }
            return new AsyncResult<JSONArray>(result);
        }
        return new AsyncResult<JSONArray>(new JSONArray(0));
    }

    /**
     * 保存污染源信息
     *
     * @param pollutionInfoData
     */
    @Override
    public void saveInfo(CityDirectPollutionData pollutionInfoData) {
        if (ToolUtil.isEmpty(pollutionInfoData.getUuid())) {
            pollutionInfoData.setUuid(null);
            cityDirectPollutionDataDao.save(pollutionInfoData);
        } else {
            CityDirectPollutionData temp = cityDirectPollutionDataDao.getById(pollutionInfoData.getUuid());
            BeanUtil.copyProperties(pollutionInfoData, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
            cityDirectPollutionDataDao.update(temp);
        }
    }

    /**
     * 通过主键删除污染源信息
     *
     * @param pkid
     */
    @Override
    public void deleteInfo(String pkid) {
        cityDirectPollutionDataDao.deleteById(pkid);
    }

    /**
     * 检查污染源大数据上一周是否有修改动作
     *
     * @return
     */
    @Override
    public List<Map> checkLastWeekAlreadyUpdateInfo() {
        String sql = "SELECT * FROM (\r\n" +
                "    SELECT u.uuid, u.name, u.phone, d.name AS deptName\r\n" +
                "    FROM SYS_USER u\r\n" +
                "    INNER JOIN sys_job_user ju ON u.uuid = ju.user_id \r\n" +
                "    INNER JOIN SYS_JOB j ON ju.job = j.uuid \r\n" +
                "        INNER JOIN (\r\n" +
                "            SELECT d2.*\r\n" +
                "            FROM sys_dept d1\r\n" +
                "                LEFT JOIN sys_dept d2 ON d1.uuid = d2.pid \r\n" +
                "            WHERE d1.NAME = '环保作战指挥平台数据录入'\r\n" +
                "                AND d2.ENABLE = 1\r\n" +
                "            UNION ALL\r\n" +
                "            SELECT d3.*\r\n" +
                "            FROM sys_dept d1\r\n" +
                "            LEFT JOIN sys_dept d2 ON d1.uuid = d2.pid \r\n" +
                "                LEFT JOIN sys_dept d3 ON d2.uuid = d3.pid \r\n" +
                "            WHERE d1.NAME = '环保作战指挥平台数据录入'\r\n" +
                "                AND d3.ENABLE = 1\r\n" +
                "        ) d ON d.uuid = j.dept ) A left JOIN (\r\n" +
                "        SELECT p.userid, MAX(p.userdate) updatetime\r\n" +
                "        FROM (\r\n" +
                "            SELECT decode(UPDATE_USER, NULL, CREATE_USER, UPDATE_USER) AS userid\r\n" +
                "                , decode(UPDATE_DATE, NULL, CREATE_DATE, UPDATE_DATE) AS userdate\r\n" +
                "            FROM POLLUTION_INFO_DATA\r\n" +
                "        ) p\r\n" +
                "        WHERE p.userdate >= TRUNC(SYSDATE - TO_CHAR(SYSDATE, 'D')) - 5\r\n" +
                "            AND p.userdate <= TRUNC(SYSDATE - TO_CHAR(SYSDATE, 'D') + 2)\r\n" +
                "        GROUP BY p.userid\r\n" +
                "    ) B ON A.uuid = B.userid ";
        List<Map> list = simpleDao.getNativeQueryList(sql);
        return list;
    }


    /**
     * 动态查询市直查所有单位下的污染源种类以及汇总
     *
     * @return
     */
    @Override
    public List<Map> dynamicCountCityDirectPollutionInfo() {
        StringBuilder sql = new StringBuilder("  SELECT DW,COUNT(WRYZL) COUNT FROM CITY_DIRECT_POLLUTION_DATA ");
        sql.append(" WHERE JD IS NOT NULL AND WD IS NOT NULL AND (TRIM(JD) LIKE  '117%' OR TRIM(JD) LIKE  '118.0%' OR TRIM(JD) LIKE '118.1%') AND WRYLX IS NOT NULL ");
        sql.append(" GROUP BY DW ");
        List<Map> dwList = simpleDao.getNativeQueryList(sql.toString());
        sql = new StringBuilder("  SELECT WRYZL,DW,COUNT(WRYZL) COUNT FROM CITY_DIRECT_POLLUTION_DATA ");
        sql.append(" WHERE JD IS NOT NULL AND WD IS NOT NULL AND (TRIM(JD) LIKE  '117%' OR TRIM(JD) LIKE  '118.0%' OR TRIM(JD) LIKE '118.1%') AND WRYLX IS NOT NULL ");
        sql.append(" GROUP BY WRYZL,DW ORDER BY DW ");
        List<Map> wryzlList = simpleDao.getNativeQueryList(sql.toString());
        String dw;
        String dw2;
        String dwCount;
        String wryzl;
        String wryzlCount;
        List<Map> resultList = new ArrayList<>();
        for (Map map : dwList) {
            Map dwMap = Maps.newHashMap();
            JSONArray json = new JSONArray();
            dw = MapUtils.getString(map, "dw","");
            dwCount = MapUtils.getString(map, "count","0");
            for (Map wryzlMap : wryzlList) {
                dw2 = MapUtils.getString(wryzlMap, "dw","");
                wryzl = MapUtils.getString(wryzlMap, "wryzl","");
                wryzlCount = MapUtils.getString(wryzlMap, "count","0");
                if (dw.equals(dw2)) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", wryzl);
                    temp.put(dw, dwCount);
                    temp.put(wryzl, wryzlCount);
                    json.add(temp);
                }
            }
            dwMap.put(dw, json);
            resultList.add(dwMap);
        }
        return resultList;
    }

    @Override
    public String save(List<List<Object>> result, String deptPath) throws Exception {
        List<CityDirectPollutionData> list = new ArrayList<CityDirectPollutionData>();
        String message = "";
        boolean flag = true;
        for (int i = 1; i < result.size(); i++) {
            List<Object> row = result.get(i);
            CityDirectPollutionData entity = new CityDirectPollutionData();
            entity.setDw(row.get(0).toString());
            entity.setWrylx(row.get(1).toString());
            entity.setWryzl(row.get(2).toString());
            entity.setMc(row.get(3).toString());
            entity.setCzwt(row.get(4).toString());
            entity.setZgcs(row.get(5).toString());
            entity.setZlxm(row.get(6).toString());
            entity.setWcmb201912(row.get(7).toString());
            entity.setWcmb202006(row.get(8).toString());
            entity.setWcmb202012(row.get(9).toString());
            entity.setSdzrZrdw(row.get(10).toString());
            entity.setSdzrdwZrrlxfs(row.get(11).toString());
            entity.setBmzrPhzrdw(row.get(12).toString());
            entity.setBmzrdwZrrlxfs(row.get(13).toString());
            entity.setBmzrPhzrdw(row.get(14).toString());
            entity.setPhzrdwZrrlxfs(row.get(15).toString());
            entity.setXz(row.get(16).toString());
            entity.setDz(row.get(17).toString());
            entity.setJd(row.get(18).toString());
            entity.setWd(row.get(19).toString());
            entity.setBz(row.get(20).toString());
            entity.setEntryDepartment(row.get(21).toString());
            message = patternValid(entity);
            if (message.length() != 0) {
                message = "第" + (i) + "行出现错误:（" + message + "）请修改后再导入！";
                flag = false;
                break;
            }
            entity.setDeptPath(deptPath);
            list.add(entity);
        }
        if (flag) {
            cityDirectPollutionDataDao.saveBatch(list);
        }
        return message;
    }

    /**
     * @param entity
     * @return java.lang.String
     * @Author lianhuinan
     * @Description //TODO(pollutionDataInfo实体数据验证)
     * @Date 2019/10/11 0011 11:19
     * @version 1.0
     **/
    @Override
    public String patternValid(CityDirectPollutionData entity) {
        String message = "";
        for (String str : entity.getSdzrdwZrrlxfs().replaceAll("，", ",").split(",")) {
            str = str.trim();
            if (Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")) {
                continue;
            }
            if (!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
                message += "属地责任_责任人及联系方式，手机号有误！";
            }
        }
        for (String str : entity.getBmzrdwZrrlxfs().replaceAll("，", ",").split(",")) {
            str = str.trim();
            if (Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")) {
                continue;
            }
            if (!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
                message += "部门责任_责任人及联系方式，手机号有误！";
            }
        }
        for (String str : entity.getPhzrdwZrrlxfs().replaceAll("，", ",").split(",")) {
            str = str.trim();
            if (Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")) {
                continue;
            }
            if (!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
                message += "部门责任_配合责任人及联系方式，手机号有误！";
            }
        }
        if (PreceedPointInAreaUtil.findBelongQx(entity.getJd(), entity.getWd()).equals("漳州市")) {
            message += "该经纬度超出漳州市范围！";
        }
//        if(ToolUtil.isEmpty(entity.getEntryDepartment())){
//            message += "录入部门不能为空！";
//        }
        return message;
    }
}

