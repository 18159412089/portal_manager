var preUrl = "/environment/waterDataShow";
var pictorialBarChart6;
var affectReachData;//影响达标流域;
var reachData;//达标数据;
var reduceData;//不生反降数据
var raiseData;//小河流域达标(提升数据)
var allSameScale;//所有的流域的同比数据
var allAVGLevel;//所有的流域的同比数据


$(function () {
    getRiverScale();
    notReachStandardRiver();
    ReduceQualityRiver();
    pictorialBarChart6 = echarts.init(document.getElementById('pictorialBarChart6'));
    reachRequstQualityData();
    getReachRiver();
    affectReachRequstQualityData();
    getReduceRiverData();
    getAllAVGLevel();
    getAllRiverScale();
})

function getRiverScale() {
    $.ajax({
        data: {},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/ReachStandardScale",
        success: function (data) {
            var scale = (data.message * 100).toFixed(2);
            $("#completeTargetText").html('<span><span class="em">完成情况：</span>小河流域Ⅰ～Ⅲ类水质比例达' + scale + '%以上</span>');
            $("#riverTargetReachTo").text("小河流域Ⅰ～Ⅲ类水质比例达" + scale + " %以上");
            $("#reachScale").text("小流域断面Ⅰ～Ⅲ类水质比例达" + scale + " %以上")
            if (scale < 76.4) {
                $("#target_text").text('未达考核目标');
                $("#target_text").addClass("alone-font")
            } else {
                $("#target_text").text('已达到考核目标');
                $("#target_text").removeClass("alone-font")
            }
            setPictorialBarChart6(scale);
        },
        dataType: 'json'
    })
}


function setPictorialBarChart6(a) {
    var pictorialBarOption6 = {
        grid: pictorialBarGrid,
        yAxis: pictorialBarYAxis,
        xAxis: pictorialBarXAxis,
        series: [
            {
                name: '小河流域-完成情况',
                type: 'pictorialBar',
                barGap: 0,
                label: labelSetting,
                barWidth: '100%',
                symbol: 'rect',
                symbolSize: [2, '100%'],
                symbolMargin: '150%',
                symbolRepeat: true,
                itemStyle: {
                    normal: {
                        color: '#ff6262',
                    }
                },
                data: [a]
            }, fullBgBar


        ],
    };
    pictorialBarChart6.setOption(pictorialBarOption6);
}

/**
 * 未达标流域
 * 数据
 */
function notReachStandardRiver() {
    $.ajax({
        data: {},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/NotReachStandardRiver",
        success: function (data) {
            var h='';
            var cla ;
            var length =data.length;
            //如果没有未达标的就显示一个圆圈都达标
            if (length == 0) {
                setXlyData();
                return;
            }
            var colxs='col-xs-4';
            if(length==1)colxs='col-xs-12';
            if(length==2)colxs='col-xs-6';
            if(length==3)colxs='col-xs-4';
            for (var i = 0; i < length; i++) {
                if (i==3) break;
                if (i==0){
                    cla = 'basin-name-container circle-3 yellow';
                }
                if (i==1){
                    cla = 'basin-name-container circle-3 blue';
                }
                if (i==2){
                    cla = 'basin-name-container circle-3 purple';
                }
                h+='<div class="'+colxs+'">';
                h+='<div class="'+cla+'">';
                h += '<div class="basin-bg">';
                h += '<div class="bg-img bg-1"></div>';
                h += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
                h += '</div>';
                h += '<div class="basin-text-box">';
                h += '<div class="basin-text">';
                h += '<div class="area"></div>';
                h += '<div class="name" style="cursor:pointer" onclick="clickMiniRiverBasin(\''+data[i].split("-")[1]+'\')">' +data[i].split("-")[0]+ '</div>';
                h += '</div>';
                h += '</div>';
                h += '</div>';
                h += '</div>';
            }
            $("#yxdbly div").remove();
            $('#yxdbly').append(h);
        },
        dataType: 'json'
    })
}

/**
 * 如果没有未达标的断面则显示都已达标
 */
function setXlyData(){
    var h = '';
    h+='<div class="col-xs-12">';
    h+='<div class="basin-name-container circle-3 red">';
    h+='<div class="basin-bg">';
    h+='<div class="bg-img bg-1"></div>';
    h+='<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
    h+='</div>';
    h+='<div class="basin-text-box">';
    h+='<div class="basin-text">';
    h+='<div class="area"></div>';
    h+='<div class="name">都已达标</div>';
    h+='</div>';
    h+='</div>';
    h+='</div>';
    h+='</div>';
    $("#bsfj div").remove();
    $('#bsfj').append(h);
}


/**
 * 不升反降流域
 * @constructor
 */
function ReduceQualityRiver() {
    $.ajax({
        data: {},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/ReduceQualityRiver",
        success: function (data) {
            var h='';
            var cla ;
            var length =data.length;
            //如果没有未达标的就显示一个圆圈都达标
            if (length == 0) {
                setXlyData();
                return;
            }
            var colxs='col-xs-4';
            if(length==1)colxs='col-xs-12';
            if(length==2)colxs='col-xs-6';
            if(length==3)colxs='col-xs-4';
            for (var i = 0; i < data.length; i++) {
                if (i==3) break;
                if (i==0){
                    cla = 'basin-name-container circle-3 red';
                }
                if (i==1){
                    cla = 'basin-name-container circle-3 orange';
                }
                if (i==2){
                    cla = 'basin-name-container circle-3 green';
                }
                h+='<div class="'+colxs+'">';
                h+='<div class="'+cla+'">';
                h+='<div class="basin-bg">';
                h+='<div class="bg-img bg-1"></div>';
                h+='<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
                h+='</div>';
                h+='<div class="basin-text-box">';
                h+='<div class="basin-text">';
                h+='<div class="area"></div>';
                h+='<div class="name" style=" cursor: pointer;" onclick="clickMiniRiverBasin(\''+data[i].basinCode+'\')">'+data[i].basinName+'</div>';
                h+='</div>';
                h+='</div>';
                h+='</div>';
                h+='</div>';
            }
            $("#bsfj div").remove();
            $('#bsfj').append(h);
        },
        dataType: 'json'
    })
}

/*****
 * 这个是达标流域名称详情就是说
 * 达标流域的名称
 * 获取达标的流域每个月的情况
 *
 * */
function reachRequstQualityData() {
    $.ajax({
        data: {},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/ReachRequstQuality",
        success: function (data) {
            reachData = data;
        },
        dataType: 'json'
    })
}

function reachRequstQuality() {
    getdataMonth(reachData, 1)
}

/*****
 * 未达标流域的详情
 * 根据名称获取未达标的流域的名称
 * */
function affectReachRequstQualityData() {

    $.ajax({
        data: {"category": 1},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/AffectReachRequstQuality",
        success: function (data) {
            affectReachData = data;
        },
        dataType: 'json'
    })
}

function affectReachRequstQuality() {
    getdataMonth(affectReachData, 1)
}

/* 获取不升反降的流域数据详情*/

function getReduceRiverData() {
    $.ajax({
        data: {"category": 1},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/ReduceQualityRiverDetail",
        success: function (data) {
            reduceData = data;
        },
        dataType: 'json'
    })
}

function getReduceRiver() {
    getdataMonth(reduceData, 2);
}

/****
 * 获取不升反降的反面的数据详情
 * 上升的或者不生不降得数据
 * @param data
 */
function getReachRiver() {
    $.ajax({
        data: {},
        type: "POST",
        url: Ams.ctxPath + preUrl + "/ReachQualityRiverDetail",
        success: function (data) {
            raiseData = data;
        },
        dataType: 'json'
    })
}

function getReachRiverData() {
    getdataMonth(raiseData, 2)
}

function getdataMonth(data, status) {
    if (status == 1) {
        $('#dmxqbtid').text('小河流域详情');
    } else {
        $('#dmxqbtid').text('小河流域不升反降情况');
    }
    var newRow = "";
    $("#pjhtml").empty();
    var scaleData;
    var avgData;
    var sameScaleImg
    for (var i=0;i<data.length;i++){
        for (var key in data[i]) {
            scaleData = allSameScale[key] == null ? 0 : allSameScale[key];
            avgData = allAVGLevel[key] == null ? "Ⅲ" : allAVGLevel[key];

            newRow += '<div class="item">';
            newRow += "<h5><span>" + key + "</span><a     class='details-open' onclick='setRiverDataDetail(\"" + key + "\")'>详情</a></h5>";
            newRow += '<div class="item-info">';

            if (scaleData == null || scaleData < 0) {
                sameScaleImg = '<img src="/static/images/new-popup/drop-icon.png">';
            } else {
                sameScaleImg = '<img src="/static/images/new-popup/rise-icon.png">';
            }
            newRow += '<div class="average-tag"><span>目标：Ⅲ </span><span>2019年均值：' + avgData + '</span><span>同比:' + scaleData+sameScaleImg + '</span></div>';
            newRow += '<div class="month-data">';
            newRow += getDataRiver(data[i][key]);
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
        }
    }

    $("#pjhtml").html(newRow);

}

function getDataRiver(mapData) {
    var newRow = "";
    var month = new Array();
    for (var key in mapData) {
        month.push(key);
    }
    for (var i = 1; i <= 12; i++) {
        if (month.join(",").indexOf(i) != -1) {
            newRow += '<div  class="' + Ams.formatBgclByWtQuality(mapData[i].replace("类", "")) + '">';
            newRow += '<span>' + i + '月</span>';
            newRow += '<span>' + mapData[i].replace("类", "") + '</span>';
            newRow += '</div>';
        } else {
            newRow += '<div class="month-item">';
            newRow += '<span>' + i + '月</span>';
            newRow += '<span>-</span>';
            newRow += '</div>';
        }
    }

    return newRow;
}

/**
 * 小河流域断面年平均值显示
 * 现在显示的是一个月中的最大的那一个的数据
 */
function getYearRiverData() {
    $.ajax({
        url: Ams.ctxPath + preUrl + "/RiverYearAVGData",
        type: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            riverYearAVGData(data);
        }
    })


}

/**
 *  为小河流域详情赋值
 */
function riverYearAVGData(dataRglMap) {
    var h = "";
    for (var i = 0; i < dataRglMap.length; i++) {
        var dataMap = dataRglMap[i];
        h += '<div class="item">'
        h += '<div class="' + Ams.formatRglBg(dataMap.resultQuality) + '">'
        h += '<div class="home-border-panel-bg">'
        h += '<div class="bg-top-left"></div>'
        h += '<div class="bg-top-center"></div>'
        h += '<div class="bg-top-right"></div>'
        h += '<div class="bg-center-left"></div>'
        h += '<div class="bg-center-center"></div>'
        h += '<div class="bg-center-right"></div>'
        h += '<div class="bg-bottom-right"></div>'
        h += '<div class="bg-bottom-center"></div>'
        h += '<div class="bg-bottom-left"></div>'
        h += '</div>'
        h += '<div class="home-border-panel-bg active ani">'
        h += '<div class="bg-top-left"></div>'
        h += '<div class="bg-top-center"></div>'
        h += '<div class="bg-top-right"></div>'
        h += '<div class="bg-center-left"></div>'
        h += '<div class="bg-center-center"></div>'
        h += '<div class="bg-center-right"></div>'
        h += '<div class="bg-bottom-right"></div>'
        h += '<div class="bg-bottom-center"></div>'
        h += '<div class="bg-bottom-left"></div>'
        h += '</div>'
        h += '<div class="home-border-panel-body">'
        h += '<div class="target-text-box">'
        h += '<div class="target-text">'
        h += '<div class="area">' + dataMap.basinName + '</div>'
        h += '<div class="name">' + dataMap.resultQuality + '</div>'
        h += '</div>						'
        h += '</div>		'
        h += '</div>'
        h += '</div>'
        h += '</div>'
        if (i == 7) {
            break;
        }
    }
    $("#rglid div:gt(1)").remove();
    $('#rglid').append(h);
    aniTargetManager();
}

function setRiverDataDetail(riverName) {
    $("#detail_pointName").text(riverName + "详情")
    $(".details-water").css("display", "flex");
    layui.use(['layer', 'element', 'table'], function () { //添加layui模块：弹出层、tab选项卡、数据表格
        var layer = layui.layer
            , element = layui.element
            , table = layui.table;
        //数据表格
        table.render({
            elem: '#water-table'
            , theme: '#31882d'
            , url: Ams.ctxPath + '/environment/waterDataShow/RiverQualityDetail'
            , where: {
                'basinName': riverName,
            }
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                //,count:20//数据总数
                , limit: 12 //每页显示的条数
                , groups: 5 //只显示 5 个连续页码
                , first: false //不显示首页
                , last: false //不显示尾页
                , count: 100 //总页数
                , theme: '#31882d'
                //,skip: true //开启跳页
                , jump: function (obj, first) {
                    if (!first) {
                        layer.msg('第' + obj.curr + '页', {offset: 'b'});
                    }
                }
            }
            , cols: [[
                {
                    field: 'yearNumber',
                    width: '10%',
                    title: '年',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                },
                {
                    field: 'monthNumber',
                    width: '10%',
                    title: '月',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {
                    field: 'basinName',
                    width: '10%',
                    title: '小流域',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {
                    field: 'targetQuality',
                    width: '10%',
                    title: '目标水质',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {
                    field: 'resultQuality',
                    width: '10%',
                    title: '检测水质',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {field: 'zlValue', width: '10%', title: 'PH', style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                , {
                    field: 'rjyValue',
                    width: '10%',
                    title: '溶解氧',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {
                    field: 'gmsyValue',
                    width: '10%',
                    title: '高锰酸盐指数',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {
                    field: 'andanValue',
                    width: '10%',
                    title: '氨氮',
                    style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'
                }
                , {field: 'zlValue', width: '10%', title: '总磷', style: 'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#08260b', 'color': '#fff'});
            }

            // ,data:[]
        });
    });
}

/**
 * 获取一条河流的平均值
 */
function getYearAVGQualityOneRiver(basinName) {
    var strRiverQuality;
    $.ajax({
        url: Ams.ctxPath + preUrl + "/OneRiverYearAVGQuality",
        type: "POST",
        async: false,
        data: {"basinName": basinName},
        dataType: "json",
        success: function (data) {
            strRiverQuality = data.qualityLevel;
        }

    })
    return strRiverQuality;
}

function getNewRiverData() {
    $.ajax({
        url: Ams.ctxPath + preUrl + "/GetNewRiverDataQuality",
        type: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            riverYearAVGData(data);
        }

    })
}

/**
 * 获取同比
 */
function getSameScale(basinName) {
    var strRiverQuality;
    $.ajax({
        url: Ams.ctxPath + preUrl + "/SameScaleCompareToLastYear",
        type: "POST",
        async: false,
        data: {"basinName": basinName},
        dataType: "json",
        success: function (data) {
            strRiverQuality = data.resultScale;
        }

    })
    return strRiverQuality;
}

function aniTargetManager() {
    /*--------------------定时动画--------------------------*/
    $("#targetManage .ani").each(function (index) {
        var $t = $(this);
        var el = $t.get(0);
        var animationEvent = whichAnimationEvent(el);
        animationEvent && el.addEventListener(animationEvent, function () {
            $t.removeClass("ani-flash1");
        });
        setTimeout(function () {
            $t.addClass("ani-flash1");
        }, 1000 * index);
        var myVar = setInterval(function () {
            setTimeout(function () {
                $t.addClass("ani-flash1");
            }, 1000 * index);
        }, 8000);
    });
}

/***
 * 获取不升反降比例
 */
function getScaleReduceRiver() {
    $.ajax({
        url: Ams.ctxPath + preUrl + "/ReduceQualityRiverScale",
        type: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            var dataStr = data.message * 10000 / 100;
            setPictorialBarChart6(dataStr)
            $("#completeTargetText").html('<span><span class="em">完成情况：</span>不升反降小流域达' + dataStr + '%以上</span>');
        }

    })
}
//获取所有的小河流域的同比
function getAllRiverScale() {
    $.ajax({
        url: Ams.ctxPath + preUrl + "/GetAllRiverScale",
        type: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            allSameScale = data;
        }

    })
}

function getAllAVGLevel() {
    $.ajax({
        url: Ams.ctxPath + preUrl + "/GetAllAVGLevel",
        type: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            allAVGLevel = data;
        }
    })
}
function clickMiniRiverBasin(basinCode){
    window.open("/enviromonit/water/nationalSurfaceWater?pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369&basinCode="+basinCode);
}