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
import com.fjzxdz.ams.module.enviromonit.pollution.dao.PollutionInfoDataDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PollutionInfoService;
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

/**
 * @version 1.0
 * @Author lianhuinan
 * @Description //TODO(PollutionInfoService接口实现类)
 * @Date 2019/9/11 0011 17:00
 **/
@Service
@Transactional(rollbackFor = Exception.class)
public class PollutionInfoServiceImpl implements PollutionInfoService {

    private static Logger logger = LogManager.getLogger(PollutionInfoServiceImpl.class);

    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private PollutionInfoDataDao pollutionInfoDataDao;

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
    public Future<JSONArray> countPollutionByArea(String wrylx, String wryzl) {
        StringBuilder countys = new StringBuilder();
        for (PollutionInfoCountyEnum countyEnum : PollutionInfoCountyEnum.values()) {
            countys.append(countyEnum.getKey()).append(",");
        }
        countys.deleteCharAt(countys.length() - 1);

        StringBuilder sql = new StringBuilder(" select qx, count(1) count from(select distinct p.mc name,p.qx,p.wrylx,p.wryzl,p.jd,p.wd,p.mc,p.czwt,p.zgcs,p.zlxm,")
                .append("p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,")
                .append("p.dz,p.jwd,p.bz from POLLUTION_INFO_DATA p where p.wrylx='")
                .append(wryzl).append("' and p.wryzl='").append(wrylx).append("' and p.jd is not null and p.wryzl is not null and p.wd is not null and p.wrylx is not null and p.qx in (")
                .append(SqlUtil.toSqlStr(countys.toString())).append(")").append(" and (p.jd like '%117.%' or p.jd like '%118.0%' or p.jd like '%118.1%')) group by qx ");

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
    public void saveInfo(PollutionInfoData pollutionInfoData) {
        if (ToolUtil.isEmpty(pollutionInfoData.getUuid())) {
            pollutionInfoData.setUuid(null);
            pollutionInfoDataDao.save(pollutionInfoData);
        } else {
            PollutionInfoData temp = pollutionInfoDataDao.getById(pollutionInfoData.getUuid());
            BeanUtil.copyProperties(pollutionInfoData, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
            pollutionInfoDataDao.update(temp);
        }
    }

    /**
     * 通过主键删除污染源信息
     *
     * @param pkid
     */
    @Override
    public void deleteInfo(String pkid) {
        pollutionInfoDataDao.deleteById(pkid);
    }

    /**
     * 检查污染源大数据上一周是否有修改动作
     *
     * @return
     */
    @Override
    public List<Map> checkLastWeekAlreadyUpdateInfo(){
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
    public List<Map> dynamicCountPollutionInfo() {
        StringBuilder sql = new StringBuilder(" SELECT WRYLX,COUNT(1) COUNT FROM POLLUTION_INFO_DATA   ");
        sql.append(" WHERE JD IS NOT NULL AND WD IS NOT NULL AND (TRIM(JD) LIKE  '117%' OR TRIM(JD) LIKE  '118.0%' OR TRIM(JD) LIKE '118.1%') AND WRYLX IS NOT NULL  ");
        sql.append(" GROUP BY WRYLX ");
        List<Map> wrylxList = simpleDao.getNativeQueryList(sql.toString());
        sql = new StringBuilder("  SELECT WRYZL,WRYLX,COUNT(1) COUNT FROM POLLUTION_INFO_DATA ");
        sql.append(" WHERE JD IS NOT NULL AND WD IS NOT NULL AND (TRIM(JD) LIKE  '117%' OR TRIM(JD) LIKE  '118.0%' OR TRIM(JD) LIKE '118.1%') AND WRYZL IS NOT NULL ");
        sql.append(" GROUP BY WRYZL,WRYLX ");
        List<Map> wryzlList = simpleDao.getNativeQueryList(sql.toString());
        String dw;
        String dw2;
        String dwCount;
        String wryzl;
        String wryzlCount;
        List<Map> resultList = new ArrayList<>();
        for (Map map : wrylxList) {
            Map dwMap = Maps.newHashMap();
            JSONArray json = new JSONArray();
            dw = MapUtils.getString(map, "wrylx","");
            dwCount = MapUtils.getString(map, "count","0");
            for (Map wryzlMap : wryzlList) {
                dw2 = MapUtils.getString(wryzlMap, "wrylx","");
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
        System.out.println(resultList);
        return resultList;
    }

}

