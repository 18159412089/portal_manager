package com.fjzxdz.ams.module.enviromonit.water.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtPolicy;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("wtPolicyDao")
public class WtPolicyDao extends PagingDaoSupport<WtPolicy> {

}
