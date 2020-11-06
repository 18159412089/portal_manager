<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>近岸海域</title> <#include "/decorators/header.ftl"/>
<!-- ol -->
<link rel="stylesheet"
	href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
<script type="text/javascript"
	src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
<!-- Custom -->
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
<!-- ol end -->

<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>

<!-- 地图相关 -->
<script
	src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script
	src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<script src="${request.contextPath}/static/js/epaConsole.js"></script>
<link rel="stylesheet"
	href="${request.contextPath}/static/css/EcologicalCloudMap.css" />
<link rel="stylesheet"
	href="${request.contextPath}/static/css/EcologicalCloud.css" />
<#include "/waterEnvironmentMenu.ftl">
<style>
.ztree li a {
	color: #fff;
}
</style>
</head>

<body>
	<#include "/common/loadingDiv.ftl"/>
	<!--标记筛选-->

	<div class="container"
		style="position: absolute; top: 70px; bottom: 0px; left: 0px; right: 0px;">
		<div class="map-container">
			<div class="map-wrapper">
				<div id="allMap" class="map-wrapper" style="height: 100%"></div>
				<!--地图层-->
				<!--左侧工具栏-->
				<div class="map-tool-container" style="z-index: 1;">
					<div class="map-panel"
						style="position: absolute; top: 72px; right: 30px;">
						<div class="map-panel-header">
							<span class="title"> <span
								class="icon iconcustom icon-zhedie3"></span>近岸海域分析监控图
							</span>
						</div>
						<div class="map-panel-body"
							style="height: 450px; width: 400px; position: relative;">
							<div class="theme-container" style="width: 400px;">
								<div class="theme-title">筛选</div>
								<div class="theme-content">
									<div class="search-container" id="search2">
										<div class="search-box">
											<input id="stationName" class="easyui-textbox"
												style="width: 100%;" /> <a href="javascript:void(0)" id="searchStation"
												class="easyui-linkbutton"
												data-options="iconCls:'icon-search'"></a>
										</div>
									</div>
									<div class="easyui-table-light">
										<table id="dg_enterprise" class="easyui-datagrid"
											style="width: 400px; height: 400px;" toolbar="#search2"
											url="${request.contextPath}/area/siteInfo/getAreaSiteInfoPage"
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
													<th field="local" formatter="locationEnterpriseOnMap"
														width="50">定位</th>
													<th field="kdmc" width="150">名称</th>
													<th field="xzqh" width="150">地址</th>
													<th field="detail" formatter="imgFormatterByDetail"
														width="50">详情</th>
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
							<li class="btn task" layer_group="GLOBAL_IMG_MAP"><span
								class="icon fa-globe"></span><span>卫星图层</span></li>
							<li class="btn report active" layer_group="GLOBAL_VEC_MAP">
								<span class="icon fa-road"></span><span>矢量图层</span>
							</li>
						</ul>
					</div>


				</div>

				<!--地图内的详情列表-->
				<div class="map-details-popup" style="display: none">
					<div class="popup-top">
						<span class="close">&times;</span>
						<div class="title" id="moreMoniorInfo"
							style="margin-right: 37px; color: #0088cc; cursor: pointer;">
							漳州市环境质量数据详情</div>

					</div>
					<div class="popup-con">
						<table id="dg" class="easyui-datagrid"
							style="width: 100%; height: auto;" toolbar="#toolbar"
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
		<div id="monitorDlg" class="easyui-dialog"
			style="width: 800px; background: #ADADAD;"
			data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
			<div class="map-panel">
				<div id="tt" class="easyui-tabs easyui-tabs-bg"
					style="width: 100%; height: 380px;">
					<div title="详情" selected="true">
						<div class="panel-group-container">
							<div class="panel-group-top">
								<span id="deviceName"></span>
							</div>
							<div class="panel-group-body">
								<div class="panel-info" id="pointInfo"></div>
							</div>
						</div>
					</div>
					<div title="数据分析">
						<div class="data-analysis">
							<div id="polluteCodeDiv" class="radio-button-group style-list fl"
								style="width: 100px; height: 100%;">
								<div id="polluteCodeList"></div>
							</div>
							<div class="oh data-analysis-content">
								<div id="timeList" class="radio-button-group">
									<span id="7D" class="active" value="">最近7天</span> <span id="2W"
										class="" value="">最近2周</span>
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
        var currentData = null;
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
        
        $("#polluteCodeDiv").mCustomScrollbar({
            theme : "dark-3",
            scrollButtons : {
                enable : true
            }
        });

        $("#searchStation").click(function() {
            $('#dg_enterprise').datagrid('load', {
                stationName : $("#stationName").val().trim()
            });
        });

        //企业信息列表绑定相关函数 --start--
        function locationEnterpriseOnMap(value, row, index) {
            var value = "<div onclick=localtionAndOpenInfoWindow($(this)) row-data="
                    + JSON.stringify(row)
                    + " > <img style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_01.png></div>";
            return value;
        }

        function imgFormatterByDetail(value, row, index) {

            value = "<img  onclick= localtionAndOpenInfoWindow($(this)) row-data="
                    + JSON.stringify(row)
                    + " style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_02.png>";
            return value;
        }

        function localtionAndOpenInfoWindow(target) {
            var record = JSON.parse(target.attr("row-data"));

            if (record.jd == null || record.wd == null) {
                $.messager.show({
                    title : '提示',
                    msg : "该站点暂无定位信息！"
                });
                return false;
            }
            var point = new fjzx.map.Point(record.jd, record.wd);
            map.setCenter(point);
            openSeaSiteDetail(record);
        }

        var map = null;
        var option = {};
        function initMapForEpa() {
            var longitude = "117.65";
            var latitude = "24.52";
            map = initMap({
                target : "allMap",
                center : [ parseFloat(longitude), parseFloat(latitude) ],
                layers : fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
                zoom : 15
            });
            map.render();
        }
        initMapForEpa();

        /* //筛选点击 默认隐藏
        $("#dFilter").show(); */
        $("#filterId").click(function() {
            var display = $('#dFilter').css('display');
            if (display == 'none') {
                $("#dFilter").show();
            } else {
                $("#dFilter").hide();
            }
        });

        var hydroStationArray = null;
        var onlyMonitorFlag = true;
        var idArray = new Array();
        var myMarkMap = new HashMap();
        var allSignArr = new Array();
        function initStation() {
            $
                    .ajax({
                        type : 'POST',
                        url : '${request.contextPath}/area/siteInfo/getAreaSiteInfoPage',
                        success : function(data) {
                            hydroStationArray = [];

                            for (var i = 0; i < data.rows.length; i++) {
                                var record = data.rows[i];
                                hydroStationArray.push(record);
                            }
                            addMakerStation(hydroStationArray);
                        },
                        dataType : 'json'
                    });
        }
        var colmnMap = new Map();

        function getLeftMenuColmnName(skbm) {
            $
                    .ajax({
                        type : 'POST',
                        url : '${request.contextPath}/area/siteMonitorData/getLeftMenuColumnName',
                        success : function(data) {
                            var str = "";
                            colmnMap.clear();
                            for (var i = 0; i < data[0].length; i++) {
                                colmnMap.set(data[0][i]["COLUMN_NAME"],
                                        data[0][i]["COMMENTS"]);
                                str = str
                                        + '<span  skbm = "'+skbm+'"  id="'+data[0][i]["COLUMN_NAME"]+'"    value="'+data[0][i]["COMMENTS"]+'">'
                                        + data[0][i]["COMMENTS"] + '</span>'
                            }
                            $("#polluteCodeList").text("");// 清空数据
                            $("#polluteCodeList").append(str);
                            addMenuLeftClick();
                        },
                        dataType : 'json'
                    });
        }

        initStation();
        function addMakerStation(stationArray) {

            for (var i = 0; i < stationArray.length; i++) {
                var record = stationArray[i];

                var point = new fjzx.map.Point(record.jd, record.wd);
                if (markerMap.get(record.skbm) == null) {
                    imagePath = "${request.contextPath}/static/images/area.png";
                    iconMap = new fjzx.map.Icon(imagePath, new fjzx.map.Size(
                            30, 40));
                    myMarker = new fjzx.map.Marker(point, {
                        icon : iconMap,
                        map : map,
                        title : record.kdmc
                    });
                } else {
                    myMarker = markerMap.get(record.skbm);
                }
                idArray[i] = record.pointcode;
                myMarker.type = "area";
                myMarker.recordJson = record;
                map.addOverlay(myMarker);
                myMarkMap.put(record.skbm, myMarker);
                addClickHandler(record, myMarker);
                markerMap.put(record.skbm, myMarker);
                allSignArr.push(myMarker);
            }
        }

        var monitorHydroFlag = false;
        function addClickHandler(record, myMarker) {
            myMarker.addClick(function(e) {
                if (!monitorHydroFlag) {
                    monitorHydroFlag = true;
                    openSeaSiteDetail(record);
                }
                ;
            });
        }
        //打开 近岸海域详情页
        function openSeaSiteDetail(record) {

            $
                    .ajax({
                        type : 'POST',
                        url : '${request.contextPath}/area/siteInfo/getAreaSiteInfoListBySkbm',
                        data : {
                            'SKBM' : record.skbm
                        },
                        success : function(data) {
                            monitorHydroFlag = false;
                            $('#monitorDlg').dialog('open').dialog('center')
                                    .dialog('setTitle', '近岸海域点位详情');
                            getDeviceInfo(record);
                            getLeftMenuColmnName(record.skbm);
                            currentRecord = record;
                            currentData = null;
                            currentData = data;

                            getMonitorInfoByStationId(data);

                        },
                        dataType : 'json'
                    });
        }

        function getDeviceInfo(info) {

            var gkbm = (typeof (info.gkbm) == "undefined" || info.gkbm == null) ? " "
                    : info.gkbm;

            document.getElementById('deviceName').innerHTML = info.kdmc;
            document.getElementById('pointInfo').innerHTML = '<span>经度：'
                    + info.jd + '</span>' + '<span>纬度：' + info.wd + '</span>'
                    + '<span>行政区划名称：' + info.xzqh + '</span>' + '<span></span>'
                    + '<span>国控编码：' + gkbm + '</span>' + '<span>省控编码：'
                    + info.skbm + '</span>';
        }

        $("#monitorDlg").dialog({
            onClose : function() {
                $(".select-panel").removeClass('show');
                $("#polluteCodeList").children("span").removeClass("active");
                $("#ph").addClass("active");
                $("#timeList").children("span").removeClass("active");
                $("#2W").addClass("active");
            }
        });

        var xAxisData = [];
        var optionYarr = [];
        var waterFactorChart = null;
        // 根据设备ID获取监测数据信息
        function getMonitorInfoByStationId(data) {
            optionYarr = [];
            xAxisData = [];
            optionYarr = data["monitorValueArr"];
            xAxisData = data["jcsjArr"];
            option = {};
            option = {
                title : {},
                tooltip : {
                    show : true,
                    trigger : 'axis',
                    axisPointer : { // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                color : [ "#0000CD" ],
                legend : {
                    data : [ colmnMap.get("" + data["monitorName"] + "") ],
                    top : '10',
                    textStyle : {
                        color : '#000000',
                        fontSize : 12,
                        fontFamily : 'microsoft yahei light',
                        fontWeight : 300
                    }
                },
                dataZoom : [ {
                    show : true,
                    realtime : true,
                    start : 20,
                    end : 80
                }, {
                    type : 'inside',
                    realtime : true,
                    start : 20,
                    end : 80
                } ],

                xAxis : [ {
                    name : '时间',
                    type : 'category',
                    data : xAxisData
                } ],
                yAxis : [ {
                    type : 'value'
                } ],
                toolbox : {
                    show : true,
                    feature : {
                        magicType : {//动态类型切换
                            type : [ 'line', 'bar' ]
                        },
                        saveAsImage : {
                            show : true
                        }
                    },
                },
                textStyle : {
                    color : '#000000',
                    fontSize : 12,
                    fontFamily : 'microsoft yahei light',
                    fontWeight : 300
                },
                series : [ {
                    name : colmnMap.get("" + data["monitorName"] + ""),
                    type : 'line',
                    stack : colmnMap.get("" + data["monitorName"] + ""),
                    data : optionYarr
                } ]
            };

            if (option && typeof option === "object"
                    && waterFactorChart != null) {
                waterFactorChart.setOption(option, true);
            }
        }

        $('#tt').tabs(
                {
                    border : false,
                    onSelect : function(title, index) {
                        if (title == "数据分析") {
                            waterFactorChart = echarts.init(document
                                    .getElementById('waterPointBar'));
                            if (option && typeof option === "object") {
                                waterFactorChart.clear();
                                waterFactorChart.setOption(option, true);
                            }
                        }

                    }
                });
        $("#7D").hide();
        $("#2W").hide();
        $("#7D").click(function() {
            optionMaxYarr = [];
            optionAvgYarr = [];
            optionMinYarr = [];
            xAxisData = [];
            selectStyle($(this), $("#timeList"));
            //getMonitorInfoByStationId(currentRecord.uuid, 7);

        });

        $("#2W").click(function() {
            optionMaxYarr = [];
            optionAvgYarr = [];
            optionMinYarr = [];
            xAxisData = [];
            selectStyle($(this), $("#timeList"));
            //getMonitorInfoByStationId(currentRecord.uuid, 14);

        });
        function addMenuLeftClick() {
            var pollutionCodeListSpan = $("#polluteCodeList").find("span");
            for (var i = 0; i < pollutionCodeListSpan.length; i++) {
                $(pollutionCodeListSpan[i]).click(
                        function() {
                            selectStyle($(this), $("#polluteCodeList"));
                            menuLeftResolve($(this).attr("id"), $(this).attr(
                                    "skbm"), $(this).attr("value"));
                        })
            }
            defaultSelect($(pollutionCodeListSpan[0]));
        }
        //默认选择
        function defaultSelect(target) {
            target.attr("class", "active");
            menuLeftResolve(target.attr("id"), target.attr("SKBM"), target
                    .attr("value"));
        }

        function menuLeftResolve(id, skbm, titleName) {

            $
                    .ajax({
                        type : 'POST',
                        url : '${request.contextPath}/area/siteMonitorData/getSiteMonitorDataInfo',
                        data : {
                            'skbm' : skbm,
                            'columnName' : id
                        },
                        success : function(data) {
                            getMonitorInfoByStationId(data);
                        },
                        dataType : 'json'
                    });

        }

        $(".close").click(function() {
            if ($(".map-details-popup").show()) {
                $(".map-details-popup").hide();
            }
        });

        //测距代码
        var myDis = new fjzx.map.MeasureTool({
            map : map,
            measureType : "line"
        }, function() { //开始绘画回调
        }, function() { //结束绘画回调
            if ($("div#btn_ranging").hasClass("active")) {
                $("div#btn_ranging").removeClass("active");
            }
        });
        $("[data-dropdown]").click(function() {

            var $t = $(this);
            if ($t.attr("data-dropdown") == '.btn_ranging') {
                myDis.open();
            }
            if ($t.attr("data-dropdown") != '.btn_mark_point') {
                if (myMakeMark != null) {
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
        function selectStyle(select, target) {
            var btnArr = target.find("span");
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