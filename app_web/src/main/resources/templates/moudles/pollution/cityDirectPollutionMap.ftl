<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染源大地图-部门数据录入</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <#include "/secondToolbar2.ftl">
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
<body class="pollution-body  alone-pollution">
<input type="hidden" id="pageType" value="${type!}">
<input type="hidden" id="skipqx" value="${skipqx!}">
<input type="hidden" id="department" value="${department!}">
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
        <#--新增还原按钮-->
        <#-- <div class="map-reduction-box" style="z-index: 106">
             <span> <i class="icon iconcustom icon-shuaxin1"></i>还原</span>
         </div>
 -->
    </div><!-- 地图层  -->
    <!--案件列表-->
    <div class="map-caselist-container show  map-contaminated-part" style="width: 370px">
        <div class="map-case-list-box" style="width: 370px">
            <div class="map-case-list" style="width: 370px">
                <div class="map-contaminated-title">
                    <h3 style="border-bottom: none"><span class="icon iconcustom icon-leibie5"></span> 数据筛选</h3>
                </div>

                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <div class="soil-table-box select-Search">
                        <!--搜索框-->
                        <div class="theme-content searchInfo ">
                            <div class="search-container" id="search">
                                <div class="inline-block" style="padding-bottom: 5px;">
                                    <label class="textbox-label textbox-label-before" title="选择站点">选择类型：</label>
                                    <input class="easyui-combobox" name="pointName" value="" id="type" prompt="全部"
                                           data-options="
						url:'/env/pollution2/cityDirect/getCityPollutionType',
						method:'get',
						editable:true,
						valueField:'text',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
                                           style="width:211px;height:33px;">
                                </div>

                                <div class="search-box">
                                    <label class="textbox-label textbox-label-before" title="选择站点">企业名称：</label>
                                    <input class="easyui-textbox"
                                           data-options="prompt:''" style="width:190px;"
                                           id="queryMcMap"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton"
                                       data-options="iconCls:'icon-search'"
                                       onclick="searchDepartmentPollution()"></a>
                                </div>
                            </div>

                            <div class="easyui-table-light" style="padding: 0 10px">
                                <table id="searchDG" class="easyui-datagrid"
                                       style="width: 100%;height:820px
                                       ;min-height: 300px;" toolbar="#search"
                                       data-options="
							            rownumbers:true,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="mc" width="140" formatter="Ams.tooltipFormat">企业名称</th>

                                        <th field="wryzl" width="140" formatter="Ams.tooltipFormat">类型</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
    </div>
</div>
<#include "/moudles/pollution/cityPollutionDetail.ftl">
</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/js/moudles/pollution/pollutionInfoDepartment.js"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\detailInfo.js"></script>
<script type="text/javascript">
    $(function () {
        /*$('#qx').combobox('setValue',$("#skipqx").val());*/
        pollutionMapData();
        pollutionTableData();
    })
    //两个数据一个是布点用的一个是显示表格用的
    //污染源表格数据;
    function pollutionTableData() {
        $('#searchDG').datagrid({
            url: '/env/pollution2/cityDirect/getInfoPage',
            width: '100%',
            fitColumns: true,
            showFooter: true,
            singleSelect: true,//只允许选择一行
            loadMsg: "正在努力加载，请稍等。",
            queryParams: {
                wryzl: $("#type").val(),
                mc: $("#queryMcMap").val().trim(),
                /*  qx: $("#qx").val(),*/
                type: pageType,
                department: $('#department').val()
            },

        });
    }

    var pageType = Ams.isNoEmpty($('#pageType').val()) ? $('#pageType').val() : "dept";

    //污染源地图数据
    function pollutionMapData() {
        $.ajax({
            url: "/env/pollution2/cityDirect/getInfoToMap",
            data: {
                wryzl: $("#type").val(),
                mc: $("#queryMcMap").val().trim(),
                /*qx: $("#qx").val(),*/
                type: pageType,//页面跳转过来的时候使用的参数;
            },
            success: function (data) {
                initDepartmentPollutionMap(data)
            }
        })

    }

    //开始布点============
    function getIconForDepartmentPollution(tid) {//获取污染源图标
        var icon;
        switch (tid) {
            case "餐饮企业"://
                icon = "/static/images/icon/canyinqiye.png";
                break;
            case "海洋排污口":
                icon = "/static/images/hypk.png";
                break;
            case"海洋固体废物":
                icon = "/static/images/hygygtfw-icon.png";
                break;
            case "VOCs企业":
                icon = "/static/images/VOCs-icon.png";
                break;
            case"高架源企业":
                icon = "/static/images/gjyqy-icon.png";
                break;
            case"散乱污企业":
                icon = "/static/images/slwqy-icon.png";
                break;
            case"工业固废":
                icon = "/static/images/gyfq-icon.png";
                break;
            case"工业危险废物":
                icon = "/static/images/gywxfw-icon.png";
                break;
            case"持证矿山":
                icon = "/static/images/stwry-icon.png";
                break;
            case"石板材行业":
                icon = "/static/images/ybgy-icon.png";
                break;
            case"三格化粪池":
                icon = "/static/images/fdlydy-icon.png";
                break;
            case"非道路移动源":
                icon = "/static/images/sghfc-icon.png";
                break;
        }
        return icon;
    }

    var departmentArray;

    function initDepartmentPollutionMap(data) {
        departmentArray = new Array()
        var lng, lat, name, wryzl, targetIcon;
        for (i = 0; i < data.length; i++) {
            lng = data[i].jd;
            lat = data[i].wd;
            name = data[i].mc;
            targetIcon = pollutionIcon[data[i].wryzl];
            if (!Ams.isNoEmpty(lng) || !Ams.isNoEmpty(lat) || !Ams.isNoEmpty(name) || !Ams.isNoEmpty(targetIcon)) {
                continue;
            }
            var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(lng, lat), {
                icon: new fjzx.map.Icon(
                    targetIcon,
                    {
                        size: new fjzx.map.Size(30, 30),
                        imgSize: new fjzx.map.Size(30, 30),
                        anchor: new fjzx.map.Point(0, 30)
                    }
                ),
                map: map,
                title: name
            });
            departmentArray.push(tempMarker);
            map.addOverlay(tempMarker);
            addCaseClickEvent(tempMarker, data[i]);
        }
    }

    $("#searchDG").datagrid({
        onDblClickRow: function (index, row) {
            showDetail(row);
        },
        onClickRow: function (index, data) {
            map.setCenter(new fjzx.map.Point(data.jd, data.wd));
        }
    });

    function searchDepartmentPollution() {
        $("#searchDG").datagrid('load', {
            wryzl: $("#type").val(),
            mc: $("#queryMcMap").val().trim(),
            /* qx: $("#qx").val(),*/
            type: pageType
        });
        for (var i = 0; i < departmentArray.length; i++) {
            map.removeOverlay(departmentArray[i])
        }
        pollutionMapData();
    }

    var pollutionIcon = {
        "VOCs企业":"/static/images/VOCs-icon.png",
        "一般工业固废":"/static/images/icon/yibangongyegufei.png",
        "三格化粪池":"/static/images/icon/sangehuafenchi.png",
        "入河入海排污口":"/static/images/icon/ruheruhaiwurang.png",
        "养殖废水":"/static/images/icon/yangzhifeishui.png",
        "农业种植面源":"/static/images/icon/nongyezhongzhi.png",
        "商业活动":"/static/images/icon/shangyehuodong.png",
        "园区基础设施":"/static/images/icon/yuanqusheshi.png",
        "城市生活污水处理厂":"/static/images/icon/shengshishenghuowushui.png",
        "小水电站":"/static/images/icon/xiaoshuidianzhan.png",
        "工业危险废物":"/static/images/icon/gongyeweixiangufei.png",
        "废弃矿山闭矿":"/static/images/icon/feiqikuangshan.png",
        "持证矿山":"/static/images/icon/chizhengkuangshan.png",
        "持证矿山环评":"/static/images/icon/chikuangshanhuanping.png",
        "持证矿山问题":"/static/images/icon/chizhengkuangshanwenti.png",
        "散乱污企业":"/static/images/icon/sanluangwuqiye.png",
        "水产养殖污染":"/static/images/icon/shuichanyangzhiwurang.png",
        "河道问题":"/static/images/icon/hedaowuti.png",
        "沿海沿江工业固废":"/static/images/icon/yanhaigongyegufei.png",
        "沿海沿江生活垃圾":"/static/images/icon/yanhaiyanjianglaji.png",
        "涉水工业企业":"/static/images/icon/sheshuigongyeqiye.png",
        "渣土车":"/static/images/icon/zhatuche.png",
        "滨海旅游垃圾":"/static/images/icon/binghailvyoulaji.png",
        "漂浮垃圾":"/static/images/icon/piaofulaji.png",
        "生活垃圾":"/static/images/icon/shenghuolaji.png",
        "生活污水":"/static/images/icon/shenghuowushui.png",
        "石板材行业改造":"/static/images/icon/shibancaigaizhao.png",
        "石板材行业环评":"/static/images/icon/chikuangshanhuanping.png",
        "自然保护区功能区保护":"/static/images/icon/ziranbaohuqu.png",
        "规划外养殖":"/static/images/icon/guihuawaiyangzhi.png",
        "道路扬尘":"/static/images/icon/daoluyangcheng.png",
        "闭坑矿山水保":"/static/images/icon/bikengkuangshan.png",
        "露天烧烤":"/static/images/icon/lutianshaokao.png",
        "非法采矿":"/static/images/icon/feifacaikuang.png",
        "非道路移动源":"/static/images/icon/feidaoluyidong.png",
        "项目水保监管":"/static/images/icon/xiangmushuibao.png",
        "餐饮企业":"/static/images/icon/canyinqiye.png",
        "高架源企业":"/static/images/icon/gaojiayuanqiye.png"
    }
</script>

</html>
