package cn.fjzxdz.frame.mongo.service;

import java.io.InputStream;

import com.mongodb.client.gridfs.model.GridFSFile;

import cn.fjzxdz.frame.entity.core.MongoAttachFile;

public interface IMongoAttachFile {

	MongoAttachFile saveFile(InputStream content, String filename, String contentType);

	GridFSFile getFile(String uuid);

	void removeFile(String uuid);

}
