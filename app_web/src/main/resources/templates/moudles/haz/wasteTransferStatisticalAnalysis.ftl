<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
<title> 漳州生态云</title> <#include "/header.ftl"/>

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
		<#--<div class="data-details-head">-->
			<#--<div class="title fl" style="height: 50px"></div>-->
		<#--</div>-->
		<div class="data-details-search">
			<div class="form-group">
				<label class="control-label">年份：</label>
				<div class="control-div">
					<select class="form-control" style="width: 80px;" name="year"
						id="year">
						<option value="2019">2019年</option>
						<option value="2018" selected="selected">2018年</option>
						<option value="2017">2017年</option>
						<option value="2016">2016年</option>
					</select>
				</div>
				<label class="control-label">月份：</label>
				<div class="control-div">
					<select class="form-control" style="width: 60px;" name="startTime"
						id="startTime">
						<option value="01" selected="selected">1月</option>
						<option value="02">2月</option>
						<option value="03">3月</option>
						<option value="04">4月</option>
						<option value="05">5月</option>
						<option value="06">6月</option>
						<option value="07">7月</option>
						<option value="08">8月</option>
						<option value="09">9月</option>
						<option value="10">10月</option>
						<option value="11">11月</option>
						<option value="12">12月</option>
					</select>
					<label>至 </label>
					<select class="form-control" style="width: 60px;" name="endTime"
						id="endTime">
						<option value="01">1月</option>
						<option value="02">2月</option>
						<option value="03">3月</option>
						<option value="04">4月</option>
						<option value="05">5月</option>
						<option value="06">6月</option>
						<option value="07">7月</option>
						<option value="08">8月</option>
						<option value="09">9月</option>
						<option value="10">10月</option>
						<option value="11">11月</option>
						<option value="12" selected="selected">12月</option>
					</select>
				</div>
			</div>
			<div class="form-group" style="display: none;">
				<label class="control-label">区域：</label>
				<div class="control-div">
					<!--下拉框-->
					<select class="form-control" style="width: 80px;" name="qy"
						id="qy">
						<option value="zz" selected="selected">漳州市</option>
						<option value="xc">芗城区</option>
						<option value="lw">龙文区</option>
						<option value="yx">云霄县</option>
						<option value="zp">漳浦县</option>
						<option value="sa">诏安县</option>
						<option value="ct">长泰县</option>
						<option value="ds">东山县</option>
						<option value="nj">南靖县</option>
						<option value="ph">平和县</option>
						<option value="ha">华安县</option>
						<option value="lh">龙海市</option>
					</select>
					<!--下拉框-->
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="l-btn btn-blue" onclick="search()">
						<span class="fa-search mr6"></span>查询
					</button>
				</div>
			</div>
		</div>

		<div class="data-details-chart">
			<div id="wasteProduceNum" style="height: 560px; width: 45%; display: inline-block;"></div>
			<div id="wasteTransferNum" style="height: 560px; width: 45%; display: inline-block;"></div>
		</div>
	</div>

	<script type="text/javascript">
		function search(){
			
			var year = document.getElementById("year").value;//年份
			var startTime = year+"-"+document.getElementById("startTime").value;//开始月
			var endTime = year+"-"+document.getElementById("endTime").value;//结束月
			//var qy = document.getElementById("qy").value;
			var qytext=$("#qy option:selected");//区域
			var qy = qytext.text();
			
			$.ajax({
				type : 'POST',
				url: Ams.ctxPath + '/haz/enterpriseWasteInfo/getWasteProduceStatistics',
				async : true,
				data: {
					startTime:startTime,
					endTime:endTime,
					qy:qy
				},
				success : function(data) {
					setWasteProduce(data);//
				},
				error : function(jqXHR, textStatus, errorThrown) {
				},
				dataType : 'json'
			});
			$.ajax({
				type : 'POST',
				url: Ams.ctxPath + '/haz/enterpriseWasteInfo/getWasteTransferStatistics',
				async : true,
				data: {
					startTime:startTime,
					endTime:endTime,
					qy:qy
				},
				success : function(data) {
					setWasteTransfer(data);//
				},
				error : function(jqXHR, textStatus, errorThrown) {
				},
				dataType : 'json'
			}); 
		}
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
	
		$(function() {
			search();//
		});
		
		function setWasteProduce(data){
			var result = data.data;
			var arrayXName = new Array();
			var arrayNum = new Array();
			for(var i=0;i<result.length;i++){
				var x = result[i].rq;
				var num = result[i].num;
				arrayXName.push(x);
				arrayNum.push(num);
			}
			var jsonXStr = "["+arrayXName+"]";
			jsonXStr = eval('(' + jsonXStr + ')');
			var jsonNumStr = "["+arrayNum+"]";
			jsonNumStr = eval('(' + jsonNumStr + ')');
			var wasteProduce = echarts.init(document.getElementById('wasteProduceNum'));
			
			var wasteProduceOption = {
						    /* color: ['#77bef7'], */
						    title: {
						        text: '危险废物统计'
						    },
						    legend: {
						        data: ['产生量(吨)']
						    },
						    tooltip : {
						        trigger: 'axis',
						        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
						            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
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
						            data : jsonXStr,
						            axisTick: {
						                alignWithLabel: true
						            }
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value'
						        }
						    ],
						    series : [
						        {
						            name:'产生量(吨)',
						            type:'bar',
						            barWidth: '60%',
						            data:jsonNumStr
						        }
						    ]
						};

	         wasteProduce.setOption(wasteProduceOption);
	   	}
		
		function setWasteTransfer(data){
			var result = data.data;
			var arrayXName = new Array();
			var arrayNum = new Array();
			for(var i=0;i<result.length;i++){
				var x = result[i].rq;
				var num = result[i].num;
				arrayXName.push(x);
				arrayNum.push(num);
			}
			var jsonXStr = "["+arrayXName+"]";
			jsonXStr = eval('(' + jsonXStr + ')');
			var jsonNumStr = "["+arrayNum+"]";
			jsonNumStr = eval('(' + jsonNumStr + ')');
			var wasteTransfer = echarts.init(document.getElementById('wasteTransferNum'));
			var wasteTransferOption = {
				    color: ['#77bef7'],
				    title: {
				        text: '危废转移量统计'
				    },
				    tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['转移量(吨)']
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				    toolbox: {
				        feature: {
				            saveAsImage: {}
				        }
				    },
				    xAxis: {
				        type: 'category',
				        boundaryGap: false,
				        data: jsonXStr
				    },
				    yAxis: {
				        type: 'value'
				    },
				    series: [
				        {
				            name:'转移量(吨)',
				            type:'line',
				            stack: '总量',
				            data:jsonNumStr
				        }
				    ]
				};


	         wasteTransfer.setOption(wasteTransferOption);
	   	}
	</script>

</body>

</html>
