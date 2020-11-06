package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import com.alibaba.fastjson.JSON;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.DataService;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PollutionInfoService;
import com.fjzxdz.ams.module.enviromonit.pollution.service.impl.DataServiceImpl;
import com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.Map;

/**
 * 
 * 水环境-应急短信下发-水质问题整改任务派发
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午2:57:31
 */
@Controller
@RequestMapping("/env/pollution2/data")
@Secured({ "ROLE_USER" })
public class DataController extends BaseController {
	@Autowired
	private DataService dataService;
	@Autowired
	private TaskDetalisService taskDetalisService;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private PollutionInfoService pollutionInfoService;

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView, String pid) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/pollution/PollutionInfoData");
		return modelAndView;
	}

	/**
	 * @Author lianhuinan
	 * @Description //TODO(污染源数据——excel导入)
	 * @Date 2019/10/11 0011 11:17
	 * @param file
	 * @param request
	 * @return cn.fjzxdz.frame.pojo.R
	 * @version 1.0
	 **/
	@RequestMapping("/importFile")
	@ResponseBody
	public R importFile(@RequestParam(name = "xlsxfile") MultipartFile file, HttpServletRequest request)
			throws Exception {
		if (file.isEmpty()) {
			throw new Exception("文件不存在！");
		}
		String fileName=file.getOriginalFilename();
		String suffix=fileName.substring(fileName.lastIndexOf("."));
		String prefix=fileName.substring(0,fileName.lastIndexOf("."));
		String message="";
        File excelFile = null;
		try {
			excelFile=File.createTempFile(prefix, suffix);
			file.transferTo(excelFile);
			List<List<Object>> result = getExcelContent(excelFile);
			message = dataService.save(result, getUserPidPath());
		}catch (Exception e) {
			e.printStackTrace();
			return R.error("导入失败："+e.getMessage()+"！\n注意：有多行空数据，请使用官方提供模板上传数据。");
		}finally {
			deleteFile(excelFile);
        }
		if(message!="") {
			return R.error("导入失败："+message);
		}
		return R.ok("导入成功");
	}

	/**
	 * @Author lianhuinan
	 * @Description //TODO(删除临时文件)
	 * @Date 2019/10/11 0011 11:15
	 * @param excelFile
	 * @return void
	 * @version 1.0
	 **/
	private void deleteFile(File... excelFile) {
		for (File file : excelFile) {  
            if (file.exists()) {  
                file.delete();  
            }  
        }  
	}

	/**
	 * @Author lianhuinan
	 * @Description //TODO(获取excel文件的内容)
	 * @Date 2019/10/11 0011 11:18
	 * @param excelFile
	 * @return java.util.List<java.util.List < java.lang.Object>>
	 * @version 1.0
	 **/
	public List<List<Object>> getExcelContent(File excelFile) throws Exception{
		FileInputStream fileInputStream = null;
		if (excelFile.isFile() && excelFile.exists()) {
			String suffix = excelFile.getName().substring(excelFile.getName().lastIndexOf("."));
			if(".xls".equals(suffix) || ".xlsx".equals(suffix)) {
				fileInputStream = new FileInputStream(excelFile);
			}else {
				throw new Exception("文件类型错误！");
			}
		}

		ExcelReader reader = ExcelUtil.getReader(fileInputStream);
		List<List<Object>> lists = reader.read();
		if(ToolUtil.isNotEmpty(lists)) {
			for (List list : lists) {
				if (ToolUtil.isEmpty(list)) {
					System.out.println(list.toString());
					lists.remove(list);
				}
			}
		}
		return lists;
	}

	/**
	 * 污染源数据信息  --分页
	 * @param pollutionInfoData 参数集合
	 * @param request
	 * @return
	 */
	@RequestMapping("/getInfoPage")
	@ResponseBody
	public PageEU<Map<String, Object>> getBasinNameByArea(PollutionInfoData pollutionInfoData, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder.append(" SELECT * FROM POLLUTION_INFO_DATA WHERE 1=1 ");
		if (StringUtils.isNotEmpty(pollutionInfoData.getMc())) {
			sqlBuilder.append(" AND MC LIKE ").append(SqlUtil.toSqlStr_like(pollutionInfoData.getMc()));
		}
		sqlBuilder.append(" ORDER BY UPDATE_DATE DESC NULLS LAST  ");
		Page<Map<String, Object>> listPage = simpleDao.listNativeByPage(sqlBuilder.toString(), page);
		return new PageEU<>(listPage);
	}

	/**
	 * 保存修改污染源数据信息
	 * @param pollutionInfoData
	 */
	@RequestMapping(value = "/saveInfo")
	@ResponseBody
	public R saveInfo(PollutionInfoData pollutionInfoData) {
		try {
			DataServiceImpl dataService = new DataServiceImpl();
			pollutionInfoData.setDeptPath(getUserPidPath());
			String patternValid = dataService.patternValid(pollutionInfoData);
			if (StringUtils.isNotEmpty(patternValid)) {
				return R.error(patternValid);
			} else {
				pollutionInfoService.saveInfo(pollutionInfoData);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	/**
	 * 删除污染源数据信息
	 * @param pkid
	 * @return
	 */
	@RequestMapping(value = "/deleteInfo")
	@ResponseBody
	public R deleteCompanyInfo(@RequestParam(value = "pkid", required = true) String pkid) {
		try {
			if (org.springframework.util.StringUtils.isEmpty(pkid)) {
				return R.ok("污染源数据信息已经删除！");
			} else {
				pollutionInfoService.deleteInfo(pkid);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 *
	 * @Title:  getType
	 * @Description:    获取污染源种类，污染源类型
	 * @CreateBy: hyl
	 * @CreateTime: 2019年10月12日10:14:47
	 * @UpdateBy: hyl
	 * @UpdateTime:  2019年10月12日10:14:56
	 * @param flag	(wryzl为污染源种类，wrylx为污染源类型)
	 * @return  String
	 * @throws
	 */
	@RequestMapping("/getType")
	@ResponseBody
	public String getType(@RequestParam(value = "flag", required = true)String flag,String tblName) {
		com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();
		if (StringUtils.isEmpty(tblName)) {
			return array.toJSONString();
		}
		StringBuilder sql = new StringBuilder(" SELECT DISTINCT ").append(flag).append(" uuid , ").append(flag)
	            .append(" name  FROM ").append(tblName).append(" WHERE  ").append(flag).append( " IS NOT NULL ");
//		if ("wryzl".equals(flag)) {
//			sql.append("and wryzl in ('持证矿山','散乱污企业','工业固废','涉海工业固废','工业危险废物','VOCs企业','涉水工业企业',"
//	                + "'海洋排污口','高架源企业','石板材行业','非道路移动源','三格化粪池')");
//		}
		List<Map> list = simpleDao.getNativeQueryList(sql.toString());
		return JSON.toJSONString(list);
	}

}
