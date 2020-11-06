package com.fjzxdz.ams.module.enviromonit.camera.controller;

import cn.fjzxdz.frame.controller.BaseController;
import com.fjzxdz.ams.module.basin.entity.BasinCamera;
import com.fjzxdz.ams.module.basin.entity.BasinRegion;
import com.fjzxdz.ams.module.basin.service.BasinCameraService;
import com.fjzxdz.ams.module.basin.service.BasinRegionService;
import com.fjzxdz.ams.module.deployball.bean.DemoPro;
import com.fjzxdz.ams.module.deployball.bean.TreeNode;
import com.fjzxdz.ams.module.deployball.service.DemoService;
import com.fjzxdz.ams.module.deployball.util.DemoUtil;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraConfig;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraData;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraParam;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraDataService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/camera/localCameraController")
//@Secured({ "ROLE_ADMIN" })
public class LocalCameraController extends BaseController {

	@Autowired
	public CameraDataService cameraDataService;
	@Autowired
	private BasinCameraService basinCameraService;
	@Autowired
	private BasinRegionService basinRegionService;
	@Autowired
	private JdbcTemplate jdbcTemplate ;

	private String opUserUuid = CameraConfig.getInstance().getOpUserUuid();
	private String subSystemCode = CameraConfig.getInstance().getSubSystemCode();
	private List<TreeNode> list = null;

	@RequestMapping("mpv")
	public ModelAndView indexMpv(String pid, ModelAndView modelAndView) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/camera/localCameraMpv");
		return modelAndView;
	}

	@RequestMapping("basin")
	public ModelAndView basinMpv(String pid, ModelAndView modelAndView) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/camera/localCameraBasin");
		return modelAndView;
	}

	@RequestMapping("mpvSingle")
	public String localCameraMpvSingle(String cameraId, Model model) {
		model.addAttribute("cameraId", cameraId);
		return "/moudles/camera/localCameraMpvSingle";
	}

	@RequestMapping(value = "/getCameraList")
	@ResponseBody
	public String getCameraList(@RequestBody CameraParam param) throws Exception {
		List<JSONObject> list = cameraDataService.list(param.getSearchInput());
		
        return new JSONArray(list).toString();
	}


	@RequestMapping("getLocationTree")
	@ResponseBody
	public String getLocationTree(@RequestBody String jsonStr) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject(jsonStr);
		String indexCode = "";
		if(jsonObject.has("indexCode")) {
			indexCode = jsonObject.getString("indexCode");
		}
		String name = "";
		if(jsonObject.has("name")){
			name = jsonObject.getString("name");
		}
		String queryStr = "";
		if(!"".equals(name)){
			queryStr =  " SELECT " +
					"  A .UUID, " +
					"  A .INDEX_CODE, " +
					"  A .PARENT_INDEX_CODE, " +
					"  A . NAME, " +
					"  'camera' AS NODE_TYPE, " +
					"  'false' AS OPEN, " +
					"  'false' AS IS_PARENT, " +
					"  'true' AS STATUS, " +
					"  'images/camera_online.png' AS ICON " +
					" FROM BASIN_CAMERA A " +
					" WHERE  A .NAME LIKE '%"+name+"%'";
		}else if (indexCode==null || indexCode.length()==0) {
			String operatorCode = "0";
			queryStr = "SELECT a.UUID," +
									"a.INDEX_CODE," +
									"a.PARENT_INDEX_CODE," +
									"a.NAME ," +
									"'controlUnit' AS NODE_TYPE," +
									" 'false' AS OPEN," +
									"'true' AS IS_PARENT," +
									"'true' AS STATUS" +
								" FROM BASIN_REGION a" +
								" WHERE INDEX_CODE = "+operatorCode;
		}else{
			queryStr = "SELECT " +
						" A .UUID, " +
						" A .INDEX_CODE, " +
						" A .PARENT_INDEX_CODE, " +
						" A . NAME, " +
						" A . TYPE AS NODE_TYPE, " +
						" 'false' AS OPEN, " +
						" 'true' AS IS_PARENT, " +
						" 'true' AS STATUS, " +
						" '' AS ICON " +
					" FROM  BASIN_REGION A " +
					" WHERE  A .PARENT_INDEX_CODE = "+indexCode +
					" UNION ALL " +
					" SELECT " +
						"  A .UUID, " +
						"  A .INDEX_CODE, " +
						"  A .PARENT_INDEX_CODE, " +
						"  A . NAME, " +
						"  'camera' AS NODE_TYPE, " +
						"  'false' AS OPEN, " +
						"  'false' AS IS_PARENT, " +
						"  'true' AS STATUS, " +
						"  'images/camera_online.png' AS ICON " +
					" FROM BASIN_CAMERA A " +
					" WHERE A .PARENT_INDEX_CODE = "+indexCode;
		}
		List<Map<String, Object>> listPage = jdbcTemplate.queryForList(queryStr);
		for(Map<String, Object> objectMap:  listPage){
			JSONObject result = new JSONObject();
			result.put("uuid",objectMap.get("UUID"));
			result.put("id",objectMap.get("INDEX_CODE"));
			result.put("pId",objectMap.get("PARENT_INDEX_CODE"));
			result.put("name",objectMap.get("NAME"));
			result.put("nodeType",objectMap.get("NODE_TYPE"));
			result.put("OPEN",objectMap.get("OPEN"));
			result.put("isParent",objectMap.get("IS_PARENT"));
			result.put("status",objectMap.get("STATUS"));
			result.put("icon",objectMap.get("ICON"));
			jsonArray.put(result);
		}
		return jsonArray.toString();
	}
	@RequestMapping("getProperties")
	@ResponseBody
	public String getProperties() throws Exception{//该方法用于把属性文件对应参数给前台
		DemoPro demo = new DemoPro();
		String innerIpStr = DemoUtil.getPropertyByName(DemoUtil.INNERIP);
		demo.setUsername(DemoUtil.getPropertyByName(DemoUtil.USERNAME));
		demo.setPassword(DemoUtil.getPropertyByName(DemoUtil.PASSWORD));
		demo.setCasIpPort(DemoUtil.getPropertyByName(DemoUtil.CASIPPORT));
		demo.setVasIpPort(DemoUtil.getPropertyByName(DemoUtil.VASIPPORT));
		demo.setVmsIpPort(DemoUtil.getPropertyByName(DemoUtil.VMSIPPORT));

		return new JSONObject(demo).toString();
	}

	@RequestMapping("synchroData")
	@ResponseBody
	public String synchroData() throws Exception {

		//获取根节点
		List<TreeNode> treeNodes = DemoService.getCameraTreeNodeSynChro("");
		TreeNode rootTreeNode = treeNodes.get(0);
		//递归方法 获取所有节点信息
		list = new ArrayList<TreeNode>();
		this.getList(rootTreeNode);
		for(TreeNode treeNode:list){
			if("camera".endsWith(treeNode.getNodeType())){
				this.saveCamera(treeNode);
			}else{
				this.saveRegion(treeNode);
			}
		}
		JSONObject msg = new JSONObject();
		msg.put("status", "OK");
		return msg.toString();
	}


	private void saveRegion(TreeNode treeNode) throws Exception {

		String name = modifyStr(treeNode.getText());
		String indexCode = treeNode.getIndexCode();
		String parentIndexCode = treeNode.getParentIndexCode();
		String type = treeNode.getNodeType();
		Double longitude = null;
		Double latitude =  null;
		String place =  null;
		BasinRegion basinRegion = new BasinRegion();
		basinRegion.setIndexCode(indexCode);
		basinRegion.setParentIndexCode(parentIndexCode);
		basinRegion.setName(name);
		basinRegion.setType(type);
		String queryStr = "select * from BASIN_REGION where INDEX_CODE=" + indexCode;
		List<Map<String, Object>> listPage = jdbcTemplate.queryForList(queryStr);
		if(listPage.size()==0){
			basinRegionService.save(basinRegion);
		}
	}

	public void saveCamera(TreeNode treeNode)
			throws Exception {

		String name = treeNode.getText();
		String indexCode = treeNode.getIndexCode();
		String parentIndexCode = treeNode.getParentIndexCode();
		Double longitude = null;
		Double latitude =  null;
		String place =  null;
		BasinCamera basinCamera = new BasinCamera();
		basinCamera.setIndexCode(indexCode);
		basinCamera.setParentIndexCode(parentIndexCode);
		basinCamera.setName(name);
		String queryStr = "select * from BASIN_CAMERA where INDEX_CODE=" + indexCode;
		List<Map<String, Object>> listPage = jdbcTemplate.queryForList(queryStr);
		if(listPage.size()==0){
			basinCameraService.save(basinCamera);
		}
	}

	private String modifyStr(String str)throws Exception {
		String subStr = str.substring(0, str.indexOf("(")).trim() ;
		return subStr;
	}




	@RequestMapping(value = "/getPreviewParamByCameraUuid")
	@ResponseBody
	public String getPreviewParamByCameraUuid(@RequestBody CameraParam param) throws Exception {
		String data = OpenApi.getPreviewParamByCameraUuid(opUserUuid, param.getCameraUuids(), param.getNetZoneUuid());
		JSONObject result = new JSONObject(data);
		
		return result.toString();
	}

	@RequestMapping(value = "/getNetZones")
	@ResponseBody
	public String getNetZones() throws Exception {
		String data = OpenApi.getNetZones(opUserUuid);
		JSONObject result = new JSONObject(data);

		return result.toString();
	}
	
	//===================同步数据开始====================
	
	@RequestMapping("initCameraDataList")
	@ResponseBody
	public String initCameraDataList() throws Exception {
		List<CameraData> cameraDataList = getCameraDataList();
		
		JSONObject msg = new JSONObject();
		if(cameraDataList.size()>0) {
			cameraDataService.deleteAll();
			cameraDataService.saveBatch(cameraDataList);
			
			List<JSONObject> list = cameraDataService.list("");
			
			msg.put("status", "OK");
			msg.put("list", new JSONArray(list).toString());
		}else {
			msg.put("status", "ERROR");
		}
		
		return msg.toString();
	}

	private List<CameraData> getCameraDataList() throws Exception {
		// 先查中心或区域
		String defaultUnit  = OpenApi.getDefaultUnit(opUserUuid, subSystemCode);
		JSONObject result = new JSONObject(defaultUnit).getJSONObject("data");
		result.put("uuid", result.getString("unitUuid"));
		result.put("nodeType", "1");
		result.put("name", result.getString("name"));
		result.put("isParent",true);
		result.put("iconSkin","data-icon-region");
		result.put("id", result.getString("unitUuid"));
		result.put("pId","");

		List<JSONObject> list = new ArrayList<JSONObject>();
		list.add(result);
		getTreeNode(list, result,opUserUuid, subSystemCode);
		
		List<CameraData> cameraDataList = new ArrayList<>();
		for (JSONObject obj : list) {
			CameraData cameraData = new CameraData();
			
			cameraData.setId(obj.getString("id"));
			cameraData.setpId(obj.getString("pId"));
			cameraData.setName(obj.getString("name"));
			cameraData.setNodeType(String.valueOf(obj.getInt("nodeType")));
			cameraData.setIsParent((Boolean) obj.get("isParent"));
			cameraData.setIconSkin(obj.getString("iconSkin"));
			
			cameraDataList.add(cameraData);
		}

		System.out.println(list);
		System.out.println("摄像头数据初始化完成");
		
		return cameraDataList;
	}

	/**
	 * 必须按照此种方式获取数据，因为获取摄像头数据的接口会将摄像头相应的父节点一同取出
	 * @param list
	 * @param treeNode
	 * @param opUserUuid
	 * @param subSystemCode
	 * @throws Exception
	 */
	private void getTreeNode(List<JSONObject> list, JSONObject treeNode,String opUserUuid, String subSystemCode) throws Exception {
		Integer allChildren = 0;
		// 先查中心或区域
		String data = "";
		JSONObject tempData = new JSONObject();

		if (treeNode.getInt("nodeType") == 2){    // 点击的是区域，查区域
			data = OpenApi.getRegionsByParentUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			tempData = new JSONObject(data).getJSONObject("data");
			
			if(tempData.getInt("total") > 0) {
				JSONArray array = tempData.getJSONArray("list");
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
					getTreeNode(list, obj,opUserUuid, subSystemCode);
				}
				
				list.addAll(childNodes);
			}
		}else if (treeNode.getInt("nodeType") == 1){	// 点击的是控制中心，查控制中心
			data = OpenApi.getUnitsByParentUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			tempData = new JSONObject(data).getJSONObject("data");
			if(tempData.getInt("total") > 0) {
				
				JSONArray array = tempData.getJSONArray("list");
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
					getTreeNode(list, obj,opUserUuid, subSystemCode);
				}
				
				list.addAll(childNodes);
			}
		}
		
		// 再查区域或监控点
		if (treeNode.getInt("nodeType") == 2){  // 当前点击的是区域，查监控点			
			data = OpenApi.getCamerasByRegionUuids(opUserUuid, treeNode.getString("uuid"));
			tempData = new JSONObject(data).getJSONObject("data");
			if(tempData.getInt("total") > 0) {
				JSONArray array = tempData.getJSONArray("list");
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
					getTreeNode(list, obj,opUserUuid, subSystemCode);
				}
				
				list.addAll(childNodes);
			}
		}else if (treeNode.getInt("nodeType") == 1){  // 当前点击的是中心，查区域
			data = OpenApi.getRegionsByUnitUuid(opUserUuid, treeNode.getString("uuid"), allChildren);
			tempData = new JSONObject(data).getJSONObject("data");
			if(tempData.getInt("total") > 0) {
				JSONArray array = tempData.getJSONArray("list");
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
					getTreeNode(list, obj,opUserUuid, subSystemCode);
				}
				list.addAll(childNodes);
			}
		}
	}
	//===================同步数据结束====================
	private void getList(TreeNode treeNode){
		//List<TreeNode> childrenNodeList = DemoService.getSubChildrenTreeNodeList(treeNode.getIndexCode());
		List<TreeNode> childrenNodeList = DemoService.getCameraTreeNodeSynChro(treeNode.getIndexCode());
		for(TreeNode childNode :  childrenNodeList){
			this.getList(childNode);
		}
		list.add(treeNode);
	}
}
