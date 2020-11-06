package com.fjzxdz.ams.module.enviromonit.pollution.service;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;

import cn.fjzxdz.frame.common.Page;


public interface EnvCompanyService {

	EnvCompany getById(String uuid);

    Page<EnvCompany> listByPage(EnvCompanyParam param, Page<EnvCompany> page);
}
