<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>断面详情</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
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

<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
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
<#--<  头部>-->
<#--<  头部>-->
<input value="${name!}" type="hidden" id="pointName">
<div id="pf-hd" class="pf-head">
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
                <li class="pf-modify-pwd" id="editpass">
                    <a href="javascript:void(0)">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload">
                    <a href="javascript:void(0)">
                        <i class="iconfont">&#xe670;</i>
                        <span class="pf-opt-name">下载操作手册</span>
                    </a>
                </li>
                <li class="pf-logout" id="loginOut">
                    <a href="javascript:void(0)">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <#--  当导航只有一级开始-->
    <div class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
                <li class="select-link">
                    <a href="javascript:void(0)" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" target="_self">
                        <i class="icon iconcustom icon-gongzuoguanli1"></i>
                        <span class="title">水环境服务</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)">
                        <i class="icon iconcustom icon-fenzhi"></i>
                        <span class="title"> 污染溯源</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" target="_blank">
                        <i class="icon iconcustom icon-shuju2""></i>
                        <span class="title"> 数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)">
                        <i class="icon iconcustom icon-jianguan1"></i>
                        <span class="title"> 总体情况</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" target="_blank">
                        <i class="icon iconcustom icon-jibenxinxi1"></i>
                        <span class="title">一河一策</span>
                    </a>
                </li>


            </ul>
        </div>
        <div class="nav-menu-tag">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>

</div>

<div class="region-content">
    <div class="map-left border-style">
        <#--<div class="map-title">
            <h3><a href="/environment/pollutionTraceability/detail" style="text-decoration:none">
                    <i class="icon iconcustom icon-fanhui5"></i> 返回 </a></h3>
             <img style="width: 100%;max-width: 900px;" src="${request.contextPath}/static/images/pollute/map_img.png">

        </div>-->
        <div class="map-title">
            <h3><a href="/environment/pollutionTraceability?pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369"
                   style="text-decoration:none">
                    <i class="icon iconcustom icon-fanhui5"></i> 返回</a></h3>
        </div>
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
        <#-- <div class="tagging-item">
            <h5>华安县三达水务有限公司</h5>
             <div class="row">
                 <span>吨数：5万吨</span>
             </div>
             <div class="row">
                <span> 农业:</span>
               <div class="speed-box min-speed">
                 <div class="speed-row"><span class="tag violet" style="width: 20%"></span></div>
               </div>
             </div>

             <div class="row">
                 <span> 农业:</span>
                 <div class="speed-box min-speed">
                     <div class="speed-row"><span class="tag pink" style="width: 50%"></span></div>
                 </div>
             </div>

             <div class="row">
                 <span> 农业:</span>
                 <div class="speed-box min-speed">
                     <div class="speed-row"><span class="tag yellow" style="width: 30%"></span></div>
                 </div>
             </div>
         </div>-->
    </div>

    <div class="region-right">
        <div class="region-info">
            <div class="item border-style">
                <h3><a>国控断面 <i> <img src="${request.contextPath}/static/images/pollute/icon-img3.png"></i></a></h3>
                <div class="info-data">
                    <div class="tex">
                        <a>浦南水文站</a>
                        <div class="speed-box">
                            <p>金属物 12%</p>
                            <div class="speed-row">
                                <div class="tag green" style="width: 20%">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>有机物20%</p>
                            <div class="speed-row">
                                <div class="tag orange" style="width: 30%">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>化学物 18%</p>
                            <div class="speed-row">
                                <div class="tag yellow" style="width: 40%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>微生物 18%</p>
                            <div class="speed-row">
                                <div class="tag pink" style="width: 60%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#--<a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>放射物 12%</p>
                            <div class="speed-row">
                                <div class="tag violet" style="width: 70%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>其他 20%</p>
                            <div class="speed-row">
                                <div class="tag"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item border-style">
                <h3><a>污水处理厂 <i> <img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a></h3>
                <div class="info-data">
                    <div class="info-data">
                        <div class="tex">
                            <a href="/indextemp24">华安县三达水务有限公司</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">长泰西区污水处理厂（长泰县三达水务有限公司）</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">漳州市西区污水处理厂</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">南靖高新污水处理厂（西部水务（漳州）有限公司）</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item border-style">
                <h3><a>常规排口 <i> <img src="${request.contextPath}/static/images/pollute/icon-img2.png"></i></a></h3>
                <div class="info-data">
                    <div class="tex">
                        <a href="javascript:void(0)">福建立兴食品有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">漳州盈晟纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建荣信纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建省联盛纸业有限责任公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">大闽食品（漳州）有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">龙海市榜山民政三星造纸厂</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">龙海市信达纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">漳州片仔癀药业股份有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建龙溪轴承（集团）股份有限公司</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="chart-box">
            <h3> 数据分析 <span></span></h3>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 yellow">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <#--<div class="name">南靖上洋</div>-->
                            <p>4</p>
                        </div>
                    </div>
                </div>
                <p>国控断面</p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 blue">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <#-- <div class="name">南靖上洋</div>-->
                            <p>4</p>
                        </div>
                    </div>
                </div>
                <p>污水处理厂</p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 green">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <#--<div class="name">南靖上洋</div>-->
                            <p>9</p>
                        </div>
                    </div>
                </div>
                <p>常规排口</p>
            </div>
        </div>
    </div>

</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/policy.js"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    var basinDatas = new Array(); // 流域数据数组
    var basinPoints = new Array(); // 流域站点数组(重新定位的时候需要清楚掉)
    var basinRiver = new Array();//流域中的河流
    var companyAndPlantPoint = new Array(); // 常规排口,污水处理厂数组
    var envRectifition_icon;
    var fivePolygons = null;

    $(function () {

        /*地图初始化*/
        var longitude = "117.65";
        var latitude = "24.52";
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        envRectifition_icon = new fjzx.map.Icon("/static/images/min-basin.png", {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        });
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
            zoom: 10
        });
        map.render();
        map.removeSelectInteraction();
        //getBasin();
        // getReservoirPoints();

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
        pollutionTraceabilityDetailByUUID();
    });
function pollutionTraceabilityDetailByUUID(){
    //
    $.ajax({
        url:"/environment/pollutionTraceability/findThirdDetailByUUID",
        data:{pointName:$("#pointName").val()},
        type:'POST',
        dataType:'json',
        success:function (data) {
           for(var i=0;i<data.length;i++){
               var tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].jd, data[i].wd), {
                   icon : new fjzx.map.Icon("/static/images/water_sewagePlant.png", {
                       size: new fjzx.map.Size(25, 25),
                       imgSize: new fjzx.map.Size(25, 25),
                       anchor: new fjzx.map.Point(12, 25)
                   }),
                   map : map,
                   title :Ams.isNoEmpty(data[i].mc)==true?data[i].mc:'经度：'+data[i].jd+'，纬度：'+data[i].wd
               });
               map.addOverlay(tempMarker);
           }
            
        }
    })

}
    var thirdDetail = new Array(); // 流域数据数组
    var thirdDetailMap = new Array(); // 流域数据数组

</script>
</html>