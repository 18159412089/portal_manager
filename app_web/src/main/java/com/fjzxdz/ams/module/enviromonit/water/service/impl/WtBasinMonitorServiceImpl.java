package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.module.enums.EnumCounty;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinMonitorDao;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinMonitorEditDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.BaseWtBasinMonitorEntity;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEditEntity;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEntity;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinMonitorParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * This class is used for 实现wt_basinmonitor修改;
 *
 * @author wudenglin
 * @version 1.0
 * @datetime 2019年5月6日 下午6:32:06
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtBasinMonitorServiceImpl implements WtBasinMonitorService {

    @Autowired
    private WtBasinMonitorDao wtBasinMonitorDao;

    @Autowired
    private WtBasinMonitorEditDao wtBasinMonitorEditDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    public Page<WtBasinMonitorEditEntity> listByPage(WtBasinMonitorParam param, Page<WtBasinMonitorEditEntity> page) {
        return wtBasinMonitorEditDao.listByPage(param, page);
    }

    /**
     * <p>Title: listWtBasinMonitor</p>
     * <p>Description: 河流监测点名称</p>
     *
     * @param param
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#listWtBasinMonitor(com.fjzxdz.ams.module.enviromonit.water.param.WtBasinMonitorParam)
     */
    @Override
    public List<WtBasinMonitorEditEntity> listWtBasinMonitor(WtBasinMonitorParam param) {
        return wtBasinMonitorEditDao.selectList("from WtBasinMonitorEntity");
    }

    /**
     * <p>Title: updataWtBasinMonitor</p>
     * <p>Description: 将河流分配给需要操作的人员</p>
     *
     * @param id
     * @param checkVal
     * @param checkedIds
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#updataWtBasinMonitor(java.lang.String, java.lang.String, java.lang.String)
     */
    @SuppressWarnings("rawtypes")
    @Override
    public int updataWtBasinMonitor(String id, String checkVal, String checkedIds) {
        if (StringUtils.isBlank(id)) {
            return 0;
        }
        String[] riverid = checkVal.split(",");
        String sql = "SELECT LOGINNAME FROM SYS_USER WHERE UUID=?";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, id);
        Object singleResult = createNativeQuery.getSingleResult();
        if (singleResult == null) {
            return 0;
        }
        String[] split = String.valueOf(singleResult).split("_");
        if (split.length != 2) {
            return 0;
        }
        EnumCounty enumByKey = EnumCounty.getEnumByKey(split[0]);
        String county = enumByKey == null ? "" : enumByKey.getValue();
        String sql1 = "FROM WtBasinMonitorEditEntity  WHERE UUID=? ";
        Set<String> set = new HashSet<String>();
        if (StringUtils.isNotBlank(checkedIds)) {
            String[] newchickedIds = checkedIds.split(",");
            for (String newchickedId : newchickedIds) {
                WtBasinMonitorEditEntity unique = wtBasinMonitorEditDao.getUnique(sql1, newchickedId);
                if (unique != null && unique.getUuid() != null) {
                    if (unique.getUserid() != null) {
                        set = new HashSet<String>(Arrays.asList(unique.getUserid().split(",")));
                    }
                    set.remove(id);
                    String join = StringUtils.join(set, ",");
                    unique.setUserid(join);
                    wtBasinMonitorEditDao.update(unique);
                }
            }
        }
        if (StringUtils.isNotBlank(checkVal)) {
            for (String newriverid : riverid) {
                WtBasinMonitorEditEntity unique = wtBasinMonitorEditDao.getUnique(sql1, newriverid);
                if (unique != null && unique.getUuid() != null) {
                    if (unique.getUserid() != null) {
                        set = new HashSet<String>(Arrays.asList(unique.getUserid().split(",")));
                    }
                    set.add(id);
                    String join = StringUtils.join(set, ",");
                    unique.setUserid(join);
                    if (unique.getCounty() == null) {
                        unique.setCounty(county);
                    }
                    wtBasinMonitorEditDao.update(unique);
                }
            }
        }
        return 1;
    }

    /**
     * <p>Title: listUserRiver</p>
     * <p>Description: 小河流域列表根据登录名成来获取用户管理的小河流域;</p>
     *
     * @param uid
     * @param county
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#listUserRiver(java.lang.String, java.lang.String)
     */
    @Override
    public List<WtBasinMonitorEditEntity> listUserRiver(String uid, String county) {
        String sql1 = "";
        if (StringUtils.isBlank(county)) {
            sql1 = "FROM WtBasinMonitorEditEntity WHERE USERID LIKE ?   ORDER BY UUID";
            return wtBasinMonitorEditDao.selectList(sql1, "%" + uid + "%");
        } else {
            sql1 = "FROM WtBasinMonitorEditEntity WHERE COUNTY = ?    ORDER BY UUID";
            return wtBasinMonitorEditDao.selectList(sql1, county);

        }
    }

    /**
     * <p>Title: editWtBasinMonitor</p>
     * <p>Description: 修改监测点信息</p>
     *
     * @param param
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#editWtBasinMonitor(com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEditEntity)
     */
    @Override
    public int editWtBasinMonitor(WtBasinMonitorEditEntity param) {
        String sql1 = "FROM WtBasinMonitorEditEntity  WHERE UUID=? ";
        WtBasinMonitorEditEntity unique = wtBasinMonitorEditDao.getUnique(sql1, param.getUuid());
        if (unique != null) {
            String time = String.valueOf(System.currentTimeMillis());
            param.setUpdateTime(time);
            param.setState(0);
            wtBasinMonitorEditDao.update(param);
            return 1;
        } else {
            return 0;
        }
    }

    /**
     * <p>Title: examineWtBasinMonitor</p>
     * <p>Description: </p>
     *
     * @param param 审核通过
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#examineWtBasinMonitor(com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEntity)
     */
    @Override
    public int examineWtBasinMonitor(BaseWtBasinMonitorEntity param) {
        String sql1 = "FROM WtBasinMonitorEditEntity  WHERE UUID=? ";
        WtBasinMonitorEditEntity unique = wtBasinMonitorEditDao.getUnique(sql1, param.getUuid());
        if (unique != null) {
            WtBasinMonitorEntity entity = new WtBasinMonitorEntity();
            unique.setState(1);
            wtBasinMonitorEditDao.update((WtBasinMonitorEditEntity) unique);
            entity.setUpdateTime(unique.getUpdateTime());
            entity.setAfriculture(unique.getAfriculture());
            entity.setAnalysis(unique.getAnalysis());
            entity.setBasin(unique.getBasin());
            entity.setBasinArea(unique.getBasinArea());
            entity.setState(unique.getState());
            entity.setBordorCity(unique.getBordorCity());
            entity.setBasinShapeCoefficient(unique.getBasinShapeCoefficient());
            entity.setBordorCity(unique.getBordorCity());
            entity.setCounty(unique.getCounty());
            entity.setIndustrySource(unique.getIndustrySource());
            entity.setInsideBasinArea(unique.getInsideBasinArea());
            entity.setInsideRiverLength(unique.getInsideRiverLength());
            entity.setLatitude(unique.getLatitude());
            entity.setLines(unique.getLines());
            entity.setLiveSewage(unique.getLiveSewage());
            entity.setLivestock(unique.getLivestock());
            entity.setLongitude(unique.getLongitude());
            entity.setMonitorName(unique.getMonitorName());
            entity.setMonitorCode(unique.getMonitorCode());
            entity.setOther(unique.getOther());
            entity.setRiver(unique.getRiver());
            entity.setRiverLength(unique.getRiverLength());
            entity.setSlopeRatio(unique.getSlopeRatio());
            entity.setType(unique.getType());
            entity.setUpdateTime(unique.getUpdateTime());
            entity.setUserid(unique.getUserid());
            entity.setUuid(unique.getUuid());
            entity.setAverageFlow(unique.getAverageFlow());
            entity.setUpdateTime(String.valueOf(System.currentTimeMillis()));
            wtBasinMonitorDao.update(entity);
            return 1;
        } else {
            return 0;
        }
    }

    /**
     * <p>Title: getCityUUID</p>
     * <p>Description: </p>
     *
     * @param logName
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService#getCityUUID(java.lang.String)
     */
    @Override
    public String getCityUUID(String logName) {
        String sql = " SELECT UUID FROM SYS_USER WHERE LOGINNAME=?";
        Query createNativeQuery = simpleDao.createNativeQuery(sql, logName);
        Object singleResult = createNativeQuery.getSingleResult();
        return String.valueOf(singleResult);
    }
}
