<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>实时监测-省数据分析-大气环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
    <!-- tabs 标签页 -->
    <div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
        <!-- 标签页——1 -->
        <div title="省实时监测" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar1">
                    <!-- 搜索栏 -->
                    <div id="searchBar1" class="searchBar">
                        <form id="searchForm">
                            <div class="inline-block" >
                                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'post',
									editable:false,
									valueField:'uuid',
						          textField:'name',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getPointListByType?pointType=0',
									method:'post',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">污染因子:</label>
                                <div class="selectBox-container" style="width:200px;">
                                    <a href="javascript:void(0)"
                                       class="easyui-linkbutton select-button btn-orange">因子选择</a>
                                    <div class="select-panel">
                                        <div class="easyui-panel" title="污染物"
                                             style="width:560px;height:200px;padding:10px;"
                                             data-options="footer:'#ft',tools:'#tt'">
                                            <div id="selectGrop">
                                                <!--复选框-->

                                                <!--复选框 over-->
                                            </div>
                                        </div>
                                        <div id="tt">
                                            <label class="form-checkbox">
                                                <input name="type" type="checkbox" value="" class="all" checked="checked"/>
                                                <span class="lbl">全选</span>
                                            </label>
                                        </div>
                                        <div class="tr" id="ft">
                                            <button type="button" id="cfm" class="btnSure btn-blue l-btn">确定</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary"
                               data-options="iconCls:'icon-search'"
                               onclick="doCx('')">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset('')">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->
                    <!-- 操作栏-->
                    <div class="optionBar">
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('')">导出数据</a>
                    </div>
                    <!-- 操作栏 over-->
                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="jcsj"></span>
                            </div>

                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title" >AQI排名前三</div>
                                <div class="cell-content" id="frontRank" style="height: 35px">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名后三</div>
                                <div class="cell-content" id="leanback" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->

                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group" class="radio-button-group style-btn-group">
                            <span class="active" id="hour">时</span>
                            <span id="day">日</span>
                            <span id="month">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                    </div>

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       url="${request.contextPath}/environment/debriefing/list"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="monitorTime" width="190px" formatter="jcsjFormat">监测时间</th>
                        <th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区</th>
                        <th field="pointName" width="170px" formatter="Ams.tooltipFormat">监测站点</th>
                        <!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
                        <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
                        <th field="aqi" width="160px" id="AQI" styler="Ams.setAQIBackground">AQI</th>
                        <th field="pm25" width="160px" id="PM2.5" id="" formatter="Ams.tooltipFormat">PM2.5(μg/m3)</th>
                        <th field="pm10" width="160px" id="PM10" formatter="Ams.tooltipFormat">PM10(μg/m3)</th>
                        <th field="so2" width="160px" id="SO2" formatter="Ams.tooltipFormat">SO2(μg/m3)</th>
                        <th field="no2" width="160px" id="NO2" formatter="Ams.tooltipFormat">NO2(μg/m3)</th>
                        <th field="o38" width="160px" id="O3" formatter="Ams.tooltipFormat">O3(μg/m3)</th>
                        <th field="co" width="160px" id="CO" formatter="Ams.tooltipFormat">CO(mg/m3)</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->
        <div title="自建实时监测" style="padding:10px">
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar2">
                    <!-- 搜索栏 -->
                    <div id="searchBar2" class="searchBar">
                        <form id="searchForm2">
                            <div style="display: none">
                                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName2"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'post',
									editable:false,
									valueField:'uuid',
						          textField:'name',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName2"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getPointListByType?pointType=2',
									method:'post',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime2" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime2" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">污染因子:</label>
                                <div class="selectBox-container" style="width:200px;">
                                    <a href="javascript:void(0)"
                                       class="easyui-linkbutton select-button btn-orange">因子选择</a>
                                    <div class="select-panel">
                                        <div class="easyui-panel" title="污染物"
                                             style="width:560px;height:200px;padding:10px;"
                                             data-options="footer:'#ft2',tools:'#tt2'">
                                            <div id="selectGrop2">
                                                <!--复选框-->

                                                <!--复选框 over-->
                                            </div>
                                        </div>
                                        <div id="tt2">
                                            <label class="form-checkbox">
                                                <input name="type" type="checkbox" value="" class="all" checked="checked"/>
                                                <span class="lbl">全选</span>
                                            </label>
                                        </div>
                                        <div class="tr" id="ft2">
                                            <button type="button" id="cfm2" class="btnSure btn-blue l-btn">确定</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary"
                               data-options="iconCls:'icon-search'"
                               onclick="doCx('2')">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset('2')">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->
                    <!-- 操作栏-->
                    <div class="optionBar">
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('2')">导出数据</a>
                    </div>
                    <!-- 操作栏 over-->
                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="jcsj2"></span>
                            </div>

                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名前三</div>
                                <div class="cell-content" id="frontRank2" style="height: 35px">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名后三</div>
                                <div class="cell-content" id="leanback2" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->

                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group2" class="radio-button-group style-btn-group">
                            <span class="active" id="hour">时</span>
                            <span id="day">日</span>
                            <span id="month">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                    </div>

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
                       url="${request.contextPath}/environment/debriefing/list"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="monitorTime" width="190px" formatter="jcsjFormat2">监测时间</th>
                        <th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区</th>
                        <th field="pointName" width="170px" formatter="Ams.tooltipFormat">监测站点</th>
                        <!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
                        <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
                        <th field="aqi" width="160px" styler="Ams.setAQIBackground">AQI</th>
                        <th field="pm25" width="160px" id="" formatter="Ams.tooltipFormat">PM2.5(μg/m3)</th>
                        <th field="pm10" width="160px" formatter="Ams.tooltipFormat">PM10(μg/m3)</th>
                        <th field="so2" width="160px" formatter="Ams.tooltipFormat">SO2(μg/m3)</th>
                        <th field="no2" width="160px" formatter="Ams.tooltipFormat">NO2(μg/m3)</th>
                        <th field="o38" width="160px" formatter="Ams.tooltipFormat">O3(μg/m3)</th>
                        <th field="co" width="160px" formatter="Ams.tooltipFormat">CO(mg/m3)</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
        </div>
        <!-- 标签页——2 over-->


    </div>
    <!-- tabs 标签页 over -->

</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            $('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            $('#startTime2').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime2').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            doCx('');
        });
    };
    var pointCode = '';
    var flag = 'hour';
    var flag2 = 'hour';
    var pointType = '0';
    var url = '/enviromonit/airHourData/list';
    var url2 = '/enviromonit/airHourData/list';
    var title ='省数据分析-气省实时监测（小时）数据==>';
    var title2 ='省数据分析-气自建实时监测（小时）数据==>';
    var aqiText = '';
    var jcTime = startTime + " 00:00:00~" + endTime + " 23:59:59";
    var jcTime2 = startTime + " 00:00:00~" + endTime + " 23:59:59";
    $(function () {
        setJcyz();
        /*因子选择*/
        $('body').on('click', '#cfm', function () {
            var $target = $(this).parents(".select-panel");
            $target.removeClass('show');
            $target.off("change.selectAll", ".all");
            //获取选中的值
            var $chenckbox = $("#selectGrop").find(".form-checkbox");
            var nub = $chenckbox.length; // 获取checkbox 个数
            for (var i = 0; i < nub; i++) {
                if ($chenckbox.eq(i).find("input").is(':checked')) {
                    showColumn($chenckbox[i].innerText);
                } else {
                    hideColumn($chenckbox[i].innerText);
                }
            }
        });
        /*因子选择*/
        $('body').on('click', '#cfm2', function () {
            var $target = $(this).parents(".select-panel");
            $target.removeClass('show');
            $target.off("change.selectAll", ".all");
            //获取选中的值
            var $chenckbox = $("#selectGrop2").find(".form-checkbox");
            var nub = $chenckbox.length; // 获取checkbox 个数
            for (var i = 0; i < nub; i++) {
                if ($chenckbox.eq(i).find("input").is(':checked')) {
                    showColumn($chenckbox[i].innerText);
                } else {
                    hideColumn($chenckbox[i].innerText);
                }
            }
        });


        $('body').on('click', '.select-button', function () {
            var $target = $(this).next();
            $target.addClass('show');
            $target.on("change.selectAll", ".all", function () {
                if ($(this).prop("checked")) {
                    $target.find('input[name=' + $(this).prop("name") + ']').prop("checked", true);
                } else {
                    $target.find('input[name=' + $(this).prop("name") + ']').prop("checked", false);
                }

            });
        });
        /*单选按钮组*/
        $("#group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).context.id == 'hour') {
                flag = 'hour';
                url = '/enviromonit/airHourData/list';
                title = '省数据分析-气省实时监测（小时）数据==>'+aqiText;
                jcTime = startTime + " 00:00:00~" + endTime + " 23:59:59";
            }
            if ($(this).context.id == 'day') {
                flag = 'day';
                url = '/enviromonit/airDayData/list';
                title = '省数据分析-气省实时监测（日）数据==>'+aqiText;
                jcTime = startTime + "~" + endTime;
            }
            if ($(this).context.id == 'month') {
                flag = 'month';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气省实时监测（月）数据==>'+aqiText;
                jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if ($(this).context.id == 'year') {
                flag = 'year';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气省实时监测（年）数据==>'+aqiText;
                jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
            }
            doCx('');
        });

        /*单选按钮组*/
        $("#group2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).context.id == 'hour') {
                flag2 = 'hour';
                url2 = '/enviromonit/airHourData/list';
                title2 = '省数据分析-气自建实时监测（小时）数据==>'+aqiText;
                jcTime2 = startTime + " 00:00:00~" + endTime + " 23:59:59";
            }
            if ($(this).context.id == 'day') {
                flag2 = 'day';
                url2 = '/enviromonit/airDayData/list';
                title2 = '省数据分析-气自建实时监测（日）数据==>'+aqiText;
                jcTime2 = startTime + "~" + endTime;
            }
            if ($(this).context.id == 'month') {
                flag2 = 'month';
                url2 = '/enviromonit/airHourData/listMonth';
                title2 = '省数据分析-气自建实时监测（月）数据==>'+aqiText;
                jcTime2 = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if ($(this).context.id == 'year') {
                flag2 = 'year';
                url2 = '/enviromonit/airHourData/listMonth';
                title2 = '省数据分析-气自建实时监测（年）数据==>'+aqiText;
                jcTime2 = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
            }
            doCx('2');
        });

        /**
         * 显示列
         */
        function showColumn(val) {
            if (val == 'PM2.5') val = 'PM25';
            if (val == 'O3') val = 'O38';
            if (pointType == '0') {
                $('#dg').datagrid('showColumn', val.toString().toLowerCase());
            } else {
                $('#dg2').datagrid('showColumn', val.toString().toLowerCase());
            }

        }

        /**
         * 隐藏列
         */
        function hideColumn(val) {
            if (val == 'PM2.5') val = 'PM25';
            if (val == 'O3') val = 'O38';
            if (pointType == '0') {
                $('#dg').datagrid('hideColumn', val.toString().toLowerCase());
            } else {
                $('#dg2').datagrid('hideColumn', val.toString().toLowerCase());
            }
        }

        /**/
        $("#tabs").tabs({
            onSelect: function (title, index) {
                if (index == 0) {
                    pointType = '0';
                    doCx('');
                }
                if (index == 1) {
                    pointType = '2';
                    doCx('2');
                }
            }
        });
    });

    /**
     * 重置按钮
     */
    function doReset(idx) {
        $("#searchForm" + idx).form('clear');
        $('#startTime' + idx).datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
        $('#endTime' + idx).datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
        doCx(idx);
    }


    /**
     * 查询按钮
     */
    var startTime = '';
    var endTime = '';
    function doCx(idx) {

       startTime = $("#startTime" + idx).val().trim();
       endTime = $("#endTime" + idx).val().trim();
        if (startTime == "" || endTime == "") {
            $.messager.alert('提示', '时间区间不允许为空！');
            return;
        }
        var a = flag;
        var b = url;
        var time = jcTime;
        setJcsj();
        if (idx == '2') {
            a = flag2;
            b = url2;
            time = jcTime2;
        }
        time = setJcsj(a);
        if(time.indexOf('defined')>-1) time = startTime + ' 00:00:00~' + endTime + ' 23:59:59';
        $('#jcsj' + idx).text(time);
        if (Ams.isNoEmpty(startTime) && Ams.isNoEmpty(endTime)) {
            $('#dg' + idx).datagrid({
                url: Ams.ctxPath + b,
                queryParams: {
                    pointCode: $("#pointName" + idx).val().trim(),
                    codeRegion: $("#regionName" + idx).val().trim(),
                    pointType: pointType,
                    startTime: startTime,
                    endTime: endTime,
                    flag: a
                }
            });
        }

        listAqiRank(startTime,endTime,idx,pointType,a,'front',null);////AQI排名前三的数据;
        listAqiRank(startTime,endTime,idx,pointType,a,'leanback',null);////AQI排名后三的数据;
    }

    function setJcsj(flag) {
        switch (flag) {
            case 'hour':
                return startTime + " 00:00:00~" + endTime + " 23:59:59";
                break;
            case 'day':
                return startTime + "~" + endTime;
                break;
            case 'month':
                return startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
                break;
            case 'year':
                return startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
                break;
            default:
                return startTime + " 00:00:00~" + endTime + " 23:59:59";
                break;
        }
    }

    /**
     *
     * 检测因子赋值
     */
    function setJcyz() {
        $.ajax({
            type: "POST",
            url: Ams.ctxPath + "/enviromonit/airDataService/getSixFactor",
            async: true,
            success: function (data) {
                var h = '';
                for (var i = 0; i < data.length; i++) {
                    h += '<label class="form-checkbox">';
                    h += '<input name="type" type="checkbox" value="' + data[i].key + '" checked="checked"/>';
                    h += '<span class="lbl">' + data[i].text + '</span>';
                    h += '</label>';
                }
                $('#selectGrop div').remove();
                $('#selectGrop').append(h);
                $('#selectGrop2 div').remove();
                $('#selectGrop2').append(h);

            }
        });

    }

    function jcsjFormat(value) {
        if (flag == 'hour') {
            return Ams.timeDateFormat(value);
        }
        if (flag == 'day') {
            return Ams.stdDateFormat(value);
        }
        if (flag == 'month') {
            return Ams.dateMonthFormat(value);
        }
        if (flag == 'year') {
            return Ams.dateYearFormat(value);
        }
    }
     function jcsjFormat2(value) {
        if (flag2 == 'hour') {
            return Ams.timeDateFormat(value);
        }
        if (flag2 == 'day') {
            return Ams.stdDateFormat(value);
        }
        if (flag2 == 'month') {
            return Ams.dateMonthFormat(value);
        }
        if (flag2 == 'year') {
            return Ams.dateYearFormat(value);
        }
    }

     function listAqiRank(startTime, endTime,idx,pointType,timeType,sort,callBack) {
        $.ajax({
            url: Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getAQIDataRank",
            type: "POST",
            dataType: 'json',
            data: {
                startTime: startTime,
                endTime: endTime,
                timeType:timeType,
                pointType:pointType,
                sort: sort

            },
            success: function (data) {
                getAQISpanRow(data,sort,idx);
                if (callBack != null) {
                    callBack.call();
                }
            }
        })

    }

    function getAQISpanRow(data,sort,idx) {

        if (sort == "front") {
            $("#frontRank" + idx).empty();
        } else {
            $("#leanback" + idx).empty();
        }
        var newRow = "";
        var text = '';
        for (var i = 0; i < data.length; i++) {
            if (i==3){
                break;
            }
            newRow += '<div class="inline-block"><div class="inline-block">';
            newRow += '<span> ' + data[i].pointName + ':</span>';
            newRow += '<span class="em"> ' + Ams.formatNum(data[i].aqi) + '</span>';
            newRow += '</div>';
            newRow += '<div class="inline-block"><span>首污:</span>';
            newRow += '<span class="em"> ' + (data[i].major).replace("pm25", "pm2.5") + '</span></div></div>';
            text += data[i].pointName + '：' +data[i].aqi + '，首污:' + (data[i].major).replace("pm25", "pm2.5")+"；";
        }
        if (sort == "front") {
            $("#frontRank" + idx).append(newRow);
            aqiText += 'AQI排名前三【' + text + '】';
        } else {
            $("#leanback" + idx).append(newRow);
            aqiText += 'AQI排名后三【' + text + '】';
        }
    }

    /**
     * 导出省控数据excel
     */
    function exportExlPro(idx){

        var regionName = $("#regionName"+idx).val().trim();
        var pointName = $("#pointName"+idx).val().trim();
        var startTime= $("#startTime"+idx).val().trim();
        var endTime = $("#endTime"+idx).val().trim();
        var u = url;
        var f = flag;
        var tle = title+aqiText;
        if (idx==2) {
            u = url2;
            f = flag2;
            tle = title2+aqiText;
        }
        aqiText = '';
        listAqiRank(startTime,endTime,idx,pointType,f,'front',exportExl(u,regionName,pointName,startTime,endTime,f,tle));////AQI排名前三的数据;
        listAqiRank(startTime,endTime,idx,pointType,f,'leanback',exportExl(u,regionName,pointName,startTime,endTime,f,tle));////AQI排名后三的数据;

    }

    function exportExl(u,regionName,pointName,startTime,endTime,f,tle){
        window.location.href = u + "?datatype=2&codeRegion=" + regionName + "&pointCode=" + pointName + "&startTime=" + startTime + "&endTime=" + endTime + "&pointType="
            + pointType + "&flag=" + f + "&exportExl=exportExl" + "&exportTitle=" + tle;
    }

</script>
</html>