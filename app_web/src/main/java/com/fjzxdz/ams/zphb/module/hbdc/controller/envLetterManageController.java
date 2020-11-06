package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.water.entity.FileAttachment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 
 * 信访件ontroller实现类
 * @author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年4月22日 下午4:36:38
 */
@Controller
@RequestMapping("/zphb/environment/letterManage")
@Secured({ "ROLE_USER" })
public class envLetterManageController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;
	@Secured({ "ROLE_USER" })
	@RequestMapping("")
	public ModelAndView index(ModelAndView modelAndView,String authority,String pid) {
		modelAndView.addObject("authority", authority);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/zphb/moudles/hbdc/envLetterManage");
		return modelAndView;
	}

	/**
	 * 获取附件列表
	 * @param fileAttachment 参数集合
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getFileAttachPage")
	@ResponseBody
	public PageEU<Map<String, Object>> getFileAttachPage(FileAttachment fileAttachment, HttpServletRequest request, HttpServletResponse response) {
		Page<Map<String, Object>> page = pageQuery(request);
		StringBuilder sb = new StringBuilder(" SELECT A.*,B.NAME FROM FILE_ATTACHMENT A LEFT JOIN COMMON_RELATION_TABLE B ON A.PKID = B.UUID where 1=1 ");
		if (StringUtils.isNotEmpty(fileAttachment.getDescribe())) {
			sb.append(" and a.DESCRIBE like ").append(SqlUtil.toSqlStr_like(fileAttachment.getDescribe()));
		}if (StringUtils.isNotEmpty(fileAttachment.getSource())) {
			sb.append(" and a.source = ").append(SqlUtil.toSqlStr(fileAttachment.getSource()));
		}
		sb.append(" ORDER BY  a.UPDATE_DATE DESC NULLS LAST ");
		Page<Map<String, Object>> fileAttachPage = simpleDao.listNativeByPage(sb.toString(), page);
		return new PageEU<>(fileAttachPage);
	}
}
