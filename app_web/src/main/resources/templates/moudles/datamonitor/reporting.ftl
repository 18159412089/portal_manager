<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>数据监控管理</title>

</head>
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div  id="toolbar">
        <div id="searchBar" class="searchBar">
            <form id="searchForm">
                <div class="inline-block">
                    <label class="textbox-label textbox-label-before" title="汇报人">汇报人:</label>
                    <input id="createUser" name="createUser" class="easyui-textbox" style="width: 200px;">
                </div>
                <div class="inline-block">
                    <div class="layui-input-inline">
                        <label class="textbox-label textbox-label-before" title="汇报时间">汇报时间:</label>
                        <input type="text" class="layui-input" id="startTime" placeholder=" 开始时间">-
                        <input type="text" class="layui-input" id="endTime" placeholder=" 结束时间">
                    </div>
                </div>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <div class="optionBar">
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="insert()">添加汇报</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editReporting()" style="margin-bottom:10px;">修改汇报</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="deleteReporting()" style="margin-bottom:10px;">删除汇报</a>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar"
           url="${request.contextPath}/dataMonitor/DataMonitor/reportingList"
           data-options="
					rownumbers:false,
					singleSelect:true,
					striped:true,
					autoRowHeight:false,
					fitColumns:false,
					fit:true,
					pagination:true,
					pageSize:10,
					pageList:[10,30,50]">
        <thead>
        <tr>
            <th field="username" width="30%">汇报人</th>
            <th field="createTime" width="30%" formatter="Ams.timeDateFormat">汇报时间</th>
            <th field="uuid" width="40%" align="left" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
</div>
<script src="${request.contextPath}/static/layer/layer.js"></script>
<script>
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //日期时间选择器
        laydate.render({
            elem: '#startTime',
            type: 'datetime',
            trigger: 'click'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime',
            trigger: 'click'
        });
    });
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    function doSearch() {
        $('#dg').datagrid('load', {
            createUser: $("#createUser").val(),
            startTime: $("#startTime").val(),
            endTime: $("#endTime").val()
        });
    }
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }

    function formatView(value,row,index){
        var deptId = row.uuid;
        return '<div>'+Ams.setImageSee()+'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="viewDetail(\''+deptId+'\')">查看详情</a></div>';
    }

    //打开汇报详情页面方法
    function viewDetail(deptId) {
        layer.open({
            type: 2,
            title: '汇报详情',
            shade: false,
            maxmin: true,
            area: ['60%', '95%'],
            content: "${request.contextPath}/dataMonitor/DataMonitor/reportingContent?uuid="+deptId
        });
    }
    //打开添加汇报页面方法
    function insert() {
        layer.open({
            type: 2,
            title: '添加汇报',
            shade: false,
            maxmin: true,
            area: ['60%', '95%'],
            content: "${request.contextPath}/dataMonitor/DataMonitor/insertContent"
        });
    }
    ///打开修改汇报页面方法
    function editReporting() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            layer.open({
                type: 2,
                title: '修改汇报',
                shade: false,
                maxmin: true,
                area: ['60%', '95%'],
                content: "${request.contextPath}/dataMonitor/DataMonitor/updateContent?uuid="+row.uuid
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }
    //删除汇报方法
    function deleteReporting(){
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            //询问框
            layer.confirm('确定删除吗？', {
                btn: ['删除','取消'] //按钮
            }, function(){
                $.ajax({
                    type : "POST",
                    url : '${request.contextPath}/dataMonitor/DataMonitor/deleteReporting',
                    async : false,
                    dataType : "json",
                    data : {
                        uuid : row.uuid
                    },
                    success : function(data) {
                        if (data.status==200) {
                            closeIframe();
                        }
                    }
                });
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }
    function closeIframe() {
        //刷新页面
        window.location.reload();
        //先得到当前iframe层的索引
        var index = parent.layer.getFrameIndex(window.name);
        //再执行关闭
        parent.layer.close(index);
    }
</script>
</body>
</html>
