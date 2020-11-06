package com.fjzxdz.ams.module.deployball.service;

import com.fjzxdz.ams.module.deployball.bean.CameraInfo;
import com.fjzxdz.ams.module.deployball.bean.ControlUnit;
import com.fjzxdz.ams.module.deployball.bean.RegionInfo;
import com.fjzxdz.ams.module.deployball.bean.TreeNode;
import com.fjzxdz.ams.module.deployball.util.DemoUtil;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DemoService {

	private static Map<String, List<?>> map = new HashMap<String, List<?>>();

	private static int offset = 0;
	private static int length = 100;

	private static String url = null;
	private static String cu_url = null;
	private static CloseableHttpClient httpClient;
	//private static boolean flag = false;

	static {
		// url = getUrl();
		// cu_url =getCuUrl();
		// map.put("ControlUnit",getAllControlCenter());
		// map.put("RegionInfo",getAllRegionInfo());
		// map.put("CameraInfo",getCameraInfoPage(offset, length));
	}

	public static String getUrl() {

		StringBuffer urlBuf = new StringBuffer();
		urlBuf.append("http://");
		urlBuf.append(DemoUtil.getPropertyByName(DemoUtil.VMSIPPORT));
		urlBuf.append("/vms/services/OmpService?wsdl");
		return urlBuf.toString();

	}

	public static String getCuUrl() {

		StringBuffer urlBuf = new StringBuffer();
		urlBuf.append("http://");
		urlBuf.append(DemoUtil.getPropertyByName(DemoUtil.VMSIPPORT));
		urlBuf.append("/vms/services/CuService?wsdl");
		return urlBuf.toString();

	}

	public static TreeNode getControlUnitRootTreeNode() {// 获取根节点
		// TODO Auto-generated method stub
		TreeNode rootNode = new TreeNode();
		// List<ControlUnit> controlUnits = (List<ControlUnit>)
		// map.get("ControlUnit");
		// for(ControlUnit controlUnit :controlUnits){
		// if(controlUnit.getParentId()==0){
		// rootNode.setIndexCode(controlUnit.getIndexCode());
		// rootNode.setParentIndexCode("-1"); //设置根节点的父节点编号为-1
		// rootNode.setText(controlUnit.getName());
		// rootNode.setNodeType("controlUnit");
		// rootNode.setOpen(true);
		// rootNode.setIsParent(true);
		// break;
		// }
		// }
		List<TreeNode> treeNodes = getCameraTreeNode("");
		if (treeNodes != null && treeNodes.size() > 0)
			rootNode = treeNodes.get(0);
		return rootNode;
	}

	public static List<TreeNode> getSubChildrenTreeNodeList(
			String controlUnitIndexCode) {// 获取子节点，包括组织、区域、通道
	// // TODO Auto-generated method stub
	// List<TreeNode> treeNodeList = new ArrayList<TreeNode>();
	// List<TreeNode> unitList = getSubUnitTreeNodeList(controlUnitIndexCode);
	// treeNodeList.addAll(unitList);
	// List<TreeNode> regionList =
	// getSubRegionTreeNodeList(controlUnitIndexCode);
	// treeNodeList.addAll(regionList);
	// List<TreeNode> cameraList
	// =getSubCameraTreeNodeList(controlUnitIndexCode);
	// treeNodeList.addAll(cameraList);
	// return treeNodeList;
		List<TreeNode> treeNodes = getCameraTreeNode(controlUnitIndexCode);
		return treeNodes;
	}

	@SuppressWarnings("unchecked")
	private static List<TreeNode> getSubUnitTreeNodeList(
			String controlUnitIndexCode) {// 获取组织子节点，父节点一定是组织

		List<TreeNode> unitChilds = new ArrayList<TreeNode>();
		;

		List<ControlUnit> controlUnits = (List<ControlUnit>) map
				.get("ControlUnit");

		ControlUnit currCon = getCurControlUnitbyCode(controlUnitIndexCode);
		if (currCon != null) {

			for (ControlUnit controlUnit : controlUnits) {

				if (controlUnit.getParentId() == currCon.getControlUnitId()) {// 设置监控中心子类Node

					TreeNode treeNode = new TreeNode();
					treeNode.setIndexCode(controlUnit.getIndexCode());
					treeNode.setText(controlUnit.getName());
					treeNode.setNodeType("controlUnit");
					treeNode.setParentIndexCode(currCon.getIndexCode());
					treeNode.setIsParent(true);
					unitChilds.add(treeNode);

				}

			}
		}
		return unitChilds;
	}

	@SuppressWarnings("unchecked")
	private static List<TreeNode> getSubRegionTreeNodeList(
			String controlUnitIndexCode) {// 获取区域子节点，父节点可能是组织，也可能是区域

		List<TreeNode> regChilds = new ArrayList<TreeNode>();
		List<RegionInfo> RegionInfos = (List<RegionInfo>) map.get("RegionInfo");

		ControlUnit currCon = getCurControlUnitbyCode(controlUnitIndexCode); // 获取当前节点表示的组织，可能为空
		RegionInfo currReg = getRegionbyCode(controlUnitIndexCode); // 获取当前节点表示的区域，可能为空

		if (currCon != null) {// 查找组织下的区域子节点

			for (RegionInfo regionInfo : RegionInfos) {

				if (regionInfo.getParentRegionId() == 0
						&& regionInfo.getControlUnilId() == currCon
								.getControlUnitId()) {

					TreeNode treeNode = new TreeNode();
					treeNode.setIndexCode(regionInfo.getIndexCode());
					treeNode.setText(regionInfo.getName());
					treeNode.setNodeType("region");
					treeNode.setParentIndexCode(currCon.getIndexCode());
					treeNode.setIsParent(true);
					regChilds.add(treeNode);
				}
			}

		} else {
			if (currReg != null) {// 查找区域下的子区域节点
				for (RegionInfo regionInfo : RegionInfos) {

					if (regionInfo.getParentRegionId() == currReg.getRegionId()) {

						TreeNode treeNode = new TreeNode();
						treeNode.setIndexCode(regionInfo.getIndexCode());
						treeNode.setText(regionInfo.getName());
						treeNode.setNodeType("region");
						treeNode.setParentIndexCode(currReg.getIndexCode());
						treeNode.setIsParent(true);
						regChilds.add(treeNode);
					}
				}
			}

		}

		return regChilds;
	}

	// 只有区域子节点才可能为通道
	@SuppressWarnings("unchecked")
	private static List<TreeNode> getSubCameraTreeNodeList(
			String controlUnitIndexCode) {// 获取通道子节点，父节点只能是区域

		List<TreeNode> cameraChilds = new ArrayList<TreeNode>();

		List<CameraInfo> cameraInfos = (List<CameraInfo>) map.get("CameraInfo");

		RegionInfo currReg = getRegionbyCode(controlUnitIndexCode); // 获取当前节点表示的区域，可能为空,（节点若为组织，子节点是区域，不会是通道）

		if (currReg != null) {// 查找区域下的子区域节点
			for (CameraInfo cameraInfo : cameraInfos) {

				if (cameraInfo.getRegionId() == currReg.getRegionId()) {

					TreeNode treeNode = new TreeNode();
					treeNode.setIndexCode(cameraInfo.getIndexCode());
					treeNode.setText(cameraInfo.getName());
					treeNode.setNodeType("camera");
					treeNode.setParentIndexCode(currReg.getIndexCode());
					cameraChilds.add(treeNode);
				}
			}
		}

		return cameraChilds;
	}

	@SuppressWarnings("unchecked")
	private static ControlUnit getCurControlUnitbyCode(
			String controlUnitIndexCode) {// 判断对应节点是否是监控中心并返回

		List<ControlUnit> controlUnits = (List<ControlUnit>) map
				.get("ControlUnit");

		ControlUnit currCon = null;
		for (ControlUnit controlUnit : controlUnits) {

			if (controlUnit.getIndexCode().equals(controlUnitIndexCode)) {
				currCon = controlUnit;
				break;
			}

		}

		return currCon;

	}

	@SuppressWarnings("unchecked")
	private static RegionInfo getRegionbyCode(String controlUnitIndexCode) {// 判断对应节点是否是区域并返回

		List<RegionInfo> RegionInfos = (List<RegionInfo>) map.get("RegionInfo");

		RegionInfo currReg = null;
		for (RegionInfo regionInfo : RegionInfos) {

			if (regionInfo.getIndexCode().equals(controlUnitIndexCode)) {
				currReg = regionInfo;
				break;
			}

		}

		return currReg;

	}

	public static boolean remoteLogin() {
		try {
			//if(!flag){
				String casIpPort = "http://"+DemoUtil.getPropertyByName(DemoUtil.CASIPPORT);
				String username = DemoUtil.getPropertyByName(DemoUtil.USERNAME);
				String password = DemoUtil.getPropertyByName(DemoUtil.PASSWORD);
				String loginUrl = casIpPort + "/cas/remoteLogin?username="
						+ username + "&password=" + password;
				HttpGet loginGet = new HttpGet(loginUrl);
				CloseableHttpResponse response;
				//if (httpClient == null) {
					httpClient = HttpClients.createDefault();
				//}
				response = httpClient.execute(loginGet);
				if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
					//flag = true;
					return true;
				}
			//}
			
		} catch (Exception e) {
			System.err.println(e.getMessage().toString());
		}
		return false;

	}

	public static List<TreeNode> getCameraTreeNode(String cameraIndexCode) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		try {
			String casIpPort = "http://"+DemoUtil.getPropertyByName(DemoUtil.CASIPPORT);
			// String username = "admin";
			// String password =
			// "0770039609d9a6815ace28a50280740eca6f06aba6f1dcd4599837cda6b8d641";
			// String loginUrl =
			// casIpPort+"/cas/remoteLogin?username="+username+"&password="+password;
			String getTreeUrl = casIpPort
					+ "/vas/web/preview!getPreviewTree.action?controlUnitIndexCode="
					+ cameraIndexCode;
			// HttpGet loginGet = new HttpGet(loginUrl);
			CloseableHttpResponse response;
			//if (httpClient == null) {
			//	httpClient = HttpClients.createDefault();
				// response = httpClient.execute(loginGet);
			//}
			remoteLogin();
			// if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
			// 登陆成之后获取树结构
			HttpGet httpGet = new HttpGet(getTreeUrl);
			response = httpClient.execute(httpGet);
			try {
				if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
					HttpEntity entity = response.getEntity();
					if (entity != null) {
						String responseData = EntityUtils.toString(entity,
								"UTF-8");
//						if (responseData.contains("login")) {
//							System.err.println("需要登录");
//							flag = false;
//							remoteLogin();
//							response = httpClient.execute(httpGet);
//							responseData = EntityUtils.toString(entity,
//									"UTF-8");
//						}
						org.json.JSONArray datas = new org.json.JSONArray(
								responseData);
						if (datas != null) {
							for (int i = 0; i < datas.length(); i++) {
								JSONObject jsonObject = (JSONObject) datas
										.get(i);
								TreeNode tmp = new TreeNode();
								tmp.setText(jsonObject.getString("text"));
								tmp.setIndexCode(jsonObject.getString("indexCode"));
								tmp.setParentIndexCode(jsonObject.getString("parentIndexCode"));
								tmp.setNodeType(jsonObject.getString("nodeType"));
								tmp.setOpen(jsonObject.getBoolean("open"));
								tmp.setIsParent(jsonObject.getBoolean("isParent"));
								if("camera".equals(jsonObject.getString("nodeType"))){
									String status = jsonObject.getString("status");
									if("1".equals(status)){
										tmp.setIcon("images/camera_online.png");
									}else{
										tmp.setIcon("images/camera_outline.png");
									}
									/*if(i%2==1){
										tmp.setIcon("images/camera_online.png");
									}else{
										tmp.setIcon("images/camera_outline.png");
									}*/
									
								}
								treeNodes.add(tmp);
								System.out.println("treeNodes111:"+tmp.getIcon());
								
							}
						}

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				response.close();
			}
			// }else{
			// 登陆失败

			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return treeNodes;
	}
	
	
	public static List<TreeNode> getCameraTreeNodeSynChro(String cameraIndexCode) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		try {
			String casIpPort = "http://"+DemoUtil.getPropertyByName(DemoUtil.CASIPPORT);
			String getTreeUrl = casIpPort
					+ "/vas/web/preview!getPreviewTree.action?controlUnitIndexCode="
					+ cameraIndexCode;
			CloseableHttpResponse response;
			if (httpClient == null) {
				remoteLogin();
			}
			// 登陆成之后获取树结构
			HttpGet httpGet = new HttpGet(getTreeUrl);
			response = httpClient.execute(httpGet);
			try {
				if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
					HttpEntity entity = response.getEntity();
					if (entity != null) {
						String responseData = EntityUtils.toString(entity,"UTF-8");
						org.json.JSONArray datas = new org.json.JSONArray(responseData);
						if (datas != null) {
							for (int i = 0; i < datas.length(); i++) {
								JSONObject jsonObject = (JSONObject) datas.get(i);
								TreeNode tmp = new TreeNode();
								tmp.setText(jsonObject.getString("text"));
								tmp.setIndexCode(jsonObject.getString("indexCode"));
								tmp.setParentIndexCode(jsonObject.getString("parentIndexCode"));
								tmp.setNodeType(jsonObject.getString("nodeType"));
								tmp.setOpen(jsonObject.getBoolean("open"));
								tmp.setIsParent(jsonObject.getBoolean("isParent"));
								treeNodes.add(tmp);
							}
						}
						
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				response.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return treeNodes;
	}

}
