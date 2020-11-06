package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

/**
 * 
 * 污染源实时动态数据
 * @Author   hyl
 * @Version   1.0 
 * @CreateTime 2019年11月8日16:30:38
 */
@Controller
@RequestMapping("/env/pollution2/realtime")
@Secured({ "ROLE_USER" })
public class RealTimeController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView, String pid) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/pollution/realtime");
		return modelAndView;
	}

	/**
	 * 县级实时更新
	 * @return
	 */
	@RequestMapping("/getRealTimeUpdateByQX")
	@ResponseBody
	public List<Map> getRealTimeUpdateByQX() {
		StringBuilder sql = new StringBuilder();
        sql.append(" select rownum, t.* from (select QX, count(1) count, to_char(UPDATE_DATE, 'yyyy-mm-dd') time ");
        sql.append(" from POLLUTION_INFO_DATA ");
        sql.append(" where (qx, to_char(UPDATE_DATE, 'yyyy-mm-dd')) in ");
        sql.append("       (select qx, to_char(max(UPDATE_DATE), 'yyyy-mm-dd') time from POLLUTION_INFO_DATA group by qx) ");
        sql.append(" group by QX, to_char(UPDATE_DATE, 'yyyy-mm-dd') order by time desc) t");
		List<Map> list = simpleDao.getNativeQueryList(sql.toString());
		return list;
	}

	/**
	 * 市直实时更新
	 * @return
	 */
	@RequestMapping("/getRealTimeUpdateByDept")
	@ResponseBody
	public List<Map> getRealTimeUpdateByDept() {
		StringBuilder sql = new StringBuilder();
		/*sql.append(" select rownum, t.* from (select deptName, nvl(count,0) count, nvl(time,'-') time");
		sql.append(" from (select CREATE_USER, count(1) count, to_char(UPDATE_DATE, 'yyyy-mm-dd') time ");
		sql.append("       from POLLUTION_INFO_DATA ");
		sql.append("       where (CREATE_USER, to_char(UPDATE_DATE, 'yyyy-mm-dd')) in ");
		sql.append("             (select CREATE_USER, to_char(max(UPDATE_DATE), 'yyyy-mm-dd') time ");
		sql.append("              from POLLUTION_INFO_DATA ");
		sql.append("              group by CREATE_USER) ");
		sql.append("       group by CREATE_USER, to_char(UPDATE_DATE, 'yyyy-mm-dd')) a ");
		sql.append("          right join (SELECT u.uuid, d.name AS deptName ");
		sql.append("                      FROM SYS_USER u ");
		sql.append("                               INNER JOIN sys_job_user ju ON u.uuid = ju.user_id ");
		sql.append("                               INNER JOIN SYS_JOB j ON ju.job = j.uuid ");
		sql.append("                               INNER JOIN ( ");
		sql.append("                          SELECT d2.* ");
		sql.append("                          FROM sys_dept d1 ");
		sql.append("                                   LEFT JOIN sys_dept d2 ON d1.uuid = d2.pid ");
		sql.append("                          WHERE d1.NAME = '市直属部门' ");
		sql.append("                            AND d2.ENABLE = 1 ");
		sql.append("                      ) d ON d.uuid = j.dept) b on a.CREATE_USER = b.UUID) t ");*/
		sql.append(" select rownum, t.* ");
		sql.append(" from (select dw, count(1) count, to_char(UPDATE_DATE, 'yyyy-mm-dd') time ");
		sql.append("       from CITY_DIRECT_POLLUTION_DATA ");
		sql.append("       where (dw, to_char(UPDATE_DATE, 'yyyy-mm-dd')) in ");
		sql.append("             (select dw, to_char(max(UPDATE_DATE), 'yyyy-mm-dd') time ");
		sql.append("              from CITY_DIRECT_POLLUTION_DATA ");
		sql.append("              group by dw) ");
		sql.append(" AND JD IS NOT NULL AND WD IS NOT NULL AND (TRIM(JD) LIKE  '117%' OR TRIM(JD) LIKE  '118.0%' OR TRIM(JD) LIKE '118.1%') AND WRYLX IS NOT NULL ");
		sql.append("       group by dw, to_char(UPDATE_DATE, 'yyyy-mm-dd') ");
		sql.append("       order by time desc) t ");
		List<Map> list = simpleDao.getNativeQueryList(sql.toString());
		return list;
	}

	/**
	 * 污染源种类统计
	 */
	@RequestMapping(value = "/getwryzl")
	@ResponseBody
	public List<Map> getwryzl() {
		StringBuilder sql = new StringBuilder();
		sql.append("select lx||'污染源' lx,zl,count from (select WRYLX lx,WRYZL zl,count(1) count from POLLUTION_INFO_DATA ");
		sql.append("where jd is not null and wd is not null and (jd like '%117.%' or jd like '%118.0%' or jd like '%118.1%')");
		sql.append("and wrylx is not null group by WRYLX,WRYZL)");
		List<Map> list = simpleDao.getNativeQueryList(sql.toString());
		return list;
	}

}
