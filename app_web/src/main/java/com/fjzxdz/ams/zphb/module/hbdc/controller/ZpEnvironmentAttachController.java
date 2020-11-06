package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;
import com.fjzxdz.ams.module.debriefing.entity.CommonTaskTable;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;
import com.fjzxdz.ams.module.debriefing.param.CommonTaskTableParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpCommonRelationTableService;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpCommonTaskTableService;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentAttachService;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping("/zphb/environment/attach")
@Secured({ "ROLE_USER" })
/**
 * 
 * 包含重要工作-八闽快讯（一本账）功能	 和	环保督察部分功能
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午1:57:52
 */
public class ZpEnvironmentAttachController extends BaseController {

	@Autowired
	private ZpEnvironmentAttachService attachService;

	@Autowired
	private MongoTemplate mongoTemplate;
	
	@Autowired
	private ZpCommonTaskTableService commonTaskTableService;
	
	@Autowired
	private ZpCommonRelationTableService commonRelationTableService;
	
	@RequestMapping("/environmentAttachTask")
	private ModelAndView environmentAttachTask(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/environmentAttachTaskTable");
		return modelAndView;
	}
	
	@RequestMapping("/environmentAttachAddTask")
	private String environmentAttachAddTask() {
		return "/zphb/moudles/hbdc/environmentAttachAddTask";
	}
	
	@RequestMapping("/environmentAttachDisplay")
	public ModelAndView environmentAttachDisplay(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/environmentAttachDisplay");
		return modelAndView;
	}
	
	/**
	 * 
	 * @Title:  getChartList
	 * @Description:  八闽快讯（一本账）总体情况柱状图 和饼图 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:47:22
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:47:22    
	 * @param startTime
	 * @param endTime
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/getChartList")
	@ResponseBody
	public R getChartList(String startTime,String endTime) {
		JSONObject chartList = commonTaskTableService.getChartList(startTime,endTime);
		return R.ok(chartList);
	}
	
	/**
	 * 
	 * @Title:  getDescript
	 * @Description:    八闽快讯汇总表    -  描述
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:48:59
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:48:59    
	 * @param param
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/getDescript")
	@ResponseBody
	public R getDescript(CommonTaskTableParam param) {
		return commonTaskTableService.getDescript(param);
	}
	
	/**
	 * 
	 * @Title:  getPageList
	 * @Description:    八闽快讯汇总表   - 列表   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:48:50
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:48:50    
	 * @param param
	 * @param request
	 * @return  PageEU<CommonTaskTable> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<CommonTaskTable> getPageList(CommonTaskTableParam param, HttpServletRequest request) {
		Page<CommonTaskTable> page = pageQuery(request);
		Page<CommonTaskTable> commonTaskTable = commonTaskTableService.getPageList(param, page);
		return new PageEU<CommonTaskTable>(commonTaskTable);
	}
	
	/**
	 * 
	 * @Title:  setStatus
	 * @Description:    八闽快讯汇总表  - 设置状态    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:50:12
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:50:12    
	 * @param uuid
	 * @param status
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/setStatus")
	@ResponseBody
	public R setStatus(String uuid,BigDecimal status) {
		int i = commonTaskTableService.setStatus(uuid,status);
		if(i!=0) {
			return R.ok("修改成功");
		}
		return R.error("修改失败");
	}
	
	/**
	 * 
	 * @Title:  getRelationNameList
	 * @Description:    八闽快讯汇总表 - 获取项目  list    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:52:57
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:52:57    
	 * @param relation
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getRelationNameList")
	@ResponseBody
	public JSONArray getRelationNameList(String relation) {
		JSONArray array=new JSONArray();
		List<Object[]> list = commonTaskTableService.getRelationNameList(relation);
		for(Object[] objects:list) {
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("id", objects[0]);
			jsonObject.put("text", objects[1]);
			array.add(jsonObject);
		}
		return array;
	}
	
	/**
	 * 
	 * @Title:  addTask
	 * @Description:    八闽快讯  - 新增任务
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:53:33
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:53:33    
	 * @param commonTaskTable
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/addTask")
	@ResponseBody
	public R addTask(CommonTaskTable commonTaskTable) {
		commonTaskTable.setCreateTime(DateUtil.parseDate(commonTaskTable.getCreatetime()));
		int i = commonTaskTableService.addTask(commonTaskTable);
		if(i!=0) {
			return R.ok("添加成功");
		}
		return R.error("添加失败");
	}
	
	/**
	 * 
	 * @Title:  getRelationList
	 * @Description:    八闽快讯  - 新增任务  - 新增项目弹窗 - 项目列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:53:58
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:53:58    
	 * @param param
	 * @param request
	 * @return  PageEU<CommonRelationTable> 
	 * @throws
	 */
	@RequestMapping("/getRelationList")
	@ResponseBody
	public PageEU<CommonRelationTable> getRelationList(CommonRelationTableParam param, HttpServletRequest request){
		Page<CommonRelationTable> page = pageQuery(request);
		Page<CommonRelationTable> commonRelationTable = commonRelationTableService.listByPage(param, page);
		return new PageEU<CommonRelationTable>(commonRelationTable);
	}
	
	/**
	 * 
	 * @Title:  addRelation
	 * @Description:    八闽快讯  - 新增任务  - 新增项目弹窗 - 新增项目  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:54:46
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:54:46    
	 * @param relationName
	 * @param relation
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/addRelation")
	@ResponseBody
	public R addRelation(String relationName,String relation) {
		String message;
		try {
			CommonRelationTable commonRelationTable=new CommonRelationTable();
			commonRelationTable.setName(relationName);
			commonRelationTable.setRelation(relation);
			message = commonRelationTableService.save(commonRelationTable);
			return R.ok(message);
		}catch (Exception e) {
			return R.error("添加失败！");
		}
	}
	
	/**
	 * 
	 * @Title:  editRelation
	 * @Description:   八闽快讯  - 新增任务  - 新增项目弹窗 - 项目列表    - 编辑
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:55:06
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:55:06    
	 * @param commonRelationTable
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/editRelation")
	@ResponseBody
	public R editRelation(CommonRelationTable commonRelationTable) {
		String message ="操作失败";
		try {
			message = commonRelationTableService.save(commonRelationTable);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		if (message.indexOf("失败")>-1) {
			return R.error(message);
		}
		return R.ok(message);
	}
	
	/**
	 * 
	 * @Title:  delRelation
	 * @Description:    八闽快讯  - 新增任务  - 新增项目弹窗 - 项目列表 - 删除 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:55:20
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:55:20    
	 * @param commonRelationTable
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/delRelation")
	@ResponseBody
	public R delRelation(CommonRelationTable commonRelationTable) {
		try {
			commonRelationTableService.delete(commonRelationTable.getUuid());
			return R.ok("删除成功");
		}catch (Exception e) {
			return R.error("删除失败");
		}
	}
	
	/**
	 * 
	 * @Title:  save
	 * @Description:    八闽快讯  - 新增任务 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:55:37
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:55:37    
	 * @param commonTaskTable
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/saveCommonTaskTable")
	@ResponseBody
	public R save(CommonTaskTable commonTaskTable) {
		try {
			commonTaskTableService.save(commonTaskTable);
		} catch (Exception e) {
			return R.error("修改失败！");
		}
		return R.ok("修改成功！");
	}
	
	/**
	 * 
	 * @Title:  delete
	 * @Description:    八闽快讯汇总表  - 删除任务
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:55:53
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:55:53    
	 * @param uuid
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public R delete(String uuid) {
		try {
			commonTaskTableService.delete(uuid);
		} catch (Exception e) {
			return R.error("删除失败！");
		}
		return R.ok("删除成功！");
	}
	
	/**
	 * 在线加载文件
	 * @param uuid
	 * @param response
	 */
	@RequestMapping("/file")
	public void imageShow(String uuid, HttpServletResponse response) {
		try {
			GridFSFile gridfs = attachService.get(uuid);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename()+"."+gridfs.getMetadata().getString("_contentType"),"utf-8"));
			getGridFSBucket().downloadToStream(gridfs.getObjectId(), response.getOutputStream());
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	/**
	 * 在线加载文件
	 * @param uuid
	 * @param response
	 */
	@RequestMapping("/file2")
	public void imageShow2(String mongoid, HttpServletResponse response) {
		try {
			GridFSFile gridfs = attachService.getByMongoId(mongoid);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename()+"."+gridfs.getMetadata().getString("_contentType"),"utf-8"));
			getGridFSBucket().downloadToStream(gridfs.getObjectId(), response.getOutputStream());
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	/**
	 * 访问文件
	 */
	@RequestMapping(value = "/download/{fileId}/{type}")
	public void getFile(@PathVariable String fileId,@PathVariable String type,
			HttpServletResponse response, HttpServletRequest request) {
		try {
			GridFSFile gridfs = attachService.getByMongoId(fileId);
			if("pdf".equals(gridfs.getMetadata().get("_contentType"))) {
				response.setContentType("application/pdf");
				response.setHeader("Content-Disposition", "fileName="+URLEncoder.encode(gridfs.getFilename(), "utf-8"));
			} else if("mp4".equals(gridfs.getMetadata().get("_contentType"))) {
				byte[] data = gridfs.getObjectId().toByteArray();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename()+"."+gridfs.getMetadata().getString("_contentType"),"utf-8"));
				String range = request.getHeader("range");
				response.setContentType("video/mp4");
				response.setContentLength((int) gridfs.getLength());
				response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
				response.setHeader("Accept-Ranges", "text/x-dvi");
				response.setHeader("Etag", "W/\"9767057-1323779115364\"");
			} else if("2".equals(type)) {
				response.setContentType("image/jpeg");
				response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(gridfs.getFilename()+"."+gridfs.getMetadata().getString("_contentType"),"utf-8"));
			} else {
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(),"utf-8"));
			}
			OutputStream out = response.getOutputStream();
			getGridFSBucket().downloadToStream(gridfs.getId(), out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 在线加载文件
	 * @param uuid
	 * @param response
	 */
	@SuppressWarnings("unused")
	@RequestMapping("/video")
	public void video(String uuid, HttpServletResponse response,HttpServletRequest request) {
		try {
			GridFSFile gridfs = attachService.get(uuid);
			byte[] data = gridfs.getObjectId().toByteArray();
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename()+"."+gridfs.getMetadata().getString("_contentType"),"utf-8"));
			
			String range = request.getHeader("range");
			String browser = request.getHeader("User-Agent");
			response.setContentType("video/mp4");
			response.setContentLength((int) gridfs.getLength());
			response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
			response.setHeader("Accept-Ranges", "text/x-dvi");
			response.setHeader("Etag", "W/\"9767057-1323779115364\"");
			getGridFSBucket().downloadToStream(gridfs.getObjectId(), response.getOutputStream());
//			byte[] content = new byte[1024];
//			BufferedInputStream is = new BufferedInputStream(new ByteArrayInputStream(data));
//			OutputStream os = response.getOutputStream();
//			while (is.read(content) != -1) {
//				os.write(content);
//			}
//			is.close();
//			os.close();
		} catch (Exception e) {
			e.getMessage();
		}
	}

	private GridFSBucket getGridFSBucket() {
		return GridFSBuckets.create(mongoTemplate.getDb());
	}
}
