 <#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>公共代码</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div class="easyui-layout" fit=true>
    <div id="toolbar">
    </div>
    <table id="tg" class="easyui-treegrid" style="width:100%;"
           url="${request.contextPath}/enviromonit/commonCode/getAllTree"
           idField="id" treeField="name" toolbar="#toolbar" fit=true>
        <thead>
        <tr>
            <th field="name" width="40%">名称</th>
            <th field="code" width="20%">代码</th>
            <!--<th field="status" width="20%" align="left" formatter="Ams.formatEnable">是否启用</th>-->
        </tr>
        </thead>
    </table>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }


</script>
</body>
</html>