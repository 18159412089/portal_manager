package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enums.PollutionInfoCountyEnum;
import com.fjzxdz.ams.module.enums.PollutionInfoDataWrylxEnum;
import com.fjzxdz.ams.module.enums.PollutionInfoDataWryzlEnum;
import com.fjzxdz.ams.module.enviromonit.air.dao.FileAttachmentDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PollutionInfoService;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;
import com.google.common.collect.Maps;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

@Controller
@RequestMapping("/env/pollution2")
public class PolluctionInfoController2 extends BaseController {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private PollutionInfoService pollutionInfoService;

    @Autowired
    private DeptService deptService;

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图总的污染源
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfo")
    public ModelAndView getPollutionInfo(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图总的污染源
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/cityPollution")
    public ModelAndView getCityPollution(String pid, String name, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("name", name);
        modelAndView.setViewName("/moudles/pollution/cityPollution");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大气部分
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfodq")
    public ModelAndView getPollutionInfoForDQ(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2dq");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图水环境部分
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfos")
    public ModelAndView getPollutionInfoForS(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2s");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图土壤部分
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfotr")
    public ModelAndView getPollutionInfoFortr(String pid, String type, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("type", type);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2tr");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图海洋部分
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfohy")
    public ModelAndView getPollutionInfoForhy(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2hy");
        return modelAndView;
    }

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图生态部分
     * create time: 2019/9/11 0011 10:24
     *
     * @return * @return: org.springframework.web.servlet.ModelAndView
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     */
    @RequestMapping("/pollutionInfost")
    public ModelAndView getPollutionInfoForst(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2st");
        return modelAndView;
    }

    @RequestMapping("/listByMc")
    @ResponseBody
    public PageEU<Map<String, Object>> listByMc(String mc, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sql = new StringBuilder("select distinct p.mc name,p.qx,p.wrylx,p.wryzl,p.mc,p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,")
                .append("p.sdzr_zrdw,p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,p.dz,p.jwd,p.jd,p.wd,p.bz from POLLUTION_INFO_DATA p ")
                .append(" where p.jd is not null and p.wd is not null and (p.jd like '%117.%' or p.jd like '%118.0%' or p.jd like '%118.1%') and p.wrylx is not null and (p.mc like '%")
                .append(mc).append("%' or p.qx like '%").append(mc).append("%' or p.wryzl like '%").append(mc).append("%')");

        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sql.toString(), page);
        return new PageEU<>(listPage);
    }

    /**
     * @param
     * @return com.alibaba.fastjson.JSONObject
     * @Author lianhuinan
     * @Description //TODO(获取污染源大地图的区县划分数据)
     * @Date 2019/9/19 0019 17:40
     * @version 1.0
     **/
    @RequestMapping("/countPollutionByArea")
    @ResponseBody
    public JSONObject countPollutionByArea() throws InterruptedException, ExecutionException {
        Future<JSONArray> ssqyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.涉水工业企业.getKey(), PollutionInfoDataWrylxEnum.涉水工业企业.getParant());
        Future<JSONArray> vocsqyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.VOCs企业.getKey(), PollutionInfoDataWrylxEnum.VOCs企业.getParant());
        Future<JSONArray> gywxfwFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.工业危险废物.getKey(), PollutionInfoDataWrylxEnum.工业危险废物.getParant());
        Future<JSONArray> slwqyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.散乱污企业.getKey(), PollutionInfoDataWrylxEnum.散乱污企业.getParant());
        Future<JSONArray> hygygtfwFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.涉海工业固废.getKey(), PollutionInfoDataWrylxEnum.涉海工业固废.getParant());
        Future<JSONArray> hypwkFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.海洋排污口.getKey(), PollutionInfoDataWrylxEnum.海洋排污口.getParant());
        Future<JSONArray> gygfFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.工业固废.getKey(), PollutionInfoDataWrylxEnum.工业固废.getParant());
        Future<JSONArray> sbchyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.石板材行业.getKey(), PollutionInfoDataWrylxEnum.石板材行业.getParant());
        Future<JSONArray> czksFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.持证矿山.getKey(), PollutionInfoDataWrylxEnum.持证矿山.getParant());
        Future<JSONArray> gjyqyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.高架源企业.getKey(), PollutionInfoDataWrylxEnum.高架源企业.getParant());
        Future<JSONArray> sghfcFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.三格化粪池.getKey(), PollutionInfoDataWrylxEnum.三格化粪池.getParant());
        Future<JSONArray> fdlydyFuture = pollutionInfoService.countPollutionByArea(PollutionInfoDataWrylxEnum.非道路移动源.getKey(), PollutionInfoDataWrylxEnum.非道路移动源.getParant());

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

    @RequestMapping("/getEnterpriseByQxAndLxAndZl")
    @ResponseBody
    public PageEU<Map<String, Object>> getEnterpriseByQxAndLxAndZl(String qx, String lx, String zl, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sql = new StringBuilder("select distinct p.mc name,p.qx,p.wrylx,p.wryzl,p.mc,p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,p.dz,p.jwd,p.jd,p.wd,p.bz from POLLUTION_INFO_DATA p ")
                .append(" where p.jd is not null and p.wryzl is not null and p.wd is not null and (p.jd like '%117.%' or p.jd like '%118.0%' or p.jd like '%118.1%') and p.wrylx is not null and p.qx='").append(qx).append("'")
                .append(" and p.wrylx='").append(lx).append("' and p.wryzl='").append(zl).append("'");

        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sql.toString(), page);
        return new PageEU<>(listPage);
    }

    @RequestMapping("/getEnterpriseByQxAndLxAndZlCount")
    @ResponseBody
    public JSONObject getEnterpriseByQxAndLxAndZlCount(String qx, String lx, String zl, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sql = new StringBuilder("select WRYZL name,WRYLX,count(*) count from (select distinct p.mc name,p.qx,p.wrylx,p.wryzl,")
                .append(" p.mc,p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,p.sdzrdw_zrrlxfs,")
                .append(" p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,p.dz,p.jwd,p.jd,p.wd,p.bz")
                .append(" from POLLUTION_INFO_DATA p where p.jd is not null and p.wryzl is not null and p.wd is not null and (p.jd like '%117.%' ")
                .append(" or p.jd like '%118.0%' or p.jd like '%118.1%') and p.wrylx is not null and p.qx='").append(qx).
                        append("') group by WRYZL,WRYLX");

        List<Map<String, Object>> result = simpleDao.getNativeQueryList(sql.toString());
        JSONObject data = new JSONObject(result.size());
        for (Map map : result) {
            data.put(map.get("name").toString(), map.get("count"));
        }
        return data;
    }

    /**
     * create by: wudenglin
     * description: TODO
     * create time: 2019/11/11 0011 15:11
     * 获取地图数据;
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/pollutionPointData")
    @ResponseBody
    public Map<String, Object> polluctionPointData() {
        StringBuilder stringBuilder = null;
        Map<String, Object> dataMap = new HashMap<>();
        for (PollutionInfoDataWrylxEnum pollution : PollutionInfoDataWrylxEnum.values()) {
            stringBuilder = new StringBuilder();
            stringBuilder.append("select * from POLLUTION_INFO_DATA where wryzl=" + SqlUtil.toSqlStr(pollution.getKey()));
            stringBuilder.append(" and (trim(jd) like  '117%' or trim(jd) like  '118.0%' or trim(jd) like '118.1%')");
            List<PollutionInfoData> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString(), PollutionInfoData.class);
            dataMap.put(pollution.getValue(), nativeQueryList);
        }
        return dataMap;
    }

    @Autowired
    private IMongoAttachFile iMongoAttachFile;
    @Autowired
    private FileAttachmentDao fileAttachmentDao;

    /**
     * 保存附件信息
     *
     * @param fileAttachment
     * @param picFile
     * @param request
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    @Transactional(rollbackOn = Exception.class)
    public R save(FileAttachment fileAttachment, String mc, String jd, String wd, @RequestParam("picFile") MultipartFile picFile, HttpServletRequest request) {
        try {
            String originFilename = picFile.getOriginalFilename();
            MongoAttachFile mongoAttachFile = null;
            if (ToolUtil.isNotEmpty(originFilename)) {
                mongoAttachFile = iMongoAttachFile.saveFile(picFile.getInputStream(),
                        StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
                fileAttachment.setPicture(mongoAttachFile.getUuid());
                fileAttachment.setPicname(mongoAttachFile.getFileName());
            }
            StringBuilder stringBuilder = new StringBuilder();
            String table = "POLLUTION_INFO_DATA";
            if ("cityPollutionMapInfo".equals(fileAttachment.getSource())) table = "CITY_DIRECT_POLLUTION_DATA";
            stringBuilder.append("select * from ").append(table).append(" where mc =").append(SqlUtil.toSqlStr(mc));
            stringBuilder.append(" and jd = ").append(SqlUtil.toSqlStr(jd));
            stringBuilder.append(" and wd = ").append(SqlUtil.toSqlStr(wd));
            List<Map> list = simpleDao.getNativeQueryList(stringBuilder.toString());
            if (ToolUtil.isNotEmpty(list)) {
                Map map = list.get(0);
                fileAttachment.setPkid(MapUtils.getString(map, "uuid"));
            }
            fileAttachment.setUuid(null);
            fileAttachmentDao.save(fileAttachment);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 删除，删除对象和图片信息
     *
     * @param uuid
     * @param picture
     * @return
     */
    @RequestMapping(value = "/deleteActach")
    @ResponseBody
    @Transactional(rollbackOn = Exception.class)
    public R delete(@RequestParam(value = "uuid", required = true) String uuid,
                    @RequestParam(value = "picture", required = true) String picture) {
        try {
            if (StringUtils.isEmpty(uuid)) {
                return R.ok("附件信息记录已经删除！");
            } else {
                fileAttachmentDao.deleteById(uuid);
            }
            if (!StringUtils.isEmpty(picture)) iMongoAttachFile.removeFile(picture);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }


    /**
     * 查找时间轴信息 --图片  污染源大地图  市直查
     *
     * @param mc
     * @param jd
     * @param wd
     * @param source
     * @return
     */
    @RequestMapping(value = "/findTimelineData")
    @ResponseBody
    public R findTimelineData(String mc, String jd, String wd, String source) {
        try {
            StringBuilder stringBuilder = new StringBuilder();
            String table = "POLLUTION_INFO_DATA";
            if ("cityPollutionMapInfo".equals(source)) table = "CITY_DIRECT_POLLUTION_DATA";
            stringBuilder.append("select * from ").append(table).append(" where mc =").append(SqlUtil.toSqlStr(mc));
            stringBuilder.append(" and jd = ").append(SqlUtil.toSqlStr(jd));
            stringBuilder.append(" and wd = ").append(SqlUtil.toSqlStr(wd));
            Map map = Maps.newHashMap();
            List<Map> list = simpleDao.getNativeQueryList(stringBuilder.toString());
            if (ToolUtil.isNotEmpty(list)) {
                Map obj = list.get(0);
                stringBuilder = new StringBuilder(" SELECT * FROM FILE_ATTACHMENT A WHERE 1=1 ");
                if (!StringUtils.isEmpty(source)) {
                    stringBuilder.append(" AND  A.SOURCE =  ").append(SqlUtil.toSqlStr(source));
                }
                stringBuilder.append(" AND A.PKID =  ").append(SqlUtil.toSqlStr(MapUtils.getString(obj, "uuid")));
                stringBuilder.append(" ORDER BY A.UPDATE_DATE DESC ");
                List<Map> allTimeLineData = simpleDao.getNativeQueryList(stringBuilder.toString());
                map.put("allTimeLineData", allTimeLineData);
            }
            return R.ok(map);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }

    /**
     * create by: wudenglin
     * description: TODO
     * create time: 2019/10/10 0010 15:24
     *
     * @Param parterName:
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/pollutionDepartment")
    @ResponseBody
    public ModelAndView skitToPollutionFtl(ModelAndView modelAndView, String pid, String type, String qx) {
        modelAndView.setViewName("/moudles/pollution/pollutionDepartment");
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("type", type);
        modelAndView.addObject("skipqx", qx);
        return modelAndView;
    }
    //================================================污染源漳州录入人员查看录入情况===================

    /**
     * create by: wudenglin
     * description: 获取查询类型;污染源录入人员搜索查看类型(获取污染源类型)
     * create time: 2019/10/10 0010 15:24
     *
     * @Param parterName:
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/getPollutionType")
    @ResponseBody
    public List<Map<String, Object>> getPollutionType(ModelAndView modelAndView) {
        Map<String, Object> dataMap = null;
        List<Map<String, Object>> datalist = new ArrayList<>();
        for (PollutionInfoDataWrylxEnum pollution : PollutionInfoDataWrylxEnum.values()) {
            dataMap = new HashMap<>();
            dataMap.put("text", pollution.getKey());
            datalist.add(dataMap);
        }
        return datalist;
    }

    /**
     * create by: wudenglin
     * description: 获取污染源数据通过登录人的uuid
     * create time: 2019/10/11 0011 9:11
     *
     * @Param wryzl: 污染源种类
     * @Param companyName:
     * @Param request:
     * @return: cn.fjzxdz.frame.toolbox.page.PageEU<java.util.Map < java.lang.String, java.lang.Object>>
     */
    @RequestMapping(value = "/getPollutionByLoginName")
    @ResponseBody
    public PageEU<Map<String, Object>> getPollutionByLoginName(String type, PollutionInfoData pollutionInfoData, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sqlBuilder = new StringBuilder();
        CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
        sqlBuilder.append(" SELECT * FROM POLLUTION_INFO_DATA WHERE 1=1 ");
        if (type.equals("county")) {
            sqlBuilder.append(" and CREATE_USER = '").append(getUserId()).append("' ");
        }
        if (type.equals("dept")) {
            List list = new ArrayList();
            for (Dept dept : deptService.getDeptByUserId(getUser().getUuid())) {
                list.add(dept.getName());
            }
            sqlBuilder.append(" and QX in (").append(SqlUtil.toSqlIn(list)).append(") ");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getMc())) {
            sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWryzl())) {
            sqlBuilder.append(" and WRYZL in ('" + pollutionInfoData.getWryzl().replaceAll(",", "','") + "')");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getQx())) {
            sqlBuilder.append(" and QX in ('" + pollutionInfoData.getQx().replaceAll(",", "','") + "')");
        }
        sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");
        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);
        return new PageEU<>(listPage);
    }

    @RequestMapping("/getAllPollutionByLoginName")
    @ResponseBody
    public List<Map<String, Object>> getAllPollutionByLoginName(String type, PollutionInfoData pollutionInfoData, HttpServletRequest request) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(" SELECT * FROM POLLUTION_INFO_DATA WHERE 1=1 ");
        if (type.equals("county")) {
            sqlBuilder.append(" and CREATE_USER = '").append(getUserId()).append("' ");
        }

        if (type.equals("dept")) {
            List list = new ArrayList();
            for (Dept dept : deptService.getDeptByUserId(getUser().getUuid())) {
                list.add(dept.getName());
            }
            sqlBuilder.append(" and QX in (").append(SqlUtil.toSqlIn(list)).append(") ");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getMc())) {
            sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getQx())) {
            sqlBuilder.append(" and QX in ('" + pollutionInfoData.getQx().replaceAll(",", "','") + "')");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWryzl())) {
            sqlBuilder.append(" and WRYZL in ('" + pollutionInfoData.getWryzl().replaceAll(",", "','") + "')");
        }
        sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");
        return simpleDao.getNativeQueryList(sqlBuilder.toString());
    }

    @RequestMapping("/getAllPollutionCity")
    @ResponseBody
    public List<Map<String, Object>> getAllPollutionCity(String wryzl, PollutionInfoData companyName) {
        List<Map<String, Object>> datalist = new ArrayList<>();
        Map<String, Object> dataMap = null;
        String userDeptName = getUserDeptName();
        for (PollutionInfoCountyEnum name : PollutionInfoCountyEnum.values()) {
            dataMap = new HashMap<>();
            if (!StringUtils.isEmpty(userDeptName) && userDeptName.equals(name.getKey())) {
                dataMap.put("name", name.getKey());
                datalist.add(dataMap);
            }
            if (StringUtils.isEmpty(userDeptName)) {
                dataMap.put("name", name.getKey());
                datalist.add(dataMap);
            }
        }

        return datalist;
    }


    /**
     * 获取排污口名称list 污染源大地图详情页一企一档
     *
     * @param outFall --查找排口 OUTFALL_TYPE：1=水，2=气
     * @param peName
     * @return List<Map>
     */
    @RequestMapping("/getSewageOutletList")
    @ResponseBody
    public List<Map> getSewageOutletList(String peName, String outFall) {
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT P.OUTPUT_ID||','||E.PE_ID id, P.NAME ");
        sql.append(" FROM PE_MONITOR_POINT P ");
        sql.append("          INNER JOIN PE_ENTERPRISE_DATA E ON P.PE_ID = E.PE_ID ");
        sql.append(" WHERE PE_NAME =  ").append(SqlUtil.toSqlStr(peName));
        sql.append("   AND P.OUTFALL_TYPE =  ").append(SqlUtil.toSqlStr(outFall));
        List<Map> list = simpleDao.getNativeQueryList(sql.toString());
        return list;
    }

    /**
     * 获取污染物list 污染源大地图详情页一企一档
     *
     * @param peId
     * @param pluType 查找污染物及其单位  PLU_TYPE：1=水，2=气
     * @return
     */
    @RequestMapping("/getContaminantList")
    @ResponseBody
    public List<Map> getContaminantList(String peId, String pluType) {
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT DISTINCT A.PLU_CODE, A.PLU_NAME, PCC.NAME  ");
        sql.append(" FROM PE_FACTOR A  ");
        sql.append("          LEFT JOIN PE_MONITOR_POINT B ON A.OUTPUT_ID = B.OUTPUT_ID AND B.STATUS = 1  ");
        sql.append("          LEFT JOIN PE_ENTERPRISE_DATA C ON B.PE_ID = C.PE_ID AND C.STATUS = 1  ");
        sql.append("          LEFT JOIN PE_COMMON_CODE PCC ON A.UNIT_CODE = PCC.ID  ");
        sql.append(" WHERE A.STATUS = 1  ");
        sql.append("   AND A.PLU_TYPE =   ").append(SqlUtil.toSqlStr(pluType));
        sql.append("   AND A.IS_USED = 1  ");
        if (!StringUtils.isEmpty(peId)) {
            sql.append("   AND C.PE_ID =   ").append(SqlUtil.toSqlStr(peId));
        }
        sql.append(" ORDER BY A.PLU_CODE ASC  ");
        List<Map> list = simpleDao.getNativeQueryList(sql.toString());
        return list;
    }

    /**
     * 获取一企一档详情页的表格信息
     *
     * @param outfallType
     * @param pluCode
     * @param time
     * @param request
     * @param outputId
     * @return
     */
    @RequestMapping("/getOneEnterpriseListPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getOneEnterpriseListPage(String outfallType, String pluCode, String time, HttpServletRequest request, String outputId) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(" select c.OUTPUT_ID, m.NAME, to_char(c.MEASURE_TIME, 'yyyy-mm-dd hh24:mi:ss') time, d.PLU_NAME, c.CHROMA_AVG ");
        sqlBuilder.append(" from PE_MONITOR_POINT m ");
        sqlBuilder.append("          inner join PE_CON_HOUR_DATA c on m.OUTPUT_ID = c.OUTPUT_ID  ");

        if (!StringUtils.isEmpty(time)) {
            sqlBuilder.append("    and      c.MEASURE_TIME >= TO_DATE(").append(SqlUtil.toSqlStr(time)).append(", 'yyyy-mm-dd hh24:mi:ss') and ");
            sqlBuilder.append("          c.MEASURE_TIME <= TO_DATE(").append(SqlUtil.toSqlStr(time)).append(", 'yyyy-mm-dd hh24:mi:ss')  ");
        }
        if (!StringUtils.isEmpty(pluCode)) {
            sqlBuilder.append("  and     c.PLU_CODE in( ").append(SqlUtil.toSqlStr(pluCode)).append(") ");
        }
        sqlBuilder.append(" LEFT JOIN PE_FACTOR D ON C.PLU_CODE = D.PLU_CODE AND D.PLU_EQP_ID=C.PE_ID AND D.PLU_CODE=C.OUTFALL_TYPE  ");
        sqlBuilder.append(" where c.OUTFALL_TYPE =  ").append(SqlUtil.toSqlStr(outfallType));
        sqlBuilder.append("   and m.OUTPUT_ID =").append(SqlUtil.toSqlStr(outputId));
        sqlBuilder.append(" order by c.OUTPUT_ID, c.MEASURE_TIME desc, c.PLU_CODE asc ");
        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);
        return new PageEU<>(listPage);
    }
//=================污染源实时数据展示

    /**
     * create by: wudenglin
     * description: 污染源实时数据页面跳转
     * create time: 2019/10/10 0010 15:24
     *
     * @Param parterName:
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/pollutionDataShow")
    @ResponseBody
    public ModelAndView skitToPollutionDataShow(ModelAndView modelAndView, String pid) {
        modelAndView.setViewName("/moudles/pollution/pollutionDataShow");
        modelAndView.addObject("pid", pid);
        return modelAndView;
    }

    /*** create by: wudenglin
     * description: TODO
     * create time: 2019/11/14 0014 11:21
     */
    @RequestMapping(value = "/countPollutionData")
    @ResponseBody
    public Map<String, Object> countPollutionData(PollutionInfoData pollutionInfoData) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select count(WRYLX) count,WRYLX from POLLUTION_INFO_DATA ")
                .append("where (trim(jd) like  '117%' or trim(jd) like  '118.0%' ")
                .append("or trim(jd) like '118.1%') and wryzl is not null and wrylx is not null group by WRYLX");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString());
        Map<String, Object> dataMap = new HashMap<>();
        int countPollution = 0;
        for (Map<String, Object> map : nativeQueryList) {
            for (PollutionInfoDataWryzlEnum pollutionEnum : PollutionInfoDataWryzlEnum.values()) {
                if (MapUtils.getString(map,"wrylx","").equals(pollutionEnum.getKey())) {
                    dataMap.put(pollutionEnum.getValue(), map.get("count"));
                    countPollution += Integer.valueOf(MapUtils.getString(map,"count","0"));
                }
            }
        }
        dataMap.put("countPollution", countPollution);
        return dataMap;
    }
    /*** create by: wudenglin
     * description: 污染原类型实时数据展示页面数据datagrid部分
     * create time: 2019/11/14 0014 13:55
     * @Param type:
     * @Param pollutionInfoData:
     * @Param request:
     * @return: cn.fjzxdz.frame.toolbox.page.PageEU<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @RequestMapping(value = "/pollutionPageData")
    @ResponseBody
    public PageEU<Map<String, Object>> pollutionPageData(PollutionInfoData pollutionInfoData,String export,String updateTime, HttpServletRequest request,HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append(" SELECT * FROM POLLUTION_INFO_DATA WHERE 1=1 ");
        if (!StringUtils.isEmpty(pollutionInfoData.getMc())) {
            sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWryzl())) {
            sqlBuilder.append(" and WRYZL in ('" + pollutionInfoData.getWryzl().replaceAll(",", "','") + "')");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getWrylx())) {
            sqlBuilder.append(" and WRYLX in ('" + pollutionInfoData.getWrylx().replaceAll(",", "','") + "')");
        }
        if (!StringUtils.isEmpty(pollutionInfoData.getQx())) {
            sqlBuilder.append(" and QX in ('" + pollutionInfoData.getQx().replaceAll(",", "','") + "')");
        }
        if(!StringUtils.isEmpty(updateTime)){
            sqlBuilder.append(" and ").append(SqlUtil.toSqlStr(updateTime)).append(" =to_Char(update_date,'yyyy-mm-dd')");
        }
        sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");

        if(ToolUtil.isNotEmpty(export) && export.equals("yes")) {
            List<Map> lists=simpleDao.getNativeQueryList(sqlBuilder.toString());
            List<Map> result = new ArrayList<>(lists.size());
            for (Map map : lists) {
                LinkedHashMap<String, Object> temp = new LinkedHashMap<>();
                temp.put("qx",map.get("qx"));
                temp.put("wrylx",map.get("wrylx"));
                temp.put("wryzl",map.get("wryzl"));
                temp.put("mc",map.get("mc"));
                temp.put("czwt",map.get("czwt"));
                temp.put("zgcs",map.get("zgcs"));
                temp.put("zlxm",map.get("zlxm"));
                temp.put("wcmb201912",map.get("wcmb201912"));
                temp.put("wcmb202006",map.get("wcmb202006"));
                temp.put("wcmb202012",map.get("wcmb202012"));
                temp.put("sdzrZrdw",map.get("sdzrZrdw"));
                temp.put("sdzrdwZrrlxfs",map.get("sdzrdwZrrlxfs"));
                temp.put("bmzrZrdw",map.get("bmzrZrdw"));
                temp.put("bmzrdwZrrlxfs",map.get("bmzrdwZrrlxfs"));
                temp.put("bmzrPhzrdw",map.get("bmzrPhzrdw"));
                temp.put("phzrdwZrrlxfs",map.get("phzrdwZrrlxfs"));
                temp.put("xz",map.get("xz"));
                temp.put("dz",map.get("dz"));
                temp.put("jd",map.get("jd"));
                temp.put("wd",map.get("wd"));
                temp.put("bz",map.get("bz"));
                result.add(map);
            }
            return exportExl(response, result);
        }
        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);

        return new PageEU<>(listPage);
    }
/** create by: wudenglin
 * create time: 2019/11/15 0015 10:31
 * description:
 * @Param response:
 * @Param list:
 * @return: cn.fjzxdz.frame.toolbox.page.PageEU<java.util.Map < java.lang.String, java.lang.Object>>
 */
    private PageEU<Map<String, Object>> exportExl(HttpServletResponse response, List<Map> list) {
        // 定义Excel 字段名称
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", "漳州市污染源数据导出表");

        columnMap.put("qx","区县");
        columnMap.put("wrylx","污染源类型");
        columnMap.put("wryzl","污染源种类");
        columnMap.put("mc","名称");
        columnMap.put("czwt","存在问题");
        columnMap.put("zgcs","整改措施");
        columnMap.put("zlxm","治理项目");
        columnMap.put("wcmb201912","完成目标2019年12月底");
        columnMap.put("wcmb202006","完成目标2020年06月底");
        columnMap.put("wcmb202012","完成目标2020年12月底");
        columnMap.put("sdzrZrdw","属地责任单位");
        columnMap.put("sdzrdwZrrlxfs","属地责任单位责任人及联系方式");
        columnMap.put("bmzrZrdw","部门责任责任单位");
        columnMap.put("bmzrdwZrrlxfs","部门责任责任单位责任人及联系方式");
        columnMap.put("bmzrPhzrdw","部门责任配合责任单位");
        columnMap.put("phzrdwZrrlxfs","部门责任配合责任单位责任人及联系方式");
        columnMap.put("xz","乡镇");
        columnMap.put("dz","单位");
        columnMap.put("jd","经度");
        columnMap.put("wd","纬度");
        columnMap.put("bz","备注");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /**
     * @MethodName: dynamicCountPollutionInfo
     * @Description: 动态查询污染源类型下的污染源种类以及汇总
     * @param
     * @return: java.util.List<java.util.Map>
     * @Author: huangyl
     * @CreatedDate: 2019/11/15 0015 下午 3:51
     **/
    @RequestMapping(value = "/dynamicCountPollutionInfo")
    @ResponseBody
    public List<Map> dynamicCountPollutionInfo() {
        return pollutionInfoService.dynamicCountPollutionInfo();
    }

}

