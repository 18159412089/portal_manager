package com.fjzxdz.ams.module.debriefing.service.impl;

import java.io.InputStream;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.debriefing.dao.EnvironmentAttachDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentAttachParam;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentAttachService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.gridfs.model.GridFSFile;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor=Exception.class)
public class EnvironmentAttachServiceImpl implements EnvironmentAttachService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(EnvironmentAttachServiceImpl.class);

	@Autowired
	private GridFsTemplate gridFsTemplate;

	@Autowired
	private EnvironmentAttachDao environmentAttachDao;
	
    @Autowired
    private SimpleDao simpleDao;
    
	@Override
	public EnvironmentAttach getAttach(String uuid) {
		return environmentAttachDao.getById(uuid);
	}

	@Override
	public void update(String uuid, String relation) {
		EnvironmentAttach iAttach=environmentAttachDao.getById(uuid);
		iAttach.setRelation(relation);
		environmentAttachDao.update(iAttach);
	}

	@Override
	public String saveToMongoDB(InputStream content, @Nullable String filename,@Nullable String fileType) {
		DBObject metadata = new BasicDBObject("userId", SpringSecurityUtils.getCurrentUserUuid());
		ObjectId gfs = gridFsTemplate.store(content, filename, fileType, metadata);
		EnvironmentAttach iAttach = new EnvironmentAttach();
		iAttach.setMongoid(gfs.toString());
		iAttach.setName(filename);
		EnvironmentAttach updateAttach = environmentAttachDao.update(iAttach);
		return updateAttach.getUuid();
	}
	
	@Override
	public EnvironmentAttach save(InputStream content, @Nullable String filename,
			@Nullable String fileType, String ObjUuid) {
		// 存储文件的额外信息，比如用户ID,后面要查询某个用户的所有文件时就可以直接查询
		DBObject metadata = new BasicDBObject("userId", SpringSecurityUtils.getCurrentUserUuid());
		ObjectId gfs = gridFsTemplate.store(content, filename, fileType, metadata);
		EnvironmentAttach iAttach = new EnvironmentAttach();
		iAttach.setMongoid(gfs.toString());
		iAttach.setName(filename);
		iAttach.setRelation(ObjUuid);
		return environmentAttachDao.update(iAttach);
	}

	@Override
	public void delByRelation(String relation) {
		
		String mongoId = getFileIdByRelation(relation);
		if (ToolUtil.isNotEmpty(mongoId)) {
			Query query = new Query(Criteria.where("_id").is(mongoId));
			gridFsTemplate.delete(query);
		}
		
		EnvironmentAttach attach=environmentAttachDao.getByMongoId(mongoId);
		environmentAttachDao.delete(attach);
	}

	@Override
	public GridFSFile get(String uuid) {
		GridFSFile sfile = null;
		String fileId = getFileId(uuid);
		if (ToolUtil.isNotEmpty(fileId)) {
			Query query = new Query(Criteria.where("_id").is(fileId));
			sfile = gridFsTemplate.findOne(query);
		}
		return sfile;
	}

	@Override
	public GridFSFile getByMongoId(String mongoId) {
		GridFSFile sfile = null;
		Query query = new Query(Criteria.where("_id").is(mongoId));
		sfile = gridFsTemplate.findOne(query);
		return sfile;
	}
	
	@Override
	public GridFSFile getByRelation(String relation) {
		GridFSFile sfile = null;
		String fileId = getFileIdByRelation(relation);
		if (ToolUtil.isNotEmpty(fileId)) {
			Query query = new Query(Criteria.where("_id").is(fileId));
			sfile = gridFsTemplate.findOne(query);
		}
		return sfile;
	}

	@Override
	public void remove(String mongoId) {
		String fileId = getFileId(mongoId);
		if (ToolUtil.isNotEmpty(fileId)) {
			Query query = new Query(Criteria.where("_id").is(fileId));
			gridFsTemplate.delete(query);
			environmentAttachDao.deleteById(mongoId);
		}
	}
	
	private String getFileIdByRelation(String relation) {
		List<EnvironmentAttach> list = simpleDao.find("from EnvironmentAttach where relation=?", relation);
		if(ToolUtil.isNotEmpty(list)) {
			return (ToolUtil.isEmpty(list.get(0)) || ToolUtil.isEmpty(list.get(0).getMongoid())) ? null : list.get(0).getMongoid();
		}
		return null;
	}
	
	private String getFileId(String uuid) {
		EnvironmentAttach iAttach = environmentAttachDao.getById(uuid);
		return (ToolUtil.isEmpty(iAttach) || ToolUtil.isEmpty(iAttach.getMongoid())) ? null : iAttach.getMongoid();
	}

	@Override
	public Page<EnvironmentAttach> listByPage(EnvironmentAttachParam EnvironmentAttachParam, Page<EnvironmentAttach> page) {
		Page<EnvironmentAttach> EnvironmentAttachPage=environmentAttachDao.listByPage(EnvironmentAttachParam, page);
		return EnvironmentAttachPage;
	}

}
