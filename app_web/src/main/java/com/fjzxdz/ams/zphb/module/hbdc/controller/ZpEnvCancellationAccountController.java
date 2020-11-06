package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.PersistenceService;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvCancellationAccount;
import com.fjzxdz.ams.module.debriefing.param.EnvCancellationAccountParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvCancellationAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * 销号概况,销号汇总表 
 * @Author   
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午10:12:18
 */
@Controller
@RequestMapping("/zphb/environment/envCancellationAccount")
@Secured({ "ROLE_USER" })
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class ZpEnvCancellationAccountController extends BaseController {

    @Autowired
    private ZpEnvCancellationAccountService envCancellationAccountService;
    @Autowired
    private PersistenceService persistenceService;

    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView,String authority,String pid) {
    	modelAndView.addObject("authority", authority);
    	modelAndView.addObject("pid", pid);
    	modelAndView.setViewName("/zphb/moudles/hbdc/envCancellationAccountList");
        return modelAndView;
    }
    
    @RequestMapping("/show")
    public ModelAndView show(ModelAndView modelAndView,String authority,String pid) {
        modelAndView.addObject("authority", authority);
        modelAndView.addObject("pid", pid);
    	modelAndView.setViewName("/zphb/moudles/hbdc/envCancellationAccountIndex");
        return modelAndView;
    }
    
    /**
     * 
     * @Title:  delete
     * @Description:    销号汇总表	-	删除
     * @CreateBy: chenmingdao 
     * @CreateTime: 2019年5月10日 上午10:10:57
     * @UpdateBy: chenmingdao 
     * @UpdateTime:  2019年5月10日 上午10:10:57    
     * @param uuid
     * @return  R 
     * @throws
     */
    @RequestMapping("/delete")
	@ResponseBody
	public R delete(String uuid) {
		try {
			envCancellationAccountService.deleteByUuid(uuid);
			return R.ok("删除成功！");
		}catch (Exception e) {
			return R.error("删除失败！ ");
		}
	}

    
    /**
     * 
     * @Title:  list
     * @Description:    销号汇总表 - 分页列表   
     * @CreateBy:  
     * @CreateTime: 2019年5月10日 上午10:29:32
     * @UpdateBy:  
     * @UpdateTime:  2019年5月10日 上午10:29:32    
     * @param param
     * @param request
     * @return  PageEU<EnvCancellationAccount> 
     * @throws
     */
    @RequestMapping("/list")
    @ResponseBody
    public PageEU<EnvCancellationAccount> list(EnvCancellationAccountParam param, HttpServletRequest request, HttpServletResponse response) {
        Page<EnvCancellationAccount> page = pageQuery(request);
        Page<EnvCancellationAccount> accountPage = envCancellationAccountService.listByPage(param, page);
        //导出
		if ("yes".equals(request.getParameter("export"))) {
			List<EnvCancellationAccount> result = new ArrayList<EnvCancellationAccount>();

			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			columnMap.put("title", "漳州市环保督察销号汇总表");
			columnMap.put("projectName", "项目名称");
			columnMap.put("describleName", "问题简述");
			columnMap.put("timeLimit", "问题整改完成时限");
			columnMap.put("schedule", "整改进度");
			columnMap.put("countyActualTime", "实际县级验收时间");
			columnMap.put("cityActualTime", "实际实级验收时间");
			columnMap.put("professionActualTime", "实际提交行业验收时间");
			columnMap.put("professionExamineTime", "完成行业审查时间");
			ExcelExportUtil.exportExcel(response, columnMap, accountPage.getResult());
			return null;
		}
        return new PageEU<>(accountPage);
    }

    /**
     * 
     * @Title:  saveTime
     * @Description:   销号汇总表  - 修改时间
     * @CreateBy:  
     * @CreateTime: 2019年5月10日 上午10:31:02
     * @UpdateBy:  
     * @UpdateTime:  2019年5月10日 上午10:31:02    
     * @param uuid
     * @param columnId
     * @param modifyTime
     * @param request
     * @return  R 
     * @throws
     */
    @RequestMapping(value = "/saveTime")
    @ResponseBody
    public R saveTime(String uuid, String columnId, String modifyTime, HttpServletRequest request) {
        try {
            String sql = "update ENV_CANCELLATION_ACCOUNT set " + columnId + "=to_date('"
                    + modifyTime + "', 'yyyy-MM-dd') where uuid='" + uuid + "'";
            persistenceService.upgrade(sql);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 
     * @Title:  getEcharts
     * @Description:    销号概况  - 柱状图 
     * @CreateBy:  
     * @CreateTime: 2019年5月10日 上午10:28:58
     * @UpdateBy:  
     * @UpdateTime:  2019年5月10日 上午10:28:58    
     * @param startTime
     * @param endTime
     * @return
     * @throws ParseException  JSONObject 
     * @throws
     */
    @RequestMapping(value = "/getEcharts")
    @ResponseBody
    public JSONObject getEcharts(String startTime,String endTime) throws ParseException {
//    	startTime = CountUtil.getStartDate(startTime,0);
//		endTime = CountUtil.getEndDate(endTime,0);
		SimpleDateFormat simpleDateFormat  = new SimpleDateFormat("yyyy-MM-dd");
        JSONObject result = envCancellationAccountService.getEcharts(startTime);
        return result;
    }
    
    /**
     * 
     * @Title:  getDescript
     * @Description:    销号汇总表  - 描述  
     * @CreateBy:  
     * @CreateTime: 2019年5月10日 上午10:28:36
     * @UpdateBy:  
     * @UpdateTime:  2019年5月10日 上午10:28:36    
     * @param param
     * @return  R 
     * @throws
     */
    @RequestMapping("/getDescript")
    @ResponseBody
    public R getDescript(EnvCancellationAccountParam param) {
		return envCancellationAccountService.getDescript(param);
    }
    
    /**
     * 
     * @Title:  getDecription
     * @Description:    根据项目id和项目状态获取描述信息    
     * @CreateBy: zhongyunlong 
     * @CreateTime: 2019年5月5日 下午4:49:40
     * @UpdateBy: zhongyunlong 
     * @UpdateTime:  2019年5月5日 下午4:49:40    
     * @param id	项目id
     * @param status	项目状态
     * @param request
     * @return  PageEU<Map<String,Object>> 
     * @throws
     */
    @RequestMapping(value="/getDecription")
	@ResponseBody
	public PageEU<Map<String, Object>> getDecription(String id,String status,HttpServletRequest request){
		status = getStatus(status);
        Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> decription = envCancellationAccountService.getDecription(id,status,page);
		return new PageEU<>(decription);
	}
	
    /**
     * 
     * @Title:  getDetail
     * @Description:    获取描述的详细信息    
     * @CreateBy: zhongyunlong 
     * @CreateTime: 2019年5月5日 下午4:49:27
     * @UpdateBy: zhongyunlong 
     * @UpdateTime:  2019年5月5日 下午4:49:27    
     * @param id	id
     * @param request
     * @return  PageEU<Map<String,Object>> 
     * @throws
     */
	@RequestMapping("/getDetail")
	@ResponseBody
	public PageEU<Map<String, Object>> getDetail(String id,HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> result = envCancellationAccountService.getDetail(id,page);
		return new PageEU<>(result);
	}
	
	/**
	 * 
	 * @Title:  getDecriptionAll
	 * @Description:    根据任务状态获取所有描述信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月5日 下午4:48:22
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月5日 下午4:48:22    
	 * @param status	任务状态
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getDecriptionAll")
	@ResponseBody
	public PageEU<Map<String, Object>> getDecriptionAll(String status,HttpServletRequest request){
		status = getStatus(status);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> decription = envCancellationAccountService.getDecriptionAll(status,page,request);
		return new PageEU<>(decription);
	}
    
	/**
	 * 
	 * @Title:  getStatus
	 * @Description:    根据状态返回查询条件    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月5日 下午4:48:00
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月5日 下午4:48:00    
	 * @param status
	 * @return  String 
	 * @throws
	 */
    public String getStatus(String status) {
		String xysAll = ""; //县验收
		String sysAll = ""; //市验收
		String hyscAll = ""; //行业审查
		String wcshAll = ""; //完成审核
		if(status.equals("完成县级验收")) {
			xysAll = "not";
		}else if(status.equals("完成市级验收")) {
			xysAll = "not";
			sysAll = "not";
		}else if(status.equals("提交行业审查")) {
			xysAll = "not";
			sysAll = "not";
			hyscAll = "not";
		}else if(status.equals("完成行业审核")) {
			xysAll = "not";
			sysAll = "not";
			hyscAll = "not";
			wcshAll = "not";
		}
		if (!"undefined".equals(status)) {
			status = " AND COUNTY_ACTUAL_TIME IS "+xysAll+" NULL AND CITY_ACTUAL_TIME IS "+sysAll
					+" NULL  AND PROFESSION_ACTUAL_TIME IS "+hyscAll +" NULL AND PROFESSION_EXAMINE_TIME IS "+wcshAll+" NULL ";
		}else {
			status = "";
		}

		return status;
	}
}
