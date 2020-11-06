<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>多路预览</title> <#include "/header.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/testing.css">

<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/upload/webuploader.css">
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css" />
<link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css" />
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css" />
<link rel="stylesheet" href="${request.contextPath}/static/css/progressbar.css" />
<script src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script src="${request.contextPath}/static/upload/webuploader.js"></script>
<script src='${request.contextPath}/static/js/fileUpload.js'></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>

<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css" />

<!-- camera -->
<link rel="stylesheet" href="${request.contextPath}/static/camera/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${request.contextPath}/static/camera/css/icon.css" type="text/css">
<script type="text/javascript" src="${request.contextPath}/static/camera/md5.js"></script>
<!-- zTree  这里使用的 all.js = core + excheck + exedit ( 不包括 exhide )-->
<script src="${request.contextPath}/static/camera/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script src ="${request.contextPath}/static/camera/mpv.js"></script>
</head>
<!-- body -->
<body> 
	<div style="width:1300px;float:left">
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
		<div class="tree" style="width:250px;float:left">
			<ul id="planTree" class="ztree" width="100%"></ul>
		</div>
		<!-- style="Margin-left:tree.width -->
		<div class="ActiveX" style="Margin-left:tree.width">
			<object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv"  width="1000px" height="600px" ></object>
		</div>	
	</div>
</body>

<!-- 选择窗口时间 -->
<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>		
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>

</html>
