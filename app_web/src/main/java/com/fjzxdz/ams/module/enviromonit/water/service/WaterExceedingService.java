package com.fjzxdz.ams.module.enviromonit.water.service;


import cn.fjzxdz.frame.pojo.R;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface WaterExceedingService {

    String daysRatio(String start, String end,Integer category);
}
