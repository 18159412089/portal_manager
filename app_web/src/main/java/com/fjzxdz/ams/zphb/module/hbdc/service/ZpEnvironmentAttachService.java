package com.fjzxdz.ams.zphb.module.hbdc.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentAttachParam;
import com.mongodb.client.gridfs.model.GridFSFile;

import java.io.InputStream;

public interface ZpEnvironmentAttachService {

	GridFSFile get(String uuid);

	void remove(String mongoId);

	EnvironmentAttach save(InputStream content, String filename, String fileType, String ObjUuid);

	Page<EnvironmentAttach> listByPage(EnvironmentAttachParam param, Page<EnvironmentAttach> page);

	String saveToMongoDB(InputStream content, String filename, String fileType);

	void update(String uuid, String relation);

	GridFSFile getByRelation(String relation);

	void delByRelation(String relation);

	GridFSFile getByMongoId(String mongoId);

	EnvironmentAttach getAttach(String uuid);
}
