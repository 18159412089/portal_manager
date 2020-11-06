<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>单日空气质量目标管理</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>

<style type="text/css"> 
</style>
<div class="container box-center" style="width: 100%;height: 100%;overflow: auto;"> 
    <div class="box-cell">   
    <!-- main -->
    	<div class="single-day-container">
    		<div class="single-day-air">
    			<div class="item">
    				<div class="air-box">
    					<div class="data" id="showDate"></div>
    					<div class="tit">当前时间</div>
    				</div>
    			</div>
    			<div class="item AQI">
    				<div class="air-box">
    					<div class="data" id="AQI">120</div>
    					<div class="tit">今日统计AQI</div>
    				</div>
    			</div>
    			<div class="item top">
    				<div class="air-box">
    					<div class="data" id="pollute">PM2.5</div>
    					<div class="tit">首要污染物</div>
    				</div>
    			</div>
    		</div>
    		<div class="single-day-details">
    			<!-- panel -->
    			<div class="column-panel">
			         <div class="column-panel-header"> 
			         	<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->     	
						<span class="title">
							详情
						</span>				
			         </div>
			         <div class="column-panel-body">
			         	<div class="ca">
			         		<!-- 图例  -->
							<div class="bar-legend-container fr">
								<div class="title">
									<div class="item">优</div>
									<div class="item">良</div>
									<div class="item">轻度</div>
									<div class="item">中度</div>
									<div class="item">重度</div>
									<div class="item">严重</div>
									<div class="item">未知</div>
								</div>
								<div class="grade-legend">
									<div class="item excellent"></div>
									<div class="item good"></div>
									<div class="item mild"></div>
									<div class="item moderate"></div>
									<div class="item severe"></div>
									<div class="item dangerous"></div>
									<div class="item"></div>
								</div>
								<div class="num">
									<div class="item">0</div>
									<div class="item">50</div>
									<div class="item">100</div>
									<div class="item">150</div>
									<div class="item">200</div>
									<div class="item">300</div>
									<div class="item">500</div>
									<div class="item"></div>
								</div>
							</div>  
						    <!-- 图例 over -->
			         		<!--<div class="oh">
			         			今日AQI预计达标值
			         			<input id="" type="text"  class="easyui"style="height: 32px; width: 100px;"/>
			         			<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" onclick="">计算</a>
			         		</div>-->
			         	</div>
			         	<div class="row">
			         		<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend PM10"></div><!--默认未知 excellent good mild moderate severe dangerous-->
			         					<span>PM10</span>
			         				</div>

			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="PM10"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(μg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residuePM10"></div>
				         					</div>
				         				</div>
			         				</div>

			         			</div>
			         		</div>
							<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend PM2"></div>
			         					<span>PM2.5</span>
			         				</div>

			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="PM2"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(μg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residuePM2"></div>
				         					</div>
				         				</div>
			         				</div>
			         				
			         			</div>
			         		</div>
			         		<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend SO2"></div>
			         					<span>SO₂</span>
			         				</div>
			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="SO2"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(μg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residueSO2"></div>
				         					</div>
				         				</div>
			         				</div>
			         				
			         			</div>
			         		</div>
			         		<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend NO2"></div>
			         					<span>NO₂</span>
			         				</div>
			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="NO2"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(μg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residueNO2"></div>
				         					</div>
				         				</div>
			         				</div>
			         				
			         			</div>
			         		</div>
							<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend CO"></div>
			         					<span>CO</span>
			         				</div>
			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="CO"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(mg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residueCO"></div>
				         					</div>
				         				</div>
			         				</div>
			         			</div>
			         		</div>
			         		<div class="col-xs-4">
			         			<div class="material-list-container">

			         				<div class="grade-legend">			         					
			         					<div class="legend O3"></div>
			         					<span>O₃</span>
			         				</div>

			         				<div class="data-panel-layout">	
				         				<div class="data-panel">
				         					<div class="data-panel-header">当前AQI</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="O3"></div>
				         					</div>
				         				</div>
									</div>
									<div class="data-panel-layout">
				         				<div class="data-panel">
				         					<div class="data-panel-header">剩余(μg/m3)</div>
				         					<div class="data-panel-body">
				         						<div class="data" id="residueO3"></div>
				         					</div>
				         				</div>
			         				</div>
			         			</div>
			         		</div>
			         	</div>	
			         </div>
			    </div>
    			<!-- panel over -->
    		</div>
    	</div>
    <!-- main over -->
    </div>
</div>
<script type="text/javascript">
   
	var beforeColorPM10;
	var beforeColorPM2;
	var beforeColorCO;
	var beforeColorNO2;
	var beforeColorO3;
	var beforeColorSO2;
	
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
    $(function () {
    	getTime();
    	showAirInfo();
    	
    });
    $(window).resize(function () {

    });
	setInterval("getTime();",1000); //每隔一秒运行一次
    //setInterval("showAirInfo();",1000*10); //每隔一秒运行一次
  	//取得系统当前时间
	function getTime(){
		var myDate = new Date();
		var hours = myDate.getHours();
		if(hours<10)
			hours = "0"+hours;
		var minutes = myDate.getMinutes();
		if(minutes<10){
			minutes = "0"+minutes;
		}
		var seconds = myDate.getSeconds();
		if(seconds<10)
			seconds = "0"+seconds;
		$("#showDate").html(hours+":"+minutes+":"+seconds); //将值赋给div
	}
    
    
    function showAirInfo(){
    	var  time = $("#showDate").text();
    	$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/airQualityManagement/getAirInfoByTime",
			data : {
				time:time
			},
			dataType: "json",
			success: function(data){
				$("#AQI").html(data[0].AQI);
				$("#pollute").html(data[0].pollute);
				$("#PM2").html(data[0].PM2);
				$("#PM10").html(data[0].PM10);
				$("#CO").html(data[0].CO);
				$("#NO2").html(data[0].NO2);
				$("#O3").html(data[0].O3);
				$("#SO2").html(data[0].SO2);
				//$('.PM10').removeClass(className);
			
				
				addClassName('PM10',data[0].colorPM10,beforeColorPM10);
				addClassName('PM2',data[0].colorPM2,beforeColorPM10);
				addClassName('CO',data[0].colorCO,beforeColorPM10);
				addClassName('NO2',data[0].colorNO2,beforeColorPM10);
				addClassName('O3',data[0].colorO3,beforeColorPM10);
				addClassName('SO2',data[0].colorSO2,beforeColorPM10);
				beforeColorPM10 = data[0].colorPM10;
				beforeColorPM2 = data[0].colorPM2;
				beforeColorCO = data[0].colorCO;
				beforeColorNO2 = data[0].colorNO2;
				beforeColorO3 = data[0].colorO3;
				beforeColorSO2 = data[0].colorSO2;	
					
				$("#residuePM2").html(data[0].residuePM2);
				$("#residuePM10").html(data[0].residuePM10);
				$("#residueCO").html(data[0].residueCO);
				$("#residueNO2").html(data[0].residueNO2);
				$("#residueO3").html(data[0].residueO3);
				$("#residueSO2").html(data[0].residueSO2);
			},
			error: function(r){console.log(r);}
		});
    }
	function addClassName(name,nowColor,beforeColor){
		$("."+name).removeClass(beforeColor);
		$("."+name).addClass(nowColor);
	}
</script>

</body>

</html>