<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
		"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>本年各级别天数变化分析</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/css/progressbar.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/css/base.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/testing.css" />

<script type="text/javascript"
	src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/progressbar.js"></script>
<style type="text/css">
	input[readonly]{
		background-color: #fff;
	}
</style>
</head>
<body ondragstart="return false"
	style="padding:20px;background:#ffffff;">

	<div class="data-details-container">
		
		<div class="data-details-search">
			<div class="form-group">
				<label class="control-label" id="lb_name">行政区：</label>
				<div class="control-div">
					<input id="queryArea" class="easyui-combobox" name="queryArea" style="height: 32px; width: 140px;" data-options="
						url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
						method:'post',
						editable:false,
						valueField:'uuid',
						textField:'name',
						multiple:false,
						panelHeight:'auto'">
				</div>
			</div>

			<div class="form-group">
				<label for="riverSystem" class="control-label">年份：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryYear" id="queryYear" data-options="
						url:'/enviromonit/airDataService/getYearList',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'130px'"
						style="width:100px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary" type="submit" onclick="doSearch()">
						<span class="fa-search mr6"></span>查询
					</button>
				</div>
			</div>
		
			<div class="r grade-legend">
				<div class="legend">
					<span class="item excellent"></span>优（0-50） <span class="item good"></span>良（51-100）
					<span class="item mild"></span>轻度（101-150） <span
						class="item moderate"></span>中度（151-200） <span class="item severe"></span>重度（201-300）
					<span class="item dangerous"></span>严重（301-500） <span class="item"></span>暂无数据
				</div>
			</div>

		</div>

		<div class="data-details-chart grade-legend">
			<table class="annual-chart-table"
				style="margin-top:20px;margin-bottom:20px">
				<caption id="titleId">2017年AQI指数全年分布图</caption>
				<tbody id="dgbody">
				
				</tbody>
			</table>
		</div>
		<div class="easyui-layout" fit=true style="margin-top:20px">
			<table id="dg" class="easyui-datagrid"
				style="width:100%;height:auto;" toolbar="#toolbar"
				
				data-options="
		            rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:false,
		            fitColumns:true,
		            fit:true,
		            <!-- pagination:true, -->
		            pageSize:12,
		            pageList:[12]">
				<thead>
					<th field="month" width="100px">月份</th>
					<th field="days" width="100px">有效监测天数</th>
					<th field="ExDays" width="100px">一级天数</th>
					<th field="gdDays" width="100px">二级天数</th>
					<th field="ratio" width="100px">优良天数比例(%)</th>
					<th field="other" width="100px">劣于二级天数</th>
					<th field="plt" width="100px">重污染天数</th>
					</tr>
				</thead>
			</table>

		</div>


	</div>
	
	<div id="air" class="easyui-window" title="详细信息" c class="easyui-dialog" style="width:300px;height:320px;background:#ffffff;"
    	 data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
		<div class="map-panel">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top">
	       				<span id="cityName"></span><span class="subtext fr" id="monitrorTime"></span>
	       			</div>
	       			<div class="panel-group-body" >
	       				<table class="table-info" id="pointTableInfo" style="width: 298px; margin-top:10px;">
						</table>      				
	       			</div>
	       		</div>
	    </div>	
	</div>
</div>

<script type="text/javascript">


	//第一行列标题
	var columnName = "<tbody id=\"dgbody\"><tr><td class=\"no-border\"></td>";
	for(var i=1; i<32; i++) {
		columnName += '<td class="no-border">'+i+'</td>';
	}
	columnName += "</tr>";
		
	$(function() {
		$('#queryArea').combobox('setValue','350600');
		//----------------年份初始化----------------
		var nowDate = new Date();
		var year = nowDate.getFullYear();
		var i=1;
		
		
		$("#queryYear").combobox({
			onLoadSuccess: function () { //数据加载完毕事件
				var date = new Date();
				var year = date.getFullYear();
				$(this).combobox('select', year);
				if(i==1){
					doSearch();
					i++;
				}
				
			}
		})
	});
	
	function doSearch() {
		var year = $("#queryYear").val();
		var pointCode = $("#queryArea").val();
		$("#titleId").html(year+"年AQI指数全年分布图");
		$.ajax({
			type : 'POST',
			url : '${request.contextPath}/enviromonit/airQualityDailyAnalysis/airAqiForYear',
			async : true,
			data:{
				//category : "daily",
				pointCode : pointCode,
				time : year
			},
			success : function(result) {
				var data = eval(result);
				var columns = columnName;
				for(var i=1; i<13; i++) {
					columns+="<tr><td class=\"no-border\">"+i+"</td>";
					for(var j=1; j<32; j++) {
						var info = new Object();
						
						var x = i<10?"0"+i : i;
						var y = j<10?"0"+j : j;
						var day = new Date(year,i,0);
						var days = x+"-"+y;
						
						info.pointName = data[days+"pointName"];
						info.time = data[days+"time"];
						info.aqi = data[days+"aqi"];
						info.PM10 = data[days+"PM10"];
						info.PM2 = data[days+"PM2"];
						info.CO = data[days+"CO"];
						info.NO2 = data[days+"NO2"];
						info.O3 = data[days+"O3"];
						info.SO2 = data[days+"SO2"];
						if(j>day.getDate()){
							break;
						}
						if(data[x+'-'+y]==undefined){
							columns+='<td class="item"></td>';
						} else {
							columns+='<td class="item '+data[days]+'"dataStr='+JSON.stringify(info)+ ' style="text-align:center;" onclick=openInfo(this,"'+year+'","'+days+'","'+pointCode+'")>'
							+data[days+'pollute']+'</td>';
						}
					}
					columns+="</tr>";
				}
				$("#dgbody").replaceWith(columns+"</tbody>");
			},
			error : function() {},
			dataType : 'json'
		});
		
		$('#dg').datagrid('options').url = '${request.contextPath}/enviromonit/airQualityDailyAnalysis/LevelDaysList';
		$('#dg').datagrid('load', {
			pointCode : $("#queryArea").val(),
			time : year
		});

	};
	function openInfo(obj,year,days){
		var data = JSON.parse($(obj).attr("dataStr"))
		var html = "<tr ><td class='tit' style='text-align:center;'>地区</td><td class='tit' style='text-align:center;'>"+isNull(data.pointName)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>时间</td><td class='tit'style='text-align:center;'>"+isNull(data.time)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>AQI</td><td class='tit'style='text-align:center;'>"+isNull(data.aqi)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>PM2.5</td><td class='tit'style='text-align:center;'>"+isNull(data.PM2)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>PM10</td><td class='tit'style='text-align:center;'>"+isNull(data.PM10)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>CO</td><td class='tit'style='text-align:center;'>"+isNull(data.CO)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>NO2</td><td class='tit'style='text-align:center;'>"+isNull(data.NO2)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>O3</td><td class='tit'style='text-align:center;'>"+isNull(data.O3)+"</td></tr>"
		+"<tr><td class='tit'style='text-align:center;'>SO2</td><td class='tit'style='text-align:center;'>"+isNull(data.SO2)+"</td></tr>";
		
		
		 $("#pointTableInfo")[0].innerHTML= html;
		//alert(days);
		$('#air').window('open');
	}
	
		/*判断值是否为空*/
	function isNull(value){
		if(value == null){
			return '-';
		}else{
			return value;
		}
	}
	//EasyUI datagrid 动态导出Excel
	/*function ExporterExcel() {
	      //获取Datagride的列
	      var rows = $('#dg').datagrid('getRows');
	      var columns = $("#dg").datagrid("options").columns[0];
	      var oXL = new ActiveXObject("Excel.Application"); //创建AX对象excel 
	      var oWB = oXL.Workbooks.Add(); //获取workbook对象 
	      var oSheet = oWB.ActiveSheet; //激活当前sheet
	      //设置工作薄名称
	      oSheet.name = "导出Excel报表";
	      //设置表头
	      for (var i = 0; i < columns.length; i++) {
	        oSheet.Cells(1, i+1).value = columns[i].title;
	      }
	      //设置内容部分
	      for (var i = 0; i < rows.length; i++) {
	        //动态获取每一行每一列的数据值
	        for (var j = 0; j < columns.length; j++) {        
	          oSheet.Cells(i + 2, j+1).value = rows[i][columns[j].field];
	        }  
	      }       
	      oXL.Visible = true; //设置excel可见属性
	}*/
</script>

</body>
</html>