package com.fjzxdz.ams.module.jobSchedule.service.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.jobSchedule.dao.JobScheduleDepartmentDao;
import com.fjzxdz.ams.module.jobSchedule.dao.VehiclePollutionDao;
import com.fjzxdz.ams.module.jobSchedule.entity.VehiclePollution;
import com.fjzxdz.ams.module.jobSchedule.param.VehiclePollutionParam;
import com.fjzxdz.ams.module.jobSchedule.service.VehiclePollutionService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
/**
 * 
 * 车辆污染service实现
 * @Author   
 * @Version   1.0 
 * @CreateTime 
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class VehiclePollutionServiceImpl implements VehiclePollutionService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(VehiclePollutionServiceImpl.class);

    @Autowired
    private VehiclePollutionDao vehiclePollutionDao;
    @Autowired
    private GridFsTemplate gridFsTemplate;
    @Autowired
    private MongoAttachFileDao mongoAttachFileDao;
    @Autowired
    private JobScheduleDepartmentDao departmentDao;

    @Override
    public Page<VehiclePollution> listByPage(VehiclePollutionParam param, Page<VehiclePollution> page) {
        // return vehiclePollutionDao.listByPage(param, page);
        if (!ToolUtil.isEmpty(param.getDepartmentId())) {
            String sql = "select new VehiclePollution(uuid, name, mongoid, department.uuid, department.name, type, status, updateDate, fileName) ";
            Page<VehiclePollution> vehiclePollution = vehiclePollutionDao.listByPage(sql + param.getQueryString(),
                    param.getParams(), page);
            return vehiclePollution;
        } else {
            CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
            param.setDeptUserID(user.getUuid());
            String sql = "select new VehiclePollution(uuid, name, mongoid, department.uuid, department.name, type, status, updateDate, fileName) ";
            Page<VehiclePollution> vehiclePollution = vehiclePollutionDao.listByPage(sql + param.getQueryString(),
                    param.getParams(), page);
            return vehiclePollution;
        }
    }

    @Override
    public void save(VehiclePollution vehiclePollution) {
        if (ToolUtil.isEmpty(vehiclePollution.getUuid())) {
            vehiclePollution.setUuid(null);
            if (ToolUtil.isNotEmpty(vehiclePollution.getDepartmentId())) {
                vehiclePollution.setDepartment(departmentDao.getById(vehiclePollution.getDepartmentId()));
            }
            vehiclePollutionDao.save(vehiclePollution);
        } else {
            VehiclePollution temp = vehiclePollutionDao.getById(vehiclePollution.getUuid());
            temp.setName(vehiclePollution.getName());
            if (ToolUtil.isNotEmpty(vehiclePollution.getDepartmentId())) {
                temp.setDepartment(departmentDao.getById(vehiclePollution.getDepartmentId()));
            }

            if (!StringUtils.isNull(vehiclePollution.getMongoid())) {
                Query query = new Query(Criteria.where("_id").is(temp.getMongoid()));
                gridFsTemplate.delete(query);
                mongoAttachFileDao.deleteById(temp.getMongoid());
                temp.setMongoid(vehiclePollution.getMongoid());
                temp.setType(vehiclePollution.getType());
            }
            vehiclePollutionDao.update(temp);
        }

    }

    @Override
    public VehiclePollution getById(String uuid) {
        return vehiclePollutionDao.getById(uuid);
    }

    @Override
    public void delete(String uuid) {
        vehiclePollutionDao.deleteById(uuid);
    }

}
