<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>在线月监测数据分析</title> <#include "/header.ftl"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/testing.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/progressbar.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/base.css" />
	<link rel="stylesheet" 
		href="${request.contextPath}/static/layui/css/layui.css"  media="all">
	
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
					<input class="easyui-combobox" name="queryPoint" id="queryPoint" data-options="
						url:'/enviromonit/water/wtCityPoint/getPointsList?type=2',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
						style="width:156px;height:33px;">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">查询时间：</label>
				<div class="control-div">
					<input id="queryStartTime" type="text" class="layui-input" style="width: 156px;height:33px;" readonly="">
				</div>
				<span>-</span>
				<div class="control-div">
					<input id="queryEndTime" type="text" class="layui-input" style="width: 156px;height:33px;" readonly="">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">监测参数：</label>
				<div class="control-div">
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
	<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		layui.use('laydate', function(){
			var laydate = layui.laydate;
			//年选择器
			var startTime = laydate.render({
				elem: '#queryStartTime',
				type: 'month',
				format: 'yyyy-M',
				max: getNowDate(0),
				//value: getNowDate(30),
				btns: ['confirm'],
				done: function(text,date){
	                var d2 = new Date();
	                $("#queryEndTime").val("");
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
				elem: '#queryEndTime',
				type: 'month',
				format: 'yyyy-M',
				//value: getNowDate(0),
				max: getNowDate(0)+"-1",
				btns: ['confirm'],
				done: function(text,date){ 
				}
			});
			
		});
	
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
	
		$(function() {
			//$('#queryPoint').combobox('setValue',['600603','350600101'])
			//alert($('#queryPoint').combobox('getValues'));
			//doSearch();
		});
		function doSearch(){
			var pollutes = $('#queryFactor').combobox('getValues')+"";
			var pointName = $('#queryPoint').combobox('getValues')+"";
			var startTime = $("#queryStartTime").val();
			var endTime = $("#queryEndTime").val();
			
			if(isEmpty(pointName)){
				$.messager.alert('提示', '请选择查询站点！');
			}else if(isEmpty(startTime)||isEmpty(endTime)){
				$.messager.alert('提示', '请选择查询时间！');
			}else if(isEmpty(pollutes)){
				$.messager.alert('提示', '请选择监测参数！');
			}else{
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/water/wtMonthData/getPointsDateByMonth",
					data : {
						"pointName" : pointName,
						"pollutes" : pollutes,
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
			var date = d.getDate();
			var currentdate = year+"-"+month;
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
