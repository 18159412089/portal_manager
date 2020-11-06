<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>汇报详情管理</title>
</head>
<body style="overflow: auto;">
	<#include "/common/loadingDiv.ftl"/>
	<#include "/decorators/header.ftl"/>
	<#include "/toolbar.ftl">
    <#include "/passwordModify.ftl">
<!-- datagrid -->
<div class="easyui-layout" fit=true style="margin-top:70px;">
    <div id="toolbar">
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newOne()">新增</a>
        <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editOne()">修改</a>
        </@sec.authorize>
    </div>
    
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/environment/debrief/details/list" data-options="
           	queryParams : {debriefing : '${debriefing}'},
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:10,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="name" width="120px" formatter="Ams.tooltipFormat">项目名称</th>
            <th field="enable" width="90px" formatter="Ams.formatEnable">状态</th>
            <th field="updateDate" width="100px" formatter="Ams.timeDateFormat">时间</th>
            <th field="createDate" width="100px" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input name="uuid" hidden="true"/>
        <input id="debriefing" name="debriefing" value="" type="hidden">
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" data-options="required:true,label:'描述:'" multiline="true" style="width: 100%; height: 120px">
        </div>
        <div style="margin-bottom:10px">
            <select name="enable" class="easyui-combobox" data-options="required:true,editable:true" label="启用/禁用:" style="width:100%">
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
        	<input class="easyui-filebox" label="视频:" data-options="required:true,buttonText:'选择视频',accept:'audio/mp4,video/mp4'" style="width:100%" 
        	 	id="file" name="file"/>
        </div>
        <div style="margin-bottom:10px">
        	<span><font color="red">*&nbsp;&nbsp;&nbsp;请上传 *.MP4 格式视频</font></span>
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveOne()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<!-- dialog1 -->
<div id="dlg1" class="easyui-dialog" style="width:800px;height:500px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg1-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload >您的浏览器不支持 video 标签。</video>
</div>
<script>
	var debriefing = '${debriefing}';

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $("#dlg1").dialog({
    	onClose: function () {
    		if ($('#video').get(0).paused) {
    			//$('#video').get(0).play();
    		} else {
    			$('#video').get(0).pause();
    		}
    	}
    });
    
    function formatView(value,row,index){
    	var uuid = row.video;
    	return "<a href='#' class='easyui-linkbutton' onClick='play(\""+uuid+"\")'>播放</a>";
    }
    
    function play(uuid){
    	$('#dlg1').dialog('open').dialog('center').dialog('setTitle', '视频播放');
    	//$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
    	$('#video').attr("src", Ams.ctxPath+'/environment/attach/video?uuid='+uuid);
    }

    function newOne() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增汇报详情');
        $('#fm').form('clear');
        $('#debriefing').val(debriefing);
        url = Ams.ctxPath + '/environment/debrief/details/save';
    }

    function editOne() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/debrief/details/get',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改汇报项目');
                    $('#fm').form('load', result.result);
                    url = Ams.ctxPath + '/environment/debrief/details/save';
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
</script>
</body>
</html>