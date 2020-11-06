<#ftl attributes={ "content_type":"text/html;charset=UTF-8"}> <#assign
	sec=JspTaglibs[ "http://www.springframework.org/security/tags"] />
<html lang="en">
<head>
<title>${titleName}</title>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
	<div id="pf-bd">
		<!-- tab -->
		<div id="pf-sider">
			<h2 class="pf-model-name">
				<span class="iconfont">&#xe64a;</span> <span class="pf-name">菜单</span>
				<span class="toggle-icon"></span>
			</h2>

			<div id="nav" class="easyui-accordion" border="false">
		    </div>
			<input type="hidden" id="type" value="${type!}" /> 
			<input type="hidden" id="pointCode" value="${pointCode!}" />
			<input	type="hidden" id="category" value="${category!}" /> 
			<input type="hidden" id="startTime" value="${startTime!}" /> 
			<input type="hidden" id="endTime" value="${endTime!}" />
		</div>
		<!-- main -->
		<div id="pf-page">
			<div id="tabs" class="easyui-tabs1" border="false"
				style="height: 100%;">
			</div>
		</div>
	</div>
	<!-- menu -->
	<div id="mm" class="easyui-menu" style="width: 150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
	</div>
	<script src='${request.contextPath}/static/js/main.js'></script>
	<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
</script>
</body>
</html>