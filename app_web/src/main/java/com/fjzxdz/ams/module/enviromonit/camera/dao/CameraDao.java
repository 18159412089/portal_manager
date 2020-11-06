package com.fjzxdz.ams.module.enviromonit.camera.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("cameraDao")
public class CameraDao extends PagingDaoSupport<Camera> {
}
