package com.fjzxdz.ams.module.enviromonit.pollution.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;


@Repository("factorDao")
public class FactorDao extends PagingDaoSupport<Factor> {
}
