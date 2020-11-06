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
import com.fjzxdz.ams.module.enviromonit.enterprise.dao.PeEnterpriseDataDao;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.enterprise.param.PeEnterpriseDataParam;
import com.fjzxdz.ams.module.enviromonit.enterprise.service.PeEnterpriseDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 污染源自动监控企业信息表Controller
 * 
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/api/enterprise/")
public class PeEnterpriseDataApiController extends BaseController {

	@Autowired
	private PeEnterpriseDataDao peEnterpriseDataDao;
	@Autowired
	private PeEnterpriseDataService peEnterpriseDataService;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 按uuid查询，并返回map
	 * 
	 * @param token
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getPeEnterpriseData")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPeEnterpriseData(String token, @RequestParam(value = "uuid") String uuid, HttpServletRequest request) {
        WebServiceMessage msg = new WebServiceMessage();
		try {
            PeEnterpriseData peEnterpriseData = peEnterpriseDataDao.getById(uuid);
            Map<String, Object> record = BeanUtil.beanToMap(peEnterpriseData,false,true);
            msg.setRecord(record);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("data", msg);
	}

	/**
	 * 查询列表
	 * 
	 * @param token
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPeEnterpriseDataList")
    @ApiValid(value = "350629")
	@ResponseBody
	public Map<String, Object> getPeEnterpriseDataList(String token, HttpServletRequest request) {
        WebServiceMessage msg = new WebServiceMessage();
        try {
            PeEnterpriseDataParam peEnterpriseDataParam = new PeEnterpriseDataParam();
            peEnterpriseDataParam.setOrgCode(token);
            Page<PeEnterpriseData> pageObj = peEnterpriseDataService.listByPage(peEnterpriseDataParam, pageQuery(request));
            PageEU<PeEnterpriseData> pageData = new PageEU<>(pageObj);

            int page = pageQuery(request).getCurrentPage() + 1;
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
     * 华安县污染源自动监控企业列表
     *
     * @param token
     * @param request
     * @return
     */
    @RequestMapping("/getPeEnterpriseDataListForHA")
    @ApiValid(value = "350629")
    @ResponseBody
    public Map<String, Object> getPeEnterpriseDataListForHA(String token, HttpServletRequest request) {
        WebServiceMessage msg = new WebServiceMessage();
        try {
            PeEnterpriseDataParam peEnterpriseDataParam = new PeEnterpriseDataParam();
            peEnterpriseDataParam.setOrgCode(token);

            Page<PeEnterpriseData> pageObj = peEnterpriseDataService.listByPage(peEnterpriseDataParam, pageQuery(request));
            PageEU<PeEnterpriseData> pageData = new PageEU<>(pageObj);

            int page = pageQuery(request).getCurrentPage() + 1;
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
