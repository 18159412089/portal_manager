package com.fjzxdz.ams.module.api;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.annotation.ApiValid;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 空气小时数据 controller
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:49:26
 */
@Controller
@RequestMapping("/api/enviromonit/airHourData")
public class AirHourDataApiController extends BaseController {

    @Autowired
    private AirHourDataService airHourDataService;

    @Autowired
    private AirHourDataDao airHourDataDao;

    @Autowired
    private AirMonitorPointService airMonitorPointService;

    @Autowired
    private SimpleDao simpleDao;



    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: list
     * @Description: 查询空气小时数据
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午2:28:56
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午2:28:56
     */
    @RequestMapping("/list")
    @ApiValid(value = "350629")
    @ResponseBody
    public R list(String token,AirHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
        WebServiceMessage msg = new WebServiceMessage();
        try {
            String startTime =  param.getStartTime();
            String endTime =  param.getEndTime();
            if( DateUtil.getDiffHour(startTime,endTime) <0) {
                msg.setMessage("时间格式出错,请输入YYYY-MM-DD HH:MM:SS格式！！！");
                return R.error(msg.toString());
            }
            if( DateUtil.getDiffHour(startTime,endTime) >24){
                msg.setMessage("查询间隔不能超过24小时！！！");
                return R.error(msg.toString());
            }
            Page<Map<String, Object>> airDataPage = airHourDataService.alllistByPage(param, pageQuery(request),response);
            if (ToolUtil.isEmpty(airDataPage)) return null;
                int page = pageQuery(request).getCurrentPage() + 1;
                int rows = pageQuery(request).getLimit();
                int total = (int) airDataPage.getTotalCount();
                msg.setList(airDataPage.getResult());
                msg.setPageInfo(page, rows, total);
        }catch (Exception e){
              return R.error(e.getMessage());
        }
        return R.ok().put("data", msg);
    }

}
