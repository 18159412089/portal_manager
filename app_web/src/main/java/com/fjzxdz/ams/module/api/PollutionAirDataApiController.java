package com.fjzxdz.ams.module.api;

import com.fjzxdz.ams.common.annotation.ApiValid;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.fjzxdz.ams.common.generate.utils.StringUtils;

import com.fjzxdz.ams.module.enums.RegionCodeEnum;
import com.fjzxdz.ams.zphb.module.enviromonit.air.entity.PollutionAirAndWaterData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * 污染源普查废气数据
 * @author ZhangGQ
 * @date  2019-10-21
 */
@Controller
@RequestMapping("/api/pollutionAirData")
public class PollutionAirDataApiController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;

    /**
     * 污染源普查废气数据
     * @param token
     * @param qymc
     * @param request
     * @return
     */
	@RequestMapping("/getPollutionAirDataList")
    @ApiValid(value = "350629")
	@ResponseBody
	public R getPollutionAirDataList(String token, String qymc, HttpServletRequest request) {
        WebServiceMessage msg = new WebServiceMessage();

        String sql = "select QYMC,WRWNAME,YEAR,PFL,LXR,QX,DS,LXDH,ADDRESS,LONGITUDE,LATITUDE from POLLUTION_AIR_DATA where 1=1";
        String qx = RegionCodeEnum.getRegionCodeEnumValue(token);
        if (!StringUtils.isNull(qx)) {
            sql += " AND QX like '%" + qx + "%'";
        }
        if (!StringUtils.isNull(qymc)) {
            sql += " AND QYMC like '%" + qymc + "%'";
        }

        try {
            Page<PollutionAirAndWaterData> pageObj = simpleDao.listNativeByPage(sql, pageQuery(request));

            PageEU<PollutionAirAndWaterData> pageData = new PageEU<>(pageObj);
            int page = pageQuery(request).getCurrentPage()+1;
            int rows = pageQuery(request).getLimit();
            int total = (int) pageData.getTotal();

            msg.setList(pageData.getRows());
            msg.setPageInfo(page, rows, total);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }

        return R.ok().put("data",msg);
	}
}
