package com.fjzxdz.ams.module.distributeMap.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;
import com.fjzxdz.ams.module.distributeMap.entity.EnvironmeentMapDistribution;

import java.util.List;
import java.util.Map;

/**
 * 
 * 分布地图接口
 * @Author   huangyangl
 * @Version   1.0 
 * @CreateTime 2019年7月15日15:28:20
 */
public interface DistributeMapService {
	/**
	 * 通过项目id查找之前之后的附件信息 图片视频等
	 * @param page
	 * @return
	 */
	Page<Map<String, Object>> listByPage(Page<Map<String, Object>> page);


	/**
	 * 分布地图所有信息
	 * @return
	 * @param param
	 */
	List list(EnvironmentRectifition param);

	/**
	 * 保存文件信息
	 * @param mapDistribution
	 */
    void save(EnvironmeentMapDistribution mapDistribution);

	/**
	 * 删除文件信息
	 * @param uuid
	 */
	void delete(String uuid);

	/**
	 * 获取分布地图的文件及点位信息
	 * @param page
	 * @param param
	 * @return
	 */
	Page<Map<String, Object>> getFilePage(Page<Map<String, Object>> page, EnvironmeentMapDistribution param);

	Page<Map<String, Object>> getListPage(Page<Map<String, Object>> page, EnvironmentRectifition param);

	List getRoundList(String type);
}
