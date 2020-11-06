package com.fjzxdz.ams.module.enviromonit.hourdata.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.hourdata.service.PeHourFluxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;
import java.util.concurrent.FutureTask;

/**
 * @program: portal_manager
 * @className: PeHourFluxServiceImpl
 * @description: TODO
 * @author: lianhuinan
 * @create: 2019-09-11 10:19
 * @version: 1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class PeHourFluxServiceImpl implements PeHourFluxService {

    @Autowired
    private SimpleDao simpleDao;

    @Async
    @Override
    public Future<Object> getDaySumFlux(String peId) {
        String currDateStr = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select SUM(c.FLUX_SUM) sum " +
                "from PE_MONITOR_POINT m inner join PE_HOUR_FLUX_DATA c on m.OUTPUT_ID = c.OUTPUT_ID and " +
                "   c.MEASURE_TIME >= TO_DATE('"+ currDateStr + " 00:00:00" +"', 'yyyy-mm-dd hh24:mi:ss') and " +
                "   c.MEASURE_TIME <= TO_DATE('"+ currDateStr + " 23:59:59" +"', 'yyyy-mm-dd hh24:mi:ss') " +
                "where c.OUTFALL_TYPE = 1 and m.OUTPUT_ID = '"+ peId +"' order by c.OUTPUT_ID, c.MEASURE_TIME asc");
        if (list.get(0).get("sum") == null){
            return new AsyncResult<Object>(0);
        }
        return new AsyncResult<Object>(list.get(0).get("sum"));
    }

    @Async
    @Override
    public Future<Object> getMonthSumFlux(String peId) {
        String starTime = DateUtil.format(DateUtil.getFirstDayOfCurrentMonth(), "yyyy-MM-dd");
        String endTime = DateUtil.getLastDayOfMonth(new Date(), "yyyy-MM-dd");
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select SUM(c.FLUX_SUM) sum " +
                "from PE_MONITOR_POINT m inner join PE_DAY_FLUX_DATA c on m.OUTPUT_ID = c.OUTPUT_ID and " +
                "   c.MEASURE_TIME >= TO_DATE('"+ starTime +"', 'yyyy-mm-dd') and " +
                "   c.MEASURE_TIME <= TO_DATE('"+ endTime +"', 'yyyy-mm-dd') " +
                "where c.OUTFALL_TYPE = 1 and m.OUTPUT_ID = '"+ peId +"' " +
                "order by c.OUTPUT_ID, c.MEASURE_TIME asc");
        if (list.get(0).get("sum") == null){
            return new AsyncResult<Object>(0);
        }
        return new AsyncResult<Object>(list.get(0).get("sum"));
    }

    @Async
    @Override
    public Future<Object> getYearSumFlux(String peId) {
        String starTime = DateUtil.getCurYearFirstDay();
        String endTime = DateUtil.getCurYearLastDay();
        List<Map<String, Object>> list = simpleDao.getNativeQueryList("select SUM(c.FLUX_SUM) sum " +
                "from PE_MONITOR_POINT m inner join PE_DAY_FLUX_DATA c on m.OUTPUT_ID = c.OUTPUT_ID and " +
                "   c.MEASURE_TIME >= TO_DATE('"+ starTime +"', 'yyyy-mm-dd') and " +
                "   c.MEASURE_TIME <= TO_DATE('"+ endTime
                +"', 'yyyy-mm-dd') " +
                "where c.OUTFALL_TYPE = 1 and m.OUTPUT_ID = '"+ peId +"' " +
                "order by c.OUTPUT_ID, c.MEASURE_TIME asc");
        if (list.get(0).get("sum") == null){
            return new AsyncResult<Object>(0);
        }
        return new AsyncResult<Object>(list.get(0).get("sum"));
    }
}
