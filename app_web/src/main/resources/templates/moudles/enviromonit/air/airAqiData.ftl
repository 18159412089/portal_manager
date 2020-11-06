<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
		"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>空气质量在线监测数据查询</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="${request.contextPath}/static/testing.css">

<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/upload/webuploader.css">
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css" />
<link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css" />
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css" />
<script type="text/javascript"
	src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/progressbar.js"></script>

</head>
<body ondragstart="return false"
	style="padding:20px;background:#ffffff;">

	<div class="data-details-container">
		<div class="data-details-head">
			<div class="title l">数据来源：福建省环保在线监控数据共享平台</div>
			<div class="data-details-toolbar">
				<div class="btn btn-link">
					<span class="icon fa-copy"></span> 导出
				</div>
				<div class="btn btn-link">
					<span class="icon fa-refresh"></span> 刷新
				</div>
				<div class="btn btn-link">
					<span class="icon fa-globe"></span> GIS分析
				</div>
			</div>
		</div>
		<div class="data-details-search" id="searchBar">
			<div class="form-group">
				<label class="control-label">测点信息:</label>
				<div class="control-div">
					<input id="queryCity" name="queryCity" class="easyui-textbox" style="width: 128px; height:34px;">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">开始日期：</label>
				<div class="control-div">
					<input id="startTime" name="startTime" class="easyui-datebox"style="width: 128px; height:34px;"  data-options="value:'Today'">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label">结束日期：</label>
				<div class="control-div">
					<input id="endTime" name="endTime" class="easyui-datebox"style="width: 128px; height:34px;"  data-options="value:'Today'">
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary" type="submit" onclick="doSearch()">
						<span class="fa-search mr6"></span>查询
					</button>
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary" onclick="doReset()">
						<span class="fa-search mr6"></span>重置
					</button>
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary"  onclick="openSearch()">
						<span class="fa-search mr6"></span>列选项
					</button>
				</div>
			</div>
		</div>
		
		<div class="easyui-layout" fit=true style="margin-top:20px;height:500px;">
			<table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
		  		url="${request.contextPath}/enviromonit/air/araqidata/list_" data-options="
		       		rownumbers:true,
		       		singleSelect:true,
		       		striped:true,
			        autoRowHeight:false,
			        fitColumns:true,
			        fit:true,
			        pagination:true,
			        pageSize:10,
			        pageList:[10,30,50]">
		        <thead data-options="frozen:true">
		        <tr>
		            <th field="arMonitorPoint" width="120px">测点信息</th>
		            <th field="aqi" width="120px">AQI指数</th>
		            <th field="level" width="120px">级别</th>
		            <th field="status" width="120px">状况</th>
		            <th field="pollutant" width="120px">首要污染物</th>
		            <th field="monitorTime" width="150px" formatter="Ams.timeDateFormat">修改时间</th>
		        </tr>
		        </thead>
	    	</table>
	    </div>
	</div>
		
	<div id="dd" class="easyui-dialog" style="width:400px;height:250px;"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
	</div>
	<div id="dlg-buttons">
	    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="selectCloumn()"
	       style="width:90px">保存</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
	       onclick="$('#dd').dialog('close')" style="width:90px">取消</a>
	</div>
<script>
	/*表单提交*/
	$.extend({
	    StandardPost:function(url,args){
	        var form = $("<form method='post'></form>"),
	            input;
	        form.attr({"action":url});
	        $.each(args,function(key,value){
	            input = $("<input type='hidden'>");
	            input.attr({"name":key});
	            input.val(value);
	            form.append(input);
	        });
	        $("body").append(form); 
	        form.submit();
	    }
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
	var columnArr = [];
	var columns = JSON.parse('${columns}');
	for(var i in columns) {
		if(columns[i].hasOwnProperty("formatter") ){
			columns[i]['formatter']=valueFormat;
		}
	}
	columnArr.push(columns);
	var limit = JSON.parse('${limit}');
	$('#dg').datagrid({
		columns : columnArr
		
	});
	
	function valueFormat(value, row, index) {
        if (undefined == value || '' == value) {
            return "";
        } else {
        	for(var i in limit){
        		if(value == row[limit[i].field]){
        			if(limit[i].max!='' && limit[i].max<row[limit[i].field]) {
        			return "<span title='" + value + "' style='color:#F00'>" + value + "</span>";
        			} else if (limit[i].min!='' && limit[i].min>row[limit[i].field]){
        				return "<span title='" + value + "' style='color:#F00'>" + value + "</span>";
        			}else{
        				return "<span title='" + value + "' >" + value + "</span>";
        			}
        		}
        	}
        }
        
    }
	/*查询*/
	function doSearch() {
		$('#dg').datagrid('load', {
			pointCity : $("#queryCity").val().trim(),
			startTime : $("#startTime").val().trim(),
			endTime : $("#endTime").val().trim()
		});
	}

	/*重置*/
	function doReset() {
		$("#searchBar").form('clear');
		doSearch();
	}
	/*选择列*/
	function selectCloumn() {
			$('#dd').dialog('close'); 
			var box = document.getElementsByName("record");
			var objArray = box.length;
			var apiContentStr="";
			
			for(var i=0;i<objArray;i++){
				if(box[i].checked == true){
					apiContentStr += box[i].id+"-";
				} 
			}
			var pointCity = $("#queryCity").val().trim();
			
			var startTime = $("#startTime").val().trim();
			var endTime = $("#endTime").val().trim();
			/*加载窗口中的多选框*/
			
			$.StandardPost('${request.contextPath}/enviromonit/air/araqidata',{str:apiContentStr,id:'37765f9e-8a6a-4a67-923c-62ff6e86ba00'});
	}
	
	/*打开列选项窗口*/
	function openSearch(){
	
		
		$('#dd').dialog('open'); 
		
		
		/*加载窗口中的多选框*/
		$.post('${request.contextPath}/enviromonit/air/araqidata/getChecks',{'id':'37765f9e-8a6a-4a67-923c-62ff6e86ba00','check':"${string}"},function(data){
				
				var listHtml=''; 
				var j = 0;
				$.each(data,function(i){ 
					listHtml += "<div style='float:left; padding:20px; padding-left:50px;'>";
					listHtml += "<span class='checkbox inputbox' >";
					j=j+1;
				    listHtml += "<input type='checkbox' id="+data[i].id+" name='record'  class='checkbox-value' >"; 
					
					listHtml += "<lable>"+data[i].name+"</lable>";
					listHtml += "</span></div>";
				}); 
				$("#dd").html(listHtml); 
				/*设置多选框是否选中*/
				$.each(data,function(k){
					
					if (data[k].check == "1"){
						$("#"+data[k].id).prop("checked",true); 
					}else{
						$("#"+data[k].id).prop("checked",false); 
					}
				});
				
		},"json");

	}
	
</script>
	
	
</body>
</html>