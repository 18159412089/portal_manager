<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>站点污染物往月环比</title> <#include "/header.ftl"/>
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
						url:'${request.contextPath}/enviromonit/water/wtCityPoint/getPointsList?type=2',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'350px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label for="riverSystem" class="control-label">比较因子：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryFactor" id="queryFactor" data-options="
						url:'${request.contextPath}/enviromonit/water/wtHourData/getPollutes',
						method:'get',
						valueField:'key',
						textField:'text',
						multiple:false,
						panelHeight:'170px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label for="riverSystem" class="control-label">比较年月：</label>
				<div class="control-div">
					<input id="queryYearMonth" name="queryYearMonth" class="easyui-datebox" style="width:139px;height:30px;" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">时间步长：</label>
				<div class="control-div">
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="Hour" checked/>
						<span class="lbl">小时</span>
					</label>
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="Day"/>
						<span class="lbl">天</span>
					</label>
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
			$('#queryYearMonth').datebox({
				//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
				onShowPanel: function () {
				//触发click事件弹出月份层
			    span.trigger('click'); 
			    if (!tds)
			    	//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
			    	setTimeout(function() {
			    		tds = p.find('div.calendar-menu-month-inner td');
			    		tds.click(function(e) {
			    			//禁止冒泡执行easyui给月份绑定的事件
			    			e.stopPropagation();
			    			//得到年份
			    			var year = /\d{4}/.exec(span.html())[0] ,
			    			//月份
			    			//之前是这样的month = parseInt($(this).attr('abbr'), 10) + 1;
			    			month = parseInt($(this).attr('abbr'), 10);
			    			//隐藏日期对象
			    			$('#queryYearMonth').datebox('hidePanel')
			    			//设置日期的值
			    			.datebox('setValue', year + '-' + month);
			    		});
			    	}, 0);
			    },
			    //配置parser，返回选择的日期
			    parser: function (s) {
			    	if (!s) return new Date();
			    	var arr = s.split('-');
			    	return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
			    },
			    //配置formatter，只返回年月 之前是这样的d.getFullYear() + '-' +(d.getMonth()); 
			    formatter: function (d) { 
			    	var currentMonth = (d.getMonth()+1);
			    	var currentMonthStr = currentMonth < 10 ? ('0' + currentMonth) : (currentMonth + '');
			    	return d.getFullYear() + '-' + currentMonthStr; 
			    }
			});
			//日期选择对象
			var p = $('#queryYearMonth').datebox('panel');
			//日期选择对象中月份
			tds = false;
			//显示月份层的触发控件
			span = p.find('span.calendar-text'); 
			
			
			var curr_time = new Date();
			//设置前当月
			$("#queryYearMonth").datebox("setValue", myformatter(curr_time));
		});
		
		function doSearch(){
			var curr_time = new Date();
			var type = $('input[name="queryTimeUnit"]:checked').val();
			var point = $('#queryPoint').combobox('getValue');
			var pollutes = $('#queryFactor').combobox('getValue');
			var startTime = $('#queryYearMonth').combobox('getValue');
			var endTime = myformatter(curr_time);
			if(point == "" || point == null || point == undefined){
				$.messager.alert('提示', '请选择查询站点！');
			}else if(pollutes == "" || pollutes == null || pollutes == undefined){
				$.messager.alert('提示', '请选择查询因子！');
			}else if(startTime == "" || startTime == null || startTime == undefined){
				$.messager.alert('提示', '请选择比较年月！');
			}else{
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/water/wt"+ type +"Data/getPassMonthAnalysis",
					data : {
						pollutes:pollutes, 
						pointCode:point,
						startTime:startTime,
						endTime:endTime
					},
					dataType: "json",
					success: function(data){
						var pollutionAnalysis = echarts.init(document.getElementById('pollutionAnalysis0'));
						setEcharts(pollutionAnalysis, data.legend, data.title, data.formatter, data.xAxis, data.series);
					},
					error: function(r){console.log(r);}
				});
			}
		}
		
		function setEcharts(pollutionAnalysis, legend, title, formatter, xAxis, series){
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
                        data: legend
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
                    yAxis: {
                        type: 'value',
                        axisLabel:{
                            formatter: formatter
                        }
                    },
                    series: series
                };
    		pollutionAnalysis.setOption(option);
    	}
		
		//格式化日期
		function myformatter(date) {
		    //获取年份
		    var y = date.getFullYear();
		    //获取月份
		    var m = date.getMonth() + 1;
		    if (m >= 0 && m <= 9) {
		        m = "0" + m;
		    }
		    return y + '-' + m;
		}
	</script>
</body>
</html>
