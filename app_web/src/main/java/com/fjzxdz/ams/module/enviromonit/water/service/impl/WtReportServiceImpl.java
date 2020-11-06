package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.module.enviromonit.water.service.WtReportService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class WtReportServiceImpl implements WtReportService {
    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: countWaterQuality</p>
     * <p>Description: 小河流域环境质量状况 统计每个质量等级的数量  </p>
     *
     * @param startTime
     * @param endTime
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtReportService#countWaterQuality(java.lang.String, java.lang.String)
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<Object[]> countWaterQuality(String startTime, String endTime) {
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        if (StringUtils.isNotBlank(startTime)) {
            where.append(
                    " AND YEAR_NUMBER=" + startTime.split("-")[0] + " AND MONTH_NUMBER>=" + startTime.split("-")[1]);
        }
        if (StringUtils.isNotBlank(endTime)) {
            where.append(" AND YEAR_NUMBER =" + endTime.split("-")[0] + " AND MONTH_NUMBER<=" + endTime.split("-")[1]);
        }
        Query queryresult = simpleDao
                .createNativeQuery("SELECT RESULT_QUALITY,COUNT(UUID) FROM WT_BASIN_MONTH_DATA "
                        + where.toString() + " GROUP BY RESULT_QUALITY");
        List<Object[]> qList = queryresult.getResultList();
        return qList;
    }

}
