package com.fjzxdz.ams.module.enviromonit.water.service;

import java.util.List;
import java.util.Map;

import com.fjzxdz.ams.module.enviromonit.water.entity.WaterAttachment;
import com.fjzxdz.ams.module.enviromonit.water.param.WaterAttachmentParam;

import cn.fjzxdz.frame.common.Page;

public interface WaterAttachmentService {
	
	Page<WaterAttachment> listByPage(WaterAttachmentParam param, Page<WaterAttachment> page);

	void save(WaterAttachment waterAttachment);

	WaterAttachment getById(String uuid);
	
	void delete(String uuid);

	List<WaterAttachment> getAttachments(String pointCode);
}
