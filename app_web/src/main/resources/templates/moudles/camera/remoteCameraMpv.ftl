<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>漳州市重点污染源视频管理系统</title>
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
		<#include "/common/loadingDiv.ftl"/>
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
		<div class="tree" style="width:250px;height:100%;float:left;overflow:auto;">
			<ul id="planTree" class="ztree" width="100%"></ul>
		</div>
		<!-- style="Margin-left:tree.width -->
		<div class="ActiveX" style="overflow:hidden;height:100%; ">
			<object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
		</div>	
	</div>
</body>
<script type="text/javascript" src="${request.contextPath}/static/camera/md5.js"></script>
<!-- zTree  这里使用的 all.js = core + excheck + exedit ( 不包括 exhide )-->
<script src="${request.contextPath}/static/camera/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script src ="${request.contextPath}/static/camera/remoteMpv.js"></script>
<!-- 选择窗口时间 -->
<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>		
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>
</html>
