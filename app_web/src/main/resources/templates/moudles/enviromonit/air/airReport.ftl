<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>汇报</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>

<style>
	div.tdt-infowindow-content-wrapper{
		background-color: rgba(50, 50, 50, 0.7);
	}
	.ul:hover{ cursor:pointer}
	
	#AQIRanking .map-panel-body{height: 548px;}
	#cityAQI .map-panel-body{height: 548px;}
	#cityPanel{height: 300px;}
	/*------------------------------------------------------响应式----------------------------------------------------------*/
	@media screen and (max-width: 1440px) {
		#AQIRanking .map-panel-body{height: 448px;}
		#add{height: 407px;}		
		#cityAQI .map-panel-body{height: 448px;}
		#cityPanel{height: 250px;}
	}
	
</style> 

<#include "/toolbar.ftl">

<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
   <!-- main -->
	<div id="mapDiv" class="map-wrapper" style="position:fixed;bottom:0;"></div>
	
	<div style="position: fixed; top: 100px; right: 50px;"><a target="_blank" href="${request.contextPath}/static/js/moudles/enviromonit/air/中央环保督察整改工作情况.pdf">文档</a></div>
</div>

<!-- 修改用户密码窗口 -->
<#include "/passwordModify.ftl"/>

<div id="detail" class="easyui-window" title="介绍" c class="easyui-dialog" style="width:800px;height:450px;background:#fff;top:100px;padding:10px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
</div>     


<script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/airReport.js"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    $(window).resize(function () {
    });
    $(function(){
    	map = new T.Map("mapDiv");
    	var markerInfoWin = new T.InfoWindow("11",{offset:new T.Point(0,-30)});
		size = map.getZoom();
		//设置显示地图的中心点和级别
		map.centerAndZoom(new T.LngLat(117.65,24.52), 8.5);
		var ctrl = new T.Control.MapType({position:T_ANCHOR_BOTTOM_RIGHT});
		map.addControl(ctrl);
		layNoFireworksArea(map);
    });
</script>

</body>

</html>