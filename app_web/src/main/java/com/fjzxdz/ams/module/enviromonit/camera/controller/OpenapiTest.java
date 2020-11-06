package com.fjzxdz.ams.module.enviromonit.camera.controller;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.hikvision.cms.api.common.util.Digests;
import com.hikvision.cms.api.common.util.HttpClientSSLUtils;

/**
 * openapi 测试DEMO
 * 客户开发的时候可以参考此代码编写自己的应用
 * 也可以使用demo中的jar包，不过jar包使用务必使用全套，
 * 万不可只取其中一部分，避免依赖破坏
 * @author shengyiling
 *
 */
class OpenapiTest {
	
	
	/**
	 * APPKEY需要到部署的平台服务器上生成。
	 * <p>
	 * 调用Openpai的操作码，需要去平台上生成，详见《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》中[获取AppKey和Secret]章节说明
	 * </p>
	 * <p>
	 * 《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》 该文档请找技术支持或者交付的同事提供
	 * </p>
	 */
	private static final String APPKEY = "bc3abec3";
	
	/**
	 * SECRET需要到部署的平台服务器上生成。
	 * <p>
	 * 调用Openpai的操作码，需要去平台上生成，详见《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》中[获取AppKey和Secret]章节说明
	 * </p>
	 * <p>
	 * 《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》 该文档请找技术支持或者交付的同事提供
	 * </p>
	 */
	private static final String SECRET = "8395742643a54ea58adefe7651b0e992";
	
	
	/**
	 * http请求地址
	 * <p>openapi的地址,默认情况下openapi的IP端口与基础应用的IP端口是一致的</p>
	 * <p>请将地址配置正确.</p>
	 * <p>默认情况下是127.0.0.1:80 ，如果地址不通请根据实际情况修改IP端口</p>
 	 */
	private static final String OPENAPI_IP_PORT_HTTP = "http://27.155.33.126:81";
	
	/**
	 * https请求地址
	 * <p>openapi的地址,默认情况下openapi的IP端口与基础应用的IP端口是一致的</p>
	 * <p>请将地址配置正确.</p>
	 * <p>默认情况下是127.0.0.1:443 ，如果地址不通请根据实际情况修改IP端口</p>
 	 */
	private static final String OPENAPI_IP_PORT_HTTPS = "https://127.0.0.1:443";
	
	/**
	 * 获取默认用户UUID的接口地址，此地址可以从《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》中具体的接口说明上获取
	 */
	private static final String ITF_ADDRESS_GET_DEFAULT_USER_UUID = "/openapi/service/base/user/getDefaultUserUuid";
	
	/**
	 * 分页获取监控点信息的接口地址，此地址可以从《海康威视iVMS-8700平台SDKV2.*.* HTTP-OpenAPI使用说明书.chm》中具体的接口说明上获取
	 */
	private static final String ITF_ADDRESS_GET_CAMERAS = "/openapi/service/vss/res/getCameras";
	private static final String ITF_ADDRESS_GET_DEFAULT_UNIT = "/openapi/service/base/org/getDefaultUnit";
	private static final String ITF_ADDRESS_GET_USERS = "/openapi/service/base/user/getUsers";
	private static final String ITF_ADDRESS_GET_NET_ZONES = "/openapi/service/base/netZone/getNetZones";
	private static final String ITF_ADDRESS_GET_REGIONS_BY_PARENT_UUID = "/openapi/service/base/org/getRegionsByParentUuid";
	private static final String ITF_ADDRESS_GET_UNITS_BY_PARENT_UUID = "/openapi/service/base/org/getUnitsByParentUuid";
	private static final String ITF_ADDRESS_GET_CAMERAS_BY_PARENT_UUID = "/openapi/service/base/org/getRegionsByParentUuid";
	private static final String ITF_ADDRESS_GET_CAMERAS_BY_REGION_UUIDS = "/openapi/service/vss/res/getCamerasByRegionUuids";
	private static final String ITF_ADDRESS_GET_PLAY_BACK_PARAM_BY_UUID = "/openapi/service/vss/playback/getPlaybackParamByPlanUuid";
	private static final String ITF_ADDRESS_GET_REGIONS_BY_UNIT_UUID = "/openapi/service/base/org/getRegionsByUnitUuid";
	private static final String ITF_ADDRESS_GET_RECORD_PLANS_BY_CAMERA_UUIDS = "/openapi/service/vss/playback/getRecordPlansByCameraUuids";
	//预览
	private static final String ITF_ADDRESS_GET_PRESET_INFOS_BY_CAMERA_UUID = "/openapi/service/vss/preset/getPresetInfosByCameraUuid";
	private static final String ITF_ADDRESS_GET_PREVIEW_PARAM_BY_CAMERA_UUID = "/openapi/service/vss/preview/getPreviewParamByCameraUuid";
	
	/**
	 * <p>操作用户UUID，即用户UUID，首次使用操作用户UUID可以通过接口 [获取默认用户UUID]来获取</p>
	 * <p>也可以通过接口[分页获取用户]来获取</p>
	 */
	private static final String OP_USER_UUID = "cc78be40ec8611e78168af26905e6f0f";
	
	/**
	 * 测试方法
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {

		/***http方式调用***/
		System.out.println(testGetDefaultUserUUID());
		System.out.println(testGetCameras());
		
		/***https方式调用***/
		/*System.out.println(testGetDefaultUserUUID_Https());
		System.out.println(testGetCameras_Https());*/
	}
	
	/**
	 * HTTP方式
	 * 获取默认用户UUID 测试
	 * @return
	 * @throws Exception
	 */
	private static String testGetDefaultUserUUID() throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_DEFAULT_USER_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		String params =  JSON.toJSONString(map);
		System.out.println(" ====== testGetDefaultUserUUID 请求参数：【" + params + "】");
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		System.out.println(" ====== testGetDefaultUserUUID 请求返回结果：【{" + data + "}】");
		
		return data;
	}
	

	public static String getDefaultUserUUID() throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_DEFAULT_USER_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		String params =  JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	/** 
	 * HTTP方式
	 * 分页获取监控点信息 测试
	 * @return
	 * @throws Exception
	 */
	private static String testGetCameras() throws Exception{
		 String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_CAMERAS;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("appkey", APPKEY);//设置APPKEY
        map.put("time", System.currentTimeMillis());//设置时间参数
        map.put("pageNo", 1);//设置分页参数
        map.put("pageSize", 5);//设置分页参数
        map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
        String params = JSON.toJSONString(map);
        System.out.println(" ====== getCameras请求参数：【" + params + "】");
        String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
        System.out.println(" ====== getCameras请求返回结果：【{" + data + "}】");
        
        return data;
	}
	
	/** 
	 * HTTP方式
	 * 分页获取监控点信息 测试
	 * @return
	 * @throws Exception
	 */
	public static String getCameras() throws Exception{
		 String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_CAMERAS;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("appkey", APPKEY);//设置APPKEY
        map.put("time", System.currentTimeMillis());//设置时间参数
        map.put("pageNo", 1);//设置分页参数
        map.put("pageSize", 5);//设置分页参数
        map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
        String params = JSON.toJSONString(map);
        System.out.println(" ====== getCameras请求参数：【" + params + "】");
        String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
        System.out.println(" ====== getCameras请求返回结果：【{" + data + "}】");
        
        return data;
	}
	
	/** 
	 * HTTP方式
	 * 分页获取监控点信息 测试
	 * @return
	 * @throws Exception
	 */
	public static String getUsers(String defaultUserUuid) throws Exception{
		 String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_USERS;
        Map<String, Object> map = new HashMap<String, Object>();
        //strParam = {"appkey":tAppkey,"time":time,"pageNo":1,"pageSize":400,"opUserUuid":defaultUserUuid};
        map.put("appkey", APPKEY);//设置APPKEY
        map.put("time", System.currentTimeMillis());//设置时间参数
        map.put("pageNo", 1);//设置分页参数
        map.put("pageSize", 400);//设置分页参数
        map.put("opUserUuid", defaultUserUuid);//设置操作用户UUID
        //map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
        String params = JSON.toJSONString(map);
        
        String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
        
        return data;
	}
	
	public static String getDefaultUnit(String defaultUserUuid, String subSystemCode) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_DEFAULT_UNIT;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("opUserUuid", defaultUserUuid);//设置操作用户UUID
		map.put("subSystemCode", subSystemCode);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getNetZones(String defaultUserUuid) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_NET_ZONES;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("opUserUuid", defaultUserUuid);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getRegionsByParentUuid(String opUserUuid,String parentUuid,Integer allChildren) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_REGIONS_BY_PARENT_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("parentUuid", parentUuid);//设置操作用户UUID
		map.put("allChildren", allChildren);//设置操作用户UUID
		
		String params = JSON.toJSONString(map);
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getRegionsByUnitUuid(String opUserUuid,String parentUuid,Integer allChildren) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_REGIONS_BY_UNIT_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("parentUuid", parentUuid);//设置操作用户UUID
		map.put("allChildren", allChildren);//设置操作用户UUID
		
		String params = JSON.toJSONString(map);
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getCamerasByRegionUuids(String opUserUuid,String regionUuids) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_CAMERAS_BY_REGION_UUIDS;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("regionUuids", regionUuids);//设置操作用户UUID
		
		String params = JSON.toJSONString(map);
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getUnitsByParentUuid(String opUserUuid,String parentUuid,Integer allChildren) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_UNITS_BY_PARENT_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 400);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("parentUuid", parentUuid);//设置操作用户UUID
		map.put("allChildren", allChildren);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getCamerasByParentUuid() throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_CAMERAS_BY_PARENT_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getPlaybackParamByPlanUuid(String opUserUuid,String planType,String recordPlanUuid,String netZoneUuid) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_PLAY_BACK_PARAM_BY_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("planType", planType);//设置操作用户UUID
		map.put("recordPlanUuid", recordPlanUuid);//设置操作用户UUID
		map.put("netZoneUuid", netZoneUuid);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getRecordPlansByCameraUuids(String opUserUuid,String cameraUuids,String netZoneUuid) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_RECORD_PLANS_BY_CAMERA_UUIDS;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("pageNo", 1);//设置分页参数
		map.put("pageSize", 5);//设置分页参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("cameraUuids", cameraUuids);//设置操作用户UUID
		map.put("netZoneUuid", netZoneUuid);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	/**
	 * HTTPS方式
	 * 获取默认用户UUID 测试
	 * @return
	 * @throws Exception
	 */
	private static String testGetDefaultUserUUID_Https() throws Exception{
		String url = OPENAPI_IP_PORT_HTTPS + ITF_ADDRESS_GET_DEFAULT_USER_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		String params =  JSON.toJSONString(map);
		System.out.println("============" + params + "============");
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		System.out.println("============" + data + "============");
		
		return data;
	}
	
	/**
	 * HTTPS方式
	 * 分页获取监控点信息 测试
	 * @return
	 * @throws Exception
	 */
	private static String testGetCameras_Https() throws Exception{
		 String url = OPENAPI_IP_PORT_HTTPS + ITF_ADDRESS_GET_CAMERAS;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("appkey", APPKEY);//设置APPKEY
        map.put("time", System.currentTimeMillis());//设置时间参数
        map.put("pageNo", 1);//设置分页参数
        map.put("pageSize", 5);//设置分页参数
        map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
        String params = JSON.toJSONString(map);
        System.out.println(" ====== getCameras请求参数：【" + params + "】");
        String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
        System.out.println(" ====== getCameras请求返回结果：【{" + data + "}】");
        
        return data;
	}

	
	public static String getPresetInfosByCameraUuid(String opUserUuid,String cameraUuids) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_PRESET_INFOS_BY_CAMERA_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("cameraUuid", cameraUuids);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
	public static String getPreviewParamByCameraUuid(String opUserUuid,String cameraUuids, String netZoneUuid) throws Exception{
		String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_PREVIEW_PARAM_BY_CAMERA_UUID;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appkey", APPKEY);//设置APPKEY
		map.put("time", System.currentTimeMillis());//设置时间参数
		map.put("opUserUuid", opUserUuid);//设置操作用户UUID
		map.put("cameraUuid", cameraUuids);//设置操作用户UUID
		map.put("netZoneUuid", netZoneUuid);//设置操作用户UUID
		String params = JSON.toJSONString(map);
		
		String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
		
		return data;
	}
	
}
