package com.fjzxdz.ams.zphb.module.enviromonit.cameraMap.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * create by: wudenglin
 * description: 污染源数据处理
 * create time: 2019/10/5 0005 8:58
 */
@Controller
@RequestMapping("/zphb/cameraMap")
@Secured({"ROLE_USER"})
public class ZpCameraMapController extends BaseController {

    @Autowired
    private SimpleDao simpleDao;

    @RequestMapping(value = "/zpCamera", method = RequestMethod.GET)
    public String zpCameraMap(Model model) {
        return "zphb/zpCamera";
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(根据污染源的类型)
     * @Date 2019/10/5 0005 17:27
     * @param lx
     * @param qx
     * @return java.util.List<java.util.Map>
     * @version 1.0
     **/
    @RequestMapping("getPolluteAll")
    @ResponseBody
    public List<Map> getAll(String lx,String qx){
        List<Map> list = simpleDao.getNativeQueryList("select distinct p.uuid, p.CHANNEL_IDS, p.mc name,\n" +
                "                p.qx,p.wrylx,p.wryzl,p.mc,\n" +
                "                p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,\n" +
                "                p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,\n" +
                "                p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,\n" +
                "                p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,\n" +
                "                p.dz,p.jwd,p.jd,p.wd,p.bz\n" +
                "from POLLUTION_INFO_DATA p\n" +
                "where p.WRYLX = '"+lx+"'\n" +
                "  and p.QX = '"+qx+"'");
        return list;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(根据污染源的类型)
     * @Date 2019/10/5 0005 17:27
     * @param lx
     * @param qx
     * @return java.util.List<java.util.Map>
     * @version 1.0
     **/
    @RequestMapping("getPolluteList")
    @ResponseBody
    public PageEU<Map> getAllList(String lx, String qx,String mc, HttpServletRequest request) {
        if(StringUtils.isEmpty(mc)){
            mc = null;
        }
        StringBuilder whereStr = new StringBuilder(" where 1=1 ");
        if(StringUtils.isNotEmpty(lx)){
            whereStr.append(" and p.WRYLX = '"+lx+"' ");
        }
        if(StringUtils.isNotEmpty(mc)){
            whereStr.append(" and p.MC like '%"+mc+"%' ");
        }
        if(StringUtils.isNotEmpty(qx)){
            whereStr.append(" and p.QX = '"+qx+"' ");
        }
        whereStr.append(" ORDER BY    SEQNO   asc");
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> listPage = simpleDao.listNativeByPage("select distinct p.uuid,p.CHANNEL_IDS, p.mc name,\n" +
                "                p.qx,p.wrylx,p.wryzl,p.mc,\n" +
                "                p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,\n" +
                "                p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,\n" +
                "                p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,\n" +
                "                p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,\n" +
                "                p.dz,p.jwd,p.jd,p.wd,p.bz,p.SEQNO\n" +
                " from POLLUTION_INFO_DATA p\n" +
                whereStr.toString(), page);
        return new PageEU(listPage);
    }

    /**
     * @Author lianhuinan
     * @Description 根据企业ID获取企业信息
     * @Date 2019/10/5 0005 17:27
     * @param uuid
     * @return java.util.List<java.util.Map>
     * @version 1.0
     **/
    @RequestMapping("getPollutionEnterpriseInfoById")
    @ResponseBody
    public List<Map> getPollutionEnterpriseInfoById(String uuid, HttpServletRequest request) {
        List<Map> list = simpleDao.getNativeQueryList("select distinct p.uuid, p.CHANNEL_IDS, p.mc name,\n" +
                "                p.qx,p.wrylx,p.wryzl,p.mc,\n" +
                "                p.czwt,p.zgcs,p.zlxm,p.wcmb_201912,\n" +
                "                p.wcmb_202006,p.wcmb_202012,p.sdzr_zrdw,\n" +
                "                p.sdzrdw_zrrlxfs,p.bmzr_zrdw,p.bmzrdw_zrrlxfs,\n" +
                "                p.bmzr_phzrdw,p.phzrdw_zrrlxfs,p.xz,\n" +
                "                p.dz,p.jwd,p.jd,p.wd,p.bz\n" +
                "from POLLUTION_INFO_DATA p\n" +
                "where p.uuid = '"+uuid+"'");

        return list;
    }
}
