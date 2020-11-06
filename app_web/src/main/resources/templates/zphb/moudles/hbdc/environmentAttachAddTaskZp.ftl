<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>一本账-新增任务</title>
</head>
<body >
	<#include "/decorators/header.ftl"/>
	<#include "/toolbar.ftl">
	<#include "/passwordModify.ftl">
	<style type="text/css">
		#ff td{
			padding: 10px;
		}
		.textbox-text,.validatebox-text{
			height: 100%;
		}
		#textArea span.textbox{
			width: 900px !important;
			height: 100px !important;
		}
		div.datagrid-pager.pagination{
		    bottom:134px;
		    position: relative;
		}
		div.datagrid-pager.pagination td{
			padding: 2px;
		}
		#fm td{
			padding: 5px;
		}
	</style>
<!-- datagrid -->
<div class="easyui-layout" fit=true style="margin-top:70px;width: 100%">
	<div class="data-display-container">
	    <div class="title">
	        <span>漳浦县八闽快讯(一本账)汇总表</span>
	    </div>
    </div>
    <div id="toolbar">
        <div style="padding:10px;" id="searchBar">
            <a href="#" class="easyui-linkbutton btn-primary" onclick="jump()">任务类表</a>
        </div>
    </div>
   	 <form id="ff" method="post" style="padding-top: 20px;padding-left: 50px;">
   	 	<input type="hidden" name="relationName" id="relationName">
   	 	<input type="hidden" name="relationCode" id="relationCode">
    	<table cellpadding="5" >
    		<tr>
    			<td style="text-align: right;">任务创建时间：</td>
    			<td>
    				<input style="width:287px;height:40px;" id="createtime" name="createtime" required="required" class="easyui-datebox" data-options="editable:false" style="width:200px;">
				</td>
    		</tr>
    		<tr>
    			<td style="text-align: right;">分类：</td>
    			<td><input class="easyui-combobox" name="relation" required="required" id="relationSelect" data-options=" 
						url:'/environment/attach/getRelationNameList?relation=task',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'350px'"
						style="width:287px;height:40px;">
					&emsp;
					<span id="add" style="position: relative;top: 10px;"><img alt="添加分类" src="/static/images/attachment/add.png" style="cursor: pointer"><span>
				</td>
    		</tr>
    		<tr>
    			<td style="text-align: right;">问题：</td>
    			<td id="textArea">
    				<input class="easyui-textbox" required="required" name="problem" data-options="multiline:true,validType:'maxLength[1300]'"></input>
    			</td>
    		</tr>
    		<tr>
    			<td style="text-align: right;">整改目标要求：</td>
    			<td id="textArea"><input class="easyui-textbox" required="required" name="targetRequire" data-options="multiline:true,validType:'maxLength[1300]'"></input></td>
    		</tr>
    		<tr>
    			<td style="text-align: right;">整改进展及存在问题：</td>
    			<td id="textArea"><input class="easyui-textbox" required="required" name="existingProblem" data-options="multiline:true,validType:'maxLength[1300]'"></input></td>
    		</tr>
    		<tr>
    			<td></td>
    			<td>
    				<label><input type="radio" name="status" value="3" style="position: relative;top: 10px;">完成整改</label>&emsp;
			       	<label><input type="radio" name="status" value="2" style="position: relative;top: 10px;">继续整改</label>&emsp;
			       	<label><input type="radio" name="status" value="1" checked="checked" style="position: relative;top: 10px;">未达到序时进度</label>&emsp;
    			</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td>
    				<a href="#" class="easyui-linkbutton btn-primary" onclick="submit()">提交</a>
    			</td>
    		</tr>
    	</table>
    </form>
</div>

<div id="dlg" class="easyui-dialog" style="width:600px;height:638px;"
     data-options="closed:true,modal:true,border:'thin'">
    <form id="fm" method="post" novalidate style="margin:0;padding: 10px !important;">
    	<table>
    		<tr>
    			<td>分类：</td>
    			<td><input name="relationName" id="relationName1" data-options="validType:'maxLength[16]'" required="required" class="easyui-textbox" style="width:100%">
    				<input type="hidden" id="relation" name="relation">
    			</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td>
    				<a href="#" class="easyui-linkbutton btn-primary" onclick="addRelation()">提交</a>
    				<a href="#" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">取消</a>
    			</td>
    		</tr>
    	</table>
    </form><br/>
    <div id="dg" style="width: auto;height: auto;"></div>
    <!-- <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" 
           data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:5,
            pageList:[5]">
        <thead>
        <tr>
            <th field="name" width="140px" formatter="Ams.tooltipFormat">项目名称</th>
            <th field="opera" width="120px" data-options="formatter:opera">操作</th>
        </tr>
        </thead>
    </table> -->
    </div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script>
    $.extend($.fn.validatebox.defaults.rules, {
        maxLength: {
            validator: function (value, param) {
                return value.length <= param[0]&&value.trim().length > 0;
            },
            message: '请输入有效字符串，长度不能超过{0}个字符.'
        }
    });
	function jump(){
		//window.location.href=Ams.ctxPath + "/environment/attach/environmentAttachTask";
		window.open('${request.contextPath}/environment/attach/environmentAttachTask');
	}
	
	function opera(val, row, index) {
	    return '<div id="rowid_'+index+'">'+Ams.setImageEdit()+'<a href="#" class="easyui-linkbutton" onclick="edit('+index+')">编辑</a>&emsp;' +
				''+Ams.setImageDelete()+'<a href="#" class="easyui-linkbutton" onclick="del('+index+')">删除</a></div>';
	}
	
	function submit(){
		var relationName=$("#relationSelect").combobox('getText');
		var relationCode=$("#relationSelect").combobox('getValue');
		$("#relationName").val(relationName);
		$("#relationCode").val(relationCode);
		console.log(relationName);
		$('#ff').form('submit', {
            url: Ams.ctxPath + "/environment/attach/addTask",
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                	$('#ff').form('clear');
                	//$(".easyui-textbox").textbox('setValue','');
                	//$(".easyui-combobox").combobox('setValue','');
                	$("input[name='status'][value='1']").prop("checked",true);
                    Ams.success(result.message);
                }
            }
        });
	}
	

	
	$("#add").click(function(){
		$('#dlg').dialog('open').dialog('center').dialog('setTitle', '添加分类');
        $('#fm').form('clear');
        $('#dg').datagrid({
			url: '${request.contextPath}/environment/attach/getRelationList',
			rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:10,
            pageList:[10],
			queryParams: {
				relation:'task'
 		    },
			columns: [[//显示的列
	                {field: 'name', title: '项目名称', width: 100,editor: { type: 'validatebox', options: { required: true} }},
	                {field: 'opera', title: '操作', width: 50 ,formatter: opera}
        		]]
		});
	});
	
	function addRelation(){
		$("#relation").val("task");
		var relationName = $("#relationName1").val().trim();
		if(isNoEmpty(relationName)){
			$('#fm').form('submit', {
	            url: Ams.ctxPath + "/environment/attach/addRelation",
	            onSubmit: function () {
	                return $(this).form('validate');
	            },
	            success: function (result) {
	                var result = JSON.parse(result);
	                if (result.type == 'E') {
	                    Ams.error(result.message);
	                } else {
	                    //$('#dlg').dialog('close');
	                    $('#dg').datagrid('load');
	                    $('#relationSelect').combobox().combobox('clear');
                        $('#fm').form('clear');
	                    Ams.success(result.message);
	                }
	            }
	        });
		}
		
	}
	
	function edit(index){
		$('#dg').datagrid('selectRow',index);
        var row = $('#dg').datagrid('getSelected');
        if(row){
        	$('#dg').datagrid('beginEdit', index); 
        	var div = "rowid_"+index;
        	$("#"+div).html('<a href="#" class="easyui-linkbutton" onclick="sure('+index+')">确定</a>');
        	//
            //获取编辑行
            var editors = $('#dg').datagrid('getEditors', index);
            var sfgzEditor = editors[0];
            //绑定失焦事件并取消可编辑状态
            sfgzEditor.target.bind('blur', function () {
                $.messager.confirm("提示信息", "是否保存当前编辑行信息？", function (r) {
                    if (r) {
                        sure(index);
                    }else {
                        $('#dg').datagrid('selectRow', index).datagrid('endEdit', index);
                        $('#dg').datagrid('load');
                    }
                });
            });
        }
	}
	
	function del(index){
		$('#dg').datagrid('selectRow',index);
        var row = $('#dg').datagrid('getSelected');
        if(row){
        	$.messager.confirm("提示信息", "确认删除？", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/attach/delRelation',
                        data: {
                            'uuid': row.uuid
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg').datagrid('load');
                                $('#relationSelect').combobox().combobox('clear');
                                Ams.success(result.message);
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        }
	}
	
	function sure(index){
		$('#dg').datagrid('selectRow',index);
        var row = $('#dg').datagrid('getSelected'); 
        if(row){
        	$('#dg').datagrid('endEdit', index); 
        	var div = "rowid_"+index;
        	$("#"+div).html(Ams.setImageEdit()+'<a href="#" class="easyui-linkbutton" onclick="edit('+index+')">编辑</a>&emsp;'+Ams.setImageDelete()+'<a href="#" class="easyui-linkbutton" onclick="del('+index+')">删除</a>');
       		$.ajax({
                   type: 'POST',
                   url: Ams.ctxPath + '/environment/attach/editRelation',
                   data: {
                       'uuid': row.uuid,
                       'name': row.name,
                       'relation':'task'
                       
                   },
                   success: function (result) {
                       var result = eval(result);
                       if (result.type == 'E') {
                    	   $('#dg').datagrid('load');
                           Ams.error(result.message);
                       } else {
                           $('#dg').datagrid('load');
                           $('#relationSelect').combobox().combobox('clear');
                           Ams.success(result.message);
                       }
                   },
                   dataType: 'json'
               });
        	
        }
	}
	
	$(function(){
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
</script>
</body>
</html>