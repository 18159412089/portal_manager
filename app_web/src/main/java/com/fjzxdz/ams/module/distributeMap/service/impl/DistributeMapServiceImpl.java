package com.fjzxdz.ams.module.distributeMap.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;
import com.fjzxdz.ams.module.distributeMap.dao.EnvironmeentMapDistributionDao;
import com.fjzxdz.ams.module.distributeMap.entity.EnvironmeentMapDistribution;
import com.fjzxdz.ams.module.distributeMap.service.DistributeMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 
 * 工地空气质量 业务实现类
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午3:58:41
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class DistributeMapServiceImpl implements DistributeMapService {
	
	
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private EnvironmeentMapDistributionDao mapDistributionDao;
	@Autowired
	private GridFsTemplate gridFsTemplate;
	@Autowired
	private MongoAttachFileDao mongoAttachFileDao;


	/**
	 * 通过项目id查找之前之后的附件信息 图片视频等
	 *
	 * @param page
	 * @return
	 */
	@Override
	public Page<Map<String, Object>> listByPage(Page<Map<String, Object>> page) {
		StringBuilder sql = new StringBuilder(" SELECT * FROM DISTRIBUTE_MAP ");
		return simpleDao.listNativeByPage(sql.toString(), page);
	}

	/**
	 * 获取分布地图所有信息
	 * @return
     * @param param
	 */
	@Override
	public List list(EnvironmentRectifition param) {

        StringBuilder sql = new StringBuilder(" SELECT A.*,B.STATUS,B.NUM FROM ENVIRONMEENT_MAP_DISTRIBUTION A ");
        sql.append(" LEFT JOIN ENVIRONMEENT_RECTIFITION B ON A.NAME = B.NAME WHERE  A.MARK = ").append(SqlUtil.toSqlStr(param.getMark()));
        if (StringUtils.isNotEmpty(param.getNum())) {
			sql.append(" AND B.NUM IN (").append(SqlUtil.toSqlStr(param.getNum())).append(") ");
        }if (StringUtils.isNotEmpty(param.getStatusName())) {
			if ("1".equals(param.getStatusName())) sql.append(" AND b.STATUS = 'SENDACCOUNT' ");
			if ("2".equals(param.getStatusName())) sql.append(" AND b.STATUS <> 'SENDACCOUNT' ");
		}
		if (StringUtils.isNotEmpty(param.getCityCode())) {
			sql.append(" and b.city_code = ").append(SqlUtil.toSqlStr(param.getCityCode()));
		}
		return simpleDao.getNativeQueryList(sql.toString());
	}


	/**
	 * 地图分布附件信息
	 *
	 * @param mapDistribution 保存对象
	 * @return
	 */
	@Override
	public void save(EnvironmeentMapDistribution mapDistribution) {
		if (ToolUtil.isEmpty(mapDistribution.getUuid())) {
			mapDistribution.setUuid(null);
			mapDistributionDao.save(mapDistribution);
		} else {
			EnvironmeentMapDistribution temp = mapDistributionDao.getById(mapDistribution.getUuid());
			if (!StringUtils.isNull(mapDistribution.getPicture())) {
				if (StringUtils.isNotEmpty(temp.getPicture())) {
					Query query = new Query(Criteria.where("_id").is(temp.getPicture()));
					gridFsTemplate.delete(query);
					mongoAttachFileDao.deleteById(temp.getPicture());
				}
				temp.setPicture(mapDistribution.getPicture());
			}if (!StringUtils.isNull(mapDistribution.getVideo())) {
				if (StringUtils.isNotEmpty(temp.getVideo())) {
					Query query = new Query(Criteria.where("_id").is(temp.getVideo()));
					gridFsTemplate.delete(query);
					mongoAttachFileDao.deleteById(temp.getVideo());
				}
				temp.setVideo(mapDistribution.getVideo());
			}
            BeanUtil.copyProperties(mapDistribution, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			mapDistributionDao.update(temp);
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
		mapDistributionDao.deleteById(uuid);
	}

    /**
     * 获取分布地图的文件及点位信息
     * @param page
     * @param param 参数对象
     * @return
     */
	@Override
	public Page<Map<String, Object>> getFilePage(Page<Map<String, Object>> page, EnvironmeentMapDistribution param) {
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT * FROM ENVIRONMEENT_MAP_DISTRIBUTION WHERE MARK = ").append(SqlUtil.toSqlStr(param.getMark()));
		if (StringUtils.isNotEmpty(param.getName())) {
			sb.append(" AND NAME =  ").append(SqlUtil.toSqlStr(param.getName()));
		}
		if (StringUtils.isNotEmpty((param.getDisgribe()))) {
			sb.append(" AND DISGRIBE LIKE  '%").append(param.getDisgribe()).append("%' ");
		}
		if (StringUtils.isNotEmpty((param.getQx()))) {
			sb.append(" AND remark LIKE  '%").append(param.getQx().substring(0,param.getQx().length()-1)).append("%' ");
		}
		sb.append(" ORDER BY UPDATE_DATE DESC  ");
		return simpleDao.listNativeByPage(sb.toString(),page);
	}

	@Override
	public Page<Map<String, Object>> getListPage(Page<Map<String, Object>> page, EnvironmentRectifition param) {
		StringBuilder sql = new StringBuilder(" SELECT A.*,B.STATUS,B.NUM FROM ENVIRONMEENT_MAP_DISTRIBUTION A ");
		sql.append(" LEFT JOIN ENVIRONMEENT_RECTIFITION B ON A.NAME = B.NAME WHERE  A.MARK = ").append(SqlUtil.toSqlStr(param.getMark()));
		if (StringUtils.isNotEmpty(param.getNum())) {
			sql.append(" AND B.NUM IN (").append(SqlUtil.toSqlStr(param.getNum())).append(") ");
		}if (StringUtils.isNotEmpty(param.getProjectName())) {
			sql.append(" AND (A.PROJNAME LIKE '%").append(param.getProjectName()).append("%' ");
			sql.append("  OR  A.DISGRIBE LIKE  '%").append(param.getProjectName()).append("%' ) ");
		}if (StringUtils.isNotEmpty(param.getStatusName())) {
			if ("1".equals(param.getStatusName())) sql.append(" and b.STATUS = 'SENDACCOUNT' ");
			if ("2".equals(param.getStatusName())) sql.append(" and b.STATUS <> 'SENDACCOUNT' ");
		}
		if (StringUtils.isNotEmpty(param.getCityCode())) {
			sql.append(" and b.city_code = ").append(SqlUtil.toSqlStr(param.getCityCode()));
		}
		return simpleDao.listNativeByPage(sql.toString(),page);
	}

	@Override
	public List getRoundList(String type) {
		StringBuilder sql = new StringBuilder(" SELECT DISTINCT NUM FROM ENVIRONMEENT_RECTIFITION WHERE MARK = ").append(SqlUtil.toSqlStr(type));
		sql.append(" AND NUM < 100 ORDER BY NUM ");
		return simpleDao.getNativeQueryList(sql.toString());
	}
}
