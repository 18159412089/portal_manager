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
		<!-- style="Margin-left:tree.width -->
		<div class="ActiveX" style="overflow:hidden;height:100%; ">
			<object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
		</div>	
	</div>
</body>
<script type="text/javascript" src="${request.contextPath}/static/camera/md5.js"></script>
<script src ="${request.contextPath}/static/camera/localMpv.js"></script>
<!-- 选择窗口时间 -->
<#--<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>-->
<script>
var cameraId = '${cameraId}';
$(function(){
    // 获取网域信息
    GetNetZones();  //主要是获取netZoneUuid的值，该变量在localMpv.js中第一行定义，一般是固定值：ab0247042b0f44259e02c2024f351ab9
    //隐藏下方的工具栏
    HideMainToolBar();
    //初始化预览窗口
    InitSpvx();
    SetWnd(1);

    //延迟执行，以确保获取到netZoneUuid和初始化预览窗口
    setTimeout(function(){
        var jsonData = JSON.stringify({
            opUserUuid: "cc78be40ec8611e78168af26905e6f0f", //该参数固定
            cameraUuids: cameraId,    //根据需要传入的摄像头ID
            netZoneUuid: myNetZoneUuid //该变量在localMpv.js中第一行定义
        });
        getPreviewParamByCameraUuid(jsonData);
	},1000);

    function getPreviewParamByCameraUuid(jsonDataStr){
        $.ajax({
            type: "POST",
            url:  Ams.ctxPath + "/camera/localCameraController/getPreviewParamByCameraUuid",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: jsonDataStr,
            success: function(xml){
                // 调OCX单路预览接口
                var spvxOcx = document.getElementById("spv");
                if (xml.data){
                    var ret = 0;
                    var opt = parseInt($("#PlayType option:selected").val(), 10);
                    switch (opt){
                        case 0:
                            ret = spvxOcx.MPV_StartPreview(xml.data);
                            break;
                        case 1:
                            ret = spvxOcx.MPV_StartPreviewBySelectedWnd(xml.data);
                            break;
                        case 2:
                            var vWndIndex = $('#seledWndIndex option:selected').val();
                            ret = spvxOcx.MPV_StartPreviewByWndIndex(xml.data, parseInt(vWndIndex, 10));
                            break;
                        default:
                            return ;
                    }
                    if (ret != 0) {
                        alert("预览失败：" + xml.data);
                    }
                }else{
                    var vDesc = "查询预览参数失败，" + xml.errorMessage + ",错误码为：" + xml.errorCode;
                    alert(vDesc);
                }
            },
            error: function(data){
                console.log(data);
            }
        });
	}
});
</script>
</html>
