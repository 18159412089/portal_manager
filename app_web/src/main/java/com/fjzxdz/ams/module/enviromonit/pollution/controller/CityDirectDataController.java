package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.CityPollutionDirectEnum;
import com.fjzxdz.ams.module.enums.PollutionInfoCountyEnum;
import com.fjzxdz.ams.module.enums.PollutionInfoDataWrylxEnum;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.CityDirectPollutionData;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.CityDirectPollutionDataService;
import com.fjzxdz.ams.module.enviromonit.pollution.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

/**
 * 水环境-应急短信下发-水质问题整改任务派发
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:57:31
 */
@Controller
@RequestMapping("/env/pollution2/cityDirect")
@Secured({"ROLE_USER"})
public class CityDirectDataController extends BaseController {
    @Autowired
    private DataService dataService;
    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private CityDirectPollutionDataService cityDirectPollutionDataService;

    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView, String pid) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/cityDirectPollutionData");
        return modelAndView;
    }

    /**
     * @param file
     * @param request
     * @return cn.fjzxdz.frame.pojo.R
     * @Author lianhuinan
     * @Description //TODO(污染源数据——excel导入)
     * @Date 2019/10/11 0011 11:17
     * @version 1.0
     **/
    @RequestMapping("/importFile")
    @ResponseBody
    public R importFile(@RequestParam(name = "xlsxfile") MultipartFile file, HttpServletRequest request)
            throws Exception {
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String prefix = fileName.substring(0, fileName.lastIndexOf("."));
        String message = "";
        File excelFile = null;
        try {
            excelFile = File.createTempFile(prefix, suffix);
            file.transferTo(excelFile);
            List<List<Object>> result = getExcelContent(excelFile);
            message = cityDirectPollutionDataService.save(result, getUserPidPath());
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("导入失败：" + e.getMessage() + "！\n注意：有多行空数据，请使用官方提供模板上传数据。");
        } finally {
            deleteFile(excelFile);
        }
        if (message != "") {
            return R.error("导入失败：" + message);
        }
        return R.ok("导入成功");
    }

    /**
     * @param excelFile
     * @return void
     * @Author lianhuinan
     * @Description //TODO(删除临时文件)
     * @Date 2019/10/11 0011 11:15
     * @version 1.0
     **/
    private void deleteFile(File... excelFile) {
        for (File file : excelFile) {
            if (file.exists()) {
                file.delete();
            }
        }
    }

    /**
     * @param excelFile
     * @return java.util.List<java.util.List < java.lang.Object>>
     * @Author lianhuinan
     * @Description //TODO(获取excel文件的内容)
     * @Date 2019/10/11 0011 11:18
     * @version 1.0
     **/
    public List<List<Object>> getExcelContent(File excelFile) throws Exception {
        FileInputStream fileInputStream = null;
        if (excelFile.isFile() && excelFile.exists()) {
            String suffix = excelFile.getName().substring(excelFile.getName().lastIndexOf("."));
            if (".xls".equals(suffix) || ".xlsx".equals(suffix)) {
                fileInputStream = new FileInputStream(excelFile);
            } else {
                throw new Exception("文件类型错误！");
            }
        }

        ExcelReader reader = ExcelUtil.getReader(fileInputStream);
        List<List<Object>> lists = reader.read();
        if (ToolUtil.isNotEmpty(lists)) {
            for (List list : lists) {
                if (ToolUtil.isEmpty(list.get(0))) {
                    lists.remove(list);
                }
            }
        }
        return lists;
    }

    /**
     * 污染源数据信息  --分页
     *
     * @param pollutionInfoData 参数集合
     * @param request
     * @return
     */
    @RequestMapping("/getInfoPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getBasinNameByArea(PollutionInfoData pollutionInfoData, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(" SELECT * FROM CITY_DIRECT_POLLUTION_DATA WHERE 1=1 ");
        if (StringUtils.isNotEmpty(pollutionInfoData.getMc())) {
            sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
        }
        List deptName = getUserDeptName2();
        if (deptName != null) {
            sqlBuilder.append(" and dw in (").append(SqlUtil.toSqlIn(deptName)).append(") ");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWryzl())) {
            sqlBuilder.append(" and WRYZL in ('" + pollutionInfoData.getWryzl().replaceAll(",", "','") + "')");
        }
        sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");
        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);
        return new PageEU<>(listPage);
    }

    /**
     * create by: wudenglin
     * description: 页面跳转
     * create time: 2019/11/11 0011 16:20
     *
     * @Param modelAndView:
     * @Param pid:
     * @return: org.springframework.web.servlet.ModelAndView
     */
    @RequestMapping("/cityDirectPollutionMap")
    @ResponseBody
    public ModelAndView getPollutionInfoMapPage(ModelAndView modelAndView, String pid) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/cityDirectPollutionMap");
        return modelAndView;
    }

    /**
     * 市直察污染原类型
     *
     * @return
     */
    @RequestMapping("/getInfoToMap")
    @ResponseBody
    public List<Map<String, Object>> getInfomationToMap(CityDirectPollutionData pollutionInfoData) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(" SELECT * FROM CITY_DIRECT_POLLUTION_DATA WHERE 1=1 ");

        List deptName = getUserDeptName2();
        if (deptName != null) {
            sqlBuilder.append(" and dw in (").append(SqlUtil.toSqlIn(deptName)).append(") ");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getMc())) {
            sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWryzl())) {
            sqlBuilder.append(" and WRYZL in ('" + pollutionInfoData.getWryzl().replaceAll(",", "','") + "')");
        }
        sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");
        return simpleDao.getNativeQueryList(sqlBuilder.toString());
    }

    /**
     * create by: wudenglin
     * description: TODO计算每个城镇的污染源总数;
     * create time: 2019/11/11 0011 15:38
     *
     * @return: com.alibaba.fastjson.JSONObject
     */
    @RequestMapping("/countPollutionByArea")
    @ResponseBody
    public JSONObject countPollutionByArea() throws InterruptedException, ExecutionException {
        ;

        Future<JSONArray> ssqyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.涉水工业企业.getKey(), PollutionInfoDataWrylxEnum.涉水工业企业.getParant());
        Future<JSONArray> vocsqyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.VOCs企业.getKey(), PollutionInfoDataWrylxEnum.VOCs企业.getParant());
        Future<JSONArray> gywxfwFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.工业危险废物.getKey(), PollutionInfoDataWrylxEnum.工业危险废物.getParant());
        Future<JSONArray> slwqyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.散乱污企业.getKey(), PollutionInfoDataWrylxEnum.散乱污企业.getParant());
        Future<JSONArray> hygygtfwFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.涉海工业固废.getKey(), PollutionInfoDataWrylxEnum.涉海工业固废.getParant());
        Future<JSONArray> hypwkFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.海洋排污口.getKey(), PollutionInfoDataWrylxEnum.海洋排污口.getParant());
        Future<JSONArray> gygfFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.工业固废.getKey(), PollutionInfoDataWrylxEnum.工业固废.getParant());
        Future<JSONArray> sbchyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.石板材行业.getKey(), PollutionInfoDataWrylxEnum.石板材行业.getParant());
        Future<JSONArray> czksFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.持证矿山.getKey(), PollutionInfoDataWrylxEnum.持证矿山.getParant());
        Future<JSONArray> gjyqyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.高架源企业.getKey(), PollutionInfoDataWrylxEnum.高架源企业.getParant());
        Future<JSONArray> sghfcFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.三格化粪池.getKey(), PollutionInfoDataWrylxEnum.三格化粪池.getParant());
        Future<JSONArray> fdlydyFuture = cityDirectPollutionDataService.countPollutionByArea(getUserDeptName2(), PollutionInfoDataWrylxEnum.非道路移动源.getKey(), PollutionInfoDataWrylxEnum.非道路移动源.getParant());

        JSONObject result = new JSONObject(2);
        List<String> county = new ArrayList<>(PollutionInfoCountyEnum.values().length);
        List<String> abridge = new ArrayList<>(PollutionInfoCountyEnum.values().length);
        List<String> jd = new ArrayList<>(PollutionInfoCountyEnum.values().length);
        List<String> wd = new ArrayList<>(PollutionInfoCountyEnum.values().length);
        for (PollutionInfoCountyEnum countyEnum : PollutionInfoCountyEnum.values()) {
            county.add(countyEnum.getKey());
            abridge.add(countyEnum.getAbridge());
            jd.add(countyEnum.getJd());
            wd.add(countyEnum.getWd());
        }
        result.put("county", county);
        result.put("abridge", abridge);
        result.put("jd", jd);
        result.put("wd", wd);

        while (true) {
            if (ssqyFuture.isDone() && vocsqyFuture.isDone() && gjyqyFuture.isDone() && sbchyFuture.isDone()
                    && gygfFuture.isDone() && gywxfwFuture.isDone() && slwqyFuture.isDone() && hypwkFuture.isDone()
                    && hygygtfwFuture.isDone() && czksFuture.isDone() && sghfcFuture.isDone() && fdlydyFuture.isDone()) {
                JSONObject temp = new JSONObject();
                temp.put(PollutionInfoDataWrylxEnum.涉水工业企业.getValue(), ssqyFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.VOCs企业.getValue(), vocsqyFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.工业危险废物.getValue(), gywxfwFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.工业固废.getValue(), gygfFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.散乱污企业.getValue(), slwqyFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.涉海工业固废.getValue(), hygygtfwFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.海洋排污口.getValue(), hypwkFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.石板材行业.getValue(), sbchyFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.持证矿山.getValue(), czksFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.高架源企业.getValue(), gjyqyFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.三格化粪池.getValue(), sghfcFuture.get());
                temp.put(PollutionInfoDataWrylxEnum.非道路移动源.getValue(), fdlydyFuture.get());
                result.put("data", temp);
                break;
            }
            Thread.sleep(100);
        }
        return result;
    }

    /**
     * 保存修改污染源数据信息
     *
     * @param pollutionInfoData
     */
    @RequestMapping(value = "/saveInfo")
    @ResponseBody
    public R saveInfo(CityDirectPollutionData pollutionInfoData) {
        try {
            pollutionInfoData.setDeptPath(getUserPidPath());
            String patternValid = cityDirectPollutionDataService.patternValid(pollutionInfoData);
            if (StringUtils.isNotEmpty(patternValid)) {
                return R.error(patternValid);
            } else {
                cityDirectPollutionDataService.saveInfo(pollutionInfoData);
            }
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 删除污染源数据信息
     *
     * @param pkid
     * @return
     */
    @RequestMapping(value = "/deleteInfo")
    @ResponseBody
    public R deleteCompanyInfo(@RequestParam(value = "pkid", required = true) String pkid) {
        try {
            if (org.springframework.util.StringUtils.isEmpty(pkid)) {
                return R.ok("污染源数据信息已经删除！");
            } else {
                cityDirectPollutionDataService.deleteInfo(pkid);
            }
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * @param flag (wryzl为污染源种类，wrylx为污染源类型)
     * @return String
     * @throws
     * @Title: getType
     * @Description: 获取污染源种类，污染源类型
     * @CreateBy: hyl
     * @CreateTime: 2019年10月12日10:14:47
     * @UpdateBy: hyl
     * @UpdateTime: 2019年10月12日10:14:56
     */
    @RequestMapping("/getType")
    @ResponseBody
    public String getCity(@RequestParam(value = "flag", required = true) String flag) {
        StringBuilder sql = new StringBuilder(" SELECT DISTINCT ").append(flag)
                .append(" wryzl FROM CITY_DIRECT_POLLUTION_DATA WHERE  ").append(flag).append(" IS NOT NULL ");
        if ("wryzl".equals(flag)) {
            sql.append("and wryzl in ('持证矿山','散乱污企业','工业固废','涉海工业固废','工业危险废物','VOCs企业','涉水工业企业',"
                    + "'海洋排污口','高架源企业','石板材行业','非道路移动源','三格化粪池')");
        }
        List<PollutionInfoData> list = simpleDao.getNativeQueryList(sql.toString(), PollutionInfoData.class);
        com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();

        if (list != null) {
            for (PollutionInfoData pollutionInfoData : list) {
                JSONObject area = new JSONObject();
                area.put("uuid", pollutionInfoData.getWryzl());
                area.put("name", pollutionInfoData.getWryzl());
                array.add(area);
            }
        }

        return array.toJSONString();
    }
    /**
     * create by: wudenglin
     * description: 获取查询类型;污染源录入人员搜索查看类型(获取污染源类型)
     * create time: 2019/10/10 0010 15:24
     *
     * @Param parterName:
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/getCityPollutionType")
    @ResponseBody
    public List<Map<String, Object>> getPollutionType(ModelAndView modelAndView) {
        Map<String, Object> dataMap = null;
        List<Map<String, Object>> datalist = new ArrayList<>();
        for (CityPollutionDirectEnum pollution : CityPollutionDirectEnum.values()) {
            dataMap = new HashMap<>();
            dataMap.put("text", pollution.getKey());
            datalist.add(dataMap);
        }
        return datalist;
    }

    /**
     * @MethodName: dynamicCountCityDirectPollutionInfo
     * @Description: 动态查询市直查所有单位下的污染源种类以及汇总
     * @param
     * @return: java.util.List<java.util.Map>
     * @Author: huangyl
     * @CreatedDate: 2019/11/15 0015 下午 3:51
     **/
    @RequestMapping(value = "/dynamicCountCityDirectPollutionInfo")
    @ResponseBody
    public List<Map> dynamicCountCityDirectPollutionInfo() {
        return cityDirectPollutionDataService.dynamicCountCityDirectPollutionInfo();
    }
}
