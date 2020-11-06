package com.fjzxdz.ams.module.enviromonit.pollution.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;


@Repository("envCompanyDao")
public class EnvCompanyDao extends PagingDaoSupport<EnvCompany> {
}
