package cn.fjzxdz.frame.entity.core;

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

@Entity
@Table(name = "mongo_attach_file")
public class MongoAttachFile extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	private String fileId;

	private String fileName;

	private String contentType;

	public MongoAttachFile() {

	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
}
