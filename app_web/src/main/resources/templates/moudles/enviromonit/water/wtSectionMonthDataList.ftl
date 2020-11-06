<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>手工监测数据</title>
	<#include "/header.ftl"/>
	<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
	<style type="text/css">
		.layui-input{
			display: inline;
		}
	</style>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
 	<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
   	<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div  id="searchBar" class="searchBar">
            <form id="searchForm">
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="选择站点">选择站点：</label>
                    <input class="easyui-combobox" name="sectionName" id="sectionName" prompt="全部" data-options="
						url:'${request.contextPath}/enviromonit/water/wtSectionPoint/getPointsList?type=0',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'350px'"
                           style="width:156px;height:33px;">
                </div>
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="监测时间">监测时间：</label>
                    <input id="queryMeasureStartTime" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
                    <span>-</span>
                </div>
                <div class="inline-block">
                    <input id="queryMeasureEndTime" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
                </div>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
    <#--<@sec.authorize access="hasAuthority('sys:user:add')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newUser()">新增</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:role:edit')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editUser()">修改</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:user:enable')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock_open'" onclick="enableUser()">启用</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:user:disable')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="disableUser()">禁用</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:user:resetPwd')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetPwd()">重置密码</a>
    </@sec.authorize>-->
        <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-large-smartart'" onclick="importWtSectionMonthData()">导入数据</a>
    </div>
    <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 100%;">
    	<table id="dg" class="easyui-datagrid" style="width: 100%;"></table>
    </div>
    
</div>


<!-- dialog2 -->
<div id="dlg-file" class="easyui-dialog" style="width: 600px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-file-buttons',maximizable:true,maximized:false">
    <div style="padding: 0px 29px;">
        <form id="fm-file" method="post" novalidate style="margin: 0; padding: 20px 50px">
            <div style="margin-bottom: 10px;display: none;">
                <label class="textbox-label textbox-label-before" title="主界面图片">文件:</label>
                <input name="headImgId1" id="headImgId1" class="easyui-textbox" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
            </div>
        </form>
        <!-- uploader_moreIconId -->
        <div class="multiple-file-container" style="width:80%;">
            <div class="multiple-title"><h3>数据导入</h3></div>
            <div class="multiple-content">
                <div id="uploader" class="wu-example">
                    <div class="btns">
                        <div id="uploader_headImgId"  class="easyui-linkbutton"> 选择文件</div>
                        <div id="ctlBtn"  class="start-upload easyui-linkbutton show-hidden"><span class="iconfont icon-upload"></span> 开始导入</div>
                    </div>
                </div>
                <div id="thelist" class="uploader-list thelist"></div>
            </div>
        </div>
    </div>
</div>
<div id="dlg-file-buttons">
    <#--<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveFile()" style="width: 90px">确认</a>-->
    <a href="javascript:void(0)" class="easyui-linkbutton uploadDialogClose" iconCls="icon-cancel" onclick="$('#dlg-file').dialog('close')" style="width: 90px">关闭</a>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).hide();
        });
       
    };
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年选择器
		var startTime = laydate.render({
			elem: '#queryMeasureStartTime',
			type: 'month',
			format: 'yyyy-M',
			max: getNowDate(0),
			//value: getNowDate(30),
			btns: ['confirm'],
			done: function(text,date){
                var d2 = new Date();
                $("#queryMeasureEndTime").val("");
				endTime.config.max = {
					year: d2.getFullYear(),
					month: d2.getMonth(),
					date: date.date
				};
				endTime.config.min = {
					year: date.year,
					month: date.month-1,
					date: date.date
				}
			}
		});
		
		//年月选择器
		var endTime = laydate.render({
			elem: '#queryMeasureEndTime',
			type: 'month',
			format: 'yyyy-M',
			//value: getNowDate(0),
			min: getNowDate(365)+"-1",
			max: getNowDate(0)+"-1",
			
			btns: ['confirm'],
			done: function(text,date){ 
			}
		});
		
		window.doReset = function(){
	        $("#searchBar").find("#searchForm").form('clear');
	        var start = new Date(getNowDate(365));
	        var end = new Date();
	        endTime.config.max = {
					year: end.getFullYear(),
					month: end.getMonth(),
					date: end.getDate()
				};
			endTime.config.min = {
				year: start.getFullYear(),
				month: start.getMonth(),
				date: start.getDate()
			}
	        $("#startTime").val(getNowDate(365));
			$("#endTime").val(getNowDate(0));
	        doSearch();
	    }
	});
    Date.prototype.format = function(format){ 
    	var o = {   
	        "M+" : this.getMonth()+1,                 //月份   
	        "d+" : this.getDate(),                    //日   
	        "H+" : this.getHours(),                   //小时   
	        "m+" : this.getMinutes(),                 //分   
	        "s+" : this.getSeconds(),                 //秒   
	        "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	        "S"  : this.getMilliseconds()             //毫秒   
    	};   
    	if(/(y+)/.test(format)){
    		format=format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
    	} 
   		for(var k in o){
	        if(new RegExp("("+ k +")").test(format)){
		    	format = format.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	        }   
   		}
    	return format;   
    };
    
    function doSearch(){
    	showMonitorMonthData( $("#sectionName").combobox('getValue'));
    }
    
    
    function initQueryForm(){
 
        $('#queryMeasureStartTime').val(new Date().format("yyyy")+"-01" );
        $('#queryMeasureEndTime').val(new Date().format("yyyy-MM"));
    }
    initQueryForm();
    //动态获取列名
	$.ajax({
		type: "post",
		url:  "${request.contextPath}/enviromonit/water/wtSectionMonthData/getSectionWaterLevelColumn",
		data : {},
		dataType: "json",
		success: function(result){
			   renderColumn(result);
		},
		error: function(r){console.log(r);}
	});
    
	function renderColumn(reslut){
       var columnCodeArr =	reslut.columnCodes;
       var columnNameArr =	reslut.columnNames;
       var columnArr =[];
       columnArr.push({field:'sectionName',title:'断面名称',width:100});
       columnArr.push({field:'dateTime',title:'时间',width:100});
       columnArr.push({field:'dateTimeOrder',title:'时间',width:100,hidden:'true'});
       
       for(var i = 0 ; i < columnCodeArr.length; i++){
    	   columnArr.push({
    		   field:''+columnCodeArr[i]+'',
    		   title:''+columnNameArr[i]+'',
    		   width:100, index:''+i+'', 
    		   formatter: function(value,row,index){
    		   for(var i = 0 ; i<row.codePollutants.length;i++){
    			    if(this.field== row.codePollutants[i]){
    			    	return row.polluteValues[i];
    			    	break;
    			    }
    			}
    		   return '-';
    		 }})
       }
       
		var page = 1;
		var pageSize = 20;
	    
		var fitColumns = false;
		if(columnArr.length<=16){
			fitColumns = true;
		}
	  //初始化监测数据列表
		$('#dg').datagrid({
			fit : true,
			 nowrap : true,
			fitColumns : fitColumns,
		    columns:[columnArr],
			view : bufferview,
			rownumbers : true,
			singleSelect : true,
			autoRowWidth : true,
			autoRowHeight :false,
			pagination: true,
			pageSize : pageSize,
			toolbar: '#toolbar',
			sortName: 'dateTimeOrder',
		    sortOrder: 'desc',
		    remoteSort: false,
			pagination:false,
			onLoadSuccess: function(data){
		 
			}
		});
	  
		$('#dg').datagrid('getPager').pagination({
			onSelectPage:function(pageNumber, pageSize){
		        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
		        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
		        getMonthDataList('',queryMeasureStartTime,queryMeasureEndTime, pageNumber,pageSize);
			}
		});
	    
    }
    
	showMonitorMonthData('');
	
	function showMonitorMonthData(station) {
        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
 
       
        var page = 1;
		var pageSize = 20;
		getMonthDataList(station,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
	}
	
	//根据每个月监测数据
	function getMonthDataList(station, queryMeasureStartTime,queryMeasureEndTime, page, pageSize) {
  		$.ajax({
			type : 'POST',
			url :"${request.contextPath}/enviromonit/water/wtSectionMonthData/getWtSectionMonthMonitorDataList",
			dataType : 'json',
			data : {
				'stationName' :station,
				'queryMeasureStartTime' : queryMeasureStartTime.toString(),
				'queryMeasureEndTime' :   queryMeasureEndTime.toString(),
				'page': page,
				'pageSize': pageSize
			},
			success : function(result) {
			 
				$("#dg").datagrid("loadData", {total : result.maxSize,rows : result.data});
			},
			error: function(){
			}
		});
	}


    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        $('#queryMeasureStartTime').datebox('setValue',getNowDate(29).substring(0,10));
        $('#queryMeasureEndTime').datebox().datebox('calendar').calendar({
            validator: function (date) {
                var start = $('#queryMeasureStartTime').datebox('getValue').replace(/-/g,"/");
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                return d1>=date && new Date(start) <=date;
            }
        });
        $('#queryMeasureEndTime').datebox('setValue',getNowDate(0).substring(0,10));

        $('#queryMeasureStartTime').datebox('setValue','');
        $('#queryMeasureEndTime').datebox('setValue','');
        doSearch();
    }

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth()+1;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var date = d.getDate();
        if (date >= 0 && date <= 9) {
            date = "0" + date;
        }
        var hours = d.getHours();
        if (hours >= 0 && hours <= 9) {
            hours = "0" + hours;
        }
        var minutes = d.getMinutes();
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        var seconds = d.getSeconds();
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
        return currentdate;
    }

    function isNoEmpty(obj){
        if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
            return false;
        }else{
            return true;
        }
    }

    function importWtSectionMonthData(){
        $('#dlg-file').dialog('open').dialog('center').dialog('setTitle', '导入监测数据');
        $('#uploader_headImgId').fileUploader('reset');

        $('#fm-file').form('clear');
    }
    function saveFile() {
        var headImgId = $("#headImgId1").val();
        /* if($('#thelist').is(':has(*)') == false) */
        $.messager.confirm("提示信息", "确认选择的附件是否上传,继续提交?", function (r) {
            if (r) {
                $('#dlg-file').dialog('close');
                var html="";
                if(headImgId == "" || headImgId == null || headImgId == undefined){
                    html="<li><label class='textbox-label textbox-label-before' title='文件'>文件</label><img src='${request.contextPath}/static/images/file-remove-1.png"
                            +"' alt='未上传附件或附件无法正常显示' style='width: 210px;height: 160px'></li>";
                }else{

                    html="<li><label class='textbox-label textbox-label-before' title='头像'>头像</label><img src='${request.contextPath}/file/download/"+headImgId
                            +"' alt='未上传附件或附件无法正常显示' style='width: 210px;height: 160px'>";

                    $("#headImgId").textbox("setValue", headImgId);
                    $('#pictures').html(html);
                }
            }
        });
    }
    /* --------------------------上传附件功能开始------------------------------------------------- */
    $(function(){
        $('#uploader_headImgId').fileUploader({
            dlg:'dlg-file',//新增修改弹出框
            server:'${request.contextPath}/enviromonit/water/wtSectionMonthData/importData',//文件接收服务端
            fileId:'headImgId1',//上传文件后返回到新增修改弹出框中的文件id
            fileNumLimit:1,
            accept: {
                title: '只允许上传Excel文档',
                extensions: 'xls,xlsx',// 允许的文件后缀
                mimeTypes: '.xls,.xlsx'
            },
            uploadBeforeSend: function(){
                $("#loadingDiv").css({"background":"#ffffffb3","z-index":"10000"}).fadeIn("normal");
            },
            uploadSuccess: function(){
                doSearch();
                $.messager.alert('提示', '数据导入成功！');

                $("#loadingDiv").fadeOut("normal", function () {
                    $(this).hide();
                });

            },
            uploadError: function(){
                $.messager.alert('提示', '数据导入出错，请检查Excel文件是否符合规范！');
                doSearch();

                $("#loadingDiv").fadeOut("normal", function () {
                    $(this).hide();
                });
            }
        });
    })
    
    	 
    
    /* --------------------------上传附件功能结束------------------------------------------------- */
</script>
</body>
</html>