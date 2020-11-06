package com.fjzxdz.ams.module.distributeMap.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;
import com.fjzxdz.ams.module.distributeMap.entity.EnvironmeentMapDistribution;
import com.fjzxdz.ams.module.distributeMap.service.DistributeMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 
 * 分布地图
 * @Author   huangyl
 * @Version   1.0 
 * @CreateTime 2019年7月15日15:26:08
 */
@Controller
@RequestMapping("/enviromonit/distributeMap")
public class DistributeMapController extends BaseController {

	
	@Autowired
	private DistributeMapService mapService;
	@Autowired
	private IMongoAttachFile iMongoAttachFile;

	/**
	 * 分布地图所有信息
	 * @return
	 */
	@RequestMapping("/map")
	public ModelAndView show(ModelAndView modelAndView,String authority,String pid) {
	    modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
	    modelAndView.setViewName("/moudles/debriefing/mapDistribution");
	    return modelAndView;
	}

	/**
	 * 访问分布地图点位信息 附件信息路径
	 *
	 * @return
	 */
	@RequestMapping("/distributeMapInfo")
	public ModelAndView distributeMapInfo(ModelAndView modelAndView, String pid, String authority) {
		modelAndView.setViewName("/moudles/debriefing/distributeMapInfo");
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("authority", authority);
		return modelAndView;
	}

	/**
	 * 分布地图描点信息
	 * @param param 参数对象
	 * @return
	 */
	@RequestMapping(value = "")
	@ResponseBody
	public List getList(EnvironmentRectifition param){
		String userDeptName = getUserDeptName();
		param.setMark("ZZ");
		param.setCityCode(userDeptName);
		return mapService.list(param);
	}

	/**
	 * 获取轮数
	 *
	 * @return
	 */
	@RequestMapping(value = "/getRoundList")
	@ResponseBody
	public List getRoundList() {
		return mapService.getRoundList("ZZ");
	}

	/**
	 * 获取分布地图的点位信息  文件信息
	 * @param param 参数对象
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getFilePage")
	@ResponseBody
    public PageEU<Map<String, Object>> getFilePage(EnvironmeentMapDistribution param,HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        param.setMark("ZZ");
		param.setQx(getUserDeptName());
		Page<Map<String, Object>> list = mapService.getFilePage(page,param);
        return new PageEU<>(list);
    }

	/**
	 * 分布地图描点信息 分页
	 *
	 * @param param   参数对象
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getListPage")
	@ResponseBody
	public PageEU<Map<String, Object>> getListPage(EnvironmentRectifition param, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		param.setMark("ZZ");
		String userDeptName = getUserDeptName();
		param.setCityCode(userDeptName);
		Page<Map<String, Object>> list = mapService.getListPage(page, param);
		return new PageEU<>(list);
	}

	/**
	 * 保存地图分布附件信息
	 *
	 * @param mapDistribution 保存对象
	 * @param picFile   图片附件
	 * @param videoFile   视频附件
	 * @param request         请求对象
	 * @return
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(EnvironmeentMapDistribution mapDistribution, @RequestParam("picFile") MultipartFile picFile, @RequestParam("videoFile") MultipartFile videoFile, HttpServletRequest request) {
		try {
			String originFilename = picFile.getOriginalFilename();
			MongoAttachFile mongoAttachFile = null;
			if (ToolUtil.isNotEmpty(originFilename)) {
				mongoAttachFile = iMongoAttachFile.saveFile(picFile.getInputStream(),
						StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
				mapDistribution.setPicture(mongoAttachFile.getUuid());
			}
			originFilename = videoFile.getOriginalFilename();
			if (ToolUtil.isNotEmpty(originFilename)) {
				mongoAttachFile = iMongoAttachFile.saveFile(videoFile.getInputStream(),
						StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
				mapDistribution.setVideo(mongoAttachFile.getUuid());
			}
			mapDistribution.setMark("ZZ");
			mapService.save(mapDistribution);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


	/**
	 * 删除，删除对象和图片信息
	 *
	 * @param uuid
	 * @param mongoid
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public R delete(@RequestParam(value = "uuid", required = true) String uuid,
					@RequestParam(value = "pictureId", required = true) String pictureId,@RequestParam(value = "videoId", required = true) String videoId) {
		try {
			mapService.delete(uuid);
			if (!StringUtils.isEmpty(pictureId))iMongoAttachFile.removeFile(pictureId);
			if (!StringUtils.isEmpty(videoId))iMongoAttachFile.removeFile(videoId);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}


}
