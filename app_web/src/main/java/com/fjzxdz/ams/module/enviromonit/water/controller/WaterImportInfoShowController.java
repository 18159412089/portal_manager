package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.fjzxdz.ams.module.enviromonit.water.entity.*;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterImportInfoShowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 水环境数据导入展示
 *
 * @Author huangyl
 * @Version 1.0
 * @CreateTime 2019年9月12日10:37:26
 */
@Controller
@RequestMapping("/environment/waterImportInfoShow")
@Secured({"ROLE_USER"})
public class WaterImportInfoShowController extends BaseController {
    @Autowired
    private WaterImportInfoShowService waterImportInfoShowService;
    @RequestMapping("/getWtptLivestockPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getWtptLivestockPageList(WtptLivestock param, HttpServletRequest request){
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtptLivestockPage = waterImportInfoShowService.getWtptLivestockPageList(param, page);
        return new PageEU<>(wtptLivestockPage);
    }

    @RequestMapping("/getWtptPollutionFactorPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getWtptPollutionFactorPageList(WtptPollutionFactor param, HttpServletRequest request){
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtptPollutionFactorPage = waterImportInfoShowService.getWtptPollutionFactorPageList(param, page);
        return new PageEU<>(wtptPollutionFactorPage);
    }

    @RequestMapping("/getWtptWastewaterOutletPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getWtptWastewaterOutletPageList(WtptWastewaterOutlet param, HttpServletRequest request){
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtptWastewaterOutletPage = waterImportInfoShowService.getWtptWastewaterOutletPageList(param, page);
        return new PageEU<>(wtptWastewaterOutletPage);
    }

    @RequestMapping("/getWtptWastewaterPlantPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getWtptWastewaterPlantPageList(WtptWastewaterPlant param, HttpServletRequest request){
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtptWastewaterPlantaPage = waterImportInfoShowService.getWtptWastewaterPlantPageList(param, page);
        return new PageEU<>(wtptWastewaterPlantaPage);
    }

    @RequestMapping("/getWtptWastewaterPageList")
    @ResponseBody
    public PageEU<Map<String, Object>> getWtptWastewaterPageList(WtptWastewater param, HttpServletRequest request){
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> wtptWastewaterPage = waterImportInfoShowService.getWtptWastewaterPageList(param, page);
        return new PageEU<>(wtptWastewaterPage);
    }




}
