package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.debriefing.dao.EnvCancellationAccountDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvCancellationAccount;
import com.fjzxdz.ams.module.debriefing.param.EnvCancellationAccountParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvCancellationAccountService;
import org.apache.commons.collections.MapUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 销号概况,销号汇总表
 *
 * @Author
 * @Version 1.0
 * @CreateTime 2019年5月10日 上午10:36:24
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpEnvCancellationAccountServiceImpl implements ZpEnvCancellationAccountService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(ZpEnvCancellationAccountServiceImpl.class);

    @Autowired
    private EnvCancellationAccountDao envCancellationAccountDao;

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 销号汇总表 - 分页列表   </p>
     *
     * @param param
     * @param page
     * @return
     * @see ZpEnvCancellationAccountService#listByPage(EnvCancellationAccountParam, Page)
     */
    @Override
    public Page<EnvCancellationAccount> listByPage(EnvCancellationAccountParam param,
                                                   Page<EnvCancellationAccount> page) {
        //return envCancellationAccountDao.listByPage(param, page);
        String sql = "select new EnvCancellationAccount(project.name,describle.name,uuid,cityActualTime,cityEstimateTime,countyActualTime,countyEstimateTime,professionActualTime,professionEstimateTime,professionExamineTime,schedule,timeLimit,rectifitionUuid) ";
        Page<EnvCancellationAccount> accountPage = envCancellationAccountDao.listByPage(sql + param.getQueryString(), param.getParams(), page);
        return accountPage;
    }

    /**
     * <p>Title: getEcharts</p>
     * <p>Description: 销号概况  - 柱状图 </p>
     *
     * @param startTime
     * @param endTime
     * @return
     * @see ZpEnvCancellationAccountService#getEcharts(Date, Date)
     */
    @Override
    public JSONObject getEcharts(String startTime) {
        StringBuilder sb = new StringBuilder(" SELECT  T.UUID,T.CREATE_DATE,T.CREATE_USER,T.UPDATE_DATE,T.UPDATE_USER,");
        sb.append("  T.CITY_ACTUAL_TIME,T.CITY_ESTIMATE_TIME,T.COUNTY_ACTUAL_TIME,  ");
        sb.append("  T.COUNTY_ESTIMATE_TIME ,T.DESCRIBE,T.PROFESSION_ACTUAL_TIME,T.PROFESSION_ESTIMATE_TIME, ");
        sb.append("  T.PROFESSION_EXAMINE_TIME,T.NAME,T.RECTIFITION_UUID,T.SCHEDULE,a.uuid relationUuid, ");
        sb.append("  T.TIME_LIMIT,A.NAME projOProbName,B.NUM_OF_ROUND_VALUE ");
        sb.append("   FROM ENV_CANCELLATION_ACCOUNT T  LEFT JOIN COMMON_RELATION_TABLE A ON T.NAME = A.UUID ");
        sb.append("   LEFT JOIN COMMON_RELATION_TABLE c ON T.DESCRIBE = c.UUID  LEFT JOIN ENVIRONMEENT_RECTIFITION B ON T.RECTIFITION_UUID = B.UUID ");
        sb.append("   WHERE b.NUM_OF_ROUND_VALUE = ").append(SqlUtil.toSqlStr(startTime));
        sb.append("    AND  T.COUNTY_ACTUAL_TIME IS NOT NULL ");
        List<Map> list = simpleDao.getNativeQueryList(sb.toString());

        //List<EnvCancellationAccount> list = envCancellationAccountDao.selectList("from EnvCancellationAccount where timeLimit>=? and timeLimit<=? and countyActualTime is not null", startTime, endTime);
        JSONObject result = new JSONObject();
        int finishAll = 0; //已完成整改销号问题
        int xysAll = 0; //县验收
        int sysAll = 0; //市验收
        int hyscAll = 0; //行业审查
        int wcshAll = 0; //完成审核
        List<String> xAxisData = new ArrayList<String>();
        String seriesData = "";
        List<Integer> seriesDataList = new ArrayList<Integer>();
        if (ToolUtil.isNotEmpty(list)) {
            List<String> projectIds = new ArrayList<String>();
            Map<String, String> projectNames = new HashMap<>();
            Map<String, Map<String, Integer>> map = new HashMap<>();

            for (int i = 0; i < list.size(); i++) {
                Map account = list.get(i);
                String uuid = MapUtils.getString(account, "relationuuid", "");
                if (!projectIds.contains(uuid)) {
                    projectIds.add(uuid);
                    projectNames.put(uuid, MapUtils.getString(account, "projoprobname", ""));
                    Map<String, Integer> mapValue = new HashMap<>();
                    mapValue.put("xys", 0);
                    mapValue.put("sys", 0);
                    mapValue.put("hysc", 0);
                    mapValue.put("wcsh", 0);
                    map.put(uuid, mapValue);
                }
                String countyActualTime = MapUtils.getString(account, "countyActualTime", "");
                String cityActualTime = MapUtils.getString(account, "cityActualTime", "");
                if (ToolUtil.isNotEmpty(countyActualTime) && ToolUtil.isEmpty(cityActualTime)) {
                    xysAll++;
                    map.get(uuid).put("xys", map.get(uuid).get("xys") + 1);
                    map.get(uuid).put("status", 1);//每个项目到达的状态
                } else {
                    String professionActualTime = MapUtils.getString(account, "professionActualTime", "");
                    if (ToolUtil.isNotEmpty(cityActualTime) && ToolUtil.isEmpty(professionActualTime)) {
                        sysAll++;
                        map.get(uuid).put("sys", map.get(uuid).get("sys") + 1);
                        map.get(uuid).put("status", 2);//每个项目到达的状态
                    } else {
                        String professionExamineTime = MapUtils.getString(account, "professionExamineTime", "");
                        if (ToolUtil.isNotEmpty(professionActualTime) && ToolUtil.isEmpty(professionExamineTime)) {
                            hyscAll++;
                            map.get(uuid).put("hysc", map.get(uuid).get("hysc") + 1);
                            map.get(uuid).put("status", 3);//每个项目到达的状态
                        } else if (ToolUtil.isNotEmpty(professionExamineTime)) {
                            wcshAll++;
                            map.get(uuid).put("wcsh", map.get(uuid).get("wcsh") + 1);
                            map.get(uuid).put("status", 4);//每个项目到达的状态
                        }
                    }
                }
            }

            Integer status;
            for (int i = 0; i < projectIds.size(); i++) {
//				xAxisData.add(projectNames.get(projectIds.get(i)) + "," + map.get(projectIds.get(i)).get("xys") + "," + map.get(projectIds.get(i)).get("sys")
//						+ "," + map.get(projectIds.get(i)).get("hysc") + "," + map.get(projectIds.get(i)).get("wcsh")+","+projectIds.get(i));
//				seriesDataList.add(1);
                status = map.get(projectIds.get(i)).get("status");
                xAxisData.add(projectNames.get(projectIds.get(i)) + "," + projectIds.get(i) + "," + status);

                seriesDataList.add(status);
            }
        }
        //X轴数据从高到底排序
        Collections.sort(xAxisData, (o1, o2) -> new Integer(Integer.parseInt(o2.split(",")[2])).compareTo(new Integer(Integer.parseInt(o1.split(",")[2]))));
        //状态从高到底排序
        Collections.sort(seriesDataList, (o1, o2) -> o2 == null ? 0 : o2.compareTo(o1 == null ? 0 : o1));
        finishAll = xysAll + sysAll + hyscAll + wcshAll;
        seriesData = StringUtils.join(seriesDataList, ",");
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy年M月dd日");
        result.put("time", startTime + "年");
        result.put("xAxisData", xAxisData);
        result.put("seriesData", seriesData);
        result.put("xys", xysAll);
        result.put("sys", sysAll);
        result.put("hysc", hyscAll);
        result.put("wcsh", wcshAll);
        result.put("finishAll", finishAll);
        return result;
    }

    /**
     * <p>Title: getDescript</p>
     * <p>Description: 销号汇总表  - 描述   </p>
     *
     * @param param
     * @return
     * @see ZpEnvCancellationAccountService#getDescript(EnvCancellationAccountParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public R getDescript(EnvCancellationAccountParam param) {
        JSONObject jsonObject = new JSONObject();
        String sql = "SELECT SCHEDULE,COUNTY_ACTUAL_TIME,CITY_ACTUAL_TIME,PROFESSION_ACTUAL_TIME,PROFESSION_EXAMINE_TIME FROM ENV_CANCELLATION_ACCOUNT  ";
        if (ToolUtil.isNotEmpty(param.getProjectName())) {
            sql += " WHERE NAME IN (SELECT UUID FROM COMMON_RELATION_TABLE WHERE NAME LIKE'%" + param.getProjectName() + "%')";
            if (ToolUtil.isNotEmpty(param.getDescribleName())) {
                sql += " AND DESCRIBE IN (SELECT UUID FROM COMMON_RELATION_TABLE WHERE NAME LIKE'%" + param.getDescribleName() + "%')";
            }
        } else if (ToolUtil.isNotEmpty(param.getDescribleName())) {
            sql += " WHERE DESCRIBE IN (SELECT UUID FROM COMMON_RELATION_TABLE WHERE NAME LIKE'%" + param.getDescribleName() + "%')";
        }
        List<Object[]> resultList = envCancellationAccountDao.createNativeQuery(sql).getResultList();
        int num = 0, num1 = 0, num2 = 0, num3 = 0, num4 = 0;
        for (Object[] objects : resultList) {
            num++;
            if (ToolUtil.isNotEmpty(objects[1])) {
                num1++;
            }
            if (ToolUtil.isNotEmpty(objects[2])) {
                num2++;
            }
            if (ToolUtil.isNotEmpty(objects[3])) {
                num3++;
            }
            if (ToolUtil.isNotEmpty(objects[4])) {
                num4++;
            }
        }
        jsonObject.put("num", num);
        jsonObject.put("num1", num1);
        jsonObject.put("num2", num2);
        jsonObject.put("num3", num3);
        jsonObject.put("num4", num4);
        return R.ok(jsonObject);
    }

    /**
     * <p>Title: getDecription</p>
     * <p>Description:根据项目id和项目状态获取描述信息 </p>
     *
     * @param id
     * @param status
     * @param page
     * @param request
     * @return
     * @see ZpEnvCancellationAccountService#getDecription(String, String, Page, HttpServletRequest)
     */
    @Override
    public Page<Map<String, Object>> getDecription(String id, String status, Page<Map<String, Object>> page) {
        String sql = "SELECT e.UUID ,c.NAME FROM ENV_CANCELLATION_ACCOUNT e INNER JOIN  COMMON_RELATION_TABLE c  ON e.DESCRIBE = c.UUID "
                + "WHERE e.NAME='" + id + "'" + status;
        return simpleDao.listNativeByPage(sql, page);
    }

    /**
     * <p>Title: getDetail</p>
     * <p>Description: 获取描述的详细信息</p>
     *
     * @param id
     * @param page
     * @return
     * @see ZpEnvCancellationAccountService#getDetail(String, Page)
     */
    @Override
    public Page<Map<String, Object>> getDetail(String id, Page<Map<String, Object>> page) {
        String sql = "SELECT SCHEDULE,COUNTY_ACTUAL_TIME,CITY_ACTUAL_TIME,PROFESSION_ACTUAL_TIME,PROFESSION_EXAMINE_TIME"
                + " FROM ENV_CANCELLATION_ACCOUNT WHERE UUID ='" + id + "'";
        return simpleDao.listNativeByPage(sql, page);
    }

    /**
     * <p>Title: getDecriptionAll</p>
     * <p>Description: 根据任务状态获取所有描述信息</p>
     *
     * @param status
     * @param page
     * @param request
     * @return
     * @see ZpEnvCancellationAccountService#getDecriptionAll(String, Page, HttpServletRequest)
     */
    @Override
    public Page<Map<String, Object>> getDecriptionAll(String status, Page<Map<String, Object>> page, HttpServletRequest request) {
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
//        if (StringUtils.isNotEmpty(startTime)) {
//            startTime = CountUtil.getStartDate(startTime,0);
//            endTime = CountUtil.getEndDate(endTime,0);
//        }
        StringBuilder sql = new StringBuilder(" SELECT e.UUID ,a.NAME,b.NAME DESCRIBE FROM ENV_CANCELLATION_ACCOUNT e INNER JOIN ");
        sql.append(" COMMON_RELATION_TABLE a ON e.DESCRIBE=a.UUID INNER JOIN COMMON_RELATION_TABLE b ON e.NAME=b.UUID ");
        sql.append(" LEFT JOIN ENVIRONMEENT_RECTIFITION c ON e.RECTIFITION_UUID = c.UUID WHERE 1=1  ");
        sql.append(" and c.NUM_OF_ROUND_VALUE =").append(SqlUtil.toSqlStr(startTime));
        sql.append(status);
        return simpleDao.listNativeByPage(sql.toString(), page);
    }

    /**
     * <p>Title: deleteByUuid</p>
     * <p>Description: 销号汇总表	-	删除</p>
     *
     * @param uuid
     * @see ZpEnvCancellationAccountService#deleteByUuid(String)
     */
    @Override
    public void deleteByUuid(String uuid) {
        String sql1 = "DELETE FROM ENV_CANCELLATION_ACCOUNT WHERE RECTIFITION_UUID='" + uuid + "'";
        String sql2 = "DELETE FROM ENVIRONMEENT_RECTIFITION WHERE UUID='" + uuid + "'";
        simpleDao.createNativeQuery(sql1).executeUpdate();
        simpleDao.createNativeQuery(sql2).executeUpdate();
    }

}
