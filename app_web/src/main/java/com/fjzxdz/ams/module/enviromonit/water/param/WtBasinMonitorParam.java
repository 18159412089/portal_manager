package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEditEntity;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;

import cn.fjzxdz.frame.common.BaseQueryParam;

public class WtBasinMonitorParam  extends BaseQueryParam{

private static final long serialVersionUID = -1592027072795838675L;
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	public WtBasinMonitorParam() {
		super(WtBasinMonitorEditEntity.class);
		this.clazz = WtDayData.class;
	}

}
