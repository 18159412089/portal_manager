<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<head>
    <title>一本账-总体情况汇总表</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
</head>
<body >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>
    <#include "/accountMenu.ftl">
<#else>
    <#include "/inputAccountMenu.ftl">
</#if>-->
<#include "/secondToolbar.ftl">
<style type="text/css">
    .layui-input{
        display: inline;
        border-radius:4px !important;
        border:1px solid #cfcfcf;
        width: 131px !important;
        height: 35px;
    }
    html{
        height: auto !important;
        overflow: auto !important;
    }
    .easyui-dialog form > div span.textbox{
        width: 400px !important;
    }

    #toolbar .textbox-text{
        background-color: #f3f8f6;
    }

    #searchDiv{
        left: 0% !important;
    }
    html{
        min-width: 1024px !important;
    }
    .textbox{
        border: 1px solid #45b97c;
        width: 170px !important;
    }
    .combo-arrow{
        background-color: #f3f8f6;
    }
    #queryTime{
        width: 170px !important;
        border: 1px solid #45b97c;
        background-color: #f3f8f6;
    }
</style>

<!-- datagrid -->
<div class="easyui-layout" fit=true style="padding:0px 30px 60px  30px;width: 100%;background-color: #f3f8f6" id="myPrint">

    <input type="hidden" id="authority" value="${authority!}">
    <div id="toolbar">
        <div style="border-bottom: none" id="searchBar">
            <form id="searchForm" style="background-color: #f3f8f6;">
                <div style="width: 100%;text-align: center;"><font style="font-size: 180%;font-weight: bold !important;">漳州市八闽快讯(一本账)总体情况汇总表</font>
                    <a onclick="Ams.doPrint('myPrint')" id="printImg" class="printing-button" style=" cursor:pointer; display: inline-block;float: right;font-size: 14px; width: 98px; line-height: 40px;color: white; background-color: #45b97c; border-radius: 3px;margin-right: 50px;margin-top: 10px;text-align: center;" >
                        <span style="font-size: 28px; vertical-align: middle" class="icon iconcustom"/></span> 打印
                    </a>
                </div>
            <#--<div id="message" style="width: 100%;text-align: center;font-size: 120%;font-weight: bold;color:white;background-color:#676767;"></div>-->
                <div class="dc-info-box">
                    <p id="timeid">2019 年 05 月，《八闽快讯》（专报件）共通报</p>
                    <div class="entry-list">
                        <div class="entry-item">
                            <span id="tcwtDetail"></span>
                            <p><i id="tcwt">0</i> 个</p>
                        </div>
                        <div class="entry-item">
                            <span >完成整改</span>
                            <p><i id="wczg">0</i> 个</p>
                        </div>
                        <div class="entry-item">
                            <span>继续整改 </span>
                            <p><i id="jxzg">0</i> 个</p>
                        </div>
                        <div class="entry-item">
                            <span>未达到序时进度</span>
                            <p><i
                             id="wddxs">0</i> 个</p>
                        </div>
                    </div>
                </div>
                <a href="javascript:void(0)" style="position:relative; margin: 10px;float: left;" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-add'" onclick="addTask()">新增任务</a>
                <div id="searchDiv" style="width: 100%">
                    <select class="easyui-combobox" name="status" id="status">
                        <option value="">全部</option>
                        <option value="3">完成整改</option>
                        <option value="2">继续整改</option>
                        <option value="1">未达到序时进度</option>
                    </select>
                    <input id="queryTime" type="text" class="layui-input" style="height:35px;width:156px;position: relative;top:2px;" readonly="">
                    <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                </div>

            </form>
        </div>

    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100]">
        <thead>
        <tr>
            <th field="createTime" width="60px" formatter="Ams.stdDateFormat">创建时间</th>
            <th field="relationName" width="120px" formatter="Ams.tooltipFormat">归类</th>
            <th field="problem" width="120px" formatter="Ams.tooltipFormat">问题</th>
            <th field="targetRequire" width="120px" formatter="Ams.tooltipFormat">整改目标要求</th>
            <th field="existingProblem" width="120px" formatter="Ams.tooltipFormat">整改进展及存在问题</th>
            <th field="status" width="120px" formatter="statusFormat">备注</th>
            <th field="opera" width="120px" data-options="formatter:opera">操作</th>
        </tr>
        </thead>
    </table>


    <!-- 引入底部文字提示 main -->
<#include "/moudles/debriefing/tips-font.ftl"/>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input type="hidden" name="uuid" id="uuid">
        设置状态：&emsp;
        <div style="right: -38px;width: 300px;">
            <label><input type="radio" name="status" value="3" style="position: relative;top: 10px;">完成整改</label>&emsp;
            <label><input type="radio" name="status" value="2" style="position: relative;top: 10px;">继续整改</label>&emsp;
            <label><input type="radio" name="status" value="1" style="position: relative;top: 10px;">未达到序时进度</label>
        </div>

    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveTask()"
       style="width:90px">确定</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<div id="dlg_one" class="easyui-dialog" style="width:600px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons_one'">
    <form id="fm_one" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input type="hidden" name="uuid" id="uuid">
        <div style="margin-bottom:10px">
            <input label="创建时间:" id="createtime" name="createtime" required="required" class="easyui-datebox" data-options="editable:false" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input type="hidden" name="relationName" id="relationName">
            <input class="easyui-combobox" name="relationCode" required="required" id="relationSelect" data-options="
						url:'/environment/attach/getRelationNameList?relation=task',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'350px'"
                   label="归类:" style="width:400px;height:40px;">
        </div>
        <div style="margin-bottom:10px">
            <input name="problem" class="easyui-textbox" data-options="required:true,label:'问题:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
        </div>
        <div style="margin-bottom:10px">
            <input name="targetRequire" class="easyui-textbox" data-options="required:true,label:'整改目标要求:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
        </div>
        <div style="margin-bottom:10px">
            <input name="existingProblem" class="easyui-textbox" data-options="required:true,label:'整改进展及存在问题:',validType:'maxLength[1300]'" multiline="true" style="width: 100%; height: 120px">
        </div>
    </form>
</div>
<div id="dlg-buttons_one">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg_one').dialog('close')" style="width:90px">取消</a>
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script>

    //操作
    function opera(val, row, index) {
        var uuid = row.uuid;
        return '<div>'+Ams.setImageSet()+'<a href="javascript:void(0)" class="easyui-linkbutton" onclick="setStatus('+index+')">设置状态</a>'
                +"&emsp;"+Ams.setImageEdit()+"<a href='#' class='easyui-linkbutton' onClick=\"edit('"+index+"')\">编辑</a>"
                +"&emsp;"+Ams.setImageDelete()+"<a href='#' class='easyui-linkbutton' onClick=\"del('"+uuid+"')\">删除</a></div>";
    }


  
    //编辑
    function edit(index){
        $('#dg').datagrid('selectRow',index);// 关键在这里
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $('#dlg_one').dialog('open').dialog('center').dialog('setTitle', '修改信息');
            $('#fm_one').form('clear');
            $('#fm_one').form('load', row);
            //$('#uuid').textbox({readonly: true});
            var date = Ams.dateFormat(row.createTime, 'yyyy-MM-dd');
            $("#createtime").datebox("setValue",date);
        }
    }

    //保存
    function save(){
        var relationName=$("#relationSelect").combobox('getText');
        $("#relationName").val(relationName);
        $('#dlg_one #fm_one').form('submit', {
            url:  Ams.ctxPath + '/environment/attach/saveCommonTaskTable',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg_one').dialog('close');
                    $('#dg').datagrid('load');
                    //getDescript($("#queryTime").val().trim());
                    Ams.success(result.message);
                }
            }
        });
    }

    //删除
    function del(uuid){
        if (uuid) {
            $.messager.confirm("提示信息", "确认删除？", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/attach/delete',
                        data: {
                            'uuid': uuid
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg').datagrid('load');
                                getDescript($("#queryTime").val().trim());
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

    function statusFormat(value,row, index){
        if(value==3){
            return "<span title='完成整改 ' style='color:green;'>完成整改 </span>";
        }else if(value==2){
            return "<span title='继续整改 ' style='color:red;'>继续整改 </span>";
        }else{
            return "<span title='未达到序时进度' >未达到序时进度 </span>";
        }
    }

    function setStatus(index){
        $('#dg').datagrid('selectRow',index);// 关键在这里
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '设置状态');
            $('#fm').form('clear');
            $('#uuid').val(row.uuid);
            $("input[name='status'][value='"+row.status+"']").prop("checked",true);
            url = '${request.contextPath}/environment/attach/setStatus';
        }
    }

    function saveTask() {
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
                    getDescript($("#queryTime").val().trim());
                    Ams.success(result.message);
                }
            }
        });
    }

    function addTask(){
        window.open('${request.contextPath}/environment/attach/environmentAttachAddTask');
    }

    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //年选择器
        var queryTime = laydate.render({
            elem: '#queryTime',
            type: 'month',
            format: 'yyyy-MM',
            max: getNowDate(0),
            //value: getNowDate(30),
            btns: ['confirm'],
            /* done: function(value, date){ //监听日期被切换
                doSearch(value);
               } */
        });

    });

    /* $("#status").combobox({
        onChange: function (n,o) {
            var queryTime= ;
            doSearch($("#queryTime").val().trim());
        }
    }); */

    $(function(){
        var authority=$("#authority").val();
        if(authority=='1'){
            $("#searchForm").children("a").hide();
            $("#searchForm").children("#searchDiv").css("left","78%");
            $('#dg').datagrid('hideColumn','opera');
        }
        $("#queryTime").val(getNowDate(0));
        doSearch();
    });

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
        var queryTime = $("#queryTime").val().trim();
        if(isNoEmpty(queryTime)){
            $('#dg').datagrid({
                url: '${request.contextPath}/environment/attach/getPageList',
                queryParams: {
                    status: $('#status').val(),
                    queryTime: queryTime
                }
            });
            getDescript(queryTime);
        }

    }

    function getDescript(queryTime){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/attach/getDescript",
            async : true,
            data: {
                status: $('#status').val(),
                queryTime: queryTime
            },
            dataType: "json",
            success: function(data){
                var status1=data.status1;
                var status2=data.status2;
                var status3=data.status3;
                if(data.status1 == undefined ){
                    status1=0;
                }
                if(data.status2 == undefined ){
                    status2=0;
                }
                if(data.status3 == undefined ){
                    status3=0;
                }
                var temp=data.sum-data.lastSum;
                if(temp<0){
                    temp=0;
                }
                var month = queryTime.split("-")[1] != "10"?queryTime.split("-")[1].replace("0",""):queryTime.split("-")[1];
                $('#timeid').text("截至"+queryTime.split("-")[0]+"年"+month+"月，《八闽快讯》（专报件）共通报");
                $('#tcwt').text(data.sum);
                $('#tcwtDetail').text("突出环境问题（上期"+data.lastSum+"个，本期新增 "+temp+"个）");
                $('#wczg').text(status3);
                $('#jxzg').text(status2);
                $('#wddxs').text(status1);
//                var html="截至 <font style='color:yellow'>"+queryTime.split("-")[0]+"</font> 年 <font style='color:yellow'>"+queryTime.split("-")[1]+"</font> 月，" +
//                        "《八闽快讯》（专报件）共通报突出环境问题 <font style='color:yellow'>"+data.sum+"</font> 个（上期 <font style='color:yellow'>"+data.lastSum+"</font> 个，本期新增 <font style='color:yellow'>"+temp+"</font> 个），" +
//                        "已完成整改 <font style='color:yellow'>"+status3+"</font> 个，继续整改 <font style='color:yellow'>"+status2+"</font> 个，" +
//                        "未达到序时进度 <font style='color:yellow'>"+status1+"</font> 个";
              //  $("#message").html(html);
            },
            error: function(r){console.log(r);}
        });
    }

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth()+1;
        if(month>0 && month <10){
            month="0"+month;
        }
        var date = d.getDate();
        var currentdate = year+"-"+month;
        return currentdate;
    }

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