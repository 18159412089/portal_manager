<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>月城市空气质量类别分析</title> <#include "/header.ftl"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/testing.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/progressbar.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/base.css" />
	
	<script type="text/javascript"
		src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript"
		src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
	<script type="text/javascript"
		src="${request.contextPath}/static/js/progressbar.js"></script>
</head>
<!-- body -->
<body ondragstart="return false" style="background: #ffffff;">
	<div class="data-details-container">
		<div class="data-details-search">
			<div class="form-group">
				<label for="riverSystem" class="control-label">选择城市：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryPoint" id="queryPoint" data-options="
						url:'${request.contextPath}/enviromonit/airMonitorPoint/getPointByType?type=1',
						method:'get',
						valueField:'uuid',
						textField:'name',
						multiple:true,
						panelHeight:'350px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label for="riverSystem" class="control-label">选择年份：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryYear" id="queryYear" data-options="
						url:'${request.contextPath}/enviromonit/airDataService/getYearList',
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
		</div>
		<div class="data-details-chart" id="parent0">
			<div id="pollutionAnalysis0" style="height: 350px;width:100%; display: inline-block;"></div>
		</div>
	</div>

	<script type="text/javascript">
	
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
	
		$(function() {
		    var date = new Date(); 
			$('#queryPoint').combobox('setValue','350600');
			$("#queryYear").combobox('setValue', date.getFullYear());
			doSearch();
		});
		function doSearch(){
			var points = $('#queryPoint').combobox('getValues')+"";
			var year = $('#queryYear').combobox('getValue');
			if(points == "" || points == null || points == undefined){
				$.messager.alert('提示', '请选择查询城市！');
			}else if(year == "" || year == null || year == undefined){
				$.messager.alert('提示', '请选择年份！');
			}else{
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/airDataService/getMonthQualityAnalysis",
					data : {
						"points" : points,
						"startTime" : year
					},
					dataType: "json",
					success: function(result){
						var array = $('#parent0').nextAll();
						for(var i=0;i<array.length;i++){
							array[i].remove();
						}
						for(var j=0;j<result.length-1;j++){
							$("#parent"+j).after("<div class='data-details-chart' id='parent"+(j+1)+"'>"+
							"<div id='pollutionAnalysis"+(j+1)+"' style='height:350px;width:100%;display:inline-block;'></div></div>");
						}
						for(var j in result){
							var pollutionAnalysis = echarts.init(document.getElementById('pollutionAnalysis'+j));
							setCharts(pollutionAnalysis, result[j].title, result[j].xAxis, result[j].series);
						} 
					},
					error: function(r){console.log(r);}
				});
			}
		}
		
		function setCharts(charts, title, xAxis, series){
			charts.clear();
    		var option = {
    	            title:{
    	                text:title
    	            },
    	            legend: {
    	                data:['优','良','轻度','中度','重度','严重']
    	            },
    	            tooltip : {
    	                trigger: 'axis',
    	                axisPointer : {
    	                    type : 'shadow'
    	                },
    	                formatter: function(params){
    	                    var res=params[0].name+"<br/>";
    	                    for(let i=0;i<params.length-1;i++){
    	                        res+=params[i].seriesName+":"+params[i].value+"<br/>"
    	                    }
    	                    return res;
    	                }
    	            },
    	            grid: {
    	                left: '3%',
    	                right: '4%',
    	                bottom: '3%',
    	                containLabel: true
    	            },
    	            xAxis : [
    	                {
    	                    type : 'category',
    	                    data : xAxis
    	                }
    	            ],
    	            yAxis : [
    	                {
    	                    type : 'value'
    	                }
    	            ],
    	            series : series
    	        };
    		charts.setOption(option);
    	}
		
		function calTwoDate(start, end){
			var d1 = start.replace(/\-/g, "/");
			var d2 = end.replace(/\-/g, "/");
			var date1 = new Date(d1);
			var date2 = new Date(d2);
			var sum = parseInt(date2 - date1)/(1000*60*60*24);
			if(sum>31){
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
