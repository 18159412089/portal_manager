<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>水环境生态作战图</title>
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
   	
   	<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
    <div title="国控断面" style="padding:20px;display:none;">
		<!-- datagrid -->
			<div class="easyui-layout" fit=true>
			    <div id="toolbar">
			        <div  id="searchBar" class="searchBar">
			            <form id="searchForm">
			               <div class="inline-block">
                               <label  class="textbox-label textbox-label-before" title="选择站点">选择站点：</label>
                               <input class="easyui-combobox" name="sectionName" id="sectionName" prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/water/wtSectionPoint/getPointsList?type=1',
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
			    </div>
			    <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 100%;">
			    	<table id="dg" class="easyui-datagrid" style="width: 100%;"></table>
			    </div>
			    
			</div>
	 </div>
    <div title="省控断面"  style="width:100%;height:100%;">
		<!-- datagrid -->
			<div class="easyui-layout" fit=true>
			    <div id="toolbar1">
			        <div style="padding:3px;" id="searchBar1">
			            <form id="searchForm1">
			                <label  class="textbox-label textbox-label-before" title="字典类型">选择站点：</label>
			                <input class="easyui-combobox" name="sectionName1" id="sectionName1" prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/water/wtSectionPoint/getPointsList?type=2',
									editable:false,
									method:'get',
									valueField:'id',
									textField:'text',
									multiple:false,
									panelHeight:'350px'"
			                       style="width:156px;height:33px;">
			                 <label  class="textbox-label textbox-label-before" title="字典类型">监测时间：</label>
                			<input id="queryMeasureStartTime1" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch1()">查询</a>
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset1()">重置</a>
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
			    </div>
			    <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 100%;">
			    	<table id="dg1" class="easyui-datagrid" style="width: 100%;"></table>
			    </div>
			    
			</div>
	  </div>
     
</div>
   	

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
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
 
    layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年选择器
		var startTime = laydate.render({
			elem: '#queryMeasureStartTime',
			type: 'year',
			format: 'yyyy',
			max: getNowDate(0),
			//value: getNowDate(30),
			btns: ['confirm'],
			done: function(text,date){
                var d2 = new Date();
                $("#queryMeasureEndTime").val("");
			 }
		});
	  });
    
    layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年选择器
		var startTime = laydate.render({
			elem: '#queryMeasureStartTime1',
			type: 'year',
			format: 'yyyy',
			max: getNowDate(0),
			//value: getNowDate(30),
			btns: ['confirm'],
			done: function(text,date){
                var d2 = new Date();
                $("#queryMeasureEndTime").val("");
			 }
		});
	  });
    function initQueryForm(){
    	 $('#queryMeasureStartTime').val(new Date().format("yyyy") );
    	 $('#queryMeasureStartTime1').val(new Date().format("yyyy") );
     }
    initQueryForm();
    
    $('#tt').tabs({
        border:false,
        onSelect:function(title){
    	   if(title == "省控断面"){
    		   getColumnList(2);
    	   }else{
    		   getColumnList(1);
    	   }
        }
    });
    
    
    
    //动态获取列名
    
    function getColumnList(type){
    	var target = "";
    	var toolStr = "#toolbar";
    	if(type == "1"){
    		toolStr = "#toolbar";
    		target = $('#dg');
    	}else{
    		toolStr = "#toolbar1";
    		target = $('#dg1');
    	}
    	var yearNum = new Date().format("yyyy");
    	$.ajax({
    		type: "post",
    		url:  "${request.contextPath}/enviromonit/water/wtReportData/getSectionWaterLevelForMonth",
    		data : {type:type,year:yearNum},
    		dataType: "json",
    		success: function(result){
    		  if(result.length >0){ 
    			  renderColumn(result[0],target,toolStr);
    			  showMonitorMonthData(type);
    		  }
    		},
    		error: function(r){console.log(r);}
    	});
    }
     function renderColumn(reslut,target,toolStr){
      
	   var columnMonth = reslut.months;
	   var columnResultQualitys = reslut.resultQualitys;
       var columnArr =[];
       var d = new Date();
       //var lastYearNum = new Date().format("yyyy")-1+"年水质";
       var currentYearNum = new Date().format("yyyy")+"年水质目标";
       columnArr.push({field:'name',title:'考核断面名称',width:100});
       columnArr.push({field:'targetQuality',title:''+currentYearNum+'',width:100,formatter: function(value,row,index){
    	
		    return changeLevelNum(row.targetQuality);
		 }});
       
       for(var i = 0 ; i < columnMonth.length; i++){
    	   columnArr.push({
    		   field:''+columnMonth[i]+'',
    		   title:''+columnMonth[i]+'',
    		   width:100, index:''+i+'', 
    		  formatter: function(value,row,index){
    		  for(var i = 0 ; i<row.resultQualitys.length;i++){
    			    if(this.field== row.months[i]){
    			    	return changeLevelNum(row.resultQualitys[i]);
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
		target.datagrid({
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
			toolbar: toolStr,
		    pagination:false, 
		    onLoadSuccess: function(data){
				//填充颜色
				 var trs = $(this).prev().find('div.datagrid-body').find('tr');
		          for(var i = 0 ; i<trs.length;i++){
		        	  for (var j = 2; j < trs[0].cells.length; j++) {
		        		  trs[i].cells[j].style.cssText = changeLevelColor($(trs[i].cells[j]).text());
		        	  }
		         }		          
		   }
		});
	    target.datagrid('getPager').pagination({
			onSelectPage:function(pageNumber, pageSize){
		         getMonthDataList(pageNumber,pageSize);
			}
		});
	    
    }
    
 
	
	function showMonitorMonthData(type ,stationName) {
        
        var page = 1;
		var pageSize = 20;
	    getMonthDataList(stationName,type, page,pageSize);
	}
	
	//根据每个月监测数据
	function getMonthDataList(stationName,type ,page, pageSize) {
		var yearNum = null ;
		if(type == 1){
			  yearNum = $('#queryMeasureStartTime').val();
		}else{
			 yearNum = $('#queryMeasureStartTime1').val();
		}
	    $.ajax({
			type : 'POST',
			url:  "${request.contextPath}/enviromonit/water/wtReportData/getSectionWaterLevelForMonth",
		    data : {
		    	'stationName':stationName,
				'type':type,
				'year':yearNum,
				'page': page,
				'pageSize': pageSize
			},
			success : function(result) {
				if(type == 1){
					$("#dg").datagrid("loadData",  {total : result.maxSize,rows : result});
				}else{
					$("#dg1").datagrid("loadData", {total : result.maxSize,rows : result});
				}
				
			},
			error: function(){
			}
		});
	}

	 function doReset() {
	        $("#searchBar").find("#searchForm").form('clear');
	         doSearch();
	 }
    
	 
	 function doReset1() {
	        $("#searchBar1").find("#searchForm1").form('clear');
	        doSearch1();
	 }
	 
    function doSearch(){
    	var span1 =$( $(".datagrid-cell-c3-targetQuality").find("span")[0]);
    	span1.text($("#queryMeasureStartTime").val()+"年水质目标");
    	showMonitorMonthData( 1,$("#sectionName").combobox('getValue'));
    }
    function doSearch1(){
    	var span1 =$( $(".datagrid-cell-c4-targetQuality").find("span")[0]);
    	span1.text($("#queryMeasureStartTime1").val()+"年水质目标");
    	showMonitorMonthData( 2,$("#sectionName1").combobox('getValue'));
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
   
    function changeLevelNum(str){
    	var strNum ="";
    	switch(str){
    	case 1:
    		strNum = "Ⅰ";
    		  break;
    	case 2:
    		strNum = "Ⅱ";
  		  break;
    	case 3:
    		strNum = "Ⅲ";
  		  break;
    	case 4:
    		strNum = "Ⅳ";
  		  break;
    	case 5:
    		strNum = "Ⅴ";
  		  break;
    	case 6:
    		strNum = "劣Ⅴ";
  		  break;
    	case "-":
    		strNum = "-";
  		  break;
    	}
    	return strNum;
    }
     function changeLevelColor(str){
    	var color = 'background-color:#b8b8b8;';
    	switch(str){
    	case "Ⅰ":
    		color = 'background-color:#2ba4e9;';
    	  break;
    	case "Ⅱ":
    		color = 'background-color:#2ba4e9;';
  		  break;
    	case "Ⅲ":
    		color = 'background-color:#45b97c;';
  		  break;
    	case "Ⅳ":
    		color = 'background-color:#FFFF00;';
  		  break;
    	case "Ⅴ":
    		color = 'background-color:#f47920;';
  		  break;
    	case "劣Ⅴ":
    		color = 'background-color:#d02032;';
 		  break;
    	default:
    		color = 'background-color:#ffffff;';
  		  break;
    	}
    	return color;
    }
 
    
</script>
</body>
</html>