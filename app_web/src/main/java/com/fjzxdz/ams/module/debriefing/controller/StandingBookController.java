package com.fjzxdz.ams.module.debriefing.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.CommonAttachment;
import com.fjzxdz.ams.module.debriefing.param.CommonAttachmentParam;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;
import com.fjzxdz.ams.module.debriefing.service.StandingBookService;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

/**
 * 
 * 环保督察 具体台账 controller
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午9:58:28
 */
@Controller
@RequestMapping("/debrief/StandingBook")
@Secured({ "ROLE_USER" })
public class StandingBookController extends BaseController {

	@Autowired
	private StandingBookService standingBookService;

	@Autowired
	private IMongoAttachFile iMongoAttachFile;

	@Autowired
	private MongoTemplate mongoTemplate;
	/**
	 * 
	 * @Title:  index
	 * @Description:    环保督察 跳转到具体台账页面
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:58:49
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:58:49    
	 * @param modelAndView
	 * @param authority
	 * @return  ModelAndView 
	 * @throws
	 */
	@RequestMapping("")
	public ModelAndView index(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/debriefing/standingBookList");
		return modelAndView;
	}

	/**
	 * 
	 * @Title:  list
	 * @Description:    台账内容分页显示    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:59:07
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:59:07    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Map<String, Object>> list(CommonRelationTableParam param, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> standingBookPage = standingBookService.listByPage(param, page);

		return new PageEU<>(standingBookPage);
	}

	/**
	 * 
	 * @Title:  getSubClass
	 * @Description:     获取大类对应的小类信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午10:00:01
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午10:00:01    
	 * @param type
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getSubClassName")
	@ResponseBody
	public String getSubClass(String type) {
		List<Object[]> list = standingBookService.getSubClass(type);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		if (ToolUtil.isNotEmpty(list)) {
			for (Object[] objects : list) {
				jsonObject.put("uuid", objects[0]);
				jsonObject.put("name", objects[1]);
				jsonObject.put("relation", objects[3]);
				jsonArray.put(jsonObject);
			}
		}
		return jsonArray.toString();
	}

	/**
	 * 
	 * @Title:  save
	 * @Description:    上传文件    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午10:00:09
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午10:00:09    
	 * @param commonAttach
	 * @param multipartFile
	 * @param request
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(CommonAttachment commonAttach, @RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		try {
			String originFilename = multipartFile.getOriginalFilename();
			MongoAttachFile mongoAttachFile = new MongoAttachFile();
			if (ToolUtil.isNotEmpty(originFilename)) {
				mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
						StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
				commonAttach.setMongoid(mongoAttachFile.getUuid());
				commonAttach.setFileName(mongoAttachFile.getFileName());
				standingBookService.save(commonAttach);
			}

		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


	/**
	 * 
	 * @Title:  attachmentList
	 * @Description:    文件信息分页显示   
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午10:04:02
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午10:04:02    
	 * @param param
	 * @param request
	 * @return  PageEU<CommonAttachment> 
	 * @throws
	 */
	@RequestMapping("/attachmentList")
	@ResponseBody
	public PageEU<CommonAttachment> attachmentList(CommonAttachmentParam param, HttpServletRequest request) {
		Page<CommonAttachment> page = pageQuery(request);
		Page<CommonAttachment> waterAttachment = standingBookService.listByPage(param, page);
		return new PageEU<>(waterAttachment);
	}

	/**
	 * 
	 * @Title:  download
	 * @Description:    下载文件    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午10:03:53
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午10:03:53    
	 * @param fileId
	 * @param type
	 * @param response
	 * @param request  void 
	 * @throws
	 */
	@RequestMapping(value = "/download/{fileId}")
	public void download(@PathVariable String fileId, String type, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			GridFSFile gridfs = iMongoAttachFile.getFile(fileId);

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition",
					"attachment;filename=" + URLEncoder.encode(gridfs.getFilename(), "utf-8"));

			OutputStream out = response.getOutputStream();
			getGridFs().downloadToStream(gridfs.getId(), out);

			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @Title:  browseFile
	 * @Description:    查看文件    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午10:03:40
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午10:03:40    
	 * @param fileId
	 * @param type
	 * @param response
	 * @param request  void 
	 * @throws
	 */
	@RequestMapping(value = "/browse/{fileId}")
	public void browseFile(@PathVariable String fileId, String type, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			GridFSFile gridfs = iMongoAttachFile.getFile(fileId);

			if ("pdf".equals(gridfs.getMetadata().get("_contentType"))) {
				response.setContentType("application/pdf");
				response.setHeader("Content-Disposition",
						"fileName=" + URLEncoder.encode(gridfs.getFilename(), "utf-8"));
			} else if ("mp4".equals(gridfs.getMetadata().get("_contentType"))) {
				byte[] data = gridfs.getObjectId().toByteArray();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder
						.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString("_contentType"), "utf-8"));
				String range = request.getHeader("range");
				response.setContentType("video/mp4");
				response.setContentLength((int) gridfs.getLength());
				response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
				response.setHeader("Accept-Ranges", "text/x-dvi");
				response.setHeader("Etag", "W/\"9767057-1323779115364\"");
			} else if ("png".equals(gridfs.getMetadata().get("_contentType"))
					|| "jpg".equals(gridfs.getMetadata().get("_contentType"))) {
				response.setContentType("image/jpeg");
				response.setHeader("Content-Disposition", "filename=" + URLEncoder
						.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString("_contentType"), "utf-8"));
			} else {
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + URLEncoder.encode(gridfs.getFilename(), "utf-8"));
			}
			OutputStream out = response.getOutputStream();
			getGridFs().downloadToStream(gridfs.getId(), out);

			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected GridFSBucket getGridFs() {
		MongoDatabase db = mongoTemplate.getDb();
		return GridFSBuckets.create(db);
	}

}
