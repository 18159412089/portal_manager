<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
<title>数据折线图</title> <#include "/header.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/testing.css">

<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/upload/webuploader.css">
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css" />
<link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css" />
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css" />
<link rel="stylesheet" href="${request.contextPath}/static/css/progressbar.css" />
<script src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script src="${request.contextPath}/static/upload/webuploader.js"></script>
<script src='${request.contextPath}/static/js/fileUpload.js'></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>

<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css" />
</head>
<!-- body -->
<body ondragstart="return false" style="padding: 5px; background: #ffffff;">
	<div class="data-details-container">
		<div class="data-details-search">
			<div class="form-group">
				<label for="riverSystem" class="control-label">数据类型：</label>
				<div class="control-div">
					<select name="queryType" id="queryType" class="easyui-combobox" data-options="editable:false" style="width:220px;">
						<option value="分钟" selected="selected">分钟数据</option>
						<option value="小时">小时数据</option>
						<option value="day">天数据</option>
						<option value="month">月数据</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label">时间：</label>
				<div class="control-div">
					<input id="startTime" name="startTime" class="easyui-datebox" data-options="value:'Today'" style="width: 150px;">
					<input id="endTime" name="endTime" class="easyui-datebox" data-options="value:'Today'" style="width: 150px;">
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<a href="${request.contextPath}/env/pollution/factor/getColumn?uuid=${pointUuid}" class="easyui-linkbutton" data-options="iconCls:'icon-back'">数据列表</a>
				</div>
			</div>
		</div>

		<div class="data-details-chart">
			<div id="waterQualityRate" style="height: 420px; width: 100%; display: inline-block;"></div>
		</div>
	</div>

	<script type="text/javascript">
	 	var result_str='${result!}';
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
	
		$(function() {
			var result=JSON.parse(result_str);
			var legend_data = result.title;
			var series_data = result.series;
			
			setData(legend_data,series_data);
		});
		
		var waterQualityRateChart = echarts.init(document.getElementById('waterQualityRate'));
		function setData(value1,value2){
			waterQualityRateChart.clear();
			// 基于准备好的dom，初始化echarts实例
			var option = {
				    tooltip : {
				        trigger: 'item',
				        formatter : function (params) {
				            return params.value[0]+'<br>'+params.value[1];
				        }
				    },
				    dataZoom: {
				        show: true,
				        start : 0
				    },
				    legend : {
				        data : value1
				    },
				    grid: {
				        y2: 80
				    },
				    xAxis : [
				        {
				            type : 'time',
				            splitNumber:5
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series :   value2
				};
			// 使用刚指定的配置项和数据显示图表。
			waterQualityRateChart.setOption(option,true);
		}
		
		function doSearch() {
			$.ajax({
				type: "post",
				url:  Ams.ctxPath + "/env/pollution/TestData/getDataFlush",
				data: {
					pointuuid : '${pointUuid}',
					test_type : $("#queryType").val().trim(),
					startTime : $("#startTime").val().trim(),
					endTime : $("#endTime").val().trim()
				}, 
				dataType: "json",
				success: function(result){
					var legend_data2 = result.title;
					var series_data2 = result.series;
					setData(legend_data2,series_data2);
				}
			});
		}
		
		function timeFn(dateBegin,dateEnd) {
		    var dateDiff = dateEnd.getTime() - dateBegin.getTime();//时间差的毫秒数
		    var dayDiff = Math.floor(dateDiff / (24 * 3600 * 1000));//计算出相差天数
		    var leave1=dateDiff%(24*3600*1000)    //计算天数后剩余的毫秒数
		    var hours=Math.floor(leave1/(3600*1000))//计算出小时数
		    //计算相差分钟数
		    var leave2=leave1%(3600*1000)    //计算小时数后剩余的毫秒数
		    var minutes=Math.floor(leave2/(60*1000))//计算相差分钟数
		    //计算相差秒数
		    var leave3=leave2%(60*1000)      //计算分钟数后剩余的毫秒数
		    var seconds=Math.round(leave3/1000)
		    console.log(" 相差 "+dayDiff+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒")
		    console.log(dateDiff+"时间差的毫秒数",dayDiff+"计算出相差天数",leave1+"计算天数后剩余的毫秒数"
		        ,hours+"计算出小时数",minutes+"计算相差分钟数",seconds+"计算相差秒数");
		    return dayDiff;
		}
	</script>

</body>

</html>
