/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.datamonitor.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.module.datamonitor.dao.ReportingDao;
import com.fjzxdz.ams.module.datamonitor.entity.Reporting;
import com.fjzxdz.ams.module.datamonitor.param.ReportingParam;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 信息汇报Service
 *
 * @author slq
 * @version 2019-02-27
 */
@Component
@Transactional(rollbackFor = Exception.class)
public class ReportingService {

    private static Logger logger = LogManager.getLogger(ReportingService.class);

    @Autowired
    private ReportingDao reportingDao;
    @Autowired
    private SimpleDao simpleDao;

    /**
     * 分页查询
     *
     * @param page
     * @return
     */
    public Page<Reporting> listByPage(ReportingParam reportingParam, Page<Reporting> page) {
        Page<Reporting> listPage = reportingDao.listByPage(reportingParam, page);
        return listPage;
    }

    /**
     * 更新或新增
     *
     * @param reporting
     */
    public void save(Reporting reporting) {
        if (StringUtils.isNotEmpty(reporting.getUuid())) {
            reportingDao.update(reporting);
        } else {
            reporting.setUuid(null);
            reportingDao.save(reporting);
        }
    }

    /**
     * 按uuid删除
     *
     * @param uuid
     */
    public void delete(String uuid) {
        reportingDao.deleteById(uuid);
    }

    /**
     * 按uuid删除
     *
     * @param uuid
     */
    public List<Object> getById(String uuid) {
        String sql="SELECT a.UUID,a.CONTENT,a.USER_ID, to_char(a.CREATE_TIME,'yyyy-mm-dd hh24:mi:ss') as CREATE_TIME ,b.name AS userName FROM \"INFORMATION_REPORTING\" a LEFT JOIN SYS_USER b on a.USER_ID=b.UUID WHERE a.uuid='"+uuid+"'";
        return simpleDao.getNativeQueryList(sql);
    }


    public Page<Map<String, Object>> findList(ReportingParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        String sql = "SELECT a.UUID,a.CONTENT,a.USER_ID, to_char(a.CREATE_TIME,'yyyy-mm-dd hh24:mi:ss') as CREATE_TIME ,b.name AS userName FROM \"INFORMATION_REPORTING\" a LEFT JOIN SYS_USER b on a.USER_ID=b.UUID WHERE 1=1";
        if (StringUtils.isNotEmpty(param.getCreateUser())){
            sql+=" AND b.name like '%"+param.getCreateUser()+"%'";
        }
        if(StringUtils.isNotEmpty(param.getStartTime())&&StringUtils.isNotEmpty(param.getEndTime())){
            sql+=" AND a.CREATE_TIME >= TO_DATE ('"+param.getStartTime()+"','yyyy-mm-dd hh24:mi:ss') AND a.CREATE_TIME <= TO_DATE ('"+param.getEndTime()+"','yyyy-mm-dd hh24:mi:ss')";
        }
        sql += " ORDER BY a.CREATE_TIME DESC";
        return simpleDao.listNativeByPage(sql, page);
    }
}
