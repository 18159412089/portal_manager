package com.fjzxdz.ams.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirConstructionSite;
import com.fjzxdz.ams.module.enviromonit.air.param.AirConstructionSiteParam;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;

import java.util.List;
import java.util.Map;
/**
 * 
 * 工地空气质量 接口
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午3:58:50
 */
public interface AirConstructionSiteService {
	
	/**
	 * 
	 * @Title:  getConstructionInfo
	 * @Description:    获取工地信息     
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午3:57:24
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午3:57:24    
	 * @return  List<AirConstructionSite> 
	 * @throws
	 */
	List<AirConstructionSite> getConstructionInfo(String deptName);

	/**
	 * 
	 * @Title:  listByPage
	 * @Description:    获取工地信息分页列表   
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年6月15日 下午1:40:19
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年6月15日 下午1:40:19    
	 * @param param
	 * @param page
	 * @return  Page<AirConstructionSite> 
	 * @throws
	 */
	Page<AirConstructionSite> listByPage(AirConstructionSiteParam param, Page<AirConstructionSite> page);

    Page<Map<String, Object>> getFileAttachPage(Page<Map<String, Object>> page, Map paramMap);

    void save(FileAttachment fileAttachment);

	void delete(String uuid);

	/**
	 * 保存修改工地信息
	 * @param airConstructionSite
	 */
    void saveCompanyInfo(AirConstructionSite airConstructionSite);

	void deleteCompanyInfo(String pkid);
}
