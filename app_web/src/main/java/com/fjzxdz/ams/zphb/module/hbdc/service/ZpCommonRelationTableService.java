package com.fjzxdz.ams.zphb.module.hbdc.service;


import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;

import java.util.List;

public interface ZpCommonRelationTableService {

	String save(CommonRelationTable commonRelationTable);

    List<CommonRelationTable> listNoPage(CommonRelationTableParam param);

	Page<CommonRelationTable> listByPage(CommonRelationTableParam param, Page<CommonRelationTable> page);

	String delete(String uuid);

	CommonRelationTable getById(String uuid);


}
