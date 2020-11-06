<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>漳州市生态云-环保一张图</title>

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
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<!--标记筛选-->
<!-- <div id="pf-hd" style="position: absolute;width:100%;">
	<span class="pf-logo">
   		<img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="${request.contextPath}/static/images/main/user.png" alt="">
        </div>
        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
        <i class="iconfont xiala">&#xe607;</i>

        <div class="pf-user-panel">
            <ul class="pf-user-opt">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <li class="pf-modify-pwd">
                    <a href="javascript:void(0)" id="editpass">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li class="pf-logout">
                    <a href="javascript:void(0)" id="loginOut">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div> -->
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
    <div class="map-container">
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

            <!-- 实时统计数据 -->
            <div class="map-data-container" style="position: absolute; top: 70px; right: 0px;">
					<span class="map-data-item">
						<img src="${request.contextPath}/static/images/map_icon.png" />&nbsp;实时联网率：
						<span id="net_working">100%</span>
					</span>
                <span class="map-data-item">
						<img src="${request.contextPath}/static/images/map_icon1.png" />&nbsp;废水站点：
						<span class="fa-circle online"></span>&nbsp;
						<span id="water_online">0</span>个在线
						<span class="fa-circle offline"></span>&nbsp;
						<span id="water_offline">0</span>个离线
					</span>
                <span class="map-data-item">
						<img src="${request.contextPath}/static/images/map_icon2.png" />&nbsp;废气站点：
						<span class="fa-circle online"></span>&nbsp;
						<span id="gas_online">0</span>个在线  
						<span class="fa-circle offline"></span>&nbsp;
						<span id="gas_offline">0</span>个离线
					</span>
            </div>
            <!-- 实时统计数据 over -->
        <#--<div class="map-panel panel-top" style="position: absolute; top: 86px; left: 42px; width: 360px;">-->
        <#--<div class="map-panel-header">-->
        <#--<span class="title"><span class="icon iconcustom icon-zhedie3"></span> 企业综合分析监控</span>-->
        <#--</div>-->
        <#--<div class="map-panel-body" style="height: 448px;">-->
        <#--<div class="map-panel-subtext tl">-->
        <#--<div class="column-group">-->
        <#--<div class="top">-->
        <#--<div class="title"><span class="icon fa-filter"></span>筛选</div>-->
        <#--</div>-->
        <#--<div class="column-con">-->
        <#--<div class="search-box">-->
        <#--<div class="form-group">-->
        <#--<select id="peCommonCode" name="peCommonCode" class="easyui-combobox" label="污染源类型：" style="width: 339px;"></select>-->
        <#--</div>-->
        <#--<div class="form-group">-->
        <#--<select id="enterpirseId" name="enterpirseId" class="easyui-combobox" label="企 业 名 称：" style="width: 339px;"></select>-->
        <#--</div>-->
        <#--<div class="">-->
        <#--<label class="control-label"></label>-->
        <#--<div class="control-div tr">-->
        <#--<button type="button" id="selectEnterpriseId" class="btn-blue l-btn" style="margin: 0px;"><span class="icon fa-search"></span> 查询</button>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--<div class="panel-group-container" id="cityPanel"-->
        <#--style="height: 300px;">-->
        <#--<div class="panel-group-box">-->
        <#--<div class="panel-group-top">企业信息：</div>-->
        <#--<div class="panel-group-body" style="height: 242px;">-->
        <#--<table id="dg_enterprise" class="easyui-datagrid" style="width: 100%; height: 100%">-->
        <#--<thead>-->
        <#--<tr>-->
        <#--<th field="local" formatter="locationEnterpriseOnMap" width="120">定位</th>-->
        <#--<th field="peName" width="250">名称</th>-->
        <#--<th field="envPrincipal" width="150">负责人</th>-->
        <#--<th field="detail" formatter="imgFormatterByDetail" width="120">详情</th>-->
        <#--</tr>-->
        <#--</thead>-->
        <#--</table>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->

            <!-- 企业综合分析监控 -->
            <div class="map-panel" style="position:absolute;top:86px;left: 60px;">
                <div class="map-panel-header  map-panel-header-left">
					<span class="title">
						<span class="icon iconcustom icon-zhedie3"></span>
					    企业综合分析监控
					</span>
                </div>
                <div class="map-panel-body" style="height: 502px;width:390px;position: relative;">
                    <div class="theme-container" style="width:390px;">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="search2">
                                <div class="search-box">
                                    <div class="form-group form-group-alone">
                                        <select id="peCommonCode" name="peCommonCode" class="easyui-combobox" label="污染源类型：" style="width: 339px;"></select>
                                    </div>
                                    <div class="form-group form-group-alone">
                                        <select id="enterpirseId" name="enterpirseId" class="easyui-combobox" label="企业名称：" style="width: 339px;"></select>
                                    </div>
                                    <div class="form-group form-group-right">
                                        <a href="javascript:void(0)" id="selectEnterpriseId" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'">查询</a>
                                    </div>
                                </div>
                            </div>
                            <div class="easyui-table-light alone-table-style"  id="cityPanel">
                                <table id="dg_enterprise" class="easyui-datagrid alone-datagrid"
                                       style="width: 100%;height:454px;" toolbar="#search2"
                                       url=""
                                       data-options="
					                   rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="peName" width="250" formatter="Ams.tooltipFormat">名称</th>
                                        <th field="envPrincipal" width="150" formatter="Ams.tooltipFormat">负责人</th>
                                        <th field="local" width="120" formatter="locationEnterpriseOnMap">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
            <!-- 企业综合分析监控 -->



            <div id="bottonDiv" class="map-panel panel-top collapsed"
                 style="position: absolute; left: 240px; bottom: 27px; right: 18px;">
                <div class="map-panel-header ">
                <#--min-panel-header-->
                    <span class="title"> <span class="icon iconcustom icon-zhedie3"></span> <label id="monitorDataEnterpriseName">企业排口综合分析数据详情</label>
						</span>
                </div>
                <div class="map-panel-body" style="height: 264px; width: 100%;">
                    <div class="theme-container" >
                        <div class="theme-title">
                            <span>企业综合分析监控</span>
                            <span class="time-span">2019.1.18 14:43</span>
                        </div>
                        <div class="theme-content scroll-theme-content"  >
                            <div class="easyui-table-light alone-table-style">
                                <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 264px;">
                                    <table id="monitorDeviceDataTable" class="easyui-datagrid" style="width: 100% px; height: 100%"></table>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- main over -->
    <script>
        initPeCommonCodeCombobox();
        initEnterpriseCombobox();
        initEnterpriseTable();
        function initEnterpriseTable(){
            //污染源企业
            $('#dg_enterprise').datagrid({
                url: "${request.contextPath}/enterprise/peenterprisedata/peEnterpriseDataList",
                fitColumns : true,
                rownumbers : false,
                mumonitorDeviceDataTableiple:false,
                singleSelect: true
            });
        };

        // 根据企业名称查询企业
        $("#selectEnterpriseId").click(function() {
            $('#dg_enterprise').datagrid('load', {
                peName : $("#enterpirseId").combobox('getText'),
                unitTypeCode : $("#peCommonCode").combobox('getValue')
            });
        });
        //污染源类型下拉框
        function initPeCommonCodeCombobox(){
            $("#peCommonCode").combobox({
                url: "${request.contextPath}/enterprise/pecommoncode/getPeCommonCodeListByParentId?parentId=6800",
                valueField: "id",
                textField: "text",
                editable: false,
                panelHeight:'auto',
                panelMaxHeight:'240',
                method:'get',
                labelPosition:'left',
                multiple:false,
                value: "",
                onLoadSuccess: function(){
                },
                onChange: function(newValue, oldValue){
                    //initEnterpriseCombobox(newValue);
                    var unitTypeCode = newValue;
                    var url = "${request.contextPath}/enterprise/peenterprisedata/getCompnentPeEnterpriseDatasListByUnitTypeCode";
                    $.ajax({
                        type: "POST",
                        url: url,
                        dataType: "json",
                        data: {"unitTypeCode":newValue },
                        beforeSend: function(){
                        },
                        success: function(data){
                            $("#enterpriseId").combobox("loadData", data);
                        },
                        error:function(data){
                        }
                    });
                },
                onSelect: function(rec){
                }
            });
        }
        //企业下拉框
        function initEnterpriseCombobox(unitTypeCode){
            if(unitTypeCode==null || typeof(unitTypeCode)=="undefined"){
                unitTypeCode = "";
            }
            var url = "${request.contextPath}/enterprise/peenterprisedata/getCompnentPeEnterpriseDatasListByUnitTypeCode?unitTypeCode="+unitTypeCode;
            //污染源企业
            $("#enterpirseId").combobox({
                url: url,
                valueField: "id",
                textField: "text",
                editable: true,
                panelHeight:'auto',
                panelMaxHeight:'240',
                method:'get',
                labelPosition:'left',
                multiple:false,
                value: "",
                onLoadSuccess: function(){	//加载完成后选择第一项
                    var val = $(this).combobox("getData");
                },
                onChange: function(newValue, oldValue){
                }
            });
        }

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
        //企业列表以及监测数据列表面板的收起与展开 --start--
        $(".map-panel-header").on("click", function() {
            closeMapPanel($(this));
        });

        function closeMapPanel(this_) {
            var $target = this_.parent();
            if ($target.hasClass("collapsed")) {
                $target.removeClass("collapsed");
                //WaterPollutionBar.resize();
                //WatertypeBar.resize();
                //WaterIndexBar.resize();
            } else {
                $target.addClass("collapsed");
            }
        }
        //企业列表以及监测数据列表面板的收起与展开 --end--

        //企业信息列表绑定相关函数 --start--
        function locationEnterpriseOnMap(value, row, index) {
            var pointList = [];
            for(var i=0;i<row.peMonitorPointList.length;i++){
                var point = row.peMonitorPointList[i];
                var pointObj = {
                    outputId: point.outputId,
                    name: point.name,
                    csn: point.csn
                };
                pointList[i]=pointObj;
            }
            var obj = {
                peId: row.peId,
                csn: row.csn,
                uuid: row.peId,
                peName: row.peName,
                address: row.address==null || typeof(row.address)=="undefined" ? "" : row.address,
                portList: pointList,
                longitude: row.longValue,
                latitude: row.latValue
            };
            var value = "<div onclick=localtionAndOpenInfoWindow(this) row-data=" + JSON.stringify(obj) + " > <img style='width:24px; height:24px' src=${request.contextPath}/static/images/icon_img_01.png></div>";
            return value;
        }

        function localtionAndOpenInfoWindow(thisDiv) {
            var $thisDiv = $(thisDiv);
            var record = JSON.parse($thisDiv.attr("row-data"));
            var marker = markerMap.get(record.peId);

            if(record.longitude==null || record.latitude==null){
                $.messager.show({
                    title: '提示',
                    msg: "该企业暂无定位信息！"
                });
                return false;
            }
            createInfoWindow(record,marker) ;
        }

        function imgFormatterByDetail(value, row, index) {
            value = '<img style="width:24px; height:24px" src=${request.contextPath}/static/images/icon_img_02.png>';
            return value;
        }

        function createInfoWindow(record,marker) {
            if (!monitorHydroFlag) {
                monitorHydroFlag = true;
                $(".map-details-popup").hide();
                openInfoWindow(record, myMarker, false);
            }
        }
        //企业信息列表绑定相关函数 --end--

        //地图加载相关 --start--
        var map = null;
        initMapForEpa();
        initStation();
        function initMapForEpa() {
            var longitude = "117.65";
            var latitude = "24.52";
            /* var layers = [
                fjzx.map.source.getGlobalVecLayerGroup(),
                new ol.layer.Tile({
                    source : new ol.source.XYZ({
                        url : 'https://map.geoq.cn/arcgis/rest/services/ChinaOnlineStreetPurplishBlue/MapServer/tile/{z}/{y}/{x}'
                    })
                })
            ]; */
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
                url : '${request.contextPath}/enterprise/peenterprisedata/getPeEnterpriseDatasList',
                success : function(data) {
                    enterpriseArray = [];
                    for (var i = 0; i < data.length; i++) {
                        var record = data[i];
                        if (record.latitude != null
                                && record.longitude != null) {
                            enterpriseArray.push(record);
                        }
                    }
                    addMakerStation("online", enterpriseArray);
                },
                error:function(data){
                    console.log("=========initStation error=========");
                },
                dataType : 'json'
            });
        }
        function addMakerStation(type, stationArray) {
            for (var i = 0; i < stationArray.length; i++) {
                var record = stationArray[i];
                var point = new fjzx.map.Point(record.longitude, record.latitude);
                if (markerMap.get(record.uuid) == null) {
                    iconMap = new fjzx.map.Icon(getImagePathByType(type), {size:new fjzx.map.Size(30, 30),imgSize:new fjzx.map.Size(30, 30)});
                    myMarker = new fjzx.map.Marker(point, {
                        icon : iconMap,
                        map : map
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
        function getImagePathByType(type) {
            var imagePath = null;
            switch (type) {
                case "offline":
                    imagePath = "${request.contextPath}/static/images/marker_port_01.png";
                    break;
                case "online":
                    imagePath = "${request.contextPath}/static/images/marker_port_02.png";
                    break;
                case "over":
                    imagePath = "${request.contextPath}/static/images/marker_port_03.png";
                    break;
            }
            return imagePath;
        }

        var monitorHydroFlag = false;
        function addClickHandler(record, myMarker) {
            myMarker.addClick(function(e) {
                if (!monitorHydroFlag) {
                    monitorHydroFlag = true;
                    $(".map-details-popup").hide();
                    openInfoWindow(record, myMarker, true);
                }
                ;
            });
        }

        function openInfoWindow(recordHydro, marker, ismove) {
            var clickDiv2 = "";
            var clickDiv3 = "";
            var tempClikDiv = "";
            var clickDiv = "";
            var point = new fjzx.map.Point(recordHydro.longitude,
                    recordHydro.latitude);
            monitorHydroFlag = false;
            //点击标记物后展示公司排口点
            var dataList = recordHydro.portList;
            for (var i = 0; i < dataList.length; i++) {
                var record = dataList[i];
                clickDiv3 = "<tr id='"
                        + record.outputId
                        + "' rname ='"
                        + recordHydro.name
                        + "' row-data ='"
                        + JSON.stringify(record)
                        + "' onclick=showMonitorDeviceData(this)><td style='text-align:center;'><span class='fa-circle online'></span></td><td>"
                        + record.name
                        + "</td><td><a class='dataDetail'><span class='icon fa-search'></span> 查看详情</a></td></tr>";
                clickDiv2 = clickDiv2 + clickDiv3;
            }
            var enterpriseStr = "";
            if (clickDiv2 == "") {
                clickDiv = "<div class='marker-info-container'>"
                        + "<div class='base-info'>" + "<div class='name'>"
                        + recordHydro.peName + "</div>"
                        + "<div class='other'><span class='address'>"
                        + recordHydro.address + "</span></div>" + "</div>"
                        + "<div class='data-info' style='text-align:center; '>"
                        + "暂无数据！" + "</div>";
            } else {
                clickDiv = "<div class='marker-info-container'>"
                        + "<div class='base-info'>"
                        + "<div class='name'>"
                        + recordHydro.peName
                        + "</div>"
                        + "<div class='other'><span class='address'>"
                        + recordHydro.address
                        + "</span></div>"
                        + "</div>"
                        + "<div class='data-info'>"
                        + "<table id='detailDataTable' class='table-mini no-background no-border'><thead><tr><th style='width:20%;'>联网 </th><th style='width:50%;'>排口名称</th><th style='width:30%;'>操作</th></tr></thead>"
                        + "<tbody>" + clickDiv2 + "</tbody></table>" + "</div>";
            }

            var infoWindow = new fjzx.map.InfoWindow({
                infoWindow : clickDiv
            });
            openWindowInfo_Monitor = infoWindow;
            var title = recordHydro.name;
            if (ismove) {
                marker.openInfoWindow(infoWindow);//打开信息窗口
            } else {
                marker.openInfoWindowWithPoint(infoWindow, point, [ 0, 0 ]);//打开信息窗口
            }
            map.setCenter(point, true);
        };

        $(".close").click(function() {
            if ($(".map-details-popup").show()) {
                $(".map-details-popup").hide();
            }
        });
        //地图加载相关 --start--

        //获取监测数据列表标题
        function getMonitorDeviceDataTableColumn(outputId){
            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/factor/pefactor/getPeFactorListColumnTitleByOutputId',
                dataType : 'json',
                data : {
                    'outputId' : outputId
                },
                success : function(data) {
                    //清空列表
                    $("#monitorDeviceDataTable").datagrid("loadData", {total : 0, rows : []});

                    var columnList = data.peFactorColumnArray;
                    var peFactorColumnThreshold = data.peFactorColumnThreshold;
                    //遍历获取到的监测数据，判断相应监测值是否超标
                    for(var i=0;i<columnList.length;i++){
                        var column = columnList[i];
                        var threshold = peFactorColumnThreshold[column.field];
                        columnList[i] = validateMonitorDeviceData(column, threshold);
                    }
                    var fitColumns = false;
                    if(columnList.length<=16){
                        fitColumns = true;
                    }

                }
            });
        }
        //校验监测数据是否超标，超标数据背景色为红色高亮
        function validateMonitorDeviceData(column,threshold){
            if(threshold != undefined && threshold.isUsed==='1'){
                var upLimit = Number(threshold.upLimit)*1000;
                var lowLimit = Number(threshold.lowLimit)*1000;
                //标题加上报警阈值范围
                if(upLimit==0 && lowLimit==0){
                    column.title = column.title + "(mg/L)";
                }else{
                    column.title = column.title + "(mg/L)<br/>["+lowLimit+","+upLimit+"]"
                    //给超标数据所在单元格设置样式
                    column.styler = function(val,row,index){
                        var result = "";
                        var value = val==null ? 0 : Number(val);
                        if(upLimit<value || lowLimit > value){
                            result = 'background-color:#FF0000;';
                        }
                        return result;
                    }
                }
            }
            return column;
        }
        //数据详情
        var currentPage = 1;
        var pageSize = 10;
        var currentOutputId = "";
        var loadingFlag = false;

        var queryMeasureStartTime = "";
        var queryMeasureEndTime   = "";
        function showMonitorDeviceData(thisDiv) {

            $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
            var $thisDiv = $(thisDiv);
            var monitorRecord = JSON.parse($thisDiv.attr("row-data"));
            record = monitorRecord;
            //currentOutputId = record.outputId;
            currentOutputId = record.csn;
            //标题
            $("#monitorDataEnterpriseName").text("企业排口综合分析数据详情--"+record.name)
            $("#bottonDiv").removeClass("collapsed");

            //getMonitorDeviceDataTableColumn(currentOutputId,pageSize);
            //getPeConDayDataListByOutputId(currentOutputId,currentPage);
            //getPeConHourDataListByOutputId(currentOutputId,currentPage,pageSize);
            //清空列表
            $("#monitorDeviceDataTable").datagrid("loadData", {total : 0, rows : []});
            getPeConMinuteDataListByOutputId(currentOutputId,queryMeasureStartTime,queryMeasureEndTime, currentPage,pageSize);
        }

        //监测数据详细列表滚动条触底绑定函数
        function onMonitorDeviceDataListScroll(){
            $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
            var nScrollHight = 0; //滚动距离总长(注意不是滚动条的长度)
            var nScrollTop = 0;   //滚动到的当前位置
            var nDivHight = $("#monitorDeviceDataContainer .datagrid-body").height();
            $("#monitorDeviceDataContainer .datagrid-body").on("scroll",function(){
                nScrollHight = $(this)[0].scrollHeight;
                nScrollTop = $(this)[0].scrollTop;
                var paddingBottom = parseInt($(this).css('padding-bottom') ),paddingTop = parseInt( $(this).css('padding-top') );
                if(nScrollTop + paddingBottom + paddingTop + nDivHight >= nScrollHight && !loadingFlag){
                    //getPeConDayDataListByOutputId(currentOutputId,currentPage);
                    //getPeConHourDataListByOutputId(currentOutputId,currentPage,pageSize);
                    getPeConMinuteDataListByOutputId(currentOutputId,queryMeasureStartTime,queryMeasureEndTime, currentPage,pageSize);
                }
            });
        }

        //根据排口获取天监测数据
        function getPeConDayDataListByOutputId(outputId, page,pageSize) {
            $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
            loadingFlag = true;
            if (outputId == null){
                return;
            }

            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/dayData/pecondaydata/getPeConDayDataListByOutputId',
                data : {
                    'outputId' : outputId,
                    'page': page,
                    'pageSize': pageSize
                },
                success : function(result) {
                    var rowData = result.data;
                    for(var i=0;i<rowData.length;i++){
                        $('#monitorDeviceDataTable').datagrid('appendRow', rowData[i]);
                    }
                    currentPage++;
                    loadingFlag = false;
                    onMonitorDeviceDataListScroll();
                },
                error: function(){
                    loadingFlag = false;
                },
                dataType : 'json'
            });
        }
        //根据排口获取小时监测数据
        function getPeConHourDataListByOutputId(outputId, page,pageSize) {
            $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
            loadingFlag = true;
            if (outputId == null){
                return;
            }

            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/hourData/peconhourdata/getPeConHourDataListByOutputId',
                data : {
                    'outputId' : outputId,
                    'page': page,
                    'pageSize': pageSize
                },
                success : function(result) {
                    var rowData = result.data;
                    for(var i=0;i<rowData.length;i++){
                        $('#monitorDeviceDataTable').datagrid('appendRow', rowData[i]);
                    }
                    currentPage++;
                    loadingFlag = false;
                    onMonitorDeviceDataListScroll();
                },
                error: function(){
                    loadingFlag = false;
                },
                dataType : 'json'
            });
        }

        //根据排口获取小时监测数据
        function getPeConMinuteDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime, page, pageSize) {
            if (outputId == null){
                return;
            }

            $('#monitorDeviceDataTable').datagrid('loading','true');

            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/minuteData/peconminutedata/getPeConMinuteDataListAndTableMetaByOutputId',
                dataType : 'json',
                data : {
                    'outputId' : outputId,
                    'queryMeasureStartTime' : queryMeasureStartTime.toString(),
                    'queryMeasureEndTime' : queryMeasureEndTime.toString(),
                    'page': page,
                    'pageSize': pageSize
                },
                success : function(result) {
                    var columnList = result.data.cloumnList;
                    var cloumnValueList = result.data.cloumnValueList;

                    //var peFactorColumnThreshold = data.peFactorColumnThreshold;
                    //遍历获取到的监测数据，判断相应监测值是否超标
                    for(var i=0;i<columnList.length;i++){
                        var column = columnList[i];
                        //var threshold = peFactorColumnThreshold[column.field];
                        var threshold = null;
                        columnList[i] = validateMonitorDeviceData(column, threshold);
                    }
                    var fitColumns = false;
                    if(columnList.length<=16){
                        fitColumns = true;
                    }
                    //初始化监测数据列表
                    $('#monitorDeviceDataTable').datagrid({
                        fit : true,
                        nowrap : true,
                        fitColumns : fitColumns,
                        columns : [columnList],
                        view : bufferview,
                        rownumbers : false,
                        singleSelect : true,
                        autoRowWidth : true,
                        autoRowHeight : false,
                        pagination: false,
                        pageSize : pageSize,
                        toolbar: '#toolbar',
                        onLoadSuccess: function(data){
                            onMonitorDeviceDataListScroll();
                        }
                    });
                    for(var i=0;i<cloumnValueList.length;i++){
                        $('#monitorDeviceDataTable').datagrid('appendRow', cloumnValueList[i]);
                    }
                    if($('#monitorDeviceDataTable').datagrid('getData').total<=0){
                        $('#monitorDeviceDataTable').datagrid('appendRow', {measureTime:'<div class="datagrid-empty" style="text-align:center;">没有找到符合条件的记录</div>'});
                    }
                    currentPage++;
                    loadingFlag = false;
                    onMonitorDeviceDataListScroll();
                },
                error: function(){
                }
            });
        }


        // 自定义table 宽度 窗口大小改变时，调用
        $.fn.extend({
            resizeDataGrid: function ( widthMargin, minWidth) {
                var width = $("#bottonDiv").width() - widthMargin;
                width = width < minWidth ? minWidth : width;
                $(this).datagrid('resize', {
                    width: width
                });
            }
        });

        $(document).ready(function(){
            //如果有左侧导航也可以添加宽度边界
            var widthMargin = 0;
            // 第一次加载时和当窗口大小发生变化时，自动变化大小
            $('#datagrid-12').resizeDataGrid(widthMargin,  70);
            //窗口大小改变时，调用
            $(window).resize(function () {
                $('#datagrid-12').resizeDataGrid(widthMargin, 70);
            });

            //这里的200是设置的最小宽度和高度
        });

        $(function(){
           /*  $("#test").datagrid("getPager").pagination({
                showPageList:false,
                showRefresh:false,
                layout:['first','prev','links','next','last'],
                links:3
            });
            $("#test").datagrid('resize'); */
//            $("#datagrid-12").datagrid("getPager").pagination({
//                showPageList:false,
//                showRefresh:false,
//                layout:['first','prev','links','next','last'],
//                links:3
//            });
        })




    </script>
</body>
</html>