<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>用户管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <input id="queryLogin" name="queryLogin" class="easyui-textbox" label="登录名:" style="width:200px;">
                <input id="queryName" name="queryName" class="easyui-textbox" label="姓名:" style="width:200px;">
                <input id="queryPhone" name="queryPhone" class="easyui-textbox" label="电话:" style="width:200px;">
                <select name="queryEnable" id="queryEnable" class="easyui-combobox" data-options="editable:true"
                        label="状态:"
                        style="width:250px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRain()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editUser()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock_open'"
           onclick="enableUser()">启用</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="disableUser()">禁用</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetPwd()">重置密码</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'"
           onclick="assignJob()">岗位分配</a>
        </@sec.authorize>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/environment/AirQualityByYear/getAirYearOnYearAnalysis?startTime=2027-01&endTime=2039-02" data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100]">
        <thead >
        <tr>
            <th field="pointName" width="120px">县</th>
            <th field="reach" width="120px">达标率</th>
            <th field="reachYear" width="60px" >同比</th>
            <th field="rank" width="250px">全市排名</th>
            <th field="polluteDay" width="120px">天数</th>
            <th field="polluteDayYear" width="120px">同比</th>
            
            <th field="PM2Day" width="120px">天数</th>
            <th field="PM2DayYear" width="120px">同比</th>
            
            <th field="PM10Day" width="120px">天数</th>
            <th field="PM10DayYear" width="120px">同比</th>
            
            <th field="NO2Day" width="120px">天数</th>
            <th field="NO2DayYear" width="120px">同比</th>
            
            <th field="O3Day" width="120px">天数</th>
            <th field="O3DayYear" width="120px">同比</th>
         
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input id="time" name="time" required="true" editable='false' class="easyui-datebox" label="月份:" style="width:139px;height:30px;" />
        </div>
        <div style="margin-bottom:10px">
            <input name="days" class="easyui-textbox" required="true" label="天数" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="sunshineDuration" class="easyui-textbox" required="true" label="日照时间:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="rainFall" class="easyui-textbox" required="true" label="降雨量:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRain()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<script>

	$(function() {
			$('#time').datebox({
				//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
				onShowPanel: function () {
				//触发click事件弹出月份层
			    span.trigger('click'); 
			    if (!tds)
			    	//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
			    	setTimeout(function() {
			    		tds = p.find('div.calendar-menu-month-inner td');
			    		tds.click(function(e) {
			    			//禁止冒泡执行easyui给月份绑定的事件
			    			e.stopPropagation();
			    			//得到年份
			    			var year = /\d{4}/.exec(span.html())[0] ,
			    			//月份
			    			//之前是这样的month = parseInt($(this).attr('abbr'), 10) + 1;
			    			month = parseInt($(this).attr('abbr'), 10);
			    			//隐藏日期对象
			    			$('#time').datebox('hidePanel')
			    			//设置日期的值
			    			.datebox('setValue', year + '-' + month);
			    		});
			    	}, 0);
			    },
			    //配置parser，返回选择的日期
			    parser: function (s) {
			    	if (!s) return new Date();
			    	var arr = s.split('-');
			    	return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
			    },
			    //配置formatter，只返回年月 之前是这样的d.getFullYear() + '-' +(d.getMonth()); 
			    formatter: function (d) { 
			    	var currentMonth = (d.getMonth()+1);
			    	var currentMonthStr = currentMonth < 10 ? ('0' + currentMonth) : (currentMonth + '');
			    	return d.getFullYear() + '-' + currentMonthStr; 
			    }
			});
			//日期选择对象
			var p = $('#time').datebox('panel');
			//日期选择对象中月份
			tds = false;
			//显示月份层的触发控件
			span = p.find('span.calendar-text'); 
			
			
			var curr_time = new Date();
			//设置前当月
			//$("#time").datebox("setValue", myformatter(curr_time));
		});
	
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
   

    function delFormat(value, row, index) {
        return '<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:\'icon-remove\'" onclick="jobRemove(' + index + ')">删除</a>'
    }

    function newRain() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增降雨量数据');
        $('#fm').form('clear');
        $('#loginname').textbox({readonly: false});
        url = Ams.ctxPath + '/enviromonit/rainMonthlyData/savaRainMonthlyData';
    }

    function editUser() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/enviromonit/rainMonthlyData/getRainMonthlyData',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改降雨量数据');
                    $('#fm').form('load', result.rainMonthlyData);
                    $('#loginname').textbox({readonly: true});
                    url = Ams.ctxPath + '/enviromonit/rainMonthlyData/savaRainMonthlyData';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveRain() {
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
                	  Ams.success(result.message);
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                }
            }
        });
    }

    function disableUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认禁用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/editUserStatus',
                        data: {
                            'uuid': row.uuid,
                            'enable': 0,
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要禁用的记录！');
        }
    }

    function enableUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (1 == row.enable) {
                $.messager.alert('提示', '已经是启用状态！');
                return;
            }
            $.messager.confirm("提示信息", "确认启用当前选中的记录吗?启用将清空该用户所有岗位！", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/editUserStatus',
                        data: {
                            'uuid': row.uuid,
                            'enable': 1,
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                               Ams.
                            } else {
                                $('#dg').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要启用的记录！');
        }
    }

    function resetPwd() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认给当前选中的记录重置密码吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/resetPwd',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                ams
                            } else {
                                $.messager.show({
                                    title: '成功',
                                    msg: '重置密码成功'
                                });
                                $('#dg').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要重置密码的记录！');
        }
    }

    function assignJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            loadRightGrid(row);
            $('#leftGrid').datagrid("options").url = Ams.ctxPath + '/sys/job/list?enable=1';
            tbSearch();
            $('#assignJobDlg').dialog('open').dialog('center').dialog('setTitle', '分配岗位');
        } else {
            $.messager.alert('提示', '请选择一条要分配岗位的记录！');
        }
    }

    function loadRightGrid(row) {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/sys/user/assignJob',
            data: {
                'uuid': row.uuid
            },
            success: function (result) {
                var result = eval(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    var data = eval(result.data);
                    $('#rightGrid').datagrid('loadData', {total: data.length, rows: data});
                }
            },
            dataType: 'json'
        });
    }

    function saveUserAndJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            var checkedData = getCheckedData().toString();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/user/saveUserAndJob',
                data: {
                    'uuid': row.uuid,
                    'jobIds': checkedData
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#assignJobDlg').dialog('close');
                        $('#dg').datagrid('load');
                    }
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要分配岗位的记录！');
        }
    }

    function getCheckedData() {
        var rows = $('#rightGrid').datagrid('selectAll').datagrid('getSelections');
        var roleIds = '';
        for (var i = 0; i < rows.length; i++) {
            if (i == rows.length - 1) {
                roleIds += rows[i].uuid;
            } else {
                roleIds += rows[i].uuid + ",";
            }
        }
        return roleIds;
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            loginname: $("#queryLogin").val().trim(),
            name: $("#queryName").val().trim(),
            phone: $("#queryPhone").val().trim(),
            enable: $("#queryEnable").val()
        });
    }

    function tbSearch() {
        $('#leftGrid').datagrid('load', {
            userid: $('#dg').datagrid('getSelected').uuid,
            jobName: $("#tbJob").val(),
            deptid: $("#tbDeptName").val(),
        });
    }

    function checkJobTbClear() {
        $('#rightGrid').datagrid('loadData', {total: 0, rows: []});
    }

    function jobRemove(index) {
        $('#rightGrid').datagrid('deleteRow', index);
        var rows = $('#rightGrid').datagrid("getRows");
        $('#rightGrid').datagrid("loadData", rows);
    }

    function leftToRight() {
        var selected = $('#leftGrid').datagrid("getSelections");
        var haveSelected = $('#rightGrid').datagrid("selectAll").datagrid("getSelections");
        for (var i = 0; i < selected.length; i++) {
            for (var j = 0; j < haveSelected.length; j++) {
                if (selected[i].uuid === haveSelected[j].uuid) {
                    var rowIndex = $('#rightGrid').datagrid('getRowIndex', haveSelected[j]);
                    $('#rightGrid').datagrid('deleteRow', rowIndex);
                    break;
                }
            }
            //把选择的数据添加到右侧grid
            $('#rightGrid').datagrid('appendRow', selected[i]);
        }
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>