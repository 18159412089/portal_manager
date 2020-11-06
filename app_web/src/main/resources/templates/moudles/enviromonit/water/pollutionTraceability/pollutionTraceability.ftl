<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>污染溯源</title>

</head>
<!-- body -->
<body class="">
<#include "/common/loadingDiv.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/animate.min.css" >
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/wow.min.js"></script>

<!-- ol -->
<link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
<!-- Custom -->
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
<!-- ol end -->

<!-- 地图相关 -->
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<script src="${request.contextPath}/static/js/epaConsole.js"></script>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"></link>
<script>


</script>
<style type="text/css">
    /* 底图控制器 */
    #mapDiv .basemap-toggle {
        position: absolute;
        z-index: 9;
    }
    .layui-layer-iframe{
        z-index: 999!important;
    }

    /* 底图控制项 */
    #mapDiv .basemap-toggle > .basemap {
        position: absolute;
        background-color: #fff;
        border: 1px solid #f0f0f0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        -webkit-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        -moz-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        text-align: center;
        cursor: pointer;
        margin: 0;
        padding: 0;
        font-weight: bold;
        -moz-opacity: 0.9;
        opacity: 0.9;
        -moz-user-select: none;
        -ms-user-select: none;
        -webkit-user-select: none;
        user-select: none;
    }

    #mapDiv .basemap-toggle > .basemap:hover {
        background-color: #d0d0d0;
    }

    #mapDiv .basemap-toggle > .basemap > img {
        border: 0;
        outline: 0;
        display: block;
    }

    #mapDiv .basemap-toggle > .basemap > span {
        font-size: 10px;
        display: block;
    }

    /* 底图控制项（选中时） */
    #mapDiv .basemap-toggle > .basemap[selected],
    #mapDiv .basemap-toggle > .basemap[selected]:hover {
        background-color: #fff;
        display: block;
    }
</style>
<!-- 头部 -->
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<!-- 头部 over  -->
<!-- 主体 -->
<div class="home-pollute-container">
    <div class="home-panel-bg">
        <div class="bg-left"></div>
        <div class="bg-right"></div>
        <div class="bg-bottom-left"></div>
        <div class="bg-bottom-right"></div>
        <div class="bg-bottom"></div>
    </div>
	<!-- 左 -->
	<div class="home-layout fl" id="home-left">
		<!--首页面板-->
		<div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>九龙江</span>
				</span>
            </div>
            <div class="home-panel-body">
			<!--面板主内容-->
				<a class="map-info-container" onclick="toDetail('九龙江')">
					<div class="map-info-img">
                        <img src="/static/images/water/A350600_1001.png" alt="">
					</div>
                    <div class="map-info-content">
						<ul class="map-info-list">
							<li class="item">
								<div class="title">国控断面</div>
								<div id="gkdm1">4个</div>
							</li>
							<li class="item">
								<div class="title">污水处理厂</div>
								<div id="wsclc1">4座</div>
							</li>
							<li class="item">
								<div class="title">常规排口</div>
								<div id="cgpk1">9个</div>
							</li>
							<li class="item">
								<div class="title">总处理能力</div>
								<div>35万吨</div>
							</li>
						</ul>

					</div>
				</a>
			</div>
		</div>
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>鹿溪</span>
				</span>
            </div>
            <div class="home-panel-body">
                <a class="map-info-container" onclick="toDetail('鹿溪')">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/water/A350600_1002.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div id="gkdm2">无</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div id="wsclc2">2座</div>
                            </li>
                            <li class="item">
                                <div class="title">常规排口</div>
                                <div id="cgpk2">无</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>15万吨</div>
                            </li>
                        </ul>

                    </div>
                </a>
            </div>
        </div>
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>漳江</span>
				</span>
            </div>
            <div class="home-panel-body">
                <a class="map-info-container" onclick="toDetail('漳江')">
                    <div class="map-info-img">
                        <img src="/static/images/water/A350600_1003.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div id="gkdm3">1个</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div id="wsclc3">1座</div>
                            </li>
                            <li class="item">
                                <div class="title">常规排口</div>
                                <div id="cgpk3">无</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>25万吨</div>
                            </li>
                        </ul>

                    </div>
                </a>
            </div>
        </div>
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>诏安东溪</span>
				</span>
            </div>
            <div class="home-panel-body">
                <a class="map-info-container" onclick="toDetail('诏安东溪')">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/water/A350600_1004.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div id="gkdm4">无</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div id="wsclc4">无</div>
                            </li>
                            <li class="item">
                                <div class="title">常规排口</div>
                                <div id="cgpk4">无</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>5万吨</div>
                            </li>
                        </ul>

                    </div>
                </a>
            </div>
        </div>
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
                    <span>韩江(九峰溪)</span>
                </span>
            </div>
            <div class="home-panel-body">
                <a class="map-info-container" onclick="toDetail('韩江(九峰溪)')">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/water/A350600_1005.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div id="gkdm5">无</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div id="wsclc5">无</div>
                            </li>
                            <li class="item">
                                <div class="title">常规排口</div>
                                <div id="cgpk5">无</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>5万吨</div>
                            </li>
                        </ul>

                    </div>
                </a>
            </div>
        </div>
    </div>
	<!-- 左  over-->
	<!-- 右 -->
	<div class="home-layout fr" id="home-right">
        <!--首页面板-->
        <div class="home-panel" id="rankingTOP10">
            <div class="home-panel-header">
                <span class="title">
					<span>实际排放企业top10</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="topEnterpriseTb" class="easyui-datagrid" url=""
                           style="height:100%"
                           data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
                        <thead>
                        <tr>
                            <th align="center" class="ranking" field="rownum" formatter="orderNm" width="70">排名</th>
                            <th align="center" class="ranking" field="dwmc" width="150">企业名称</th>
                            <th align="center" class="ranking" field="fspfl" width="130">排放（吨）</th>
                            <th align="center" class="ranking" field="psqxlx" width="130">排放去向类型</th>
                        </tr>
                        </thead>
                    </table>
                    <!-- 数据列表 over-->
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-panel" id="rankingTOP5">
            <div class="home-panel-header">
                <span class="title">
					<span>污水处理厂实际与预计不符TOP5</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="topPlantTb" class="easyui-datagrid" url=""
                           style="height:100%"
                           data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
                        <thead>
                        <tr>
                            <th align="center" class="ranking" field="rownum" formatter="orderNm" width="70">排名</th>
                            <th align="center" class="ranking" field="name" width="150">处理厂</th>
                            <th align="center" class="ranking" field="allow" width="100">预计排放(万立方米)</th>
                            <th align="center" class="ranking" field="actual" width="100">实际排放(万立方米)</th>
                            <#--<th align="center" class="ranking" field="dis" width="130">超过</th>-->
                        </tr>
                        </thead>
                    </table>
                    <!-- 数据列表 over-->
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->

	</div>
	<!-- 右  over-->
	<!-- 地图 -->
	<div class="home-layout oh" id="homeMap">
		<!--首页面板-->
        <div class="home-panel">
            <!--面板主内容-->
            <div class="map-container">
                <div class="map-tool"></div>
                <div class="map-wrapper" id="mapDiv">
                    <div class="basemap-toggle" style="width: 60px; height: 60px; top: 16px; right: 16px;">
                        <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                             layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                            <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="/static/fjzx-map/img/basemap-1.png" alt="">
                        </div>
                        <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                             layer-group-name="FJ_IMG_MAP" title="影像图层">
                            <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="/static/fjzx-map/img/basemap-2.png" alt="">
                        </div>
                    </div>
                </div><!--地图图层-->

            </div>
            <!--面板主内容 over-->
        </div>
		<!--首页面板 over-->
	</div>
	<!-- 地图  over-->
	<div class="ca"></div>

</div>
<!-- 主体 over  -->


</body>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/nationalSurfaceWater.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/policy.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/ranking.js"></script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">  
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    /*打开dialog*/
    function dialogOpen(target){    	
    	var sWidth=$(target).dialog('panel').outerWidth();
    	var pWidth=$(target).dialog('panel').parent().outerWidth();
    	var sHeight=$(target).dialog('panel').outerHeight();
    	var pHeight=$(target).dialog('panel').parent().outerHeight();
    	
    	sWidth=sWidth<pWidth?sWidth:pWidth-40;
    	sHeight=sHeight<pHeight?sHeight:pHeight-40;
    	
    	var sLeft=(pWidth-sWidth)/2;
    	var sTop=(pHeight-sHeight)/2;
    	
        $(target).dialog('open').panel('resize',{
       		width: sWidth,
       		height: sHeight,
       		left:sLeft,
       		top:sTop
       	});
    }
    
    var pointsData = new Array(); //站点数组
    var selectedPointInfo = ""; //已选择站点信息
    var pointInfoWins = new Array(); //地图上显示的水质监测站点
    var pointLabels = new Array(); //地图上显示的水质监测站点
    var linesAndPolygons = new Array(); //线和面
    var polygons = null;
    var fivePolygons = null;
    var polygonsMap = new HashMap();
    var basinPoints = new Array(); // 流域站点数组
    var basinDatas = new Array(); // 流域数据数组
    
    $(function () {
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        
        /*地图初始化*/
        var longitude = "117.65";
        var latitude = "24.52";
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
            zoom: 10
        });
        map.render();
        map.removeSelectInteraction();
        getBasin();
        getReservoirPoints();
    	//打开弹窗
    	//dialogOpen('#dd');

    	var separation = 8;// 子组件展开时的间距。
        var size = 60;
        $('div.basemap-toggle').on({
            mouseenter: function (e) {
                expand(e);
            },
            mouseleave: function (e) {
                collapse(e);
            }
        });
        $('div.basemap-toggle').find('.basemap').click(function(){
            // 已经选中则返回。
            if (!!$(this).attr("selected")) {
                return;
            }
            var layerGroupName = $(this).attr("layer-group-name");
            $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index',0);

            // 标记选中状态。
            $(this).attr("selected", "selected");
            //$(this).css("z-index", 10000);
            $(this).animate({
                top: 0
            }, 200);
            collapse(0);
            // 显示当前底图。
            map.getLayers().forEach(function(layer,i){
                if(layer instanceof ol.layer.Group){
                    layer.getLayers().forEach(function(sublayer,j){
                        map.removeLayer(sublayer);
                    });
                }
            });
            var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
            console.log(layerGroup);
            console.log($(this));
            map.setLayerGroup(layerGroup);
        });

        function expand() {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            // 如果已经展开，则返回。
            if (!!$domNode.attr("expand")) {
                return;
            }
            // 标记展开状态。
            $domNode.attr("expand", "expand");
            // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
            $domNode.css("height", (size + separation) * baseMaps.length + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行展开并显示。
                console.log(!$(baseMaps[i]).attr("selected"));
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).css("display", "block");
                    $(baseMaps[i]).animate({
                        top: "+=" + (size + separation) * count
                    }, 300, function (count) {
                        $(this).css("display", "block");
                        $(this).css("top", (size + separation) * count + "px");
                    });
                }
            }
        }

        function collapse(time) {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            if (Object.prototype.toString.call(time) !== "[object Number]") {
                time = 200;
            }
            // 如果没有展开，则返回。
            if (!$domNode.attr("expand")) {
                return false;
            }
            // 移出展开状态标记。
            $domNode.removeAttr("expand");
            $domNode.css("height", size + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行收起并隐藏。
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).animate({
                        top: "-=0"
                    }, time, function () {
                        $(this).css("display", "none");
                        $(this).css("top", 0);
                    });
                }
            }
        }
        
        showRiverDetail("九龙江",1);
        showRiverDetail("鹿溪",2);
        showRiverDetail("漳江",3);
        showRiverDetail("诏安东溪",4);
        showRiverDetail("韩江(九峰溪)",5);
    });

    function getBasin() {
        $.ajax({
            type : "post",
            url : "/enviromonit/water/nationalSurfaceWater/getBasinMonitor",
            async : true,
            success : function(result) {
                var data = result.data;
                var geoJSONArr = [] ;
                for (var i = 0; i < data.length; i++) {
                    basinDatas[i] = data[i];
                    
                    var color  = "#2ba4e9";
                    var clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                        +"<div style='border-radius: 15px;height:20px;line-height: 25px;width:20px;text-align: center;font-weight:bold;"
                        +"background-color:"+color+"' onclick=''> </div>"
                        +"</div><p style='font-weight:bold;'>"+data[i].name+"</p></div>";
                    //创建pint
                    var point = new fjzx.map.Point(data[i].lng, data[i].lat);
                    //创建地图marker点 
                    var  myMarker = new fjzx.map.Marker(point, {
                        markerHtml : clickDiv,
                        map : map,
                        isShowIcon :false,
                        title:data[i].name,
                        id:data[i].mn
                    });
                    map.addOverlay(myMarker);
                    basinPoints[i] = myMarker;
                    
                }
            },
            error : function() {
            },
            dataType : 'json'
        });

    }
    
    function getReservoirPoints() {
        $.ajax({
            type : 'POST',
            url : '/enviromonit/water/nationalSurfaceWater/getReservoirPoints',
            async : true,
            data : {},
            success : function(result) {
                var data = result.data;
                for (var i = 0; i < data.length; i++) {
                    var tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
                        icon : reservoir_icon,
                        map : map,
                        title :data[i].name
                    });
                    map.addOverlay(tempMarker);
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
            },
            dataType : 'json'
        });
    }
    
    function toDetail(basinName) {
        window.open(encodeURI("${request.contextPath}/environment/pollutionTraceability/detail?basinName="+basinName), "_self")
    }

    /**
     * 排名
     * @param value
     * @returns {*|string|*}
     */
    function orderNm(value, row, index) {
        return "<span class='ranking' title='" + (index + 1) + "'>" + (index + 1) + "</span>";
    }
    function showRiverDetail(dataRiver,index) {
        $.ajax({
            url: '/environment/pollutionTraceability/findPlantAndOuterList',
            data: {'riverName':dataRiver},
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data.type == 'E') {
                    Ams.error(result.message);
                } else {
                    getBasinInfo(dataRiver,data,index);
                }
            }
        })
    }
    //获取流域中的数据显示国控断面有多少个
    function  getBasinInfo(basinName,data,index) {
        var wsclcLength=data.wsclc.length
        var cgpkLength=data.cgpk.length
        var gkdm="";
        var cgpk=cgpkLength==0?"无":cgpkLength;
        var wsclc=wsclcLength==0?"无":wsclcLength;
        switch (basinName) {
            case "九龙江":
                gkdm=4;
                break;
            case "鹿溪":
                gkdm="无";
                break;
            case "漳江":
                gkdm=1;
                break
            case "诏安东溪":
                gkdm="无";
                break;
            case "韩江(九峰溪)":
                gkdm="无";
                break;
        }
        $("#gkdm"+index).text(gkdm);
        $("#wsclc"+index).text(wsclc);
        $("#cgpk"+index).text(cgpk);
    }
</script>


</html>;