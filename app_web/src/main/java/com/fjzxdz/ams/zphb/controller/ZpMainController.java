package com.fjzxdz.ams.zphb.controller;

import cn.fjzxdz.frame.constant.TestData;
import cn.fjzxdz.frame.controller.BaseController;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/zphb/mainPage")
public class ZpMainController extends BaseController {

    @RequestMapping("/main.do")
    public ModelAndView enter(@RequestParam(value = "type", required = false)String type, ModelAndView model) throws UnsupportedEncodingException {
        if (StringUtils.isNotEmpty(type)) {
            model.addObject("type", type);
        }else {
            model.addObject("type", null);
        }
        String titleName = getRequest().getParameter("titleName");
        if(StringUtils.isNotEmpty(titleName)){
            titleName =java.net.URLDecoder.decode(titleName,"UTF-8");
        }
        model.setViewName("/zphb/zpMain");
        model.addObject("titleName",titleName);
        return model;
    }

    @RequestMapping("/testData.do")
    @ResponseBody
    public String testData(HttpServletRequest request){
        String typeStr = request.getParameter("type");
        String testData = "";
        if("ZPMANAGE".equals(typeStr)){
            testData = TestData.ZPMANAGE;
        }
        JSONArray tableData = JSONArray.parseArray(testData);
        return tableData.toString();
    }

}
