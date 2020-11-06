<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>环保督察管理</title>
    <style type="text/css">
		#describe{
			margin-left:15px;
			width:95%; 
			display:inline-block;
			overflow: hidden; 
			white-space: nowrap; 
			text-overflow: ellipsis;
			font-size:20px;
		}
	</style>
</head>
<body >
	<#include "/common/loadingDiv.ftl"/>
	<#include "/decorators/header.ftl"/>
	<#include "/toolbar.ftl">
    <#include "/passwordModify.ftl">
	 <!-- ol -->
	<link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
	<!-- Custom -->
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
	<!-- ol end -->
   	
	<!-- 地图相关 -->
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
	<script src="${request.contextPath}/static/js/epaConsole.js"></script>
	
	
<!-- datagrid -->
<!-- <div class="easyui-layout" fit=true style="margin-top:70px;"> -->
    <div id="toolbar" style="">
        <div style="padding:3px;padding-top:67px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">项目名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">项目进度:</label>
	            <select name="queryStatus" id="queryStatus"  class="easyui-combobox" style="width:200px">
	                <option value="" selected="selected">全部状态</option>
	                <option value="0">滞后</option>
	                <option value="1">整治中</option>
	                <option value="2">完成</option>
	            </select>
                <label class="control-label">启用/禁用:</label>
	            <select name="queryEnable" id="queryEnable" class="easyui-combobox"  style="width:200px;">
	                <option value="" selected="selected">全部状态</option>
	                <option value="1">启用</option>
                	<option value="0">禁用</option>
	            </select>
                <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newOne()">新增</a>
        <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editOne()">修改</a>
        <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newDetailOne()">新增详情</a>
        </@sec.authorize>
        <br>
        <span id="describe"></span>
    </div>
    
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;padding-bottom:26px" toolbar="#toolbar"
           url="${request.contextPath}/environment/debriefing/list" data-options="
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
            <th field="code" width="50px" formatter="Ams.tooltipFormat">整改任务</th>
            <th field="name" width="120px" formatter="Ams.tooltipFormat">项目名称</th>
            <th field="city" width="50px" formatter="Ams.tooltipFormat">地市</th>
            <th field="picture" width="120px" formatter="imgFormatter">图片预览</th>
            <th field="timelimit" width="80px" formatter="Ams.tooltipFormat">整改时限</th>
            <th field="status" width="50px" formatter="Ams.formatDebriefing">进度</th>
            <th field="pctime" width="80px" formatter="Ams.tooltipFormat">拟市级验收时间</th>
            <th field="actime" width="80px" formatter="Ams.tooltipFormat">实际市级验收时间</th>
            <th field="pttime" width="80px" formatter="Ams.tooltipFormat">拟行业审查时间</th>
            <th field="attime" width="80px" formatter="Ams.tooltipFormat">实际行业审查时间</th>
            <th field="overtime" width="80px" formatter="Ams.tooltipFormat">完成行业审查时间</th>
            <th field="isover" width="50px" formatter="Ams.formatEnableSave">是否超期</th>
            <th field="longitude" width="50px" formatter="Ams.tooltipFormat">经度</th>
            <th field="latitude" width="50px" formatter="Ams.tooltipFormat">纬度</th>
            <th field="enable" width="50px" formatter="Ams.formatEnable">状态</th>
            <th field="updateDate" width="120px" formatter="Ams.timeDateFormat">时间</th>
            <th field="createDate" width="50px" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
<!-- </div> -->
<!-- 环保督察立项弹窗 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="code" id="code" class="easyui-textbox" required="true" label="整改任务:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="name" id="name" class="easyui-textbox" required="true" label="项目名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input id="longitude_" name="longitude" class="easyui-textbox" label="经度:" style="width:100%">
            <a href="#" class="easyui-linkbutton" onclick="openMap()" data-options="toggle:true,group:'g1'">取点</a>
        </div>
        <div style="margin-bottom:10px">
            <input id="latitude_" name="latitude" class="easyui-textbox" label="纬度:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input id="city" name="city" class="easyui-textbox" required="true" label="地市:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input id="timelimit" name="timelimit" class="easyui-textbox" required="true" label="整改时限:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <select name="status" class="easyui-combobox" data-options="required:true,editable:true" label="进度:" style="width:100%">
                <option value="0">滞后</option>
                <option value="1">整治中</option>
                <option value="2">完成</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <input name="pctime" class="easyui-textbox" required="true" label="拟市级验收时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="actime" class="easyui-textbox" label="实际市级验收时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="pttime" class="easyui-textbox" required="true" label="拟行业审查时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="attime" class="easyui-textbox" label="实际行业审查时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="overtime" class="easyui-textbox" label="完成行业审查时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <select name="isover" class="easyui-combobox" data-options="editable:true" label="是否超期:" style="width:100%">
                <option value="1">超期</option>
                <option value="0">按时</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
	        <input class="easyui-filebox" label="照片:" data-options="buttonText:'选择图片',accept:'image/jpeg,image/png'" style="width:100%" 
	        	 id="file" name="file"/>
        </div>
        <div style="margin-bottom:10px">
        	<span><font color="red">*&nbsp;&nbsp;&nbsp;请上传 *.png、*.jpe、*.jpeg、*.jpg 格式图片</font></span>
        </div>
        <div style="margin-bottom:10px">
            <select name="enable" class="easyui-combobox" data-options="required:true,editable:true" label="启用/禁用:" style="width:100%">
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveOne()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<div id="dlg-detail" class="easyui-dialog" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
	<div class="easyui-panel" style="width:100%;height:100%" style="padding:5px">
	    <table id="dg2" class="easyui-datagrid" style="width:100%;height:auto;"
	           data-options="
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
	            <th field="status" width="120px" formatter="Ams.formatDebriefingDetail">项目进度</th>
	            <th field="enable" width="90px" formatter="Ams.formatEnable">状态</th>
	            <th field="updateDate" width="100px" formatter="Ams.timeDateFormat">时间</th>
	            <th field="createDate" width="100px" formatter="attach">操作</th>
	        </tr>
	        </thead>
	    </table>
	</div>
</div>
<div id="dlg-detail-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-detail').dialog('close')" style="width: 90px">返回</a>
</div>
<!-- 详情编辑弹窗 -->
<div id="dlg3" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg3-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input name="uuid" hidden="true"/>
        <input id="debriefing" name="debriefing" value="" type="hidden">
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" data-options="required:true,label:'描述:'" multiline="true" style="width: 100%; height: 120px">
        </div>
        <div style="margin-bottom:10px">
            <select name="status" class="easyui-combobox" data-options="required:true,editable:true" label="项目进度:" style="width:100%">
                <option value="1">严重滞后</option>
                <option value="2">进度偏慢</option>
                <option value="3">时序进度</option>
                <option value="4">完成整改</option>
                <option value="5">已经销号</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <select name="enable" class="easyui-combobox" data-options="required:true,editable:true" label="启用/禁用:" style="width:100%">
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </div>
        <div style="margin-bottom:10px" id="file-div">
        	<input class="easyui-filebox" label="附件:" data-options="required:true,buttonText:'选择文件',multiple:'true'" style="width:100%" 
        	 	id="file" name="file"/>
        </div>
    </form>
</div>
<div id="dlg3-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveDetailOne()" style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg3').dialog('close')" style="width:90px">取消</a>
</div>
<!-- 附件列表弹框 -->
<div id="dlg4" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin'">
    <div class="easyui-panel" style="width:100%;height:500px;" style="padding:5px">
    	<form id="fm" method="post" novalidate enctype="multipart/form-data" style="display:inline;">
	    	<input name="uuid" id="uuid" hidden="true"/>
	    	<input class="easyui-filebox" data-options="buttonText:'选择文件',multiple:'false'" style="width:200px" id="file" name="file"/>
    	</form>
    	<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newUploadOne()">新增上传</a>
	    <table id="dg3" class="easyui-datagrid" style="width:100%;height:auto;"
	           data-options="
	            rownumbers:true,
	            singleSelect:true,
	            striped:true,
	            autoRowHeight:true,
	            fitColumns:true,
	            fit:true">
	        <thead>
	        <tr>
	            <th field="name" width="120">附件名称</th>
	            <th field="createDate" width="50" formatter="attachList">操作</th>
	        </tr>
	        </thead>
	    </table>
	</div>
</div>
<#include "/moudles/debriefing/map.ftl"/>
<script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/map.js"></script>
<script>

//初始化地图对象
    //设置显示地图的中心点和级别
 
   
    /*function editMarker() {
            var markers = markerTool.getMarkers()
            for (var i = 0; i < markers.length; i++) {
                markers[i].enableDragging();
            }
        }
        
	function endeditMarker() {
	    var markers = markerTool.getMarkers()
	    for (var i = 0; i < markers.length; i++) {
	        markers[i].disableDragging();
	    }
	}*/
	
	function ok(){
		$("#longitude_").textbox('setValue',$('#lng').val());
		$("#latitude_").textbox('setValue',$('#lat').val());
    	$('#map').dialog('close');
	}
    
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
	$(function(){
		$.ajax({
			type: "POST",
			url: Ams.ctxPath + "/environment/debriefing/getDescribe",
			async:true,
			success: function (data) {
				$('#describe').html(data);
            }
		});
	});
	
    function formatView(value,row,index){
    	var uuid = row.uuid;
    	//return "<a href='${request.contextPath}/environment/debrief/details?uuid="+uuid+"' class='easyui-linkbutton' target='_blank'>汇报详情</a>";
    	return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+uuid+"')\">详情查看</a></div>";
    }
    
    function attach(value,row,index){
    	var uuid = row.uuid;
    	return "<a href='#' class='easyui-linkbutton' onClick=\"editDetailOne('"+uuid+"')\">编辑</a>&nbsp;&nbsp;&nbsp;"+
    		"<a href='#' class='easyui-linkbutton' onClick=\"openfiles('"+uuid+"')\">附件</a>";
    }
    
    function attachList(value,row,index){
    	var mongoid = row.mongoid;
    	return "<a href='#' class='easyui-linkbutton' onClick=\"download2('"+mongoid+"')\">下载</a>";
    }
    
    function setting(rowId) {
		$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '环保督察详情');
    	$('#dg2').datagrid({   
		    url: Ams.ctxPath + '/environment/debrief/details/list',
		    queryParams:{
		    	debriefing:rowId
		    }
		});
	}
    
    function newUploadOne(){
    	$('#dlg4 #fm').form('submit', {
            url: Ams.ctxPath + '/environment/debrief/details/updateOnlyFile',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
               	var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                	$('#dlg4 #file').filebox('setValue','');
                    $('#dg3').datagrid('load');
                }
            }
        });
    }
    
    function openfiles(rowId) {
    	$('#dlg4 #fm').form('clear');
		$('#dlg4').dialog('open').dialog('center').dialog('setTitle', '附件列表');
		$('#dlg4 #uuid').val(rowId);
    	$('#dg3').datagrid({
		    url: Ams.ctxPath + '/environment/debrief/details/getAttachList',
		    queryParams:{
		    	uuid:rowId
		    }
		});
	}
    
    function download2(mongoid){
    	var url = Ams.ctxPath + '/environment/attach/down?mongoid='+mongoid;
    	window.location.href=url;
    }

    function newOne() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增汇报项目');
        $('#fm').form('clear');
        url = Ams.ctxPath + '/environment/debriefing/save';
    }

    function editOne() {
    	$('#dlg #file').filebox({required:false});
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
    
    function newDetailOne() {
    	var row = $('#dg').datagrid('getSelected');
        if (row) {
	        $('#dlg3').dialog('open').dialog('center').dialog('setTitle', '新增汇报详情');
	        $('#dlg3 #fm').form('clear');
	        $('#dlg3 #debriefing').val(row.uuid);
    		$('#dlg3 #file-div').show();
	        url = Ams.ctxPath + '/environment/debrief/details/save';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function editDetailOne(rowId) {
		$('#dlg3 #file').filebox({required:false});
        $('#dlg3 #fm').form('clear');
        $.ajax({
        	type: 'POST',
        	url: Ams.ctxPath + '/environment/debrief/details/get',
        	data: {'uuid': rowId},
        	success: function (result) {
		   		$('#dlg3 #file-div').hide();
        		$('#dlg3').dialog('open').dialog('center').dialog('setTitle', '修改汇报项目');
        		$('#dlg3 #fm').form('load', result.result);
        		url = Ams.ctxPath + '/environment/debrief/details/save';
        	},
        	dataType: 'json'
        });
    }
    
    function saveDetailOne() {
        $('#dlg3 #fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
               	var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg3').dialog('close');
                    $('#dg2').datagrid('load');
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