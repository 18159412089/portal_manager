package com.fjzxdz.ams.zphb.module.hbdc.petitionLetter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * 矿山专项整治
 * @Author   chenbingke
 * @Version   1.0 
 * @CreateTime 2019年9月11日 下午3:54:04
 */
@Controller
@RequestMapping("/zphb/environment/petitionLetter")
public class ZpPetitionLetterController {

    @RequestMapping("")
    public ModelAndView index(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/debriefing/petitionLetter");
        return modelAndView;
    }
}