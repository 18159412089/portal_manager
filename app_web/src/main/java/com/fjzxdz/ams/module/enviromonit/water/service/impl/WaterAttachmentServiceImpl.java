package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.water.dao.WaterAttachmentDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WaterAttachment;
import com.fjzxdz.ams.module.enviromonit.water.param.WaterAttachmentParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterAttachmentService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class WaterAttachmentServiceImpl implements WaterAttachmentService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(WaterAttachmentServiceImpl.class);

    @Autowired
    private WaterAttachmentDao waterAttachmentDao;
    @Autowired
    private GridFsTemplate gridFsTemplate;
    @Autowired
    private MongoAttachFileDao mongoAttachFileDao;

    /**
     * 获取河流站点附件信息
     *
     * @param param
     * @param request
     * @return
     */
    @Override
    public Page<WaterAttachment> listByPage(WaterAttachmentParam param, Page<WaterAttachment> page) {
        return waterAttachmentDao.listByPage(param, page);
    }

    /**
     * 保存河流站点附件信息
     *
     * @param waterAttachment 保存对象
     * @return
     */
    @Override
    public void save(WaterAttachment waterAttachment) {
        if (ToolUtil.isEmpty(waterAttachment.getUuid())) {
            waterAttachment.setUuid(null);
            waterAttachmentDao.save(waterAttachment);
        } else {
            WaterAttachment temp = waterAttachmentDao.getById(waterAttachment.getUuid());
            temp.setName(waterAttachment.getName());
            temp.setType(waterAttachment.getType());
            temp.setEnable(waterAttachment.getEnable());
            temp.setRemark(waterAttachment.getRemark());
            temp.setIsNew(waterAttachment.getIsNew());
            temp.setIsShow(waterAttachment.getIsShow());

            temp.setDescription(waterAttachment.getDescription());
            if (!StringUtils.isNull(waterAttachment.getMongoid())) {
                Query query = new Query(Criteria.where("_id").is(temp.getMongoid()));
                gridFsTemplate.delete(query);
                mongoAttachFileDao.deleteById(temp.getMongoid());
                temp.setMongoid(waterAttachment.getMongoid());
            }
            waterAttachmentDao.update(temp);
        }
    }

    /**
     * 根据id获取附件对象
     *
     * @param uuid 主键id
     * @return
     */
    @Override
    public WaterAttachment getById(String uuid) {
        return waterAttachmentDao.getById(uuid);
    }

    /**
     * 根据id删除附件对象
     *
     * @param uuid 主键id
     * @return
     */
    @Override
    public void delete(String uuid) {
        waterAttachmentDao.deleteById(uuid);
    }

    /**
     * 根据河流站点编码获取对应的附件信息
     *
     * @param pointCode 站点编码
     * @return
     */
    @Override
    public List<WaterAttachment> getAttachments(String pointCode) {
        return waterAttachmentDao.selectList("from WaterAttachment"
                + " where isShow=1 and enable=1 and pointCode='" + pointCode + "'");
    }


}
