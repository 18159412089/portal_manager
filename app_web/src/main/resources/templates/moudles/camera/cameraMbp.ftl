<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>多路回放</title> <#include "/header.ftl"/>

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
<script src ="${request.contextPath}/static/camera/mpb.js"></script>
</head>
<!-- body -->
    <body> 
		<div style="width:1000px;float:left">
			<div style="text-align:left;background-color: #C0C0C0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp多路回放:请先填入appKey和secret，然后点击"加载数据"按钮获取用户、网域以及组织资源数据，然后点"初始化"按钮初始化控件</div>
			<br />
			<div style="padding: 1px; margin: 1px;">
				startTime:&nbsp;<input id="startTime" type="text" value="" />&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;endTime:&nbsp;<input id="endTime" type="text" value="" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;appKey:&nbsp;<input id="appKey" type="text" value="bc3abec3" />&nbsp;&nbsp;&nbsp; 
				&nbsp;&nbsp;<input type="button" onclick="InitData()" value="加载数据" />
			</div>
			<div>	
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;secret:&nbsp;<input id="secret" type="text" value="8395742643a54ea58adefe7651b0e992" />&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;userName:&nbsp;<select id="SelectUser" name="user"  style="width:152px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;netZone:&nbsp;<select id="SelectNet" name="net" style="width:152px"></select>
			</div>
			<br />
			<div>
				<input type="button" onclick="InitSpb()" value="初始化" />
				&nbsp;&nbsp;<input type="button" onclick="SetLocalParam()" value="设置本地参数" />
				&nbsp;&nbsp;<input type="button" onclick="stopAllPlayback()" value="停止所有回放" />
				&nbsp;&nbsp;<input type="button" onclick="UninitSpb()" value="反初始化" />
				&nbsp;&nbsp;<input type="button" onclick="SetToolBar()" value="设置播放窗口工具条按钮">
				&nbsp;按钮ID：<input id="tbar" type="text" value="0,1,2,3,4">
			</div>
			<div>
			<input type="button" onclick="SetWnd()" value="设置窗口数"/>
				&nbsp;窗口数：<select id="SetWnd" name="setwnd" style="width:50px">
					<option value = "1">1</option>
					<option value = "4">4</option>
					<option value = "9">9</option>
					<option value = "16">16</option>
				</select>
				&nbsp;&nbsp;<input type="button" onclick="GetWnd()" value="获取窗口数" />
				&nbsp;&nbsp;<input type="button" onclick="SnapPic()" value="回放抓图">
				&nbsp;&nbsp;回放类型：<select id="PlayType" style="width:100pix">
					<option value="0" selected="true">空闲窗口回放</option>
					<option value="1">选中窗口回放</option>
					<option value="2">指定窗口回放</option>
				</select>
				&nbsp;<select id="seledWndIndex" style="width:80px">
				</select>
			</div>
			<div>
				<div class="tree" style="width:250px;float:left">
					<ul id="planTree" class="ztree" width="100%" />
				</div>
				<div class="ActiveX" style="Margin-left:tree.width">
					<td>
						<object classid="clsid:863E7B58-A280-40A5-8394-CE33F4E7B654" id="spb"  width="700px" height="600px" />
					</td>
				</div>	
			</div>
		</div>
    </body>
	<!-- <script type="text/javascript">
		$(function() {
			$.ajax({
				type: "POST",
				url:  Ams.ctxPath + "/camera/getDefaultUserUUID",
				dataType: "json",
				success: function(result){
					console.log(result);
				}
			});
		});
	</script> -->
	<script language="javascript" for="spb" event="MPB_FireSelectWndIndex(lWndId, cameraUuid)"> 
		szMsg = "窗口:" + lWndId + ":" + cameraUuid;  
		alert(szMsg);
	</script>		
	<script language="javascript" for="spb" event="MPB_FirePlaybackResult(lWndId, lPlaybackResult)"> 
		szMsg = "回放窗口" + lWndId; 
		if (1 == lPlaybackResult)
		{
			szMsg += "开始回放";
		}
		else if(2 == lPlaybackResult)
		{
			szMsg += "停止回放";
		}
		alert(szMsg);
	</script>
	<script language="javascript" for="spb" event="MPB_FireSnapShot(lWndIndex,lpPicName,lpCameraUUID,lSnapResult)"> 
		if(lSnapResult == 1){
			alert("窗口" + lWndIndex + "抓图成功：" + lpPicName);
		}
		else
		{
			alert("窗口" + lWndIndex + "抓图失败");
		}
	</script>
</html>
