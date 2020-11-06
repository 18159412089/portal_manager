package com.fjzxdz.ams.task;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.service.ScheduleLogService;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.fjzxdz.frame.utils.SendSmsUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentRectifition;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentRectifitionService;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.LogSmsDao;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.PollutionInfoDataUnUpdateDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoDataUnUpdate;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PollutionInfoService;
import com.fjzxdz.ams.util.LogSms;
import com.fjzxdz.ams.util.ValidatorUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.regex.Pattern;

@Component
@Configurable
@EnableScheduling
public class EnvironmentRectifitionTask {

	private static Logger logger = LogManager.getLogger(EnvironmentRectifitionTask.class);
	@Autowired
	private EnvironmentRectifitionService rectifitionService;
	@Autowired
	private ScheduleLogService scheduleLogService;
	@Autowired
	private PollutionInfoService pollutionInfoService;
	@Autowired
	SimpleDao simpleDao;
	@Autowired
	PollutionInfoDataUnUpdateDao pollutionInfoDataUnUpdateDao;
	@Autowired
	LogSmsDao logSmsDao;
    @Value("${isOpenScheduling}")
    private String isOpenScheduling;


	// 每4小时执行一次
	/**
	 * 上周未及时更新录入污染源数据内容短信发送
	 */
//	@Scheduled(cron = "0 0/1 * * * ?")
	// 每周一9点分钟触发,可以根據需要修改
	@Scheduled(cron = "0 0 9 ? * MON")
	@Transactional
	public void sendUnUpdMessage() {
        if ("true".equals(isOpenScheduling)) {
            System.out.println("短信发送上一周未更新污染源大地图数据");
            String sql = "SELECT * FROM POLLUTION_INFO_DATA_UNUPDATE WHERE UPDATE_TIME IS NULL";
            List<Map> unUpdUserList = simpleDao.getNativeQueryList(sql);
            String phone;
			String msg;
			List<LogSms> logSmsList = new ArrayList<>();
            for (Map map : unUpdUserList) {
                phone = (String) map.get("lxrLxfs");
                for (String str : phone.replaceAll("，", ",").split(",")) {
                    if (ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
						msg = "您上周未及时更新录入污染源数据内容，请尽快更新！" + DateUtil.getCurYearMonthDay();
						SendSmsUtil.sendSms(str, msg);
						//保存短信日志表
						LogSms logSms = new LogSms();
						logSms.setMark("短信发送上一周未更新污染源大地图数据");
						logSms.setMsg(msg);
						logSms.setPhone(str);
						logSmsList.add(logSms);
                    }
                }
            }
			logSmsDao.saveBatch(logSmsList);
        }
    }
	//0/5 * * * * ?
	//0 0 9/4 * * ? *
	//0 0/2 * * * ?
	//0 15 08 ? * *

	@Scheduled(cron = "0 15 08 ? * *")
	// "0 15 10 ? * *" 每天上午10:15触发,可以根據需要修改
	public void sendMessage() {
		// logger.info("开始发送环境督察任务提醒消息"+ DateUtil.formatDateTime(new Date()));
		// 获取列表
		List<EnvironmentRectifition> list = rectifitionService.allWornList();
		if (list.size() > 0) {
			int days = Integer.parseInt(list.get(0).getWornTime());// 预警时间
			int times = 5;// 发送次数（默认5次，预警时间小于5天的，几天就几次，大于5天的默认为5次）
			if (days < 5) {
				times = days;
			}
			long time = (int) times;
			for (EnvironmentRectifition environmentRectifition : list) {
				String dutyPersonPhone = environmentRectifition.getDutyPersonPhone();// 责任人
				String projectName = environmentRectifition.getProjectName();// 任务名称
				if(projectName == null || projectName == "null"){
					projectName = " ";
				}
				if (dutyPersonPhone != null && !"".equals(dutyPersonPhone)) {
					Date curTime = new Date();// 系统当前时间
					Date timeLimit = environmentRectifition.getTimelimit();// 整改时限
					long diff = timeLimit.getTime() - curTime.getTime();// 差值是微秒级别
					long daysBetween = diff / (60 * 60 * 24 * 1000);
					if (0 < daysBetween && daysBetween < time) {// 发预警短信
						SendSmsUtil.sendSms(dutyPersonPhone, projectName + " 整改时间将于" + DateUtil.formatDateTime(timeLimit)
								+ "到期，距离您提交整改还有" + daysBetween + "天,请及时整改。");
						System.err.println("开始发送环境督察任务预警消息" + DateUtil.formatDateTime(new Date()));
					} else if (diff < 0) {// 发延期短信
						SendSmsUtil.sendSms(dutyPersonPhone,
								projectName + "整改时间将于" + DateUtil.formatDateTime(timeLimit) + "到期，您已延期。");
						System.err.println("开始发送环境督察任务延期消息" + DateUtil.formatDateTime(new Date()));
					}
				}
			}
		}
	}

	/**
	 * 检查污染源大数据上一周是否有修改动作
	 * @return
	 */
//	@Scheduled(cron = "0 0/1 * * * ?")
	@Scheduled(cron = "0 0 6 ? * MON")
	//@Scheduled(cron = "0 */1 * * * ?")
	// 每天10分钟触发,可以根據需要修改
	@Transactional

	public void checkDataUpload() {
        if("true".equals(isOpenScheduling)) {
            //查找所有人员的维护记录  如果uderid和userdate为空 则上周未维护过。
            List<Map> list = pollutionInfoService.checkLastWeekAlreadyUpdateInfo();
            if (ToolUtil.isNotEmpty(list)) {
                alredyUpdate(list);
            }
            /*//未更新
            String sql = "select distinct CREATE_USER\n" +
                    "from POLLUTION_INFO_DATA where CREATE_USER is not null ";
            List<PollutionInfoData> queryList = simpleDao.getNativeQueryList(sql, PollutionInfoData.class);
            if (ToolUtil.isNotEmpty(queryList)) {
                unUpdateList(list, sql, queryList);
            }*/
        }
	}

	/**
	 * 未更新
	 * @param list
	 * @param sql
	 * @param queryList
	 */
	private void unUpdateList(List<Map> list, String sql, List<PollutionInfoData> queryList) {
		String userSql = null;
		List<PollutionInfoDataUnUpdate> unUpdateList =  new ArrayList<>();
		for (PollutionInfoData pollutionInfoData : queryList) {
			for (int i = 0; i < list.size(); i++) {
				Map map = list.get(i);
				if (!pollutionInfoData.getCreateUser().equals(MapUtils.getString(map, "uuid", ""))) {
					userSql = "SELECT * FROM SYS_USER WHERE UUID = " + SqlUtil.toSqlStr(pollutionInfoData.getCreateUser());
					List<Map> userList = simpleDao.getNativeQueryList(userSql);
					Map userMap = userList.get(0);
					List<Map> deptName = getDeptName(userMap);
					Map deptMap = deptName.get(0);
					PollutionInfoDataUnUpdate unUpdate = new PollutionInfoDataUnUpdate();
					unUpdate.setLxrLxfs(MapUtils.getString(userMap, "phone", ""));
					unUpdate.setEntryDepartment(MapUtils.getString(deptMap, "name", ""));
					unUpdate.setUuidUn(MapUtils.getString(userMap, "uuid", ""));
					unUpdate.setUpdateTime(null);
					unUpdateList.add(unUpdate);
				}
			}

		}
		pollutionInfoDataUnUpdateDao.saveBatch(unUpdateList);
	}


	/**
	 * 已更新
	 * @param list
	 */
	private void alredyUpdate(List<Map> list) {
		List<PollutionInfoDataUnUpdate> alreadyUpdList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			PollutionInfoDataUnUpdate unUpdate = new PollutionInfoDataUnUpdate();

//			List<Map> queryList = getDeptName(map);
//			Map userMap = queryList.get(0);
			unUpdate.setLxrLxfs(MapUtils.getString(map, "phone", ""));
			unUpdate.setEntryDepartment(MapUtils.getString(map, "deptname", ""));
			unUpdate.setUuidUn(MapUtils.getString(map, "uuid", ""));
			unUpdate.setUpdateTime((Date) map.get("updatetime"));
			alreadyUpdList.add(unUpdate);
		}
		pollutionInfoDataUnUpdateDao.saveBatch(alreadyUpdList);
	}

	/**
	 * 获取部门名称
	 * @param map
	 * @return
	 */
	private List<Map> getDeptName(Map map) {
		String sql;
		sql = "SELECT user0.uuid,user0.PHONE, dept0.name\n" +
				"FROM sys_user user0\n" +
				"         left join sys_job_user user1 on user0.uuid = user1.user_id\n" +
				"         left join sys_job job0 on job0.UUID = user1.JOB\n" +
				"         left join SYS_DEPT dept0 on dept0.uuid = job0.dept\n" +
				"         LEFT JOIN sys_dept dept1 ON dept0.pid = dept1.uuid\n" +
				"WHERE dept1.NAME = '环保作战指挥平台数据录入'\n" +
				"  AND dept0.ENABLE = 1 and user0.uuid =" + SqlUtil.toSqlStr(MapUtils.getString(map, "uuid", ""));
		return simpleDao.getNativeQueryList(sql);
	}
}