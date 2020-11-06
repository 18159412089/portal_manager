<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳浦环保一张图</title>
    <!-- 基础 css -->
    <#include "/zphb/common/baseCss.ftl"/>
    <!-- 开发 css -->
    <script type="text/javascript" src="${request.contextPath}/static/zphb/js/zpxAreaPolygons.js"></script>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"/>
    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/photoswipe.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/default-skin/default-skin.min.css" rel="stylesheet"/>

    <#--水系图层相关-->
    <link rel="stylesheet" href="${request.contextPath}/static/river/app.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/layer/theme/default/layer.css"/>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"/>
    <!-- 自定义 css（开发开发自己加的css一定要在自定义css之前）-->
    <#include "/zphb/common/customBaseCss.ftl"/>
    <!-- old css -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <!-- 主题 css -->
    <#include "/zphb/common/zpThemeCss.ftl"/>
    <!-- js 在底部 -->
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/zphb/common/header.ftl"/>
<div id="pf-md">

    <div class="map-container">
        <div id="mapDiv" class="map-wrapper" style="position: fixed; bottom: 0;">
            <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -170px;">
                <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                     layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                    <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-1.png" alt="">
                </div>
                <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                     layer-group-name="FJ_IMG_MAP" title="影像图层">
                    <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-2.png" alt="">
                </div>
            </div>
        </div>

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
                                <div class="form-group form-group-alone hide">
                                    <select id="peCommonCode" name="peCommonCode" class="easyui-combobox" label="污染源类型：" style="width: 339px;"></select>
                                </div>
                                <div class="form-group form-group-alone">
                                    <select id="enterpirseId" name="enterpirseId" class="easyui-combobox" label="企业名称：" style="width: 339px;"></select>
                                </div>
                                <div class="form-group form-group-right">
                                    <a href="#" id="selectEnterpriseId" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'">查询</a>
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

        <!-- 地图层  -->
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
                        <a  id="moreData"  class="time-span" target="_blank"  href ="${request.contextPath}/zphb/hourData/peconhourdata/index">更多数据</a>
                    </div>
                    <div class="theme-content scroll-theme-content"  >
                        <div class="easyui-table-light alone-table-style">
                            <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 217px;">
                                <table id="monitorDeviceDataTable" class="easyui-datagrid" style="width: 100% px; height: 100%"></table>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
</div>


</div>
</div>

<#include "/zphb/zpCameraMapPollutionDetail.ftl">
</body>
<!-- 基础的js-->
<#include "/zphb/common/baseJs.ftl"/>

<!-- ol -->
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
<!-- Custom -->
<!-- ol end -->

<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
<!-- 地图相关 -->
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<script src="${request.contextPath}/static/js/epaConsole.js"></script>





<!-- 页面 js -->
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var currentEnterprise = ""; //当前的企业名称
    //数据详情
    var currentPage = 1;
    var showMessageEmpty = true ;
    var pageSize = 10;
    var currentOutputId = "";
    var loadingFlag = false;
    var tempColumn = [];
    var queryMeasureStartTime = "";
    var queryMeasureEndTime   = "";
    var monitorHydroFlag = false;
    initEnterpriseCombobox();
    // 根据企业名称查询企业
    $("#selectEnterpriseId").click(function() {
        $('#dg_enterprise').datagrid('load', {
            peName : $("#enterpirseId").combobox('getText')
        });
    });

    //企业下拉框
    function initEnterpriseCombobox(enterpriseName){
        if(enterpriseName==null || typeof(enterpriseName)=="undefined"){
            enterpriseName = "";
        }
        var url = "${request.contextPath}/zphb/enterprise/peenterprisedata/getCompnentPeEnterpriseDatasListByEnterpriseName?enterpriseName="+enterpriseName;
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

            },
            onChange: function(newValue, oldValue){
            }
        });
    }
    function showMonitorDeviceData(thisDiv) {
        $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
        var $thisDiv = $(thisDiv);
        var monitorRecord = JSON.parse($thisDiv.attr("row-data"));
        record = monitorRecord;
        currentOutputId = record.outputId;
        currentEnterprise = record.peName;
        $("#moreData").attr("href","${request.contextPath}/zphb/hourData/peconhourdata/index?outputId="+currentOutputId+"&enterpriseName="+encodeURI(encodeURI(currentEnterprise)));
        //标题
        $("#monitorDataEnterpriseName").text("企业排口综合分析数据详情-"+record.peName+"--"+record.name)
        $("#bottonDiv").removeClass("collapsed");
        //清空列表
        $("#monitorDeviceDataTable").datagrid("loadData", {total : 0, rows : []});
        currentPage = 1;
        showMessageEmpty = true;
       getPeConMinuteDataListByOutputId(currentOutputId,queryMeasureStartTime,queryMeasureEndTime, 1,pageSize);
    }
    //根据排口获取小时监测数据
    function getPeConMinuteDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime, page, pageSize) {
        var cloumnValueList = [] ;
        var columnList = [] ;
        if (outputId == null){
            return;
        }
        queryMeasureEndTime = getDay(0)+" 23:59:59";
        queryMeasureStartTime =   getDay(-10)+" 00:00:00";
        $('#monitorDeviceDataTable').datagrid('loading','true');
        $.ajax({
            type : 'POST',
            url : Ams.ctxPath + '/zphb/minuteData/peconminutedata/getPollutionConMinuteDataListAndTableMetaByOutputId',
            dataType : 'json',
            data : {
                'outputId' : outputId,
                'queryMeasureStartTime' :queryMeasureStartTime,
                'queryMeasureEndTime' : queryMeasureEndTime,
                'page': page,
                'pageSize': pageSize
            },
            success : function(result) {
                 var fitColumns = false;
                 if(page == 1){
                     tempColumn =[];
                     //页面加载第一次保存列名
                     if( result.maxSize != null) {
                         tempColumn = result.data.clumnName;
                     }
                 }
                if(  result.data.rows.length > 0 ){
                     columnList = result.data.clumnName;
                     cloumnValueList = result.data.rows;
                     if(columnList.length<=16){
                         fitColumns = true;
                     }
                    if(page > 1 ){
                        columnList = tempColumn;
                    }
                    //遍历获取到的监测数据，判断相应监测值是否超标
                    var overStatus =  result.data.overStatus;
                    for(var i=0;i<columnList.length;i++){
                        var column = columnList[i];
                        columnList[i] = validateMonitorDeviceData(column,overStatus);
                    }
                 }else{
                    //关闭loding进度条；
                    $('#monitorDeviceDataTable').datagrid('loaded');
                    columnList = tempColumn;
                    for(var i=0;i<columnList.length;i++) {
                        var column = columnList[i];
                        columnList[i] = initColumnStyle(column);
                    }
                    //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
                    // index 行数
                   if(showMessageEmpty) {
                       showMessageEmpty = false;
                       var rows = $("#monitorDeviceDataTable").datagrid("getRows");
                       var lastIndex =  rows.length;
                       $('#monitorDeviceDataTable').datagrid({
                           columns : [columnList]})
                           .datagrid('appendRow', {rowNum: '<div style="text-align:center;color:red">没有找到符合条件的记录！</div>'})
                           .datagrid('mergeCells', {
                               index:  lastIndex,
                               field: 'rowNum',
                               colspan: columnList.length
                           });
                       return;
                   }
                }

                //初始化监测数据列表
                $('#monitorDeviceDataTable').datagrid({
                    fit : true,
                    nowrap : true,
                    fitColumns : fitColumns,
                    columns : [columnList],
                    rownumbers : false,
                    singleSelect : true,
                    autoRowWidth : true,
                    autoRowHeight : true,
                    pagination: false,
                    pageSize : pageSize,
                    toolbar: '#toolbar',
                    onLoadSuccess: function(data){

                    }
                });

                for(var i=0;i<cloumnValueList.length;i++){
                    $('#monitorDeviceDataTable').datagrid('appendRow', cloumnValueList[i]);
                }
                currentPage++;
                loadingFlag = false;
                onMonitorDeviceDataListScroll();

            },
            error: function(){
            }
        });
    }
    function clearDataGrid(){
        //获取当前页的记录数
        var item = $('#monitorDeviceDataTable').datagrid('getRows');
        for (var i = item.length - 1; i >= 0; i--) {
            var index = $('#monitorDeviceDataTable').datagrid('getRowIndex', item[i]);
            $('#monitorDeviceDataTable').datagrid('deleteRow', index);
        }
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

    //企业信息列表绑定相关函数 --start--
    function locationEnterpriseOnMap(value, row, index) {
        var pointList = [];
        for(var i=0;i<row.zpPeMonitorPointList.length;i++){
            var point = row.zpPeMonitorPointList[i];
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
                getPeConMinuteDataListByOutputId(currentOutputId,queryMeasureStartTime,queryMeasureEndTime, currentPage,pageSize);
            }
        });
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

        var longitude = typeof (recordHydro.longitude) == "undefined" ?recordHydro.longValue:recordHydro.longitude
        var latitude = typeof (recordHydro.latitude) == "undefined" ?recordHydro.latValue:recordHydro.latitude
        var point = new fjzx.map.Point(longitude,  latitude);
        monitorHydroFlag = false;
        //点击标记物后展示公司排口点

        $.ajax({
            type : 'POST',
            url : "/zphb/enterprise/peenterprisedata/getPePointDataInfo",
            data :{"peId":recordHydro.peId},
            success : function(data) {
                var dataList =data;
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

                var $clickDiv = $(clickDiv);
                if(recordHydro.peName.match(RegExp(/德昌皮业/))){
                    $clickDiv.find('div.name').append('<a href='+Ams.ctxPath+'"/static/images/zhangpu/process_flow_dechang.png" style="margin-left:10px;font-weight:normal;color: #1286d3;text-decoration: underline;" target="_blank">工艺流程图</a>');
                }
                if(recordHydro.peName.match(RegExp(/富洋/))){
                    $clickDiv.find('div.name').append('<a href='+Ams.ctxPath+'"/static/images/zhangpu/process_flow_fuyang.png" style="margin-left:10px;font-weight:normal;color: #1286d3;text-decoration: underline;" target="_blank">工艺流程图</a>');
                }
                var infoWindow = new fjzx.map.InfoWindow({
                    infoWindow : $clickDiv.prop("outerHTML")
                });
                openWindowInfo_Monitor = infoWindow;
                var title = recordHydro.name;
                if (ismove) {
                    marker.openInfoWindow(infoWindow);//打开信息窗口
                } else {
                    marker.openInfoWindowWithPoint(infoWindow, point, [ 0, 0 ]);//打开信息窗口
                }
                map.setCenter(point, true);
            },
            error:function(data){
                console.log("=========initStation error=========");
            },
            dataType : 'json'
        });


    };



    $(function () {
        var enterpriseArray = null;
        var onlyMonitorFlag = true;
        var idArray = new Array();
        var myMarkMap = new HashMap();
        var markerMap = new HashMap();
        var allSignArr = new Array();
        var map = null;
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        //筛选点击 默认隐藏
        $(".map-panel-header").on("click", function () {
            var $target = $(this).parent();
            if ($target.hasClass("collapsed")) {
                $target.removeClass("collapsed");
            } else {
                $target.addClass("collapsed");
            }
        });

        function initMapSurfacePollution() {
            var longitude = " 117.62";
            var latitude = "24.13";
            map = initMap({
                target: "mapDiv",
                center: [parseFloat(longitude), parseFloat(latitude)],
                //layers: fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
                layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup)

            });
            //加载漳浦县区域
            setZpxArea();
            map.render();
        }
        initEnterpriseTable();
        function initEnterpriseTable(){
            //污染源企业
            $('#dg_enterprise').datagrid({
                url: "${request.contextPath}/zphb/enterprise/peenterprisedata/peEnterpriseDataList",
                fitColumns : true,
                rownumbers : false,
                mumonitorDeviceDataTableiple:false,
                singleSelect: true,
                onDblClickRow: function(index, row){
                    var enterpriseData = row;
                    var name = enterpriseData.peName;
                    var peId = enterpriseData.peId;
                    var peCode = enterpriseData.peCode;
                    var latValue = enterpriseData.latValue;
                    var longValue = enterpriseData.longValue;
                    var address = enterpriseData.address;
                    animalMarker(peId);

                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/zphb/cameraMap/getPolluteList',
                        dataType: 'json',
                        data: {
                            lx:'水',
                            qx:'漳浦县',
                            mc:name
                        },
                        success: function (res) {
                            if(res.rows.length > 0){
                                var data = res.rows[0];
                                showDetailForAirWater(data);
                            }
                        }
                    });
                }
            });
        };
        initMapSurfacePollution();
        initStation();
        function initStation() {
            $.ajax({
                type : 'POST',
                url : "/zphb/enterprise/peenterprisedata/getPeEnterpriseDataInfo",
                success : function(data) {
                    enterpriseArray = [];
                    for (var i = 0; i < data.length; i++) {
                        var record = data[i];
                        if (record.longValue != null
                            && record.latValue != null) {
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
                var point = new fjzx.map.Point(record.longValue, record.latValue);
                if (markerMap.get(record.peId) == null) {
                    var pointType = "online";

                    if (record.isOver == "true"){
                        pointType = "over";

                    }
                    iconMap = new fjzx.map.Icon(getImagePathByType(pointType), {size:new fjzx.map.Size(30, 30),imgSize:new fjzx.map.Size(30, 30)});
                    myMarker = new fjzx.map.Marker(point, {
                        icon : iconMap,
                        map : map,
                        title : record.peName
                    });
                } else {
                    myMarker = markerMap.get(record.peId);
                }
                idArray[i] = record.uuid;
                myMarker.type = type;
                myMarker.recordJson = record;
                map.addOverlay(myMarker);
                myMarkMap.put(record.peId, myMarker);
                addClickHandler(record, myMarker);
                if (onlyMonitorFlag) {
                    markerMap.put(record.peId, myMarker);
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

        //点击marker 动画
        function animalMarker(markerId) {
            var myMarker = markerMap.get(markerId);
            var	cycleObject = myMarker.cycleAnimal();
            cycleObject.startAnimal();
            cycleObject.setCycleTime(5);
        }

        //初始样式
        if($(window).width()>1200){
            $(".map-caselist-container").addClass("show");
        }else {
            $(".map-caselist-container").removeClass("show");
        }
    });
    $(window).resize(function() {
        //初始样式
        if($(window).width()>1200){
            $(".map-caselist-container").addClass("show");
        }else {
            $(".map-caselist-container").removeClass("show");
        }


    });
    //校验监测数据是否超标，超标数据背景色为红色高亮
    function validateMonitorDeviceData(column,overStatus){
        //给超标数据所在单元格设置样式
        var result = "";
        if(column.field != "rowNum" && column.field != "dataTime"){

             if(overStatus != null ){
                 column.styler = function(val,row,index){
                     var selectIndex = index%10;
                      if(overStatus[selectIndex][column.field+"overStatus"] == "true"){
                         result = 'background-color:#FF0000;';
                     }else{
                         result = 'background-color:#ffffff;';
                     }
                     return result;
                 }
             }
         }
        return column;
    }
    //初始化列名样式
    function initColumnStyle(column){
        column.styler = function(val,row,index){
             result = 'background-color:#ffffff;';
            return result;
        }
        return column;
    }


    function getDay(day){
        var today = new Date();

        var targetday_milliseconds=today.getTime() + 1000*60*60*24*day;

        today.setTime(targetday_milliseconds);

        var tYear = today.getFullYear();
        var tMonth = today.getMonth();
        var tDate = today.getDate();
        tMonth = doHandleMonth(tMonth + 1);
        tDate = doHandleMonth(tDate);
        return tYear+"-"+tMonth+"-"+tDate;
    }
    function doHandleMonth(month){
        var m = month;
        if(month.toString().length == 1){
            m = "0" + month;
        }
        return m;
    }



    function showDetailForAirWater(info) {
        obj = info;
        document.getElementById('mc').innerHTML = '<span style="font-weight:bold">名称：</span>' + Ams.formatNUll(info.mc);
        document.getElementById('czwt').innerHTML = '<span style="font-weight:bold">存在问题：</span>' + Ams.formatNUll(info.czwt);
        document.getElementById('zgcs').innerHTML = '<span style="font-weight:bold">整改措施：</span>' + Ams.formatNUll(info.zgcs);
        document.getElementById('zlxm').innerHTML = '<span style="font-weight:bold">治理项目：</span>' + Ams.formatNUll(info.zlxm);
        document.getElementById('wryzl').innerHTML = '<span style="font-weight:bold">污染源种类：</span>' + Ams.formatNUll(info.wryzl);
        document.getElementById('wrylx').innerHTML = '<span style="font-weight:bold">污染源类型：</span>' + Ams.formatNUll(info.wrylx);
        document.getElementById('wcmb201912').innerHTML = Ams.formatNUll(info.wcmb201912);
        document.getElementById('wcmb202006').innerHTML = Ams.formatNUll(info.wcmb202006);
        document.getElementById('wcmb202012').innerHTML = Ams.formatNUll(info.wcmb202012);
        document.getElementById('sdzrZrdw').innerHTML = '<span style="font-weight:bold">属地责任单位：</span>' + Ams.formatNUll(info.bmzrZrdw);
        document.getElementById('bmzrZrdw').innerHTML = '<span style="font-weight:bold">部门责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);
        document.getElementById('bmzrPhzrdw').innerHTML = '<span style="font-weight:bold">配合责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);

        document.getElementById('qx').innerHTML = '<span style="font-weight:bold">区县：</span>' + Ams.formatNUll(info.qx);
        document.getElementById('xz').innerHTML = '<span style="font-weight:bold">乡镇：</span>' + Ams.formatNUll(info.xz);
        document.getElementById('dz').innerHTML = '<span style="font-weight:bold">地址：</span>' + Ams.formatNUll(info.dz);
        document.getElementById('jd').innerHTML = '<span style="font-weight:bold">经度：</span>' + Ams.formatNUll(info.jd);
        document.getElementById('wd').innerHTML = '<span style="font-weight:bold">纬度：</span>' + Ams.formatNUll(info.wd);
        document.getElementById('bz').innerHTML = '<span style="font-weight:bold">备注：</span>' + Ams.formatNUll(info.bz);

        var sdzrdwZrrlxfsArr = formatPhoneAndName(info.sdzrdwZrrlxfs);
        var phzrdwZrrlxfsArr = formatPhoneAndName(info.phzrdwZrrlxfs);
        var bmzrdwZrrlxfsArr = formatPhoneAndName(info.bmzrdwZrrlxfs);
        var ph_lxfs = '-';
        var s = '、';
        var newChar = ",";
        if (Ams.isNoEmpty(phzrdwZrrlxfsArr[1])) {
            ph_lxfs = phzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + phzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + phzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
        }

        var sd_lxfs = '-';
        if (Ams.isNoEmpty(sdzrdwZrrlxfsArr[1])) {
            sd_lxfs = sdzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + sdzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + sdzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
        }

        var bm_lxfs = '-';
        if (Ams.isNoEmpty(bmzrdwZrrlxfsArr[1])) {
            bm_lxfs = bmzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + bmzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + bmzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
        }

        document.getElementById('ph_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(phzrdwZrrlxfsArr[0]);
        document.getElementById('ph_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + ph_lxfs;
        document.getElementById('sd_fzr').innerHTML = '<span style="font-weight:bold">负责人：</span>' + Ams.formatNUll(sdzrdwZrrlxfsArr[0]);
        document.getElementById('sd_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + sd_lxfs;
        document.getElementById('bm_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(bmzrdwZrrlxfsArr[0]);
        document.getElementById('bm_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + bm_lxfs;
        $('#airWaterDialog').dialog('open').dialog('center').dialog('setTitle', '详情');
        findTimelineData();
    }

    function formatPhoneAndName(str) {
        var newName = "";
        var newPhone = "";
        var reg = /[\u4e00-\u9fa5]/g;
        var newPhoneAndName = new Array();
        if (Ams.isNoEmpty(str)) {
            var strs = str.split(',');
            for (var i = 0; i < strs.length; i++) {
                if (i < strs.length - 1) {
                    newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('')+ "、" : '';
                    if (Ams.isNoEmpty(strs[i].replace(/[^0-9]/ig, ""))) newPhone += strs[i].replace(/[^0-9]/ig, "") + "、";
                } else {
                    newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('') : '';
                    newPhone += strs[i].replace(/[^0-9]/ig, "");
                }
            }
        }
        newPhoneAndName.push(newName);
        newPhoneAndName.push(newPhone);
        return newPhoneAndName;
    }


    function findTimelineData() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/env/pollution2/findTimelineData',
            data: {
                'mc': obj.mc,
                'jd': obj.jd,
                'wd': obj.wd,
                'source':'pollutionMapInfo'

            },
            beforeSend: function () {
                loadIndex = layer.load(1, {
                    shade: [0.1, '#fff']
                });
            },
            complete: function () {
                layer.close(loadIndex);
            },
            success: function (result) {
                var list = result.allTimeLineData;
                var html = '';
                var pic;
                var suffix;
                var pic;
                var img;
                html += '<div class="time-axis-container">';
                html += '<ul>';
                for (var obj in list) {
                    // html += '<div class="time-axis-head">';
                    // html += '<span>上传时间：'+Ams.timeDateFormat(list[obj].createDate)+'</span>';
                    // html += '<a class="delete-tag" onclick="deleteActach(\''+list[obj].uuid+'\',\''+list[obj].picture+'\')"> 刪除</a>';
                    // // html += '<a class="title-link-tag" style="line-height: 22px;" onclick="$(\'#uploadDlg\').dialog(\'open\').dialog(\'center\').dialog(\'setTitle\', \'上传附件\')"> 上传附件</a>';
                    // html += '</div>';
                    // html += '<div class="time-axis-content">';
                    // html += '';
                    // html += '<div class="img-box">';
                    // html += '<img style="cursor: pointer" title="点击放大" class="bigImg" onclick="showBigImg(\''+list[obj].picture+'\')" src="/environment/waterAttachment/download/' + list[obj].picture +'/3" width="100%;">';
                    // html += '</div>';
                    // html += '</div>';
                    // html += '<p>描述：' + Ams.formatNUll(list[obj].describe) + '</p>';
                    // html += '<hr/>';


                    html += '<li class="item highlight">';
                    html += '<div class="time-axis-part">';
                    html += '<div class="time-axis-head">';
                    html += '<span>上传时间：' + Ams.timeDateFormat(list[obj].createDate) + '</span>';
                    html += '<a class="delete-tag" onclick="deleteActach(\'' + list[obj].uuid + '\',\'' + list[obj].picture + '\')"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>';
                    html += '</div>';
                    html += '<div class="time-axis-content">';
                    html += '<div class="img-box">';

                    pic = list[obj].picname;
                    suffix = pic == null ? '' : pic.substring(pic.lastIndexOf('.') + 1, pic.length).toLowerCase();
                    if (suffix == 'mp4' || suffix == 'mp3') {
                        img = '<img style="cursor: pointer" title="点击播放" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/VIDEO.jpg" width="100%;">'
                    } else if (suffix == 'pdf') {
                        img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/PDF.jpg" width="100%;">'
                    } else if (suffix == 'rar' || suffix == 'zip') {
                        img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/rar.png" width="100%;">'
                    } else if (suffix == 'doc' || suffix == 'docx') {
                        img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/WORD.jpg" width="100%;">'
                    } else if (suffix == 'xls' || suffix == 'xlsx') {
                        img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/excel.jpg" width="100%;">'
                    } else if (suffix == 'bmp' || suffix == 'png' || suffix == 'gif' || suffix == 'jpg') {
                        img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/environment/waterAttachment/download/' + list[obj].picture + '/3" width="100%;">';
                    } else {
                        img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/other.jpg" width="100%;">'
                    }
                    html += img;
                    html += '</div>';
                    html += '</div>';
                    html += '<p>描述：</p>';
                    html += '<p>' + Ams.formatNUll(list[obj].describe) + '</p>';
                    html += '</div>';
                    html += '</li>';
                }
                html += '</ul>';
                html += '</div>';

                $('#timeData').html(html);
                if (result.type == 'E') {
                    layer.msg(result.message);
                }
            },
            dataType: 'json'
        });
    }




</script>

</html>
