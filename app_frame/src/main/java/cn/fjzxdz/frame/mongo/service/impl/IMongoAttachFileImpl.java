package cn.fjzxdz.frame.mongo.service.impl;

import java.io.InputStream;

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

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.gridfs.model.GridFSFile;

import cn.fjzxdz.frame.dao.sys.MongoAttachFileDao;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.service.impl.LoginLogServiceImpl;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class IMongoAttachFileImpl implements IMongoAttachFile {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(LoginLogServiceImpl.class);

	@Autowired
	private GridFsTemplate gridFsTemplate;

	@Autowired
	private MongoAttachFileDao mongoAttachFileDao;

	@Override
	public MongoAttachFile saveFile(InputStream content, @Nullable String filename, @Nullable String contentType) {
		// 存储文件的额外信息，比如用户ID,后面要查询某个用户的所有文件时就可以直接查询
		DBObject metadata = new BasicDBObject("userId", SpringSecurityUtils.getCurrentUserUuid());
		ObjectId gfs = gridFsTemplate.store(content, filename, contentType, metadata);
		MongoAttachFile mFile = new MongoAttachFile();
		mFile.setFileId(gfs.toString());
		mFile.setFileName(filename);
		mFile.setContentType(contentType);
		return mongoAttachFileDao.update(mFile);
	}

	@Override
	public GridFSFile getFile(String uuid) {
		GridFSFile sfile = null;
		String fileId = getFileId(uuid);
		if (ToolUtil.isNotEmpty(fileId)) {
			Query query = new Query(Criteria.where("_id").is(fileId));
			sfile = gridFsTemplate.findOne(query);
		}
		return sfile;
	}

	@Override
	public void removeFile(String uuid) {
		String fileId = getFileId(uuid);
		if (ToolUtil.isNotEmpty(fileId)) {
			Query query = new Query(Criteria.where("_id").is(fileId));
			gridFsTemplate.delete(query);
			mongoAttachFileDao.deleteById(uuid);
		}
	}

	private String getFileId(String uuid) {
		MongoAttachFile mFile = mongoAttachFileDao.getById(uuid);
		return (ToolUtil.isEmpty(mFile) || ToolUtil.isEmpty(mFile.getFileId())) ? null : mFile.getFileId();
	}
}
