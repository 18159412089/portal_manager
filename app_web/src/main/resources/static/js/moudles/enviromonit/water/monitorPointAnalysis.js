var waterPointBar = echarts.init(document.getElementById('waterPointBar'));
//var waterFactorChart = echarts.init(document.getElementById('waterFactorChart'));
var pointCode;

// 微型自动监测站名称
function miniMonitorSearch() {
    $('#miniMonitorDg').datagrid('load', {
        pointName: $("#pointNameQuery").val().trim()
    });
}

//鼠标回车事件
Ams.inputText_enterKeyEvent('pointNameQuery',miniMonitorSearch);

//点位详情信息
function getMnPointInfo(info) {

    $.ajax({
        type : "post",
        url : '/enviromonit/water/nationalSurfaceWater/getPolluteList',
        async : true,
        data : {
            pointCode : info.mn,
            monitorTime : info.datatime,
        },
        success: function (result) {
//			if(info.mnname=="上坂"){
//				var html = '<a href="/static/js/moudles/enviromonit/water/恒坑流域机场附近违规建筑拆除情况.pdf" target="_blank">恒坑流域机场附近违规建筑拆除情况</a>'
//					+' &nbsp;&nbsp;&nbsp;<a href="/static/js/moudles/enviromonit/water/内河一日一巡逻成效.pdf" target="_blank">内河一日一巡逻成效</a>'
//					+' &nbsp;&nbsp;&nbsp;<a href="/static/js/moudles/enviromonit/water/上坂整治方案——内河.pdf" target="_blank">上坂整治方案——内河</a>'
//				document.getElementById('pdfView').innerHTML = html;
//			}else if(info.mnname=="恒坑污水处理厂站"){
//				var html = '<a href="/static/js/moudles/enviromonit/water/恒坑支流巡河照片.pdf" target="_blank">恒坑支流巡河照片</a>';
//				document.getElementById('pdfView').innerHTML = html;
//			} else {
//				document.getElementById('pdfView').innerHTML = '';
//			}
            var jsonary = "";
            document.getElementById('pointName').innerHTML = info.mnname;
            document.getElementById('monitorTime').innerHTML = info.datatime;
            var category = "国控";
            var target = levelChange(info.pointQuality);
            var resultQuality = levelChange(info.resultQuality);
            var resultColor = "black";
            if (info.category == 2) {
                category = "省控";
            } else if (info.category == 3) {
                category = "市控";
            }

            if ((resultQuality == "Ⅳ" || resultQuality == "Ⅴ" || resultQuality == "劣Ⅴ") && resultQuality != target) {
                resultColor = "red";
            }
            if (info.category == 3) {
                document.getElementById('pointInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
                    + '<span>纬度：' + info.lat + '</span><span>流域：' + info.rivername + '</span>'
                    + '<span>控制级别：' + category + '</span>'
                    + '<span style="color:' + resultColor + '">综合水质评价：' + resultQuality + '</span>';
            } else {
                document.getElementById('pointInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
                    + '<span>纬度：' + info.lat + '</span><span>流域：' + info.rivername + '</span>'
                    + '<span>控制级别：' + category + '</span><span>目标水质：' + target + '</span>'
                    + '<span style="color:' + resultColor + '">综合水质评价：' + resultQuality + '</span>';
            }

            var tableHtml = "<tr><td class='tit'>因子名称</td><td class='tit'>数值</td><td class='tit'>级别</td></tr>";
            if (info.excessfactorstr != "") {
                jsonary = JSON.parse(info.excessfactorstr);
            }
            if (result.data != null) {
                var polluteAry = result.data;
                for (var i = 0; i < polluteAry.length; i++) {
                    if (JSON.stringify(jsonary).toUpperCase().indexOf(polluteAry[i].code.toUpperCase()) > 0) {
                        for (var j = 0; j < jsonary.length; j++) {
                            if (polluteAry[i].code.toUpperCase() == jsonary[j].codePollute.toUpperCase()) {
                                var quality = levelChange(jsonary[j].resultQuality);
                                var color = "black";
                                if (jsonary[j].isExcess) {
                                    color = "red";
                                }
                                tableHtml += "<tr><td class='con'>" + jsonary[j].polluteName + "</td>"
                                    + "<td class='con' style ='color:" + color + "'>" + jsonary[j].polluteValue + "</td>"
                                    + "<td class='con' style ='color:" + color + "'>" + quality + "</td></tr>";
                            }
                        }
                    } else {
                        tableHtml += "<tr><td class='con'>" + polluteAry[i].name + "</td>"
                            + "<td class='con'>" + polluteAry[i].value + "</td>"
                            + "<td class='con'>-</td></tr>";
                    }
                }
            }

            document.getElementById('pointTableInfo').innerHTML = tableHtml;
        },
        error: function (jqXHR, textStatus, errorThrown) {
        },
        dataType : 'json'
    });



}

/*function getMnPointInfo2(info) {

	$.ajax({
		type : 'POST',
		url : '/enviromonit/water/nationalSurfaceWater/getPointInfo',
		async : true,
		data : {
			mn : info.mn,
			dateTime : info.datatime
		},
		success : function(data) {
			document.getElementById('pointName2').innerHTML = info.mnname;
			var category ="国控";
			var target = levelChange(info.pointQuality);
			var resultQuality = levelChange(info.resultQuality);
			var resultColor = "black";
			if(info.category == 2)
				category ="省控";
			if((resultQuality== "Ⅳ"||resultQuality=="Ⅴ"||resultQuality=="劣Ⅴ") && resultQuality!=target){
				resultColor = "red";
			}
			document.getElementById('pointInfo2').innerHTML = '<span>经度：' + info.lng + '</span>'
					+ '<span>纬度：' + info.lat + '</span><span>流域：' + info.rivername + '</span>'
					+ '<span>控制级别：' + category + '</span><span>目标水质：' + target + '</span>'
					+ '<span style="color:'+resultColor+'">综合水质评价：' + resultQuality + '</span>';
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}*/

function play(mongoid) {
    $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
    //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
    $('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
}

var myVideo = document.getElementById("video");//获取video对象
// 关闭视频后关闭声音
$("#videoDlg").dialog({
    onClose: function () {
        myVideo.pause();
    }
});


//获取水质站点各因子的数据分析趋势图
function searchWaterPointBar() {
    var pointCodes = selectedPointInfo.mn;
    var check_val = [];
    var obj = document.getElementsByName("cb_mnname");
    for (k in obj) {
        if (obj[k].checked)
            check_val.push(obj[k].value);
    }
    if (check_val != "")
        pointCodes += "," + check_val;
    $.ajax({
        type : "post",
        url : '/enviromonit/water/nationalSurfaceWater/getTrendChart',
        async : true,
        data : {
            mn : pointCodes,
            hours : $('#timeList span.active').attr('value'),
            polluteCode : $('#polluteCodeList span.active').attr('value')
        },
        success : function(result) {
            setWaterPointBar(result.legend, result.xAxis, result.series,result.legendBar,result.min,result.color);
        },
        error : function(jqXHR, textStatus, errorThrown) {
        },
        dataType : 'json'
    });
}

//近一年各因子超标次数
function getFactorCount() {
    $.ajax({
        type : "post",
        url : '/enviromonit/water/nationalSurfaceWater/getFactorCount',
        async : true,
        data : {
            mn : selectedPointInfo.mn
        },
        success : function(result) {
            setFactorCount(result.names, result.values)
        },
        error : function(jqXHR, textStatus, errorThrown) {
        },
        dataType : 'json'
    });
}

//绘制水质站点各因子的数据分析趋势图
function setWaterPointBar(points, dateTime, seriesData, legendBar, min, color) {
    waterPointBar.clear();
    var waterPointBarOption = {
        color:color,
        title : {
            text : $('#polluteCodeList span.active').text() + $('#polluteCodeList span.active').attr('unit'),
            subtext : '',
            textStyle : {
                fontSize : 16,
                color : '#000000'
            },
            left : '50%',
            top : '10'
        },
        textStyle : {
            color : '#000000'
        },
        tooltip : {
            trigger : 'axis',
            axisPointer : { // 坐标轴指示器，坐标轴触发有效
                type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        toolbox : {
            show : true,
            orient : 'vertical',
            left : '20',
            top : '40%',
            iconStyle : {
                borderColor : '#000000'
            },
            feature : {
                magicType : {
                    show : true,
                    type : [ 'bar', 'line' ]
                },
                saveAsImage : {
                    show : true
                },
                restore : {
                    show : true
                }
            }
        },
        legend : [
            {
                orient: 'vertical',
                left:'5',
                data:legendBar
            },
            {
                orient: 'vertical',
                right:'0',
                data:points
            }
        ],
        grid : {
            top : '80',
            left : '70',
            right : '38',
            bottom : '10',
            containLabel : true
        },
        xAxis : {
            type : 'category',
            axisLabel : {
                type : 'category'
            },
            data : dateTime
        },
        yAxis : {
            type : 'value',
            min: min
        },
        series : seriesData,
    };

    waterPointBar.setOption(waterPointBarOption);

}

//近一年各因子超标次数
function setFactorCount(names, values) {

    var waterFactorChartOption = {
        title : {
            text : ' 近一年各因子超标次数',
            textStyle : {
                fontSize : 16,
                color : '#000000'
            },
            left : '10',
            top : '10'
        },
        textStyle : {
            color : '#000000'
        },
        tooltip : {
            trigger : 'axis',
            axisPointer : { // 坐标轴指示器，坐标轴触发有效
                type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        toolbox : {
            show : true,
            right : '30',
            top : '8%',
            iconStyle : {
                borderColor : '#000000'
            },
            feature : {
                saveAsImage : {
                    show : true
                }
            }
        },
        grid: {
            top: '80',
            left: '10',
            right: '30',
            bottom: '10',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            axisLabel: {
                type: 'category',
                interval: 0,
                rotate: 30,
            },
            data: names
        },
        yAxis: {
            type: 'value',
        },
        series: [{
            name: '超标次数',
            type: 'bar',
            stack: 'one',
            barWidth: '50%',
            itemStyle: {
                normal: {
                    color: '#65b149',
                }
            },
            data: values
        }

        ],
    };

    waterFactorChart.setOption(waterFactorChartOption);
}

function levelChange(str) {
    var result = "-";
    if (str == "FIRSR") {
        result = "Ⅰ";
    } else if (str == "SECOND") {
        result = "Ⅱ";
    } else if (str == "THIRD") {
        result = "Ⅲ ";
    } else if (str == "FOURTH") {
        result = "Ⅳ";
    } else if (str == "FIFTH") {
        result = "Ⅴ";
    } else if (str == "OTHER") {
        result = "劣Ⅴ";
    }
    return result;
}

function addMoreData() {
    var category = selectedPointInfo.category;
    var pointCode = selectedPointInfo.mn;
    var pid = $('#pid').val();
    if (category == "1") {
        $("#moreData a").attr("href", "/enviromonit/water/nationalSurfaceWater/index?pid="+pid+"&pointCode=" + pointCode);
    } else if (category == "2") {
        $("#moreData a").attr("href", "/enviromonit/water/wtHourData/index?pid="+pid+"&pointCode=" + pointCode);
    } else if (category == "3") {
        $("#moreData a").attr("href", "/enviromonit/water/wtCityHourData/index?pid="+pid+"&pointCode=" + pointCode);
    }
    $("#attach a").attr("href", "/environment/waterAttachment/index?pid="+pid+"&pointCode=" + pointCode);
    console.log(selectedPointInfo.mn);
}

function getWaterMonitorAttachement(pcode) {
    pointCode=pcode;
    //按名称搜索附件时使用
    $('#attachmentIdDg').datagrid({
        url: '/environment/waterAttachment/list',
        queryParams: {
            pointCode:pcode,
            isShow:"1",
            enable:"1",
            showDetail:"show"
        }
    });

    $("#attachmentIdDg").datagrid('getPager').pagination({
        showPageList: false,
        showRefresh: false,
        layout: ['first', 'prev', 'links', 'next', 'last']
    });
    $("#attachmentIdDg").datagrid('resize');
}
function operation(value,row){
        if (row.type == 3) {
            return '<div class="link-box"><a class=\'look-tag\' href="javascript:onClick= play(\''+row.mongoid+'\')" target="_blank" ><span class="icon iconcustom look-icon"></span>查看</a><a href="/environment/waterAttachment/downloadFile/'+row.mongoid+'/'+row.type+'"><span class="icon iconcustom"></span>下载</a></div>';
        } else {
            return '<div class="link-box"><a  class=\'look-tag\' href="/environment/waterAttachment/download/'+row.mongoid+'/'+row.type+'" target="_blank"><span class="icon iconcustom look-icon"></span>查看</a><a href="/environment/waterAttachment/downloadFile/'+row.mongoid+'/'+row.type+'"><span class="icon iconcustom"></span>下载</a></div>';
        }
}
function getPointAttachentName(value,row){
    console.log(row)
    var imgSrc='/static/images/file-pdf.png';
    if (row.type==3){
        imgSrc = '/static/images/file-ppt.png';
    }
    return '<div class="table-font"> <i><img src='+imgSrc+'></i><span style="color: black;font-size: 12px">'+row.name+'</span></div>';

}
//通过名称查找附件
function findAttachmentByName(){
       if ($("#attachementName").val()==undefined ||$("#attachementName").val()==null||$("#attachementName").val()==''){
           getWaterMonitorAttachement(pointCode);
           return;
       }
        $('#attachmentIdDg').datagrid({
            url: '/environment/waterAttachment/findAttachementByName',
            queryParams: {
                pointCode:pointCode,
                attachementName:$("#attachementName").val()
            }
        });
        $("#attachmentIdDg").show();
        $("#attachmentIdDg").datagrid('getPager').pagination({
            showPageList: false,
            showRefresh: false,
            layout: ['first', 'prev', 'links', 'next', 'last']
        });
        $("#attachmentIdDg").datagrid('resize');
}

//鼠标回车事件
$('#attachementName').textbox({
    inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
        keyup: function(event){
            if(event.keyCode == 13) {
                findAttachmentByName();
                $("#attachementName").next('span').find('input').focus();//获取焦点
            }
        }})
});