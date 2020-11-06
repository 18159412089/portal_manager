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
    <div style="padding:3px;" id="searchBar">
        <select name="categoryParam" id="categoryParam" class="easyui-combobox" data-options="editable:true" label="流程分类:"
                    style="width:250px;">
                <option value="">全部分类11</option>    
                <option value="1">分类1</option>
                <option value="2">分类2</option>
        </select>
        <input name="nameParam" id="nameParam" class="easyui-textbox" label="模块名称:" style="width:200px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
           onclick="doSearch()">查询</a>
    </div>
</div>
<div  style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="code" class="easyui-textbox" required="true" label="申请单号:" style="width:100%">
        </div>
        <#--<div style="margin-bottom:10px">
            <input name="applydate" class="easyui-datebox" required="true" label="申请时间:" style="width:100%">
        </div> -->
        <div style="margin-bottom:10px">
            <input name="applyuse" class="easyui-textbox" required="true" label="采购人:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="采购物品:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="applynumber" class="easyui-textbox" required="true" label="采购数量:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="applyunit" class="easyui-textbox" required="true" label="单位:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="price" class="easyui-textbox" required="true" label="单价:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="total" class="easyui-textbox" required="true" label="总价:" style="width:100%">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveApply()" style="width:90px">提出申请</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    function saveApply() {
     url = Ams.ctxPath + '/apply/apply/save';
     alert(url);
        $('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('reload');
                }
            }
        });
    }
</script>
</body>
</html>