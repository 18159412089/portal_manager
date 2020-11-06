/*   
 * Copyright (c) 2015-2020 FuJianZhongXingDianzi. All Rights Reserved.   
 *   
 * This software is the confidential and proprietary information of   
 * Founder. You shall not disclose such Confidential Information   
 * and shall use it only in accordance with the terms of the agreements   
 * you entered into with Founder.   
 *   
 */
package com.fjzxdz.ams.module.jobSchedule.controller;

import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fjzxdz.ams.module.jobSchedule.entity.CliqueBuild;
import com.fjzxdz.ams.module.jobSchedule.param.CliqueBuildParam;
import com.fjzxdz.ams.module.jobSchedule.service.CliqueBuildService;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import org.springframework.web.servlet.ModelAndView;

/**
 * 党建Controller
 * 
 * @Author caibai
 */
@Controller
@RequestMapping(value = "/jobSchedule/cliqueBuild")
public class CliqueBuildController extends BaseController {

	@Autowired
	private CliqueBuildService cliqueBuildService;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private IMongoAttachFile iMongoAttachFile;
	@Autowired
	private MongoTemplate mongoTemplate;

	@RequestMapping("")
	public ModelAndView index(String pid, ModelAndView modelAndView) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/jobSchedule/cliqueBuildList");
		return modelAndView;
//		return "/moudles/jobSchedule/cliqueBuildList";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageEU<CliqueBuild> list(CliqueBuildParam param, HttpServletRequest request) {
		Page<CliqueBuild> page = pageQuery(request);
		Page<CliqueBuild> cliqueBuild = cliqueBuildService.listByPage(param, page);
		return new PageEU<>(cliqueBuild);
	}

	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		CliqueBuild cliqueBuild;
		try {
			cliqueBuild = cliqueBuildService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("result", cliqueBuild);
	}

	@RequestMapping(value = "/saveFile")
	@ResponseBody
	public R save(CliqueBuild cliqueBuild, @RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		try {
			String originFilename = multipartFile.getOriginalFilename();
			MongoAttachFile mongoAttachFile = new MongoAttachFile();
			if (ToolUtil.isNotEmpty(originFilename)) {
				mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
						StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
				cliqueBuild.setMongoid(mongoAttachFile.getUuid());
				cliqueBuild.setType(mongoAttachFile.getContentType());
				cliqueBuild.setFileName(StringUtils.getFilename(originFilename));
			}
			cliqueBuildService.save(cliqueBuild);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public R delete(@RequestParam(value = "uuid", required = true) String uuid,
			@RequestParam(value = "mongoid", required = true) String mongoid) {
		try {
			cliqueBuildService.delete(uuid);
			iMongoAttachFile.removeFile(mongoid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 查看文件
	 */
	@RequestMapping(value = "/viewFile/{fileId}/{type}")
	public void viewFile(@PathVariable String fileId, @PathVariable String type, HttpServletResponse response,
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
