package com.fjzxdz.ams.module.debriefing.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;
/**
 * 
 * 文件信息实体类
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午10:07:03
 */
@Entity
@Table(name = "COMMON_ATTACHMENT")
public class CommonAttachment extends TrackingEntity{
	
	private static final long serialVersionUID = -1769925538835340337L;
	
	@Column(name="FILE_NAME")
	private String fileName;
	
	@Column(name="RELATION_TABLE_ID")
	private String relationTableId;
	
	private String mongoid;


	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRelationTableId() {
		return relationTableId;
	}

	public void setRelationTableId(String relationTableId) {
		this.relationTableId = relationTableId;
	}

	public String getMongoid() {
		return mongoid;
	}

	public void setMongoid(String mongoid) {
		this.mongoid = mongoid;
	}
	
	
	
}
