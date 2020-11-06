package com.fjzxdz.ams.module.api;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.annotation.ApiValid;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 有关在线水小时的功能
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午2:12:28
 */
@Controller
@RequestMapping("/api/enviromonit/water/wtHourData")
public class WtHourDataApiController extends BaseController {

    @Autowired
    private WtHourDataService wtHourDataService;
    @Autowired
    private SimpleDao simpleDao;


    /**
     *  获取小时数据
     * @param param
     * @param request
     * @return
     */
    @RequestMapping("/getPageList")
    @ApiValid(value = "350629")
    @ResponseBody
    public R getPageList(String token, WtHourDataParam param, HttpServletRequest request) {
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
            Page<Map<String, Object>> wtHourDataPage = wtHourDataService.getPageAllList(param, pageQuery(request));
            int page = pageQuery(request).getCurrentPage() + 1;
            int rows = pageQuery(request).getLimit();
            int total = (int) wtHourDataPage.getTotalCount();
            msg.setList(wtHourDataPage.getResult());
            msg.setPageInfo(page, rows, total);
        }catch (Exception e){
            return R.error(e.getMessage());
        }
		return R.ok().put("data", msg);

    }

    /**
     * @param str
     * @return String
     * @throws
     * @Title: toSqlStr
     * @Description: 部分sql语句拼接
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:15:33
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:15:33
     */
    public String toSqlStr(String str) {
        String sqlStr = null;
        if (ToolUtil.isNotEmpty(str)) {
            String[] strs = str.split(",");
            sqlStr = "'" + StringUtils.join(strs, "','") + "'";
        }
        return sqlStr;
    }
}
