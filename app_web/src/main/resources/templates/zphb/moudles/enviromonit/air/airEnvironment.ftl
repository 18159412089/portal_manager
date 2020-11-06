<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>大气环境服务</title>
</head>
<!-- body -->
<body style="overflow:auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/mainMap.css"/>

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
    .fjzx-map-infoWindow a{color:#464444;}
    .fjzx-map-infoWindow-closer{
        top: -50px;
        right: 43px;
    }


    .table-info{width:100%;}
    .table-info td{border:1px solid #c2c2c2;padding:4px 12px;}
    .table-info .tit{width:40%; background:#f6f6f6;text-align:center;}
    .table-info .con{width:30%; text-align:center;}
    .ul:hover{cursor:pointer}
    #mapgroup .ant-radio-button-wrapper{
        width: 95px;
    }
    ._3dsy{
        width: 95px;
    }
    .tdt-infowindow-content{margin:0px;}
    div.tdt-infowindow-content-wrapper{
    //background-color: rgba(50, 50, 50, 0.7);
    }

    #AQIRanking .map-panel-body{height: 548px;}
    #cityAQI .map-panel-body{height: 548px;}
    #cityPanel{height: 300px;}
    /*------------------------------------------------------响应式----------------------------------------------------------*/
    @media screen and (max-width: 1440px) {
        #AQIRanking .map-panel-body{height: 448px;}
        #add{height: 407px;}
        #cityAQI .map-panel-body{height: 448px;}
        #cityPanel{height: 250px;}
        #city{overflow-y: auto;height: 502px;}
    }
    @media screen and (max-width: 1024px){
        .basemap-toggle{
            left: -216px;
        }
    }

    #gridCaseDlg {width:800px;height:500px;padding:15px;}
    #gridCaseDlg table {width:100%;}
    #gridCaseDlg tr.odd {background:#f0f0f0;}
    #gridCaseDlg .detail-info-group {float:left;width:50%;padding:8px 4px;color:#333333;overflow:hidden;box-sizing:border-box;}
    #gridCaseDlg .detail-info-group .info-title {color:#999999;width:120px;text-align:right;float:left;}
    #gridCaseDlg .detail-info-group .info-con {margin-left:120px;}
    .thumb-img {width:180px;height:120px;padding:4px;margin:5px;display:inline-block;overflow:hidden;position:relative;border:1px solid #dddddd;background:#ffffff;-webkit-border-radius:3px;-moz-border-radius:3px;border-radius:3px;}
    .thumb-img img {width:100%;height:100%;cursor:pointer;}
    .thumb-img .video-img {position: absolute;z-index:100;top:36px;left:60px;width:50px;height:auto;}
</style>

<#include "/zphb/zpSecondToolbar.ftl">

<input type="hidden" id="airPointCode" value="${airPointCode!}" />
<input type="hidden" id="airPointType" value="${airPointType!}" />
<input type="hidden" id="targetId" value="${target!}" />
<input type="hidden" id="pointNameId" value="${pointName!}" />

<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
    <!-- main -->
    <div id="mapDiv" class="map-wrapper" style="position:fixed;bottom:0;">
        <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -200px;">
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
    <!-- 地图层 -->

    <!-- 图例  -->
    <div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;z-index: 998;">
        <div class="title">
            <div class="item">优</div>
            <div class="item">良</div>
            <div class="item">轻度</div>
            <div class="item">中度</div>
            <div class="item">重度</div>
            <div class="item">严重</div>
            <div class="item">暂无数据</div>
        </div>
        <div class="grade-legend">
            <div class="item excellent"></div>
            <div class="item good"></div>
            <div class="item mild"></div>
            <div class="item moderate"></div>
            <div class="item severe"></div>
            <div class="item dangerous"></div>
            <div class="item not_data"></div>
        </div>
        <div class="num">
            <div class="item">0</div>
            <div class="item">50</div>
            <div class="item">100</div>
            <div class="item">150</div>
            <div class="item">200</div>
            <div class="item">300</div>
            <div class="item">500</div>
            <div class="item"></div>
        </div>
    </div>
    <!-- 图例 over -->

    <div class="map-panel panel-top" style="z-index: 998;position:absolute;top:100px;left:50px;width:430px;">
        <div class="map-panel-header">
				<span class="title">
					<span class="icon iconcustom icon-zhedie3"></span><span >AQI行政划区排行榜</span>
				</span>
        </div>
        <div class="map-panel-body" style="height:548px;">
            <div class="alone-part">
                <a id="realTime" class="select-tag">实时</a>
                <a id="yesterday">昨日</a>
                <a id="currentonth">当月</a>
                <div  style="display: none;"><#--class="inline-block"-->
                    <div class="selectBox-container">
                        <a href="javascript:void(0)" class="select-button">对比</a>
                        <div class="select-panel">
                            <div class="easyui-panel" title="区县"  style="width:560px;height:200px;padding:10px;" data-options="footer:'#ft',tools:'#tt'" ng-style="color:red">
                                <#--时间控件-->
                                <div class="row" style="padding: 0 10px 12px 10px; border-bottom: 1px solid #e7e7e6;margin-bottom: 10px;">
                                    <div class="inline-block selectBox-container-input">
                                        <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                        <input id="startTimeC" name="startTimeC" class="easyui-datebox" style="width:156px;line-height: 26px;height: 26px">
                                        <label>-</label>
                                        <input id="endTimeC" name="endTimeC" class="easyui-datebox" style="width:156px;line-height: 26px;height: 26px">
                                    </div>
                                </div>

                                <div id="selectGrop">
                                    <!--复选框-->
                                    <label class="form-checkbox">
                                        <input name="type" type="checkbox" value="1"/>
                                        <span class="lbl">测点</span>
                                    </label>
                                    <label class="form-checkbox">
                                        <input name="type" type="checkbox" value="2"/>
                                        <span class="lbl">行政区</span>
                                    </label>
                                    <label class="form-checkbox">
                                        <input name="type" type="checkbox" value="3"/>
                                        <span class="lbl">测点</span>
                                    </label>
                                    <label class="form-checkbox">
                                        <input name="type" type="checkbox" value="4"/>
                                        <span class="lbl">行政区</span>
                                    </label>
                                    <!--复选框 over-->
                                </div>
                            </div>
                            <div id="tt">
                                <label class="form-checkbox">
                                    <input name="type" type="checkbox" value="" class="all"/>
                                    <span class="lbl">全选</span>
                                </label>
                            </div>
                            <div class="tr" id="ft">
                                <button type="button" class=" btn-blue l-btn " id="sure—tag">确定</button>
                                <button type="button" class="btnSure btn-blue l-btn close-select">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="AQI-ranking-list grade-legend-text" id="add">
                <div class="item">
                    <span class="ranking">排名</span>
                    <span class="title">城市</span>
                    <span class="newTime">最新数据时间</span>
                    <span class="data">AQI</span>
                </div>
                <ul class="ul" id="city"></ul>
            </div>
            <#--当月  昨天 数据-->
            <div class="yesterday AQI-ranking-list grade-legend-text" style="display: none">
                <div class="item">
                    <span class="ranking">排名</span>
                    <span class="title">城市</span>
                    <span class="newTime">日期</span>
                    <span class="data">AQI</span>
                </div>
                <ul id="yesterdayData" class="ul"></ul>
            </div>
            <div class="currentonth AQI-ranking-list grade-legend-text"  style="display: none">
                <div class="item">
                    <span class="ranking">排名</span>
                    <span class="title">城市</span>
                    <span class="newTime">月份</span>
                    <span class="data">AQI</span>
                </div>
                <ul id="currentMonthData" class="ul"></ul>
            </div>

        </div>
    </div>
    <!-- 图例 over -->

    <div class="map-panel" id="map-panel2" style="z-index: 998;position:absolute;top:86px;right:58px;">
        <div class="map-panel-header">
				<span class="title">
					<span class="icon iconcustom icon-zhedie3"></span>
					功能控制
				</span>
        </div>
        <div class="map-panel-body" style="height: 545px;width:440px;position: relative;background: none;">
            <div class="body-box" id="filterBox" style="width:320px;height:150px;margin-left:120px; border-bottom: 1px solid #fff;border-color: rgba(255,255,255,0.15);">
                <div class="filter-container" style="margin-bottom: 12px;">
                    <div class="filter-box">
                        <div class="filter-title">按类型</div>
                        <div class="filter-content">
                            <div class="change-line no-choice" title="空气自建站点" id="miniMonitor" style="width: 130px;display: none;" onclick="getMiniMonitor()">
                                <img style="height:20px; width: 20px;float:left" src="/static/images/air/miniMonitor.png" />空气自建站点(13)
                            </div>
                            <div class="change-line no-choice" id="enterprise" title="废气排口" style="width:110px;">
                                <img style="height:20px; width: 20px;float:left" src="/static/images/air/export.png" />废气排口
                            </div>
                            <div class="change-line no-choice" id="construction" title="工地" style="width:100px;display: none;" >
                                <img style="height:20px; width: 20px;float:left" src="/static/images/air/site.png" />工地(273)
                            </div>
                            <div class="change-line no-choice" title="工业废气企业" id="wpfqqy" style="width: 142px" onclick="getWpfqqy()">
                                <img style="height:20px; width: 20px;float:left" src="/static/images/air/waste_gas.png" />工业废气企业
                            </div>
                            <div class="change-line no-choice" title="网格事件" id="gridCase" style="width:120px;" onclick="getAirCase()">
                                <img style="height:20px;width:20px;float:left" src="/static/images/air_case.png" />网格事件
                            </div>
                            <!-- <div class="change-line no-choice" id="truck" style="width:160px;">禁卡区域</div>
                             <div class="change-line no-choice" id="noFireworksArea" style="width:80px;">禁炮区域</div> -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content" style="width:320px;margin-left:120px;top: 150px;">
                <div class="body-box" id="mapTabs_miniMonitor"
                     url="/enviromonit/airMonitorPoint/getCityListByType?pointType=2">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="miniMonitorToolbar">
                                <div class="search-box">
                                    <input id="pointName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="miniMonitorSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="miniMonitorDg" class="easyui-datagrid"
                                       style="width: 100%;height:350px;" toolbar="#miniMonitorToolbar" url=""
                                       data-options="
										rownumbers:false,
										singleSelect:true,
										striped:false,
										autoRowHeight:false,
										pagination:{layout:['first','links','last']},
										pageSize:10,
										nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="pointName" width="320px" formatter="Ams.tooltipFormat">站点名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_enterprise"
                     url="/zphb/enterprise/peenterprisedata2/list?outType=2">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="enterpriseToolbar">
                                <div class="search-box">
                                    <input id="outName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="enterpriseSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="enterpriseDg" class="easyui-datagrid"
                                       style="width: 100%;height:350px;" toolbar="#enterpriseToolbar" url=""
                                       data-options="
										rownumbers:false,
										singleSelect:true,
										striped:false,
										autoRowHeight:false,
										pagination:{layout:['first','links','last']},
										pageSize:10,
										nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="peName" width="320px" formatter="Ams.tooltipFormat">排口名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_construction"
                     url="/enviromonit/airConstructionSite/getFileAttachPage">
                    <div class="theme-container">
                        <div class="theme-title">筛选<a id="companyInfoSetGlobal" href='/enviromonit/airConstructionSite/companyInfoSet?pid=${pid!}'  class="title-link-tag" target="_blank">企业信息配置>></a></div>
                        <div class="theme-content">
                            <div class="search-container" id="constructionToolbar">
                                <div class="search-box">
                                    <input id="constructionName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="constructionSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="constructionDg" class="easyui-datagrid"
                                       style="width: 100%;height:350px;" toolbar="#constructionToolbar" url=""
                                       data-options="
										rownumbers:false,
										singleSelect:true,
										striped:false,
										autoRowHeight:false,
										pagination:{layout:['first','links','last']},
										pageSize:10,
										nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="name" width="320px" formatter="Ams.tooltipFormat">工地名称</th>
                                        <th field="picture" hidden></th>
                                        <th field="video" hidden></th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_wpfqqy"
                     url="/zphb/enviromonit/airEnvironment/getPolluteList">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="wpfqqyToolbar">
                                <div class="search-box">
                                    <input id="wpfqqyName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="wpfqqySearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="wpfqqyDg" class="easyui-datagrid"
                                       style="width: 100%;height:350px;" toolbar="#wpfqqyToolbar" url=""
                                       data-options="
										rownumbers:false,
										singleSelect:true,
										striped:false,
										autoRowHeight:false,
										pagination:{layout:['first','links','last']},
										pageSize:10,
										nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="name" width="320px" formatter="Ams.tooltipFormat">企业名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_gridCase" url="">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="gridCaseToolbar">
                                <div class="search-box">
                                    <label class="textbox-label textbox-label-before" title="事件描述">事件描述:</label>
                                    <input id="describe" class="easyui-textbox" style="width:228px;"/>
                                    <div style="margin-top:7px;">
                                        <label class="textbox-label textbox-label-before" title="开始时间">开始时间:</label>
                                        <input id="startTime" class="easyui-datebox" style="width:160px;">
                                    </div>
                                    <div style="margin-top:7px;">
                                        <label class="textbox-label textbox-label-before" title="结束时间">结束时间:</label>
                                        <input id="endTime" class="easyui-datebox" style="width:160px;">
                                        <a href="#" title="搜索" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" style="margin:0;" onclick="getAirCaseList()"></a>
                                    </div>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="gridCaseDg" class="easyui-datagrid"
                                       style="width:100%;height:380px;" toolbar="#gridCaseToolbar" url=""
                                       data-options="
												rownumbers:false,
												singleSelect:true,
												striped:false,
												autoRowHeight:false,
												pagination:true,
												nowrap:true">
                                    <thead>
                                    <tr>
                                        <th field="describe" width="320px" formatter="Ams.tooltipFormat">事件描述</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="tabs-panel" style="top:150px;margin-right: -120px;"></ul>
        </div>
    </div>
    <!-- main over -->
</div>

<div id="mapgroup" class="_3dsy mapgroup-left">
    <div class="point-group">
        <a class="select-point" value="aqi">AQI</a>
        <a value="A34004">PM2.5</a>
        <a value="A34002">PM10</a>
        <a value="A21026">SO2</a>
        <a value="A21004">NO2</a>
        <a value="A21005">CO</a>
        <a value="A05024">O3</a>
    </div>
    <span class="point-tag" id="test"><span class="icon iconcustom icon-zhedie3"></span>因子列表</span>
</div>

<!-- 修改用户密码窗口 -->
<#include "/passwordModify.ftl"/>
<!-- 数据分析和详细信息窗口 -->
<#include "/moudles/enviromonit/air/airAnalysis.ftl"/>
<!-- 废弃排口窗口 -->
<#include "/moudles/enviromonit/air/enterpriseAnalysis.ftl"/>
<!-- 在建工地详细信息 -->
<#include "/moudles/enviromonit/air/projectAnalysis.ftl"/>
<!-- 污普废气企业信息 -->
<#include "/moudles/enviromonit/air/wpfqAnalysis.ftl"/>

<!--  网格事件弹窗 -->
<div id="gridCaseDlg" class="easyui-dialog" data-options="closed:true,modal:true,border:'thin'">
    <table>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件编号：</div>
                    <div class="info-con" id="caseNumber"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">事件类型：</div>
                    <div class="info-con" id="caseTypeName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件来源：</div>
                    <div class="info-con" id="sourceName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">超时状态：</div>
                    <div class="info-con" id="overTimeStatusName"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件类型：</div>
                    <div class="info-con" id="majorTypeIdName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">事件小类：</div>
                    <div class="info-con" id="smallTypeIdName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">所属网格：</div>
                    <div class="info-con" id="departmentIdName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">网格等级：</div>
                    <div class="info-con" id="userLevel"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">所属辖区：</div>
                    <div class="info-con" id="jurisdiction"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">状态：</div>
                    <div class="info-con" id="statusName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">上报时间：</div>
                    <div class="info-con" id="reportFormatTime"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">上报人：</div>
                    <div class="info-con" id="createByName"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">事发位置：</div>
                    <div class="info-con" id="address"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">情况描述：</div>
                    <div class="info-con" id="describe"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">附件：</div>
                    <div class="info-con" id="airCaseFiles"></div>
                </div>
            </td>
        </tr>
    </table>
</div>

<!-- 附件弹窗-->
<div id="caseFileDialog" class="easyui-dialog" style="width:800px;height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <div class="modal-body" style="height:100%;">
        <div class="no-file-list">没有附件</div>
        <div id="bodyShow" style="height:100%;">
            <div class="gallerys" style="height:78%;"></div>
            <div class="picDetail-bottom"></div>
        </div>
    </div>
</div>


<!-- 图表弹窗-->
<div id="chartDialog" class="easyui-dialog" title="数据"  closed="true" style="width:800px;height: 500px;">
    <div class="chart-box" style="padding: 15px ;">
        <div id="airPrimaryPollutant" style="width: 100%;height: 380px;"></div>
    </div>
</div>

<script type="text/javascript" src="${request.contextPath}/static/zphb/js/zpxAreaPolygons.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/airEnvironment.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/airAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/enterpriseAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/projectAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/truckForbiddenArea.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/noFireworksArea.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/wpfqqyAnalysis.js"></script>
<!-- 网格事件js -->
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-download.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/photoGallery/jquery.photo.gallery.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/airCase.js"></script>
<script type="text/javascript">

    var markerMap = new HashMap();
    var onlyMonitorFlag = true;
    var f=0;
    var size = 0 ; // 当前地图大小
    var code;  // 城市站点编号
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $('#startTimeC').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTimeC').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            $(this).remove();
        });
    };
    $(window).resize(function () {

    });

    $('#wpfqqyDg').datagrid({onClickRow:function(index,data){
            animalMarker(data.name);
            console.log(data)
            updateMp(data.lng,data.lat);
        }
    });

    $('#enterpriseDg').datagrid({onClickRow:function(index,data){
            animalMarker(data.peId);
            updateMp(data.longValue,data.latValue);
        }
    });

    $('#miniMonitorDg').datagrid({onClickRow:function(index,data){
            updateMp(data.longitude,data.latitude);
        }
    });

    $('#constructionDg').datagrid({onClickRow:function(index,data){
            updateMp(data.longitude,data.latitude);
        }
    });

    $(function(){
        Ams.setPageDg('wpfqqyDg');
        Ams.setPageDg('enterpriseDg');
        Ams.setPageDg('miniMonitorDg');
        Ams.setPageDg('constructionDg');

        $.ajax({
            type: 'POST',
            dataType : 'json',
            url: Ams.ctxPath+'/zphb/enviromonit/airMonitorPoint/getCity',
            success: function(data){
                var html = "";
                $.each(data,function(i){
                    html += "<label class='form-checkbox'><input name='type' type='checkbox' value='"
                        +data[i].uuid+"'/><span class='lbl'>"+data[i].name+"</span></label>";
                });
                $("#selectGrop").html(html);
            }
        });
        /*---------------------------------------------------根据排名上的城市，定位到地图上的位置、显示城市信息-------------------------------------*/
        //creatMarker("1",$("span.ant-radio-button-checked input").val());
        //creatMarker("2",$("span.ant-radio-button-checked input").val());
        ranking("1", "1");//第一个值是站点类型 第二个是站点级别
        creatMarker("1",$(".point-group .select-point").attr("value"));

        //根据实时动态数据上的 站点code 打开弹窗
        var airPointCode = $("#airPointCode").val();
        var airPointType = $("#airPointType").val();
        if(airPointCode != ""){
            $.ajax({
                type: 'POST',
                dataType : 'json',
                url: Ams.ctxPath+'/zphb/enviromonit/airMonitorPoint/getPointsInfo',
                data: {pointCode:airPointCode },
                success: function(data){
                    if(airPointType == "0"){
                        map.setZoom(12);
                    }
                    map.setCenter(new fjzx.map.Point(parseFloat(data.longitude),parseFloat(data.latitude)));
                    showAir(data,airPointType);
                }
            });
        }

        $(".map-panel-header").on("click",function(){
            var $target=$(this).parents(".map-panel");
            if($target.hasClass("collapsed")){
                $target.removeClass("collapsed");
            }else{
                $target.addClass("collapsed");
            }
        });

        $("#cityPanel").mCustomScrollbar({
            theme:"light-3",
            scrollButtons:{
                enable:true
            }
        });

        $("input:radio").click(function(event){
            $("label.ant-radio-button-wrapper-checked").removeClass("ant-radio-button-wrapper-checked");
            $("span.ant-radio-button-checked").removeClass("ant-radio-button-checked");
            $(this).parent().parent().addClass("ant-radio-button-wrapper-checked");
            $(this).parent().addClass("ant-radio-button-checked");
            var factor = $("span.ant-radio-button-checked input").val();
            if(f == 1){
                creatAir("0",factor,code);
            }
            // 没点击排名的时候，地图放大和缩小就显示对应的城市站点或者监测站点（所有）
            if(f == 0) {
                if(map.getView().getZoom()<11 ){
                    creatAir("1",factor);
                }else if(map.getView().getZoom()>=11 ){
                    creatAir("0",factor);
                }
            }
            if($("#miniMonitor").hasClass('choiced')){
                creatAir("2",factor);
            }
        });
        loadAirData1();
    });

    $("#test").click(function () {
        if ($('.point-group').width() <= 0){
            $("#test").html("<span class=\"icon iconcustom icon-zhedie3\"></span> 因子列表")
            $('.point-group').animate({width: '132',opacity:'1'}, 200);
        }else{
            $("#test").html("<span class=\"icon iconcustom\"></span> 因子列表")
            $('.point-group').animate({width: '0',opacity:'0'}, 200);
        }
    })

    //监测点 点击事件
    $(".point-group") .find("a").click(function () {
        $(".point-group").find("a").removeClass("select-point");
        $(this).addClass("select-point");
        var factor = $(".point-group .select-point").attr("value");
        if(f == 1){
            creatAir("0",factor,code);
        }
        // 没点击排名的时候，地图放大和缩小就显示对应的城市站点或者监测站点（所有）\
        if(f == 0) {
            if(map.getView().getZoom()<11 ){
                creatAir("1",factor);
            }else if(map.getView().getZoom()>=11 ){
                creatAir("0",factor);
            }
        }
        if($("#miniMonitor").hasClass('choiced')){
            creatAir("2",factor);
        }
    })
</script>
<script>
    $(function(){

        /*区县选择*/
        $('body').on('click','#sure—tag',function () {
            var $target=$(this).parents(".select-panel");
            // $target.off("change.selectAll",".all");

            //获取选中的值
            var $chenckbox =$("#selectGrop").find(".form-checkbox");
            var  nub= $chenckbox.length; // 获取checkbox 个数
            var nublist=[];//存放被选中值
            var regionCode = "";
            for(var i = 0; i<nub;i++){
                if($chenckbox.eq(i).find("input").is(':checked')){
                    $chenckbox.eq(i).find("span").text()
                    nublist.push($chenckbox.eq(i).find("input").val());
                    // nublist.push( "key:"+ i+"  val:"+$chenckbox.eq(i).find("span").text())
                    if(i==0){
                        regionCode += $chenckbox.eq(i).find("input").val();
                    }else{
                        regionCode += ","+$chenckbox.eq(i).find("input").val();
                    }
                }
            }

            console.log(nublist)
            if(regionCode == ""){
                Ams.error("对比的城市不能为空");
                $('#chartDialog').window('close');
                return;
            }
            if(!Ams.timeComparison($("#startTimeC").val(), $("#endTimeC").val())){
                $('#chartDialog').window('close');
                return;
            }
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/zphb/enviromonit/airPrimaryPollutant/getAQIEchart',
                data: {
                    codeRegion: regionCode,
                    pointType: "1",
                    startTime: $("#startTimeC").val(),
                    endTime: $("#endTimeC").val(),
                    timeType: "day"
                },
                async: true,
                success: function (result) {
                    console.info(111)
                    var charts = echarts.init(document.getElementById('airPrimaryPollutant'));
                    setCharts(charts, "城市对比", result.pointName, result.aqi, result.colorList);
                }
            });

        });


        $('body').on('click','.select-button',function () {
            var $target=$(this).next();
            $target.addClass('show');
            $target.on("change.selectAll",".all",function () {
                if($(this).prop("checked")){
                    $target.find('input[name='+$(this).prop("name")+']').prop("checked",true);
                }else{
                    $target.find('input[name='+$(this).prop("name")+']').prop("checked",false);
                }

            });
        });
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");

        });


        //昨日 点击事件
        $("#yesterday").click(function () {
            $("#add").hide()
            $(".currentonth").hide()
            $(".yesterday").show()
            var day1 = new Date();
            day1.setTime(day1.getTime()-24*60*60*1000);
            $.ajax({
                type: 'POST',
                dataType : 'json',
                url: Ams.ctxPath+'/zphb/enviromonit/airHourData/getAllPointsDayDataRanking',
                data: {time:Ams.dateFormat(day1, "yyyy-MM-dd") },
                success: function(data){
                    if(data.length == 0){
                        $("#currentMonthData").html("<li class='item'><span class='ranking'><span style='width:400px;'>暂无数据</span></span>");
                        return;
                    }
                    var listHtml = "";
                    $.each(data,function(i){
                        var color;
                        var text;
                        if(data[i].aqi < 0){
                            color = 'not_data';
                        }else if(data[i].aqi <=50){
                            color ='excellent';
                            text ='';
                        }else if(data[i].aqi <= 100){
                            color ='good';
                        }else if(data[i].aqi <= 150){
                            color ='mild';
                        }else if(data[i].aqi <= 200){
                            color ='moderate';
                        }else if(data[i].aqi <= 300){
                            color ='severe';
                        }else if(data[i].aqi <= 500){
                            color ='dangerous';
                        }
                        listHtml +="<li class='item'><span class='ranking'><span>"+(i+1)+"</span></span>";
                        listHtml +="<span class='title'>"+data[i].name+"</span>";
                        listHtml +="<span class='newTime'>"+data[i].time+"</span>";
                        listHtml +="<span class='data'><span class='"+color+"'>"+data[i].aqi+"</span></span></li>";
                    });
                    $("#yesterdayData").html(listHtml);
                }
            });
        })


        //当月 点击事件
        $("#currentonth").click(function () {
            $("#add").hide()
            $(".yesterday").hide()
            $(".currentonth").show()
            var day1 = new Date();
            day1.setTime(day1.getTime()-24*60*60*1000);
            $.ajax({
                type: 'POST',
                dataType : 'json',
                url: Ams.ctxPath+'/zphb/enviromonit/airHourData/getAllPointsDayDataRanking',
                data: {time:Ams.dateFormat(day1, "yyyy-MM") },
                success: function(data){
                    if(data.length == 0){
                        $("#currentMonthData").html("<li class='item'><span class='ranking'><span style='width:400px;'>暂无数据</span></span>");
                        return;
                    }
                    var listHtml = "";
                    $.each(data,function(i){
                        var color;
                        var text;
                        if(data[i].aqi < 0){
                            color = 'not_data';
                        }else if(data[i].aqi <=50){
                            color ='excellent';
                            text ='';
                        }else if(data[i].aqi <= 100){
                            color ='good';
                        }else if(data[i].aqi <= 150){
                            color ='mild';
                        }else if(data[i].aqi <= 200){
                            color ='moderate';
                        }else if(data[i].aqi <= 300){
                            color ='severe';
                        }else if(data[i].aqi <= 500){
                            color ='dangerous';
                        }
                        listHtml +="<li class='item'><span class='ranking'><span>"+(i+1)+"</span></span>";
                        listHtml +="<span class='title'>"+data[i].name+"</span>";
                        listHtml +="<span class='newTime'>"+data[i].time+"</span>";
                        listHtml +="<span class='data'><span class='"+color+"'>"+data[i].aqi+"</span></span></li>";
                    });
                    $("#currentMonthData").html(listHtml);
                }
            });

        })


        //实时 点击事件
        $("#realTime").click(function () {
            $(".currentonth").hide()
            $(".yesterday").hide()
            $("#add").show()
        })

        $(".close-select").click(function () {

            $(".select-panel").removeClass("show")
            $('#chartDialog').window('close');
        });


        //图表弹窗打开
        $("#sure—tag").click(function () {
            $('#chartDialog').window('open');
        });

        $(".alone-part").find("a").click(function () {
            $(".alone-part").find("a").removeClass("select-tag")
            $(this).addClass("select-tag")
        })
    })

    //图表数据插入
    function setCharts(charts, title, xAxis, series, colorList) {
        charts.clear();
        var option = {
            title: {
                text: title
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: ''        // 默认为直线，可选为：'line' | 'shadow'  设置‘’去除倒影
                },
                formatter: function (params) {
                    var htmlStr = '<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[0].color + ';"></span>';
                    htmlStr += params[0].seriesName + ': ' + params[0].value + '<br/>';
                    htmlStr += '</div>';
                    return htmlStr;
                }
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            formatter: function (value) {
                return value.split(",")[0].split('').join('\n');
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis,
                    axisLabel: {
                        type: 'category',
                        interval: 0,
                        formatter: function (value, index) {//格式化文本标签
                            return (index + 1) + '\n' + value.split(",")[0].split('').join('\n');
                        },
                        textStyle: {
                            fontSize: 15      //更改坐标轴文字大小
                        }
                    }
                }

            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [{
                name: "AQI",
                type: "bar",
                data: series,
                itemStyle: {
                    normal: {
                        label: {
                            show: true, //开启显示
                            position: 'top', //在上方显示
                            textStyle: { //数值样式
                                color: 'black',
                                fontSize: 16
                            }
                        }, color: function (params) {
                            return colorList[params.dataIndex];
                        }
                    }
                },
            }]
        };
        charts.setOption(option);

        window.onresize = function() {
            $('#airPrimaryPollutant').width('100%');
            charts.resize();
        }
    }


    //右侧边栏 默认隐藏 搜索栏
    $(document).ready(function(){
        if($(".choiced").length==0){
            $("#map-panel2"). find(".map-panel-body").css({"height":"156px","overflow":"hidden"});
        }
    })
    //年数据大屏展示中点击大气中的监控情况进入1行政区,2测点,3废气排口,4工地,5工业废气企
    function loadAirData1() {
        var target =$("#targetId").val();
        if (target == 1) {//行政区不作处理

        } else if (target == 2) {//本页空气自建站点
            getMiniMonitor()
            $("#miniMonitor").addClass("choiced");
            addTab("空气自建站点", "miniMonitor")
        } else if (target == 3) {
            $("#enterprise").addClass("choiced");
            addTab("废气排口", "enterprise")
        } else if (target == 4) {
            $("#construction").addClass("choiced");
            addTab("工地", "construction")
        } else if (target == 5) {
            getWpfqqy();
            $("#wpfqqy").addClass("choiced");
            addTab("工业废气企业", "wpfqqy")
        }else if(target == 6){
            getAirCase();
            $("#gridCase").addClass("choiced");
            addTab("网格事件", "gridCase")
        }
    }
    //点击marker 动画
    function animalMarker(markerId) {
        var myMarker = markerMap.get(markerId);
        var cycleObject = myMarker.cycleAnimal();
        cycleObject.startAnimal();
        cycleObject.setCycleTime(5);
    }
</script>
</body>
</html>
