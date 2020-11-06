<!DOCTYPE html>
<html lang="en" class="real-body">
<head>
    <title>污染源汇总表</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudData.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
</head>
<style>
    .window {
        border-width: 3px;
        border-radius: 5px;
    }

    .window, .window .window-body {
        border-color: #3aa1d9;
    }

    .panel.window.panel-htop .panel-header {
        border-color: #328bc1;
        background: #1e609e;
    }

    .window, .window .window-body {
        border-color: #3aa1d9;
    }

    .window .panel-body {
        background-color: #1e609e !important;
    }

    .window-shadow {
        background: #1e609e;
        -webkit-box-shadow: -1px 0px 1px 0px #1e609e;
    }

    .tabs li {
        border-color: #3aa1d9;
    }

    .tabs-title {
        color: white
    }

    .tabs-header, .tabs-tool {
        background-color: #3aa1d9;
    }

    .tabs li a.tabs-inner {
        border-color: #3aa1d9;
    }

    .tabs li.tabs-selected {
        border-top-color: #3aa1d9;
    }

    .tabs li.tabs-selected a.tabs-inner {
        background: #1e65a3;
        border-top-color: #00a65a;
        background-color: #1e65a3;
    }

    .datagrid .datagrid-pager.pagination .pagination-info {
        display: none
    }

    .alone-pollution .window-proxy-mask, .window-mask {
        background: rgba(0, 0, 0, 0.1);
    }

    .datagrid-htable, .home-ranking-list .datagrid-btable, .home-ranking-list .datagrid-ftable {
        color: #d4dbe5;
    }

    .easyui-dialog .textbox-label {
        color: white !important;
    }

    .inline-radio-box {
        color: white;
    }


</style>
<!-- body -->
<body class="pollution-info-body">
<div class="pollution-real-body info-real-body ">
    <#--    头部---->
    <div class="home-real-head">
        <div class="real-head-left">
            <span class="countPollution"> <i><img src="${request.contextPath}/static/images/new-img/tips-icon.png" alt=""/></i> 截止2019年10月30日共排查各类污染源企业3463个</span>
        </div>
        <div class="real-head-title">
            <span>污染源汇总表</span>
        </div>
        <div class="real-head-right">
            <a class="real-but" href="${request.contextPath}/env/pollution2/pollutionInfo?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">进入</a>
            <a class="real-but" style="margin-left: 0" href="${request.contextPath}/env/pollution2/realtime/index">实时动态</a>
        </div>
    </div>
    <#--内容-->
    <div class="info-real-content">
        <#--类型-->
        <div class="entry-type-list">
            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p><span id="countPollution"></span> 个</p>

                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">大气污染</span>
                <p><span id="dq"></span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">水环境污染</span>
                <p><span id="s"></span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">土壤环境污染</span>
                <p><span id="tr"></span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">海洋环境污染</span>
                <p><span id="hy"></span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">生态环境污染</span>
                <p><span id="st"></span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png"
                                                  alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png"
                                                   alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png"
                                                     alt=""/></div>
                <div class="right-bottom-border"><img
                            src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>
        </div>

        <form style="margin: 20px 0" id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="行政区">行政区:</label>
                <input class="easyui-combobox" id="qx_search" name="qx" prompt="全部" data-options="
							url:'/env/pollution2/getAllPollutionCity',
									method:'get',
									editable:false,
									valueField:'name',
									textField:'name',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="污染源类型">污染源类型：</label>
                <input class="easyui-combobox" id="wrylx_search" name="wrylx" prompt="全部" data-options="
											url:'/env/pollution2/data/getType?flag=wrylx&tblName=POLLUTION_INFO_DATA',
									method:'get',
									editable:false,
									valueField:'name',
									textField:'name',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="污染源种类">污染源种类：</label>
                <input class="easyui-combobox" id="wryzl_search" name="wryzl" prompt="全部" data-options="
									url:'${request.contextPath}/env/pollution2/data/getType?flag=wryzl&tblName=POLLUTION_INFO_DATA',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                <input name="updateTime" id="updateDate_search" class="easyui-datebox" style="width:156px;">
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="企业">企业：</label>
                <input class="easyui-textbox" id="mc_search" name="mc" prompt="全部"
                       style="width:200px;"/>
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-red"
               data-options="iconCls:'icon-arrow_refresh_small'"
               onclick="doReset()">重置</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" onclick="exportData()"
               data-options="iconCls:'iconcustom icon-shujudaochu1'">导出excel</a>
        </form>

        <div class="data-table-box">
            <div class="home-ranking-list">
                <!-- 数据列表-->
                <table id="pollutionDataShow" class="easyui-datagrid" url="/env/pollution2/pollutionPageData"
                       style="height:100%"
                       data-options="
							  rownumbers:false,
							            singleSelect:false,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            fitColumns:true,
							            fit:false,
							            pageSize:10,
							            nowrap:false">
                    <thead>
                    <tr>
                        <th align="center" rowspan="2" width="10%" field="wryzl">种类</th>
                        <th align="center" rowspan="2" width="10%" field="mc">企业名称</th>
                        <th colspan="2"  align="center"> <span class="th-style1">属地责任</span></th>
                        <th colspan="4"  align="center"> <span class="th-style1">部门责任</span></th>
                        <th align="center" rowspan="2" width="10%" formatter="operation" field="uuid">操作</th>
                    </tr>
                    <tr>
                        <th align="center" width="10%" field="sdzrZrdw">责任单位</th>
                        <th align="center" width="15%" field="sdzrdwZrrlxfs">责任人及联系方式</th>
                        <th align="center" width="10%" field="bmzrZrdw">责任单位</th>
                        <th align="center" width="13%" field="bmzrdwZrrlxfs">负责人及联系方式</th>
                        <th align="center" width="10%" field="bmzrPhzrdw">配合责任单位</th>
                        <th align="center" width="12%" field="bmzrdwZrrlxfs">负责人及联系方式</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <!-- 数据列表 over-->
            </div>
        </div>


    </div>


</div>
<#include "/moudles/pollution/realTimePollutionDetail.ftl">
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\detailInfo.js"></script>
<#include "/common/loadingDiv.ftl"/>
</body>


<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }

    $(document).ready(function () {
        $(".see-tag").on("click", function () {
            $("#infoDlg").dialog('open').dialog('center').dialog('setTitle', '详情');
        })
    })
    $(function () {
        countPollutionData()
    })

    function countPollutionData() {
        $.ajax({
            url: "/env/pollution2/countPollutionData",
            dataType: "json",
            data: {},
            type: "POST",
            success: function (result) {
                $(".countPollution").text("截止"+Ams.dateFormat(new Date(),'yyyy年MM月dd日')+"共排查各类污染源企业"+result.countPollution+"个");
                for (var key in result) {
                    $("#" + key).text(result[key]);
                }
            }
        })
    }

    function operation(target, row, rowIndex) {
        var newdata = JSON.stringify(row);
        return "<a class='see-tag' onclick='showDetail(" + newdata + ")'>查看</a>";
    }

    function doSearch() {
        $("#pollutionDataShow").datagrid('reload',Ams.searchParam("searchForm1"));
    }
    function doReset() {
        $("#searchForm1").form('clear');
        $('#pollutionDataShow').datagrid('reload',{});
    }
    function exportData() {
        window.open(Ams.ctxPath + '/env/pollution2/pollutionPageData?export=yes&mc='+$("#mc_search").val()+'&qx='+$("#qx_search").val()+'&wrylx='+$("#wrylx_search").val()+'&updateTime='+$("#updateDate_search").val()+'&wryzl='+$("#wryzl_search").val());
    }
</script>

</html>