package com.fjzxdz.ams.module.enviromonit.camera.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraData;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("cameraDataDao")
public class CameraDataDao extends PagingDaoSupport<CameraData> {
}
