<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>环保督察-销号概况</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
    <script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
</head>
<!-- body -->
<body class="wrap-color">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>
        <#include "/supervisionMenu.ftl">
    <#else>
        <#include "/inputSupervisionMenu.ftl">
    </#if>-->
<#include "/secondToolbar.ftl">
<style type="text/css">
   .tips-font{
       position: inherit!important;
       margin-left: 3%;
   }
    html{
        min-width: 100%;
    }

</style>
<input type="hidden" id="authority" value="${authority!}">
<div id="myPrint" class="container hbdc_yl">
    <!-- 内容 -->
    <div class="data-display-container yl-data-display-container" >
        <div class="title" >
            <span id="title">环保督察销号概况</span>
            <a id="printImg" onclick="Ams.doPrint('myPrint')" class="printing-button" >
                <span class="icon iconcustom yl_print" /></span> 打印
            </a>
            <a id="exportImg" onclick="Ams.exportPdfById('myPrint','漳州市环保督察销号概况')" class="printing-button">
                <span class="icon iconcustom icon-PDFwenjian yl_print"></span> 导出PDF
            </a>
            <div class="sub-content">
                <!-- 时间控件 -->
				
            </div>
        </div>
		<div>
           <#-- <label class="control-label">查询时间：</label>
            <input id="queryStartTime" type="text" class="layui-input" style="display: inline-block; width: 156px; height: 33px;" readonly="">
            <span>-</span>
            <input id="queryEndTime" type="text" class="layui-input" style="display: inline-block; width: 156px; height: 33px;" readonly="" >-->
            <input name="queryStartTime" id="queryStartTime" class="easyui-combobox"
                   data-options="
                                        editable:false,
                                        url:'${request.contextPath}/environment/rectifition/getNumOfRound?flag=xhgk',
                                        valueField:'id',
                                        textField:'name',
                                        onLoadSuccess: function (data) {
                                            if (Ams.isNoEmpty(data)&&data) {
                                               $('#queryStartTime').combobox('setValue',data[0].id);//选择后台查出来的第一个值
                                            }
                                        }
                                        " label="" style="width:250px;">
            </input>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
        </div>

        <div class="data-charts yl-data-charts" >
            <div class="xhgk-left-box">
                <div class="data-font">
                    <span>总体情况数据分析</span>
                </div>
                <div id="dataCharts" style="width:100%;height: 700px;;"></div>
            </div>
            <div class="right-box dataPieCharts-right">
                <div class="data-font">
                    <span>总体情况数据分析</span>
                </div>
                <div id="dataPieCharts" style="width:100%;height: 700px;float:left;"></div>
                <div class="describe information-text" id="information">
                </div>
            </div>
            &nbsp;

        </div>
        &nbsp;
    </div>
    <!-- 引入底部文字提示 main  必须放在这个大的div里面，否则打印的时候不会显示-->
    <#include "/moudles/debriefing/tips-font.ftl"/>
</div>



    <!-- 弹窗 -->
    <div id="dlg" class="easyui-dialog" style="width:800px; min-height:280px;"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <div class="easyui-tabs easyui-tabs-bg" style="height:100%">
            <div style="padding:10px">
                <div class="easyui-layout" fit=true>
                    <table id="dgDescription" class="easyui-datagrid" style="width:100%;height:auto;"
                           data-options="
                        rownumbers:true,
                        singleSelect:true,
                        striped:true,
                        autoRowHeight:true,
                        fitColumns:true,
                        fit:true,
                        pagination:true,
                        pageSize:10,
                        pageList:[10,20,50]">
                        <thead>
                        <tr>
                            <th field="name" width="120px" formatter="Ams.tooltipFormat">描述</th>
                            <th field="opera" width="50px" data-options="formatter:operation">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div style="padding:10px">
                <div class="easyui-layout" fit=true>
                    <table id="dgDetail" class="easyui-datagrid" style="width:100%;"
                           data-options="
                        rownumbers:true,
                        singleSelect:true,
                        striped:true,
                        autoRowHeight:true,
                        fitColumns:true,
                        fit:true,
                        pagination:true,
                        pageSize:10,
                        pageList:[10,20,50]">
                        <thead>
                        <tr>
                            <th field="schedule" width="120px" formatter="Ams.tooltipFormat">整改进度</th>
                            <th field="countyActualTime" width="120px" formatter="timeEdit">实际县级验收时间</th>
                            <th field="cityActualTime" width="120px" formatter="timeEdit">实际市级验收时间</th>
                            <th field="professionActualTime" width="120px" formatter="timeEdit">实际提交行业验收时间</th>
                            <th field="professionExamineTime" width="120px" formatter="timeEdit">完成行业审查时间</th>
                        </tr>
                        </thead>
                    </table>

                </div>
            </div>
            <div style="padding:10px">
                <div class="easyui-layout" fit=true>
                    <table id="dgDescriptionAll" class="easyui-datagrid" style="width:100%;height:auto;"
                           data-options="
                        rownumbers:true,
                        singleSelect:true,
                        striped:true,
                        autoRowHeight:true,
                        fitColumns:true,
                        fit:true,
                        pagination:true,
                        pageSize:10,
                        pageList:[10,20,50]">
                        <thead>
                        <tr>
                            <th field="name" width="80px" formatter="Ams.tooltipFormat">项目</th>
                            <th field="describe" width="80px" formatter="Ams.tooltipFormat">描述</th>
                            <th field="opera" width="50px" data-options="formatter:operation">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:onClick=close()" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">关闭</a>
    </div>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">

   /* layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年月选择器
		var date=new Date();
		var year = date.getFullYear();
		var initYear = year;
		var endYear = year;
		
		var startTime = laydate.render({
			elem: '#queryStartTime',
			type: 'month',
			format: 'yyyy-M',
			max: getNowDate(0)+"-01",
			showBottom: false,
			ready: function(date){
				initYear=date.year;
			},
			change: function(value, date, endDate){
				var selectYear = date.year; 
				var differ = selectYear-initYear; 
				if (differ == 0) { 
					if($(".layui-laydate").length){ 
						$("#queryStartTime").val(value); 
						$(".layui-laydate").remove(); 
					}
				} 
				initYear = selectYear;
				if($("#queryStartTime").val()==value){
					var d2 = new Date();
					endTime.config.max = {
						year: d2.getFullYear(),
						month: d2.getMonth(),
						date: date.date
					};
					endTime.config.min = {
							year: date.year,
							month: date.month-1,
							date: date.date
					}
				}
		  	}
		});
		//年月选择器
		var endTime = laydate.render({
			elem: '#queryEndTime',
			type: 'month',
			format: 'yyyy-M',
			value: date,
            //max: getNowDate(0)+"-01",
            min: getNowDate(30)+"-01",
			showBottom: false,
			ready: function(date){
				endYear=date.year;
			},
			change: function(value, date, endDate){
				var selectYear = date.year; 
				var differ = selectYear-endYear; 
				if (differ == 0) { 
					if($(".layui-laydate").length){
					    //设置起始时间的最大值
                        startTime.config.max = {
                            year: date.year,
                            month: date.month-1,
                            date: date.date
                        }
						$("#queryEndTime").val(value); 
						$(".layui-laydate").remove(); 
					} 
				} 
				endYear = selectYear;
		  	}
		});
		
	});*/

        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
                // var d = new Date();
                // $('#queryStartTime').val(d.getFullYear() + '-1');
        		// $('#queryEndTime').val(getNowDate(0));
        		doSearch();
            });
        };

        var dataCharts = echarts.init(document.getElementById('dataCharts'));
        var dataPieCharts = echarts.init(document.getElementById('dataPieCharts'));
        var nameValue = "";
        var labelOption = {
            normal: {
                show: true,
                formatter: function (value) {
                    if (value.name.indexOf(",") > -1) {
                        nameValue = value.name;
                    }
                    var i = 0;
                    if (value.seriesName == "完成县级验收") {
                        i = Number(1);
                    } else if (value.seriesName == "完成市级验收") {
                        i = Number(2);
                    } else if (value.seriesName == "提交行业审查") {
                        i = Number(3);
                    } else if (value.seriesName == "完成行业审核") {
                        i = Number(4);
                    }
                    var temp = nameValue.split(",")[i];
                    if (temp) {
                        return value.seriesName.split("").join("\n") + "\n" + temp + "\n个";
                    }
                },
                fontSize: 14,
                color: 'white',
                rich: {
                    name: {
                        textBorderColor: '#000000'
                    }
                }
            }
        };

    window.onresize = function() {
        $('#dataCharts').width('100%');
        $('#dataPieCharts').width('100%');
        dataCharts.resize();
        dataPieCharts.resize();
    }
    var startTime ='2019';
    var endTime ='2019';
        function doSearch(){
            startTime = $('#queryStartTime').combobox('getValue');
            endTime = startTime;
        	getData();
        }

        function getData() {
        	/*var startTime = $("#queryStartTime").val();
    		var endTime = $("#queryEndTime").val();
    		if (!Ams.isNoEmpty(endTime)||!Ams.isNoEmpty(startTime)){
                Ams.alert('提示信息', '时间区间不能为空！');
                return;
    		}*/
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/envCancellationAccount/getEcharts',
                async: true,
                data: {
                    startTime: startTime,
                    endTime: endTime
                },
                success: function (data) {
                    $('#title').text((Ams.isNoEmpty(data.qx)==true?data.qx:'漳州市')+'环保督察销号概况')
                    var remark = "截至 <span style=\"'color:ffffoo'\">"+startTime+" 年，"
                            + "已完成整改销号问题 <span style=\"'color:ffffoo'\">" + data.finishAll + "</span> 个,"
                            + "完成县级验收 <span style=\"'color:ffffoo'\">" + data.xys + "</span> 个,"
                            + "完成市级验收 <span style=\"'color:ffffoo'\">" + data.sys + "</span> 个,"
                            + "提交行业审查 <span style=\"'color:ffffoo'\">" + data.hysc + "</span> 个,"
                            + "完成行业审查 <span style=\"'color:ffffoo'\">" + data.wcsh + "</span> 个。";
                    $("#information").html(remark);
                    setDataPieChart(data.xys, data.sys, data.hysc, data.wcsh);
                    setDataCharts(data.xAxisData, data.seriesData.split(','));
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    airChart.hideLoading();
                },
                dataType: 'json'
            });
        }

        function setDataCharts(xAxisData, seriesData) {
            var dataChartsOption = {
                //title : {
                //    text: '某站点用户访问来源',
                //    subtext: '纯属虚构',
                //    x:'center'
                //},
//                toolbox: {
//                    show : true,
//                    feature : {
//                        mark : {show: true},
//                        dataView : {show: true, readOnly: false},
//                        magicType : {show: true, type: ['line', 'bar']},
//                        restore : {show: true},
//                        saveAsImage : {show: true}
//                    }
//                },

                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: ''
                    },
                    formatter: function (params) {
                        var htmlStr = '<div>';
                        htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                        for (var i = 0; i < params.length; i++) {
//                            var j = 0;
//                            if (params[i].seriesName == "完成县级验收") {
//                                j = Number(1);
//                            } else if (params[i].seriesName == "完成市级验收") {
//                                j = Number(2);
//                            } else if (params[i].seriesName == "提交行业审查") {
//                                j = Number(3);
//                            } else if (params[i].seriesName == "完成行业审核") {
//                                j = Number(4);
//                            }
                            var text ;
                            var s = Number(params[i].data);
                            switch(s){
                                case 0:text="";
                                    break;
                                case 1:text="完成县级验收";
                                    break;
                                case 2:text="完成市级验收";
                                    break;
                                case 3:text="提交行业审查";
                                    break;
                                case 4:text="完成行业审查";
                                    break;
                            }
                            htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[i].color + ';"></span>';
                            htmlStr += text + '<br/>';
                        }
                        htmlStr += '</div>';
                        return htmlStr;
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        data: xAxisData,
                        //data : ['微矿库整改,1,2,3,4', '东山森林公园,6,6,7,8', '垃圾渗滤液,9,10,11,1211', '微矿库整改,13,14,15,1611'],
                        triggerEvent: true,
                        axisLabel: {
                            type: 'category',
                            interval: 0,
                            // rotate:20,
                            // formatter: function (value) {
                            //     value = value.split(",")[0];
                            //     return value;
                            // },
                            formatter:function(value)
                            {
                                return value.split(",")[0].split('').join('\n');
                            },
                            textStyle: {
                                fontSize: 15      //更改坐标轴文字大小
                            }
                        },
                        axisTick: {
                            alignWithLabel: false
                        }
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        splitNumber: 4,
                        max: 4,
                        axisLabel: {
                            formatter: function (value) {
                                var text = value;
                                switch (value) {
                                    case 0:
                                        text = " ";
                                        break;
                                    case 1:
                                        text = "完成县级验收";
                                        break;
                                    case 2:
                                        text = "完成市级验收";
                                        break;
                                    case 3:
                                        text = "提交行业审查";
                                        break;
                                    case 4:
                                        text = "完成行业审核";
                                        break;
                                }

                                return text;
                            },
                            textStyle: {
                                fontSize: 15      //更改坐标轴文字大小
                            }
                        }
                    }
                ],
                series: [
                    {
                        name: {
                            normal: {
                                formatter: function (params) {
                                    var status = Number(params.value);
                                    if (status == 0) {
                                        return "";
                                    } else if (status == 1) {
                                        return "完成县级验收";
                                    } else if (status == 2) {
                                        return "完成市级验收";
                                    } else if (status == 3) {
                                        return "提交行业审查";
                                    } else if (status == 4) {
                                        return "完成行业审查";
                                    }
                                }

                            }
                        },
                        type: 'bar',
                        barWidth: '15%',
                        barMaxWidth: 30,
                        barMinWidth: 30,
                        stack: 'one',
                        color: ['#65B149'],
                        //label: labelOption,
                        data: seriesData,
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    var status = Number(params.value);
                                    if (status == 0 ) {
                                        return "#FE8463";
                                    } else if (status == 1) {
                                        return "#65b149";
                                    }else if (status == 2 ) {
                                        return "#ffbf26";
                                    }else if (status == 3) {
                                        return "#884FA9";
                                    }else if (status == 4 ) {
                                        return "#51a1fa";
                                    }
                                }

                            }
                        }


                    }
//                    {
//                        name: '完成市级验收',
//                        type: 'bar',
//                        barWidth: '50%',
//                        barMaxWidth: 30,
//                        barMinWidth: 30,
//                        stack: 'one',
//                        color: ['#FFBF26'],
//                        label: labelOption,
//                        data: seriesData
//                    },
//                    {
//                        name: '提交行业审查',
//                        type: 'bar',
//                        barWidth: '50%',
//                        barMaxWidth: 30,
//                        barMinWidth: 30,
//                        stack: 'one',
//                        color: ['#FF6317'],
//                        label: labelOption,
//                        data: seriesData
//                    },
//                    {
//                        name: '完成行业审核',
//                        type: 'bar',
//                        barWidth: '50%',
//                        barMaxWidth: 30,
//                        barMinWidth: 30,
//                        stack: 'one',
//                        color: ['#51A1FA'],
//                        label: labelOption,
//                        data: seriesData
//                    }
                ]
            };
            dataCharts.off('click');
            dataCharts.on('click', function (params) {
                //x轴点击
                var id ;
                var name;
                var st;
                //点击横轴项目名称显示详情
                if(params.componentType == "xAxis"){
                    id = params.value.split(",")[1];
                    name = params.value.split(",")[0];
                    getDecription(id, name, st);
                }else{
                    id = params.name.split(",")[1];
                    name = params.name.split(",")[0];
//                    status = params.seriesName;
                    getDecription(id, name, st);
                }
            });
            dataCharts.setOption(dataChartsOption);
        }

        function setDataPieChart(xys, sys, hysc, wcsh) {
            var dataPieChartsOption = {
                //title : {
                //    text: '某站点用户访问来源',
                //    subtext: '纯属虚构',
                //    x:'center'
                //},
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c}"
                },
                legend: {
                    orient: 'horizontal',
                    top: '0',
                    left: 'center',
                    data: ['完成县级验收', '完成市级验收', '提交行业审查', '完成行业审核']
                },
                series: [
                    {
                        name: '已完成个数',
                        type: 'pie',
                        radius: '45%',
                        center: ['50%', '50%'],
                        label: {
                            formatter: '{b}:\n{c} 个',
                            textStyle: {
                                fontSize: 14    //文字的字体大小
                            },
                        },
                        data: [
                            {value: xys, name: '完成县级验收', itemStyle:{color: '#65B149'}},
                            {value: sys, name: '完成市级验收', itemStyle:{color: '#FFBF26'}},
                            {value: hysc, name: '提交行业审查', itemStyle:{color: '#884FA9'}},
                            {value: wcsh, name: '完成行业审核', itemStyle:{color: '#51A1FA'}},
                        ],
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            dataPieCharts.off('click');
            dataPieCharts.on('click', function (params) {
                var name = params.name;
                var value = params.value;
                getDecriptionAll(name, value);
            });
            dataPieCharts.setOption(dataPieChartsOption);
        }

        var flag = 0;
        var f = 0;

        function operation(val, row, index) {
            var id = row.uuid;
            var html = "<div>"+Ams.setImageSee()+"<a href='javascript:onClick=showDescribe(\"" + id + "\")' class='easyui-linkbutton'>查看</a></div>"
            return html
        }

        //点击柱状图打开窗口
        function getDecription(id, name, status) {
            f = 1;
            $('#dlg').dialog('open').dialog('center');
            $(".tabs-header li").eq(0).click();
            $(".tabs-header .tabs-wrap").hide();
            $('#dgDescription').datagrid({
                url: "${request.contextPath}/environment/envCancellationAccount/getDecription?id=" + id + "&status=" + status,
                onLoadSuccess: function (data) {
                    var data = $('#dgDescription').datagrid('getData');
                    $('#dlg').dialog('setTitle', name);
                }
            });

        }

        //点击饼图打开窗口
        function getDecriptionAll(name, value) {
            f = 2;
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', name + " " + value + " 个 ");
            $(".tabs-header li").eq(2).click();
            $(".tabs-header .tabs-wrap").hide();
            // var startTime = $("#queryStartTime").val();
            // var endTime = $("#queryEndTime").val();
            $('#dgDescriptionAll').datagrid({
                url: "${request.contextPath}/environment/envCancellationAccount/getDecriptionAll?status=" + name + "&startTime=" + startTime + "&endTime=" + endTime
            });
        }


      
        //获取描述的详情
        function showDescribe(id) {
            $(".tabs-header li").eq(1).click();
            $('#dgDetail').datagrid({
                url: "${request.contextPath}/environment/envCancellationAccount/getDetail?id=" + id,
            });
            $("#dlg-buttons a").text("返回");
            flag = 1;
        }

        function close() {
            if (flag == 1) {
                if (f == 2) {
                    $(".tabs-header li").eq(2).click();
                    $("#dlg-buttons a").text("关闭");
                    flag = 0;
                } else if (f == 1) {
                    $(".tabs-header li").eq(0).click();
                    $("#dlg-buttons a").text("关闭");
                    flag = 0;
                }

            } else if (flag == 0) {
                $('#dlg').dialog('close');
            }
        }

        function timeEdit(value, row, index) {
            var temp = Ams.dateFormat(value, 'yyyy-MM-dd');
            if (value == "") {
                return "暂未设置时间";
            } else {
                return temp;
            }
        }
      //获取时间格式化(cutDay为往前几天，0为当天)
    	function getNowDate(cutDay) {
    		var d = new Date();
    		var nowDateTime = d.getTime() - cutDay*60000*60*24;
    		d.setTime(nowDateTime);
    		var year = d.getFullYear();
    		var month = d.getMonth()+1;
    		var date = d.getDate();
    		var currentdate = year+"-"+month;
    	    return currentdate;
    	}
    </script>

</div>
</body>

</html>