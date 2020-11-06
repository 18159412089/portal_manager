package com.fjzxdz.ams.module.enviromonit.epa.controller;

import cn.fjzxdz.frame.controller.BaseController;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.JedisUtils;
import com.fjzxdz.ams.module.enviromonit.poc.PocApi;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/epa/instantMessagingMap")
@Secured({ "ROLE_USER" })
public class InstantMessagingMapController extends BaseController {

	@RequestMapping("")
	public String index( HttpServletRequest request) {

		String callAccount = request.getParameter("callAccount");
		request.setAttribute("dispatchAccount", PocApi.getInstance().getPocConfig().getDispatchAccount());
		request.setAttribute("dispatchPassword", PocApi.getInstance().getPocConfig().getDispatchPassword());
		request.setAttribute("plaintextPassword", PocApi.getInstance().getPocConfig().getPlaintextPassword());
		if(callAccount!=null){
			request.setAttribute("callAccount", callAccount);
		}else{
			request.setAttribute("callAccount", "");
		}
		return "/moudles/enviromonit/instantMessagingMap";
	}

	/**
	 * PoC入驻平台接入鉴权
	 * @return
	 */
	@RequestMapping("/identifyAccount")
	@ResponseBody
	public String identifyAccount(){
		String serviceCode = "";
		try {
			if(JedisUtils.getObject("ServiceCode")!= null){
				serviceCode = JedisUtils.getObject("ServiceCode").toString();
			}else{
				String responseData = PocApi.getInstance().identifyAccount();
				JSONObject jsonObject = JSONObject.parseObject(responseData);
				serviceCode = jsonObject.getString("ServiceCode");
				JedisUtils.setObject("ServiceCode",serviceCode,3000);
			}
		}catch (Exception e){
			System.out.println(e);
		}
		return serviceCode;
	}

	/**
	 * 调度员获取Session信息
	 * @return
	 */
	@RequestMapping("/getSession")
	@ResponseBody
	public String getSession(String ServiceCode){
		String sessionId = "";
		try {
			if(JedisUtils.getObject("SessionId")!= null){
				sessionId = JedisUtils.getObject("SessionId").toString();
			}else{
				String  responseData = PocApi.getInstance().getSession(ServiceCode);
				JSONObject jsonObject = JSONObject.parseObject(responseData);
				sessionId = jsonObject.getString("SessionId");
				JedisUtils.setObject("SessionId",sessionId,3000);
			}
		}catch (Exception e){
			System.out.println(e);
		}
		return sessionId;
	}
	/**
	 * 获取可见的频道列表
	 * @return
	 */
	@RequestMapping("/getChannelList")
	@ResponseBody
	public String getChannelList(){
		String responseData = "";
		try {
			if(JedisUtils.getObject("SessionId")!= null){
				String sessionId = JedisUtils.getObject("SessionId").toString();
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("SessionId",sessionId);
				responseData = PocApi.getInstance().getChannelList(jsonObject.toString());
			}
		}catch (Exception e){
			System.out.println(e);
		}
		return responseData;
	}

	/**
	 * 获取可见的会话列表
	 * @return
	 */
	@RequestMapping("/getConversationList")
	@ResponseBody
	public String getConversationList(){
		String responseData = "";
		try {
			if(JedisUtils.getObject("SessionId")!= null){
				String sessionId = JedisUtils.getObject("SessionId").toString();
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("SessionId",sessionId);
				responseData = PocApi.getInstance().getConversationList(jsonObject.toString());
			}
		}catch (Exception e){
			System.out.println(e);
		}
		return responseData;
	}

    /**
     * 获取频道成员列表
     * @return
     */
    @RequestMapping("/getChannelUserList")
    @ResponseBody
    public String getChannelUserList(String channelId){
        String responseData = "";
        try {
            if(JedisUtils.getObject("SessionId")!= null){
                String sessionId = JedisUtils.getObject("SessionId").toString();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("SessionId",sessionId);
                jsonObject.put("ChannelId",channelId);
                responseData = PocApi.getInstance().getChannelUserList(jsonObject.toString());
            }
        }catch (Exception e){
            System.out.println(e);
        }
        return responseData;
    }

    /**
     * 获取会话成员列表
     * @return
     */
    @RequestMapping("/getConversationUserList")
    @ResponseBody
    public String getConversationUserList(String conversationId){
        String responseData = "";
        try {
            if(JedisUtils.getObject("SessionId")!= null){
                String sessionId = JedisUtils.getObject("SessionId").toString();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("SessionId",sessionId);
                jsonObject.put("ConversationId",conversationId);
                responseData = PocApi.getInstance().getConversationUserList(jsonObject.toString());
            }
        }catch (Exception e){
            System.out.println(e);
        }
        return responseData;
    }
	/**
	 * 获取组织节点树
	 * @return
	 */
	@RequestMapping("/getOrganizationListTree")
	@ResponseBody
	public String getOrganizationListTree(String SessionId){
		String str = "";
		try {
			if(JedisUtils.getObject("OrganizationListTree")!= null){
				str = JedisUtils.getObject("OrganizationListTree").toString();
			}else{
				String responseData = PocApi.getInstance().getOrganizationListTree(SessionId);
				JSONArray returnArray = getOrganizationTree(responseData);
				str = returnArray.toString();
				JedisUtils.setObject("OrganizationListTree",str,3000);
			}
		}catch (Exception e){
			System.out.println(e);
		}
		return str;
	}


	/**
	 * 获取用户列表（获取某组织下的成员）
	 * @return
	 */
	@RequestMapping("/getOrganizationUserListByOrgId")
	@ResponseBody
	public String getOrganizationUserListByOrgId(String OrgId){
		String responseData = "";
		try {
			String sessionId = "";
			if(JedisUtils.getObject("SessionId")!= null){
				sessionId = JedisUtils.getObject("SessionId").toString();
			}
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("SessionId",sessionId);
			jsonObject.put("OrgId",OrgId);//18250221601 30784
			responseData = PocApi.getInstance().getOrganizationUserListByOrgId(jsonObject.toString());
		}catch (Exception e){
			System.out.println(e);
		}
		return responseData;
	}

	public JSONArray getOrganizationTree(String responseData){
		JSONArray returnArray = new JSONArray();
		JSONObject returnObject = new JSONObject();
		JSONObject jsStr = JSONObject.parseObject(responseData);
		String organizationTree1;
		String organizationTree = jsStr.getString("Orgs");

		JSONArray organizationTreeArray = JSONArray.parseArray(organizationTree);
		for(int i=0;organizationTreeArray.size()>i;i++){
			organizationTree1= organizationTreeArray.get(i).toString();

			JSONObject jsStr1 = JSONObject.parseObject(organizationTree1);
			returnObject.put("text", jsStr1.getString("Name"));
			returnObject.put("id", jsStr1.getString("Id"));
			returnObject.put("parentId", "");
			if(jsStr1.containsKey("Orgs")){
				JSONArray jsonArrayTemp = getOrganizationTreeChildren(jsStr1);
				returnObject.put("children",jsonArrayTemp);
			}else {
				returnObject.put("state", "");
			}
		}
		returnArray.add(returnObject);
		return returnArray;
	}

	public JSONArray getOrganizationTreeChildren(JSONObject jsStr){
		JSONArray organizationTreeArray = new JSONArray();
		if(jsStr.containsKey("Orgs")){
			JSONArray jsonArray = JSONArray.parseArray(jsStr.getString("Orgs"));
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = JSONObject.parseObject(jsonArray.get(i).toString());
				JSONObject jsStr1 = new JSONObject();
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
