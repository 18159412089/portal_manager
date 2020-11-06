/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.api;

import com.fjzxdz.ams.common.annotation.ApiValid;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.module.enter.dao.PollutionEnterpriseInfoDao;
import com.fjzxdz.ams.module.enter.entity.PollutionEnterpriseInfo;
import com.fjzxdz.ams.module.enter.param.PollutionEnterpriseInfoParam;
import com.fjzxdz.ams.module.enter.service.PollutionEnterpriseInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 污染源档案企业信息Controller
 * @author lilongan
 * @version 2019-02-26
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/api/enterpriseSurvey/")
public class PollutionEnterpriseInfoApiController extends BaseController {
	@Autowired
	private PollutionEnterpriseInfoDao pollutionEnterpriseInfoDao;
	@Autowired
	private PollutionEnterpriseInfoService pollutionEnterpriseInfoService;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 按uuid查询，并返回map
	 * @param standenterid
	 * @return
	 */
	@RequestMapping("/getPollutionEnterpriseInfo")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPollutionEnterpriseInfo(String token, String standenterid, HttpServletRequest request) throws Exception {
        WebServiceMessage msg = new WebServiceMessage();
        try{
            PollutionEnterpriseInfo pollutionEnterpriseInfo = simpleDao.findUnique("from PollutionEnterpriseInfo where STANDENTERID=?",standenterid);
            Map<String, Object> record = BeanUtil.beanToMap(pollutionEnterpriseInfo,false,true);
            msg.setRecord(record);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

        return R.ok().put("data", msg);
	}
	
	/**
	 * 查询列表
	 * @param token
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPollutionEnterpriseInfoList")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPollutionEnterpriseInfoList(String token, HttpServletRequest request) throws Exception {
        WebServiceMessage msg = new WebServiceMessage();
        try{
            PollutionEnterpriseInfoParam pollutionEnterpriseInfoParam = new PollutionEnterpriseInfoParam();
            pollutionEnterpriseInfoParam.setCodeRegion(token);
            Page<PollutionEnterpriseInfo> pageObj = pollutionEnterpriseInfoService.listByPage(pollutionEnterpriseInfoParam, pageQuery(request));

            PageEU<PollutionEnterpriseInfo> pageData = new PageEU<>(pageObj);
            int page = pageQuery(request).getCurrentPage()+1;
            int rows = pageQuery(request).getLimit();
            int total = (int) pageData.getTotal();

            msg.setList(pageData.getRows());
            msg.setPageInfo(page, rows, total);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

        return R.ok().put("data", msg);
	}

    /**
     * 获取华安县污染源普查企业列表
     * @param token
     * @param request
     * @return
     */
    @RequestMapping("/getPollutionEnterpriseInfoListForHA")
    @ApiValid(value = "350629")
    @ResponseBody
    public Map<String, Object> getPollutionEnterpriseInfoListForHA(String token, HttpServletRequest request) throws Exception {
        WebServiceMessage msg = new WebServiceMessage();
        try{
            PollutionEnterpriseInfoParam pollutionEnterpriseInfoParam = new PollutionEnterpriseInfoParam();
            pollutionEnterpriseInfoParam.setCodeRegion(token);

            Page<PollutionEnterpriseInfo> pageObj = pollutionEnterpriseInfoService.listByPage(pollutionEnterpriseInfoParam, pageQuery(request));

            PageEU<PollutionEnterpriseInfo> pageData = new PageEU<>(pageObj);
            int page = pageQuery(request).getCurrentPage()+1;
            int rows = pageQuery(request).getLimit();
            int total = (int) pageData.getTotal();

            msg.setList(pageData.getRows());
            msg.setPageInfo(page, rows, total);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

        return R.ok().put("data", msg);
    }
}
