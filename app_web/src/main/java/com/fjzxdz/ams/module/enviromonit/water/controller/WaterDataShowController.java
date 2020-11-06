package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.NumUtil;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterDataShowService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import javassist.tools.reflect.ClassMetaobject;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.persistence.Query;
import java.util.*;

@Controller
@RequestMapping("/environment/waterDataShow")

public class WaterDataShowController extends BaseController {
    @Autowired
    WaterDataShowService waterDataShowService;

    @RequestMapping("")
    public String index() {
        return "/moudles/enviromonit/water/waterDataShow";
    }

    /**
     * 这里就放回一个比例值就行了
     * 获取测试数据的平均数据然后对比就ok
     * 达标比例
     * 通过测试
     *
     * @return
     */
    @RequestMapping("/ReachStandardScale")
    @ResponseBody
    public R qualityScale() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> maps = waterDataShowService.listRiverDataScale(year, 3, "");

        List<String> datalist = new ArrayList<>();
        datalist.add("FIRSR");
        datalist.add("THIRD");
        datalist.add("SECOND");
        int rechNumber = 0;
        for (Map<String, Object> data : maps) {
            if (datalist.contains(data.get("resultQuality"))) {
                rechNumber++;
            }
        }
        if (maps.size() == 0) {
            return R.ok(String.valueOf(0));
        }
        //总共的质量数
        return R.ok(String.valueOf(NumUtil.divide(Double.valueOf(rechNumber), Double.valueOf(maps.size()), 4)));
    }

    /**
     * 获取总的
     * 达标的小河流域数据
     * 通过测试
     * 通过点击详情然后根据这个数据获取每一个月的详情
     *
     * @return
     */
    @RequestMapping("/ReachStandardRiver")
    @ResponseBody
    public List<String> listReachStandardRiver() {
        return getTargetRiverName();
    }

    /**
     * 获取总的
     * 未达标的小河流域数据
     * 通过测试
     * 说明通过这个列表可以获取每条达标流域的一个月的数据
     *
     * @return
     */
    @RequestMapping("/NotReachStandardRiver")
    @ResponseBody
    public List<String> listNotReachStandardRiver() {
        return getTargetNotReachRiverName();
    }

    /**
     * 小河流域达标的流域的
     * 每一个月的详细情况
     *
     * @return
     */
    @RequestMapping("/ReachRequstQuality")
    @ResponseBody
    public List<Map<String, Map<String, String>>> listReachTargetRiver() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<String> listTargetName = getTargetRiverName();
        List<Object[]> objects = null;
        List<Map<String, Map<String, String>>> dataList = new ArrayList<>();
        Map<String, String> dataMap = null;
        Map<String, Map<String, String>> dataMapList =null;
        for (String targetName : listTargetName) {
            objects = waterDataShowService.listTargetRiverByName(year, 3, targetName);
            dataMap = new HashMap<>();
            dataMapList = new HashMap<>();
            for (Object[] object : objects) {
                dataMap.put(String.valueOf(object[2]), WaterQualityEnum.valueOf(String.valueOf(object[1])).getValue());
            }
            dataMapList.put(targetName, dataMap);
            dataList.add(dataMapList);

        }

        return dataList;
    }

    /**
     * 未达标小河流域数据
     * 小河流域中未达标
     * 的小河流域的数据每一个月的等级情况
     *
     * @return
     */
    @RequestMapping("/AffectReachRequstQuality")
    @ResponseBody
    public List<Map<String, Map<String, String>>> listNotReachTargetRiver() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<String> listNotReachTargetName = getTargetNotReachRiverName();
        List<Object[]> objects = null;
        List<Map<String, Map<String, String>>> resultList = null;
        Map<String, String> dataMap = null;
        List<Map<String, Map<String, String>>>  dataList=new ArrayList<>();
        Map<String, Map<String, String>> dataMapList =null;
        for (String targetName : listNotReachTargetName) {
            objects = waterDataShowService.listTargetRiverByName(year, 3, targetName);
            dataMap = new HashMap<>();
            dataMapList = new HashMap<>();
            for (Object[] object : objects) {
                dataMap.put(String.valueOf(object[2]), WaterQualityEnum.valueOf(String.valueOf(object[1])).getValue());
            }
            dataMapList.put(targetName, dataMap);
            dataList.add(dataMapList);
        }

        return dataList;
    }

    /**
     * 测试水质未达标流域详情通过名字获取
     * 一条小河流域的详情每一个月和年的数据显示
     * 小河流域水质量详情
     *
     * @return
     */
    @RequestMapping("/RiverQualityDetail")
    @ResponseBody
    public Map<String, Object> getRiverDetail(String basinName) {
        List<Map<String, Object>> maps = waterDataShowService.listRiverDetailByName(basinName,3);
        for (Map<String, Object> dataMap : maps) {
            dataMap.put("targetQuality", WaterQualityEnum.valueOf(String.valueOf(dataMap.get("targetQuality"))).getValue().replace("类", ""));
            dataMap.put("resultQuality", WaterQualityEnum.valueOf(String.valueOf(dataMap.get("resultQuality"))).getValue().replace("类", ""));
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", maps);
        map.put("code", 0);
        map.put("count", maps.size());
        map.put("msg", "");
        return map;
    }

    /**
     * @return
     */
    @RequestMapping("/testindextemp10")
    public ModelAndView getUrl(String basinName) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/testindextemp");
        return modelAndView;
    }

    /**
     * 测试水质不升反降河流
     * 一年至今为止的小河流域的平均值比上前一年的平均值小的就是不升反降
     *
     * @return
     */
    @RequestMapping("/ReduceQualityRiver")
    @ResponseBody
    public List<Map<String, Object>> listReduceQualityRiver() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        Map paramMap = new HashMap();
        paramMap.put("showView", "1");
        return listReduceRiverData(1, year, 3, paramMap);
    }

    /**
     * 测试水质不升反降河流
     * 一年至今为止的小河流域的平均值比上前一年的平均值小的就是不升反降
     *
     * @return
     */
    @RequestMapping("/ReduceQualityRiverDetail")
    @ResponseBody
    public List<Map<String, Map<String, String>>> listReduceQualityRiverDetail() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        Map paramMap = new HashMap();
        paramMap.put("showView", "bsfjwdb");
        List<Map<String, Object>> dataListMap = listReduceRiverData(1, year, 3,paramMap);
        Map<String, Map<String, String>> listMap = null;
        List<Object[]> objects = null;
        Map<String, String> targetDataMap = null;
        List<Map<String,Map<String,String>>> dataList=new ArrayList<>();
        for (Map<String, Object> dataMap : dataListMap) {
            targetDataMap = new HashMap<>();
            listMap=  new HashMap<>();
            objects = waterDataShowService.listTargetRiverByName(year, 3, String.valueOf(dataMap.get("basinName")));
            for (Object[] object : objects) {
                targetDataMap.put(String.valueOf(object[2]), WaterQualityEnum.valueOf(String.valueOf(object[1])).getValue());
            }
            listMap.put(String.valueOf(dataMap.get("basinName")), targetDataMap);
            dataList.add(listMap);
        }
        return dataList;
    }

    /**
     * 测试水质不升反降河流相反的流域就是说有上升的或者相等的流域
     * 一年至今为止的小河流域的平均值比上前一年的平均值小的就是不升反降
     *
     * @return
     */
    @RequestMapping("/ReachQualityRiverDetail")
    @ResponseBody
    public List<Map<String, Map<String, String>>> listReachQualityRiverDetail() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        Map param = new HashMap();
        param.put("showView", "bsfjdb");
        List<Map<String, Object>> dataListMap = listReduceRiverData(0, year, 3, param);
        Map<String, Map<String, String>> listMap = null;
        List<Object[]> objects = null;
        Map<String, String> targetDataMap = null;
        List<Map<String, Map<String, String>>> dataList=new ArrayList<>();
        for (Map<String, Object> dataMap : dataListMap) {
            targetDataMap = new HashMap<>();
            listMap=new  HashMap<>();
            objects = waterDataShowService.listTargetRiverByName(year, 3, String.valueOf(dataMap.get("basinName")));
            for (Object[] object : objects) {
                targetDataMap.put(String.valueOf(object[2]), WaterQualityEnum.valueOf(String.valueOf(object[1])).getValue());
            }
            listMap.put(String.valueOf(dataMap.get("basinName")), targetDataMap);
            dataList.add(listMap);

        }
        return dataList;
    }

    /**
     * 获取达标小河流域名称
     * 什么是达标流域就是数据比III低
     * 的就达标了现在获取达标流域
     *
     * @return
     */

    public List<String> getTargetRiverName() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> maps = waterDataShowService.listRiverDataScale(year, month, "");
        List<String> dataList = new ArrayList<>();
        List<String> resultRiver = new ArrayList<>();
        dataList.add("FIRSR");
        dataList.add("THIRD");
        dataList.add("SECOND");
        Collections.sort(maps, new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                Integer name1 = WaterQualityUtil.formatVal(o1.get("resultQuality").toString()); ;//name1是从你list里面拿出来的一个
                Integer name2 = WaterQualityUtil.formatVal(o2.get("resultQuality").toString());; //name1是从你list里面拿出来的第二个name
                return name2.compareTo(name1);
            }
        });
        for (Map<String, Object> data : maps) {
            if (dataList.contains(data.get("resultQuality"))) {
                resultRiver.add(String.valueOf(data.get("basinName")));
            }
        }
        return resultRiver;
    }

    /**
     * 获取未达标小河流域名称
     *
     * @return
     */
    public List<String> getTargetNotReachRiverName() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> maps = waterDataShowService.listRiverDataScale(year, month, "");
        List<String> dataList = new ArrayList<>();
        List<String> resultRiver = new ArrayList<>();
        dataList.add("FOURTH");
        dataList.add("FIFTH");
        dataList.add("OTHER");
        Collections.sort(maps, new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                Integer name1 = WaterQualityUtil.formatVal(o1.get("resultQuality").toString());//name1是从你list里面拿出来的一个
                Integer name2 = WaterQualityUtil.formatVal(o2.get("resultQuality").toString());//name1是从你list里面拿出来的第二个name
                return name2.compareTo(name1);
            }
        });
        for (Map<String, Object> data : maps) {
            if (dataList.contains(data.get("resultQuality"))) {
                resultRiver.add(String.valueOf(data.get("basinName"))+"-"+data.get("basinCode"));
            }
        }
        return resultRiver;
    }

    /***
     * 获取不升反降的小河流域情况列表
     * target目标是获取不升反降的数据还是上升的数据
     * target==1是不升反降的数据0表示上升的数据
     */
    public List<Map<String, Object>> listReduceRiverData(int target, int year, int month,Map paramMap) {
        Map<String, Integer> qualityMap = new HashMap<>();
        qualityMap.put("FIRSR", 0);
        qualityMap.put("SECOND", 1);
        qualityMap.put("THIRD", 2);
        qualityMap.put("FOURTH", 3);
        qualityMap.put("FIFTH", 4);
        qualityMap.put("OTHER", 5);
        List<Map<String, Object>> dataList = new ArrayList<>();
        List<Map<String, Object>> yearMaps = waterDataShowService.listRiverDataScale(year, month, "");//年水质均值
        List<Map<String, Object>> oldyearMaps = waterDataShowService.listRiverDataScale(year - 1, 12, "");
        String resultQuality = "";
        String lastYearResult = "";
        Integer cur = 0;
        Integer lastYear = 0;
        String showView = MapUtils.getString(paramMap, "showView", "");
        System.out.println("cur:" + yearMaps);
        System.out.println("last:" + oldyearMaps);
        for (Map<String, Object> dataMap : yearMaps) {
            for (Map<String, Object> newdataMap : oldyearMaps) {
                if (String.valueOf(dataMap.get("baseName")).equals(String.valueOf(newdataMap.get("baseName")))) {
                    resultQuality = (String) dataMap.get("resultQuality");
                    lastYearResult = (String) newdataMap.get("resultQuality");
                    cur = qualityMap.get(resultQuality);
                    lastYear = qualityMap.get(lastYearResult);
                    if (target == 1) {//今年的数据比去年的从map中获取的大就是下降的数据;
                        //一、1-3类不显示，条件：
                        //1、原来是2类，降为3类，不显示大屏，列为达标流域
                        //2、原来是1类，降为3类，不显示大屏，列为达标流域
                        //3、原来是3类，降为3类，不显示大屏，列为达标流域

                        //界面显示的圆圈
                        if ("1".equals(showView) && cur <= 3 && lastYear <= 3) {
                            continue;
                        }
                        //不升反降达标
                        if (("bsfjdb".equals(showView) && cur <= 3 && lastYear <= 3) || (lastYear > 3 && cur >= lastYear)) {
                            dataList.add(dataMap);
                        }
                        //不升反降未达标
                        if ("bsfjwdb".equals(showView) && ((lastYear > 3 && cur > lastYear)||(lastYear <= 3 && cur>3))) {
                            dataList.add(dataMap);
                        }

                        //二、显示大屏条件：
                        //1、原来是2类，降为4类，显示大屏，列为未达标流域
                        //2、原来是1类，降为5类，显示大屏，列为未达标流域
                        //3、原来是3类，降为6（劣5）类，显示大屏，列为未达标流域
                        //界面显示的圆圈
                        if (("1".equals(showView) && (cur > 3 && lastYear <= 3)) ||  (lastYear > 3 && cur > lastYear) ) {
                            dataList.add(dataMap);
                        }


                    } else {//今年的数据比去年的从map中获取的小就是上升;
                        //一、1-3类不显示，条件：
                        //1、原来是2类，降为3类，不显示大屏，列为达标流域
                        //2、原来是1类，降为3类，不显示大屏，列为达标流域
                        //3、原来是3类，降为3类，不显示大屏，列为达标流域
                        if (("bsfjdb".equals(showView) && (cur <= 3 && lastYear <= 3)) || (lastYear > 3 && cur <= lastYear)) {
                            dataList.add(dataMap);
                        }
                    }
                    break;
                }
            }
        }
        //按照目标未达到等级 4-》3-》2级显示
        Collections.sort(dataList, new Comparator<Map>() {
            @Override
            public int compare(Map o1, Map o2) {
                return WaterQualityUtil.formatVal(MapUtils.getString(o2, "resultQuality", "")) - WaterQualityUtil.formatVal(MapUtils.getString(o1, "resultQuality", ""));
            }
        });
        return dataList;
    }

    /**
     * 小河流域的年平均值
     *
     * @return
     */
    @RequestMapping("/RiverYearAVGData")
    @ResponseBody
    public List<Map<String, Object>> listAVGData() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> maps = waterDataShowService.listRiverDataScale(year, 3, "");
        for (Map<String, Object> map : maps) {
            map.put("resultQuality", WaterQualityEnum.valueOf(String.valueOf(map.get("resultQuality"))).getValue().replace("类", ""));
        }
        return maps;
    }

    /**
     * 一条小河流域的平均水质量
     *
     * @param basinName
     * @return
     */
    @RequestMapping("/OneRiverYearAVGQuality")
    @ResponseBody
    public Map<String, String> getOneRiverAVGQuality(String basinName) {
        String quality = null;
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> maps = waterDataShowService.listRiverDataScale(year, 3, basinName);
        for (Map<String, Object> dataMap : maps) {
            quality = String.valueOf(WaterQualityEnum.valueOf(String.valueOf(dataMap.get("resultQuality"))).getValue().replace("类", ""));
            break;
        }
        Map<String, String> dataMap = new HashMap<>();
        dataMap.put("qualityLevel", quality);
        return dataMap;

    }
    /***
     * 小河流域不升反降流域比例
     * 所有的小河流域情况
     */
    @RequestMapping(value = "/ReduceQualityRiverScale")
    @ResponseBody
    public R reduceQualityRiverScale() {
        //求出不升反降的数据
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> reducedataListMap = listReduceRiverData(1, year, 3,new HashMap());//不升反降数据
        List<Map<String, Object>> reachListMap = listReduceRiverData(0, year, 3,new HashMap());//上升数据
        int total = reducedataListMap.size() + reachListMap.size();
        if (total != 0) {
            return R.ok(String.valueOf(NumUtil.divide(Double.valueOf(reducedataListMap.size()), Double.valueOf(total), 4)));
        }
        return R.ok("0");
    }

    /***
     * 同比就是今年的几月份的数据和去年的几月份的数据的比较
     *
     * @return
     */
    @RequestMapping(value = "/SameScaleCompareToLastYear")
    @ResponseBody
    public R getTheScaleCompareToLastYear(String basinName) {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        List<Map<String, Object>> currentYear = waterDataShowService.listScaleCompareToLastYear(basinName, year,month);
        List<Map<String, Object>> lastYear = waterDataShowService.listScaleCompareToLastYear(basinName, year - 1,12);
        Map<String, String> qualityMap = new HashMap<>();
        qualityMap.put("FIRSR", "0");
        qualityMap.put("SECOND","1" );
        qualityMap.put("THIRD", "2");
        qualityMap.put("FOURTH","3" );
        qualityMap.put("FIFTH", "4");
        qualityMap.put("OTHER", "5");
        int currentReach = 0;//现在的达标数据
        for (Map<String, Object> map : currentYear) {

            if (Integer.valueOf(qualityMap.get(map.get("resultQuality"))) < 3) {
                currentReach++;
            }

        }
        int lastReach = 0;//上一次的达标数据
        for (Map<String, Object> dataMap : lastYear) {
            if (Integer.valueOf(qualityMap.get(dataMap.get("resultQuality"))) < 3) {
                lastReach++;
            }
        }
        Double currentScale = 0d;
        Double lastScale = 0d;
        if (currentYear.size() > 0) {
            if(Double.valueOf(lastYear.size())==0){
                currentScale=0d;
            }else{
                currentScale = NumUtil.divide(Double.valueOf(currentReach), Double.valueOf(currentYear.size()), 4);
            }

            if(Double.valueOf(lastYear.size())==0){
                lastScale=0d;
            }else{
                lastScale = NumUtil.divide(Double.valueOf(lastReach), Double.valueOf(lastYear.size()), 4);
            }


        }
        Map<String, Object> dataMap = new HashMap<>();
        double resultScale = currentScale - lastScale;
        if (resultScale < 0) {
            dataMap.put("result", "0");
        } else {
            dataMap.put("result", "1");
        }
        dataMap.put("resultScale", String.valueOf(resultScale));
        return R.ok(dataMap);
    }

    /***
     * 获取小河流域中最新的数据(月数据最新的那一条)
     * @return
     */


    @RequestMapping(value = "/GetNewRiverDataQuality")
    @ResponseBody
    public List<Map<String,Object>> getNewRiverDataQuality(){
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        return waterDataShowService.getRiverNewData(year);
    }

    /***
     * 获取所有的小河流域的平均值的同比
     * @return
     */
    @RequestMapping(value = "/GetAllRiverScale")
    @ResponseBody
    public Map<String,Object> getRiverSameScale(){
        List<String> basinNameData = waterDataShowService.getBasinNameData();
        R theSameScale=null;
        Map<String,Object> dataMap=new HashMap<>();
        for(String basinName:basinNameData){
            theSameScale = getTheScaleCompareToLastYear(basinName);
            dataMap.put(basinName,theSameScale.get("resultScale"));
        }
        return dataMap;
    }
    /***
     * 获取所有的小河流域的平均值
     * @return
     */
    @Autowired
    private SimpleDao simpleDao;
    @RequestMapping(value = "/GetAllAVGLevel")
    @ResponseBody
    public Map<String,Object> getAllAVGLevel1(){
        List<String> basinNameData = waterDataShowService.getBasinNameData();
        Map<String,Object> dataMap=new HashMap<>();
        Map<String, String> oneRiverAVGQuality=null;
        for(String basinName:basinNameData){
            oneRiverAVGQuality = getOneRiverAVGQuality(basinName);
            dataMap.put(basinName,oneRiverAVGQuality.get("qualityLevel"));
        }
        return dataMap;
    }
    @RequestMapping(value = "getTestName")
    @ResponseBody
    public Map<String,String> dataMapget(){
              String sql="select * from wt_basin_month_data";
 simpleDao.getNativeQueryList(sql);

        return null;
    }
}
