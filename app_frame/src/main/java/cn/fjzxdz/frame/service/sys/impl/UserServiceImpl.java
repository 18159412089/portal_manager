package cn.fjzxdz.frame.service.sys.impl;

import cn.fjzxdz.frame.common.Constants;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.JobDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.*;
import cn.fjzxdz.frame.license.utils.IdGenerator;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.sys.UserService;
import cn.fjzxdz.frame.service.sysdbsyn.UserSynDb;
import cn.fjzxdz.frame.toolbox.util.MD5Util;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.fjzxdz.frame.toolbox.util.UUIDUtil;
import cn.fjzxdz.frame.utils.JedisUtils;
import cn.fjzxdz.frame.utils.SynDBSimpleCurdUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.*;

import static cn.fjzxdz.frame.service.sysdbsyn.UserSynDb.insertPortalDeptInfoToSysJobTable;
import static cn.fjzxdz.frame.service.sysdbsyn.UserSynDb.setSqlStr;

@Service
@Transactional(rollbackFor=Exception.class)
public class UserServiceImpl implements UserService {
	private static Logger logger = LogManager.getLogger(UserServiceImpl.class);

	@Autowired
	private UserDao userDao;
	@Autowired
	private JobDao jobDao;
	@Autowired
	private SimpleDao simpleDao;

	@Override
	@CacheEvict(value = { "deptUserTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
	public R save(User user) {
		List<User> users = userDao.selectListBy("loginname", user.getLoginname());
		if (StringUtils.isNotEmpty(user.getUuid())) {
			User userTemp = getById(user.getUuid());
			if (!user.getLoginname().equals(userTemp.getLoginname())) {
				if (users.size() == 1) {
					return R.error("该登录名已注册，请换一个账号注册！");
				}
			}
			userTemp.setLogintype(LoginType.SYSTEM);
			userTemp.setLoginname(user.getLoginname());
			userTemp.setName(user.getName());
			userTemp.setSex(user.getSex());
			userTemp.setIdcard(user.getIdcard());
			userTemp.setEmail(user.getEmail());
			userTemp.setPhone(user.getPhone());
			userDao.update(userTemp);
		} else {
			if (users.size() == 1) {
				return R.error("该登录名已注册，请换一个账号注册！");
			}
			user.setPassword(MD5Util.encode(Constants.INIT_PWD));
			user.setUuid(null);
			user.setEnable(1);
			userDao.save(user);
		}
		return R.ok();
	}

	//保存用户表和用户扩展表信息
	@Override
	@CacheEvict(value = { "deptUserTree", "userMenuTree" }, allEntries = true)
	public R saveUserRelateInfo(UserReLateInfo userReLateInfo) {
		UserOther user = userReLateInfo.getUser();
		UserInfo userInfo = userReLateInfo.getUserInfo();
		R allRe = null;
		//需要保存到Oracle的‘部门’ID
		String portalDeptId = userReLateInfo.getPortalDepartmentId();

		try {
			if(StringUtils.isEmpty(user.getUuid())){
				//创建用户开始
				JobOther job = userReLateInfo.getJob();

				Map<String, Object> paramMap = new HashMap<String, Object>();
				//判断登录账号是否存在
				paramMap.clear();
                paramMap.put("loginname", setSqlStr(user.getLoginname()));
				cn.hutool.json.JSONArray userReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.user_select_list", paramMap);
				if (userReArray.size()>0) {
					return R.error("该登录名已注册，请换一个账号注册！");
				}
				//判断岗位编号是否存在
				paramMap.clear();
                paramMap.put("seq", setSqlStr(job.getSeq()));
				cn.hutool.json.JSONArray jobReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.job_select_list", paramMap);
				if(jobReArray.size()>0) {
					return R.error("该岗位编号已经存在，请换一个岗位编号注册！");
				}

				paramMap.clear();
				paramMap.put("where", "uuid="+setSqlStr(userInfo.getDepartmentId()));
				cn.hutool.json.JSONArray gridReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.dept_select_list", paramMap);
				DeptOther dept = gridReArray.get(0, DeptOther.class);

				User portalUser = new User();
				portalUser.setPassword(MD5Util.encode(Constants.INIT_PWD));
				portalUser.setUuid(null);
				portalUser.setPhone(userInfo.getMobilephone());
				portalUser.setSex(user.getSex());
				portalUser.setEmail(user.getEmail());
				portalUser.setIdcard(user.getIdcard());
				portalUser.setLogintype(LoginType.SYSTEM);
				portalUser.setLoginname(user.getLoginname());
				portalUser.setName(user.getName());
				portalUser.setEnable(1);
				userDao.save(portalUser);

				Job portalJob = new Job();
				portalJob.setUuid(null);
				portalJob.setName(job.getName());
				portalJob.setSeq(job.getSeq());
				Dept portalDept = new Dept();
				portalDept.setUuid(portalDeptId);
				portalJob.setDept(portalDept);
				portalJob.setRemark(job.getName());
				portalJob.setEnable(1);
				jobDao.save(portalJob);

				simpleDao.createNativeQuery("INSERT INTO sys_job_user (job, user_id) VALUES ('"+portalJob.getUuid()+"','"+portalUser.getUuid()+"')").executeUpdate();

				String[] roleStrArr = userReLateInfo.getRoleUuids().split(",");
				for (int i=0;i<roleStrArr.length;i++){
					simpleDao.createNativeQuery("INSERT INTO SYS_JOB_ROLE (JOB,ROLE) VALUES ('"+portalJob.getUuid()+"','"+roleStrArr[i]+"')").executeUpdate();
				}

				String userSysUuid = portalUser.getUuid();
				String userOldSysUuid = IdGenerator.getNewId();
				user.setUuid(userSysUuid);
				user.setPassword(MD5Util.encode(Constants.INIT_PWD));
				user.setPhone(userInfo.getMobilephone());
				user.setLogintype(LoginType.SYSTEM);
				user.setEnable(1);
				user.setOldSysUuid(userOldSysUuid);

				String userInfoSysUuid = UUIDUtil.randomUUID();
				userInfo.setUuid(userInfoSysUuid);
				userInfo.setIdCard(user.getIdcard());
				userInfo.setEmpId(userInfo.getEmpId()==null ? "" : userInfo.getEmpId());
				userInfo.setSex(user.getSex().toString());
				userInfo.setEmail(user.getEmail());
				userInfo.setUserId(userSysUuid);
				userInfo.setAnychatUserId("1");

				//获取单位danweiId
				String danweiId = "";
				String oldSysDanweiId = "";
				paramMap.clear();
				paramMap.put("where", "uuid="+setSqlStr(dept.getDepartmentType()));
				cn.hutool.json.JSONArray dictReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.dict_select_list", paramMap);
				DictOther dict = dictReArray.get(0, DictOther.class);
				DeptOther depto = dept;
				if(dict!=null){
					String deptType = dict.getType();
					if("BUREAU".equals(deptType) || "SUB_BUREAU".equals(deptType)) {
						danweiId = dept.getUuid();
						oldSysDanweiId = dept.getOldSysUuid();
					}else{
						while (!"SUB_BUREAU".equals(deptType)&&!"BUREAU".equals(deptType)){
							DeptOther tempDept = dept.getParent();
							paramMap.clear();
							paramMap.put("where", "uuid="+setSqlStr(tempDept.getDepartmentType()));
							dictReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.dict_select_list", paramMap);
							DictOther tempDict = dictReArray.get(0, DictOther.class);
							deptType = tempDict.getType();
							oldSysDanweiId = tempDept.getOldSysUuid();
							danweiId = tempDept.getUuid();
							dept = dept.getParent();
						}
					}
				}
				userInfo.setDanweiId(danweiId);
				userInfo.setOldSysDanweiId(oldSysDanweiId);
				userInfo.setOldSysDepartmentId(dept.getOldSysUuid());

				//保存岗位表、岗位角色表、岗位用户表
				job.setUuid(portalJob.getUuid());
				job.setOldSysUuid(IdGenerator.getNewId());
				job.setEnable(1);
				job.setDept(depto);
				Set<UserOther> userSets = new HashSet<UserOther>();
				userSets.add(user);
				job.setUsers(userSets);
				job.setRemark(job.getName());

				StringBuilder valuesSql = new StringBuilder();
				for (int i = 0; i < roleStrArr.length; i++) {
					if(i==roleStrArr.length-1){
						valuesSql.append("'"+roleStrArr[i] + "'");
					}else{
						valuesSql.append("'"+roleStrArr[i] + "'").append(",");
					}
				}
				paramMap.clear();
				paramMap.put("where", "uuid in ("+valuesSql+")");
				cn.hutool.json.JSONArray roleReArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.role_select_list_by_id", paramMap);
				List<RoleOther> roleList = roleReArray.toList(RoleOther.class);
				Set<RoleOther> roleSets = new HashSet<RoleOther>(roleList);
				job.setRoles(roleSets);

				//跨库插入用户数据
				allRe = UserSynDb.saveUserRelateInfo(user, userInfo, job);

				if(allRe == null || "E".equals(allRe.get("type"))){
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					return allRe;
				}

				//这边需要插入sql server中的SYS_JOB表数据，数据来源于Oracle的portal同名表，主要作用是为了好统计网格员数量因为需要过滤有‘部门’数据的网格员
				allRe = insertPortalDeptInfoToSysJobTable(job, portalDeptId);
				if(allRe == null || "E".equals(allRe.get("type"))){
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					return allRe;
				}
			}else{
				//更新用户开始
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return R.error("服务器出了点小问题！！");
		}

		//清除旧框架缓存
		JedisUtils.batchDel("EpaUserAllNum*");
		return R.ok();
	}

	@Override
	public User getById(String uuid) {
		return userDao.getById(uuid);
	}

	@Override
	public Page<User> listByPage(UserParam param, Page<User> page) {

		Page<User> userPage = userDao.listByPage(param, page);
		try {
			List<User> users = userPage.getResult();
			if (ToolUtil.isNotEmpty(users)) {
				for (User user : users) {
					Set<Job> jobs = user.getJobs();
					Set<Dept> depts = new HashSet<>();

					StringBuilder deptName = new StringBuilder();

					if (ToolUtil.isNotEmpty(jobs)) {
						for (Job job : jobs) {
							depts.add(job.getDept());
						}
					}

					for (Dept dept : depts) {
						deptName.append(dept.getName()).append(",");
					}

					user.setDeptName(ToolUtil.removeSuffix(deptName.toString(), ","));
				}
			}
		}catch (Exception e){
			e.printStackTrace();
		}

		return userPage;
	}

	@Override
	@CacheEvict(value = { "deptUserTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
	public R assignJob(String uuid, String[] jobIds) {
		// 先清空用户下的岗位
		simpleDao.createNativeQuery("delete from sys_job_user where user_id='" + uuid + "'").executeUpdate();
		for (int i = 0; i < jobIds.length; i++) {
			simpleDao.createNativeQuery(
					"INSERT INTO sys_job_user (job, user_id) VALUES " + "('" + jobIds[i] + "','" + uuid + "')").executeUpdate();
		}
		return R.ok();
	}

	@Override
	@CacheEvict(value = { "deptUserTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
	public R editUserStatus(String uuid, Integer enable) {
		User user = userDao.getById(uuid);
		if (null != user) {
			if (1 == enable && 0 == user.getEnable()) {
				simpleDao.createNativeQuery("delete from sys_job_user where user_id='" + uuid + "'").executeUpdate();
			}
			user.setEnable(enable);
			userDao.save(user);
		} else {
			return R.error("数据库中没有该记录");
		}
		return R.ok();
	}

	@Override
	public R editPwd(String uuid, String newPwd) {
		User user = userDao.getById(uuid);
		user.setPassword(MD5Util.encode(newPwd));
		userDao.save(user);
		return R.ok();
	}

	@Override
	public R resetPwd(String uuid) {
		User user = userDao.getById(uuid);
		user.setPassword(MD5Util.encode("123456"));
		logger.info("==================>重置密码：用户名为" + user.getName());
		userDao.save(user);
		return R.ok();
	}

	@Override
	public List<User> findList(UserParam param) {
		String sql = "SELECT a.UUID,a.name FROM \"SYS_USER\" a WHERE a.ENABLE='1' ";
		List<User> list = simpleDao.createNativeQuery(sql).getResultList();
		return list;
	}

}
