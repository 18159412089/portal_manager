package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fjzxdz.ams.module.enums.EnumCounty;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEditEntity;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinMonitorParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtBasinMonitorService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.CommonUtil;
/**
 * 
 * 这里描述这个类是做什么业务 
 * @Author   wudenglin
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午4:39:52
 */
 
@Controller
@RequestMapping(value = "/enviromonit/waterData")
public class WaterDataEditController extends BaseController {
	@Autowired
	public SimpleDao simpleDao;
	@Autowired
	WtDataEditService wtDataEditService;
	@Autowired
	WtBasinMonitorService wtBasinMonitorService;
	private  final int loginNameLength=2;
	/**
	 * 
	 * @Title: index @Description: 小河流域县级账户人员 页面跳转@param: @return @return:
	 * String @throws
	 */
	@RequestMapping("/userList")
	public String index() {
		return "/moudles/enviromonit/water/userEditRiverDataUser";
	}
	/**
	 * 
	 * @Title: riverMatchToUser   
	 * @Description: 小河流域数据更新 页面
	 * @param: @return      
	 * @return: String      
	 * @throws
	 */
	@RequestMapping("/EidtRiverData")
	public String riverMatchToUser() {
		return "/moudles/enviromonit/water/userEditRiverDataForm";
	}
	

	/**
	 * 
	 * @Title: list   
	 * @Description: 县级用户账号不分页 
	 * @param: @param request
	 * @param: @return      
	 * @return: List<Map<String,Object>>      
	 * @throws
	 */
	@RequestMapping("/getUserList")
	@ResponseBody
	public List<Map<String, Object>> list(HttpServletRequest request) {
		String loginName = CommonUtil.getCustommerUserDetail(request).getUsername();
		List<Map<String, Object>> userList = wtDataEditService.getUserList(loginName);
		String cityTown = null;
		EnumCounty enumByKey = null;
		for (Map<String, Object> dataMap : userList) {
			loginName = String.valueOf(dataMap.get("loginName"));

			if (loginName != null) {
				enumByKey = EnumCounty.getEnumByKey(loginName.split("_")[0]);
			}
			cityTown = enumByKey == null ? String.valueOf(dataMap.get("name"))
					: enumByKey.getValue() + "-" + String.valueOf(dataMap.get("name"));
			dataMap.put("name", cityTown);
		}
		return userList;
	}
     /**
      * 
      * @Title: pageUser   
      * @Description: 村镇数据
      * @param: @param request
      * @param: @return      
      * @return: PageEU<Map<String,Object>>      
      * @throws
      */
	@RequestMapping("/getUserPage")
	@ResponseBody
	public PageEU<Map<String, Object>> pageUser(HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		String loginName=CommonUtil.getCustommerUserDetail(request).getUsername();
		page.setResult(wtDataEditService.getPageList(loginName, page));
		String cityTown=null;
		EnumCounty enumByKey =null;
		if(page.getResult()!=null) {
			for(Map<String,Object> dataMap:page.getResult()) {
			 loginName=String.valueOf(dataMap.get("loginname"));
			 if(loginName!=null) {
				 enumByKey= EnumCounty.getEnumByKey(loginName.split("_")[0]);
			}
			 cityTown=enumByKey==null?String.valueOf(dataMap.get("name")):  enumByKey.getValue() +"-"+String.valueOf(dataMap.get("name"));
			dataMap.put("name",cityTown);
			}
		}
	
		return new PageEU<>(page);
	}
	/**
	 * 
	 * @Title: listRiverMonitor   
	 * @Description: 小河流域列表   
	 * @param: @param uid
	 * @param: @param pointName
	 * @param: @param request
	 * @param: @return      
	 * @return: List<Map<String,Object>>      
	 * @throws
	 */
	@RequestMapping("/listRiverMonitor")
	@ResponseBody
	public List<Map<String, Object>> listRiverMonitor(String uid, String pointName, HttpServletRequest request) {
		return wtDataEditService.listRiverMonitor(uid);
	}
	/**
	 * 
	 * @Title: listRiverUnknowTown   
	 * @Description: 未知所属县城的小河流域列表   
	 * @param: @param uid
	 * @param: @param pointName
	 * @param: @param request
	 * @param: @return      
	 * @return: List<Map<String,Object>>      
	 * @throws
	 */
	@RequestMapping("/listRiverUnkownTown")
	@ResponseBody
	public List<Map<String, Object>> listRiverUnknowTown() {
		return wtDataEditService.listRiverUnknowTown();
	}

	/**
	 * 
	 * @Title: list   
	 * @Description: 小河流域数据
	 * @param: @param param
	 * @param: @param request
	 * @param: @return      
	 * @return: PageEU<WtBasinMonitorEntity>      
	 * @throws
	 */
	@RequestMapping("/listWtBasinMonitor")
	@ResponseBody
	public PageEU<WtBasinMonitorEditEntity> list(WtBasinMonitorParam param, HttpServletRequest request) {
		Page<WtBasinMonitorEditEntity> page = pageQuery(request);
		Page<WtBasinMonitorEditEntity> wtDayDataPage = wtBasinMonitorService.listByPage(param, page);
		return new PageEU<>(wtDayDataPage);
	}
/**
 * 
 * @Title: listWtBasinMonitor   
 * @Description: 获取小河流域信息列表
 * @param: @param param
 * @param: @param request
 * @param: @return      
 * @return: List<WtBasinMonitorEditEntity>      
 * @throws
 */
	@RequestMapping("/listWtBasinMonitor1")
	@ResponseBody
	public List<WtBasinMonitorEditEntity> listWtBasinMonitor(WtBasinMonitorParam param, HttpServletRequest request) {
		List<WtBasinMonitorEditEntity> listWtBasinMonitor = wtBasinMonitorService.listWtBasinMonitor(param);
		return listWtBasinMonitor;
	}
/***
 * 
 * @Title: updataWtBasinMonitor   
 * @Description: 分配小河流域修改权限  
 * @param: @param uid
 * @param: @param checkVal
 * @param: @param checkedId
 * @param: @param request
 * @param: @return      
 * @return: R      
 * @throws
 */
	@RequestMapping("/updateWtBasinMonitor")
	@ResponseBody
	public R updataWtBasinMonitor(String uid, String checkVal, String checkedId, HttpServletRequest request) {
		int updataWtBasinMonitor = wtBasinMonitorService.updataWtBasinMonitor(uid, checkVal, checkedId);
		return R.ok(String.valueOf(updataWtBasinMonitor));
	}

	/**
	 * 
	 * @Title:  matchtWtBasinMonitor
	 * @Description:   更新wt_basin_monitor数据   
	 * @CreateBy: daizhengui 
	 * @CreateTime: 2019年4月29日 下午4:31:58
	 * @UpdateBy: daizhengui 
	 * @UpdateTime:  2019年4月29日 下午4:31:58    
	 * @param param
	 * @param request
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/editWtBasinMonitor")
	@ResponseBody
	public R matchtWtBasinMonitor(WtBasinMonitorEditEntity param, HttpServletRequest request) {
		int updataWtBasinMonitor = wtBasinMonitorService.editWtBasinMonitor(param);
		return R.ok(String.valueOf(updataWtBasinMonitor));
	}
	/**
	 * 
	 * @Title:  examineWtBasinMonitor
	 * @Description:  小河流域数据审核通过
	 * @CreateBy: daizhengui 
	 * @CreateTime: 2019年4月29日 下午4:39:32
	 * @UpdateBy: daizhengui 
	 * @UpdateTime:  2019年4月29日 下午4:39:32    
	 * @param param
	 * @param request
	 * @return  R 
	 * @throws
	 */
	 

	@RequestMapping("/examine")
	@ResponseBody
	public R examineWtBasinMonitor(WtBasinMonitorEditEntity param, HttpServletRequest request) {
		int updataWtBasinMonitor = wtBasinMonitorService.examineWtBasinMonitor(param);
		return R.ok(String.valueOf(updataWtBasinMonitor));
	}

	/**
	 * 
	 * @Title: listUserRiver   
	 * @Description: 小河流域列表根据登录名成来获取用户管理的小河流域;
	 * @param: @param uid
	 * @param: @param loginName
	 * @param: @param request
	 * @param: @return      
	 * @return: List<WtBasinMonitorEntity>      
	 * @throws
	 */
	@RequestMapping("/listUserRiver")
	@ResponseBody
	public List<WtBasinMonitorEditEntity> listUserRiver(String uid,String loginName, HttpServletRequest request) {
		String county="";
		if(StringUtils.isBlank(loginName)) {
			loginName=CommonUtil.getCustommerUserDetail(request).getUsername();
			String[] countyEnum=loginName.split("_");
			if(countyEnum.length!=loginNameLength) {
				return null;
			}
			EnumCounty enumByKey = EnumCounty.getEnumByKey(countyEnum[1]);
			county=enumByKey==null?"":enumByKey.getValue();
			if(StringUtils.isBlank(county)) {
				uid=CommonUtil.getCustommerUserDetail(request).getUuid();
			}
		}
		
		return wtBasinMonitorService.listUserRiver(uid,county);
	}

	/**
	 * 
	 * @Title: listUserRiver   
	 * @Description: 小河流域管理页面跳转 市账号查看县的河流数量
	 * @param: @param model
	 * @param: @param userName
	 * @param: @param uuid
	 * @param: @param loginName
	 * @param: @param request
	 * @param: @return      
	 * @return: ModelAndView      
	 * @throws
	 */
	@RequestMapping("/watchUserRiver")
	public ModelAndView listUserRiver(ModelAndView model, String userName, String uuid,String loginName, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/moudles/enviromonit/water/userEditRiverDataForm");
		mav.addObject("name", userName);
		mav.addObject("uuid", uuid);
		mav.addObject("loginName",loginName);
		return mav;
	}
   
	
}
