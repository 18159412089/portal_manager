package com.fjzxdz.ams.module.enviromonit.air.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.text.StrBuilder;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.dao.FileAttachmentDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirConstructionSite;
import com.fjzxdz.ams.module.enviromonit.air.param.AirConstructionSiteParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirConstructionSiteService;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 
 * 大气环境 大气环境服务 工地显示。 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午3:40:46
 */
@Controller
@RequestMapping("/enviromonit/airConstructionSite")
@Secured({ "ROLE_USER" })
public class AirConstructionSiteController extends BaseController {

	@Autowired
	private AirConstructionSiteService airConstructionSiteService;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 
	 * @Title:  getConstructionInfo
	 * @Description:    获取工地信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午3:50:27
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午3:50:27    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getConstructionInfo")
	@ResponseBody
	public String getConstructionInfo() {

		JSONArray jsonArray = new JSONArray();
		List<AirConstructionSite> list = airConstructionSiteService.getConstructionInfo(getUserDeptName());
		for (AirConstructionSite airConstructionSite : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", airConstructionSite.getPkid());
			jsonObject.put("name", airConstructionSite.getName());
			jsonObject.put("builtValue", airConstructionSite.getBuiltValue());
			jsonObject.put("responOrganization", airConstructionSite.getResponOrganization());
			jsonObject.put("video", airConstructionSite.getVideo());
			jsonObject.put("picture", airConstructionSite.getPicture());
			if (null != airConstructionSite.getLongitude() && null != airConstructionSite.getLatitude()) {
				jsonObject.put("longitude", Double.valueOf(String.valueOf(airConstructionSite.getLongitude())));
				jsonObject.put("latitude", Double.valueOf(String.valueOf(airConstructionSite.getLatitude())));
				jsonArray.put(jsonObject);
			}
		}

		return jsonArray.toString();
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<AirConstructionSite> list(AirConstructionSiteParam param, HttpServletRequest request) {
		Page<AirConstructionSite> page = pageQuery(request);
		param.setArea(getUserDeptName());
		Page<AirConstructionSite> airConstructionSite = airConstructionSiteService.listByPage(param, page);
		return new PageEU<>(airConstructionSite);
	}

	/**
	 * 获取附件列表
	 * @param name 公司名称
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getFileAttachPage")
	@ResponseBody
	public PageEU<Map<String, Object>> getFileAttachPage(String name, HttpServletRequest request, HttpServletResponse response) {
		Page<Map<String, Object>> page = pageQuery(request);
		Map paramMap = new HashMap<>();
		paramMap.put("name", name);
		paramMap.put("source", "site");
		paramMap.put("deptName", getUserDeptName());
		Page<Map<String, Object>> fileAttachPage = airConstructionSiteService.getFileAttachPage(page,paramMap);
		return new PageEU<>(fileAttachPage);
	}

	/**
	 * 访问 附件信息路径
	 *
	 * @return
	 */
	@RequestMapping("/fileAttachment")
	public ModelAndView distributeMapInfo(ModelAndView modelAndView, String pid,String name, String authority) {
		modelAndView.setViewName("/moudles/enviromonit/air/fileAttachment");
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("name", name);
		return modelAndView;
	}

	/**
	 * 访问 企业信息维护路径
	 *
	 * @return
	 */
	@RequestMapping("/companyInfoSet")
	public ModelAndView companyInfoSet(ModelAndView modelAndView, String pid,String name, String authority) {
		modelAndView.setViewName("/moudles/enviromonit/air/companyInfoSet");
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("name", name);
		return modelAndView;
	}




	@Autowired
	private IMongoAttachFile iMongoAttachFile;

	/**
	 * 保存附件信息
	 * @param fileAttachment
	 * @param picFile
	 * @param videoFile
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(FileAttachment fileAttachment, @RequestParam("picFile") MultipartFile picFile, @RequestParam("videoFile") MultipartFile videoFile, HttpServletRequest request) {
		try {
			String originFilename = null;
			MongoAttachFile mongoAttachFile = null;
			if (!ObjectUtils.isEmpty(picFile)) {
				originFilename = picFile.getOriginalFilename();
				if (ToolUtil.isNotEmpty(originFilename)) {
					mongoAttachFile = iMongoAttachFile.saveFile(picFile.getInputStream(),
							StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
					fileAttachment.setPicture(mongoAttachFile.getUuid());
				}
			}
			if (!ObjectUtils.isEmpty(videoFile)) {
				originFilename = videoFile.getOriginalFilename();
				if (ToolUtil.isNotEmpty(originFilename)) {
					mongoAttachFile = iMongoAttachFile.saveFile(videoFile.getInputStream(),
							StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
					fileAttachment.setVideo(mongoAttachFile.getUuid());
				}
			}
			airConstructionSiteService.save(fileAttachment);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	/**
	 * 保存附件信息 【批量附件上传】
	 * @param picFile
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/saveAttachBatch")
	@ResponseBody
	public R saveAttachBatch(@RequestParam("picFiles") LinkedList picFile, HttpServletRequest request,StandardMultipartHttpServletRequest servletRequest) {
		try {
			String fileName = "";
			String originFilename = null;
			MongoAttachFile mongoAttachFile = null;
			for (int i = 0; i < picFile.size(); i++) {
				if (!ObjectUtils.isEmpty(picFile.get(i))) {
					MultipartFile multipartFile = 	(MultipartFile)picFile.get(i);
					originFilename = multipartFile.getOriginalFilename();
					if (ToolUtil.isNotEmpty(originFilename)) {
						FileAttachment fileAttachmentNew = new FileAttachment();
						mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
								StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
						fileAttachmentNew.setPicture(mongoAttachFile.getUuid());
						fileName = originFilename.substring(0, originFilename.indexOf("号") + 1);
						fileAttachmentNew.setSource("letterManage");
						fileAttachmentNew.setPicture(mongoAttachFile.getUuid());
						fileAttachmentNew.setPicname(originFilename);
						fileAttachmentNew.setDescribe(fileName);
						airConstructionSiteService.save(fileAttachmentNew);
					}
				}

			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 保存修改工地信息
	 * @param airConstructionSite
	 */
	@RequestMapping(value = "/saveCompanyInfo")
	@ResponseBody
	public R saveCompanyInfo(AirConstructionSite airConstructionSite) {
		try {
			airConstructionSiteService.saveCompanyInfo(airConstructionSite);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


	/**
	 * 删除，删除对象和图片信息
	 * @param uuid
	 * @param pictureId
	 * @param videoId
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public R delete(@RequestParam(value = "uuid", required = true) String uuid,
					@RequestParam(value = "pictureId", required = true) String pictureId,@RequestParam(value = "videoId", required = true) String videoId) {
		try {
			if (StringUtils.isEmpty(uuid)){
				return R.ok("附件信息记录已经删除！");
			}else{
				airConstructionSiteService.delete(uuid);
			}
			if (!StringUtils.isEmpty(pictureId)){
				iMongoAttachFile.removeFile(pictureId);
			}
			if (!StringUtils.isEmpty(videoId)){
				iMongoAttachFile.removeFile(videoId);
			}

		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	@Autowired
	private FileAttachmentDao fileAttachmentDao;

	/**
	 * 删除视频和图片信息  不删除对象
	 *
	 * @param uuid
	 * @param pictureId
	 * @param videoId
	 * @return
	 */
	@RequestMapping(value = "/deleteByMap")
	@ResponseBody
	@Transactional
	public R deleteByMap(@RequestParam(value = "uuid", required = true) String uuid,
					@RequestParam(value = "pictureId", required = true) String pictureId, @RequestParam(value = "videoId", required = true) String videoId) {
		try {
			if (StringUtils.isEmpty(uuid)){
				return R.ok("附件信息记录已经删除！");
			}
			FileAttachment fileAttachment = fileAttachmentDao.getById(uuid);
			if (!StringUtils.isEmpty(pictureId)) {
				iMongoAttachFile.removeFile(pictureId);
				fileAttachment.setPicname(null);
				fileAttachment.setPicture(null);
			}
			if (!StringUtils.isEmpty(videoId)) {
				iMongoAttachFile.removeFile(videoId);
				fileAttachment.setVedioname(null);
				fileAttachment.setVideo(null);
			}
			fileAttachmentDao.save(fileAttachment);

		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


	/**
	 * 删除企业信息
	 * @param pkid
	 * @return
	 */
	@RequestMapping(value = "/deleteCompanyInfo")
	@ResponseBody
	public R deleteCompanyInfo(@RequestParam(value = "pkid", required = true) String pkid) {
		try {
			if (StringUtils.isEmpty(pkid)) {
				return R.ok("企业信息记录已经删除！");
			} else {
				airConstructionSiteService.deleteCompanyInfo(pkid);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 查找是否有项目占用此附件
	 *
	 * @param pkid
	 * @return
	 */
	@RequestMapping(value = "/checkPkidExist")
	@ResponseBody
	public R checkPkidExist(@RequestParam(value = "pkid", required = true) String pkid,String uuid) {
		try {
			if (!StringUtils.isEmpty(pkid)) {
				StringBuilder sql = new StringBuilder(" SELECT 1 FROM FILE_ATTACHMENT WHERE SOURCE ='letterManage' ");
				if (!StringUtils.isEmpty(uuid)) {
					sql.append("  and uuid<> ").append(SqlUtil.toSqlStr(uuid));
				}
				sql.append(" AND PKID=  ").append(SqlUtil.toSqlStr(pkid));
				Long countSqlResult = simpleDao.getCountSqlResult(sql.toString());
				if (countSqlResult > 0) {
					return R.ok("此项目已存在附件！");
				}
				return R.ok("success");
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 查找是否有项目占用此附件
	 *
	 * @param pkid
	 * @return
	 */
	@RequestMapping(value = "/changeFile")
	@ResponseBody
	@Transactional
	public R changeFile(@RequestParam(value = "pkid", required = true) String pkid) {
		try {
			if (!StringUtils.isEmpty(pkid)) {
				StrBuilder strBuilder = new StrBuilder(" UPDATE FILE_ATTACHMENT SET PKID = '' WHERE SOURCE ='letterManage' AND PKID= ").append(SqlUtil.toSqlStr(pkid));
				simpleDao.createNativeQuery(strBuilder.toString()).executeUpdate();
				return R.ok("success");
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}



}
