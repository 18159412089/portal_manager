<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>任务派发</title>
</head>
<body class="bg-color">
    <#include "/common/loadingDiv.ftl"/>
	<#include "/decorators/header.ftl"/>
	<#include "/secondToolbar.ftl">
    <#include "/passwordModify.ftl">
	<style>
	
	.filebox{
		border-radius:3px;
		border:0px solid #cfcfcf;
		width: 108px;
		height: 34px;
	}
	#div1,#div2{
		font-size: 16px;
		padding: 10px 10px 5px 10px;
	}
	#dlg2 .textbox{
		width:380px !important;
	}
	</style>
<div class="easyui-layout" fit=true style="padding:0px 30px 30px 30px;width: 100%">
<div class="easyui-tabs easyui-tab-brief" style="height:100%">
		<div title="水质问题整改任务派发" style="padding:10px">
			<div class="easyui-layout" fit=true>
    <div id="toolbar_one">
        <div id="searchBar_one">
            <form id="searchForm_one">
            	<label class="control-label">人员名称：</label>
            	<input type="text" id="username" name="userName" class="easyui-textbox" style="width:156px;">
				<label class="control-label">地区：</label>
				<input type="text" id="address" name="address" class="easyui-textbox" style="width:156px;">
				<label class="control-label">手机号码：</label>
				<input type="text" id="phone" name="phone" class="easyui-textbox" style="width:156px;">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch_one()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset_one()">重置</a>
            </form>
           
            <form id="uplodFile" method="post" enctype="multipart/form-data">
             	<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="addUser()">新建</a>
            	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-fasong1'" onclick="distributeBetch()">批量派发</a>
            	<a href="javascript:void(0)" name="xlsxfile" id="importFile" class="easyui-filebox btn-purple" data-options="accept:'application/vnd.ms-excel'"></a>
            	<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delBetch()">批量删除</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-save'" onclick="downloadFile()">导入模板下载</a>
            </form>
            
        </div>
    </div>
    <table id="dg_one" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar_one"
           data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100],
            singleSelect:false">
        <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
            <th field="userName" width="120px" formatter="Ams.tooltipFormat">人员名称</th>
            <th field="phone" width="120px" formatter="Ams.tooltipFormat">联系电话</th>
            <th field="address" width="120px" formatter="Ams.tooltipFormat">地区</th>
            <th field="createDate" width="120px" formatter="Ams.timeDateFormat">添加时间</th>
            <th field="opera" width="120px" data-options="formatter:editDelete">操作</th>
        </tr>
        </thead>
    </table>
</div>
		</div>
		<div title="派发任务明细" style="padding:10px">
		<div class="easyui-layout" fit=true>
    <div id="toolbar2">
        <div style="padding:3px;" id="searchBar_two">
            <form id="searchForm2">
                <label class="control-label">人员名称：</label>
                <input type="text" id="username_two" name="username_two" class="easyui-textbox" style="width:156px;">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch1()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset1()">重置</a>
            </form>
            <!-- <div style="width: 100%;text-align: center;">标题</div> -->
        </div>
    </div>

    <table id="dg1" class="easyui-datagrid" style="width:100%;height:auto;" url="${request.contextPath}/enviromonit/water/taskDetalis/list"
            toolbar="#toolbar2" idField="uuid"
           data-options="
           rownumbers:true,
                rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100],
            singleSelect:false">
        <thead >
                <tr>
                    <th field="userName" width="100px" formatter="Ams.tooltipFormat">人员名称</th>
                    <th field="content" width="100px" formatter="Ams.tooltipFormat">派发内容</th>
                    <th field="uuid" width="20%" align="left" formatter="formatView">操作</th>
                </tr>
        </thead>
    </table>
</div>
		</div>
	</div>
</div>
<div id="dlg2" class="easyui-dialog" style="width:550px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
    <form id="fm2" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden/>
        <div style="margin-bottom:10px">
            <input name=username_three" id="username_three" class="easyui-textbox" readonly data-options="multiline:true" style="width:100%;height:100px"  label="人员名称:">
        </div>
        <div style="margin-bottom:10px">
            <input name="content" id="content" class="easyui-textbox" data-options="multiline:true" readonly  label="内容:" style="width:100%;height:100px">
        </div>
    </form>
</div>
<div id="dlg2-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="$('#dlg2').dialog('close')"
       style="width:90px">关闭</a>
</div>
<div id="dlg_one" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons_one'">
    <form id="fm_one" method="post" novalidate style="margin:0;padding:20px 50px">

        <div style="margin-bottom:10px">
            <input name="userName" class="easyui-textbox" required="true" label="人员名称:" style="width:100%" data-options="validType:'maxLength[20]'">
        </div>
        <div style="margin-bottom:10px">
            <input name="phone" class="easyui-textbox" required="true" label="联系电话:" style="width:100%" data-options="validType:'telephone'">
        </div>
        <div style="margin-bottom:10px">
            <input name="address" class="easyui-textbox" required="true" label="地区:" style="width:100%" data-options="validType:'maxLength[120]'">
        </div>
        <input name="uuid" hidden/>
    </form>
</div>
<div id="dlg-buttons_one">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg_one').dialog('close')" style="width:90px">取消</a>
</div>

<div id="dlg1_one" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons1_one'">
    <form id="fm1_one" method="post" novalidate style="margin:0;padding:20px 50px">
        <input type="hidden" name="phones" id="phones">
        <input type="hidden" name="names" id="names">
        <div style="margin-bottom:10px">
           <input name="message" class="easyui-textbox" required="true" data-options="label:'派发信息'" multiline="true"
                   style="width:100%;height:120px">
        </div>
    </form>
</div>
<div id="dlg-buttons1_one">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="distribute()"
       style="width:90px">派发</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg1_one').dialog('close')" style="width:90px">取消</a>
</div>
<script>

doReset1 = function(){
    $("#searchBar_two").find("#searchForm2").form('clear');
    doSearch1();
}

function formatView(value,row,index){

        return '<div>'+Ams.setImageSee()+'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="viewDetail(\''+row.uuid+'\')">明细</a></div>';
    }
    function doSearch1() {
        var userName= $("#username_two").val();
        $('#dg1').datagrid({
            url: '${request.contextPath}/enviromonit/water/taskDetalis/list',
            queryParams: {
                userName: userName
            }
        });
    }
    function viewDetail(id) {
        $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '明细');
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/enviromonit/water/taskDetalis/getInfoById",
            data : {
               id:id
            },
            dataType: "json",
            success: function(result){
                $("#username_three").textbox('setValue',result[0].userName);
                $("#content").textbox('setValue',result[0].content);
            },
            error: function(r){console.log(r);}
        });
    }
	//操作 
	function editDelete(val, row, index) {
	    return '<div>'+Ams.setImageDistribute()+'<a href="javascript:void(0)" class="easyui-linkbutton" onclick="distributeOne('+index+')">派发任务</a>' +
                '&emsp;'+Ams.setImageEdit()+'<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit('+index+')">修改</a>' +
                '&emsp;'+Ams.setImageDelete()+'<a href="javascript:void(0)" class="easyui-linkbutton" onclick="del('+index+')">删除</a>';
	}
	
	//派发
    function distribute(){  
    	$('#fm1_one').form('submit', {
            url: url1,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
            	doSearch1();
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg1_one').dialog('close');
                    $('#dg_one').datagrid('load');
                    Ams.success(result.message);
                }
            }
        });
    }  
    function distributeOne(index){  
    	$('#dg_one').datagrid('selectRow',index);// 关键在这里  
        var row = $('#dg_one').datagrid('getSelected');  
        if (row){  
        	$('#dlg1_one').dialog('open').dialog('center').dialog('setTitle', '派发任务');
            $('#fm1_one').form('clear');
            $('#phones').val(row.phone);
            $('#names').val(row.userName);
            url1 = Ams.ctxPath + '/enviromonit/water/userContcatInfo/distribute';
        }  
    }  
    function distributeBetch(){  
        var checkedItems = $('#dg_one').datagrid('getChecked'); 
        var phones = [];
        var names=[];
        $.each(checkedItems, function(index, item){
        	phones.push(item.phone);
        	names.push(item.userName);
        });
        if(phones.length ==0){
       	 $.messager.confirm("提示信息", "请选择人员");
       }else{
    	   $('#dlg1_one').dialog('open').dialog('center').dialog('setTitle', '批量派发任务');
           $('#fm1_one').form('clear');
           $('#phones').val(phones.join(","));
           $('#names').val(names.join(","));
           url1 = Ams.ctxPath + '/enviromonit/water/userContcatInfo/distribute';
       }
    }  
	
    //修改 
    function edit(index){  
        $('#dg_one').datagrid('selectRow',index);// 关键在这里  
        var row = $('#dg_one').datagrid('getSelected');  
        if (row){  
        	$('#dlg_one').dialog('open').dialog('center').dialog('setTitle', '修改人员信息');
            $('#fm_one').form('clear');
            $('#fm_one').form('load', row);
            $('#uuid').textbox({readonly: true});
            url = Ams.ctxPath + '/enviromonit/water/userContcatInfo/saveUser';
        }  
    }  
    function saveUser() {
        $('#fm_one').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg_one').dialog('close');
                    $('#dg_one').datagrid('load');
                    Ams.success(result.message);
                }
            }
        });
    }
    //导入
    $('#importFile').filebox({
        buttonText: '批量导入',
        buttonAlign: 'center',
        buttonIcon: 'iconcustom icon-xiazai1',        
        clear:true ,
		onChange: function (newVal,oldVal) {
			var suffix = newVal.substring(newVal.lastIndexOf('.') + 1, newVal.length);
            if (suffix != 'xls' && suffix !='xlsx') {
                Ams.error('只能导入后缀为xls或xlsx的文件');
                return;
            }
		 	$.messager.confirm("提示信息", "确认导入文件：<br/>"+newVal+"？", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '数据导入中......', text: ''});
                    $('#uplodFile').form('submit', {
                        url: Ams.ctxPath + "/enviromonit/water/userContcatInfo/importFile",
                        onSubmit: function () {
                            var isValid = $(this).form('validate');
                            if (!isValid){
                                $.messager.progress('close');	// hide progress bar while the form is invalid
                            }
                            return isValid;
                        },
                        success: function (result) {
                            var result = JSON.parse(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dlg_one').dialog('close');
                                doReset_one();
                                Ams.success(result.message);
                            }
                            $("#filebox_file_id_2").val('');
                            $.messager.progress('close');
                        }
                    });
                } else {
                    $("#filebox_file_id_2").val('');
                }
            });
		}
    })
    //导入模板下载
    function downloadFile(){
        var $eleForm = $("<form method='get'></form>");
        $eleForm.attr("action","${request.contextPath}/static/js/moudles/enviromonit/water/任务派发人员模板.xls");
        $(document.body).append($eleForm);
        //提交表单，实现下载
        $eleForm.submit();
    }
    //增加 
    function addUser(){  
       	$('#dlg_one').dialog('open').dialog('center').dialog('setTitle', '修改人员信息');
        $('#fm_one').form('clear');
        url = Ams.ctxPath + '/enviromonit/water/userContcatInfo/addUser';
    }  
    //删除 
    function del(index){  
    	 $('#dg_one').datagrid('selectRow',index);
    	 var row = $('#dg_one').datagrid('getSelected');
         if (row) {
             $.messager.confirm("提示信息", "确认删除？", function (r) {
                 if (r) {
                     $.ajax({
                         type: 'POST',
                         url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/delUser',
                         data: {
                             'uuid': row.uuid
                         },
                         success: function (result) {
                             var result = eval(result);
                             if (result.type == 'E') {
                                 Ams.error(result.message);
                             } else {
                                 $('#dg_one').datagrid('load');
                                 Ams.success(result.message);
                             }
                         },
                         dataType: 'json'
                     });
                 }
             });
         } else {
             $.messager.alert('提示', '请选择要删除的人员信息！');
         }
    }  
    function delBetch(){  
    	var checkedItems = $('#dg_one').datagrid('getChecked'); 
        var uuids = [];
        $.each(checkedItems, function(index, item){
        	uuids.push(item.uuid);
        });
        if(uuids.length ==0){
        	 $.messager.confirm("提示信息", "请选择人员");
        }else{
        	$.messager.confirm("提示信息", "确认删除？", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/delUser',
                        data: {
                            'uuid': uuids.join(",")
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                Ams.success('批量删除成功！');
                                $('#dg_one').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        }
    }  
    
	$(function(){
		doSearch_one();
		$.extend($.fn.validatebox.defaults.rules, {
            maxLength: {
                validator: function (value, param) {
                    return value.length <= param[0];
                },
                message: '输入不能超过{0}个字符.'
            },
           telephone: {    //第三步,选中校验谁
                  validator: function(value){    //第四步, 具体编写校验规则
                   var reg = /^1[3,5,7,8][0-9]{9}$/;
                      return reg.test(value);
                     
                  },   
                  message: '请输入正确的手机号!'   //第五步,如果输入内容不符合校验规则,出现的提示语.
              }
          });  
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch_one() {
    	$('#dg_one').datagrid({
			url: '${request.contextPath}/enviromonit/water/userContcatInfo/getPageList',
		    queryParams: {
		    	userName:$('#username').val(),
		    	address:$('#address').val(),
		    	phone:$('#phone').val()
		    }
		});
    }

    function doReset_one() {
        $("#searchBar_one").find("#searchForm_one").form('clear');
        doSearch_one();
    }
    
</script>
</body>
</html>