package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import com.fjzxdz.ams.module.enviromonit.water.dao.WtCityMinuteDataDao;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityMinuteDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class WtCityMinuteDataServiceImpl implements WtCityMinuteDataService {

    @Autowired
    private WtCityMinuteDataDao wtCityMinuteDataDao;
}
