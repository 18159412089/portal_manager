package com.fjzxdz.ams.module.enviromonit.camera.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import com.alibaba.fastjson.JSON;
import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraRegion;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.hikvision.cms.api.common.util.Digests;
import com.hikvision.cms.api.common.util.HttpClientSSLUtils;

import cn.hutool.core.lang.Console;


/**
 * openapi 测试DEMO
 * 客户开发的时候可以参考此代码编写自己的应用
 * 也可以使用demo中的jar包，不过jar包使用务必使用全套，
 * 万不可只取其中一部分，避免依赖破坏
 * @author shengyiling
 *
 */
class OpenApi {
	
	
	/**
	 * APPKEY需要到部署的平台服务器上生成。
	 */
	private static final String APPKEY = "bc3abec3";
	
	/**
	 * SECRET需要到部署的平台服务器上生成。
	 */
	private static final String SECRET = "8395742643a54ea58adefe7651b0e992";
	
	/**
	 * http请求地址
 	 */
	private static final String OPENAPI_IP_PORT_HTTP = "http://27.155.33.126:81";
	
	/**
	 * https请求地址
 	 */
	private static final String OPENAPI_IP_PORT_HTTPS = "https://127.0.0.1:443";
	
	//获取默认用户UUID的接口地址
	private static final String ITF_ADDRESS_GET_DEFAULT_USER_UUID = "/openapi/service/base/user/getDefaultUserUuid";
	//分页获取监控点信息的接口地址
	private static final String ITF_ADDRESS_GET_CAMERAS = "/openapi/service/vss/res/getCameras";
	private static final String ITF_ADDRESS_GET_DEFAULT_UNIT = "/openapi/service/base/org/getDefaultUnit";
	private static final String ITF_ADDRESS_GET_USERS = "/openapi/service/base/user/getUsers";
	//获取平台所有的网域信息
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
	public static String getCameras() throws Exception{
		 String url = OPENAPI_IP_PORT_HTTP + ITF_ADDRESS_GET_CAMERAS;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("appkey", APPKEY);//设置APPKEY
        map.put("time", System.currentTimeMillis());//设置时间参数
        map.put("pageNo", 1);//设置分页参数
        map.put("pageSize", 1000);//设置分页参数
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
        map.put("pageSize", 1000);//设置分页参数
        map.put("opUserUuid", OP_USER_UUID);//设置操作用户UUID
        String params = JSON.toJSONString(map);
        System.out.println(" ====== getCameras请求参数：【" + params + "】");
        String data = HttpClientSSLUtils.doPost(url + "?token=" + Digests.buildToken(url + "?" + params, null, SECRET), params);
        System.out.println(" ====== getCameras请求返回结果：【{" + data + "}】");
        
        return data;
	}


	/**
	 * 测试方法
	 * @param args
	 * @throws Exception
	 */
	public static void mains(String[] args) throws Exception {

		/***http方式调用***/
		/*System.out.println(testGetDefaultUserUUID());
		System.out.println(testGetCameras());*/
		
		/***https方式调用***/
		/*System.out.println(testGetDefaultUserUUID_Https());
		System.out.println(testGetCameras_Https());*/
		
		String opUserUuid = "cc78be40ec8611e78168af26905e6f0f";
		String subSystemCode = "2097152";
		
		//顶级单位
		JSONObject defaultUnit = new JSONObject(getDefaultUnit(opUserUuid,subSystemCode)).getJSONObject("data");
		defaultUnit.put("parentUuid", "");
		//下级所有单位
		JSONArray unitArray = new JSONObject(getUnitsByParentUuid(opUserUuid, defaultUnit.getString("unitUuid"), 0)).getJSONObject("data").getJSONArray("list");
		unitArray.put(defaultUnit);
		List<JSONObject> unitList = new ArrayList<>();
		for(int i=0;i<unitArray.length();i++) {
			JSONObject obj = unitArray.getJSONObject(i);
			CameraUnit unit = new CameraUnit();
			
			unit.setCreateTime(obj.getLong("createTime"));
			unit.setIsParent(obj.getInt("isParent")>0 ? true : false);
			unit.setName(obj.getString("name"));
			unit.setParentUuid((String) obj.get("parentUuid"));
			unit.setRemark(obj.getString("remark"));
			unit.setUnitUuid((String) obj.get("unitUuid"));
			unit.setUpdateTime(obj.getLong("updateTime"));
			
			unitList.add(unit.toJSONObject());
		}
		
		//下级所有单位下的区域
		List<List<JSONObject>> allRegionList = new ArrayList<>();
		List<CameraRegion> tempList = new ArrayList<>();
		for (int i=0;i<unitArray.length();i++) {
			JSONObject obj = unitArray.getJSONObject(i);
			String unitUuid = obj.getString("unitUuid");
			
			JSONArray regionObjArray = new JSONObject(getRegionsByUnitUuid(opUserUuid, unitUuid, 0)).getJSONObject("data").getJSONArray("list");
			
			List<JSONObject> regionList = new ArrayList<>();
			for (int j=0;j<regionObjArray.length();j++) {
				JSONObject regionObj = regionObjArray.getJSONObject(j);
				
				CameraRegion region = new CameraRegion();
				region.setIsParent(regionObj.getInt("isParent")>0 ? true : false);
				region.setName(regionObj.getString("name"));
				region.setParentNodeType(regionObj.get("parentNodeType").toString());
				region.setParentUuid((String) regionObj.get("parentUuid"));
				region.setRegionUuid(regionObj.getString("regionUuid"));
				region.setRemark(regionObj.getString("remark"));
				region.setUpdateTime(regionObj.getLong("updateTime"));
				region.setCreateTime(regionObj.getLong("createTime"));
				
				regionList.add(region.toJSONObject());
				tempList.add(region);
			}
			allRegionList.add(regionList);
		}
		//获取所有摄像头
		List tempCameraList = new ArrayList<>();
		for(int i=0;i<tempList.size();i++) {
			CameraRegion region = tempList.get(i);
			String cameraStr = OpenApi.getCamerasByRegionUuids(opUserUuid, region.getRegionUuid());
			tempCameraList.addAll(new JSONObject(cameraStr).getJSONObject("data").getJSONArray("list").toList());
		}
		List<JSONObject> cameraList = new ArrayList<>();
		for(int i=0;i<tempCameraList.size();i++) {
			Map obj = (Map) tempCameraList.get(i);
			Camera camera = new Camera();
			
			camera.setCameraChannelNum(obj.get("cameraChannelNum").toString());
			camera.setCameraName((String) obj.get("cameraName"));
			camera.setCameraType((String) obj.get("cameraType").toString());
			camera.setCameraUuid((String) obj.get("cameraUuid"));
			camera.setEncoderUuid((String) obj.get("encoderUuid"));
			camera.setKeyBoardCode((String) obj.get("keyBoardCode"));
			camera.setOnLineStatus((Integer) obj.get("onLineStatus")>0 ? true : false);
			camera.setOrderNum((String) obj.get("orderNum").toString());
			camera.setRegionUuid((String) obj.get("regionUuid"));
			camera.setResAuths((String) obj.get("resAuths"));
			camera.setSmartType((String) obj.get("smartType"));
			camera.setSmartSupport(obj.get("smartSupport").toString());
			camera.setUnitUuid((String) obj.get("unitUuid"));
			camera.setUpdateTime((Long) obj.get("updateTime"));
			
			cameraList.add(camera.toJSONObject());
		}
		
		/*JSONArray cameraObjArray = new JSONObject(getCameras()).getJSONObject("data").getJSONArray("list");
		List<JSONObject> cameraList = new ArrayList<>();
		for(int i=0;i<cameraObjArray.length();i++) {
			JSONObject obj = cameraObjArray.getJSONObject(i);
			Camera camera = new Camera();
			
			camera.setCameraChannelNum(obj.get("cameraChannelNum").toString());
			camera.setCameraName(obj.getString("cameraName"));
			camera.setCameraType(obj.get("cameraType").toString());
			camera.setCameraUuid(obj.getString("cameraUuid"));
			camera.setEncoderUuid(obj.getString("encoderUuid"));
			camera.setKeyBoardCode(obj.getString("keyBoardCode"));
			camera.setOnLineStatus(obj.getInt("onLineStatus")>0 ? true : false);
			camera.setOrderNum(obj.get("orderNum").toString());
			camera.setRegionUuid(obj.getString("regionUuid"));
			camera.setResAuths(obj.getString("resAuths"));
			camera.setSmartType(obj.getString("smartType"));
			camera.setSmartSupport(obj.get("smartSupport").toString());
			camera.setUnitUuid(obj.getString("unitUuid"));
			camera.setUpdateTime(obj.getLong("updateTime"));
			
			cameraList.add(camera.toJSONObject());
		}*/

		System.out.println("===================================");
		System.out.println(unitList);
		System.out.println(allRegionList);
		System.out.println(cameraList);
	}

	public static void main(String[] args) throws Exception {
		testMain();
	}
	public static List<JSONObject> testMain() throws Exception {

		String opUserUuid = "cc78be40ec8611e78168af26905e6f0f";
		String subSystemCode = "2097152";
		Integer allChildren = 0;
		// 先查中心或区域
		String data = "";
		JSONObject result = new JSONObject();
		
		data = OpenApi.getDefaultUnit(opUserUuid, subSystemCode);
		result = new JSONObject(data).getJSONObject("data");
		result.put("uuid", result.getString("unitUuid"));
		result.put("nodeType", "1");
		result.put("name", result.getString("name"));
		result.put("isParent",true);
		result.put("iconSkin","data-icon-region");
		result.put("id", result.getString("unitUuid"));
		result.put("pId","");

		List<JSONObject> list = new ArrayList<JSONObject>();
		list.add(result);
		getTreeNode(list, result);

		System.out.println(list);
		return list;
	}


	private static void getTreeNode(List<JSONObject> list, JSONObject treeNode) throws Exception {
		String opUserUuid = "cc78be40ec8611e78168af26905e6f0f";
		String subSystemCode = "2097152";
		Integer allChildren = 0;
		// 先查中心或区域
		String data = "";
		JSONObject result = new JSONObject();
		JSONArray resultArray = new JSONArray();
		JSONObject temp = new JSONObject();
		System.out.println("====================");
		System.out.println(treeNode);

		if (treeNode.getInt("nodeType") == 2){    // 点击的是区域，查区域
			data = OpenApi.getRegionsByParentUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			temp = new JSONObject(data).getJSONObject("data");
			
			if(temp.getInt("total") > 0) {
				JSONArray array = temp.getJSONArray("list");
				//JSONArray childNodes = new JSONArray();
				List<JSONObject> childNodes = new ArrayList<>();
				for(int i=0;i<array.length();i++) {
					JSONObject obj = array.getJSONObject(i);
					obj.put("uuid",obj.get("regionUuid"));
					obj.put("name",obj.get("name"));
					obj.put("nodeType",2);
					obj.put("isParent",true);
					obj.put("iconSkin","data-icon-region");
					
					obj.put("id",obj.get("regionUuid"));
					obj.put("pId",treeNode.getString("uuid"));

					childNodes.add(obj);
					getTreeNode(list, obj);
				}
				
				resultArray.put(childNodes);
				list.addAll(childNodes);
			}
		}else if (treeNode.getInt("nodeType") == 1){	// 点击的是控制中心，查控制中心
			data = OpenApi.getUnitsByParentUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			temp = new JSONObject(data).getJSONObject("data");
			if(temp.getInt("total") > 0) {
				
				JSONArray array = temp.getJSONArray("list");
				//JSONArray childNodes = new JSONArray();
				List<JSONObject> childNodes = new ArrayList<>();

				for(int i=0;i<array.length();i++) {

					JSONObject obj = array.getJSONObject(i);
					obj.put("uuid",obj.get("unitUuid"));
					obj.put("name",obj.get("name"));
					obj.put("nodeType",1);
					obj.put("isParent",true);
					obj.put("iconSkin","data-icon-unit");
					
					obj.put("id",obj.get("unitUuid"));
					obj.put("pId", treeNode.getString("uuid"));
					
					childNodes.add(obj);
					getTreeNode(list, obj);
				}
				
				resultArray.put(result);
				list.addAll(childNodes);
			}
		}
		
		// 再查区域或监控点
		if (treeNode.getInt("nodeType") == 2){  // 当前点击的是区域，查监控点			
			data = OpenApi.getCamerasByRegionUuids(opUserUuid, treeNode.getString("uuid"));
			temp = new JSONObject(data).getJSONObject("data");
			if(temp.getInt("total") > 0) {
				
				JSONArray array = temp.getJSONArray("list");
				//JSONArray childNodes = new JSONArray();
				List<JSONObject> childNodes = new ArrayList<>();
				for(int i=0;i<array.length();i++) {
					JSONObject obj = array.getJSONObject(i);
					obj.put("uuid",obj.get("cameraUuid"));
					obj.put("name",obj.get("cameraName"));
					obj.put("nodeType",3);
					obj.put("isParent",true);
					obj.put("iconSkin","data-icon-camera1");
					
					obj.put("id",obj.get("cameraUuid"));
					obj.put("pId", treeNode.getString("uuid"));
					
					childNodes.add(obj);
					getTreeNode(list, obj);
				}
				
				resultArray.put(childNodes);
				list.addAll(childNodes);
			}
		}else if (treeNode.getInt("nodeType") == 1){  // 当前点击的是中心，查区域
			data = OpenApi.getRegionsByUnitUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			temp = new JSONObject(data).getJSONObject("data");
			if(temp.getInt("total") > 0) {
				
				JSONArray array = temp.getJSONArray("list");
				//JSONArray childNodes = new JSONArray();
				List<JSONObject> childNodes = new ArrayList<>();
				for(int i=0;i<array.length();i++) {

					JSONObject obj = array.getJSONObject(i);
					obj.put("uuid",obj.get("regionUuid"));
					obj.put("name",obj.get("name"));
					obj.put("nodeType",2);
					obj.put("isParent",true);
					obj.put("iconSkin","data-icon-region");
					
					obj.put("id",obj.get("regionUuid"));
					obj.put("pId", treeNode.getString("uuid"));
					
					childNodes.add(obj);
					getTreeNode(list, obj);
				}
				resultArray.put(childNodes);
				list.addAll(childNodes);
			}
		}
	}
}
