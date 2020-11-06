<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>漳州市水电站</title>
	<#include "/decorators/header.ftl"/>
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
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
	<#--<#include "/toolbar.ftl">-->
    <#include "/waterEnvironmentMenu.ftl">
    <style>
 	  
		.ztree li a{color:#fff;}
	</style>
</head>

<body>
<#include "/common/loadingDiv.ftl"/>
  
<div class="container" style="position: absolute;top:70px;bottom: 0px;left:0px;right: 0px;">
	<div class="map-container">
		<div class="map-wrapper">
			<div id="allMap" class="map-wrapper" style="height:100%"></div><!--地图层-->
		<!--左侧工具栏-->
		<div class="map-tool-container" style="  z-index:1;">
		    <div class="map-panel" style="position:absolute;top:72px;right:30px;">
		        <div class="map-panel-header">
		            <span class="title">
		                <span class="icon iconcustom icon-zhedie3"></span>水电站综合分析监控图
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
		                               url="${request.contextPath}/hydposition/hydpositoninfo/getAllHydpositoninfo"
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
		                                    <th field="eqpName" width="150">名称</th>
		                                    <th field="addr" width="150">地址</th>
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

		<!--地图内的详情列表-->
			<div class="map-details-popup" style= "display :none">
				<div class="popup-top">
					<span class="close">&times;</span>
					<div class="title" id="moreMoniorInfo" style="margin-right:37px;color:#0088cc;cursor:pointer;">
						漳州市环境质量数据详情 
					</div>
					
				</div>
				<div class="popup-con">
					  <table id="dg" class="easyui-datagrid" style="width: 100%; height: auto;" toolbar="#toolbar"  
								data-options="
								rownumbers:false,
					            singleSelect:true,
					            striped:true,
					            autoRowHeight:true,
					            fitColumns:true,
					            fit:true">
					           <thead>
					       			<tr>
							           	<th field="name" width="100%">--</th>
							        </tr>
					            </thead>
			 				</table>
				</div>
			</div>	
	</div>
	</div>
 <!--  站点信息   -->
<div id="monitorDlg" class="easyui-dialog" style="width:800px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div class="map-panel">
		<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:380px;">
			<div title="详情" selected="true">
	    		<div class="panel-group-container">
	       			<div class="panel-group-top"> <span id="deviceName"></span> </div>
	       			<div class="panel-group-body">
	       				<div class="panel-info" id="pointInfo">
	       				</div>
	       			</div>
	       		</div>
	        </div>
	        <div title="数据分析">
	        	<div class="data-analysis">
	        		<div id="polluteCodeList" class="radio-button-group style-list fl" style="width: 100px;height:100%;">
						<span id="dayInfo" class="active" value="day">日统计数据</span>
					</div>
					<div class="oh data-analysis-content">
						<div id="timeList" class="radio-button-group">
							<span id="7D" class="active" value="">最近7天</span>
							<span id="2W"  class="" value="">最近2周</span>
						</div>
						<div id="waterPointBar" style="height: 270px;"></div>
						 
					</div>
	        	</div>
	        </div>
	      <!--   <div title="近年分析统计" style ="display :none" >
	    		<div id="waterFactorChart" style="height: 270px;"></div>
	        </div>--> 
	    </div>
	</div>
</div>
 </div>
<!-- main over -->

 
 <script>
        var currentRecord = null;
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
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
			});
        });
       
        
      //企业信息列表绑定相关函数 --start--
		function locationEnterpriseOnMap(value, row, index) {
    	     var obj = {
    	    		eqpName: row.eqpName,
    				peName: row.peName,
    				addr: row.addr==null || typeof(row.addr)=="undefined" ? "" : row.addr,
    				uuid: row.uuid,
    				longitude: row.longitude,
    				latitude: row.latitude
    			};
			var value = "<div onclick=localtionAndOpenInfoWindow(this) row-data=" + JSON.stringify(obj) + " > <img style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_01.png></div>";
			return value;
		}
        //定位
        function localtion(thisDiv){
        	var $thisDiv = $(thisDiv);
			var record = JSON.parse($thisDiv.attr("row-data"));
		   currentRecord  = record ;
		   if(record.longitude==null || record.latitude==null){
				$.messager.show({
                    title: '提示',
                    msg: "该企业暂无定位信息！"
                });
				return false;
			}
		  	var point = new fjzx.map.Point(record.longitude, record.latitude);
		   	map.setCenter(point);
		  }
       
		function localtionAndOpenInfoWindow(thisDiv) {
			var $thisDiv = $(thisDiv);
			var record = JSON.parse($thisDiv.attr("row-data"));
			currentRecord  = record ;
			var marker = markerMap.get(record.uuid);
			if(record.longitude==null || record.latitude==null){
				$.messager.show({
                    title: '提示',
                    msg: "该企业暂无定位信息！"
                });
				return false;
			}
			createInfoWindow(record,marker) ;  
		}
        
		function createInfoWindow(record,marker) {
			if (!monitorHydroFlag) {
				  monitorHydroFlag = true;
				  $.ajax({
						type: 'POST',
						url:  '${request.contextPath}/hydposition/hydpositoninfo/getHydDeviceinfoByID',
						data: {'eqpId': record.uuid},
				   		success: function (data) {
				   			 openInfo(record,data,marker,true);
				   		 },
						dataType: 'json'
				 });
			 }
		}
      
		function imgFormatterByDetail(value, row, index) {
			 var obj = {
	    	    		eqpName: row.eqpName,
	    				peName: row.peName,
	    				addr: row.addr==null || typeof(row.addr)=="undefined" ? "" : row.addr,
	    				uuid: row.uuid,
	    				longitude: row.longitude,
	    				latitude: row.latitude
	    			};
			value = "<img  onclick= localtionAndOpenInfoWindow(this) row-data=" + JSON.stringify(obj) + " style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_02.png>";
			return value;
		}
        var map = null ;
		var option = {};
       	function initMapForEpa(){
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
       	initMapForEpa();
       	
		/* //筛选点击 默认隐藏
        $("#dFilter").hide(); */
    	$("#filterId").click(function(){
    		var display =$('#dFilter').css('display');
    		if(display == 'none'){
    			$("#dFilter").show();
    		}else{
    			$("#dFilter").hide();
    		}
    	});
    	
		var hydroStationArray=null;
		var onlyMonitorFlag =true ;
		var idArray = new Array();
		var myMarkMap =  new HashMap();
		var allSignArr = new Array();
		function initStation(){
			 $.ajax({
				type: 'POST',
				url:  '${request.contextPath}/hydposition/hydpositoninfo/getAllHydpositoninfo',
			  		success: function (data) {
			   	  hydroStationArray =[];
			   	  for (var i = 0; i < data.length; i++) {
						var record = data[i];
						switch(record.type){
						  case "hydPosition" :
							   hydroStationArray.push(record);
							  break;
					  }
					  
				  } 
			  		addMakerStation(record.type,hydroStationArray); 
			  		},
				dataType: 'json'
			});
		} 
        initStation();
        function addMakerStation(type,stationArray){
 			 for (var i = 0; i < stationArray.length; i++) {
 		     		    var record = stationArray[i];
		 				var point = new fjzx.map.Point(record.longitude,record.latitude);
		 			    if(markerMap.get(record.uuid) == null){
						 	 iconMap =  new fjzx.map.Icon( getImagePathByType(type), {size:new fjzx.map.Size(30, 30)});
                            //console.log(iconMap);
							 myMarker = new fjzx.map.Marker(point, {
								icon : iconMap,
								map : map,
								title :record.eqpName
							});
					  }else{
                     	 myMarker = markerMap.get(record.uuid);
                      }
						idArray[i]=record.uuid;
						myMarker.type= type;
						myMarker.recordJson =record;
						map.addOverlay(myMarker);  
						myMarkMap.put(record.uuid,myMarker);
						addClickHandler(record,myMarker);
					    if(onlyMonitorFlag){
							markerMap.put(record.uuid,myMarker);
							allSignArr.push(myMarker);
						}
				  }
 	           onlyMonitorFlag =false;
	    	}
        
            function getImagePathByType(type){
            	var imagePath =null;
            	switch(type){
				  case "hydPosition" :
					  imagePath = "${request.contextPath}/static/images/hydStation.png";
					  break;
            	}
				 return imagePath;
            }
          
			var monitorHydroFlag = false;
			function addClickHandler(record,myMarker){
			    myMarker.addClick(function(e){
					if(!monitorHydroFlag){
				  		monitorHydroFlag = true;
  						$.ajax({
								type: 'POST',
								url:  '${request.contextPath}/hydposition/hydpositoninfo/getHydDeviceinfoByID',
								data: {'eqpId': record.uuid},
						   		success: function (data) {
						   			 openInfo(record,data,myMarker,true);
						   			
						   		},
								dataType: 'json'
						 });
				  	 };
				});
			}	 
			
			 function getDeviceInfo(info){
					document.getElementById('deviceName').innerHTML = info.name;
					 
					document.getElementById('pointInfo').innerHTML='<span>经度：'+info.longitude+'</span>'
					+'<span>纬度：'+info.latitude+'</span><span>流域：'+info.riverName+'</span>'
					+'<span>流域编号：'+info.riverCode+'</span>'
					+'<span>行政区划名称：'+info.rgnName+'</span><span>行政区划编码：'+info.rgnCode+' </span>'
					+'<span>联系人：'+info.contacter+' </span><span>联系电话：'+info.contacterTel+' </span>'
					+'<span>地址：'+info.addr+'</span>'+'<span></span>'
					+'<span style="width:100%">概况：'+info.overview+'</span>';
			  }
		  
			//数据详情
			function showMonitorData(this_){
				$('#monitorDlg').dialog('open').dialog('center').dialog('setTitle','设备详情');
				record = JSON.parse(this_.attr("data-device"));
				getDeviceInfo(record);
				currentRecord = record;
				getMonitorInfoByDeviceId(currentRecord.uuid,7);
			}
			
		/* 	recordHydro 站点ID 
			DevList  设备列表
			marker  标记
			ismove 是否移动地图 */
			function openInfo(recordHydro,devList,marker,ismove){
					var clickDiv2 = "";
					var clickDiv3 = "";
					var tempClikDiv ="";
					var clickDiv ="";
					var point = new fjzx.map.Point(recordHydro.longitude, recordHydro.latitude);
			        monitorHydroFlag = false;
			        //点击标记物后展示公司排口点
					var dataList = devList;
					   for (var i = 0; i < dataList.length; i++) {
							var record =  dataList[i];
							clickDiv3 = "<tr id='"+record.uuid+"' rname ='"+recordHydro.eqpName+"' data-device= '"+JSON.stringify(record)+"'   onclick=showMonitorData($(this))><td style='text-align:center;'><span class='fa-circle online'></span></td><td>"+record.name+"</td><td><a class='dataDetail'><span class='icon fa-search'></span> 查看详情</a></td></tr>";
					        clickDiv2 = clickDiv2+clickDiv3;
						}
					
				       	var enterpriseStr = "";
				        if(clickDiv2 == ""){
							clickDiv  = "<div class='marker-info-container'>" 
				                +"<div class='base-info'>"
								+"<div class='name'>"+recordHydro.eqpName+"</div>"
								+"<div class='other'><span class='address'>"+recordHydro.addr+"</span></div>"
		                        +"</div>"
								+"<div class='data-info' style='text-align:center; '>"
								+"暂无数据！"
								+"</div>";
						}else{
						     clickDiv  = "<div class='marker-info-container'>" 
				                +"<div class='base-info'>"
								+"<div class='name'>"+recordHydro.eqpName+"</div>"
								+"<div class='other'><span class='address'>"+recordHydro.addr+"</span></div>"
						        +"</div>"
								+"<div class='data-info'>"
								+ "<table id='detailDataTable' class='table-mini no-background no-border'><thead><tr><th style='width:20%;'>联网 </th><th style='width:50%;'>排口名称</th><th style='width:30%;'>操作</th></tr></thead>"
								+"<tbody>"
								+clickDiv2
								+"</tbody></table>"
								+"</div>";
						}
				     
					 var infoWindow  =  new fjzx.map.InfoWindow({infoWindow: clickDiv});
					 var title = recordHydro.name;
					 if(ismove){
						 marker.openInfoWindow(infoWindow);//打开信息窗口  
					 } else{
			             marker.openInfoWindowWithPoint(infoWindow,point,[0,0]);//打开信息窗口  
					 }
					 map.setCenter(point,true);	
			 }
			 
		     
		    $("#monitorDlg").dialog({
					onClose: function () {
						$(".select-panel").removeClass('show');
						$("#polluteCodeList").children("span").removeClass("active");
						$("#ph").addClass("active");
						$("#timeList").children("span").removeClass("active");
						$("#2W").addClass("active");
					}
			});	
		
		 
		
		    var xAxisData = [];
   			var optionMaxYarr = [] ;
   			var optionAvgYarr = [] ;
   			var optionMinYarr = [] ;
   	
   		    var waterFactorChart = null;
		    // 根据设备ID获取监测数据信息
		    function getMonitorInfoByDeviceId(deviceId,day){
		    	 
				$.ajax({
					type: 'POST',
					url:  '${request.contextPath}/hydposition/hydddraindaydata/getHydDrainDayDataByDeviceID',
					data: {'deviceId': deviceId},
			   		success: function (data) {
			   		      
			   			  optionMaxYarr = [] ;
			   			  optionAvgYarr = [] ;
			   			  optionMinYarr = [] ;
			   			  xAxisData = [];
			   		   	 day =  data.length < day ? data.length :day;
			   			 for(var i = 0 ; i<=day ;i++ ){
				   		 	 	var record =  data[i];
				   				xAxisData.push(record.measureTime);
				   				optionAvgYarr.push(record.avgValue);
				   				optionMaxYarr.push(record.maxValue);
				   				optionMinYarr.push(record.minValue);
				   			
			   			  }
			   			  option= {};
			   			  option = {
								title: {
							     },
							    tooltip : {
							    	show :true,
							         trigger: 'axis',
							         axisPointer : {            // 坐标轴指示器，坐标轴触发有效
							            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
							        }
							    },
							    color :["#0000CD","#40E0D0","#CD69C9"],
							    legend: {
							        data:['日均下泄流量','当日最大下泄流量','当日最小下泄流量'],
							        top:'10',
							        textStyle: {
						                color: '#000000',
						                fontSize: 12,
						                fontFamily: 'microsoft yahei light',
						                fontWeight: 300
						            }
							    },
							    dataZoom: [{
					                show: true,
					                realtime: true,
					                start: 20,
					                end: 80
					            }, {
					                type: 'inside',
					                realtime: true,
					                start: 20,
					                end: 80
					            }],
						 
							    xAxis : [
							        {
							        	name: '时间',
							            type : 'category',
							            data : xAxisData
							        }
							    ],
							    yAxis : [
							        {
							          type : 'value'
							        }
							    ],
							    toolbox: {
					                show: true,
					                feature: {
					                    magicType: {//动态类型切换
					                        type: ['line','bar']
					                    },
					                     saveAsImage: { show: true }
					                },
					            },
					            textStyle: {
					                color: '#000000',
					                fontSize: 12,
					                fontFamily: 'microsoft yahei light',
					                fontWeight: 300
					            },
							    series :  [ {
						            name:'日均下泄流量',
						            type:'line',
						            stack: '日均下泄流量',
						            data:optionAvgYarr
						        }, {
						            name:'当日最大下泄流量',
						            type:'line',
						            stack: '当日最大下泄流量',
						            data:optionMaxYarr
						        }, {
						            name:'当日最小下泄流量',
						            type:'line',
						            stack: '当日最小下泄流量',
						            data:optionMinYarr
						        }]
							}; 
			   			 
			   			 if (option && typeof option === "object"&& waterFactorChart!=null) {
					    	  waterFactorChart.setOption(option, true);
						 }
			   			},
					dataType: 'json'
			    });
				return option;
		     }
		    
		    
		 
		    $('#tt').tabs({
		        border:false,
		        onSelect:function(title,index){
		            if(title == "数据分析"){
		            	       waterFactorChart = echarts.init(document.getElementById('waterPointBar'));
				   			    if (option && typeof option === "object") {
				   			    	waterFactorChart.clear();
									waterFactorChart.setOption(option, true);
								}
		            }
		            
		        }
		    });
		    
		    $("#7D").click(function(){
		    	 optionMaxYarr = [] ;
	   			 optionAvgYarr = [] ;
	   			 optionMinYarr = [] ;
	   		 	 xAxisData = [];
		    	leftSelectStyle($(this));
		    	 getMonitorInfoByDeviceId(currentRecord.uuid,7);
 
		    	
		    	
		    });
		    
  			$("#2W").click(function(){
  				 optionMaxYarr = [] ;
	   			 optionAvgYarr = [] ;
	   			 optionMinYarr = [] ;
	   		 	 xAxisData = [];
  				 leftSelectStyle($(this));
  				 getMonitorInfoByDeviceId(currentRecord.uuid,14);
  				 
			  });
		    
		    
		    
			$(".close").click(function(){
				 if($(".map-details-popup").show()){
						$(".map-details-popup").hide();
				} 
			});
 
	     	//测距代码
			var myDis = new fjzx.map.MeasureTool(
				{map: map,measureType: "line"},
				function(){	//开始绘画回调
				},
				function(){	//结束绘画回调
					if($("div#btn_ranging").hasClass("active")){
						$("div#btn_ranging").removeClass("active");
					}
				});
			$("[data-dropdown]").click(function() {
			 
				var $t = $(this);
				if($t.attr("data-dropdown") == '.btn_ranging'){
					myDis.open();
				}
				if($t.attr("data-dropdown") != '.btn_mark_point'){
					if(myMakeMark != null){
						map.removeOverlay(myMakeMark);
						myMakeMark = null;
					}
				}
				
				var target = $($t.attr("data-dropdown"));
				if ($t.hasClass("active")) {
					$t.removeClass("active");
					target.removeClass("show");
				} else {
					$("[data-dropdown]").removeClass("active");
					$(".map-tool-box").removeClass("show");
					$t.addClass("active");
					target.addClass("show");
				}
				if (!$(".map-tool-box").is(".show")) {
					$(".map-toolbar-container").css("bottom", "auto");
				}
			});
			
 

	   //左边侧边栏点击切换样式
        function leftSelectStyle(select) {
            var btnArr = $("#timeList").find("span");
            for (var i = 0; i < btnArr.length; i++) {
                if ($(btnArr[i]).hasClass('active')) {
                    $(btnArr[i]).removeClass("active");
                }
            }
            select.addClass("active");
        }
        $("#filterId").click(function() {
            initEnterpriseTable();
        })

        function initEnterpriseTable() {
            $('#dg_enterprise').datagrid('resize');

        };

    </script>
</body>
</html>