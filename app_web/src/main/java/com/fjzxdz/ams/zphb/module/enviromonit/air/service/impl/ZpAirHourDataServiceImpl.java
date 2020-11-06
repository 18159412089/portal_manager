package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirHourDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 空气小时数据service实现类
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:30:03
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpAirHourDataServiceImpl implements ZpAirHourDataService {


    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 查询空气小时数据</p>
     *
     * @param param
     * @param page
     * @param response
     * @return
     * @see AirHourDataService#listByPage(AirHourDataParam, Page, HttpServletResponse)
     */
    @Override
    public Page<Map<String, Object>> listByPage(AirHourDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        StringBuilder where = new StringBuilder(" where ");
        if (ToolUtil.isNotEmpty(param.getStartTime())) {
            where.append(" a.MONITOR_TIME >= TO_DATE('" + param.getStartTime() + "','yyyy-mm-dd hh24') AND "
                    + "a.MONITOR_TIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24') ");
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where.append(" AND a.POINT_CODE IN (" + SqlUtil.toSqlStr(param.getPointCode()) + ") ");

            }
            if (ToolUtil.isNotEmpty(param.getCodeRegion())) {
                where.append(" AND SUBSTR(a.CODE_REGION, 1, 6) IN ( " + SqlUtil.toSqlStr(param.getCodeRegion()) + ") ");
            }
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where.append(" and a.POINT_NAME like '%" + param.getPointName() + "%' ");
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where.append(" a.POINT_NAME like '%" + param.getPointName() + "%' ");
            } else {
                where = new StringBuilder();
            }
        }
        StringBuilder sql = new StringBuilder(" SELECT a.REGION_NAME, a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME,round(AVG(a.AQI)) AQI, ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0 ))) NO2, round(sum(DECODE( a.CODE_POLLUTE, 'A050248', a.AVERVALUE, 0 ))) O38,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A05024', a.AVERVALUE, 0 ))) O3,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0 ))) PM10,round( sum(DECODE( a.CODE_POLLUTE, 'A34004', a.AVERVALUE, 0 ))) PM25,   ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0 ))) SO2, round(sum(DECODE( a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0 )),1) CO  ");
        sql.append(" FROM AIR_HOUR_DATA a ");
        if (StringUtils.isNotEmpty(param.getPointType())) {
            sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE AND B.POINT_TYPE =  ").append(SqlUtil.toSqlStr(param.getPointType()));
        }
        sql.append(where);
        sql.append(" GROUP BY a.REGION_NAME,a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME ORDER BY a.MONITOR_TIME DESC  ");
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
            return exportExlAir(response, list, param.getExportTitle());
        }
        return simpleDao.listNativeByPage(sql.toString(), page);
    }

    private Page<Map<String, Object>> exportExlAir(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle) {
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionName", "地区");
        columnMap.put("pointName", "监测站点");
        columnMap.put("aqi", "AQI");
        columnMap.put("pm25", "PM2.5(μg/m3)");
        columnMap.put("pm10", "PM10(μg/m3)");
        columnMap.put("so2", "SO2(μg/m3)");
        columnMap.put("no2", "NO2(μg/m3)");
        columnMap.put("o38", "O3(μg/m3)");
        columnMap.put("co", "CO(mg/m3)");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 查询空气月数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see AirHourDataService#listByPage(AirHourDataParam, Page, HttpServletResponse)
     */
    @Override
    public Page<Map<String, Object>> listMonthByPage(AirHourDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        StringBuilder where = new StringBuilder(" where ");
        if ("month".equals(param.getFlag())) {
            where.append(" TO_CHAR(a.MONITOR_TIME, 'yyyy-MM') >= ").append(SqlUtil.toSqlStr(param.getStartTime().substring(0, 7)));
            where.append("and  TO_CHAR(a.MONITOR_TIME, 'yyyy-MM') <=  ").append(SqlUtil.toSqlStr(param.getEndTime().substring(0, 7)));
        }
        if ("year".equals(param.getFlag())) {
            where.append(" TO_CHAR(a.MONITOR_TIME, 'yyyy') >= ").append(SqlUtil.toSqlStr(param.getStartTime().substring(0, 4)));
            where.append("and  TO_CHAR(a.MONITOR_TIME, 'yyyy') <=  ").append(SqlUtil.toSqlStr(param.getEndTime().substring(0, 4)));
        }

        if (ToolUtil.isNotEmpty(param.getPointCode())) {
            where.append(" AND a.POINT_CODE IN (" + SqlUtil.toSqlStr(param.getPointCode()) + ") ");

        }
        if (ToolUtil.isNotEmpty(param.getCodeRegion())) {
            where.append(" AND SUBSTR(a.CODE_REGION, 1, 6) IN ( " + SqlUtil.toSqlStr(param.getCodeRegion()) + ") ");
        }
        if (ToolUtil.isNotEmpty(param.getPointName())) {
            where.append(" and a.POINT_NAME like '%" + param.getPointName() + "%' ");
        }
        StringBuilder sql = new StringBuilder();
        sql.append(" select REGION_NAME,MONITOR_TIME,POINT_CODE,POINT_NAME,  ");
        sql.append("  round(avg(AQI)) AQI, round(avg(NO2)) NO2, round(avg(O38)) O38, round(avg(O3)) O3, round(avg(PM10)) PM10, round(avg(PM25)) PM25, round(avg(SO2)) SO2, round(avg(CO),1) CO from (   ");
        sql.append(" SELECT a.REGION_NAME, ");
        if ("month".equals(param.getFlag())) sql.append(" TO_CHAR(a.MONITOR_TIME, 'yyyy-MM') MONITOR_TIME,");
        if ("year".equals(param.getFlag())) sql.append(" TO_CHAR(a.MONITOR_TIME, 'yyyy') MONITOR_TIME,");
        sql.append(" a.POINT_CODE, a.POINT_NAME,AVG(a.AQI) AQI,   ");
        sql.append("   ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0 ))) NO2, round(sum(DECODE( a.CODE_POLLUTE, 'A050248', a.AVERVALUE, 0 ))) O38,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A05024', a.AVERVALUE, 0 ))) O3,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0 ))) PM10,round( sum(DECODE( a.CODE_POLLUTE, 'A34004', a.AVERVALUE, 0 ))) PM25,   ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0 ))) SO2, round(sum(DECODE( a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0 )),1)CO  ");
        sql.append(" FROM AIR_DAY_DATA a ");
        sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE AND B.POINT_TYPE =  ").append(SqlUtil.toSqlStr(param.getPointType()));
        sql.append(where);
        sql.append(" GROUP BY a.REGION_NAME,MONITOR_TIME, a.POINT_CODE, a.POINT_NAME ORDER BY a.MONITOR_TIME DESC  ");
        sql.append(" ) group by REGION_NAME,MONITOR_TIME,POINT_CODE,POINT_NAME ORDER BY AQI ");
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
            return exportExlAir(response, list, param.getExportTitle());
        }
        return simpleDao.listNativeByPage(sql.toString(), page);
    }


    /**
     * <p>Title: rankingOrderByAQI</p>
     * <p>Description: 获取最新数据中，前十名城市信息。按空气质量排名 </p>
     *
     * @param pointType
     * @param pointCode
     * @return
     * @see AirHourDataService#rankingOrderByAQI(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> rankingOrderByAQI(String pointType, String pointCode) {
        String andStr = "";
        if(pointType.equals("1")){
            andStr = " and mp.point_Code = '350623' ";
        }else{
            andStr = "and mp.parent='350623' ";
        }
        String sql = "";
        Query createNativeQuery = null;
        if (pointCode == null) {
            sql = "select distinct mp.POINT_NAME,mp.POINT_CODE,hd.aqi,to_char(hd.MONITOR_TIME,'yyyy-mm-dd hh24'),"
                    + "mp.LONGITUDE,mp.LATITUDE,mp.POINT_TYPE , " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A34004', hd.AVERVALUE, 0 )) PM25, " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A34002', hd.AVERVALUE, 0 )) PM10, " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A21005', hd.AVERVALUE, 0 )) CO, " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A21004', hd.AVERVALUE, 0 )) NO2, " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A050248', hd.AVERVALUE, 0 )) O3, " +
                    "	sum(DECODE( hd.CODE_POLLUTE, 'A21026', hd.AVERVALUE, 0 )) SO2 "
                    + "from AIR_MONITOR_POINT mp"
                    + " left join AIR_HOUR_DATA hd on mp.POINT_CODE=hd.POINT_CODE  and (hd.point_code,hd.MONITOR_TIME) "
                    + " in (select p.point_code,MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p"
                    + " inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type= ? "
                    + " where d.MONITOR_TIME >= sysdate-10  AND d.MONITOR_TIME <= SYSDATE GROUP BY p.point_code)"
                    + " where mp.POINT_TYPE= ? "+andStr
                    + " GROUP BY mp.POINT_NAME, mp.POINT_CODE, hd.aqi, " +
                    "	to_char( hd.MONITOR_TIME, 'yyyy-mm-dd hh24' ), " +
                    "	mp.LONGITUDE, mp.LATITUDE, mp.POINT_TYPE "
                    + " order by hd.aqi asc ";
            createNativeQuery = simpleDao.createNativeQuery(sql, pointType, pointType);
        } else {
            sql = "select distinct mp.POINT_NAME,mp.POINT_CODE,hd.aqi,to_char(hd.MONITOR_TIME,'yyyy-mm-dd hh24') ,mp.LONGITUDE,mp.LATITUDE,mp.POINT_TYPE from AIR_MONITOR_POINT mp"
                    + " left join AIR_HOUR_DATA hd on mp.POINT_CODE=hd.POINT_CODE  and (hd.point_code,hd.MONITOR_TIME) "
                    + " in (select p.point_code,MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p"
                    + " inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type='0' "
                    + " where d.MONITOR_TIME >= sysdate-3  AND d.MONITOR_TIME <= SYSDATE GROUP BY p.point_code)"
                    + " where mp.POINT_TYPE='0' AND mp.PARENT= ?   order by hd.aqi asc ";

            createNativeQuery = simpleDao.createNativeQuery(sql, pointCode);
        }
        List<Object[]> resultList = createNativeQuery.getResultList();

        return resultList;
    }

    /**
     * <p>Title: getAirQuantity</p>
     * <p>Description: 某个城市的最新小时数据</p>
     *
     * @param pointCode
     * @return
     * @see AirHourDataService#getAirQuantity(String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAirQuantity(String pointCode) {

        String sql;
        sql = "SELECT TO_CHAR(MONITOR_TIME,'yyyy-mm-dd hh24:mi:ss'),POINT_NAME,AQI, " +
                " sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                " sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                " sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co  ," +
                " sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                " sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, " +
                " sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 " +
                " FROM AIR_HOUR_DATA WHERE POINT_CODE = ?  " +
                " AND MONITOR_TIME = ( SELECT MAX( MONITOR_TIME ) FROM AIR_HOUR_DATA  " +
                " WHERE MONITOR_TIME > SYSDATE - 2 AND MONITOR_TIME <= SYSDATE AND POINT_CODE = ? )  " +
                "GROUP BY MONITOR_TIME,POINT_NAME,AQI";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, pointCode, pointCode);
        List<Object[]> resultList = createNativeQuery.getResultList();

        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAirInfoByTime(String startTime, String endTime) {
        String sql = "SELECT TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd hh24:mi:ss' ),POINT_NAME,AQI, " +
                "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co,   " +
                "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,  " +
                "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2,  " +
                "sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O38h  " +
//				"FROM AIR_HOUR_DATA WHERE POINT_CODE IN('600602','600603') AND " + 
                "FROM AIR_HOUR_DATA WHERE POINT_CODE IN('600602','350600451') AND " +
                "TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd hh24' ) >= ?  " +
                "AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd hh24' ) <= ?  " +
                "GROUP BY MONITOR_TIME,POINT_NAME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, startTime, endTime);
        List<Object[]> resultList = createNativeQuery.getResultList();
        return resultList;
    }

    @Override
    public JSONArray getAllPointsDayDataRanking(String time){
        StringBuilder sql = new StringBuilder();
        if(StringUtils.length(time) == 10){
            sql.append("select d.REGION_NAME name, AQI aqi, TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd') time from AIR_DAY_DATA d " +
                    "LEFT JOIN AIR_MONITOR_POINT p ON d.POINT_CODE = p.POINT_CODE " +
                    "where d.MONITOR_TIME = TO_DATE('").append(time).append("', 'yyyy-mm-dd') and p.POINT_TYPE = 1 and p.point_code='350623' " +
                    "GROUP BY d.REGION_NAME, AQI, TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd') ORDER BY AQI");
        }else if(StringUtils.length(time) == 7) {
            sql.append("select d.REGION_NAME name, ROUND(AVG(AQI), 0) aqi, TO_CHAR(MONITOR_TIME, 'yyyy-mm') time from AIR_DAY_DATA d " +
                    "LEFT JOIN AIR_MONITOR_POINT p ON d.POINT_CODE = p.POINT_CODE " +
                    "where TO_CHAR(d.MONITOR_TIME, 'yyyy-mm-dd') like '").append(time).append("%' and p.POINT_TYPE = 1 and p.point_code='350623' " +
                    "GROUP BY d.REGION_NAME, TO_CHAR(MONITOR_TIME, 'yyyy-mm') ORDER BY AQI");
        }
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
        if(ToolUtil.isNotEmpty(list)){
            return JSONArray.parseArray(JSON.toJSONString(list));
        }
        return new JSONArray(0);
    }

}
