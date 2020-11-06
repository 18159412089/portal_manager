/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.rubbish.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.dao.ZpTransferStationDao;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.entity.ZpTransferStation;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.param.ZpTransferStationParam;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.service.ZpTransferStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 垃圾处理厂Controller
 * @author queherong
 * @version 2019-10-14
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/rubbish/zpTransferStation")
public class ZpTransferStationController extends BaseController {

	@Autowired
	private ZpTransferStationDao zpTransferStationDao;
	@Autowired
	private ZpTransferStationService zpTransferStationService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "zphb/moudles/enviromonit/" + "rubbish/zpTransferStationList";
	}
	
	/**
	 * 更新或新增
	 * @param zpTransferStation
	 * @return
	 */	
	@RequestMapping("/saveZpTransferStation")
	@ResponseBody
	public R saveZpTransferStation(ZpTransferStation zpTransferStation) {
		try {
			zpTransferStationService.save(zpTransferStation);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按id删除
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteZpTransferStation")
	@ResponseBody
	public R deleteZpTransferStation(@RequestParam(value = "id") String id) {
		try {
			zpTransferStationService.delete(id);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按id查询，并返回map
	 * @param id
	 * @return
	 */
	@RequestMapping("/getZpTransferStation")
	@ResponseBody
	public Map<String, Object> getZpTransferStation(@RequestParam(value = "id") String id) {
		ZpTransferStation zpTransferStation = zpTransferStationDao.getById(id);
		return BeanUtil.beanToMap(zpTransferStation,false,true);
	}

	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/zpTransferStationList")
	@ResponseBody
	public PageEU<ZpTransferStation> zpTransferStationList(ZpTransferStationParam zpTransferStationParam, HttpServletRequest request) {
		Page<ZpTransferStation> page = zpTransferStationService.listByPage(zpTransferStationParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
