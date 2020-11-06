<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>核与辐射管理</title>
	
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
<div class="container oh" style="position:absolute;top:70px;left:0px;right:0px;bottom:0px;">
	<div class="map-container">
		<div class="map-wrapper">
			<div id="allMap" class="map-wrapper" style="height: 100%"></div>
				<div class="map-tool-container" style="  z-index:1;">
			<ul>
				<li  class = "hide">
					<div id="btn_ranging"  class="btn-map-tool"  data-dropdown=".btn_ranging" data-parent=".map-toolbar-container"><span class="icon iconcustom  icon-ceju"></span>测距</div>
				</li>
				<li id="accordionFilter" style = "top:5px">
					<div id="filterId" class="btn-map-tool collapsed" data-target="#dFilter" data-toggle="collapse" data-parent="#accordionFilter"><span class="icon iconcustom  icon-shaixuan1"></span>筛选</div>
					<div id="dFilter" class="collapse">
						<div class="dropdown-panel-container">
							<div class="dropdown-panel-top">
								<span>核与辐射分析监控图</span>
							</div>
							<div class="dropdown-panel-body">
								<div class="column-group">
									<div class="top">
										<div class="title"><span class="icon fa-filter"></span>筛选</div>
									</div>
									<div class="column-con">
										<div class="search-box" style="border-bottom: 1px solid #c8c8c8;">
											<div class="form-group hide">
												<label class="control-label">污染源类型：</label>
												<div class="control-div">
													<input class="form-control" placeholder="" style="width: 252px;" type="text">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label">核与辐射名称：</label>
												<div class="control-div">
													<input  id="stationName" class="form-control" placeholder="" style="width: 252px;" type="text">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label"></label>
												<div class="control-div tr">
													<button  id = "searchStation" type="button" class="btn-blue l-btn m0" style="margin-bottom:10px;"><span class="icon fa-search"></span> 查询</button>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="column-group">
									<div class="top">
										<div class="title"><span class="icon fa-info-sign"></span>核与辐射信息</div>
									</div>
									<div class="column-con">
									 	<div class="panel-group-box">
							 
								        <div class="panel-group-body" style="height: 242px;">
								        <table id="dg_enterprise" class="easyui-datagrid" style="width: 100%; height: 100%; display :show"   
										url="${request.contextPath}/rad/radEnterpriseInfo/getradEnterpriseInfoListForMap" toolbar="#toolbar"
										data-options="
											rownumbers:false,
								            singleSelect:true,
								            striped:true,
								            autoRowHeight:true,
								            fitColumns:true,
								            fit:true,
								            pagination:true,
								            pageSize:10,
								            pageList:[10,30,50]">
									      <thead>
											<tr>
												<th field="local" formatter="locationEnterpriseOnMap" width="120">定位</th>
												<th field="ENTERNAME" width="220">名称</th>
												<th field="ZCDZ" width="180">地址</th>
												<th field="detail" formatter="imgFormatterByDetail" width="120">详情</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
									 </div>
								</div>

							</div>

						</div>

					</div>
            	</li>
			</ul>
			
			<div class="map-toolbar-container">
				<!--地图切换-->
				<ul class="btn-group" id="switcherLayer">
					<li class="btn task" layer_group="GLOBAL_IMG_MAP">
						<span class="icon fa-globe"></span><span>卫星图层</span>
					</li>
					<li class="btn report active" layer_group="GLOBAL_VEC_MAP">
						<span class="icon fa-road"></span><span>矢量图层</span>
					</li>
				</ul> 			</div>
			
			
        </div>
		<div class="map-wrapper">
			<div id="allMap" class="map-wrapper" style="height: 100%"></div>
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
				<div class="wtcdSiteInfoContainer" title="辐射企业信息详情" selected="true">
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
							<span class="data-analysis-item active" data-type="RAD_SOURCE_ACCOUNT">放射源台账</span>
							<span class="data-analysis-item" data-type="RAD_UNSERALED_ACCOUNT">非密封台账</span>
							<span class="data-analysis-item" data-type="RAD_X_RAY_ACCOUNT">射线装置台账</span>
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
				url : '${request.contextPath}/rad/radEnterpriseInfo/getradEnterpriseInfoListForMap',
				dataType : 'json',
				success : function(data) {
					enterpriseArray = [];
					for (var i = 0; i < data.length; i++) {
						var tempData = data[i];
						var record = {
							  "uuid": tempData.ENTERID,
							  "peName": tempData.ENTERNAME,
							  "address": tempData.TXDZ,
							  "latitude": tempData.latitude,
							  "longitude": tempData.longitude,
							  "updateTime": tempData.updatetimeRjwa,
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
					var imagePath = "${request.contextPath}/static/images/rad.png";
					iconMap = new fjzx.map.Icon(imagePath, {
						size:new fjzx.map.Size(0, 0),
						imgSize:new fjzx.map.Size(0, 0),
						offset: [0, 0],
						opacity: 0.8
					});
					myMarker = new fjzx.map.Marker(point, {
						icon : iconMap,
						map : map.peName,
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
				var ENTERID = record.rawData.ENTERID;
				var ENTERNAME = record.rawData.ENTERNAME;
				$('#wtcdSiteInfoDialog').dialog('open').dialog('center').dialog('setTitle','核与辐射站点详细数据-'+ENTERNAME);
				getWtcdSiteInfo(record);
				
				var dataType = $("div#wtcdSiteDataAnalysisList span.active").attr("data-type");
				var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
				var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);
				
				getRadDataAnalysisByType(ENTERID, dataType, queryTimeObj.startTime,queryTimeObj.endTime);
			});
		}
		
		function getWtcdSiteInfo(record){
			var wtcdSiteInfo = '<span>经度：{text:longitude}</span>\
				<span>纬度：{text:latitude}</span>\
				<span>所在省份：{text:SZSF}</span>\
				<span>所在市区：{text:SZSQ}</span>\
				<span>所在区县：{text:SZQX}</span>\
				<span>注册地址：{text:ZCDZ}</span>\
				<span>注册地邮编：{text:ZCDYB}</span>\
				<span>通讯地址：{text:TXDZ}</span>\
				<span>通讯地邮编：{text:TXDYB}</span>\
				<span>联系人：{text:LXR	}</span>\
				<span>联系电话：{text:LXDH}</span>\
				<span>法定代表人：{text:FDDBR}</span>\
				<span>法人电话：{text:FRDH}</span>\
				<span>法人证件类型：{text:FRZJLX}</span>\
				<span>法人证件号码：{text:FRZJHM}</span>\
				<span>行业类别：{text:HYLB}</span>\
				<span>主要应用领域：{text:ZYYYLY}</span>\
				<span>放射源生产活动种类：{text:FSYSCHDZL}</span>\
				<span>放射源销售活动种类：{text:FSYXSHDZL}</span>\
				<span>放射源使用活动种类：{text:FSYSYHDZL}</span>\
				<span>射线装置生产活动种类：{text:SXZZSCHDZL}</span>\
				<span>射线装置销售活动种类：{text:SXZZXSHDZL}</span>\
				<span>射线装置使用活动种类：{text:SXZZSYHDZL}</span>\
				<span>射线装置使用（含建造）I类：{text:SXZZSYIL}</span>\
				<span>非密封放射物质活动种类：{text:FMFFSWZHDZL}</span>\
				<span>非密封放射物质活动范围：{text:FMFFSWZHDFW}</span>\
				<span>使用（含收贮）：{text:SY}</span>\
				<span>辐射管理机构名称：{text:FSGLJGMC}</span>\
				<span>辐射管理机构联系人：{text:FSGLJGLXR}</span>\
				<span>辐射管理机构负责人电话：{text:FSGLJGFZRDH}</span>\
				<span>辐射管理机构联系人手机：{text:FSGLJGLXRSJ}</span>\
				<span>辐射管理机构传真：{text:FSGLJGCZ}</span>\
				<span>辐射管理机构联系人电子邮件：{text:FSGLJGLXRDZYJ	}</span>\
				<span>许可证号：{text:XKZH}</span>\
				<span>许可证生效日期：{text:XKZSXRQ}</span>\
				<span>许可证失效日期：{text:XKZASXRQ}</span>\
				<span>许可证颁发条件：{text:XKZBFTJ}</span>\
				<span>许可证发证机关：{text:XKZFZJG}</span>\
				<span>组织机构代码：{text:ZZJGDM}</span>\
				<span>单位状态：{text:DWZT}</span>\
				<span>备注：{text:BZ}</span>';
			var pointInfoHtml = $.formatStr(wtcdSiteInfo,record.rawData);
             
			var $wtcdSiteInfoContainer = $("div.wtcdSiteInfoContainer");
			$wtcdSiteInfoContainer.find('span.wtcdSiteName').html(record.rawData.ENTERNAME);
			$wtcdSiteInfoContainer.find('span.wtcdSiteUpdateTime').html(record.rawData.updatetimeRjwa);
			$wtcdSiteInfoContainer.find('div.wtcdSiteInfo').html(pointInfoHtml);
			$wtcdSiteInfoContainer.attr("data-wtcdSiteInfo",JSON.stringify(record));
		}
		
		function getRadDataAnalysisByType(ENTERID, dataType, startTime, endTime){
			var url = Ams.ctxPath;
			switch(dataType){
			case "RAD_SOURCE_ACCOUNT":
				url = url + '/rad/radSourceAccount/getRadSourceAccountDataListForMap';
				break;
			case "RAD_UNSERALED_ACCOUNT":
				url = url + '/rad/radUnseraledAccount/getRadUnseraledAccountDataListForMap';
				break;
			case "RAD_X_RAY_ACCOUNT":
				url = url + '/rad/radXRayAccount/getRadXRayAccountDataListForMap';
				break;
			default:
				url = url + '/rad/radSourceAccount/getRadSourceAccountDataListForMap';
				break;
			}

			var data = {
				'ENTERID' : ENTERID,
				'startTime': startTime,
				'endTime': endTime	
			}
			radAccountDataService(
				url, 
				data,
				function(res){
					var labelArray = res.labelArray;
					var dataArray = res.dataArray;
					initAnalysisChart(labelArray, dataArray);
				},
				function(res){
				
				}
			);
		}
		
		//Ajax调用后台接口请求数据
		function radAccountDataService(url, data,sCallback,eCallback){
			$.ajax({
				type : 'POST',
				url : url,
				dataType : 'json',
				data : data,
				success : function(res) {
					if(typeof sCallback == "function"){
						sCallback(res);
					}
				},
				error: function(res){
					if(typeof eCallback == "function"){
						eCallback(res);
					}
				}
			});
		}
		
		function initAnalysisChart(labelArray, dataArray){
			var wtcdSiteDataAnalysisChart = echarts.init(document.getElementById('wtcdSiteDataAnalysis'));
			var legendNameArray = new Array();
			for(var i=0;i<dataArray.length;i++){
				legendNameArray[i] = dataArray[i].name;
			}
	        var option = {
				title: {},
			    tooltip : {
			    	show :true,
			         trigger: 'axis',
			         axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    color :["#FFFF00","#40E0D0","#CD69C9"],
			    legend: {
			        data:legendNameArray,
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
			    series :  dataArray
			}; 
	        wtcdSiteDataAnalysisChart.clear();
	        wtcdSiteDataAnalysisChart.setOption(option, true);
		}
		
		//地图加载相关 --start--
		
		$("div#wtcdSiteDataAnalysisList span.data-analysis-item").click(function(){
			$(this).parent().find("span.active").removeClass("active");
			$(this).addClass("active");

			var wtcdSiteInfo = toJSON($("div.wtcdSiteInfoContainer").attr("data-wtcdSiteInfo"));
			var ENTERID = wtcdSiteInfo.rawData.ENTERID.replace(" ","");
			var dataType = $(this).attr("data-type");
			
			var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
			var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);

			getRadDataAnalysisByType(ENTERID, dataType, queryTimeObj.startTime,queryTimeObj.endTime);
		});
		$("div#timeIntervalList span.time-interval-item").click(function(){
			$(this).parent().find("span.active").removeClass("active");
			$(this).addClass("active");
		});
		
		function getStartTimeAndEndTimeByInterval(timeInterval){
			var now = new Date();
			var startTime = $.getDateTimeByOffsetDays(now,-1);
			var endTime = now.format("yyyy-MM-dd hh:mm:ss");
			if("ALL"===timeInterval){
				startTime = '1970-01-01 00:00:00';
			}else{
				startTime = $.getDateTimeByOffsetDays(now,-timeInterval);
			}
			
			return {startTime: startTime, endTime: endTime};
		}
		
		function toJSON(jsonStr){
			var result = {};
			if(jsonStr!="" && jsonStr!=null && jsonStr!=undefined){
				result = JSON.parse(jsonStr);
			}
			
			return result;
		}
 
 	//企业信息列表绑定相关函数 --start--
	function locationEnterpriseOnMap(value, row, index) {
	    row.updatetimeRjwa = null;
	    var value = "<div onclick=localtionAndOpenInfoWindow($(this)) row-data=" + JSON.stringify(row) + " > <img style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_01.png></div>";
		return value;
	}
	function imgFormatterByDetail(value, row, index){
		 
		value = "<img  onclick= localtionAndOpenInfoWindow($(this)) row-data=" + JSON.stringify(row) + " style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_02.png>";
		return value;
	}
	
	function localtionAndOpenInfoWindow(thisDiv) {
		var rowdata = thisDiv.attr("row-data").trim();
		 
		var record = JSON.parse(thisDiv.attr("row-data"));
		currentRecord  = record ;
		var obj = new Object();
		obj.rawData = record;
		var marker = markerMap.get(record.uuid);
 
		if(record.longitude==null || record.latitude==null){
			$.messager.show({
                title: '提示',
                msg: "该站点暂无定位信息！"
            });
			return false;
		}
		var point = new fjzx.map.Point(record.longitude, record.latitude);
	   	map.setCenter(point);
		createInfoWindow(obj,marker) ;  
	}
    
	function createInfoWindow(record,marker) {
		   openInfo(record,marker);
	}
	
	function openInfo(record,marker){
 
		var ENTERID = record.rawData.ENTERID;
		var ENTERNAME = record.rawData.ENTERNAME;
		 
		$('#wtcdSiteInfoDialog').dialog('open').dialog('center').dialog('setTitle','核与辐射站点详细数据-'+ENTERNAME);
		getWtcdSiteInfo(record);
		
		var dataType = $("div#wtcdSiteDataAnalysisList span.active").attr("data-type");
		var timeInterval = $("div#timeIntervalList").find("span.active").attr("time-interval");
		var queryTimeObj = getStartTimeAndEndTimeByInterval(timeInterval);
		
		getRadDataAnalysisByType(ENTERID, dataType, queryTimeObj.startTime,queryTimeObj.endTime);
	}
	$("#filterId").click(function(){
		var display =$('#dFilter').css('display');
		if(display == 'none'){
			$("#dFilter").show();
		}else{
			$("#dFilter").hide();
		}
	});
 
	</script>
</body>
</html>