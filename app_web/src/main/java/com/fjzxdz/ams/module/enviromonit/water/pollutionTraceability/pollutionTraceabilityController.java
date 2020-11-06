package com.fjzxdz.ams.module.enviromonit.water.pollutionTraceability;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/environment/pollutionTraceability")
public class pollutionTraceabilityController {
    @Autowired
    private SimpleDao simpleDao;
    @RequestMapping("")
    public ModelAndView index(String pid, ModelAndView modelAndView) {
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/pollutionTraceability/pollutionTraceability");
        return modelAndView;
    }
 /**
  * create by: wudenglin
  * description: 河流溯源页面跳转
  * create time: 2019/9/9 0009 13:58
   * @Param: basinName 从上一个页面跳转过来的数据进行数据查询流域使用
  * @return
  */
    @RequestMapping("/detail")
    public ModelAndView detail(ModelAndView modelAndView,String basinName,String pid) {
        modelAndView.addObject("pid", "d7aa1b75-6893-4091-8452-9c9a1ebf8369");
        if(StringUtils.isNotBlank(pid)){
            modelAndView.addObject("pid", pid);
        }

        modelAndView.addObject("basinName",basinName);
        modelAndView.setViewName("/moudles/enviromonit/water/pollutionTraceability/pollutionTraceabilityDetail");
        return modelAndView;
    }
    /**
  * create by: wudenglin
  * description: 河流溯源页面跳转
  * create time: 2019/9/9 0009 13:58
   * @Param: basinName 从上一个页面跳转过来的数据进行数据查询流域使用第三级页面详情
  * @return
  */
    @RequestMapping("/thirdDetail")
    public ModelAndView thirdDetail(ModelAndView modelAndView,String name,String pid) {
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("name",name);
        modelAndView.setViewName("/moudles/enviromonit/water/pollutionTraceability/pollutionTraceabilityThirdDetail");
        return modelAndView;
    }
    /**
  * create by: wudenglin
  * description: 河流溯源页面跳转
  * create time: 2019/9/9 0009 13:58
   * @Param: basinName 从上一个页面跳转过来的数据进行数据查询流域使用第三级页面详情
  * @return
  */
    @RequestMapping("/findThirdDetailByUUID")
    @ResponseBody
    public List<Map<String,Object>> findThirdDetailByUUID(String uuid,String pointName) {
        if(StringUtils.isBlank(pointName))
            return new ArrayList<>();
        StringBuilder sqlBuilder=new StringBuilder();
        sqlBuilder.append("select * from pollution_info_data_section where  SECTION like '%"+pointName+"%'");
        return simpleDao.getNativeQueryList(sqlBuilder.toString());
    }
    /**
     * @Description:通过流域名称或者河流名称查找该地方的小河流域名称并且
     * 把点位信息布到地图上；
     * @CreateBy: wudenglin
     * @param basinNameOrRiver
     * @return
     */
    @RequestMapping("/getBasinInfoByBasin")
    @ResponseBody
    public List<Map<String,Object>> getBasinInfoByBasin(String basinNameOrRiver){
        if(StringUtils.isBlank(basinNameOrRiver)){
            return  new ArrayList<>();
        }
        StringBuilder stringBuilder=new StringBuilder();
        stringBuilder.append("select * from wt_basin_monitor" );
        stringBuilder.append(" where basin like '%").append(basinNameOrRiver).append("%'");
        stringBuilder.append(" or river like '%").append(basinNameOrRiver).append("%'");
        List<Map<String,Object>> list = simpleDao.getNativeQueryList(stringBuilder.toString());
        return list;
    }


    /**
     * 查找所属流域的常规排口，污水处理厂以及统计数量
     *
     * @param riverName 所属流域名称
     * @return
     */
    @RequestMapping(value = "/findPlantAndOuterList")
    @ResponseBody
    public R findPlantAndOuterList(String riverName) {
        try {
            if (StringUtils.isEmpty(riverName)) {
                return R.error("所属流域名称为空！");
            } else {
                //污水处理厂
                StringBuilder wsclSql = new StringBuilder();
                wsclSql.append("  SELECT B.DWMC WSCLC,b.* ");
                wsclSql.append(" FROM  WTPT_WASTEWATER_PLANT B ");
                wsclSql.append("  WHERE B.SNSTMC LIKE '%").append(riverName.trim()).append("%'");
                List<Map> wsclcList = simpleDao.getNativeQueryList(wsclSql.toString());
                convertLatLng(wsclcList);

                //常规排口
                StringBuilder cgpkSql = new StringBuilder();
                cgpkSql.append("  SELECT B.pwkmc cgpk,b.* FROM ");
                cgpkSql.append("   WTPT_WASTEWATER_OUTLET B ");
                cgpkSql.append("  WHERE B.SNSTMC LIKE '%").append(riverName.trim()).append("%' ");
                List<Map> cgpkList = simpleDao.getNativeQueryList(cgpkSql.toString());
                convertLatLng(cgpkList);
                Map resultMap = new HashMap();
                resultMap.put("wsclc", wsclcList);
                resultMap.put("cgpk", cgpkList);
               return R.ok(resultMap);

            }
        } catch (Exception e) {
            return R.error(e.getMessage());
        }

    }

    /**
     * 经纬度转换
     * @param wsclcList
     */
    private void convertLatLng(List<Map> wsclcList) {
        String lon1;
        String lon2;
        String lon3;
        String lat1;
        String lat2;
        String lat3;
        for (int i = 0; i < wsclcList.size(); i++) {
            Map map = wsclcList.get(i);
            lon1 = MapUtils.getString(map, "longitude1").trim();
            lon2 = MapUtils.getString(map, "longitude2").trim();
            lon3 = MapUtils.getString(map, "longitude3").replace(".", "").trim();
            lat1 = MapUtils.getString(map, "latitude1").trim();
            lat2 = MapUtils.getString(map, "latitude2").trim();
            lat3 = MapUtils.getString(map, "latitude3").replace(".", "").trim();
            double l2 = new BigDecimal(lon2).doubleValue() / 60;
            double l3 = new BigDecimal(lon3).doubleValue() / 3600;
            double lt2 = new BigDecimal(lat2).doubleValue() / 60;
            double lt3 = new BigDecimal(lat3).doubleValue() / 3600;
            map.put("lat", new BigDecimal(lat1).doubleValue() + lt2 + lt3);
            map.put("lng", new BigDecimal(lon1).doubleValue() + l2 + l3);

        }
    }
}
