package com.fjzxdz.ams.zphb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fjzxdz.frame.controller.BaseController;

@Controller
@RequestMapping("/zphb")
public class ZphbController extends BaseController {

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {
        return "/zphb/index";
    }

    @RequestMapping("/dataShow")
    private String dataShow(Model model){
        return "zphb/zpDataShow";
    }
}
