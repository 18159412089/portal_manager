<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染源大地图</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <#include "/secondToolbar.ftl">
    <#include "/passwordModify.ftl">
    <#include "/common/loadingDiv.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"></link>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
    <!-- Custom -->
    <!-- ol end -->
    <!-- 地图相关 -->
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
    <script src="${request.contextPath}/static/js/epaConsole.js"></script>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <style type="text/css">
        /* 底图控制器 */
        #mapDiv .basemap-toggle {
            position: absolute;
            z-index: 9;
        }

        .layui-layer-iframe {
            z-index: 999 !important;
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
</head>
<!-- body -->
<body class="pollution-body">

<div class="map-container">
    <div id="mapDiv" class="map-wrapper">
        <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -200px;">
            <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                 layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;"
                     src="${request.contextPath}/static/fjzx-map/img/basemap-1.png" alt="">
            </div>
            <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                 layer-group-name="FJ_IMG_MAP" title="影像图层">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;"
                     src="${request.contextPath}/static/fjzx-map/img/basemap-2.png" alt="">
            </div>
        </div>
    </div><!-- 地图层  -->
    <!--案件列表-->
    <div class="map-caselist-container show  map-contaminated-part">
        <div class="btn-collapse active" data-toggle="shown" data-target=".map-caselist-container">
            <span class="icon fa-angle-left"></span>
        </div>
        <div class="map-case-list-box">
            <div class="map-case-list ">
                <div class="map-contaminated-title">
<#--                    <h3><span class="icon iconcustom icon-leibie5"></span> 图层控制</h3>-->
                    <p id="dateTime">截止2019年9月9日排查</p>
                </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul">
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>水环境污染源</span>
                                <i id="countPollution"></i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content" id="pollutionData">
                                                <div class="change-line no-choice  choiced" id="wsclc"><span
                                                            class="icon iconcustom icon-guzhang4"></span> 污水处理厂(26)
                                                </div>
                                                <div class="change-line no-choice  choiced" id="cgpk"><span
                                                            class="icon iconcustom icon-xuncha1"></span>常规排口(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="sk"><span
                                                            class="icon iconcustom icon-shuibengzhan"></span>水库
                                                </div>
                                                <div class="change-line no-choice  choiced" id="gyfsqy"><span
                                                            class="icon iconcustom icon-xuncha1"></span>工业废水企业(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="wxszzdz"><span><img
                                                                src="/static/images/water/water_mini_monitor.png"></span>微型水质自动站(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="xly"><span
                                                            class="icon iconcustom icon-xuncha1"></span>小流域(26)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>大气环境污染源</span>
                                <i id="countPollutionARINum">56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced " id="fqpk"><span><img
                                                                src="/static/images/air/export.png"></span> 废气排口(26)
                                                </div>
                                                <div class="change-line no-choice  choiced" id="gd"><span><img
                                                                src="/static/images/air/site.png"></span>工地(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="gyfqqy"><span><img
                                                                src="/static/images/air/waste_gas.png"></span>工业废气企业(26)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent collapsed ">
                                <span>土壤环境污染源</span>
                                <i></i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced" id="tr_gygf">
				                                    <span><img src="/static/images/soil/industrialSolidWaste.png"></span>工业固废(0)
				                                </div>
				                                <div class="change-line no-choice choiced" id="tr_gywxfw">
				                                    <span><img src="/static/images/soil/industrialHazardousWaste.png"></span>工业危险废物(0)
				                                </div>
				                                <div class="change-line no-choice choiced" id="tr_hfc">
				                                    <span><img src="/static/images/soil/septicTank.png"></span>化粪池(0)
				                                </div>
				                                <div class="change-line no-choice choiced" id="tr_ybgygf">
				                                    <span><img src="/static/images/soil/generalIndustrialSolidWaste.png"></span>一般工业固废(0)
				                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>


                    <div class="soil-data">
                        <div class="soil-title"><span class="icon iconcustom icon-turang"></span>区域划分</div>
                        <div class="soil-table-box">
                            <ul>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass "
                                         onclick="areaClick(this,'芗城区','xcq')">
                                        芗城区
                                        <span id="xcq">0</span>个
                                    </div>

                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'龙文区','lwq')">
                                        龙文区
                                        <span id="lwq">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'龙海市','lhs')">
                                        龙海市
                                        <span id="lhs">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'漳浦县','zpx')">
                                        漳浦县
                                        <span id="zpx">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'南靖县','njx')">
                                        南靖县
                                        <span id="njx">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'云霄县','yxx')">
                                        云霄县
                                        <span id="yxx">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'诏安县','zax')">
                                        诏安县
                                        <span id="zax">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'东山县','dsx')">
                                        东山县
                                        <span id="dsx">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'平和县','phx')">
                                        平和县
                                        <span id="phx">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'华安县','hax')">
                                        华安县
                                        <span id="hax">0</span>个
                                    </div>
                                </li>
                                <li class="item">
                                    <div class="personnel-parent alone-personnel-parent tableClass"
                                         onclick="areaClick(this,'长泰县','ctx')">
                                        长泰县
                                        <span id="ctx">0</span>个
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
    </div>
</div>


</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript">
    $('#p').panel({
        width:500,
        height:150,
        title: 'My Panel',
        tools: [{
            iconCls:'icon-add',
            handler:function(){alert('new')}
        },{
            iconCls:'icon-save',
            handler:function(){alert('save')}
        }]
    });



    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    //全局变量各区县数值Json
    var earaJson = {};
    var cityArray = ["长泰县", '龙海市', '平和县', '芗城区', '龙文区', '华安县', '漳浦县', '南靖县', '云霄县', '东山县', '诏安县'];
    var pollutionMapArray = new Array();//污染源地图数组
    var countPollutionNum = 0;//污染源总数
    $(function () {


        $('#pollutonId').datagrid('reload');
        //右边列表的缩起/展开小按钮
        $("#dateTime").text("截止" + Ams.dateFormat(new Date(), "yyyy年MM月dd日") + "排查");
        $('body').on('click', '[data-toggle="shown"]', function () {
            var target = $(this).attr("data-target");
            var $target = $(target);
            if ($target.hasClass("show")) {
                $target.removeClass("show");
                $(this).removeClass("active");
            } else {
                $target.addClass("show");
                $(this).addClass("active");
            }
        });

        //小于1366人员列表默认关闭
        var body_w = $('body').width();
        if (body_w < 1200) {
            var $target = $('.map-caselist-container');
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        }

        //获取水、气各个标签的各区县数值Json
        $.ajax({
            type: 'POST',
            url: '/env/pollution/getEveryElementCountQX',
            async: false,
            success: function (result) {
                earaJson = result;
            }
        });
    });

    $(window).resize(function () {
        //监听窗口变化，小于1366人员列表默认关闭
        var body_w = $('body').width();
        var $target = $('.map-caselist-container');
        if (body_w < 1200) {
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        } else {
            $target.addClass("show");
            $target.find('.btn-collapse').addClass("active");
        }
    });

    /**
     * 右侧菜单tab伸缩
     */
    $(".personnel-list-container").on("click", ".personnel-parent", function () {
        var $p = $(this);
        $p.siblings(".personnel-children").slideToggle("slow", function () {
            if ($(this).is(":visible")) {
                $p.addClass("collapsed");
                ChangeHeight()

            } else {
                $p.next("div").hide();
                $p.removeClass("collapsed");
                ChangeHeight()
            }
            ;
        });

    });

    /*筛选与tabs的联动*/
    $('.no-choice').click(function () {
        var cl_n = $(this);
        var tid = $(this).attr("id");
        var isChoose = false;
        $(".soil-table-box").find(".personnel-parent").removeClass("collapsed")
        $(".soil-table-box").find(".personnel-children").hide()
        if (cl_n.hasClass('choiced')) {
            cl_n.removeClass('choiced');
            clearMapPoint(tid);
        } else {
            cl_n.addClass('choiced');
            isChoose = true;

            if (Ams.isNoEmpty(areaName)) {
                areaPointMapData();
            } else {
                pointAboutPollution(tid);
            }

        }
        areaNameList(tid,isChoose);
    });
    //地图加载
    $(function () {
            var longitude = "117.76264335320418";
            var latitude = "24.329671575212295";
            map = initMap({
                target: "mapDiv",
                center: [parseFloat(longitude), parseFloat(latitude)],
                layers: fjzx.map.source
                    .getLayerGroupByMapType("ZZ_VEC_MAP"),
                zoom: 9.5,
                minZoom: 9.5
            });
            map.render();

            //--------------------切换卫星图层开始------------------//
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
            $('div.basemap-toggle').find('.basemap').click(function () {
                // 已经选中则返回。
                if (!!$(this).attr("selected")) {
                    return;
                }
                var layerGroupName = $(this).attr("layer-group-name");
                $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index', 0);

                // 标记选中状态。
                $(this).attr("selected", "selected");
                //$(this).css("z-index", 10000);
                $(this).animate({
                    top: 0
                }, 200);
                collapse(0);
                // 显示当前底图。
                map.getLayers().forEach(function (layer, i) {
                    if (layer instanceof ol.layer.Group) {
                        layer.getLayers().forEach(function (sublayer, j) {
                            map.removeLayer(sublayer);
                        });
                    }
                });
                var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
                console.log(layerGroup);
                console.log($(this));
                map.setLayerGroup(layerGroup);
                setCountyArea();
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

            //--------------------切换卫星图层结束------------------//

            map.removeSelectInteraction();
            countPollution();
            countPolluctionAIR();

            $('.no-choice.choiced').each(function () {
                areaNameList($(this).attr("id"), true);
                if (Ams.isNoEmpty(areaName)) {
                    areaPointMapData();
                } else {
                    pointAboutPollution($(this).attr("id"));
                }
            })

        }
    )

    /**
     * 清除点位
     */
    function clearMapPoint(tid) {
        clearMap(tid)
    }

    //======================水污染数量统计star
    //获取污水处理厂或者常规排口(type1为污水处理厂other为常规排口)
    function getWSCLCOrCGPK(peType) {//peType(other为常规排口;type1为污水处理厂)
        $.ajax({
            type: 'POST',
            url: '/enviromonit/water/nationalSurfaceWater/getPeMonitorPoints',
            async: false,
            data: {peType: peType},
            success: function (result) {
                if ("type1" == peType) {
                    wsclcPoint = result.data;
                    $("#wsclc").empty();
                    $("#wsclc").append('<span class="icon iconcustom icon-guzhang4" ></span> 污水处理厂(' + result.data.length + ')');
                    countPollutionNum += result.data.length;
                } else {
                    $("#cgpk").empty();
                    $("#cgpk").append('<span  class="icon iconcustom icon-xuncha1"></span>常规排口(' + result.data.length + ')');
                    cgpkPoint = result.data;
                    countPollutionNum += result.data.length;
                }
            }
        })
    }

    //(工业废水企业)获取污普废水企业
    function getWPFS() {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/getPolluteWaterData",
            async: false,
            success: function (result) {
                $("#gyfsqy").empty();
                $("#gyfsqy").append('<span class="icon iconcustom icon-xuncha1"></span>工业废水企业(' + result.data.length + ')');
                gyfsqyPoint = result.data;
                countPollutionNum += result.data.length;
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    //获取水库
    function getSK() {
        $.ajax({
            type: 'POST',
            url: '/enviromonit/water/nationalSurfaceWater/getReservoirPoints',
            async: false,
            data: {},
            success: function (result) {
                $("#sk").empty();
                $("#sk").append('<span class="icon iconcustom icon-shuibengzhan"></span>水库(' + result.data.length + ')');
                countPollutionNum += result.data.length;
                skPoint = result.data;
            },
            error: function (jqXHR, textStatus, errorThrown) {
            },
            dataType: 'json'
        });
    }

    //获取微型水质自动站
    function getWXSZZDZ() {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/listNoPage",
            async: false,
            data: {polluteCode: $("span.ant-radio-button-checked input").val(), category: "3"},
            success: function (result) {
                $("#wxszzdz").empty();
                $("#wxszzdz").append('<span><img src="/static/images/water/water_mini_monitor.png"></span>微型水质自动站(' + result.data.length + ')');
                countPollutionNum += result.data.length;
                wxszzdzPoint = result.data;
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    //获取小流域
    function getXLY() {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/getBasinMonitor",
            async: false,
            success: function (result) {
                $("#xly").empty();

                $("#xly").append('<span class="icon iconcustom icon-xuncha1"></span>小流域(' + result.data.length + ')');
                countPollutionNum += result.data.length;
                xlyPoint = result.data;
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    //统计污染源数量
    function countPollution() {
        getWSCLCOrCGPK("type1");
        getWSCLCOrCGPK("other");
        getWPFS();
        getSK();
        getWXSZZDZ();
        getXLY();
        $("#countPollution").html(countPollutionNum);
    }

    //==================水污染数量统计end====================
    //==================大气污染数量统计=====================
    // 废气排口数量统计
    var countPollutionAIRNum = 0;

    function getFQPK() {
        /*添加有废弃排口的企业监测点*/
        //向地图上添加自定义标注
        $.ajax({
            type: "post",
            url: "/enterprise/peenterprisedata/getPeEnterpriseDataInfo",
            async: false,
            data: {"outType": 2},
            success: function (result) {
                $("#fqpk").empty();
                $("#fqpk").append('<span><img src="/static/images/air/export.png"></span> 废气排口(' + result.length + ')');
                countPollutionAIRNum += result.length;
                fqpkPoint = result;
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    //========获取工地污染数量
    function getGD() {
        $.ajax({
            type: "post",
            url: "/enviromonit/airConstructionSite/getConstructionInfo",
            async: false,
            success: function (result) {
                $("#gd").empty();
                $("#gd").append('<span ><img  src="/static/images/air/site.png"></span>工地(' + result.length + ')');
                countPollutionAIRNum += result.length;
                gdPoint = result;
            },
            error: function () {
            },
            dataType: 'json'
        });

    }

    /**
     * 获取工业废水数据
     */
    function getWpfqqy() {
        $.ajax({
            type: "post",
            url: "/enviromonit/airEnvironment/getPolluteAirData",
            async: false,
            success: function (result) {
                $("#gyfqqy").empty();
                $("#gyfqqy").append('<span><img src="/static/images/air/waste_gas.png"></span>工业废气企业(' + result.data.length + ')');
                countPollutionAIRNum += result.data.length;
                gyfqqyPoint = result.data;
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    /**
     * 加载气的全部点位数据
     */
    function countPolluctionAIR() {
        getFQPK();
        getGD();
        getWpfqqy();
        $("#countPollutionARINum").html(countPollutionAIRNum);
    }

    //地图分布点位描述===========================地图点位分布秒点
    var wsclcPoint = new Array();
    var wsclcMap = new Array();
    var cgpkPoint = new Array();
    var cgpkMap = new Array();
    var skPoint = new Array();
    var skMap = new Array();
    var gyfqqyPoint = new Array();
    var gyfqqyMap = new Array();
    var wxszzdzPoint = new Array();
    var wxszzdzMap = new Array();
    var xlyPoint = new Array();
    var xlyMap = new Array();
    var fqpkPoint = new Array();
    var fqpkMap = new Array();
    var gdPoint = new Array();
    var gdMap = new Array();
    var gyfsqyPoint = new Array();
    var gyfsqyMap = new Array();


    /**
     * 描述点位
     * @param tid 点位标签id
     */
    function pointAboutPollution(tid) {
        //关于数据的描点情况书写点位信息
        var data = getTargetData(tid);
        var targetIcon = getIcon(tid);
        var lng;
        var lat;
        var name;
        for (i = 0; i < data.length; i++) {
            lng = Ams.isNoEmpty(data[i].lng) ? data[i].lng : data[i].longitude;
            lat = Ams.isNoEmpty(data[i].lat) ? data[i].lat : data[i].latitude;
            name = Ams.isNoEmpty(data[i].name) ? data[i].name : Ams.isNoEmpty(data[i].qymc) ? data[i].qymc : Ams.isNoEmpty(data[i].mnname) ? data[i].mnname : data[i].peName;
            if (!Ams.isNoEmpty(lng)) {
                lat = data[i].latValue;
                lng = data[i].longValue
            }

            var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
                icon: targetIcon,
                map: map,
                title: name
            });
            pointMapPush(tid, tempMarker);
            map.addOverlay(tempMarker);
        }
    }

    /**
     * 获取目标点位数据
     * @param tid 点位标签id
     * @returns {any[]}
     */
    function getTargetData(tid) {
        var data;
        switch (tid) {
            case "wsclc":
                data = wsclcPoint;
                break;
            case "cgpk":
                data = cgpkPoint;
                break;
            case"sk":
                data = skPoint;
                break;
            case "gyfsqy":
                data = gyfsqyPoint;
                break;
            case"wxszzdz":
                data = wxszzdzPoint;
                break;
            case"xly":
                data = xlyPoint;
                break;
            case"fqpk":
                data = fqpkPoint;
                break;
            case"gd":
                data = gdPoint;
                break;
            case"gyfqqy":
                data = gyfqqyPoint;
                break;

        }
        return data;
    }

    /**
     * 获取右侧污染源标签
     * @param tid 点位标签id
     * @returns {fjzx.map.Icon}
     */
    function getIcon(tid) {
        var icon
        switch (tid) {
            case "wsclc":
                icon = "/static/images/water_sewagePlant.png";
                break;
            case "cgpk":
                icon = "/static/images/water_outfall.png";
                break;
            case"sk":
                icon = "/static/images/reservoir.png";
                break;
            case "gyfsqy":
                icon = "/static/images/water/wpfsqy.png";
                break;
            case"wxszzdz":
                icon = "/static/images/water/water_mini_monitor.png";
                break;
            case"xly":
                icon = "/static/images/min-basin.png";
                break;
            case"fqpk":
                icon = "/static/images/air/export.png";
                break;
            case"gd":
                icon = "/static/images/air/site.png";
                break;
            case"gyfqqy":
                icon = "/static/images/air/waste_gas.png";
                break;
        }
        var targetIcon = new fjzx.map.Icon(
            icon,
            {
                size: new fjzx.map.Size(30, 30),
                imgSize: new fjzx.map.Size(30, 30),
                anchor: new fjzx.map.Point(0, 30)
            }
        );
        return targetIcon;
    }

    /**
     * 添加点位标识数组
     * @param tid 点位标签id
     * @param tempMark
     */
    function pointMapPush(tid, tempMark) {
        var data;
        switch (tid) {
            case "wsclc":
                data = wsclcMap.push(tempMark);
                break;
            case "cgpk":
                data = cgpkMap.push(tempMark);
                break;
            case"sk":
                data = skMap.push(tempMark);
                break;
            case "gyfsqy":
                data = gyfsqyMap.push(tempMark);
                break;
            case"wxszzdz":
                data = wxszzdzMap.push(tempMark);
                break;
            case"xly":
                data = xlyMap.push(tempMark);
                break;
            case"fqpk":
                data = fqpkMap.push(tempMark);
                break;
            case"gd":
                data = gdMap.push(tempMark);
                break;
            case"gyfqqy":
                data = gyfqqyMap.push(tempMark);
                break;
        }
    }

    /**
     * 清空点位
     * @param tid 点位标签id
     */
    function clearMap(tid) {
        var data;
        switch (tid) {
            case "wsclc":
                data = wsclcMap;
                break;
            case "cgpk":
                data = cgpkMap;
                break;
            case"sk":
                data = skMap;
                break;
            case "gyfqqy":
                data = gyfqqyMap;
                break;
            case"wxszzdz":
                data = wxszzdzMap;
                break;
            case"xly":
                data = xlyMap;
                break;
            case"fqpk":
                data = fqpkMap;
                break;
            case"gd":
                data = gdMap;
                break;
            case"gyfsqy":
                data = gyfsqyMap;
                break;

        }
        for (var i = 0; i < data.length; i++) {
            map.removeOverlay(data[i]);
        }
    }


    // 动态修改元素高度
    function ChangeHeight(){
        var alontVal =190;
        var listHeight =$(window).height() -$(".contaminated-personnel-ul").height();
        $(".soil-table-box").css("height", (listHeight-alontVal) + "px");
    }


    //页面加载完成后执行
    $(document).ready(function () {
        ChangeHeight();
        $(window).resize(function () {
            ChangeHeight();
        });

    })

    //----------------加载区县图层------------//
    setCountyArea();
    var names = [];

    /**
     * 地区分区块描线
     */
    function setCountyArea() {
        var countyAreaPolygons = null;
        var poyjSONArr = [];
        $.ajax({
            type: 'POST',
            async: true,
            dataType: 'json',
            url: 'https://api.tianditu.gov.cn/administrative?postStr={%22searchWord%22:%22%E6%BC%B3%E5%B7%9E%E5%B8%82%22,%22searchType%22:%221%22,%22needSubInfo%22:%22true%22,%22needAll%22:%22true%22,%22needPolygon%22:%22true%22,%22needPre%22:%22true%22}&tk=7ca2bb2feccc647effa30f35238a1fe3',
            success: function (result) {
                if (countyAreaPolygons == null) {
                    countyAreaPolygons = new fjzx.map.DrawGeoJSON({
                        map: map,
                        zIndex: 10000,
                        customType: 'poly',
                        selectType: 'click'
                    });
                    clickPloyAction(countyAreaPolygons);
                }
                if (result.returncode == "100") { //100 正常
                    var child = result.data[0].child;
                    for (var i = 0; i < child.length; i++) {
                        var points = child[i].points;
                        //for (var j = 0; j < points.length; j++) {
                        var arr = points[0].region.split(',');
                        var coordinates = [];
                        var pencilColor = "";

                        for (var n = 0; n < arr.length; n++) {
                            var arr2 = arr[n].split(' ');
                            coordinates.push([parseFloat(arr2[0]), parseFloat(arr2[1])]);
                        }

                        names.push(child[i].name);
                        if (child[i].name == "芗城区" || child[i].name == "漳浦县" || child[i].name == "诏安县") {
                            var pencilColor = "#228B22";
                        } else if (child[i].name == "龙文区" || child[i].name == "南靖县" || child[i].name == "云霄县") {
                            var pencilColor = "#ffe600";
                        } else if (child[i].name == "华安县" || child[i].name == "龙海市" || child[i].name == "东山县") {
                            var pencilColor = "#c99979";
                        } else {//child[i].name == "平和县" || child[i].name == "长泰县"
                            var pencilColor = "#f58f98";
                        }
                        var feature = {
                            "layout": "XY",
                            "coordinates": [coordinates],
                            "type": "Polygon",
                            "featureId": "p" + i,
                            "pencilColor": pencilColor,
                            "pencilSize": "3",
                            "opacity": "1"
                        };
                        poyjSONArr.push({
                            "typeString": "Polygon",
                            "feature": JSON.stringify(feature),
                            "name": "",
                            "id": i
                        });
                        //}
                    }
                    countyAreaPolygons.load(poyjSONArr);
                }
            }
        });
    }


    /**
     * 点击地图区域响应事件
     * @param drawGeojson
     */
    function clickPloyAction(drawGeojson) {
        drawGeojson.setSelectAction(function (e, selectInteraction) {
            var features = selectInteraction.getFeatures();
            if (features.array_.length == 0) {
                //判断是否为区县内的点击
                getAllPollutionSource();
                areaName = "";
                colorForTab(areaName)
            }
            features.forEach(function (feature, index, array) {
                var geometry = feature.getGeometry();
                var coordinates = geometry.getCoordinates();
                console.log(names[feature.id_]);
                areaName = names[feature.id_];
                areaPointMapData()
                colorForTab(names[feature.id_])

            });
        })

    }

    var areaName;

    /**
     * 点位信息描述
     * @param lng
     * @param lat
     * @param name
     * @param targetIcon
     * @param tid
     */
    function areaPoint(lng, lat, name, targetIcon, tid) {
        //点位信息描述
        var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
            icon: targetIcon,
            map: map,
            title: name
        });
        pointMapPush(tid, tempMarker);
        map.addOverlay(tempMarker);
    }

    /**
     * 区域点位描述
     */
    function areaPointMapData() {
        $('.no-choice').each(function () {//获取选中的污染源点击事件
            if ($(this).hasClass("choiced")) {
                var tid = $(this).attr("id");
                clearMap(tid);//先清除点位;然后再描点位
                var dataPoint = getTargetData(tid);//获取点位信息
                var length = dataPoint.length;
                var targetIcon = getIcon(tid);
                var lng;
                var lat;
                var name;
                for (var i = 0; i < length; i++) {
                    lng = Ams.isNoEmpty(dataPoint[i].lng) ? dataPoint[i].lng : dataPoint[i].longitude;
                    lat = Ams.isNoEmpty(dataPoint[i].lat) ? dataPoint[i].lat : dataPoint[i].latitude;
                    name = Ams.isNoEmpty(dataPoint[i].name) ? dataPoint[i].name : Ams.isNoEmpty(dataPoint[i].qymc) ? dataPoint[i].qymc : Ams.isNoEmpty(dataPoint[i].mnname) ? dataPoint[i].mnname : dataPoint[i].peName;
                    if (!Ams.isNoEmpty(lng)) {
                        lat = dataPoint[i].latValue;
                        lng = dataPoint[i].longValue
                    }
                    if (checkPointInArea(lng, lat, areaName)) {
                        areaPoint(lng, lat, name, targetIcon, tid)
                    }
                }
            }
        })
    }

    /**
     * 获取所有污染源id
     */
    function getAllPollutionSource() {
        $('.no-choice').each(function () {//获取选中的污染源点击事件
            if ($(this).hasClass("choiced")) {
                pointAboutPollution($(this).attr("id"));
            }
        })

    }

    /**
     * 点位描述
     * @param lng
     * @param lat
     * @param name
     * @param targetIcon
     * @param tid
     */
    function areaPoint(lng, lat, name, targetIcon, tid) {
        //点位信息描述
        var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
            icon: targetIcon,
            map: map,
            title: name
        });
        pointMapPush(tid, tempMarker);
        map.addOverlay(tempMarker);
    }

    //区域划分的第二级下拉数据显示
    function areaClick(idthis,areaName, idVal) {
        if($(idthis).hasClass("tableClass collapsed")){
            return;
        }
        var html = '<div class="personnel-children" ><ul>';
        $('.no-choice').each(function () {//获取选中的污染源点击事件
            if ($(this).hasClass("choiced")) {
                var tid = $(this).attr("id");
                var child = getLabel(tid, areaName, idVal);
                html += child;
            }
        });
        html += '</ul></div>';
        $('#' + idVal).parent('div').nextAll("div").empty("");
        $('#' + idVal).parent('div').after(html);
        $('#ll').datagrid('reload');
    }

    //区域划分的第三级下拉数据拼接
    function getLabel(tid, areaName,areaId) {
        var result2 = '';
        switch (tid) {
            case "wsclc":
                $.ajax({
                        url: "/env/pollution/getPlantOrDrain",
                        type: "POST",
                        data: {
                            "area": areaName,
                            "peType": "peType1"
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getPlantOrDrain?area=' + areaName + '&peType=peType1\')">污水处理厂 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';

                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case "cgpk":
                $.ajax({
                        url: "/env/pollution/getPlantOrDrain",
                        type: "POST",
                        data: {
                            "area": areaName,
                            "peType": "other"
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getPlantOrDrain?area=' + areaName + '&peType=other\')">常规排口 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case "sk":
                $.ajax({
                        url: "/env/pollution/getReservoirDetailByArea",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getReservoirDetailByArea?area=' + areaName + '\')">水库 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case "gyfqqy":
                $.ajax({
                        url: "/env/pollution/getIndustrialAirwaterEnterprise",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getIndustrialAirwaterEnterprise?area=' + areaName + '\')">废气 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case"wxszzdz":
                $.ajax({
                        url: "/env/pollution/getminiWaterQualityAutoStateDetailByArea",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getminiWaterQualityAutoStateDetailByArea?area=' + areaName + '\')">微型 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case"xly":
                $.ajax({
                        url: "/env/pollution/getBasinNameByArea",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getBasinNameByArea?area=' + areaName + '\')">小流域 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case"fqpk":
                $.ajax({
                        url: "/env/pollution/getEnteriseByArea",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 += '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getEnteriseByArea?area=' + areaName + '\')">废气排口 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case"gd":
                $.ajax({
                        url: "/env/pollution/getConstructionByArea",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 = '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getConstructionByArea?area=' + areaName + '\')">工地 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
            case"gyfsqy":
                $.ajax({
                        url: "/env/pollution/getIndustrialWastewaterEnterprise",
                        type: "POST",
                        data: {
                            "area": areaName
                        },
                        success: function (data) {
                            result2 = '<li class="item"><div class="personnel-parent alone-personnel-parent" ' +
                                'onclick="dataRelaod(\'' + tid + areaId + '\',\'/env/pollution/getIndustrialWastewaterEnterprise?area=' + areaName + '\')">工业废水企业 <span>' + data.total + '个</span></div>' +
                                '<div class="personnel-children"><div class="personnel-info not-border"><div class="filter-container not-border not-padding">\n' +
                                '<div class="filter-box"><div class="filter-content not-margin"><div class="slid-table-box"><table id="' + tid + areaId + '" class="easyui-datagrid"\n' +
                                'style="width:302px;height:250px;"></table></div></div></div></div></div></div></li>';
                        },
                        dataType: "json",
                        async: false
                    }
                );
                break;
        }
        console.info(result2)
        return result2;
    }

    //datagrid加载触发事件
    function dataRelaod(dgid, url){
        $('#'+dgid).datagrid({
            url: url,
            columns: [[
                {field: 'name', title: '名称', width: '302'}
            ]],
            rownumbers: true,
            singleSelect: true,
            striped: false,
            autoRowHeight: false,
            pagination: true,
            pageSize: 10,
            nowrap: false
        });
    }

    /**
     * 点位标签与区域划分数值相加减联动
     * @param tid 点位信息描述
     * @param isChoose 是否被选中
     */
    function areaNameList(tid, isChoose) {
        var temp = {};
        switch (tid) {
            case "gyfsqy":
                temp = earaJson.gyfsqy;
                break;
            case "wxszzdz":
                temp = earaJson.wxszzdz;
                break;
            case "gyfqqy":
                temp = earaJson.gyfqqy;
                break;
            case "kqzjzd":
                temp = earaJson.kqzjzd;
                break;
            case "gd":
                temp = earaJson.gd;
                break;
            case "sk":
                temp = earaJson.sk;
                break;
            case "wsclc":
                temp = earaJson.wsclc;
                break;
            case "cgpk":
                temp = earaJson.cgpk;
                break;
            case "xly":
                temp = earaJson.xly;
                break;
            case "fqpk":
                temp = earaJson.fqpk;
                break;
            default:
                break;
        }
        var xcq = Number($("#xcq").text());
        var lwq = Number($("#lwq").text());
        var lhs = Number($("#lhs").text());
        var zpx = Number($("#zpx").text());
        var njx = Number($("#njx").text());
        var yxx = Number($("#yxx").text());
        var zax = Number($("#zax").text());
        var dsx = Number($("#dsx").text());
        var phx = Number($("#phx").text());
        var ctx = Number($("#ctx").text());
        var hax = Number($("#hax").text());
        if (isChoose) {
            for (var i = 0; i < temp.length; i++) {
                for (var j = 0; j < cityArray.length; j++) {
                    if (temp[i][cityArray[j]] != null) {
                        switch (cityArray[j]) {
                            case '长泰县':
                                ctx += temp[i][cityArray[j]];
                                break;
                            case '龙海市':
                                lhs += temp[i][cityArray[j]];
                                break;
                            case '平和县':
                                phx += temp[i][cityArray[j]];
                                break;
                            case '华安县':
                                hax += temp[i][cityArray[j]];
                                break;
                            case '漳浦县':
                                zpx += temp[i][cityArray[j]];
                                break;
                            case '南靖县':
                                njx += temp[i][cityArray[j]];
                                break;
                            case '云霄县':
                                yxx += temp[i][cityArray[j]];
                                break;
                            case '诏安县':
                                zax += temp[i][cityArray[j]];
                                break;
                            case '芗城区':
                                xcq += temp[i][cityArray[j]];
                                break;
                            case '龙文区':
                                lwq += temp[i][cityArray[j]];
                                break;
                            case '东山县':
                                dsx += temp[i][cityArray[j]];
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        } else {
            for (var i = 0; i < temp.length; i++) {
                for (var j = 0; j < cityArray.length; j++) {
                    if (temp[i][cityArray[j]] != null) {
                        switch (cityArray[j]) {
                            case '长泰县':
                                ctx -= temp[i][cityArray[j]];
                                break;
                            case '龙海市':
                                lhs -= temp[i][cityArray[j]];
                                break;
                            case '平和县':
                                phx -= temp[i][cityArray[j]];
                                break;
                            case '华安县':
                                hax -= temp[i][cityArray[j]];
                                break;
                            case '漳浦县':
                                zpx -= temp[i][cityArray[j]];
                                break;
                            case '南靖县':
                                njx -= temp[i][cityArray[j]];
                                break;
                            case '云霄县':
                                yxx -= temp[i][cityArray[j]];
                                break;
                            case '诏安县':
                                zax -= temp[i][cityArray[j]];
                                break;
                            case '芗城区':
                                xcq -= temp[i][cityArray[j]];
                                break;
                            case '龙文区':
                                lwq -= temp[i][cityArray[j]];
                                break;
                            case '东山县':
                                dsx -= temp[i][cityArray[j]];
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        }

        $("#xcq").html(xcq);
        $("#lwq").html(lwq);
        $("#lhs").html(lhs);
        $("#zpx").html(zpx);
        $("#njx").html(njx);
        $("#yxx").html(yxx);
        $("#zax").html(zax);
        $("#dsx").html(dsx);
        $("#phx").html(phx);
        $("#ctx").html(ctx);
        $("#hax").html(hax);
    }

    //点击地图区域,页面右侧相应高亮显示
    function colorForTab(name) {

        $(".tableClass").each(function () {
            $(this).removeClass("select-part");

            if (Ams.isNoEmpty(name)&&$(this).text().trim().indexOf(name)!=-1) {
                $(this).addClass("select-part");
            }
        })
        $(".soil-table-box").find(".personnel-parent").removeClass("collapsed")
        $(".soil-table-box").find(".personnel-children").hide()
    }

</script>

</html>
