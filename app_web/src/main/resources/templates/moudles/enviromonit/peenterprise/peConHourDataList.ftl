<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>小时监测数据</title>
	<#include "/header.ftl"/>
   	<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
   	<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
	<div data-options="region: 'west',title:'企业监测点位',split: true" style="width:16%;" >
			<div class="input-group" >
               <input type="text" class="form-control fjzx-prog-string" placeholder="企业名称" fjzx_field_name="enterpriseIdName" fjzx_field_tip_name="企业名称">
               <span class="input-group-btn">
             	   <a href="javascript:void(0)"  id="searchbutton"  class="easyui-linkbutton btn-primary">查询</a>
               </span>
	      </div>
		<ul id="peEnterpriseDataTree"></ul>
	</div>
	<div data-options="region: 'center',title:'企业监测数据',split: true" style="width:84%;">
	    <div id="toolbar">
	        <div id="searchBar" class="searchBar">
	            <form id="searchForm">
	              <div class="inline-block">
					  <label class="textbox-label textbox-label-before" title="监测开始时间">监测开始时间</label>
                      <input id="queryMeasureStartTime" name="queryMeasureStartTime" class="easyui-datetimebox" data-options="editable:false"  style="width:280px;">
				  </div>
	               <div class="inline-block">
					   <label class="textbox-label textbox-label-before" title="监测截止时间">监测截止时间</label>
                       <input id="queryMeasureEndTime" name="queryMeasureEndTime" class="easyui-datetimebox" data-options="editable:false"  style="width:280px;">
				   </div>
	                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
	                <!-- <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a> -->
	            </form>
	        </div>
	    </div>
		<div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 100%;">
			<table id="monitorDeviceDataTable" class="easyui-datagrid" style="width: 100%;"></table>
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

	initQueryForm();
    function initQueryForm(){
        $('#queryMeasureStartTime').val(new Date().format("yyyy-MM-dd")+" 00:00:00");
        $('#queryMeasureEndTime').val(new Date().format("yyyy-MM-dd")+" 23:59:59");
    }
    
    
    function doSearch() {
        if(peEnterpriseDataTree!=null){
        	var node = peEnterpriseDataTree.tree('getSelected');
        	if(node==null || "MONITOR_POINT"!=node.attributes.nodeType){
        		$.messager.show({
                    title: '提示',
                    msg: "请选择需要调阅的企业监测点位。"
                });
        		return false;
        	}
    		showMonitorDeviceData(node.attributes);
        }
    }

    function doReset() {
        //$("#searchBar").find("#searchForm").form('clear');
        initQueryForm();
        doSearch();
    }
    //点击树的筛选按钮事件
	$("input[fjzx_field_name=enterpriseIdName]").bind('keyup',function(event){
		if(event.keyCode=="13") $("#searchbutton").click();
	});
	$("#searchbutton").click(function(){
	    var enterpiseName =$("input[fjzx_field_name=enterpriseIdName]").val();
	    $('#peEnterpriseDataTree').tree({  
			url:'${request.contextPath}/enterprise/peenterprisedata/getPeEnterpriseDatasTreeList',
		    loadFilter:function(data){
		    	  var newData = new Array(); 
		    	  var datas = data[0].children;
		    	  if(enterpiseName != null && enterpiseName !=""){
			    	  for(var i=0; i<datas.length; i++){  
			               if(datas[i].text.search(enterpiseName)!=-1){  
			                	   newData.push(datas[i]);  
			                 } 
			              }  
			    	  if(newData.length == 0 ){
			    		  var obj =[{
				    		  "attributes": "Object { nodeType:'ROOT' }",
				    	      "id": "1dKYkJqVx51o72hMzwo93S",
				    	      "state": "open",
				    	      "text": "企业监测点位",
			    		  }]
			    		  return obj;
			    	  }
			    	  return newData; 
		    	  }
		          return data;  
		    }   
		});  
	 });
    
    var peEnterpriseDataTree = null;
    peEnterpriseDataTree = $('#peEnterpriseDataTree').tree({
        url:'${request.contextPath}/enterprise/peenterprisedata/getPeEnterpriseDatasTreeList',
        animate: false,//是否显示动画效果
        lines: false,//是否显示树线条
        data: null,//要加载的节点数据
        //formatter: function(node){
        //},
        onClick: function(node){
        	var nodeType = node.attributes.nodeType;
        	if("MONITOR_POINT"==nodeType){
        		showMonitorDeviceData(node.attributes);
        	}
        }
    });
	
	//数据详情
	function showMonitorDeviceData(record) {
        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
        
		var outputId = record.outputId;
		var page = 1;
		var pageSize = 20;
		
		getMonitorDeviceDataTableColumn(outputId,pageSize);
		getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
	}

	//初始化监测数据列表
    $('#monitorDeviceDataTable').datagrid({
		toolbar: '#toolbar'
	});

	//获取监测数据列表标题
	function getMonitorDeviceDataTableColumn(outputId,pageSize){
		$.ajax({
			type : 'POST',
			url : Ams.ctxPath + '/factor/pefactor/getPeFactorListColumnTitleByOutputId',
			dataType : 'json',
			data : {
				'outputId' : outputId
			},
			success : function(data) {
				var columnList = data.peFactorColumnArray;
				var peFactorColumnThreshold = data.peFactorColumnThreshold;
				//遍历获取到的监测数据，判断相应监测值是否超标
				for(var i=0;i<columnList.length;i++){
					var column = columnList[i];	
					var threshold = peFactorColumnThreshold[column.field];
					columnList[i] = validateMonitorDeviceData(column, threshold);
				}
				var fitColumns = false;
				if(columnList.length<=16){
					fitColumns = true;
				}
				//初始化监测数据列表
				$('#monitorDeviceDataTable').datagrid({
					fit : true,
					nowrap : true,
					fitColumns : fitColumns,
					columns : [columnList],
					view : bufferview,
					rownumbers : true,
					singleSelect : true,
					autoRowWidth : true,
					autoRowHeight : false,
					pagination: true,
					pageSize : pageSize,
					toolbar: '#toolbar',
					onLoadSuccess: function(data){
					}
				});
				
				$('#monitorDeviceDataTable').datagrid('getPager').pagination({
					onSelectPage:function(pageNumber, pageSize){
				        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
				        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
						getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime, pageNumber,pageSize);
					}
				});
			}
		});
	}
	//校验监测数据是否超标，超标数据背景色为红色高亮
	function validateMonitorDeviceData(column,threshold){
		if(threshold != undefined && threshold.isUsed==='1'){
			var upLimit = Number(threshold.upLimit)*1000;
			var lowLimit = Number(threshold.lowLimit)*1000;
			//标题加上报警阈值范围
			if(upLimit==0 && lowLimit==0){
				column.title = column.title + "(mg/L)";
			}else{
				column.title = column.title + "(mg/L)<br/>["+lowLimit+","+upLimit+"]"
				//给超标数据所在单元格设置样式
				column.styler = function(val,row,index){
					var result = "";
					var value = val==null ? 0 : Number(val);
					if(upLimit<value || lowLimit > value){
						result = 'background-color:#FF0000;';
					}
					return result;
				}
			}
		}
		return column;
	}

	//根据排口获取小时监测数据
	function getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime, page, pageSize) {
		if (outputId == null){
			return;
		}
		
		$.ajax({
			type : 'POST',
			url : Ams.ctxPath + '/hourData/peconhourdata/getPeConHourDataListByOutputId',
			dataType : 'json',
			data : {
				'outputId' : outputId,
				'queryMeasureStartTime' : $("#queryMeasureStartTime").val().trim(),
				'queryMeasureEndTime' : $("#queryMeasureEndTime").val().trim(),
				'page': page,
				'pageSize': pageSize
			},
			success : function(result) {
				console.log(result.data);
				$("#monitorDeviceDataTable").datagrid("loadData", {total : result.maxSize, rows : result.data});
			},
			error: function(){
			}
		});
	}
    function exportData() {
        var outputId;
        if(peEnterpriseDataTree!=null){
            var node = peEnterpriseDataTree.tree('getSelected');
            if(node==null || "MONITOR_POINT"!=node.attributes.nodeType){
                $.messager.show({
                    title: '提示',
                    msg: "请选择需要调阅的企业监测点位。"
                });
                return false;
            }
            showMonitorDeviceData(node.attributes);
            outputId = node.attributes.outputId;
        }
        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
        var page = 1;
        var pageSize = 20;
        window.open(Ams.ctxPath + '/hourData/peconhourdata/export?queryMeasureStartTime='+queryMeasureStartTime+'&queryMeasureEndTime='+queryMeasureEndTime+
                '&outputId='+outputId+'&page='+page+'&pageSize='+pageSize);

    }
</script>
</body>
</html>