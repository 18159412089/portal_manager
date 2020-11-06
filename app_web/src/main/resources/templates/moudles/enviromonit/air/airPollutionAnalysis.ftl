<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>单站点多污染物过程分析</title> <#include "/header.ftl"/>
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
				<label for="riverSystem" class="control-label">选择站点：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryPoint" id="queryPoint" data-options="
						url:'${request.contextPath}/enviromonit/airMonitorPoint/getPonitList',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">时间步长：</label>
				<div class="control-div">
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="hour" checked/>
						<span class="lbl">小时</span>
					</label>
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="day"/>
						<span class="lbl">天</span>
					</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">查询时间：</label>
				<div class="control-div">
					<input id="queryStartTime" name="queryStartTime" class="easyui-datetimebox" style="width: 139px;height:30px;"
					data-options="showSeconds:false">
				</div>
				<span>-</span>
				<div class="control-div">
					<input id="queryEndTime" name="queryEndTime" class="easyui-datetimebox" style="width: 139px; height:30px;"
					data-options="showSeconds:false">
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
			//$('#queryPoint').combobox('setValue',['600603','350600101'])
			//alert($('#queryPoint').combobox('getValues'));
			//doSearch();
		});
		$('#queryStartTime').datetimebox().datetimebox('calendar').calendar({
            validator: function(date){
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                return d1>=date;
            }
        });
        $('#queryEndTime').datetimebox().datetimebox('calendar').calendar({
             validator: function(date){
                    var time = $('#queryStartTime').val().replace(/-/g,"/");
                    var d2 = new Date(time);
                    var now = new Date();
                    var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                    
                    return date <= d1 && date >=d2;
            }
        });
        $('#queryStartTime').datetimebox({
            onSelect: function (select) {
                $('#queryEndTime').datetimebox('setValue','');
                $('#queryEndTime').datetimebox().datetimebox('calendar').calendar({
                    validator: function (date) {
                        var d1 = new Date(select);
                        var d3 = new Date();
                        return d1 <= date  && date <= d3;
                    }
                });
            }
        });
		function doSearch(){
			
			var type = $('input[name="queryTimeUnit"]:checked').val();
			var points = $('#queryPoint').combobox('getValues')+"";
			var queryStartTime = $("#queryStartTime").val();
			var queryEndTime = $("#queryEndTime").val();
			if(queryStartTime==""||queryEndTime==""){
                $.messager.alert('提示', '时间区间不允许为空！');
                return 0;
            }
            if(points == ""){
                $.messager.alert('提示', '站点不允许为空！');
                return 0;
            }
			var startTime;
			var endTime;
			if(type=="hour"){
				startTime = queryStartTime.substring(0,13);
				endTime = queryEndTime.substring(0,13);
			}else if(type=="day"){
				startTime = queryStartTime.substring(0,10);
				endTime = queryEndTime.substring(0,10);
			}
			if(calTwoDate(queryStartTime, queryEndTime)){
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/airDataService/getPointDateByHour",
					data : {
						"type" : type,
						"points" : points,
						"startTime" : startTime,
						"endTime" : endTime
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
							setAllSitesBar(pollutionAnalysis, result[j].county, result[j].xAxis, result[j].series);
						} 
					},
					error: function(r){console.log(r);}
				});
			}else{
				$.messager.alert('提示', '时间间隔相差超过1个月！');
			}
		}
		
		function setAllSitesBar(pollutionAnalysis, title, xAxis, series){
			pollutionAnalysis.clear();
    		var option = {
                    title: {
                        text: title,
                        textStyle:{
                            fontSize: 16
        				},
                        left:'10',
        				top:'10'
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
                    legend: {
                        orient: 'horizontal',
                        top: '8%',
                        right:'30',                        
                        data: ['PM2.5','PM10','SO2','NO2','CO','O3-8h'],
                        selected: {
        					'PM2.5': true,
        					'PM10': false,
        					'SO2': false,
        					'NO2': false,
        					'CO': false,
        					'O3-8h': false
        				}
                    },
                    grid: {
                        top:'80',
                        left: '50',
                        right: '30',
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
                    yAxis: [{
                        type: 'value',
                        axisLabel:{
                            formatter:'{value}(μg/m3)'
                        }
                    },{
                    	type: 'value',
                    	axisLabel:{
                            formatter:'{value}(mg/m3)'
                        }
                    }],
                    series: series
                };
    		pollutionAnalysis.setOption(option);
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
