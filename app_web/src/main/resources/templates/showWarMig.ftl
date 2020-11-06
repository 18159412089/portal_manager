<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>汇报页-水环境</title>
	
</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<style type="text/css">
		.monitor-container{margin:16px 0;}
		.monitor-container .monitor-title{width: 48px;font-weight: normal;}
	</style>
<div class="container" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;overflow: auto;">
    <div style="width:100%;height:100%" >
		 <img style="width:100%;height:99%" alt="2019年水系作战图" src="${request.contextPath}/static/js/moudles/enviromonit/water/2019年水生态环境作战图.jpg">
    </div>
</div>
<script type="text/javascript">
	$.parser.onComplete = function () {
	    $("#loadingDiv").fadeOut("normal", function () {
	        $(this).remove();
	    });
	};
</script>
</body>

</html>