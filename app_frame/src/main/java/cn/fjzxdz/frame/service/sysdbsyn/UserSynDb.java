/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package cn.fjzxdz.frame.service.sysdbsyn;

import cn.fjzxdz.frame.common.Constants;
import cn.fjzxdz.frame.entity.core.*;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.kit.HttpKit;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.fjzxdz.frame.utils.SynDBSimpleCurdUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.json.JSONArray;
import sun.misc.BASE64Encoder;

import java.security.MessageDigest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * 调用用户接口跨库操作数据库
 * @author gsq
 * @date 2019-10-17
 */
public class UserSynDb {

    public static R saveUserRelateInfo(UserOther user, UserInfo userInfo, JobOther job) throws Exception {
        boolean allRe = true;
        //开始插入sso-MySQL数据库数据
        Map<String, Object> userParamMap = userObjToMap(user);
        Map<String, Object> userInfoParamMap = userInfoObjToMap(userInfo);
        Map<String, Object> jobParamMap = jobObjToMap(job);
        //sso的sys_user表插入用户数据
        int userRe = SynDBSimpleCurdUtil.executeBySQL("sso", "sso.user_create", userParamMap);
        if(userRe==0){
            return R.error("跨库保存用户基础数据到sso失败！");
        }
        //sso的sys_user_info表插入用户数据
        int userInfoRe = SynDBSimpleCurdUtil.executeBySQL("sso", "sso.user_info_create", userInfoParamMap);
        if(userInfoRe==0){
            return R.error("跨库保存用户详情数据到sso失败！");
        }
        //sso的sys_job表插入数据
        int jobRe = SynDBSimpleCurdUtil.executeBySQL("sso", "sso.job_create", jobParamMap);
        if(jobRe==0){
            return R.error("跨库保存岗位数据到sso失败！");
        }
        //sso的job_user表插入数据
        Map<String, Object> paramMap = new HashMap<String, Object>();
        for(UserOther userOther : job.getUsers()){
            paramMap.clear();
            paramMap.put("job", setSqlStr(job.getUuid()));
            paramMap.put("user", setSqlStr(userOther.getUuid()));
            paramMap.put("enable", setSqlStr("1"));
            int juRe = SynDBSimpleCurdUtil.executeBySQL("sso", "sso.job_user_create", paramMap);
            if(juRe==0){
                return R.error("跨库保存岗位用户关联数据到sso失败！");
            }
        }
        //sso的job_role表插入数据
        for(RoleOther role : job.getRoles()){
            paramMap.clear();
            paramMap.put("job", setSqlStr(job.getUuid()));
            paramMap.put("role", setSqlStr(role.getUuid()));
            int jrRe = SynDBSimpleCurdUtil.executeBySQL("sso", "sso.job_role_create", paramMap);
            if(jrRe==0){
                return R.error("跨库保存岗位角色关联数据到sso失败！");
            }
        }

        //同步数据到sqlserver
        return synToSqlServer(user, userInfo, job);
    }

    private static R synToSqlServer(UserOther user, UserInfo userInfo, JobOther job) throws Exception {
        CustomerUserDetail operateUser = SpringSecurityUtils.getCurrentUser();
        Map<String, Object> pm = new HashMap<String, Object>();
        pm.put("uuid", setSqlStr(operateUser.getUuid()));
        cn.hutool.json.JSONArray reArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.user_select_by_id", pm);

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("id", setSqlStr(user.getOldSysUuid()));
        paramMap.put("departMentId", setSqlStr(job.getDept().getOldSysUuid()));
        paramMap.put("positionId", setSqlStr(job.getOldSysUuid()));
        StringBuilder groupIds = new StringBuilder();
        for (RoleOther role : job.getRoles()) {
            groupIds.append(role.getOldSysUuid()).append(",");
        }
        paramMap.put("groupIds", setSqlStr(ToolUtil.removeSuffix(groupIds.toString(), ",")));
        paramMap.put("code", setSqlStr(job.getSeq()));
        paramMap.put("description", setSqlStr(job.getName()));
        paramMap.put("loginId", setSqlStr(user.getLoginname()));
        paramMap.put("password", setSqlStr(md5(user.getLoginname()+ Constants.INIT_PWD)));
        paramMap.put("name", setSqlStr(user.getName()));
        paramMap.put("organization", setSqlStr(""));
        paramMap.put("partTimeJob", setSqlStr(""));
        paramMap.put("idCard", setSqlStr(user.getIdcard()));
        paramMap.put("sex", user.getSex());
        paramMap.put("supportAudioVideo", userInfo.getSupportAudioVideo());
        paramMap.put("email", setSqlStr(user.getEmail()));
        paramMap.put("telephone", setSqlStr(userInfo.getTelephone()));
        paramMap.put("mobilephone", setSqlStr(userInfo.getMobilephone()));
        paramMap.put("highestEducation", setSqlStr(userInfo.getHighestEducation()));
        paramMap.put("birthday", setSqlStr(userInfo.getBirthday()));
        paramMap.put("inspArea", setSqlStr(userInfo.getInspArea()));
        paramMap.put("inspFreq", userInfo.getInspFreq());
        paramMap.put("training", setSqlStr(userInfo.getTraining()));
        paramMap.put("checkInfo", setSqlStr(userInfo.getCheckInfo()));
        paramMap.put("cardId", setSqlStr(userInfo.getCardId()));
        paramMap.put("empId", setSqlStr(userInfo.getEmpId()));
        paramMap.put("anychatUserId", userInfo.getAnychatUserId());
        if(user.getEnable()==1) {
            paramMap.put("status", setSqlStr("ENABLED"));
        }else {
            paramMap.put("status", setSqlStr("DISABLED"));
        }
        paramMap.put("deptmentId", setSqlStr(userInfo.getOldSysDepartmentId()));
        paramMap.put("userType", setSqlStr(userInfo.getUserType()));
        paramMap.put("operatorId", setSqlStr(reArray.getJSONObject(0).getStr("old_sys_uuid")));
        paramMap.put("operatorAddress", setSqlStr(HttpKit.getIp()));
        paramMap.put("recordVersion", 1);
        paramMap.put("headImgId", setSqlStr(user.getAvatar()));
        paramMap.put("danweiId", setSqlStr(userInfo.getOldSysDanweiId()));
        paramMap.put("workCode", setSqlStr(userInfo.getWorkCode()));

        JSONArray re = SynDBSimpleCurdUtil.findBySQL("ZZEnvironmentalMessage", "environmentalMessage.saveUserRelateInfo", paramMap);
        if(re==null || re.size()==0){
            return R.error("同步到sql server出错！");
        }
        return R.ok("跨库保存数据成功！");
    }

    public static R insertPortalDeptInfoToSysJobTable(JobOther job, String portalDeptId) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Calendar calendar = Calendar.getInstance();
        CustomerUserDetail operateUser = SpringSecurityUtils.getCurrentUser();
        paramMap.put("uuid", setSqlStr(job.getUuid()));
        paramMap.put("name", setSqlStr(job.getName()));
        paramMap.put("seq", setSqlStr(job.getSeq()));
        paramMap.put("remark", setSqlStr(job.getRemark()));
        paramMap.put("enable", job.getEnable());
        paramMap.put("updateDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("updateUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("createDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("createUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("oldSysUuid", setSqlStr(job.getOldSysUuid()));
        paramMap.put("oldSysDeptUuid", setSqlStr(job.getDept().getOldSysUuid()));
        //部门数据，不是网格数据
        paramMap.put("dept", setSqlStr(portalDeptId));
        int re = SynDBSimpleCurdUtil.executeBySQL("ZZEnvironmentalMessage", "environmentalMessage.savePortalJob", paramMap);
        if(re==0){
            return R.error("跨库保存数据到sql server失败！");
        }
        return R.ok();
    }

    private static Map<String, Object> jobObjToMap(JobOther job){
        Calendar calendar = Calendar.getInstance();
        CustomerUserDetail operateUser = SpringSecurityUtils.getCurrentUser();
        Map<String, Object> paramMap = new HashMap<String, Object>();

        paramMap.put("uuid", setSqlStr(job.getUuid()));
        paramMap.put("name", setSqlStr(job.getName()));
        paramMap.put("seq", setSqlStr(job.getSeq()));
        paramMap.put("dept", setSqlStr(job.getDept().getUuid()));
        paramMap.put("remark", setSqlStr(job.getName()));
        paramMap.put("enable", job.getEnable());
        paramMap.put("updateUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("updateDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("createUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("createDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("oldSysUuid", setSqlStr(job.getOldSysUuid()));

        return paramMap;
    }

    private static Map<String, Object> userInfoObjToMap(UserInfo userInfo){
        Calendar calendar = Calendar.getInstance();
        CustomerUserDetail operateUser = SpringSecurityUtils.getCurrentUser();
        Map<String, Object> paramMap = new HashMap<String, Object>();

        paramMap.put("uuid", setSqlStr(userInfo.getUuid()));
        paramMap.put("userId", setSqlStr(userInfo.getUserId()));
        paramMap.put("idCard", setSqlStr(userInfo.getIdCard()));
        paramMap.put("sex", setSqlStr(userInfo.getSex()));
        paramMap.put("email", setSqlStr(userInfo.getEmail()));
        paramMap.put("telephone", setSqlStr(userInfo.getTelephone()));
        paramMap.put("mobilephone", setSqlStr(userInfo.getMobilephone()));
        paramMap.put("anychatUserId", setSqlStr(userInfo.getAnychatUserId()));
        paramMap.put("oldSysDanweiId", setSqlStr(userInfo.getOldSysDanweiId()));
        paramMap.put("danweiId", setSqlStr(userInfo.getDanweiId()));
        paramMap.put("oldSysDepartmentId", setSqlStr(userInfo.getOldSysDepartmentId()));
        paramMap.put("departmentId", setSqlStr(userInfo.getDepartmentId()));
        paramMap.put("partTimeJob", setSqlStr(userInfo.getPartTimeJob()));
        paramMap.put("organization", setSqlStr(userInfo.getOrganization()));
        paramMap.put("highestEducation", setSqlStr(userInfo.getHighestEducation()));
        paramMap.put("birthday", setSqlStr(userInfo.getBirthday()));
        paramMap.put("inspArea", setSqlStr(userInfo.getInspArea()));
        paramMap.put("inspFreq", setSqlStr(userInfo.getInspFreq()));
        paramMap.put("training", setSqlStr(userInfo.getTraining()));
        paramMap.put("updateUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("updateDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("createUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("createDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));

        return paramMap;
    }

    /**
     * 将用户实体类转换成Map
     * @param user
     * @return
     */
    private static Map<String, Object> userObjToMap(UserOther user){
        Calendar calendar = Calendar.getInstance();
        CustomerUserDetail operateUser = SpringSecurityUtils.getCurrentUser();
        Map<String, Object> paramMap = new HashMap<String, Object>();

        //新框架需要字段
        paramMap.put("uuid", setSqlStr(user.getUuid()));
        paramMap.put("loginname", setSqlStr(user.getLoginname()));
        paramMap.put("name", setSqlStr(user.getName()));
        paramMap.put("password", setSqlStr(user.getPassword()));
        paramMap.put("email", setSqlStr(user.getEmail()));
        paramMap.put("phone", setSqlStr(user.getPhone()));
        paramMap.put("sex", user.getSex());
        paramMap.put("idcard", setSqlStr(user.getIdcard()));
        paramMap.put("logintype", user.getLogintype()==null ? user.getLogintype() : user.getLogintype().ordinal());
        paramMap.put("enable", user.getEnable());
        paramMap.put("createDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("createUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("updateDate", setSqlStr(DateUtil.format(calendar.getTime(), "yyyy-MM-dd HH:mm:ss")));
        paramMap.put("updateUser", setSqlStr(operateUser.getUuid()));
        paramMap.put("oldSysUuid", setSqlStr(user.getOldSysUuid()));

        return paramMap;
    }

    public static String setSqlStr(Object str){
        if(str==null){
            return "null";
        }
        return "'"+str.toString()+"'";
    }

    public static String md5(String message) throws Exception {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        String md5Str = base64en.encode(md5.digest(message.getBytes("UTF-8")));
        return md5Str;
    }

}
