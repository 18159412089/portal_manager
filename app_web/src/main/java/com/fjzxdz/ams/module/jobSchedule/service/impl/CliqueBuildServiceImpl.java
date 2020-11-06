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
import com.fjzxdz.ams.module.jobSchedule.dao.CliqueBuildDao;
import com.fjzxdz.ams.module.jobSchedule.dao.JobScheduleDepartmentDao;
import com.fjzxdz.ams.module.jobSchedule.entity.CliqueBuild;
import com.fjzxdz.ams.module.jobSchedule.entity.VehiclePollution;
import com.fjzxdz.ams.module.jobSchedule.param.CliqueBuildParam;
import com.fjzxdz.ams.module.jobSchedule.service.CliqueBuildService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor = Exception.class)
/**
 * 
 * 党建service实现类
 * 
 * @Author caibai
 * @Version 1.0
 * @CreateTime 2019年4月30日 下午3:33:00
 */
public class CliqueBuildServiceImpl implements CliqueBuildService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(CliqueBuildServiceImpl.class);

    @Autowired
    private CliqueBuildDao cliqueBuildDao;
    @Autowired
    private GridFsTemplate gridFsTemplate;
    @Autowired
    private MongoAttachFileDao mongoAttachFileDao;
    @Autowired
    private JobScheduleDepartmentDao departmentDao;

    @Override
    public Page<CliqueBuild> listByPage(CliqueBuildParam param, Page<CliqueBuild> page) {
        // return CliqueBuildDao.listByPage(param, page);
        if (!ToolUtil.isEmpty(param.getDepartmentId())) {
            String sql = "select new CliqueBuild(uuid, name, mongoid, department.uuid, department.name, type, status, updateDate, fileName) ";
            Page<CliqueBuild> cliqueBuild = cliqueBuildDao.listByPage(sql + param.getQueryString(), param.getParams(),
                    page);
            return cliqueBuild;
        } else {
            CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
            param.setDeptUserID(user.getUuid());
            String sql = "select new VehiclePollution(uuid, name, mongoid, department.uuid, department.name, type, status, updateDate, fileName) ";
            Page<CliqueBuild> cliqueBuild = cliqueBuildDao.listByPage(sql + param.getQueryString(), param.getParams(),
                    page);
            return cliqueBuild;
        }
    }

    @Override
    public void save(CliqueBuild cliqueBuild) {
        if (ToolUtil.isEmpty(cliqueBuild.getUuid())) {
            cliqueBuild.setUuid(null);
            if (ToolUtil.isNotEmpty(cliqueBuild.getDepartmentId())) {
                cliqueBuild.setDepartment(departmentDao.getById(cliqueBuild.getDepartmentId()));
            }
            cliqueBuildDao.save(cliqueBuild);
        } else {
            CliqueBuild temp = cliqueBuildDao.getById(cliqueBuild.getUuid());
            temp.setName(cliqueBuild.getName());
            if (ToolUtil.isNotEmpty(cliqueBuild.getDepartmentId())) {
                temp.setDepartment(departmentDao.getById(cliqueBuild.getDepartmentId()));
            }

            if (!StringUtils.isNull(cliqueBuild.getMongoid())) {
                Query query = new Query(Criteria.where("_id").is(temp.getMongoid()));
                gridFsTemplate.delete(query);
                mongoAttachFileDao.deleteById(temp.getMongoid());
                temp.setMongoid(cliqueBuild.getMongoid());
                temp.setType(cliqueBuild.getType());
            }
            cliqueBuildDao.update(temp);
        }

    }

    @Override
    public CliqueBuild getById(String uuid) {
        return cliqueBuildDao.getById(uuid);
    }

    @Override
    public void delete(String uuid) {
        cliqueBuildDao.deleteById(uuid);
    }

}
