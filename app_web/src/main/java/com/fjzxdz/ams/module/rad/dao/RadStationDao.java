/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.dao;

import org.springframework.stereotype.Repository;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

import com.fjzxdz.ams.module.rad.entity.RadStation;


/**
 * 辐射基站DAO接口
 * @author lilongan
 * @version 2019-02-19
 */
@Repository("radStation")
public class RadStationDao extends PagingDaoSupport<RadStation> {
	
}
