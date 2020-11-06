/*****=======================================index系列使用的js******************************/
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
//获取时间格式化(cutDay为往前几天，0为当天)
function getNowDate(cutDay) {
    var d = new Date();
    var nowDateTime = d.getTime() - cutDay * 60000 * 60 * 24;
    d.setTime(nowDateTime);
    var year = d.getFullYear();
    var month = d.getMonth() + 1;
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    var date = d.getDate();
    if (date >= 0 && date <= 9) {
        date = "0" + date;
    }
    var hours = d.getHours();
    if (hours >= 0 && hours <= 9) {
        hours = "0" + hours;
    }
    var minutes = d.getMinutes();
    if (minutes >= 0 && minutes <= 9) {
        minutes = "0" + minutes;
    }
    var seconds = d.getSeconds();
    if (seconds >= 0 && seconds <= 9) {
        seconds = "0" + seconds;
    }
    var currentdate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
    return currentdate;
}
//图表数据插入
/**********===========charts图表就是getId的chart,title标题,xAxis x轴数据 series显示的柱状图数值 colorList对应的颜色factor对应的因子=============================**********/
function setCharts(charts, title, xAxis, series, colorList,factor) {
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
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}

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
                    formatter: function (value,index) {//格式化文本标签
                        return (index+1)+'\n'+value.split(",")[0].split('').join('\n');
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
            name: factor,
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
}