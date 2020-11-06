package com.fjzxdz.ams.module.debriefing.dao;

import java.io.InputStream;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Repository("environmentAttachDao")
public class EnvironmentAttachDao extends PagingDaoSupport<EnvironmentAttach> {
	@Autowired
	private GridFsTemplate gridFsTemplate;
	
	public EnvironmentAttach getByMongoId(String mongoId) {
		return this.getBy("mongoid", mongoId);
	}
	
	public ObjectId saveToMongoDB(InputStream content, @Nullable String filename,@Nullable String fileType) {
		DBObject metadata = new BasicDBObject("userId", SpringSecurityUtils.getCurrentUserUuid());
		ObjectId gfs = gridFsTemplate.store(content, filename, fileType, metadata);
		return gfs;
	}
	
	public void deleteByUuid(String id) {
		EnvironmentAttach attach = getById(id);
		if (ToolUtil.isNotEmpty(attach.getMongoid())) {
			Query query = new Query(Criteria.where("_id").is(attach.getMongoid()));
			gridFsTemplate.delete(query);
		}
		delete(attach);
	}
}
