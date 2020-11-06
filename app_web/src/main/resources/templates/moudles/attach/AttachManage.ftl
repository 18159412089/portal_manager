<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>文件管理</title>
</head>
<body >
	<#include "/common/loadingDiv.ftl"/>
	<#include "/decorators/header.ftl"/>
	<#include "/toolbar.ftl">

<!-- datagrid -->
<div class="easyui-layout" fit=true style="margin-top:70px;">
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <input id="queryName" name="queryName" class="easyui-textbox" label="项目名称:" style="width:200px;">
	            <select name="queryStatus" id="queryStatus" label="项目进度:" class="easyui-combobox" style="width:200px">
	                <option value="" selected="selected">全部状态</option>
	                <option value="0">滞后</option>
	                <option value="1">整治中</option>
	                <option value="2">完成</option>
	            </select>
	            <select name="queryEnable" id="queryEnable" class="easyui-combobox" label="启用/禁用:" style="width:200px;">
	                <option value="" selected="selected">全部状态</option>
	                <option value="1">启用</option>
                	<option value="0">禁用</option>
	            </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newOne()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editOne()">修改</a>
        </@sec.authorize>
    </div>
    
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/environment/debriefing/list" data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="name" width="120px" formatter="Ams.tooltipFormat">项目名称</th>
            <th field="picture" width="120px" formatter="imgFormatter">图片预览</th>
            <th field="status" width="120px" formatter="Ams.formatDebriefing">进度</th>
            <th field="longitude" width="120px" formatter="Ams.tooltipFormat">经度</th>
            <th field="latitude" width="120px" formatter="Ams.tooltipFormat">纬度</th>
            <th field="enable" width="120px" formatter="Ams.formatEnable">状态</th>
            <th field="updateDate" width="120px" formatter="Ams.timeDateFormat">时间</th>
            <th field="createDate" width="50px" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="name" id="name" class="easyui-textbox" required="true" label="项目名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="longitude" class="easyui-textbox" required="true" label="经度:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="latitude" class="easyui-textbox" required="true" label="纬度:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <select name="status" class="easyui-combobox" data-options="required:true,editable:true" label="进度:"
                    style="width:100%">
                <option value="0">滞后</option>
                <option value="1">整治中</option>
                <option value="2">完成</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <select name="enable" class="easyui-combobox" data-options="required:true,editable:true" label="启用/禁用:" style="width:100%">
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
        <input class="easyui-filebox" label="照片:" data-options="required:true,buttonText:'选择图片',accept:'image/jpeg,image/png'" style="width:100%" 
        	 id="file" name="file"/>
        </div>
        <div style="margin-bottom:10px">
        	<span><font color="red">*&nbsp;&nbsp;&nbsp;请上传 *.png、*.jpe、*.jpeg、*.jpg 格式图片</font></span>
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveOne()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
    function formatView(value,row,index){
    	var uuid = row.uuid;
    	return "<a href='${request.contextPath}/environment/debrief/details?uuid="+uuid+"' class='easyui-linkbutton' target='_blank'>汇报详情</a>";
    }
    
    function viewDetail(jobId) {
    	$('#detail').dialog('open').dialog('center').dialog('setTitle', '查看岗位人员');
    	$('#userList').datagrid("options").url = Ams.ctxPath + '/sys/job/listUser?jobId='+jobId;
    	$('#userList').datagrid("reload");
    }

    function newOne() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增汇报项目');
        $('#fm').form('clear');
        url = Ams.ctxPath + '/environment/debriefing/save';
    }

    function editOne() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/debriefing/get',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改汇报项目');
                    $('#fm').form('load', result.result);
                    url = Ams.ctxPath + '/environment/debriefing/save';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }
    
    function saveOne() {
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
                    $('#dg').datagrid('load');
                }
            }
        });
    }
    
	//图片添加路径
	function imgFormatter(value, row, index) {
		var rvalue ="";
		if ('' != value && null != value) {
			rvalue = "<img style='width: 150px;height: 120px;' src='${request.contextPath}/environment/attach/file?uuid=" + value + "'/>";
		}
		return rvalue;
	}

	function doSearch() {
		$('#dg').datagrid('load', {
			name : $("#queryName").val().trim(),
			enable : $("#queryEnable").val(),
			status : $("#queryStatus").val()
		});
	}

	function doReset() {
		$("#searchBar").find("#searchForm").form('clear');
		doSearch();
	}
</script>
</body>
</html>