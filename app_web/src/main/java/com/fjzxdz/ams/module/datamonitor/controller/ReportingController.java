package com.fjzxdz.ams.module.datamonitor.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.util.IdUtil;
import com.fjzxdz.ams.module.datamonitor.entity.Reporting;
import com.fjzxdz.ams.module.datamonitor.param.ReportingParam;
import com.fjzxdz.ams.module.datamonitor.service.ReportingService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author shenliuyuan
 * @title: 信息汇报
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/8/1914:56
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/dataMonitor/DataMonitor/")
public class ReportingController extends BaseController {

    @Autowired
    private ReportingService reportingService;

    @RequestMapping("/reporting")
    public String reporting() {
        return "/moudles/datamonitor/reporting";
    }

    //跳转查看信息汇报页面
    @RequestMapping("/reportingContent")
    public String reportingContent(String uuid,HttpServletRequest request) {
        request.setAttribute("reporting",reportingService.getById(uuid).get(0));
        return "/moudles/datamonitor/reportingContent";
    }

    //跳转修改汇报页面
    @RequestMapping("/updateContent")
    public String updateContent(String uuid,HttpServletRequest request) {
        if (StringUtils.isEmpty(uuid)) {
            return "/moudles/datamonitor/reporting";
        }else{
            request.setAttribute("reporting", reportingService.getById(uuid).get(0));
            return "/moudles/datamonitor/updateContent";
        }
    }

    //跳转添加信息汇报页面
    @RequestMapping("/insertContent")
    public String insertContent(Reporting  reporting) {
        return "/moudles/datamonitor/insertContent";
    }


    /**
     * 更新或新增
     *
     * @return
     */
    @RequestMapping("/saveReporting")
    @ResponseBody
    public Map<String, Object> saveReporting(Reporting reporting,HttpServletRequest request) {
        Map<String, Object> map=new HashMap();
        try {
            String time = request.getParameter("time");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            reporting.setCreateTime(sdf.parse(time));
            reportingService.save(reporting);
        } catch (Exception e) {
            map.put("status",300);
            map.put("msg","服务器异常");
            return map;
        }
        map.put("status",200);
        map.put("msg","保存成功");
        return map;
    }

    /**
     * 按uuid删除
     *
     * @param uuid
     * @return
     */
    @RequestMapping("/deleteReporting")
    @ResponseBody
    public Map<String, Object> deleteReporting(@RequestParam(value = "uuid") String uuid) {
        Map<String, Object> map=new HashMap();
        try {
            reportingService.delete(uuid);
        } catch (Exception e) {
            map.put("status",300);
            map.put("msg","服务器异常");
            return map;
        }
        map.put("status",200);
        map.put("msg","删除成功");
        return map;
    }

    /**
     * 按uuid查询，并返回map
     *
     * @param uuid
     * @return
     */
    @RequestMapping("/getReporting")
    @ResponseBody
    public List<Object> getReporting(@RequestParam(value = "uuid") String uuid) {
        return reportingService.getById(uuid);
    }

    /**
     * 查询列表
     *
     * @param
     * @param request
     * @return
     */
    @RequestMapping("/reportingList")
    @ResponseBody
    public PageEU<Map<String, Object>> findList(ReportingParam param, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> airDataPage = reportingService.findList(param, page,response);
        if (ToolUtil.isEmpty(airDataPage)) return null;
        return new PageEU<>(airDataPage);
    }

    /**
     * 富文本上传（图片映射在WebMvcConfig.java的addResourceHandlers方法）
     * @param request
     * @param response
     *//*
    @ResponseBody
    @RequestMapping(value = "layEditUpload")
    @SuppressWarnings("unchecked")
    public Map<String,Object> LayEditUpload(HttpServletRequest request, HttpServletResponse response) {
        Map<String,Object> result = uploadMuiFile(request);
        Map<String, Object> map = new HashMap<>();
        if ((int)result.get("status") == 200) {
            LinkedHashMap<String, Object> lhm = (LinkedHashMap<String, Object>) result.get("data");
            map.put("code", 0);
            Map<String, Object> map1 = new HashMap<>();
            map1.put("src", lhm.get("path"));
            map1.put("title", lhm.get("fileName"));
            map.put("data", map1);
            System.out.println(map);
            return  map;
        } else {
            return  map;
        }
    }
    *//**
     * request流上传文件
     * @param request
     *//*
    public static Map<String,Object> uploadMuiFile(HttpServletRequest request) {
        try {
            Map<String, Object> result = new HashMap<>();
            Map<String, Object> paramMap = new LinkedHashMap<>();
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile file = null;
            Iterator<String> iter = multipartRequest.getFileNames();
            while (iter.hasNext()) {
                file = multipartRequest.getFile(iter.next());
            }
            if (null != file && !file.isEmpty()) {
                // 执行上传
                // 获取文件名(去除空格)
                String name = file.getOriginalFilename().replaceAll(" ", "");
                String fileName = file.getOriginalFilename().replaceAll(" ", "");
                fileName = IdUtil.fastUUID()+fileName;
                String s = ".";
                if (fileName.lastIndexOf(s) >= 0) {
                    String path = fileUp1(file, "C:\\imgFile\\", fileName);
                    if (!StringUtils.isBlank(path)) {
                        paramMap.put("url", "C:\\imgFile\\" + fileName); // 物理路径
                        paramMap.put("fileName", name); // 文件名
                        paramMap.put("path", "/upload/" + fileName); // 映射后的路径
                        result.put("status",200);
                        result.put("msg","操作成功");
                        result.put("data",paramMap);
                        return result;
                    }
                }
            }
            result.put("status",300);
            result.put("msg","上传失败");
            result.put("data","失败");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> result = new HashMap<>();
            result.put("status",500);
            result.put("msg","系统错误");
            return result;
        }
    }
    *//**
     * 上传文件
     * @param file       文件对象
     * @param sourcePath 上传路径
     * @param fileName   文件名
     *//*
    public static String fileUp1(MultipartFile file, String sourcePath, String fileName) {
        try {
            return copyFile(file.getInputStream(), sourcePath, fileName).replaceAll("-", "");
        } catch (IOException e) {
            System.out.println(e);
            return "";
        }
    }

    *//**
     * 写文件到当前目录的upload目录中
     * @param in
     * @param realName
     * @throws IOException
     *//*
    private static String copyFile(InputStream in, String dir, String realName) throws IOException {
        File file = mkdirsmy(dir, realName);
        FileUtils.copyInputStreamToFile(in, file);
        return realName;
    }

    *//**
     * 判断路径是否存在，否：创建此路径
     * @param dir      文件路径
     * @param realName 文件名
     * @throws IOException
     *//*
    public static File mkdirsmy(String dir, String realName) throws IOException {
        File file = new File(dir, realName);
        if (!file.exists()) {
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            file.createNewFile();
        }
        return file;
    }*/
}
