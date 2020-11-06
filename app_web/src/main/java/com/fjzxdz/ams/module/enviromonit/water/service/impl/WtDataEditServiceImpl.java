package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.core.map.MapUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.EnumCounty;
import com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This class is used for ...   小河流域数据更新
 *
 * @author wudenglin
 * @version 1.0
 * @datetime 2019年5月9日 下午3:45:06
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtDataEditServiceImpl implements WtDataEditService {
    @Autowired
    private SimpleDao simpleDao;

    /**
     * 市账号获取县账号列表需要分页
     * (zz获取zz_账号列表)
     * <p>Title: getPageList</p>
     * <p>Description: </p>
     *
     * @param loginName
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService#getPageList(java.lang.String, cn.fjzxdz.frame.common.Page)
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getPageList(String loginName, Page<Map<String, Object>> page) {
        String sql = "SELECT UUID,NAME,LOGINNAME FROM SYS_USER  JOIN SYS_JOB_USER ju ON SYS_USER.UUID=ju.USER_ID AND ju.JOB LIKE (SELECT SYS_JOB.UUID FROM SYS_JOB WHERE NAME='村镇数据维护')";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        return byPage.getResult();
    }

    /**
     * 获取县的流域有多少
     * <p>
     * Title: listRiverMonitor
     * </p>
     * <p>
     * Description:
     * </p>
     *
     * @param uid
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService#listRiverMonitor(java.lang.String)
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> listRiverMonitor(String uid) {
        String sql1 = "SELECT LOGINNAME FROM SYS_USER WHERE UUID=?";
        Query nativeCreate = simpleDao.createNativeQuery(sql1, uid);
        Object singleResult = nativeCreate.getSingleResult();
        if (singleResult == null) {
            return null;
        }
        String countName = singleResult.toString().split("_")[0];
        EnumCounty enumByKey = EnumCounty.getEnumByKey(countName);
        String sql = "SELECT MONITOR_NAME,UUID,USERID FROM WT_BASIN_MONITOR_EDIT where COUNTY=? ORDER BY  UUID";
        Query querySql = simpleDao.createNativeQuery(sql, enumByKey.getValue());
        List<Object[]> resultList = querySql.getResultList();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = null;
        for (Object[] obj : resultList) {
            map = MapUtil.newHashMap();
            map.put("monitorName", obj[0]);
            map.put("uuid", obj[1]);
            map.put("check", 0);
            if (StringUtils.ClobToString((Clob) obj[2]).contains(uid)) {
                map.put("check", 1);
            }
            result.add(map);
        }
        return result;
    }

    /**
     * 未知所属县的流域
     * <p>
     * Title: listRiverMonitor
     * </p>
     * <p>
     * Description:
     * </p>
     *
     * @param uid
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService#listRiverMonitor(java.lang.String)
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> listRiverUnknowTown() {
        String sql = "SELECT MONITOR_NAME,UUID  FROM WT_BASIN_MONITOR_EDIT WHERE COUNTY IS NULL";
        Query querySql = simpleDao.createNativeQuery(sql);
        List<Object[]> resultList = querySql.getResultList();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = null;
        for (Object[] obj : resultList) {
            map = MapUtil.newHashMap();
            map.put("monitorName", obj[0]);
            map.put("uuid", obj[1]);
            result.add(map);
        }
        return result;
    }

    /**
     * 分配小河流域到村镇的情况
     * <p>
     * Title: getUserList
     * </p>
     * <p>
     * Description:
     * </p>
     *
     * @param loginName
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService#getUserList(java.lang.String)
     */

    @Override
    public List<Map<String, Object>> getUserList(String loginName) {
        String sql = "SELECT UUID,NAME,LOGINNAME FROM SYS_USER  JOIN SYS_JOB_USER ju ON SYS_USER.UUID=ju.USER_ID AND ju.JOB LIKE (SELECT SYS_JOB.UUID FROM SYS_JOB WHERE NAME='村镇数据维护')";

        Query querySql = simpleDao.createNativeQuery(sql);
        @SuppressWarnings("unchecked")
        List<Object[]> resultList = querySql.getResultList();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = null;
        for (Object[] obj : resultList) {
            map = MapUtil.newHashMap();
            map.put("name", obj[1]);
            map.put("id", obj[0]);
            map.put("loginName", obj[2]);
            result.add(map);
        }
        return result;
    }

}
