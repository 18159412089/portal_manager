package com.fjzxdz.ams.module.api;

import com.fjzxdz.ams.common.annotation.ApiValid;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 
 * 大气环境服务。地图上站点显示。 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月24日 上午11:19:35
 */
@Controller
@Scope("prototype")
@RequestMapping("/api/airMonitorPoint/")
public class AirMonitorPointApiController extends BaseController {

	@Autowired
	private AirMonitorPointService airMonitorPointService;
	@Autowired
	private AirHourDataService airHourDataService;
    @Autowired
    private SimpleDao simpleDao;

    /**
     * 根据查询条件分页获取站点列表
     * @param token
     * @param request {page:1,rows:1}
     * @return
     */
	@RequestMapping("/getAirMonitorPointList")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getAirMonitorPointList(String token, HttpServletRequest request){
        WebServiceMessage msg = new WebServiceMessage();
        try{
            AirMonitorPointParam airMonitorPointParam = new AirMonitorPointParam();
            airMonitorPointParam.setCodeRegion(token);
            Page<AirMonitorPoint> pageObj = airMonitorPointService.listByPage(airMonitorPointParam, pageQuery(request));
            List<AirMonitorPoint> list= pageObj.getResult();
            if (list.size()!=0){
                for (AirMonitorPoint airMonitorPoint : list) {
                    if (airMonitorPoint.getPointType().equals("1")){
                        airMonitorPoint.setPointType("城市");
                    }else if(airMonitorPoint.getPointType().equals("0")){
                        airMonitorPoint.setPointType("定位");
                    }else{
                        airMonitorPoint.setPointType("其他");
                    }
                }
            }
            PageEU<AirMonitorPoint> pageData = new PageEU<>(pageObj);

            int page = pageQuery(request).getCurrentPage()+1;
            int rows = pageQuery(request).getLimit();
            int total = (int) pageData.getTotal();

            msg.setList(pageData.getRows());
            msg.setPageInfo(page, rows, total);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

		return R.ok().put("data",msg);
	}

    /**
     * 根据站点编码获取站点详情
     * @param pointCode
     * @return
     */
	@RequestMapping("/getAirMonitorPoint")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getAirMonitorPoint(String token, String pointCode, HttpServletRequest request) throws Exception {
        WebServiceMessage msg = new WebServiceMessage();
        try{
            AirMonitorPoint airMointorPoint = simpleDao.findUnique("from AirMonitorPoint where pointCode=?",pointCode);
            Map<String, Object> record = BeanUtil.beanToMap(airMointorPoint,false,true);

            msg.setRecord(record);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

        return R.ok().put("data",msg);
	}
}
