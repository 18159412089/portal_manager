package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.FileAttachmentDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PollutionInfoService;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/city/pollution")
public class CityPolluctionInfoController extends BaseController {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private PollutionInfoService pollutionInfoService;

    /**
     * create by: wudenglin
     * description: 页面跳转;污染源大地图总的污染源
     * create time: 2019/9/11 0011 10:24
     * @Param pid:菜单父菜单uid
     * @Param modelAndView:
     * @return * @return: org.springframework.web.servlet.ModelAndView
     */
    @RequestMapping("/pollutionInfo")
    public ModelAndView getPollutionInfo(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/pollution/pollutionInfo2");
        return modelAndView;
    }

    /*** create by: wudenglin
     * description: TODO(获取地图点位信息)
     * create time: 2019/9/19 0019 15:07
     * @Param pid:
     * @Param modelAndView:
     * @return: org.springframework.web.servlet.ModelAndView
     */
    @RequestMapping("/pollutionPointDataByZl")
    @ResponseBody
    public Map<String, Object> pollutionPointDataByZl(String wryzl, String dw, ModelAndView modelAndView) {
        StringBuilder stringBuilder = new StringBuilder();
        Map<String, Object> dataMap = new HashMap<>();
        stringBuilder.append("select * from CITY_DIRECT_POLLUTION_DATA where wryzl=").append(SqlUtil.toSqlStr(wryzl))
                .append(" and dw=").append(SqlUtil.toSqlStr(dw));
        stringBuilder.append(" and (trim(jd) like  '117%' or trim(jd) like  '118.0%' or trim(jd) like '118.1%')");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString());
        dataMap.put("data", nativeQueryList);

        return dataMap;
    }

    /*** create by: wudenglin
     * description: TODO(获取污染源种类的数值)
     * create time: 2019/9/19 0019 15:07
     * @return: org.springframework.web.servlet.ModelAndView
     */
    @RequestMapping("/pollutionLxCount")
    @ResponseBody
    public Map<String, Object> pollutionLxCount() {
        StringBuilder stringBuilder = new StringBuilder("select p.wryzl zl,count(1) count,dw from CITY_DIRECT_POLLUTION_DATA p ")
                .append(" where (trim(jd) like  '117%' or trim(jd) like  '118.0%' or trim(jd) like '118.1%') group by p.wryzl,dw");
        Map<String, Object> dataMap = new HashMap<>();
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString());
        for(Map<String, Object> map : nativeQueryList){
//            dataMap.put(ChineseConvertPinYin.ToFirstChar(map.get("dw").toString()+map.get("zl")), map.get("count").toString());
            dataMap.put(map.get("dw").toString()+map.get("zl"), map.get("count").toString());
        }

        return dataMap;
    }

    @RequestMapping("/listByMc")
    @ResponseBody
    public PageEU<Map<String, Object>> listByMc(String mc, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sql = new StringBuilder("select distinct p.mc name,p.dw,p.wrylx,p.wryzl,p.mc,p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,p.wcmb_202006,p.wcmb_202012,")
                .append("p.sdzr_zrdw,p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,p.dz,p.jwd,p.jd,p.wd,p.bz from CITY_DIRECT_POLLUTION_DATA p ")
                .append(" where p.jd is not null and p.wd is not null and (p.jd like '%117.%' or p.jd like '%118.0%' or p.jd like '%118.1%') and p.wrylx is not null and (p.mc like '%")
                .append(mc).append("%' or p.qx like '%").append(mc).append("%' or p.wryzl like '%").append(mc).append("%')");

        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sql.toString(), page);
        return new PageEU<>(listPage);
    }

    @Autowired
    private IMongoAttachFile iMongoAttachFile;
    @Autowired
    private FileAttachmentDao fileAttachmentDao;
    /**
     * 保存附件信息
     * @param fileAttachment
     * @param picFile
     * @param request
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    @Transactional(rollbackOn = Exception.class)
    public R save(FileAttachment fileAttachment,String mc,String jd,String wd, @RequestParam("picFile") MultipartFile picFile, HttpServletRequest request) {
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
            stringBuilder.append("select * from POLLUTION_INFO_DATA where mc =" ).append(SqlUtil.toSqlStr(mc));
            stringBuilder.append(" and jd = ").append(SqlUtil.toSqlStr(jd));
            stringBuilder.append(" and wd = ").append(SqlUtil.toSqlStr(wd));
            List<PollutionInfoData> list = simpleDao.getNativeQueryList(stringBuilder.toString(), PollutionInfoData.class);
            if (ToolUtil.isNotEmpty(list)) {
                PollutionInfoData pollutionInfoData = list.get(0);
                fileAttachment.setPkid(pollutionInfoData.getUuid());
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
     * @param uuid
     * @return
     */
    @RequestMapping(value = "/deleteActach")
    @ResponseBody
    @Transactional(rollbackOn = Exception.class)
    public R delete(@RequestParam(value = "uuid", required = true) String uuid,
                    @RequestParam(value = "picture", required = true) String picture) {
        try {
            if (StringUtils.isEmpty(uuid)){
                return R.ok("附件信息记录已经删除！");
            }else{
                fileAttachmentDao.deleteById(uuid);
            }
            if (!StringUtils.isEmpty(picture))iMongoAttachFile.removeFile(picture);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    @RequestMapping(value = "/findTimelineData")
    @ResponseBody
    public R findTimelineData(String mc,String jd,String wd) {
        try {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("select * from POLLUTION_INFO_DATA where mc =" ).append(SqlUtil.toSqlStr(mc));
            stringBuilder.append(" and jd = ").append(SqlUtil.toSqlStr(jd));
            stringBuilder.append(" and wd = ").append(SqlUtil.toSqlStr(wd));
            Map map = Maps.newHashMap();
            List<PollutionInfoData> list = simpleDao.getNativeQueryList(stringBuilder.toString(), PollutionInfoData.class);
            if (ToolUtil.isNotEmpty(list)) {
                PollutionInfoData pollutionInfoData = list.get(0);
                stringBuilder = new StringBuilder(" SELECT * FROM FILE_ATTACHMENT A WHERE A.SOURCE ='pollutionMapInfo'  ")
                        .append(" AND A.PKID =  ").append(SqlUtil.toSqlStr(pollutionInfoData.getUuid()))
                        .append(" ORDER BY A.UPDATE_DATE DESC ");
                List<Map> allTimeLineData = simpleDao.getNativeQueryList(stringBuilder.toString());
                map.put("allTimeLineData", allTimeLineData);
            }
            return R.ok(map);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }
}

