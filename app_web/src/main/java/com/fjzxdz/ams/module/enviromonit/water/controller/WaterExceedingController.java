package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterExceedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author shenliuyuan
 * @title: 水超标天数
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/6/2610:25
 */
@Controller
@RequestMapping("/environment/waterExceeding")
public class WaterExceedingController extends BaseController {
    @Autowired
    private WaterExceedingService waterExceedingService;

    /**
     * 超标天数比例
     */
    @RequestMapping("/daysRatio")
    @ResponseBody
    public String daysRatio(String start, String end ,Integer category) {
       return waterExceedingService.daysRatio(start,end,category);
    }

}
