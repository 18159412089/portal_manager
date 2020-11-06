package cn.fjzxdz.frame.controller;

import java.io.UnsupportedEncodingException;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.kit.HttpKit;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.FileUtil;

/**
 * @author liuyankun
 * @desc BaseController公共组件
 */
@Component
public class BaseController extends AmsController {

	@Autowired
	private SimpleDao simpleDao;
	
	protected CustomerUserDetail getUser() {
		return (CustomerUserDetail) SpringSecurityUtils.getCurrentUser();
	}

	protected String getUserPidPath() {
		CustomerUserDetail user = getUser();
		if (null==user) {
			return "";
		}
		String pidPath = user.getDept().getPidpath();
		return pidPath;
	}

	protected String getUserDeptName() {
		List<Map> list = simpleDao.getNativeQueryList("select * from (SELECT u.uuid userUuid, d.name deptName " +
                "FROM SYS_USER u INNER JOIN sys_job_user ju ON u.uuid = ju.user_id " +
                "         INNER JOIN SYS_JOB j ON ju.job = j.uuid " +
                "         INNER JOIN (SELECT d2.* FROM sys_dept d1 LEFT JOIN sys_dept d2 ON d1.uuid = d2.pid " +
                "                     WHERE d1.NAME = '环保作战指挥平台数据录入' AND d2.ENABLE = 1) d ON " +
                "    d.uuid = j.DEPT) where userUuid = '"+getUser().getUuid()+"'");
		if(ToolUtil.isNotEmpty(list)){
		    return list.get(0).get("deptname").toString();
        }
		return null;
	}

	protected List getUserDeptName2() {
		List<Map> list = simpleDao.getNativeQueryList("select * from (SELECT u.uuid userUuid, d.name deptName " +
                "FROM SYS_USER u INNER JOIN sys_job_user ju ON u.uuid = ju.user_id " +
                "         INNER JOIN SYS_JOB j ON ju.job = j.uuid " +
                "         INNER JOIN (SELECT d2.* FROM sys_dept d1 LEFT JOIN sys_dept d2 ON d1.uuid = d2.pid " +
                "                     WHERE d1.NAME = '市直属部门' AND d2.ENABLE = 1) d ON " +
                "    d.uuid = j.DEPT) where userUuid = '"+getUser().getUuid()+"'");
		if(ToolUtil.isNotEmpty(list)){
			List result = new ArrayList<>(list.size());
			for(Map map : list){
				result.add(map.get("deptname"));
			}
		    return result;
        }
		return null;
	}

	protected String getUserId() {
		return getUser().getUuid();
	}

	protected String getUserName() {
		return getUser().getUsername();
	}

	protected String getUserIp() {
		return SpringSecurityUtils.getCurrentUserIp();
	}

	protected Boolean isAuthenticated() {
		return Objects.requireNonNull(SpringSecurityUtils.getAuthentication()).isAuthenticated();
	}

	private HttpServletRequest getHttpServletRequest() {
		return HttpKit.getRequest();
	}

	private HttpServletResponse getHttpServletResponse() {
		return HttpKit.getResponse();
	}

	protected HttpSession getSession() {
		return HttpKit.getRequest().getSession();
	}

	/**
	 * 删除cookie
	 */
	protected void deleteCookieByName(String cookieName) {
		Cookie[] cookies = this.getHttpServletRequest().getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				Cookie temp = new Cookie(cookie.getName(), "");
				temp.setMaxAge(0);
				this.getHttpServletResponse().addCookie(temp);
			}
		}
	}

	/**
	 * easyui前台分页参数
	 *
	 * @param request
	 * @param <T>
	 * @return
	 */
	protected <T> Page<T> pageQuery(HttpServletRequest request) {
		return new Page<>(paramsMap(request));
	}

	/**
	 * 把service层的分页信息，封装为easyui datagrid通用的分页封装
	 */
	protected <T> PageEU<T> pageEU(Page<T> page) {
		return new PageEU<>(page);
	}

	/**
	 * 返回前台文件流
	 */
	protected ResponseEntity<byte[]> renderFile(String fileName, String filePath) {
		byte[] bytes = FileUtil.toByteArray(filePath);
		return renderFile(fileName, bytes);
	}

	/**
	 * 返回前台文件流
	 */
	private ResponseEntity<byte[]> renderFile(String fileName, byte[] fileBytes) {
		String dfileName = null;
		try {
			dfileName = new String(fileName.getBytes("gb2312"), "iso8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", dfileName);
		return new ResponseEntity<byte[]>(fileBytes, headers, HttpStatus.CREATED);
	}

	/**
	 * 获取HttpServletRequest包含信息
	 *
	 * @param request
	 * @return
	 */
	protected Map<String, String> paramsMap(HttpServletRequest request) {
		Map<String, String> map = new HashMap<>();
		Enumeration<String> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = String.valueOf(names.nextElement());
			map.put(name, request.getParameter(name));
		}
		return map;
	}
}
