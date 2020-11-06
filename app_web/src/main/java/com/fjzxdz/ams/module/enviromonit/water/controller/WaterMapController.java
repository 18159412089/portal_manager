package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/enviromonit/water")
@Secured({ "ROLE_USER" })
public class WaterMapController extends BaseController {

	@RequestMapping("/nationalSurfaceWater")
	public ModelAndView index(String pid,String target,String basinCode,String waterPointCode,ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("target",target);
        modelAndView.addObject("basinCode",basinCode);
        modelAndView.addObject("waterPointCode",waterPointCode);
        modelAndView.setViewName("/moudles/enviromonit/water/nationalSurfaceWater");
        return modelAndView;
	}

    @RequestMapping("/nationalSurfaceWater/river")
    public String river() {
        return "/moudles/enviromonit/water/nationalSurfaceWaterWithRiver";
    }
	
    @RequestMapping("/nationalSurfaceWater/detail")
    public ModelAndView waterDetail(ModelAndView modelAndView,String waterPointCode,String pid) {
        modelAndView.addObject("waterPointCode", waterPointCode);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/nationalSurfaceWater");
        return modelAndView;
    }
    @RequestMapping("/wastewaterFileAttachment")
    public ModelAndView wastewaterFileAttachment(ModelAndView modelAndView,String companyName,String pid) {
        modelAndView.addObject("companyName", companyName);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/wastewaterFileAttachment");
        return modelAndView;
    }
    @RequestMapping("/wastewaterCompanySet")
    public ModelAndView wastewaterCompanySet(ModelAndView modelAndView,String qymc,String pid) {
        modelAndView.addObject("qymc", qymc);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/wastewaterCompanySet");
        return modelAndView;
    }


}
