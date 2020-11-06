<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>国家水质自动监测分析</title> <#include "/header.ftl"/>
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
	<style type="text/css">
		input[readonly]{
			background-color:white;
		}
		.data-details-chart{
			border-top:1px solid #c8c8c8;
		}
	</style>
</head>
<!-- body -->
<body ondragstart="return false" style="background: #ffffff;">
	<div class="data-details-container">
		<div class="data-details-search">
			<div class="form-group">
				<label for="riverSystem" class="control-label">选择站点：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryPoint" id="queryPoint"  data-options="
						url:'/enviromonit/water/wtCityPoint/getPointList?type=1',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
						style="width: 156px;height:33px;">
				</div>
			</div>
			<div class="form-group" id="form-group1">
				<#--<span style="margin-left:126px;color:red;">*时间间隔最多为30天</span><br>-->
				<label class="control-label">查询时间：</label>
				<div class="control-div">
					<input id="queryStartTime1" name="queryStartTime" class="easyui-datetimebox" style="width: 156px;height:33px;"
					data-options="showSeconds:false,editable:false">
				</div>
				<span>-</span>
				<div class="control-div">
					<input id="queryEndTime1" name="queryEndTime" class="easyui-datetimebox" style="width: 156px;height:33px;"
					data-options="showSeconds:false,editable:false">
				</div>
			</div>
			
			<div class="form-group">
				<label class="control-label">监测参数：</label>
				<div class="control-div">
				<!-- /enviromonit/water/wtCityFactor/getFactorList?type=2 -->
					<input class="easyui-combobox" name="queryFactor" id="queryFactor" data-options="
						url:'/enviromonit/water/wtHourData/getPollutes',
						editable:false,
						method:'get',
						valueField:'key',
						textField:'text',
						multiple:true,
						panelHeight:'150px'"
						style="width: 156px;height:33px;">
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
		<div id="parent">
			<div class="data-details-chart" id="">
				<div id="pollutionAnalysis0" style="height: 500px;width:100%; display: inline-block;"></div>
			</div>
		</div>
		
	</div>

	<script type="text/javascript">
	
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
		
		$('#queryStartTime1').datetimebox().datetimebox('calendar').calendar({
			validator: function(date){
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return d1>=date;
			}
		});
		$('#queryEndTime1').datetimebox().datetimebox('calendar').calendar({
			 validator: function(date){
					var now = new Date();
					var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
					return d1>=date ;
			}
	    });
		
	   /* $('#queryStartTime1').datetimebox({
	        onSelect: function (select) {
	        	$('#queryEndTime1').datetimebox('setValue','');
	            $('#queryEndTime1').datetimebox().datetimebox('calendar').calendar({
	                validator: function (date) {
	                    // var startDate = $('#startDate').datebox('getValue');
	                    var d1 = new Date(select);
	                    var d2 = new Date(select.getFullYear(), select.getMonth(), select.getDate()+30);
	                    var d3 = new Date();
	                    return d1 <= date && date <= d2 && date <= d3;
	                }
	            });
	        }
	    });*/
		
	    
		$(function(){
			//doSearch();
		});
		function doSearch(){
			var paramnames = $("#queryFactor").val().trim();
			var pointCode = $("#queryPoint").val().trim();
			var startTime = $("#queryStartTime1").val().substring(0,13);
			var endTime = $("#queryEndTime1").val().substring(0,13);
			
			if(isEmpty(pointCode)){
				$.messager.alert('提示', '请选择查询站点！');
			}else if(isEmpty(startTime)||isEmpty(endTime)){
				$.messager.alert('提示', '请选择查询时间！');
			}else if(isEmpty(paramnames)){
				$.messager.alert('提示', '请选择监测参数！');
			}else{
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getPointsDateByHour",
					data : {
						"pointCode" : pointCode,
						"paramname" : paramnames,
						"startTime" : startTime,
						"endTime" : endTime
					},
					dataType: "json",
					success: function(result){
						var array = $('#parent').children('.data-details-chart');
						for(var i=0;i<array.length;i++){
							array[i].remove();
						}
						for(var j=0;j<result.length;j++){
							$("#parent").append("<div class='data-details-chart'>"+
							"<div id='pollutionAnalysis"+(j)+"' style='height:500px;width:100%;display:inline-block;'></div></div>");
						}
						for(var j in result){
							var pollutionAnalysis = echarts.init(document.getElementById('pollutionAnalysis'+j));
							setEcharts(pollutionAnalysis, result[j].legend, result[j].title, result[j].formatter, result[j].xAxis, result[j].series,result[j].legendBar,result[j].min);
						} 
					},
					error: function(r){console.log(r);}
				});
			}
		}
		
		function setEcharts(pollutionAnalysis, legend, title, formatter, xAxis, series ,legendBar ,min){
			pollutionAnalysis.clear();
    		var option = {
                    title: {
                        text: title,
                        textStyle:{
                            fontSize: 16
        				},
                        left:'50%',
        				top:'5%'
                    },
                    tooltip : {
                        trigger: 'axis',
                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    toolbox: {
                        show: true,
                        orient: 'vertical',
                        left: '10',
                        top: 'center',
                        iconStyle: {
                        	borderColor: '#ffffff'
                        },
                        feature: {
                            magicType: {show: true, type: ['line', 'bar']},
                            saveAsImage: {show: true},
                            restore: {show: true}
                        }
                    },
                    legend: [
                    	{
                            orient: 'vertical',
                            left:'5',                        
                            data:legendBar
                        },
                    	{
                            orient: 'vertical',
                            right:'5',                        
                            data:legend
                        }
                    ],
                    grid: {
                        top:'80',
                        left: '80',
                        right: '20',
                        bottom: '10',
                        containLabel: true
                    },
                    xAxis:  {
                        type: 'category',
                        axisLabel:{
                            type:'category'
                        },
                        data: xAxis
                    },
                    color:['#81b22f','#f3d71c','#f4b9a9'],
                    yAxis: {
                        type: 'value',
                        min:min,
                        axisLabel:{
                            formatter: formatter
                        }
                    },
                    series:series
                };
    		pollutionAnalysis.setOption(option);
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
		
		function isEmpty(obj){
		    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
		        return true;
		    }else{
		        return false;
		    }
		}
	</script>
</body>
</html>
