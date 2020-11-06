<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染源大地图</title>
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
        <div class="map-reduction-box" style="z-index: 106">
            <span> <i class="icon iconcustom icon-shuaxin1"></i>还原</span>
        </div>

        <#--显示弹窗按钮-->
        <div class="map-common-but show-info-tag" style="z-index: 106" id="showBtn">
            <span> <i class="icon iconcustom icon-xiangqing2"></i>更新记录</span>
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
                    <p id="dateTime" style="text-align: left">截止2019年9月9日排查</p>
                </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul">
                        <#include "/moudles/pollution/analysisDiv.ftl">
                        <li class="item">
                            <div class="personnel-parent">
                                <span>大气环境污染源</span>
                                <i id="countPollutionARINum"></i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced " id="gyfsqy">
                                                    <span><img src="${request.contextPath}/static/images/VOCs-icon.png"></span>
                                                    VOCs企业(26)
                                                </div>
                                                <div class="change-line no-choice  choiced" id="wxszzdz">
                                                    <span><img src="${request.contextPath}/static/images/gjyqy-icon.png"></span>
                                                    高架源企业(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="xly">
                                                    <span><img src="${request.contextPath}/static/images/slwqy-icon.png"></span>
                                                    散乱污企业(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="fdlydy">
                                                    <span><img src="${request.contextPath}/static/images/fdlydy-icon.png"></span>
                                                    非道路移动源(26)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>水环境污染源</span>
                                <i id="countPollution"></i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content" id="pollutionData">
                                                <div class="change-line no-choice  choiced" id="wsclc">
                                                    <span><img src="${request.contextPath}/static/images/ssgyqy-icon.png"></span>
                                                    涉水工业企业(26)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent  ">
                                <span>土壤环境污染源</span>
                                <i id="countTR"></i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced" id="fqpk">
                                                    <span><img src="${request.contextPath}/static/images/gyfq-icon.png"></span>工业固废(0)
                                                </div>
                                                <div class="change-line no-choice choiced" id="gd">
                                                    <span><img src="${request.contextPath}/static/images/gywxfw-icon.png"></span>工业危险废物(0)
                                                </div>
                                                <div class="change-line no-choice choiced" id="sghfc">
                                                    <span><img src="${request.contextPath}/static/images/sghfc-icon.png"></span>三格化粪池(0)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent  ">
                                <span>海洋生态污染源</span>
                                <i id="countHY"></i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice  choiced" id="cgpk">
                                                    <span><img src="${request.contextPath}/static/images/hypk.png"></span>
                                                    海洋排污口(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="sk">
                                                    <span><img src="${request.contextPath}/static/images/hygygtfw-icon.png"></span>
                                                    涉海工业固废(12)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent  ">
                                <span>生态环境污染源</span>
                                <i id="countST"></i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced" id="gyfqqy">
                                                    <span><img src="${request.contextPath}/static/images/stwry-icon.png"></span>持证矿山(0)
                                                </div>
                                                <div class="change-line no-choice choiced" id="sbc">
                                                    <span><img src="${request.contextPath}/static/images/ybgy-icon.png"></span>石板材行业(0)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <#include "/moudles/pollution/searchDiv.ftl">
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
    </div>
</div>


<#------污染源数据更新弹窗------------->
<div  class="new-popup-body">
    <div class="popup-center-container">
        <div class="title-head">
            <span class="tex22">污染源数据更新</span>
            <div class="close-popup-tag">
                <i class="icon iconcustom icon-shanchu3 "></i>
            </div>
        </div>
        <div class="info-data-box">

            <div class="info-head">
                <span class="left-tex" id="updTimeRange">上周末及时更新污染源数据</span>

                <div class="inline-block" >
                    <label class="textbox-label textbox-label-before" title="时间" style="float: left;line-height: 34px">查询时间:</label>
                    <input id="weekBox" type="text" class="layui-input laydate-test"  AUTOCOMPLETE="OFF" placeholder="选择时间查询" data-type="date" style="width:156px;float: left;">
                </div>
                <div class="state-tab">
                    <a onclick="showSetDlg()">短信接收人员配置</a>
                    <a onclick="showUpd('upd')">已更新</a>
                    <a onclick="showUpd('unUpd')" class="red-but">未更新</a>
                </div>
            </div>

            <div class="table-content">
                <div class="easyui-table-light">
                    <table id="updTable" class="easyui-datagrid"
                           style="width: 100%;height:370px;"
                           data-options="
							            rownumbers:true,
                                        singleSelect:true,
                                        striped:true,
                                        autoRowHeight:true,
                                        fitColumns:true,
                                        fit:false,
                                        pagination:true,
                                        pageSize:10,
                                        pageList:[10,20,50,100,10000]">
                        <thead>
                        <tr>
                            <th field="entryDepartment" width="220px"  style="text-align: center"> <span class="tex-center">责任单位</span></th>
                            <th field="lxrLxfs" width="220px"  style="text-align: center" ><span class="tex-center">联系方式</span></th>
                            <th field="updateTime" width="200px" formatter="Ams.timeDateFormat"  style="text-align: center"><span class="tex-center">更新时间</span></th>
                            <th field="status" width="200px" formatter="changeColor"  style="text-align: center" ><span class="tex-center">状态</span></th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  视频弹窗 -->
<div id="setDlg" class="easyui-dialog" style="width:800px;height:500px;"
     data-options="closed:true,modal:true,border:'thin'">
    <div class="table-content">
        <div class="easyui-table-light">
            <table id="telTable" class="easyui-datagrid"
                   style="width: 100%;height:450px;"
                   url="${request.contextPath}/env/pollution/getSendPhoneList"
                   data-options="
							            rownumbers:true,
                                        singleSelect:true,
                                        striped:true,
                                        autoRowHeight:true,
                                        fitColumns:true,
                                        fit:false,
                                        pagination:true,
                                        pageSize:10,
                                        pageList:[10,20,50,100]">
                <thead>
                <tr>
                    <th field="name" width="220px"  style="text-align: center" > <span class="tex-center">名称</span></th>
                    <th field="phone" width="220px"  style="text-align: center" ><span class="tex-center">联系方式</span></th>
                    <th field="operate" width="200px" formatter ="setPhone" style="text-align: center"><span class="tex-center">操作</span></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<#include "/moudles/pollution/pollutionDetail.ftl">
</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\pollutionInfo2_new.js"></script>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#weekBox', //指定元素
            btns: ['clear', 'now'],
            value: Ams.getTime(0),
            ready: function() {
                $(".layui-laydate-content table tr td:nth-child(1)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(3)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(4)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(5)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(6)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(7)").addClass('laydate-disabled')
            },
            change: function() {
                $(".layui-laydate-content table tr td:nth-child(1)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(3)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(4)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(5)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(6)").addClass('laydate-disabled')
                $(".layui-laydate-content table tr td:nth-child(7)").addClass('laydate-disabled');
            },
            done: function(value, date, endDate){
                doCx(value,'');
                var d = new Date(Number(date.year),(Number(date.month)-1),Number(date.date));
                d.setDate(d.getDate()-7);
                var year = d.getFullYear();
                var month = d.getMonth() + 1;
                //返回星期几的某一天;
                var day = d.getDay();
                sDate = year + "-" + (month < 10 ? ('0' + month) : month) + "-" + (day < 10 ? ('0' + day) : day);
                $("#updTimeRange").text(sDate+"至"+value+"更新记录");
            }
        });
    });

    /**
     * 跳转到视频图片上传界面
     */
    function setPhone(value,row){
        return "<div>" + Ams.setImageSet() + "<a href='#' class='easyui-linkbutton' onClick=\"setting('"
                + row.uuid + "','" + (row.phone==null?'':row.phone) + "')\">新增/编辑联系方式</a></div>";
    }
    <#------污染源数据更新弹窗关闭事件------------->
    $(".close-popup-tag").click(function () {
        $(".new-popup-body").hide();
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/env/pollution/noShowAgain',
            success: function (result) {
            },
            dataType: 'json'
        });
    })

    // ---弹窗显示事件
    $(".show-info-tag").click(function () {
        $(".new-popup-body").show()
        doCx($('#weekBox').val(),'');
    })

    function doCx(time,flag) {
        $('#updTable').datagrid({
            url: "/env/pollution/showUpdOrUnUpdList",
            queryParams: {
                time: time,
                flag: flag
            },
            view: Ams.easyuiEmptyView(),
            emptyMsg: '当前日期没有数据，请选择固定每周一查看未更新数据'
        })
    }

    $(document).ready(function (){
        $(".new-popup-body").hide();
        $("#showBtn").hide();

        //判断是否查看过，问未查看则显示
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/env/pollution/checkShowAgain',
            success: function (result) {
                if (result.flag) {
                    $(".new-popup-body").show();
                    doCx(Ams.getTime(0),'');
                }
                if (result.userid == 'fda12a0e-dcf2-472f-991a-b42246c9a7ca' || result.userid == '9a928e41-955c-4fe3-a352-bf1144a4f64a'){
                    $("#showBtn").show();
                }
            },
            dataType: 'json'
        });
    });

    function changeColor(value,row,index){
        if (value == '已更新') {
            return "<span class=\"tex-center tex2\" title='" + value + "'>" + value + "</span>";
        } else {
            return "<span class=\"tex-center tex1\" title='" + value + "'>" + value + "</span>";
        }
    };

    function showUpd(flag){
        doCx($('#weekBox').val(),flag);
    }

    function showSetDlg(){
        $('#setDlg').dialog('open').dialog('center').dialog('setTitle', '修改联系人联系方式');
    }

    function setting(uuid,phone){
        var title = '多个号码格式：138*****,181*****';
        layer.prompt({title: title, formType: 2, value: phone},
            function (pass, index) {
                var phs = pass.replace(/，/g,",").split(",");
                for (var i = 0; i < phs.length; i++) {
                    if (!Ams.isNoEmpty(phs[i]) || !/^(?:13\d|15\d|17\d|18\d)-?\d{5}(\d{3}|\*{3})$/.test(phs[i])) {
                        layer.msg('手机号码为空或手机号码格式不正确');
                        return;
                    }
                }
                layer.close(index);
                $.ajax({
                    type: "POST",
                    url: Ams.ctxPath + '/env/pollution/setPhone',
                    dataType: 'json',
                    data: {
                        phone: pass,
                        uuid: uuid
                    },
                    success: function () {
                        layer.msg('操作成功');
                        $('#telTable').datagrid('reload');
                    },
                    error: function () {
                        layer.msg('操作成功');
                        $('#telTable').datagrid('reload');
                    }

                });
            });
    }
</script>

</html>
