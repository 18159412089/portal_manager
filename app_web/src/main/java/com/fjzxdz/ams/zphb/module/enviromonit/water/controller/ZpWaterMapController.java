package com.fjzxdz.ams.zphb.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/zphb/enviromonit/water")
@Secured({ "ROLE_USER" })
public class ZpWaterMapController extends BaseController {
/** create by: wudenglin
 * description: 页面跳转这个页面是水环境服务
 * create time: 2019/10/4 0004 17:50
 * @Param pid:
 * @Param target:
 * @Param basinCode:
 * @Param waterPointCode:
 * @Param modelAndView:
 * @return: org.springframework.web.servlet.ModelAndView
 */

	@RequestMapping("/nationalSurfaceWater")
	public ModelAndView index(String pid,String target,String basinCode,String waterPointCode,ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("target",target);
        modelAndView.addObject("basinCode",basinCode);
        modelAndView.addObject("waterPointCode",waterPointCode);
        modelAndView.setViewName("/zphb/moudles/enviromonit/water/nationalSurfaceWater");
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
        modelAndView.setViewName("/zphb/moudles/enviromonit/water/wastewaterFileAttachment");
        return modelAndView;
    }
    @RequestMapping("/wastewaterPlantFileAttachment")
    public ModelAndView wastewaterPlantFileAttachment(ModelAndView modelAndView,String companyName,String pid) {
        modelAndView.addObject("companyName", companyName);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/zphb/moudles/enviromonit/water/wastewaterPlantFileAttachment");
        return modelAndView;
    }
    @RequestMapping("/wastewaterCompanySet")
    public ModelAndView wastewaterCompanySet(ModelAndView modelAndView,String qymc,String pid) {
        modelAndView.addObject("qymc", qymc);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/zphb/moudles/enviromonit/water/wastewaterCompanySet");
        return modelAndView;
    }


}
