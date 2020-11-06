<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>党建目标责任制</title>
</head>
<body style="overflow: auto;">
    <#include "/common/loadingDiv.ftl"/>
    <#include "/decorators/header.ftl"/>
    <#include "/secondToolbar.ftl">
    <#include "/passwordModify.ftl">
<!-- datagrid -->
<div class="easyui-layout" fit=true style="padding-left:10px;padding-right:10px;">
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">部门名称:</label>
                <input class="easyui-combobox" name="queryDeptName" id="queryDeptName"  data-options="
						url:'/jobSchedule/jobScheduleDepartment/getDeptList?category=DMBZRZ',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'350px'"
						style="width: 200px;height:33px;">
                <label class="control-label">文件名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox"  style="width:200px;">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
              </form>
        </div>
        <div class="optionBar">
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="addFile()">上传文件</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editFile()">文件修改</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="deleteFile()">删除文件</a>
        </@sec.authorize>
        </div>
    </div>
    
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/jobSchedule/cliqueBuild/list" data-options="
            queryParams : '',
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:10,
            pageList:[10,20,50]">
        <thead>
        <tr>
            <th field="name" width="30%" formatter="Ams.tooltipFormat">文件名称</th>
            <th field="departmentName" width="30%" formatter="Ams.tooltipFormat">部门名称</th>
            <th field="uuid" width="15%" align="left" formatter="formatView">操作</th>
            <th field="updateDate" width="25%" align="left" formatter="Ams.timeDateFormat">修改时间</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
    	<input id="uuid" name="uuid" hidden="true"/>
    	<input id="pointName" name="pointName" hidden="true"/>
        <div style="margin-bottom:10px">
        	<input class="easyui-combobox" required="true" name="departmentId" id="departmentId" label="部门名称:" data-options="
						url:'/jobSchedule/jobScheduleDepartment/getDeptList?category=DMBZRZ',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'350px'"
						style="width: 200px;height:33px;">
        </div>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="文件名称:" style="width:100%" id="fileName">
        </div>
        <div style="margin-bottom:10px">
        <input class="easyui-filebox" label="上传文件:" data-options="required:true,buttonText:'选择文件',accept:''" style="width:100%" 
        	 id="file" name="file"/>
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveFile()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="width:100%;height:99%;text-align:center" controls="controls" preload >您的浏览器不支持 video 标签。</video>
</div>

<script>

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    function formatView(value,row,index){
    	var mongoid = row.mongoid;
    	if(row.type == "mp4"){
    		return "<a href='javascript:onClick=play(\""+row.mongoid+"\")' class='easyui-linkbutton'>查看</a>";
		}else{
			return "<a href='/jobSchedule/cliqueBuild/viewFile/"+row.mongoid+"/"+row.type
			+ "' class='easyui-linkbutton' target='_blank'>查看</a>";
		}
    }
    
    function play(mongoid){
    	$('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
    	$('#video').attr("src", Ams.ctxPath+'/jobSchedule/cliqueBuild/viewFile/'+mongoid+'/mp4');
    }

    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });

    function editFile() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
        	$.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/jobSchedule/cliqueBuild/get',
                data: {'uuid': row.uuid},
                success: function (result) {
                 $('#file').filebox({
                     onChange: function (newValue, oldValue) {
                        var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
                        var filename = newValue.substring(0, newValue.lastIndexOf('.'));
                         $('#fileName').textbox('setValue', filename);
                    }
                 });
                	$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改附件信息');
                	$('#fm').form('load', result.result);
                	$('#departmentId').combobox('select', row.departmentId);
                	$('#file').filebox({prompt: row.name});
                    $("#file").filebox({required:false});
        			url = Ams.ctxPath + '/jobSchedule/cliqueBuild/saveFile';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }
    
    function saveFile() {
    	$.messager.progress({title: '提示', msg: '文件上传中......', text: ''});
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
            	$.messager.progress('close');
               	var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                	$.messager.progress('close');
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
            }
        });
    }
    
    function addFile(){
		$('#departmentId').combobox({onLoadSuccess : function(data){
			if (data != null && data.length > 0) {
				$('#departmentId').combobox('setValue',$("#queryDeptName").val());
               	//$('#departmentId').combobox('select', data[0].id);
               	//if(data.length == 1) {
               	//	$('#departmentId').combobox('readonly',true);
               	//} else {
               	//	$('#departmentId').combobox('readonly',false);
               	//}
            }
			
		}});
		
        $('#file').filebox({
            onChange: function (newValue, oldValue) {
                    var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
                    var filename = newValue.substring(0, newValue.lastIndexOf('.'));
                    $('#fileName').textbox('setValue', filename);
            }
        });
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '文件上传');
        $('#fm').form('clear');
        $('#file').filebox({prompt: ''});
        $("#file").filebox({required:true});
        url = Ams.ctxPath + '/jobSchedule/cliqueBuild/saveFile';
    }
    
    function deleteFile() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/jobSchedule/cliqueBuild/delete',
                        data: {'uuid': row.uuid, "mongoid": row.mongoid},
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                            }
                        },
                        error: function () {
                            $.messager.progress('close');
                            $.messager.show({
                                title: '错误',
                                msg: '删除失败！'
                            });
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }
    
    function doSearch() {
        $('#dg').datagrid('load', {
            name : $("#queryName").val(),
            departmentId : $("#queryDeptName").val()
        });
    }
     function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }

</script>
</body>
</html>