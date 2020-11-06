<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>漳州市流域监控管理系统</title>
	<#include "/header.ftl"/>
	<link rel="stylesheet" href="${request.contextPath}/static/camera/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="${request.contextPath}/static/camera/css/icon.css" type="text/css">
	<style>
		#pf-hd {
		    height: 70px;
		    position: relative;
		    z-index: 2;
		    background: url('images/main/top_bottombg.png?1464006836') left bottom repeat-x;
		        background-color: rgba(0, 0, 0, 0);
		    background-color: #3fa15a;
		}
		#pf-hd .pf-logo {
		    float: left;
		    padding: 0 15px;
		    height: 100%;
		    min-width: 230px;
		    
		    line-height: 70px;
		    color: #ffffff;
		    font-size: 24px;
		}
		#pf-hd .pf-logo img {
		    vertical-align: middle;
		    margin-left: -10px;
		}
		.ztree li a{color:#fff;}

		.search-button,.sync-button {
			 font-size:12px;
			 text-align:center;
			 padding:0px;
			 vertical-align:middle ;
			 line-height:22px;
			 margin:0px;
			 Height:26px;
			 Width:60px;
		}
		.txt {
			border:1px #6699CC solid;
			height:30px;
			width:160px;
			margin:0px;
			vertical-align:middle;
			font-size:12px;
			padding:0px 2px;
			line-height :16px;
		}
	</style>
</head>
<!-- body -->
<body>
	<div id="pf-hd">
		<span class="pf-logo">
	   		<img src="/static/images/blocks1.png" align="absmiddle"> 漳州市重点污染源视频管理系统
	    </span>
	</div>
	<div style="position: absolute;top:70px;bottom: 0px;left:0px;right: 0px;background:#333;color:#fff;">
		<div class="hide-div">
			<div style='display:none;'>
				userName:<select id="SelectUser" name="user"  style="width:152px"></select>
				netZone:<select id="SelectNet" name="net" style="width:152px"></select>
			</div>
			<div style='display:none;'>
				预览类型：
				<select id="PlayType" style="width:100pix">
					<option value="0" selected="true">空闲窗口预览</option>
					<option value="1">选中窗口预览</option>
					<option value="2">指定窗口预览</option>
				</select>
				<select id="seledWndIndex" style="width:40px"></select>
			</div>
		</div>
		<div>
			<div class="search-container">
				<input type="text" style="height: 25px;" class="search-input"/>
				<button type="button" class="search-button"><i class="fa fa-search"></i> 搜索</button>
				<button type="button" class="sync-button"><i class="fa fa-refresh"></i> 同步</button>
			</div>
		</div>
		<input type="hidden" id="vasIpPort" />
		<input type="hidden" id="casIpPort" />
		<input type="hidden" id="userName" />
		<input type="hidden" id="password" />
		<div class="tree" style="width:250px;height:100%;float:left;overflow:auto;">
			<ul id="planTree" class="ztree" width="100%"></ul>
		</div>
		<!-- style="Margin-left:tree.width -->
		<#--<div class="ActiveX" style="overflow:hidden;height:100%; ">
			<object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
		</div>-->
		<div style="position: absolute; top: 0px; left: 400px; bottom: 0px; right: 0px">
			<iframe id="view" name="view" width="0%" height="0%" scrolling="no" frameborder="0"></iframe>
		</div>
	</div>
</body>
<!-- zTree  这里使用的 all.js = core + excheck + exedit ( 不包括 exhide )-->
<script src="${request.contextPath}/static/camera/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script>
	var zTreeObj = null;
	var setting = {
		view: {
			showIcon: true //设置 zTree 是否显示节点的图标。
		},
		callback: {
			onClick: zTreeClick,
			onExpand:zTreeClick
		}
	};
	var treeNodes;
	$(function(){
		getLocationTree(null);
		getProperties();
	});
	function getLocationTree(treeNode){
		var indexCode = "";
		if(treeNode != null){
			indexCode = treeNode.id;
		}
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/getLocationTree",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			data: JSON.stringify({
				indexCode: indexCode
			}),
			success: function(data){
				treeNodes = data;
				if(zTreeObj == null){
					zTreeObj = $.fn.zTree.init($("#planTree"), setting, treeNodes);
				}else{
					zTreeObj.addNodes(treeNode,treeNodes);
				}
			}
		});
	}

	function getSearchTree(treeNode){
		var name = "";
		if(treeNode != null){
			name = treeNode.name;
		}
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/getLocationTree",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			data: JSON.stringify({
				name : name
			}),
			success: function(data){
				treeNodes = data;
				zTreeObj.destroy();
				zTreeObj = $.fn.zTree.init($("#planTree"), setting, treeNodes);
			}
		});
	}

	function getProperties() {//获取hikdemo.properties属性文件里面的配置
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/getProperties",
			success: function(data){
				$("#vasIpPort").val(JSON.parse(data).vasIpPort);
				$("#casIpPort").val(JSON.parse(data).casIpPort);
				$("#userName").val(JSON.parse(data).username);
				$("#password").val(JSON.parse(data).password);
			}
		});
	}

	$("button.search-button").click(function(){
		var searchInput = $("input.search-input").val();
		var searchTreeNode = {};
		searchTreeNode.name = searchInput;
		getSearchTree(searchTreeNode)
	});


	$("button.sync-button").click(function(){
		console.log("开始同步数据");
		var html = '<div id="loadingDiv" style="position: absolute; z-index: 1000; top: 0px; left: 0px; width: 100%; height: 100%; background: white; text-align: center;"><iframe style="border:none;"></iframe><img src="${request.contextPath}/static/plugin/jquery-easyui/themes/default/images/loading.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;width:25px;height:25px;"/></div>';
		$("div.hide-div").append(html);
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/synchroData",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(data){
				if(data.status=="OK"){
					zTreeObj.destroy();
					getLocationTree("");
					$("#loadingDiv").fadeOut("normal", function () {
						$(this).remove();
					});
				}else{
					alert("同步失败");
				}
			}
		});
	});

	function zTreeClick(event, treeId, treeNode, clickFlag) {//节点单击事件
		if (treeNode.nodeType == "camera") {//节点为通道才能触发
			playView(treeNode.id);
		}else{
			if(typeof(treeNode.children) =='undefined' || treeNode.children == null)
				getLocationTree(treeNode);
		}
	}

	//对得到的json数据进行过滤，加载树的时候执行
	function filter(treeId, parentNode, responseData) {
		alert(JSON.stringify(responseData));
		var contents = (responseData.content) ? responseData.content
				: responseData;
		return eval(contents.data);

	};
	function playView(indexCodes) {//调用预览的url
		console.log($("#userName").val());
		var playViewUrl;
		var playViewUrlArr = new Array();
		var playCodeUrl;
		var playCodeUrlArr = new Array();

		playViewUrlArr.push("http://");
		playViewUrlArr.push($("#casIpPort").val());
		//playViewUrlArr.push("172.1.1.2:82");
		playViewUrlArr.push("/cas/remoteLogin?username=");
		playViewUrlArr.push($("#userName").val());
		playViewUrlArr.push("&password=");
		playViewUrlArr.push($("#password").val());
		playViewUrlArr.push("&service=");

		playCodeUrlArr.push("http://");
		playCodeUrlArr.push($("#vasIpPort").val());
		playCodeUrlArr
				.push("/vas/web/previewCtrl.action?cameraIndexCodes=");
		playCodeUrlArr.push(indexCodes);
		playCodeUrlArr.push("&wndNum=1&previewType=1");

		playCodeUrl = playCodeUrlArr.join("");
		playCodeUrl = encodeURIComponent(playCodeUrl)

		playViewUrlArr.push(playCodeUrl);
		playViewUrl = playViewUrlArr.join("");
		//setTimeout("window.frames['view'].location.href = '"+playViewUrl+"' ;",1000);
		//window.frames["view"].location.href = playViewUrl;
		window.open(playViewUrl,'视频预览',"height=800, width=1000, top=100, left=400,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
	}
</script>
</html>
