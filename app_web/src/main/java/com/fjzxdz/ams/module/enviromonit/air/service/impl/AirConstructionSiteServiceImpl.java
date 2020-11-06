package com.fjzxdz.ams.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirConstructionSiteDao;
import com.fjzxdz.ams.module.enviromonit.air.dao.FileAttachmentDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirConstructionSite;
import com.fjzxdz.ams.module.enviromonit.air.param.AirConstructionSiteParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirConstructionSiteService;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;
import org.apache.commons.collections4.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 工地空气质量 业务实现类
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午3:58:41
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class AirConstructionSiteServiceImpl implements AirConstructionSiteService {


    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private AirConstructionSiteDao airConstructionSiteDao;
    @Autowired
    private FileAttachmentDao fileAttachmentDao;

    /**
     * <p>Title: getConstructionInfo</p>
     * <p>Description: 获取工地信息 </p>
     *
     * @return
     */
    @Override
    public List<AirConstructionSite> getConstructionInfo(String deptName) {
        String where = "";
        if(deptName != null){
            where = " where A.QX = '"+deptName+"'";
        }
        String sql = "SELECT a.*,b.VIDEO,b.PICTURE FROM AIR_CONSTRUCTION_SITE A LEFT JOIN FILE_ATTACHMENT B ON A.PKID = B.PKID AND B.SOURCE ='site'"+where;
        List<AirConstructionSite> list = simpleDao.getNativeQueryList(sql, AirConstructionSite.class);
        return list;
    }

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 获取工地信息列表</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirConstructionSiteService#listByPage(com.fjzxdz.ams.module.enviromonit.air.param.AirConstructionSiteParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<AirConstructionSite> listByPage(AirConstructionSiteParam param, Page<AirConstructionSite> page) {
        return airConstructionSiteDao.listByPage(param, page);
    }

    /**
     * 获取附件列表  工地
     *
     * @param page
     * @param paramMap
     * @return
     */
    @Override
    public Page<Map<String, Object>> getFileAttachPage(Page<Map<String, Object>> page, Map paramMap) {
        StringBuilder sb = new StringBuilder(" SELECT a.PKID,a.PKID id,a.BUILT_VALUE,a.LATITUDE,a.LONGITUDE,a.RESPON_ORGANIZATION,a.name,b.uuid,b.PICTURE,b.UPDATE_DATE,b.VIDEO,b.PICNAME,b.VEDIONAME FROM AIR_CONSTRUCTION_SITE A ");
        sb.append(" LEFT JOIN FILE_ATTACHMENT B ON A.PKID = B.PKID ");
        String source = MapUtils.getString(paramMap, "source", "");
        if (StringUtils.isNotEmpty(source)) {
            sb.append("  and B.SOURCE = ").append(SqlUtil.toSqlStr(source));
        }
        sb.append(" where 1=1 ");
        if(paramMap.get("deptName") != null){
            sb.append(" and a.qx = '"+paramMap.get("deptName")+"' ");
        }
        String name = MapUtils.getString(paramMap, "name", "");
        if (StringUtils.isNotEmpty(name)) {
            sb.append("  and a.name like '%").append(name.trim()).append("%'");
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }

    /**
     * 附件信息
     *
     * @param fileAttachment 保存对象
     * @return
     */
    @Autowired
    private GridFsTemplate gridFsTemplate;
    @Autowired
    private MongoAttachFileDao mongoAttachFileDao;

    @Override
    public void save(FileAttachment fileAttachment) {
        if (ToolUtil.isEmpty(fileAttachment.getUuid())) {
            fileAttachment.setUuid(null);
            fileAttachmentDao.save(fileAttachment);
        } else {
            FileAttachment temp = fileAttachmentDao.getById(fileAttachment.getUuid());
            if (!StringUtils.isNull(fileAttachment.getPicture())) {
                if (StringUtils.isNotEmpty(temp.getPicture())) {
                    Query query = new Query(Criteria.where("_id").is(temp.getPicture()));
                    gridFsTemplate.delete(query);
                    mongoAttachFileDao.deleteById(temp.getPicture());
                }
                temp.setPicture(fileAttachment.getPicture());
            }
            if (!StringUtils.isNull(fileAttachment.getVideo())) {
                if (StringUtils.isNotEmpty(temp.getVideo())) {
                    Query query = new Query(Criteria.where("_id").is(temp.getVideo()));
                    gridFsTemplate.delete(query);
                    mongoAttachFileDao.deleteById(temp.getVideo());
                }
                temp.setVideo(fileAttachment.getVideo());
            }
            BeanUtil.copyProperties(fileAttachment, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
            fileAttachmentDao.update(temp);
        }
    }

    /**
     * 根据id删除附件对象
     *
     * @param uuid 主键id
     * @return
     */
    @Override
    public void delete(String uuid) {
        fileAttachmentDao.deleteById(uuid);
    }

    /**
     * 保存修改工地信息
     *
     * @param airConstructionSite
     */
    public void saveCompanyInfo(AirConstructionSite airConstructionSite) {
        if (ToolUtil.isEmpty(airConstructionSite.getPkid())) {
            airConstructionSite.setPkid(null);
            airConstructionSiteDao.save(airConstructionSite);
        } else {
            AirConstructionSite temp = airConstructionSiteDao.getById(airConstructionSite.getPkid());
            BeanUtil.copyProperties(airConstructionSite, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
            airConstructionSiteDao.update(temp);
        }
    }

    /**
     * 根据id删除工地信息
     *
     * @param pkid 主键id
     * @return
     */
    @Override
    public void deleteCompanyInfo(String pkid) {
        airConstructionSiteDao.deleteById(pkid);
    }

}
