package com.fjzxdz.ams.module.enviromonit.pollution.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;


@Repository("testDataDao")
public class TestDataDao extends PagingDaoSupport<TestData> {
}
