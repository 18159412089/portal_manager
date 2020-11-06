package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirMonitorPointDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirMonitorPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.List;
import java.util.Map;

/**
 * 空气站点 Service 实现类
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午3:09:26
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpAirMonitorPointServiceImpl implements ZpAirMonitorPointService {

    @Autowired
    private AirMonitorPointDao airMonitorPointDao;

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getCityByType</p>
     * <p>Description: 大气服务页面 添加城市或监测点 每个点位的信息</p>
     *
     * @param type
     * @param pointCode
     * @param factor
     * @return
     */
    @SuppressWarnings({"unchecked"})
    @Override
    public List<Object[]> getCityByType(String type, String pointCode, String factor) {
        String sql = "";
        String andStr = "";
        if(type.equals("1")){
            andStr = " and p.point_Code = '350623' ";
        }else{
            andStr = "and p.parent='350623' ";
        }
        Query createNativeQuery = null;
        if (pointCode == null) {
            if ("aqi".equals(factor)) {
                sql = "select POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,"
                        + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O3, "
                        + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                        + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, "
                        + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O38H from (select m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,"
                        + "m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE from AIR_HOUR_DATA h inner JOIN AIR_MONITOR_POINT m "
                        + "on h.POINT_CODE = m.POINT_CODE and (h.point_code,h.MONITOR_TIME) in (select p.point_code,MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p "
                        + "inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type=? where d.MONITOR_TIME >= sysdate-7  AND "
                        + "d.MONITOR_TIME <= SYSDATE " + andStr + " GROUP BY p.point_code) group by m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,"
                        + "m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE order by h.AQI ASC) GROUP BY POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE order by POINT_NAME";

                createNativeQuery = simpleDao.createNativeQuery(sql, type);
            } else {
                sql = "select POINT_NAME,POINT_CODE,sum(DECODE( CODE_POLLUTE, ?, AVERVALUE, 0 )),POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,"
                        + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O3, "
                        + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                        + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, "
                        + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O38H,AQI  from (select m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE ,"
                        + "h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE from AIR_HOUR_DATA h inner JOIN AIR_MONITOR_POINT m on h.POINT_CODE = m.POINT_CODE "
                        + "and (h.point_code,h.MONITOR_TIME) in (select p.point_code,MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p inner "
                        + "join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type=? where d.MONITOR_TIME >= sysdate-7  AND "
                        + "d.MONITOR_TIME <= SYSDATE  " + andStr + "  GROUP BY p.point_code) group by m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,"
                        + "m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE order by h.AQI ASC) GROUP BY POINT_NAME,POINT_CODE,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,AQI order by POINT_NAME";

                createNativeQuery = simpleDao.createNativeQuery(sql, factor, type);
            }
        } else {

            if ("aqi".equals(factor)) {
                sql = "select POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, "
                        + "sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O3, sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, "
                        + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, "
                        + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O38h  "
                        + "from (select m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE from AIR_HOUR_DATA h "
                        + "inner JOIN AIR_MONITOR_POINT m on h.POINT_CODE = m.POINT_CODE and m.PARENT = ? and (h.point_code,h.MONITOR_TIME) in (select p.point_code,MAX(d.MONITOR_TIME) "
                        + "from AIR_MONITOR_POINT p inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type= ? where d.MONITOR_TIME >= sysdate-7  AND d.MONITOR_TIME <= SYSDATE  "
                        + andStr + " GROUP BY p.point_code) group by m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE order by h.AQI ASC) "
                        + "GROUP BY POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE order by POINT_NAME";

                createNativeQuery = simpleDao.createNativeQuery(sql, pointCode, type);
            } else {
                sql = "select POINT_NAME,POINT_CODE,sum(DECODE( CODE_POLLUTE, ?, AVERVALUE, 0 )),POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,"
                        + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O3, "
                        + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                        + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, "
                        + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O38h,AQI  from (select m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,"
                        + "h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE from AIR_HOUR_DATA h inner JOIN AIR_MONITOR_POINT m "
                        + "on h.POINT_CODE = m.POINT_CODE and m.PARENT = ? and (h.point_code,h.MONITOR_TIME) in (select p.point_code,MAX(d.MONITOR_TIME) "
                        + "from AIR_MONITOR_POINT p inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE and p.point_type= ? where d.MONITOR_TIME >= sysdate-7  "
                        + "AND d.MONITOR_TIME <= SYSDATE  " + andStr + "  GROUP BY p.point_code) group by m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE ,"
                        + "h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE order by h.AQI ASC) GROUP BY POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE,AQI order by POINT_NAME";

                createNativeQuery = simpleDao.createNativeQuery(sql, factor, pointCode, type);
            }
        }

        List<Object[]> resultList = createNativeQuery.getResultList();

        return resultList;

    }

    /**
     * @param pointCode
     * @return JSONObject
     * @throws
     * @Title: getPointsInfo
     * @Description: 根据pointCode获取相关数据
     * @CreateBy: chenbingke
     * @CreateTime: 2019年6月20日 下午3:29:15
     * @UpdateBy: chenbingke
     * @UpdateTime: 2019年6月20日 下午3:29:15
     */
    @Override
    public List<Map> getPointInfo(String pointCode) {
        String sql = "select POINT_NAME,POINT_CODE,ROUND(AQI,0) AQI,POINT_TYPE,to_char(MONITOR_TIME,'yyyy-mm-dd hh24:mi:ss') MONITOR_TIME,LONGITUDE,LATITUDE,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A05024', AVERVALUE, 0 )) O3, "
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, "
                + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O38H from (select m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,"
                + "m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE from AIR_HOUR_DATA h inner JOIN AIR_MONITOR_POINT m "
                + "on h.POINT_CODE = m.POINT_CODE and (h.point_code,h.MONITOR_TIME) in (select p.point_code,MAX(d.MONITOR_TIME) from AIR_MONITOR_POINT p "
                + "inner join AIR_HOUR_DATA d on p.POINT_CODE=d.POINT_CODE where p.POINT_CODE='"
                + pointCode + "' AND d.MONITOR_TIME <= SYSDATE GROUP BY p.point_code) group by m.POINT_NAME,h.POINT_CODE,h.AQI,m.POINT_TYPE,h.MONITOR_TIME,"
                + "m.LONGITUDE,m.LATITUDE ,h.POLLUTE_NAME,h.AVERVALUE,h.CODE_POLLUTE order by h.AQI ASC) GROUP BY POINT_NAME,POINT_CODE,AQI,POINT_TYPE,MONITOR_TIME,LONGITUDE,LATITUDE order by POINT_NAME";
        List<Map> list = simpleDao.getNativeQueryList(sql);
        return list;
    }

    /**
     * <p>Title: getCity</p>
     * <p>Description: 获取城市编号和名称</p>
     *
     * @return
     * @see AirMonitorPointService#getCity()
     */
    @Override
    public List<AirMonitorPoint> getCity() {

        List<AirMonitorPoint> list = airMonitorPointDao.selectList(" from AirMonitorPoint where pointType = ? and pointCode=?", "1","350623");

        return list;
    }

    @Override
    public JSONArray getPonitList(String code) {
        StringBuilder sql = new StringBuilder(" from AirMonitorPoint where pointType = 0 ");
        if (StringUtils.isNotEmpty(code)) {
            sql.append(" and codeRegion =  ").append(SqlUtil.toSqlStr(code));
        }
        List<AirMonitorPoint> list = airMonitorPointDao.selectList(sql.toString());
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray array = new JSONArray();
            for (AirMonitorPoint point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point.getPointCode());
                temp.put("text", point.getPointName());
                array.add(temp);
            }
            return array;
        }
        return new JSONArray();
    }

    /**
     * <p>Title: getMonitorPointByCity</p>
     * <p>Description: 获取父站点下所有子站点信息</p>
     *
     * @param pointCode
     * @return
     * @see AirMonitorPointService#getMonitorPointByCity(String)
     */
    @Override
    public List<AirMonitorPoint> getMonitorPointByCity(String pointCode) {
        List<AirMonitorPoint> list = airMonitorPointDao.selectList(" from AirMonitorPoint where PARENT = ? ",
                pointCode);

        return list;
    }

    /**
     * <p>Title: getPointByType</p>
     * <p>Description:  获取站点信息</p>
     *
     * @param type
     * @return
     */
    @Override
    public List<AirMonitorPoint> getPointByType(String type) {
        String andStr = "";
        if(type.equals("1")){
            andStr = "and pointCode='350623' ";
        }else{
            andStr = "and parent='350623' ";
        }

        List<AirMonitorPoint> list = airMonitorPointDao
                .selectList(" from AirMonitorPoint where pointType = ? "+andStr+" ORDER BY pointCode", type);

        return list;
    }

    /**
     * <p>Title: getImportantPoint</p>
     * <p>Description: 获取重要站点的信息</p>
     *
     * @return
     * @see AirMonitorPointService#getImportantPoint()
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getImportantPoint() {

        String sql = "SELECT  POINT_CODE ,POINT_NAME FROM AIR_MONITOR_POINT WHERE POINT_TYPE = '1' AND POINT_CODE<>'350600' OR POINT_CODE ='600602'	OR POINT_CODE ='350600451' 	ORDER BY POINT_NAME asc";

        return simpleDao.createNativeQuery(sql).getResultList();
    }

    /**
     * <p>Title: getChildrenPointByType</p>
     * <p>Description: getChildrenPointByType</p>
     *
     * @param pointCode
     * @return
     * @see AirMonitorPointService#getChildrenPointByType(String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getChildrenPointByType(String pointCode) {

        // TODO Auto-generated method stub
        String sql = "SELECT * FROM AIR_MONITOR_POINT WHERE PARENT = (SELECT PARENT FROM AIR_MONITOR_POINT WHERE POINT_CODE = ?)";
        return simpleDao.createNativeQuery(sql, pointCode).getResultList();
    }

    /*
     * 分页获取
     */
    @Override
    public Page<AirMonitorPoint> listByPage(AirMonitorPointParam param, Page<AirMonitorPoint> page) {
        return airMonitorPointDao.listByPage(param, page);
    }

}
