package com.fjzxdz.ams.module.enviromonit.pollution.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;


@Repository("pointDao")
public class PointDao extends PagingDaoSupport<Point> {
}
