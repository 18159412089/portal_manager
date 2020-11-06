package com.fjzxdz.ams.module.enviromonit.poc;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
//@Configuration
public class PocApi {
    @Autowired
    private PocConfig pocConfig;
    private static volatile PocApi sinleton;
    private PocApi(){}
    @PostConstruct //通过@PostConstruct实现初始化bean之前进行的操作
    public void init() {
        sinleton = this;
        sinleton.pocConfig = this.pocConfig;
    }
    public static PocApi getInstance(){
        if(sinleton==null){
            synchronized (PocApi.class) {
                if(sinleton==null){
                    sinleton = new  PocApi();
                }
            }
        }
        return sinleton;
    }

    public PocConfig getPocConfig() {
        return pocConfig;
    }

    public void setPocConfig(PocConfig pocConfig) {
        this.pocConfig = pocConfig;
    }

    /**
     * PoC入驻平台接入鉴权
     * @return
     */
    public String identifyAccount(){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10000);
        body.put("HostIp", pocConfig.getIdentifyHostip());
        body.put("CustomId", pocConfig.getIdentifyAccount());
        body.put("CustomPwd", pocConfig.getIdentifyPassword());
        params.put("Body",body.toString());
       return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 调度员获取Session信息
     * @return
     */
    public String getSession(String serviceCode){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10010);
        body.put("ServiceCode",serviceCode);
        body.put("DispatcherId", pocConfig.getDispatchAccount());
        body.put("DispatcherPwd", pocConfig.getDispatchPassword());
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取调度员列表
     * @return
     */
    public String getDispatcherList(String sessionId){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10011);
        body.put("SessionId",sessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 设定/取消调度员身份
     * @return
     */
    public String getSetOrCanceDispatcher(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String sessionId = jsonData.getString("sessionId");
        String uid = jsonData.getString("uid");
        String action = jsonData.getString("action");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10012);
        body.put("SessionId",sessionId);
        body.put("Uid",uid);
        body.put("Action",action);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取组织节点树
     * @return
     */
    public String getOrganizationListTree(String sessionId){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10100);
        body.put("SessionId",sessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
       // return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 增加组织节点
     * @return
     */
    public String newOrganization(String jsonDataStr){
        JSONObject jsonData =  JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgParentId = jsonData.getString("OrgParentId");
        String OrgName = jsonData.getString("OrgName");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10101);
        body.put("SessionId",SessionId);
        body.put("OrgParentId",OrgParentId);
        body.put("OrgName",OrgName);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 删除组织节点
     * @return
     */
    public String deleteOrganization(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgId = jsonData.getString("OrgId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10102);
        body.put("SessionId",SessionId);
        body.put("OrgId",OrgId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 修改组织节点
     * @return
     */
    public String updateOrganization(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgId = jsonData.getString("OrgId");
        String OrgName = jsonData.getString("OrgName");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10103);
        body.put("SessionId",SessionId);
        body.put("OrgId",OrgId);
        body.put("OrgName",OrgName);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取用户列表（获取某组织下的成员）
     * PageSize	数值（选填，但必须和PageIndex同时存在）	指定分页最大记录数
     * PageIndex	数值（选填）	-1：尾页；0：首页；其它数值为页数-1
     * @return
     */
    public String getOrganizationUserListByOrgId(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgId = jsonData.getString("OrgId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10111);
        body.put("SessionId",SessionId);
        body.put("OrgId",OrgId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取用户基本信息
     * @return
     */
    public String getOrganizationUser(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        JSONArray Uids = jsonData.getJSONArray("Uids");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10112);
        body.put("SessionId",SessionId);
        body.put("Uids",Uids);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取某组织下的成员并携带遥毙，呼叫限制状态
     * @return
     */
    public String getOrganizationUserListForRemoteCtlOrLimitCall(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgId = jsonData.getString("OrgId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10114);
        body.put("SessionId",SessionId);
        body.put("OrgId",OrgId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取组织下的成员  获取登录调度员所在组织下面所有人员及其子组织下面人员
     * @return
     */
    public String getUserList(String sessionId){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10115);
        body.put("SessionId",sessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }
    /**
     * 获取组织下的成员（树形结构）  获取登录调度员所在组织下面所有人员及其子组织下面人员
     * @return
     */
    public String getUserListTree(String sessionId){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10116);
        body.put("SessionId",sessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取指定用户的当前位置
     * @return
     */
    public String getUserLocation(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        JSONArray Uids = jsonData.getJSONArray("Uids");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10200);
        body.put("SessionId",SessionId);
        body.put("Uids",Uids);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 通过条件查询某一用户的历史坐标位置列表
     * LocationType	0：全部；1：GPS坐标；2：基站坐标
     * PageSize	指定分页最大记录数
     * PageIndex -1：尾页；0：首页；其它数值为页数-1
     * @return
     */
    public String getUserHistoryLocationList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String Uid = jsonData.getString("Uid");
        String TimeFrom = jsonData.getString("TimeFrom");
        String TimeTo = jsonData.getString("TimeTo");
        Integer LocationType = jsonData.getInteger("LocationType");
        Integer PageSize = jsonData.getInteger("PageSize");
        Integer PageIndex = jsonData.getInteger("PageIndex");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10201);
        body.put("SessionId",SessionId);
        body.put("Uid",Uid);
        body.put("TimeFrom",TimeFrom);
        body.put("TimeTo",TimeTo);
        body.put("LocationType",LocationType);
        body.put("PageSize",PageSize);
        body.put("PageIndex",PageIndex);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 获取锁定位置（报错了）
     * @return
     */
    public String getLockLocation(String sessionId){
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10202);
        body.put("SessionId",sessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }


    /**
     * 创建频道
     * Countinqueue 频道排队人数 0 无排队 5：5人 10：10人
     * CrMemberTalkduration 频道发言时长:20:20 30:30 40:40	50:50 60:60  90:90 120:120 150:150 180:180  -1：无限制
     * ChannelLevel 0：最高；1：高；2：中；3：低；4：最低
     * @return
     */
    public String newChannel(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ChannelName = jsonData.getString("ChannelName");
        String Display = jsonData.getString("Display");
        Integer ChannelLevel = jsonData.getInteger("ChannelLevel");
        Integer Countinqueue = jsonData.getInteger("Countinqueue");
        Integer CrMemberTalkduration = jsonData.getInteger("CrMemberTalkduration");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10300);
        body.put("SessionId",SessionId);
        body.put("ChannelName",ChannelName);
        body.put("Display",Display);
        body.put("ChannelLevel",ChannelLevel);
        body.put("Countinqueue",Countinqueue);
        body.put("CrMemberTalkduration",CrMemberTalkduration);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取可见的频道列表
     * @return
     */
    public String getChannelList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10305);
        body.put("SessionId",SessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取其它人创建的频道列表
     * @return
     */
    public String getOtherChannelList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10315);
        body.put("SessionId",SessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 创建会话
     * Match 0：固定会话 1：临时会话
     * @return
     */
    public String newConversation(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ConversationName = jsonData.getString("ConversationName");
        Integer Match = jsonData.getInteger("Match");
        JSONArray Members = jsonData.getJSONArray("Members");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10306);
        body.put("SessionId",SessionId);
        body.put("ConversationName",ConversationName);
        body.put("Match",Match);
        body.put("Members",Members);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 删除会话
     * @return
     */
    public String deleteConversation(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ConversationId = jsonData.getString("ConversationId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10307);
        body.put("SessionId",SessionId);
        body.put("ConversationId",ConversationId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 修改会话名称
     * @return
     */
    public String updateConversationName(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ConversationId = jsonData.getString("ConversationId");
        String ConversationName = jsonData.getString("ConversationName");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10308);
        body.put("SessionId",SessionId);
        body.put("ConversationId",ConversationId);
        body.put("ConversationName",ConversationName);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 增加/删除会话成员
     * Action 0：添加成员；1：删除成员
     * @return
     */
    public String newOrDeleteConversationUser(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ConversationId = jsonData.getString("ConversationId");
        Integer Action = jsonData.getInteger("Action");
        JSONArray Members = jsonData.getJSONArray("Members");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10309);
        body.put("SessionId",SessionId);
        body.put("ConversationId",ConversationId);
        body.put("Action",Action);
        body.put("Members",Members);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取可见的会话列表
     * @return
     */
    public String getConversationList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10310);
        body.put("SessionId",SessionId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     * 按条件检索查询视频录制记录
     * Uid	“”空字符串表示全部用户，制定用户的ID表示仅查询该用户
     * @return
     */
    public String getVideosList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String TimeFrom = jsonData.getString("TimeFrom");
        String TimeTo = jsonData.getString("TimeTo");
        String Uid = jsonData.getString("Uid");
        String SesId = jsonData.getString("SesId");
        Integer PageSize = jsonData.getInteger("PageSize");
        Integer PageIndex = jsonData.getInteger("PageIndex");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",11100);
        body.put("SessionId",SessionId);
        body.put("TimeFrom",TimeFrom);
        body.put("TimeTo",TimeTo);
        body.put("Uid",Uid);
        body.put("SesId",SesId);
        body.put("PageSize",PageSize);
        body.put("PageIndex",PageIndex);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取频道成员列表
     * @return
     */
    public String getChannelUserList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ChannelId = jsonData.getString("ChannelId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10311);
        body.put("SessionId",SessionId);
        body.put("ChannelId",ChannelId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取会话成员列表
     * @return
     */
    public String getConversationUserList(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ConversationId = jsonData.getString("ConversationId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10312);
        body.put("SessionId",SessionId);
        body.put("ConversationId",ConversationId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  加载指定组织成员和直接子组织
     * @return
     */
    public String getOrganizationListAndUserListByOrgId(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String OrgId = jsonData.getString("OrgId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10313);
        body.put("SessionId",SessionId);
        body.put("OrgId",OrgId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }

    /**
     *  获取指定频道详细属性
     * @return
     */
    public String getChannelDetails(String jsonDataStr){
        JSONObject jsonData = JSONObject.parseObject(jsonDataStr);
        String SessionId = jsonData.getString("SessionId");
        String ChannelId = jsonData.getString("ChannelId");
        JSONObject params = new JSONObject();
        JSONObject body = new JSONObject();
        params.put("Code",10314);
        body.put("SessionId",SessionId);
        body.put("ChannelId",ChannelId);
        params.put("Body",body.toString());
        return HttpClientUtils.httpPost(pocConfig.getIdentifyUrl(),params).toString();
    }
    public static void main(String[] args) {
        //String responseData = PocApi.getInstance().pocConfig.getIdentifyAccount()();
        //String responseData = PocApi.getInstance().getSession("7A5385C034FEF000B5DC7A4493DE2ED104E4FAA94F2762C0405B616124B1E77E");
        //String responseData = PocApi.getInstance().getDispatcherList("52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //String responseData = PocApi.getInstance().getSetOrCanceDispatcher("52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C","124710001",1);
        //String responseData = PocApi.getInstance().getUserListTree("52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgParentId","0");
        //jsonObject.put("OrgName","测试组织");//73383
        //String responseData = PocApi.getInstance().newOrganization(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgId","73381");
        //String responseData = PocApi.getInstance().deleteOrganization(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgId","73383");
        //jsonObject.put("OrgName","测试");//73383
        //String responseData = PocApi.getInstance().updateOrganization(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgId","30784");//18250221601
        //String responseData = PocApi.getInstance().getOrganizationUserList(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //JSONArray jsonArray = new JSONArray();
        //String userId = "18250221601";
        //jsonArray.put(userId);
        //jsonObject.put("Uids",jsonArray);//18250221601
        //String responseData = PocApi.getInstance().getOrganizationUser(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgId","30784");//18250221601
        //String responseData = PocApi.getInstance().getOrganizationUserListForRemoteCtlOrLimitCall(jsonObject.toString());
        //String responseData = PocApi.getInstance().getUserListTree("52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //JSONArray jsonArray = new JSONArray();
        //String userId = "18250221601";
        //jsonArray.put(userId);
        //jsonObject.put("Uids",jsonArray);//18250221601
        //String responseData = PocApi.getInstance().getUserLocation(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("Uid","18250221601");//18250221601
        //jsonObject.put("TimeFrom","2018-05-16 16:34:00");
        //jsonObject.put("TimeTo","2018-05-15 17:34:00");
        //jsonObject.put("LocationType",0);
        //jsonObject.put("PageSize",30);
        //jsonObject.put("PageIndex",0);
        //String responseData = PocApi.getInstance().getUserHistoryLocationList(jsonObject.toString());
        //String responseData = PocApi.getInstance().getLockLocation("52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //String responseData = PocApi.getInstance().getChannelList(jsonObject.toString());//C59126
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("ConversationName","固定会话");
        //jsonObject.put("Match",0);
        //JSONArray jsonArray = new JSONArray();
        //String userId = "18250221601";
        //String userId1 = "18250205829";
        //jsonArray.put(userId);
        //jsonArray.put(userId1);
        //jsonObject.put("Members",jsonArray);//18250221601
        //String responseData = PocApi.getInstance().newConversation(jsonObject.toString());//{"Result":200,"ConversationId":"1168745"}
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //String responseData = PocApi.getInstance().getConversationList(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("Uid"," ");//18250221601
        //jsonObject.put("TimeFrom","2018-05-16 16:34:00");
        //jsonObject.put("TimeTo","2018-05-15 17:34:00");
        //jsonObject.put("SesId","1168745");
        //jsonObject.put("PageSize",30);
        //jsonObject.put("PageIndex",0);
        //String responseData = PocApi.getInstance().getVideosList(jsonObject.toString());
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("ChannelId","C59289");
        //String responseData = PocApi.getInstance().getChannelUserList(jsonObject.toString());//C59126
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("ConversationId","1168745");
        //String responseData = PocApi.getInstance().getConversationUserList(jsonObject.toString());//C59126
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("OrgId","73381");
        //String responseData = PocApi.getInstance().getOrganizationListAndUserListByOrgId(jsonObject.toString());//C59126
        //JSONObject jsonObject = new JSONObject();
        //jsonObject.put("SessionId","52049ED09E01011416112BC1A4D9B6BDCE436B3782EECED6A60E53B9BB96779C");
        //jsonObject.put("ChannelId","C59126");
        //String responseData = PocApi.getInstance().getChannelDetails(jsonObject.toString());//C59126
//        String responseData = PocApi.getInstance().identifyAccount();
//        System.out.println("PocApi.getInstance().identifyAccount():"+responseData);
//        JSONObject data = new JSONObject(responseData);
//        String serviceCode = data.getString("ServiceCode");
//        String serviceCode = "7A5385C034FEF000B5DC7A4493DE2ED1BB97E170B8F9E50212E92150F90F87A8";
//        String sessionStr = PocApi.getInstance().getSession(serviceCode);
//        System.out.println("sessionStr:"+sessionStr);
//        JSONObject sessionData = new JSONObject(sessionStr);
        //String sessionId = sessionData.getString("SessionId");

        //52049ED09E01011416112BC1A4D9B6BDBC6E8308C5B6D81B1E55EBC4D96654A0
        String s = "PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjxjb25mZXJlbmNlLWluZm8geG1sbnM9InVybjppZXRmOnBhcmFtczp4bWw6bnM6Y29uZmVyZW5jZS1pbmZvIiBzdGF0ZT0icGFydGlhbCIgdmVyc2lvbj0iMiIgZW50aXR5PSJzaXA6YWRob2NpbnN0YW50KzcxMzM4NUA0Z3BvYy5jb20iPjx1c2VycyBzdGF0ZT0iZnVsbCI+PHVzZXIgZW50aXR5PSJzaXA6MTI0NzEwMDAxQDRncG9jLmNvbSIgc3RhdGU9ImZ1bGwiPjxkaXNwbGF5LXRleHQ+QWRtaW48L2Rpc3BsYXktdGV4dD48ZW5kcG9pbnQgZW50aXR5PSJzaXA6MTI0NzEwMDAxQDRncG9jLmNvbSI+PHN0YXR1cz5jb25uZWN0ZWQ8L3N0YXR1cz48L2VuZHBvaW50PjwvdXNlcj48dXNlciBlbnRpdHk9InNpcDoxODI1MDIwNjU3NkA0Z3BvYy5jb20iIHN0YXRlPSJmdWxsIj48ZGlzcGxheS10ZXh0PjE4MjUwMjA2NTc2PC9kaXNwbGF5LXRleHQ+PGVuZHBvaW50IGVudGl0eT0ic2lwOjE4MjUwMjA2NTc2QDRncG9jLmNvbSI+PHN0YXR1cz5jb25uZWN0ZWQ8L3N0YXR1cz48L2VuZHBvaW50PjwvdXNlcj48L3VzZXJzPjwvY29uZmVyZW5jZS1pbmZvPgoNCg==";
        //System.out.println(s.toString());
    }
//{"Result":200,"Orgs":[{"Id":0,"Name":"中国移动通信集团福建有限公司漳州分公司","Orgs":[{"Id":30784,"ParentId":0,"Name":"芗城公司演示"},{"Id":30785,"ParentId":0,"Name":"龙海公司演示"},{"Id":30786,"ParentId":0,"Name":"云霄公司演示"},{"Id":30787,"ParentId":0,"Name":"漳浦公司演示"},{"Id":30788,"ParentId":0,"Name":"南靖公司演示"},{"Id":30789,"ParentId":0,"Name":"平和公司演示"},{"Id":30790,"ParentId":0,"Name":"长泰公司演示"},{"Id":30791,"ParentId":0,"Name":"诏安公司演示"},{"Id":30792,"ParentId":0,"Name":"东山公司演示"},{"Id":30793,"ParentId":0,"Name":"华安公司演示"},{"Id":30794,"ParentId":0,"Name":"龙文公司演示"},{"Id":73383,"ParentId":0,"Name":"测试"}]}]}

    public com.alibaba.fastjson.JSONObject getOrganizationTree(String responseData){
        com.alibaba.fastjson.JSONObject returnObject = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject jsStr = com.alibaba.fastjson.JSONObject.parseObject(responseData);
        String organizationTree1;
        String organizationTree = jsStr.getString("Orgs");

        com.alibaba.fastjson.JSONArray organizationTreeArray = com.alibaba.fastjson.JSONArray.parseArray(organizationTree);
        for(int i=0;organizationTreeArray.size()>i;i++){
            organizationTree1= organizationTreeArray.get(i).toString();

            com.alibaba.fastjson.JSONObject jsStr1 = com.alibaba.fastjson.JSONObject.parseObject(organizationTree1);
            returnObject.put("text", jsStr1.getString("Name"));
            returnObject.put("id", jsStr1.getString("Id"));
            returnObject.put("parentId", "");
            if(jsStr1.containsKey("Orgs")){
                com.alibaba.fastjson.JSONArray jsonArrayTemp = getOrganizationTreeChildren(jsStr1);
                    returnObject.put("children",jsonArrayTemp);
            }else {
                returnObject.put("state", "");
            }
        }
        return returnObject;
    }

    public com.alibaba.fastjson.JSONArray getOrganizationTreeChildren(com.alibaba.fastjson.JSONObject jsStr){
        com.alibaba.fastjson.JSONArray organizationTreeArray = new com.alibaba.fastjson.JSONArray();
        if(jsStr.containsKey("Orgs")){
            com.alibaba.fastjson.JSONArray jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsStr.getString("Orgs"));
            for (int i = 0; i < jsonArray.size(); i++) {
                com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(jsonArray.get(i).toString());
                com.alibaba.fastjson.JSONObject jsStr1 = new com.alibaba.fastjson.JSONObject();
                jsStr1.put("text", jsonObject.getString("Name"));
                jsStr1.put("id", jsonObject.getString("Id"));
                jsStr1.put("parentId", jsonObject.getString("ParentId"));
                jsStr1.put("state", "");
                organizationTreeArray.add(jsStr1);
            }
        }
        return organizationTreeArray;
    }

}
