<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
		<#include "/common/loadingDiv.ftl"/>
		<div>
			<div class="search-container">
				<input type="text" style="height: 25px;" class="search-input"/>
				<button type="button" class="search-button"><i class="fa fa-search"></i> 搜索</button>
				<button type="button" class="sync-button"><i class="fa fa-refresh"></i> 同步</button>
			</div>
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
<script src ="${request.contextPath}/static/camera/localMpv.js"></script>
<!-- 选择窗口时间 -->
<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>		
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>	
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>
<script>
$(function(){
	var asynTree = document.getElementById("planTree"); // 异步树
	var zTreeObj = {};
    var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
        view: {
            showIcon: true //设置 zTree 是否显示节点的图标。
        },
        callback: {
			onDblClick: zTreeDblClick
		}
    };
    getCameraList("");
	function getCameraList(searchInput){
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/getCameraList",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			data: JSON.stringify({
				searchInput: searchInput
	        }),
			success: function(data){
				console.log(data);
				if(typeof(zTreeObj.destroy)!='undefined'){
					zTreeObj.destroy();
				}
				zTreeObj = $.fn.zTree.init($("#planTree"), setting, data);
			}
		});
	}
	
	$("button.search-button").click(function(){
		var searchInput = $("input.search-input").val();
		getCameraList(searchInput);
	});
	
	$("button.sync-button").click(function(){
		console.log("开始同步数据");
		var html = '<div id="loadingDiv" style="position: absolute; z-index: 1000; top: 0px; left: 0px; width: 100%; height: 100%; background: white; text-align: center;"><iframe style="border:none;"></iframe><img src="${request.contextPath}/static/plugin/jquery-easyui/themes/default/images/loading.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;width:25px;height:25px;"/></div>';
		$("div.hide-div").append(html);
		$.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/camera/localCameraController/initCameraDataList",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(data){
				if(data.status=="OK"){
					zTreeObj.destroy();
					zTreeObj = $.fn.zTree.init($("#planTree"), setting, JSON.parse(data.list));
				    $("#loadingDiv").fadeOut("normal", function () {
				        $(this).remove();
				    });
				}else{
					alert("同步失败");
				}
			}
		});
	});
});
</script>
</html>
