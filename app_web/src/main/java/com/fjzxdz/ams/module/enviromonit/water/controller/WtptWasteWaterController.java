package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @program: portal_manager
 * @className: WtptWasteWaterController
 * @description: TODO
 * @author: lianhuinan
 * @create: 2019-09-09 13:25
 * @version: 1.0
 */
@Controller
@RequestMapping("/enviromonit/wtpt/wastewater")
public class WtptWasteWaterController extends BaseController {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * @Author lianhuinan
     * @Description //TODO(获取废水企业top10数据)
     * @Date 2019/9/9 0009 14:45
     * @param
     * @return java.util.ArrayList<java.util.Map < java.lang.String, java.lang.Object>>
     * @version 1.0
     **/
    @RequestMapping("/getRanking")
    @ResponseBody
    public ArrayList<Map<String, Object>> getWtptRanking(){
        StringBuilder sql = new StringBuilder("select rownum,t.* from (select a.dwmc,a.FSPFL,substr(a.psqxlx, 3, length(a.psqxlx)) psqxlx from WTPT_WASTEWATER a order by a.FSPFL desc) t where rownum < 11");
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
        if(ToolUtil.isNotEmpty(list)){

            return (ArrayList<Map<String, Object>>) list;
        }
        return new ArrayList<>(0);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取污水处理厂top5数据)
     * @Date 2019/9/9 0009 14:45
     * @param
     * @return java.util.ArrayList<java.util.Map<java.lang.String,java.lang.Object>>
     * @version 1.0
     **/
    @RequestMapping("/getPlantRanking")
    @ResponseBody
    public ArrayList<Map<String, Object>> getPlantRanking(){
        StringBuilder sql = new StringBuilder("select rownum,t.* from (select distinct m.NAME,m.actual_daily_capacity actual,m.allow_plu_let allow, m.update_time,(m.actual_daily_capacity - m.allow_plu_let) dis " +
                "from PE_CON_DAY_DATA c left join PE_MONITOR_POINT m on c.OUTPUT_ID = m.OUTPUT_ID " +
                "where c.OUTFALL_TYPE = 1 and m.NAME like '%污水处理厂%' and m.allow_plu_let > 0 order by dis desc) t where rownum < 6");
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
        if(ToolUtil.isNotEmpty(list)){

            return (ArrayList<Map<String, Object>>) list;
        }
        return new ArrayList<>(0);
    }
}
