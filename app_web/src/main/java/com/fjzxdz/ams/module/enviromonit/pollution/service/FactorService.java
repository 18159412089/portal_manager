package com.fjzxdz.ams.module.enviromonit.pollution.service;

import java.util.List;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;
import com.fjzxdz.ams.module.enviromonit.pollution.param.FactorParam;

import cn.fjzxdz.frame.common.Page;


public interface FactorService {

	Factor getById(String uuid);

	List<Factor> getFactorList(String pointCode);

	Page<Factor> listByPage(FactorParam param, Page<Factor> page);
}
