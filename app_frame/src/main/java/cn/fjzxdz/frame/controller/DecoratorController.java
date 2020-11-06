package cn.fjzxdz.frame.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/decorator")
public class DecoratorController  {

    @RequestMapping(value = "/index")
    public ModelAndView index(ModelMap modelMap, HttpServletRequest request) {
        return new ModelAndView("decorators/index");
    }
}
