/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.factormanual.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.module.enviromonit.factormanual.dao.PeFactorManualDao;
import com.fjzxdz.ams.module.enviromonit.factormanual.entity.PeFactorManual;
import com.fjzxdz.ams.module.enviromonit.factormanual.param.PeFactorManualParam;
import com.fjzxdz.ams.zphb.module.enviromonit.factormanual.service.ZpPeFactorManualService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 污染源手动监控点位采集因子Controller
 * @author gsq
 * @version 2019-09-29
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/factormanual/PeFactorManual")
public class ZpPeFactorManualController extends BaseController {
    @Autowired
    private PeFactorManualDao peFactorManualDao;

    @Autowired
    private ZpPeFactorManualService peFactorManualService;

    /**
     * 跳转页面
     * @return
     */
    @RequestMapping("")
    public String index() {
        return "/zphb/moudles/enviromonit/factormanual/peFactorManualList";
    }

    /**
     * 更新或新增
     * @param peFactorManual
     * @return
     */
    @RequestMapping("/savePeFactorManual")
    @ResponseBody
    public R savePeFactorManual(PeFactorManual peFactorManual) {
        try {
            peFactorManualService.save(peFactorManual);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 按uuid删除
     * @param uuid
     * @return
     */
    @RequestMapping("/deletePeFactorManual")
    @ResponseBody
    public R deletePeFactorManual(@RequestParam(value = "uuid") String uuid) {
        try {
            peFactorManualService.delete(uuid);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    @RequestMapping("/deletePeFactorManualByEqpId")
    @ResponseBody
    public R deletePeFactorManualByEqpId(@RequestParam(value = "pluEqpId") String pluEqpId) {
        try {
            peFactorManualService.deleteByPluEqpId(pluEqpId);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }


    /**
     * 按uuid查询，并返回map
     * @param uuid
     * @return
     */
    @RequestMapping("/getPeFactorManual")
    @ResponseBody
    public Map<String, Object> getPeFactorManual(@RequestParam(value = "uuid") String uuid) {
        PeFactorManual peFactorManual = peFactorManualDao.getById(uuid);
        return BeanUtil.beanToMap(peFactorManual,false,true);
    }

    /**
     * 查询列表
     * @param
     * @param request
     * @return
     */
    @RequestMapping("/peFactorManualList")
    @ResponseBody
    public PageEU<PeFactorManual> peFactorManualList(PeFactorManualParam peFactorManualParam, HttpServletRequest request) {
        Page<PeFactorManual> page = peFactorManualService.listByPage(peFactorManualParam, pageQuery(request));
        return new PageEU<>(page);
    }

    /**
     * 查询列表
     * @param
     * @param request
     * @return
     */
    @RequestMapping("/peFactorManualAllList")
    @ResponseBody
    public JSONObject peFactorManualAllList(PeFactorManualParam peFactorManualParam, HttpServletRequest request) {
        int page = 1;
        int pageSize = 10;
        if(StringUtils.isNotEmpty((String)request.getParameter("page"))) {
            page = Integer.parseInt((String) request.getParameter("page"));
        }
        if(StringUtils.isNotEmpty((String)request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
        }
        //设置过滤条件，查询出漳浦的数据，UnitCode字段只是借用下
        peFactorManualParam.setUnitCode("350623");

        List<PeFactorManual> peFactorManualList = peFactorManualService.getPeFactorManualList(peFactorManualParam, page, pageSize);
        int maxSize = peFactorManualService.countPeFacotrManualSize(peFactorManualParam);
        JSONObject result = new JSONObject();
        result.put("rows", peFactorManualList);
        result.put("total", maxSize);
        result.put("page", page);
        result.put("pageSize", pageSize);
        return result;
    }

    /**
     * 根据pluEqpId获取相对应的条数 ，并返回map
     * @param
     * @return
     */
    @RequestMapping("/getPeFactorManualByPluEqpId")
    @ResponseBody
    public Map<String, Object> getPeFactorManualByPluEqpId(@RequestParam(value = "pluEqpId") String pluEqpId) {
        PeFactorManual peFactorManual = peFactorManualService.getPeFactorManualByPluEqlId(pluEqpId);
        return BeanUtil.beanToMap(peFactorManual,false,true);
    }

    /**
     * 根据排口ID获取污染物上下限值
     * @param outPoint
     * @return
     */
    @RequestMapping("/getPeFactorManualLimit")
    @ResponseBody
    public Map<String, Map<String, Object>> getLimitValueByMonitorPointId(@RequestParam(value = "outPoint") String outPoint) {
        return peFactorManualService.getLimitValueByMonitorPointId(outPoint);
    }

    /**
     * 根据排口ID ，污染源因子编码判断是否有重复因子信息
     * @param outPoint 排口ID
     * @param pluCode  污染源因子编码
     * @return
     */
    @RequestMapping("/isSameFactor")
    @ResponseBody
    public boolean isSameFactor(@RequestParam(value = "outPointId") String outPoint,@RequestParam(value = "pluCode") String pluCode) {
        return peFactorManualService.isSameFactor(outPoint,pluCode);
    }

    /**
     * 获取因子下拉列表
     * @return
     */
    @RequestMapping("/getComponentFactorManual")
    @ResponseBody
    public JSONArray getComponentFactorManual(){
        JSONArray jsonArray = peFactorManualService.getComponentFactorManual();
        return  jsonArray;
    }

}
