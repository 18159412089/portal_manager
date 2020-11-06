/*   
 * Copyright (c) 2015-2020 FuJianZhongXingDianzi. All Rights Reserved.   
 *   
 * This software is the confidential and proprietary information of   
 * Founder. You shall not disclose such Confidential Information   
 * and shall use it only in accordance with the terms of the agreements   
 * you entered into with Founder.   
 *   
 */ 
package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;

/**   
 * 这里描述这个类是做什么业务 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月30日 上午9:54:58   
 */
public interface ZpAirSiteHourDataService {
	
	 Page<AirSiteHourData> listByPage(AirSiteHourDataParam airSiteHourDataParam, Page<AirSiteHourData> page);
}
