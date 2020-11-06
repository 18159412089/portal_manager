/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.api;

import com.fjzxdz.ams.common.annotation.ApiValid;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.dao.PeMonitorPointDao;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.entity.PeMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.param.PeMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.service.PeMonitorPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * monitorPointController
 * @author htj
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/api/point/")
public class PeMonitorPointApiController extends BaseController {

	@Autowired
	private PeMonitorPointDao peMonitorPointDao;
	@Autowired
	private PeMonitorPointService peMonitorPointService;

	/**
	 * 按uuid查询，并返回map
	 * @param token
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getPeMonitorPoint")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPeMonitorPoint(String token, @RequestParam(value = "uuid") String uuid, HttpServletRequest request) {
        WebServiceMessage msg = new WebServiceMessage();
		try {
            PeMonitorPoint peMonitorPoint = peMonitorPointDao.getById(uuid);
            Map<String, Object> record = BeanUtil.beanToMap(peMonitorPoint,false,true);
            msg.setRecord(record);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("data", msg);
	}
	
	/**
	 * 查询列表
	 * @param token
	 * @param peId
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPeMonitorPointList")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPeMonitorPointList(String token, String peId, HttpServletRequest request){
        WebServiceMessage msg = new WebServiceMessage();
        try {
            PeMonitorPointParam peMonitorPointParam = new PeMonitorPointParam();
            peMonitorPointParam.setPeId(peId);
            Page<PeMonitorPoint> pageObj = peMonitorPointService.listByPage(peMonitorPointParam, pageQuery(request));
            PageEU<PeMonitorPoint> pageData = new PageEU<>(pageObj);

            int page = pageQuery(request).getCurrentPage() + 1;
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
	 * 根据企业获取排口列表信息
	 * @param token
	 * @param peId
	 * @return
	 */
	@RequestMapping("/getPeMonitorPointListByPeId")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPeMonitorPointListByPeId(String token, String peId, HttpServletRequest request){
        WebServiceMessage msg = new WebServiceMessage();
        if(peId == null){
            return R.error("企业ID不能为空");
        }
        try{
            PeMonitorPointParam peMonitorPointParam = new PeMonitorPointParam();
            peMonitorPointParam.setPeId(peId);

            Page<PeMonitorPoint> pageObj = peMonitorPointService.listByPage(peMonitorPointParam, pageQuery(request));
            PageEU<PeMonitorPoint> pageData = new PageEU<>(pageObj);

            int page = pageQuery(request).getCurrentPage() + 1;
            int rows = pageQuery(request).getLimit();
            int total = (int) pageData.getTotal();

            msg.setList(pageData.getRows());
            msg.setPageInfo(page, rows, total);
        }catch (Exception e){
            return R.error(e.getMessage());
        }

        return R.ok().put("data",msg);
	}
}
