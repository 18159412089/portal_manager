package com.fjzxdz.ams.module.jobSchedule.service;

import com.fjzxdz.ams.module.jobSchedule.entity.VehiclePollution;
import com.fjzxdz.ams.module.jobSchedule.param.VehiclePollutionParam;

import cn.fjzxdz.frame.common.Page;

/**
 * 
 * 车辆污染service
 * 
 * @Author
 * @Version 1.0
 * @CreateTime
 */
public interface VehiclePollutionService {

    /**
     * 
     * @Title:  listByPage
     * @Description:    分页查询
     * @CreateBy: 
     * @CreateTime: 
     * @UpdateBy: caibai 
     * @UpdateTime:  2019年5月8日 上午10:12:37    
     * @param param
     * @param page
     * @return  Page<VehiclePollution> 
     * @throws
     */
    Page<VehiclePollution> listByPage(VehiclePollutionParam param, Page<VehiclePollution> page);

    /**
     * 
     * @Title:  save
     * @Description:    保存   
     * @CreateBy: 
     * @CreateTime: 
     * @UpdateBy: caibai 
     * @UpdateTime:  2019年5月8日 上午10:13:05    
     * @param vehiclePollution  void 
     * @throws
     */
    void save(VehiclePollution vehiclePollution);

    /**
     * 
     * @Title:  getById
     * @Description:    根据id获取    
     * @CreateBy: 
     * @CreateTime: 
     * @UpdateBy: caibai 
     * @UpdateTime:  2019年5月8日 上午10:13:25    
     * @param uuid
     * @return  VehiclePollution 
     * @throws
     */
    VehiclePollution getById(String uuid);
    /**
     * 
     * @Title:  delete
     * @Description:    删除
     * @CreateBy: 
     * @CreateTime: 
     * @UpdateBy: caibai 
     * @UpdateTime:  2019年5月8日 上午10:14:12    
     * @param uuid  void 
     * @throws
     */
    void delete(String uuid);

}
