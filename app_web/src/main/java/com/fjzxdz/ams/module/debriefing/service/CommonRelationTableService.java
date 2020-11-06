package com.fjzxdz.ams.module.debriefing.service;


import java.util.List;

import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;

import cn.fjzxdz.frame.common.Page;

public interface CommonRelationTableService {

	String save(CommonRelationTable commonRelationTable);

    List<CommonRelationTable> listNoPage(CommonRelationTableParam param);

	Page<CommonRelationTable> listByPage(CommonRelationTableParam param, Page<CommonRelationTable> page);

	String delete(String uuid);

	CommonRelationTable getById(String uuid);


}
