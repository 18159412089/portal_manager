<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>模型管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div style="padding:3px;" id="toolbar">
        <a href="/work/work/apply" class="easyui-linkbutton" data-options="iconCls:'icon-search'"  >采购申请</a>
    </div>
</div>
<script>
	var isRoot = false;
	<@sec.authorize access="hasRole('ROLE_ROOT')">
	isRoot=true;
	</@sec.authorize>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    
</script>
</body>
</html>