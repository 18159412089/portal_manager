<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>测试页面</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>

	<#include "/secondToolbar.ftl">
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
				<span style="margin-left:126px;color:red;">*时间间隔最多为一个月</span><br>
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
				<label class="control-label">查询时间：</label>
				<div class="control-div">
					<input id="attYearMonth" name="attYearMonth" class="easyui-datebox"  style="width: 139px; height:30px;" />
					<input id="attYear" name="attYear" class="easyui-datebox"  style="width: 139px; height:30px;" />
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
		
		
	
		setInterval(function test(){
			console.info("1")
		}, 1000*60);
		
		$(function() {
			// $.ajax({
			// 	type: 'POST',
			// 	dataType : 'json',
			// 	url: '/sys/menu/getFrontSecondAndChileMenu',
			// 	data : {
			// 		pids : "8cc443b5-53d2-4db0-b2f7-f0901df961ea"
			// 	},
			// 	// beforeSend: ajaxLoading,
			// 	success: function(data){
			// 			console.info(data)
			//
			// 			// listHtml +="<li class='item' onclick='updateMap("+data[i].longitude+","+data[i].latitude+","+data[i].pointCode+",\""+data[i].monitrorTime+"\""+",\""+color+"\""+",\""+data[i].pointName+"\""+","+data[i].pointType+")'><span class='ranking'><span>"+(i+1)+"</span></span>";
			// 			// listHtml +="<span class='title'>"+data[i].pointName+"</span>";
			// 			// listHtml +="<span class='newTime'>"+data[i].monitrorTime+"</span>";
			// 			// listHtml +="<span class='data'><span class='"+color+"'>"+data[i].aqi+"</span></span></li>";
			// 		// $("#city").html(listHtml);
			//
			// 	}
			// });
		});
		
		//格式化日期
		function myformatter(date) {
		    //获取年份
		    var y = date.getFullYear();
		    //获取月份
		    var m = date.getMonth() + 1;
		    return y + '-' + m;
		}
		
		
		function doSearch(){
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/environment/debrief/getCompareCounty",
					data : {
						"startTime" : "2018-01",
						"endTime" : "2018-06"
					},
					dataType: "json",
					success: function(result){
						console.info(result);
					},
					error: function(r){console.log(r);}
				});
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
