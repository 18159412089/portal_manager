<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>漳州市生态云-环保一张图</title>
	<#include "/header.ftl"/>
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
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
    <style>
		#pf-hd {
		    height: 70px;
		    position: relative;
		    z-index: 2;
		    background: url('images/main/top_bottombg.png?1464006836') left bottom repeat-x;
		        background-color: rgba(0, 0, 0, 0);
		    background-color: #268AEA;
		}
		#pf-hd .pf-logo {
		    float: left;
		    padding: 0 15px;
		    height: 100%;
		    min-width: 230px;
		    border-right: 1px solid #2078cb;
		    line-height: 70px;
		    color: #ffffff;
		    font-size: 24px;
		}
		#pf-hd .pf-logo img {
		    vertical-align: middle;
		    margin-left: -10px;
		}
		.ztree li a{color:#fff;}
	</style>
</head>

<body>
<#include "/common/loadingDiv.ftl"/>
 <!--标记筛选-->
    <div id="pf-hd">
		<span class="pf-logo">
	   		<img src="/static/images/blocks1.png" align="absmiddle">  漳州生态云
	    </span>
	</div>
<div class="container" style="position: absolute;top:70px;bottom: 0px;left:0px;right: 0px;">
	<div class="filter-marker-container style-tabs" style="position: absolute;top:0;bottom: 0;left: 0;z-index: 2;">
		<div class="filter-marker-tip" style="display:none;"></div>
		<div class="btn-group">
			<div class="btn pollutant">
				<span class="icon iconcustom icon-wuranyuan1"></span><span>污染源专题</span>
				<div class="second-menu">
					<div class="menu-top">
						<span class="title">污染源专题</span>
					</div>
					<ul class="menu-content">
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
					</ul>
				</div>
			</div>
			<div class="btn water">
				<span class="icon iconcustom icon-wuranyuan2"></span><span>水环境质量</span>
				<div class="second-menu">
					<div class="menu-top">
						<span class="title">水环境质量</span>
					</div>
					<ul class="menu-content">
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
						<li><a href="" ><span class="icon iconcustom icon-zhedie3"></span>处理率</a></li>
					</ul>
				</div>
			</div>
			<div class="btn air active">
				<span class="icon iconcustom icon-huanjing2"></span><span>空气环境质量</span>
			</div>
			<div class="btn soild">
				<span class="icon iconcustom icon-zichan3"></span><span>固废危废</span>
			</div>
			<div class="btn radiate">
				<span class="icon iconcustom icon-fangsheyuan1"></span><span>核与辐射</span>
			</div>
			<div class="btn risk">
				<span class="icon iconcustom icon-fengxian1"></span><span>风险源</span>
			</div>
		</div>
	</div>
	<div class="map-container">
		<div class="map-wrapper">
			<div id="allMap" class="map-wrapper" style="height:100%"></div><!--地图层-->
		<!--左侧工具栏-->
		<div class="map-tool-container">
			<ul>
				<li>
					<div id="btn_ranging"  class="btn-map-tool"  data-dropdown=".btn_ranging" data-parent=".map-toolbar-container"><span class="icon iconcustom  icon-ceju"></span>测距</div>
				</li>
				<li id="accordionFilter">
					<div id="filterId" class="btn-map-tool collapsed" data-target="#dFilter" data-toggle="collapse" data-parent="#accordionFilter"><span class="icon iconcustom  icon-shaixuan1"></span>筛选</div>
					<div id="dFilter" class="collapse">
						<div class="dropdown-panel-container">
							<div class="dropdown-panel-top">
								<span>企业综合分析监控图</span>
							</div>
							<div class="dropdown-panel-body">
								<div class="column-group">
									<div class="top">
										<div class="title"><span class="icon fa-filter"></span>筛选</div>
									</div>
									<div class="column-con">
										<div class="search-box" style="border-bottom: 1px solid #c8c8c8;">
											<div class="form-group">
												<label class="control-label">污染源类型：</label>
												<div class="control-div">
													<input class="form-control" placeholder="" style="width: 252px;" type="text">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label">企业名称：</label>
												<div class="control-div">
													<input class="form-control" placeholder="" style="width: 252px;" type="text">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label"></label>
												<div class="control-div tr">
													<button type="button" class="btn-blue l-btn m0" style="margin-bottom:10px;"><span class="icon fa-search"></span> 查询</button>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="column-group">
									<div class="top">
										<div class="title"><span class="icon fa-info-sign"></span>企业信息</div>
									</div>
									<div class="column-con">
										<table class="table-mini">
											<thead>
											<tr>
												<th>定位</th>
												<th>企业名称</th>
												<th>运维人员</th>
												<th>详情</th>
											</tr>
											</thead>
											<tbody>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="icon_img location"></div>
												</td>
												<td>蕉岭县蕉城污水处理厂</td>
												<td>沈云溪</td>
												<td>
													<div class="icon_img search"></div>
												</td>
											</tr>
											</tbody>
										</table>
										<!--分页-->
										<div class="pagination-mini">
											<div class="left">
												共<span>212</span>条记录
											</div>
											<div class="right">
												第<span>1</span>页&nbsp;
												共<span>3</span>页&nbsp;
												<a href="">下一页 ></a>
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
 
	    
<!-- main over -->

 
 <script>
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };
		    //window.parent.toggleSider("collapse");//收起侧边菜单
        	//window.parent.toggleSider();//展开侧边菜单
        	var map = null ;
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
			//筛选点击 默认隐藏
	        $("#dFilter").hide();
	    	$("#filterId").click(function(){
	    		var display =$('#dFilter').css('display');
	    		if(display == 'none'){
	    			$("#dFilter").show();
	    		}else{
	    			$("#dFilter").hide();
	    		}
	    	});
	      var hydroStationArray=null;
	      var airStationArray=null;
	      var waterStationArray=null;
	      var solidStationArray=null;
	      var pollutantStationArray=null;
	      var riskStationArray=null;
	      var radiateStationArray=null;
	      var onlyMonitorFlag =true ;
	  	  var idArray = new Array();
	  	  var myMarkMap =  new HashMap();
	      var allSignArr = new Array();
          function initStation(){
			  $.ajax({
					type: 'POST',
					url:  '${request.contextPath}/epa/epaMainMap/getAirStationManage',
			   		success: function (data) {
				   		hydroStationArray =[];
				   		airStationArray =[];
				   		waterStationArray =[];
				   		solidStationArray =[];
				   		pollutantStationArray =[];
				   		riskStationArray =[];
				   		radiateStationArray =[];
			   		 for (var i = 0; i < data.length; i++) {
							var record = data[i];
							switch(record.type){
							  case "pollutant" :
								  pollutantStationArray.push(record);
								  break;
							  case "air" :
								  hydroStationArray.push(record);
								  break;
							  case "water" :
								  waterStationArray.push(record);
								  break;
							  case "soild" :
								  solidStationArray.push(record);
								  break;
							  case "risk" :
								  riskStationArray.push(record);
								  break;
							  case "radiate" :
								  radiateStationArray.push(record);
								  break;
								  
							}
						  
					  } 
			   		addMakerStation("air",hydroStationArray); 
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
						 	 iconMap =  new fjzx.map.Icon( getImagePathByType(type), new fjzx.map.Size(30, 30));
							 myMarker = new fjzx.map.Marker(point, {
								icon : iconMap,
								map : map
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
				  case "pollutant" :
					  imagePath = "${request.contextPath}/static/images/pollutant.png";
					  break;
				  case "air" :
					  imagePath = "${request.contextPath}/static/images/air.png";
					  break;
				  case "water" :
					  imagePath = "${request.contextPath}/static/images/water.png";
					  break;
				  case "soild" :
					  imagePath = "${request.contextPath}/static/images/soild.png";
					  break;
				  case "risk" :
					  imagePath = "${request.contextPath}/static/images/risk.png";
					  break;
				  case "radiate" :
					  imagePath = "${request.contextPath}/static/images/radiate.png";
					  break;
				 }
            	return imagePath;
            }
          
			var monitorHydroFlag = false;
			function addClickHandler(record,myMarker){
			    myMarker.addClick(function(e){
					if(!monitorHydroFlag){
				  		monitorHydroFlag = true;
				  		$(".map-details-popup").hide();
						openInfo(record,myMarker,true);
					};
				});
			}
			
			function openInfo(recordHydro,marker,ismove){
					var clickDiv2 = "";
					var clickDiv3 = "";
					var tempClikDiv ="";
					var clickDiv ="";
					var point = new fjzx.map.Point(recordHydro.longitude, recordHydro.latitude);
			        monitorHydroFlag = false;
			        //点击标记物后展示公司排口点
					var dataList = recordHydro.port;
					if(recordHydro.type == "risk" || recordHydro.type == "soild"  || recordHydro.type == "radiate" ){
						 clickDiv = openInfoDivByType(recordHydro);
					    }else{
						for (var i = 0; i < dataList.length; i++) {
							var record =  dataList[i];
							clickDiv3 = "<tr id='"+record.id+"' rname ='"+recordHydro.name+"' onclick=showMonitorData('"+JSON.stringify(record)+"')><td style='text-align:center;'><span class='fa-circle online'></span></td><td>"+record.name+"</td><td><a class='dataDetail'><span class='icon fa-search'></span> 查看详情</a></td></tr>";
					        clickDiv2 = clickDiv2+clickDiv3;
						}
				       	var enterpriseStr = "";
				        if(clickDiv2 == ""){
							clickDiv  = "<div class='marker-info-container'>" 
				                +"<div class='base-info'>"
								+"<div class='name'>"+recordHydro.name+"</div>"
								+"<div class='other'><span class='address'>"+recordHydro.address+"</span></div>"
		                        +"</div>"
								+"<div class='data-info' style='text-align:center; '>"
								+"暂无数据！"
								+"</div>";
						}else{
						     clickDiv  = "<div class='marker-info-container'>" 
				                +"<div class='base-info'>"
								+"<div class='name'>"+recordHydro.name+"</div>"
								+"<div class='other'><span class='address'>"+recordHydro.address+"</span></div>"
						        +"</div>"
								+"<div class='data-info'>"
								+ "<table id='detailDataTable' class='table-mini no-background no-border'><thead><tr><th style='width:20%;'>联网 </th><th style='width:50%;'>排口名称</th><th style='width:30%;'>操作</th></tr></thead>"
								+"<tbody>"
								+clickDiv2
								+"</tbody></table>"
								+"</div>";
						}
					}
					 var infoWindow  =  new fjzx.map.InfoWindow({infoWindow: clickDiv});
					 openWindowInfo_Monitor = infoWindow;
					 var title = recordHydro.name;
					 if(ismove){
						 marker.openInfoWindow(infoWindow);//打开信息窗口  
					 } else{
			             marker.openInfoWindowWithPoint(infoWindow,point,[0,0]);//打开信息窗口  
					 }
					 map.setCenter(point,true);	
			 }
			function openInfoDivByType(recordHydro){
				var clickDiv = null;
				if(recordHydro.type == "risk"){
					 clickDiv = "<div class='map-infoWindow'>"
						+"<div class='event-attr'>"
							+"<div class='event-con'>"
							+"	<div class='tit'>风险源信息</div>"
							+"</div>"
							+"<div class='group'>"
								+"<div class='property'>核素：</div>"
								+"<div class='value'>"+recordHydro.hesu+"</div>"
							+"</div>"
							+"</div>"
							+"<div class='group'>"
								+"<div class='property'>单位名称：</div>"
								+"<div class='value' >"+recordHydro.name+"</div>"
							+"</div>"
							+"<div class='group'>"
								+"<div class='property'>地址：</div>"
								+"<div class='value' >"+recordHydro.address+"</div>"
							+"</div>"
							+"<div class='group' style='padding-top:2px;'>"
							+"<a onClick=onclick=showMonitorData('"+JSON.stringify(recordHydro.port[0])+"');title='跳转到单位风险物资列表详情'>查看详情</a>"
							+"</div>"
							+"</div>"
						+"</div>";
				}else if(recordHydro.type == "soild"){
					 clickDiv = "<div class='map-infoWindow'>"
							+"<div class='event-attr'>"
								+"<div class='event-con'>"
								+"	<div class='tit'>固废危废信息</div>"
								+"</div>"
								+"<div class='group'>"
									+"<div class='property'>名称：</div>"
									+"<div class='value'>"+recordHydro.name+"</div>"
								+"</div>"
								+"</div>"
								+"<div class='group'>"
									+"<div class='property'>地址：</div>"
									+"<div class='value' >"+recordHydro.address+"</div>"
								+"</div>"
								+"<div class='group' style='padding-top:2px;'>"
								+"<a onClick=onclick=showMonitorData('"+JSON.stringify(recordHydro.port[0])+"');title='跳转到单位风险物资列表详情'>查看详情</a>"
								+"</div>"
							+"</div>";
					
				}else if(recordHydro.type == "radiate"){
					 clickDiv = "<div class='map-infoWindow'>"
							+"<div class='event-attr'>"
								+"<div class='event-con'>"
								+"	<div class='tit'>辐射基站信息</div>"
								+"</div>"
								+"<div class='group'>"
									+"<div class='property'>名称：</div>"
									+"<div class='value'>"+recordHydro.name+"</div>"
								+"</div>"
								+"</div>"
								+"<div class='group'>"
									+"<div class='property'>地址：</div>"
									+"<div class='value' >"+recordHydro.address+"</div>"
								+"</div>"
								+"<div class='group' style='padding-top:2px;'>"
								+"<a onClick=onclick=showMonitorData('"+JSON.stringify(recordHydro.port[0])+"');title='跳转到单位风险物资列表详情'>查看详情</a>"
								+"</div>"
							+"</div>";
				}
				 return clickDiv;
			}
			
			$(".close").click(function(){
				
				if($(".map-details-popup").show()){
						$(".map-details-popup").hide();
				} 
			});
			
        	$(window).resize(function() {
        	
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
			
 
      //数据详情
		function showMonitorData(record){
			$(".map-details-popup").show();  
			record = JSON.parse(record);
			getMonitorDeviceForPollutant(record.id,"", getNowFormatDate()+"00:00:00",getNowFormatDate()+"23:59:59")
		}
	 
		function getMonitorDeviceForPollutant(rtuId ,dataType,monitorDateStart,monitorDateEnd){
		
		    if(rtuId==null) return ;
		    $.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/epa/epaMainMap/getAirPortInfo',
				data: {
					   'uuid': rtuId
				  },
				success: function (result) {
					    $("#dg").datagrid("loadData", { total: 0, rows: [] });
				        var columnList =  result.columnList;
						var rowData = result.rowData;
						$('#dg').datagrid({
							fit: true,
							nowrap:false,
							fitColumns:true,
					        columns:[columnList],
					        view:bufferview,
					        rownumbers:true,
					        singleSelect:true,
					        autoRowWidth:true,
					        autoRowHeight:false,
					        pageSize:50
						 });
						$('#dg').datagrid('loadData', rowData);
						$('#dg').datagrid('resize');
				},
			dataType: 'json'
			});
		   }	
		
		 //更改数据源
		   function changeMapSourceByType(type){
			     map.getOverlays().clear();
			     switch(type){
				  case "pollutant" :
						addMakerStation(type,pollutantStationArray); 
					  break;
				  case "air" :
						addMakerStation(type,hydroStationArray); 
					  break;
				  case "water" :
					  addMakerStation(type,waterStationArray); 
					  break;
				  case "soild" :
					  addMakerStation(type,solidStationArray); 
					  break;
				  case "risk" :
					  addMakerStation(type,riskStationArray); 
					  break;
				  case "radiate" :
					  addMakerStation(type,radiateStationArray); 
					  break;
				}
	 
		   } 
		   //污染源专题
		   $(".pollutant").click(function(){
			  leftSelectStyle($(this));
			  changeMapSourceByType("pollutant");
			   
		   })
		   //水环境质量
		   $(".water").click(function(){
			   changeMapSourceByType("water");
		   })
		   //空气环境质量
		   $(".air").click(function(){
			   changeMapSourceByType("air");
		   })
		   //固废危废
		   $(".soild").click(function(){
			   changeMapSourceByType("soild");
		   })
		   //核与辐射
		   $(".radiate").click(function(){
			   changeMapSourceByType("radiate");
		   })
		   //风险源
		   $(".risk").click(function(){
			   changeMapSourceByType("risk");
		   })
		   //左边侧边栏点击切换样式
		   function leftSelectStyle(select){
			   var btnArr = $(".btn-group").find(".btn");
			   for(var i = 0 ; i<btnArr.length;i++){
				   if($(btnArr[i]).hasClass('active')){
					    $(btnArr[i]).removeClass("active");
				   }	 
			   }
			   select.addClass("active");
		 	}
		   function getNowFormatDate() {
			    var date = new Date();
			    var seperator1 = "-";
			    var seperator2 = ":";
			    var month = date.getMonth() + 1;
			    var strDate = date.getDate();
			    if (month >= 1 && month <= 9) {
			        month = "0" + month;
			    }
			    if (strDate >= 0 && strDate <= 9) {
			        strDate = "0" + strDate;
			    }
			    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
			            + " ";
			    return currentdate;
			}
		   
		   
    </script>
</body>
</html>