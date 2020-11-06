package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface WaterDataShowService {

    /**
     * 小河流域数据列表有多少条流域
     */
    List<Object> listRiverData(int month);

    /**
     * 小河流域目标水质对比情况
     *
     * @param month 月份;
     */
    List<Map<String, Object>> listRiverDataScale(int year, int month, String name);

    /**
     * 不升反降流域数据
     * 就是用同一年的本月以前的月份的平均值比较本月分的测试结果大的就是反降的流域
     */
    List<Object[]> listRiverCurrentMonthQuality(int month);

    /**
     * 根据名称年月获取目标流域(达标不达标流域)
     *
     * @param year
     * @param month
     * @param targetName
     * @return
     */
    List<Object[]> listTargetRiverByName(int year, int month, String targetName);

    /**
     * 根据名称获取小河流域的详情
     */
    List<Map<String, Object>> listRiverDetailByName(String targetName,int month);

    /**
     * 根据名称获取数据处理成同比
     * 同比的意思是今年的这条河流有多少条数据达到三级以上和总量对比的数据
     * 和去年的流域的河流达标数量跟去年的总数量的对比的相减是多少就是多少;
     */
    List<Map<String, Object>> listScaleCompareToLastYear(String basinName, int year,int month);

    /***
     * 获取最新的小小河流域数据显示名称和质量就行
     */
    List<Map<String, Object>> getRiverNewData(int year);

    /**
     * 获取所有小河流域的名称平均值和同比值得获取使用
     * @return
     */
    List<String> getBasinNameData();


}
