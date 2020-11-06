package cn.fjzxdz.frame.security;

import cn.fjzxdz.frame.dao.sys.JobDao;
import cn.fjzxdz.frame.dao.sys.MenuDao;
import cn.fjzxdz.frame.dao.sys.RoleDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.exception.UserNotJobException;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.service.sys.MenuService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

/**
 * 
 * 自定义UserDetailsService 接口 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 上午9:04:42
 */
@Service
public class CustomUserService implements UserDetailsService {

	@Autowired
	UserDao userDao;
	@Autowired
	MenuDao menuDao;
	@Autowired
	RoleDao roleDao;
	@Autowired
	JobDao jobDao;
	@Autowired
	DeptService deptService;
	@Autowired
	MenuService menuService;

	@SuppressWarnings("rawtypes")
	@Transactional(rollbackOn = Exception.class)
	@Override
	public UserDetails loadUserByUsername(String username) {
//		if ("root".equals(username.trim())) {
//			String sql = "SELECT DISTINCT m.permission FROM sys_menu m WHERE m.permission IS NOT NULL";
//			List menuList = menuDao.createNativeQuery(sql.toString()).getResultList();
//	        Set<GrantedAuthority> grantedAuthorities = new HashSet<GrantedAuthority>();
//			if (ToolUtil.isNotEmpty(menuList)) {
//				for (Object obj : menuList) {
//					for(String str:obj.toString().split(",")) {
//						grantedAuthorities.add(new SimpleGrantedAuthority(str));
//					}
//				}
//				//登录成功都赋予公用查询权限，如部门树，部门人员树查询
//				grantedAuthorities.add(new SimpleGrantedAuthority("user"));
//				grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_USER"));
//			}
//			return new CustomerUserDetail("root", "10e839ebdc2f2951235e6bc89146eff5", grantedAuthorities, "超级管理员",
//					"6fd35d1a-6da8-41c2-9541-fa5d21280ba6",null,null,null);
//		}
//		List userList = userDao.createQuery("from User where loginname=?0 and enable=?1", username, 1).getResultList();
		List userList = userDao.createQuery("from User where loginname=?0", username).getResultList();
		if (null != userList && userList.size() > 0) {
			User user = (User) userList.get(0);
			if(user.getEnable()==0) {
				throw new UserNotJobException("提示：登录账户"+ username +"已禁用，请联系管理员！");
			}
			Dept dept = new Dept();
			List<Dept> resultList = deptService.getDeptByUserId(user.getUuid());
			if(resultList != null && resultList.size() > 0){
				dept = resultList.get(0);
			}
			Job job=new Job();
			List<Job> jobs=new ArrayList<Job>(user.getJobs());
			if(jobs != null && jobs.size() > 0){
				job = jobs.get(0);
			}else {
				throw new UserNotJobException("提示：登录账户"+ username +"尚未分配岗位，请联系管理员！");
			}
			// 取得用户的权限
	        Collection<GrantedAuthority> grantedAuthorities = obtionGrantedAuthorities(user.getUuid());
	        
			return new CustomerUserDetail(user.getLoginname(), user.getPassword(), grantedAuthorities, user.getName(),
					user.getUuid(),dept,user,job);
		} else {
			throw new UsernameNotFoundException("admin: " + username + " do not exist!");
		}
	}
	
	@SuppressWarnings("rawtypes")
    private Set<GrantedAuthority> obtionGrantedAuthorities(String userId) {
    	/*StringBuilder indexMenuSql = new StringBuilder("SELECT " +
                "DISTINCT  m.permission" +
                "   FROM" +
                "  sys_menu m" +
                "  INNER JOIN sys_role_menu rm ON rm.menu = m.uuid" +
                "  INNER JOIN sys_role r ON rm.role = r.uuid" +
                "   WHERE m.permission!='' and m.permission is not null and " +
                "  r.uuid IN (" +
                "    SELECT" +
                "      DISTINCT r.uuid" +
                "    FROM" +
                "      sys_role r" +
                "      LEFT JOIN sys_job_role jr ON jr.role = r.uuid" +
                "      LEFT JOIN sys_job j ON jr.job = j.uuid" +
                "    WHERE" +
                "      j.uuid IN (" +
                "        SELECT" +
                "          j.uuid" +
                "        FROM" +
                "          sys_job j inner join sys_job_user ju on j.uuid=ju.job and ju.user_id='"+userId+"' " +
                "        WHERE" +
                "          j.enable = 1" +
                "      )" +
                "  )");*/
		StringBuilder indexMenuSql = new StringBuilder("SELECT " +
                "DISTINCT  m.permission" +
                "   FROM" +
                "  sys_menu m" +
                "  LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid" +
                "  LEFT JOIN sys_role r ON rm.role = r.uuid" +
                "  LEFT JOIN sys_job_role jr ON jr.role = r.uuid " +
                "  LEFT JOIN sys_job j ON jr.job = j.uuid" +
                "  LEFT JOIN sys_job_user ju ON j.uuid = ju.job" +
                "  WHERE m.permission IS NOT NULL" +
                "  AND ju. USER_ID = '"+userId+"' " +
                "  AND j. ENABLE = 1");

		List menuList = menuDao.createNativeQuery(indexMenuSql.toString()).getResultList();
        Set<GrantedAuthority> authSet = new HashSet<GrantedAuthority>();
		if (ToolUtil.isNotEmpty(menuList)) {
			for (Object obj : menuList) {
				if(obj != null){
					for(String str:obj.toString().split(",")) {
						authSet.add(new SimpleGrantedAuthority(str));
					}
				}
			}
			//登录成功都赋予公用查询权限，如部门树，部门人员树查询
			authSet.add(new SimpleGrantedAuthority("user"));
			authSet.add(new SimpleGrantedAuthority("ROLE_USER"));
		}
        return authSet;
    }

}
