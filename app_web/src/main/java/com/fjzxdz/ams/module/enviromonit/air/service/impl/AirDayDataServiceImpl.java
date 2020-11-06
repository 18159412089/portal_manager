package com.fjzxdz.ams.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 数据服务 空气环境质量 service 实现类
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:30:12
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class AirDayDataServiceImpl implements AirDayDataService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: 查询空气日数据信息</p>
     * <p>Description: </p>
     *
     * @param param
     * @param page
     * @param response
     * @return
     * @see AirDayDataService#listByPage(AirDayDataParam, Page, HttpServletResponse)
     */
    @Override
    public Page<Map<String, Object>> listByPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        StringBuilder where = new StringBuilder(" where ");
        if (ToolUtil.isNotEmpty(param.getStartTime())) {
            where.append(" a.MONITOR_TIME >= TO_DATE('" + param.getStartTime() + "','yyyy-mm-dd hh24') AND "
                    + "a.MONITOR_TIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24') ");

            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where.append(" AND a.POINT_CODE IN (" + SqlUtil.toSqlStr(param.getPointCode()) + ") ");

            }
            if (ToolUtil.isNotEmpty(param.getCodeRegion())) {
                where.append(" AND SUBSTR(a.CODE_REGION, 1, 6) IN (" + SqlUtil.toSqlStr(param.getCodeRegion()) + ") ");
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
        StringBuilder sql = new StringBuilder(" SELECT a.REGION_NAME,a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME,round(AVG(a.AQI)) AQI, ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0 ))) NO2, round(sum(DECODE( a.CODE_POLLUTE, 'A050248',a. AVERVALUE, 0 )))  O3,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0 ))) PM10,round( sum(DECODE(a. CODE_POLLUTE, 'A34004',a. AVERVALUE, 0 )))  PM25,  ");
        sql.append(" round(sum(DECODE( a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0 ))) SO2, round(sum(DECODE( a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0 )),1) CO  ");
        if(param.getPointType().equals("2")){
            sql.append(" FROM AIR_HOUR_DATA a ");
        }else {
            sql.append(" FROM AIR_DAY_DATA a ");
        }
        if (StringUtils.isNotEmpty(param.getPointType())) {
            sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE AND B.POINT_TYPE =  ").append(SqlUtil.toSqlStr(param.getPointType()));
        }
        sql.append(where);
        sql.append(" GROUP BY a.REGION_NAME,a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME  ");
        sql.append(" ORDER BY a.MONITOR_TIME DESC  ");
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
            return exportExlAir(response, list, param.getExportTitle());
        }
        Page<Map<String, Object>> list = simpleDao.listNativeByPage(sql.toString(), page);
        return list;
    }


    /**
     * <p>Title: 查询空气日数据信息</p>
     * <p>Description: </p>
     *
     * @param param
     * @param page
     * @param response
     * @return
     * @see AirDayDataService#alllistByPage(AirDayDataParam, Page, HttpServletResponse)
     */
    @Override
    public Page<Map<String, Object>> alllistByPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        StringBuilder where = new StringBuilder(" where ");
        if (ToolUtil.isNotEmpty(param.getStartTime())) {
            where.append(" a.MONITOR_TIME >= TO_DATE('" + param.getStartTime() + "','yyyy-mm-dd hh24:mi:ss') AND "
                    + "a.MONITOR_TIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ");

            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where.append(" AND a.POINT_CODE IN (" + SqlUtil.toSqlStr(param.getPointCode()) + ") ");

            }
            if (ToolUtil.isNotEmpty(param.getCodeRegion())) {
                where.append(" AND SUBSTR(a.CODE_REGION, 1, 6) IN (" + SqlUtil.toSqlStr(param.getCodeRegion()) + ") ");
            }
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where.append(" and a.POINT_NAME like '%" + param.getPointName() + "%' ");
            }
        } else {
            where.append("1=1");
            String currentStartTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 00:00:00";
            String currentEndTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 23:59:59";
            where.append(" and a.MONITOR_TIME >= TO_DATE('" + currentStartTime + "','yyyy-mm-dd hh24:mi:ss') AND "
                    + "a.MONITOR_TIME <= TO_DATE('" +currentEndTime + "','yyyy-mm-dd hh24:mi:ss') ");
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where.append("and a.POINT_CODE IN (" + SqlUtil.toSqlStr(param.getPointCode()) + ") ");
            }
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where.append("and  a.POINT_NAME like '%" + param.getPointName() + "%' ");
            }
        }
        StringBuilder sql = new StringBuilder(" SELECT a.REGION_NAME, TO_CHAR(a.MONITOR_TIME,'yyyy-mm-dd hh24:mi:ss') as DATATIME , a.POINT_CODE, a.POINT_NAME, a.AVERVALUE,a.code_pollute,a.pollute_name ");
        sql.append(" FROM AIR_DAY_DATA a ");
        sql.append(where);
        sql.append(" ORDER BY a.MONITOR_TIME DESC  ");

        Page<Map<String, Object>> list = simpleDao.listNativeByPage(sql.toString(), page);
        return list;
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
     * <p>Title: 获取漳州市过去一个月的空气AQI值</p>
     * <p>Description: </p>
     *
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService#airQuantityForLastMonth()
     */
    @SuppressWarnings({"unchecked", "static-access"})
    @Override
    public List<Object[]> airQuantityForLastMonth() {
        // 设置日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(new Date());
        calendar.add(calendar.DATE, -30);
        String startTime = df.format(calendar.getTime());
        String endTime = df.format(new Date());
        String sql = "SELECT POINT_NAME,AQI ,TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') FROM AIR_DAY_DATA   WHERE  POINT_CODE ='350600' "
                + " AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') >= ? AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd')<= ? "
                + " GROUP BY AQI,POINT_NAME,MONITOR_TIME ORDER BY MONITOR_TIME ASC";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, startTime, endTime);
        List<Object[]> resultList = createNativeQuery.getResultList();
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCityAirDayData() {
        String sql = "select d.REGION_NAME,d.POINT_CODE,d.AQI from AIR_DAY_DATA d "
                + " inner JOIN AIR_MONITOR_POINT m on d.POINT_CODE = m.POINT_CODE "
                + " AND m.POINT_TYPE = '1' where MONITOR_TIME= (SELECT MAX( MONITOR_TIME ) "
                + " FROM AIR_DAY_DATA WHERE POINT_CODE = '350600') group by d.REGION_NAME,d.POINT_CODE,d.AQI ";
        Query createNativeQuery = simpleDao.createNativeQuery(sql);
        List<Object[]> resultList = createNativeQuery.getResultList();
        if (resultList.size() <= 0) {
            return null;
        }
        System.out.println(resultList.size());
        return resultList;
    }

    /**
     * <p>Title: 空气日历 日历显示</p>
     * <p>Description: </p>
     *
     * @param pointCode
     * @param startTime
     * @param endTime
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService#getCityByMonth(java.lang.String, java.lang.String, java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCityByMonth(String pointCode, String startTime, String endTime) {

        String sql = "SELECT POINT_NAME,TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ),AQI,"
                + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25,"
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,"
                + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,"
                + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,"
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2,POINT_CODE"
                + "	FROM AIR_DAY_DATA WHERE POINT_CODE = ? AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ? "
                + " AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ? "
                + " GROUP BY MONITOR_TIME, POINT_NAME, AQI,POINT_CODE ORDER BY MONITOR_TIME";

        List<Object[]> list = simpleDao.createNativeQuery(sql, pointCode, startTime, endTime).getResultList();

        return list;
    }

    /**
     * <p>Title: 获取该城市当天天气信息</p>
     * <p>Description: </p>
     *
     * @param pointCode
     * @param time
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService#getCityAirInfo(java.lang.String, java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCityAirInfo(String pointCode, String time) {

        String sql = "SELECT POINT_NAME,TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ),AQI,"
                + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25,"
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,"
                + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,"
                + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,"
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2"
                + "	FROM AIR_DAY_DATA WHERE POINT_CODE = ? AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) = ? "
                + " GROUP BY MONITOR_TIME, POINT_NAME, AQI ORDER BY MONITOR_TIME";

        List<Object[]> list = simpleDao.createNativeQuery(sql, pointCode, time).getResultList();

        return list;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCityInfoByCode(String pointCode, String startTime, String endTime) {

        String sql = "SELECT POINT_NAME,TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ),AQI,"
                + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25,"
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,"
                + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,"
                + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,"
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2"
                + "	FROM AIR_DAY_DATA WHERE POINT_CODE = ? AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ? "
                + "	AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ? "
                + " GROUP BY MONITOR_TIME, POINT_NAME, AQI ORDER BY MONITOR_TIME ASC";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, pointCode, startTime, endTime);

        return createNativeQuery.getResultList();
    }

}
