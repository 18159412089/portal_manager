/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.mine.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.dao.ZpLicensedMineDao;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.entity.ZpLicensedMine;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.param.ZpLicensedMineParam;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.service.ZpLicensedMineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 矿山管理Controller
 * @author queherong
 * @version 2019-10-14
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/mine/zpLicensedMine")
public class ZpLicensedMineController extends BaseController {

	@Autowired
	private ZpLicensedMineDao zpLicensedMineDao;
	@Autowired
	private ZpLicensedMineService zpLicensedMineService;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "zphb/moudles/enviromonit/" + "mine/zpLicensedMineList";
	}
	/*templates/zphb/moudles/enviromonit/mine/zpLicensedMineList.ftl*/
	/**
	 * 更新或新增
	 * @param zpLicensedMine
	 * @return
	 */	
	@RequestMapping("/saveZpLicensedMine")
	@ResponseBody
	public R saveZpLicensedMine(ZpLicensedMine zpLicensedMine) {
		try {
			zpLicensedMineService.save(zpLicensedMine);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deleteZpLicensedMine")
	@ResponseBody
	public R deleteZpLicensedMine(@RequestParam(value = "id") String uuid) {
		try {
			zpLicensedMineService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getZpLicensedMine")
	@ResponseBody
	public Map<String, Object> getZpLicensedMine(@RequestParam(value = "id") String uuid) {
		ZpLicensedMine zpLicensedMine = zpLicensedMineDao.getById(uuid);
		return BeanUtil.beanToMap(zpLicensedMine,false,true);
	}

	/**
	 * 查询列表
	 * @param zpLicensedMineParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/zpLicensedMineList")
	@ResponseBody
	public PageEU<ZpLicensedMine> zpLicensedMineList(ZpLicensedMineParam zpLicensedMineParam, HttpServletRequest request) {
		Page<ZpLicensedMine> page = zpLicensedMineService.listByPage(zpLicensedMineParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
