<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>漳州市生态云-环保一张图</title>
	
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
    <!-- ol -->
	<link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
	<!-- Custom -->
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
	<!-- ol end -->
   	<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
   	<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
	<!-- 地图相关 -->
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
	<script src="${request.contextPath}/static/js/epaConsole.js"></script>
</head>
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="container" style="position: absolute;top:70px;bottom: 0px;left:0px;right: 0px;">
	<div class="map-container">
		<div class="map-wrapper">
			<div id="allMap" class="map-wrapper" style="height: 100%"></div>
			<div class="map-tool-container" style="  z-index:1;">
			<div class="map-panel" style="position:absolute;top:72px;right:30px;">
                <div class="map-panel-header">
                    <span class="title">
                        <span class="icon iconcustom icon-zhedie3"></span>水利厅综合分析监控图
                    </span>
                </div>
                <div class="map-panel-body" style="height: 450px;width:400px;position: relative;">
                    <div class="theme-container" style="width:400px;">
                        <div class="theme-title">筛选</div>
                            <div class="theme-content">
                                <div class="search-container" id="search2">
                                    <div class="search-box">
                                        <input id="stationName" class="easyui-textbox" style="width:100%;"/>
                                        <a href="javascript:void(0)" id = "searchStation" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
                                    </div>
                                </div>
                                <div class="easyui-table-light">
                                    <table id="dg_enterprise" class="easyui-datagrid"
                                       style="width: 400px;height:400px;" toolbar="#search2"
                                       url="${request.contextPath}/wtcd/wtcdSiteInfo/getWtcdSiteInfoList"
                                       data-options="
                                        rownumbers:false,
                                        singleSelect:true,
                                        striped:false,
                                        autoRowHeight:false,
                                        pageSize:10,
                                        pagination:true,
                                        nowrap:false">
                                        <thead>
                                        <tr>
                                            <th field="local" formatter="locationEnterpriseOnMap" width="50">定位</th>
                                         <th field="STNM" width="100">名称</th>
                                         <th field="STLC" width="200">地址</th>
                                         <th field="detail" formatter="imgFormatterByDetail" width="50">详情</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                                
                            </div>
        
                    </div>  
                        
                </div>
            </div>
			
			<div class="map-toolbar-container">
				<!--地图切换-->
				<ul class="btn-group" id="switcherLayer">
					<li class="btn task" layer_group="GLOBAL_IMG_MAP">
						<span class="icon fa-globe"></span><span>卫星图层</span>
					</li>
					<li class="btn report active" layer_group="GLOBAL_VEC_MAP">
						<span class="icon fa-road"></span><span>矢量图层</span>
					</li>
				</ul>
			</div>
			
			
        </div>
			<!--地图层-->
			<!-- 图例  -->
			<div class="map-legend-container"
				style="position: absolute; bottom: 27px; left: 0px;">
				<div class="grade-legend">
					<div class="legend">
						<span class="item"></span>离线 <span class="item online"></span>在线
						<span class="item offline"></span>超标
					</div>
				</div>
			</div>
			<!-- 图例 over -->
		</div>
	</div>
	<!-- main over -->
	<div id="wtcdSiteInfoDialog" class="easyui-dialog" style="width:800px;background:#ADADAD;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
		<div class="map-panel">
			<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:380px;">
				<div class="wtcdSiteInfoContainer" title="水文站点详情" selected="true">
		    		<div class="panel-group-container">
		       			<div class="panel-group-top">
		       				<span class="wtcdSiteName"></span>
		       				<span class="subtext fr wtcdSiteUpdateTime"></span>
		       			</div>
		       			<div class="panel-group-body">
		       				<div class="panel-info wtcdSiteInfo"></div>
		       			</div>
		       		</div>
		        </div>
		        <div title="数据分析">
		        	<div class="data-analysis">
		        		<div id="wtcdSiteDataAnalysisList" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
							<span class="data-analysis-item active" data-type="reservoirData">水库数据</span>
							<span class="data-analysis-item" data-type="rainfallData">雨量数据</span>
							<span class="data-analysis-item" data-type="riverwayData">河道数据</span>
						</div>
						<div class="oh data-analysis-content">
							<div id="timeIntervalList" class="radio-button-group">
								<span class="active time-interval-item" time-interval="1">最近24小时</span>
								<span class="time-interval-item" time-interval="2">最近72小时</span>
								<span class="time-interval-item" time-interval="30">最近一个月</span>
								<span class="time-interval-item" time-interval="360">最近一年</span>
								<span class="time-interval-item" time-interval="ALL">所有</span>
							</div>
							<div id="wtcdSiteDataAnalysis" style="height: 270px;width:600px;"></div>
						</div>
		        	</div>
		        </div>
		    </div>
		</div>
	</div>
</div>
<script src="${request.contextPath}/static/js/fjzx-jquery-ext.js"></script>
<script>

	
 	 
		var enterpriseArray = null;
		var onlyMonitorFlag = true;
		var idArray = new Array();
		var myMarkMap = new HashMap();
		var markerMap = new HashMap();
		var allSignArr = new Array();
		$.parser.onComplete = function() {
			$("#loadingDiv").fadeOut("normal", function() {
				$(this).remove();
			});
		};
	    
		$(function () {
            $("#dg_enterprise").datagrid('getPager').pagination({
                showPageList:false,
                showRefresh:false,
                layout:['first','prev','links','next','last'],
                links:3
            });
            $("#dg_enterprise").datagrid('resize');
            
            $(".map-panel-header").on("click", function() {
                var $target = $(this).parent();
                if ($target.hasClass("collapsed")) {
                    $target.removeClass("collapsed");
                    WaterPollutionBar.resize();
                    WatertypeBar.resize();
                    WaterIndexBar.resize();
                } else {
                    $target.addClass("collapsed");
                }
            });
        });
		
	      $("#searchStation").click(function(){
	    	  
	        	$('#dg_enterprise').datagrid('load', {
	        		stationName  : $("#stationName").val().trim()
				}
	        	);
	        });
		//地图加载相关 --start--
		var map = null;
		initMapForEpa();
		initStation();
		function initMapForEpa() {
			var longitude = "117.65";
			var latitude = "24.52";
			map = initMap({
			    target : "allMap",
			    center : [ parseFloat(longitude), parseFloat(latitude) ],
			    layers : fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
			    zoom: 15
			   });
			map.render();
		}

		function initStation() {
			$.ajax({
				type : 'POST',
				url : '${request.contextPath}/wtcd/wtcdSiteInfo/getWtcdSiteInfoList',
				dataType : 'json',
				success : function(data) {
					enterpriseArray = [];
					for (var i = 0; i < data.length; i++) {
						var tempData = data[i];
						var record = {
							  "uuid": tempData.STCD,
							  "peName": tempData.STNM,
							  "address": tempData.STLC,
							  "latitude": tempData.LTTD,
							  "longitude": tempData.LGTD,
							  "updateTime": tempData.UPDATETIME_RJWA,
							  "rawData": tempData
						};
						if (record.latitude != null && record.longitude != null) {
							enterpriseArray.push(record);
						}
					}
					addMakerStation("online", enterpriseArray);
					$("#loadingDiv").fadeOut("normal", function() {
						$(this).remove();
					});
				},
				error:function(data){
					console.log("=========initStation error=========");
				}
			});
		}
		//企业信息列表绑定相关函数 --end--
		
		function addMakerStation(type, stationArray) {
			for (var i = 0; i < stationArray.length; i++) {
				var record = stationArray[i];
				var point = new fjzx.map.Point(record.longitude, record.latitude);
				if (markerMap.get(record.uuid) == null) {
					var imagePath = "${request.contextPath}/static/images/wtcd_site_marker_02.png";
					iconMap = new fjzx.map.Icon(imagePath, {
						size:new fjzx.map.Size(30, 30),
						offset: [0, 0],
						opacity: 0.8
					});
					myMarker = new fjzx.map.Marker(point, {
						icon : iconMap,
						map : map,
						title :record.peName
					});
				} else {
					myMarker = markerMap.get(record.uuid);
				}
				idArray[i] = record.uuid;
				myMarker.type = type;
				myMarker.recordJson = record;
				
		        map.addOverlay(myMarker);
				myMarkMap.put(record.uuid, myMarker);
				addClickHandler(record, myMarker);
				if (onlyMonitorFlag) {
					markerMap.put(record.uuid, myMarker);
					allSignArr.push(myMarker);
				}
			}
			onlyMonitorFlag = false;
		}

		var monitorHydroFlag = false;
		function addClickHandler(record, myMarker) {
			myMarker.addClick(function(e) {
				var STCD = record.rawData.STCD;
				var STNM = record.rawData.STNM;
				getWtcdSiteInfo(record);
				$('#wtcdSiteInfoDialog').dialog('open').dialog('center').dialog('setTitle','水利厅水文站点详细数据-'+STNM);
				
				var dataType = $("div#wtcdSiteDataAnalysisList span.active").attr("data-type");
				var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
				var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);
				
				getWtcdDataAnalysisByType(STCD, dataType, queryTimeObj.startTime,queryTimeObj.endtime);
			});
		}
		
		function getWtcdSiteInfo(record){
			var wtcdSiteInfo = '<span>经度：{text:LGTD}</span>\
				<span>纬度：{text:LTTD}</span>\
				<span>水系名称：{text:STBK}</span>\
				<span>流域名称：{text:BSNM}</span>\
				<span>河流名称：{text:RVNM}</span>\
				<span>行政区划码：{text:ADDVCD}</span>\
				<span>站址：{text:STLC}</span>\
				<span>交换管理单位：{text:}</span>\
				<span>站类：{text:STTP}</span>\
				<span>测站岸别：{text:MODITIME}</span>\
				<span>报汛等级：{text:HNNM}</span>\
				<span>基面名称：{text:DTMNM}</span>\
				<span>隶属行业单位：{text:ATCUNIT}</span>\
				<span>信息管理单位：{text:ADMAUTH}</span>';
			var pointInfoHtml = $.formatStr(wtcdSiteInfo,record.rawData);

			var $wtcdSiteInfoContainer = $("div.wtcdSiteInfoContainer");
			$wtcdSiteInfoContainer.find('span.wtcdSiteName').html(record.rawData.STNM);
			$wtcdSiteInfoContainer.find('span.wtcdSiteUpdateTime').html(record.rawData.updatetimeRjwa);
			$wtcdSiteInfoContainer.find('div.wtcdSiteInfo').html(pointInfoHtml);
			$wtcdSiteInfoContainer.attr("data-wtcdSiteInfo",JSON.stringify(record));
		}
		
		function getWtcdDataAnalysisByType(STCD, dataType, startTime, endtime){
			switch(dataType){
			case "reservoirData":
				getWtcdReservoirData(STCD, startTime, endtime);
				break;
			case "rainfallData":
				getWtcdRainfallData(STCD, startTime, endtime);
				break;
			case "riverwayData":
				getWtcdRiverwayData(STCD, startTime, endtime);
				break;
			default:
				getWtcdReservoirData(STCD, startTime, endtime);
				break;
			}
		}

		function getWtcdRainfallData(STCD, startTime, endtime){
			$.ajax({
				type : 'POST',
				url : Ams.ctxPath + '/wtcd/wtcdRainfallData/getWtcdRainfallDataListForMap',
				dataType : 'json',
				data : {
					'STCD' : STCD,
					'startTime': startTime,
					'endtime': endtime
				},
				success : function(data) {
					var labelArray = data.labelArray;
					var dataArray = data.dataArray;
					var name = "雨量数据";
					initAnalysisChart(name, labelArray, dataArray);
				}
			});
		}
		function getWtcdReservoirData(STCD, startTime, endtime){
			$.ajax({
				type : 'POST',
				url : Ams.ctxPath + '/wtcd/wtcdReservoirData/getWtcdReservoirDataListForMap',
				dataType : 'json',
				data : {
					'STCD' : STCD,
					'startTime': startTime,
					'endtime': endtime
				},
				success : function(data) {
					var labelArray = data.labelArray;
					var dataArray = data.dataArray;
					var name = "水库数据";
					initAnalysisChart(name, labelArray, dataArray);
				},
				error: function(res){
					console.log(res);
				}
			});
		}
		function getWtcdRiverwayData(STCD, startTime, endtime){
			$.ajax({
				type : 'POST',
				url : Ams.ctxPath + '/wtcd/wtcdRiverwayData/getWtcdRiverwayDataListForMap',
				dataType : 'json',
				data : {
					'STCD' : STCD,
					'startTime': startTime,
					'endtime': endtime
				},
				success : function(data) {
					var labelArray = data.labelArray;
					var dataArray = data.dataArray;
					var name = "河道数据";
					initAnalysisChart(name, labelArray, dataArray);
				}
			});
		}
		
		function initAnalysisChart(name, labelArray, dataArray){
			var wtcdSiteDataAnalysisChart = echarts.init(document.getElementById('wtcdSiteDataAnalysis'));
	        var option = {
				title: {},
			    tooltip : {
			    	show :true,
			         trigger: 'axis',
			         axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    color :["#CD69C9"],
			    legend: {
			        data:[name],
			        top:'10',
			        textStyle: {color: '#000000', fontSize: 12, fontFamily: 'microsoft yahei light', fontWeight: 300}
			    },
			    dataZoom: [
			    	{show: true, realtime: true, start: 20, end: 80}, 
	            	{type: 'inside', realtime: true, start: 20, end: 80}
	            ],
			    xAxis: [{name: '时间', type : 'category', data : labelArray}],
			    yAxis: [{type : 'value'}],
			    toolbox: {
	                show: true,
	                feature: {
	                    magicType: {type: ['line','bar']},//动态类型切换
	                	saveAsImage: { show: true }
	                },
	            },
	            textStyle: {color: '#000000', fontSize: 12, fontFamily: 'microsoft yahei light', fontWeight: 300},
			    series :  [{name:name, type:'line', stack: name, data: dataArray}]
			}; 
	        wtcdSiteDataAnalysisChart.clear();
	        wtcdSiteDataAnalysisChart.setOption(option, true);
		}
		
		//地图加载相关 --start--
		
		$("div#wtcdSiteDataAnalysisList span.data-analysis-item").click(function(){
			$(this).parent().find("span.active").removeClass("active");
			$(this).addClass("active");

			var wtcdSiteInfo = toJSON($("div.wtcdSiteInfoContainer").attr("data-wtcdSiteInfo"));
			var STCD = wtcdSiteInfo.rawData.STCD.replace(" ","");
			var dataType = $(this).attr("data-type");
			
			var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
			var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);
			
			getWtcdDataAnalysisByType(STCD, dataType, queryTimeObj.startTime,queryTimeObj.endtime);
		});
		$("div#timeIntervalList span.time-interval-item").click(function(){
			$(this).parent().find("span.active").removeClass("active");
			$(this).addClass("active");
		});
		
		function getStartTimeAndEndTimeByInterval(timeInterval){
			var now = new Date();
			var startTime = $.getDateTimeByOffsetDays(now,-1);
			if("ALL"===timeInterval){
				startTime = '1970-01-01 00:00:00';
			}else{
				startTime = $.getDateTimeByOffsetDays(now,-timeInterval);
			}
			var endTime = now;
			
			return {startTime: startTime, endTime: endTime};
		}
		
		function toJSON(jsonStr){
			var result = {};
			if(jsonStr!="" && jsonStr!=null && jsonStr!=undefined){
				result = JSON.parse(jsonStr);
			}
			
			return result;
		}
		$("#filterId").click(function(){
    		var display =$('#dFilter').css('display');
    		if(display == 'none'){
    			$("#dFilter").show();
    		}else{
    			$("#dFilter").hide();
    		}
    	});
	function buildData(row){
		var obj = new Object();
		 obj.rawData = {
				  ADDVCD: row.ADDVCD.trim()  == null ? "" : row.ADDVCD.trim(),
				  ADMAUTH: row.ADMAUTH.trim() == null ? "" :row.ADMAUTH.trim(),
				  ATCUNIT: row.ATCUNIT.trim() == null ? "" : row.ATCUNIT.trim(),
				  LGTD:  row.LGTD  == null ? "" : row.LGTD,
				  LOCALITY: row.LOCALITY == null ? "" : row.LOCALITY.trim(),
				  LTTD: row.LTTD == null ? "" : row.LTTD,
				  RVNM: row.RVNM == null ? "" : row.RVNM.trim(),
				  STLC:  row.STLC == null ? "" :row.STLC.trim(),
				  STNM: row.STNM == null ? "" :row.STNM.trim(),
				  STCD: row.STCD == null ? "" :row.STCD.trim(),
				  STBK: row.STBK == null ? "" :row.STBK.trim(),
				  BSNM: row.BSNM == null ? "" :row.BSNM.trim(),
				  STTP: row.STTP == null ? "" :row.STTP.trim(),
				  HNNM: row.HNNM == null ? "" :row.HNNM.trim(),
				  DTMNM: row.DTMNM == null ? "" :row.DTMNM.trim()
			 };
		 return obj;
	}	
		
 	//企业信息列表绑定相关函数 --start--
	function locationEnterpriseOnMap(value, row, index) {
		var obj = buildData(row);
	    var value = "<div onclick=localtionAndOpenInfoWindow($(this)) row-data=" + JSON.stringify(obj) + " > <img style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_01.png></div>";
		return value;
	}
	function imgFormatterByDetail(value, row, index){
		var obj = buildData(row);
		value = "<img  onclick= localtionAndOpenInfoWindow($(this)) row-data=" + JSON.stringify(obj) + " style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_02.png>";
		return value;
	}
	
	function localtionAndOpenInfoWindow(thisDiv) {
	   
		var record = JSON.parse(thisDiv.attr("row-data"));
		currentRecord  = record ;
	 
		var marker = markerMap.get(record.uuid);
 
		if(record.rawData.LGTD==null || record.rawData.LTTD==null){
			$.messager.show({
                title: '提示',
                msg: "该水利厅暂无定位信息！"
            });
			return false;
		}
		var point = new fjzx.map.Point(record.rawData.LGTD, record.rawData.LTTD);
	   	map.setCenter(point);
		createInfoWindow(record,marker) ;  
	}
    
	function createInfoWindow(record,marker) {
		   openInfo(record,marker);
	}
	
	function openInfo(record,marker){
		
		var STCD = record.rawData.STCD;
		var STNM = record.rawData.STNM;
		getWtcdSiteInfo(record);
		$('#wtcdSiteInfoDialog').dialog('open').dialog('center').dialog('setTitle','水利厅水文站点详细数据-'+STNM);
		
		var dataType = $("div#wtcdSiteDataAnalysisList span.active").attr("data-type");
		var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
		var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);
		
		getWtcdDataAnalysisByType(STCD, dataType, queryTimeObj.startTime,queryTimeObj.endtime);
	}
	
	</script>
</body>
</html>