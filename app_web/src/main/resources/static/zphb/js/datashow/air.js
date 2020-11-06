
var AirtypeBar1 = echarts.init(document.getElementById('AirtypeBar1'));
var AirtypeBar2 = echarts.init(document.getElementById('AirtypeBar2'));



$("#radioList1").on("click", "span", function () {
    $(this).siblings("span").removeClass("active");
    $(this).addClass("active");
    searchAirChar(1, '350623101', AirtypeBar1);
});
$("#option1").on("click", "span", function () {
    $(this).siblings("span").removeClass("active");
    $(this).addClass("active");
    searchAirChar(1, '350623101', AirtypeBar1);
});
$("#radioList2").on("click", "span", function () {
    $(this).siblings("span").removeClass("active");
    $(this).addClass("active");
    searchAirChar(2, '350623102', AirtypeBar2);
});
$("#option2").on("click", "span", function () {
    $(this).siblings("span").removeClass("active");
    $(this).addClass("active");
    searchAirChar(2, '350623102', AirtypeBar2);
});

/*---------------------------------天气--------------------------------------------------*/
$.ajax({
    type: 'POST',
    url: Ams.ctxPath + '/zphb/dataShow/getWeather',
    async: true,
    success: function (data) {
        var result = eval('(' + data + ')');
        var weather = result.results[0].weather_data[0];
        if (weather.date != null) {
            $('#weatherDate').html(weather.date);
        } else {
            $('#weatherDate').html("-");
        }
        if (weather.wind != null) {
            $('#wind').html(weather.wind);
        } else {
            $('#wind').html("-");
        }
        if (weather.weather != null) {
            $('#weather').html(weather.weather);
            $('#weatherIcon').removeClass();
            $('#weatherIcon').addClass(Ams.weatherIcon(weather.weather));
        } else {
            $('#weather').html("-");
        }
        if (weather.temperature != null) {
            $('#temperature').html(weather.temperature);
        } else {
            $('#temperature').html("-");
        }
    }
});

/*---------------------------------监控情况--------------------------------------------------*/
$.ajax({
    type: 'POST',
    url: Ams.ctxPath + '/zphb/dataShow/getAirCount',
    async:true,
    success: function (data) {
        if(data.废气排口!=null){
            $('#wasteGas').html(data.废气排口);
        }else{
            $('#wasteGas').html("-");
        }
        if(data.污普废气排口!=null){
            $('#gasEnterprise').html(data.污普废气排口);
        }else{
            $('#gasEnterprise').html("-");
        }
    }
});

/*---------------------------------空气实时--------------------------------------------------*/
$.ajax({
    type: 'POST',
    url: Ams.ctxPath + '/zphb/dataShow/airList',
    data:{
      parent:'350623'
    },
    async:false,
    success: function (data) {
        for(var i=0;i<data.length;i++){
            var html = '';
            var html2='';
            var factor = data[i].factor;
            var colors = ["green", "blue", "yellow", "orange", "red", "purple"]
            for(var j=0;j< factor.length;j++){
                html += '<div class="col-xs-4">' +
                    '<div class="basin-name-container circle-1 blue">' +
                    '<div class="basin-bg">' +
                    '<div class="bg-img bg-1"></div>' +
                    '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>' +
                    '</div>' +
                    '<div class="basin-text-box">' +
                    '<div class="basin-text">' +
                    '<div class="name">'+ factor[j].name+'</div>' +
                    '<div class="value">'+ factor[j].value+'</div>' +
                    '</div></div></div></div>';

                html2 += '<tr><td>'+factor[j].name+'</td><td>'+ factor[j].value+'</td></tr>';
            }
            if(data[i].code=='350623101'){
                $('#350623101').html(html);
                $('#pointInfo1').html('<span>经度：'+data[i].lng+'</span><span>纬度：'+data[i].lat+'</span><span>控制级别：省控</span><span>AQI：'+data[i].aqi+'</span><span>更新时间：'+data[i].time+'</span>');
                $('#pointTableInfo1').find('tr').eq(0).after(html2);
            }else{
                $('#350623102').html(html);
                $('#pointInfo2').html('<span>经度：'+data[i].lng+'</span><span>纬度：'+data[i].lat+'</span><span>控制级别：省控</span><span>AQI：'+data[i].aqi+'</span><span>更新时间：'+data[i].time+'</span>');
                $('#pointTableInfo2').find('tbody tr').eq(0).after(html2);
            }
        }
    }
});
searchAirChar(1, '350623101',AirtypeBar1);
searchAirChar(2, '350623102',AirtypeBar2);

function searchAirChar(id, pointCode,AirtypeBar){
    $.ajax({
        type : 'POST',
        url : '/zphb/enviromonit/airEnvironment/getDataAnalysisCityPoint',
        async : true,
        data : {
            polluteName : $("#radioList"+id+" .active").attr("timeData"),
            pointCode : pointCode,
            time : $("#option"+id+" .active").attr("timeData")
        },
        success : function(data) {
            AirtypeBar.hideLoading();
            AirtypeBar.clear();
            var series = data.series;
            var time = data.xAxis;
            var legend = data.legend;
            AirtypeBar.setOption({        //加载数据图表
                tooltip : {
                    trigger: 'axis',//trigger: 'item'
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                title: {
                    text: $(".radio-button-group1 .active").text(),
                    textStyle:{
                        fontSize: 16,
                        color:'#fff'
                    },
                    left:'10',
                    top:'10'
                },
                toolbox : {
                    show : true,
                    iconStyle : {
                        borderColor : '#fff'
                    },
                    feature : {
                        magicType : {
                            show : true,
                            type : [ 'line' ]
                        },
                        saveAsImage : {
                            show : true
                        },
                        restore : {
                            show : true
                        }
                    }
                },
                textStyle: {
                    color:'#fff'
                },
                grid: {
                    top:'80',
                    left: '50',
                    right: '30',
                    bottom: '10',
                    containLabel: true
                },
                legend: {
                    data:legend,
                    textStyle: {
                        color:'#fff'
                    },
                },
                xAxis: [{
                    type : 'category',
                    axisLabel:{
                        type:'category',
                    },
                    data:  time
                }],
                yAxis : [{
                    type : 'value'
                }],
                series: series
            });
        },
        error : function(jqXHR, textStatus, errorThrown) {
        },
        dataType : 'json'
    });
}

/*初始化dialog*/
function homeDialogInit(target){
    var sWidth=$(target).outerWidth();
    var pWidth=$(target).parent().outerWidth();
    var sHeight=$(target).outerHeight();
    var pHeight=$(target).parent().outerHeight();

    sWidth=sWidth<pWidth?sWidth:pWidth-40;
    sHeight=sHeight<pHeight?sHeight:pHeight-40;
    bodyHeight=sHeight-176;
    var sLeft=(pWidth-sWidth)/2;
    var sTop=(pHeight-sHeight)/2;

    $(target).css({
        "left":sLeft+"px",
        "top":sTop+"px",
        "width":sWidth+"px",
        "height":sHeight+"px"
    });
    $('#AirtypeBar1').css({"width":(sWidth-400)+"px"})
    $('#AirtypeBar2').css({"width":(sWidth-400)+"px"})
    $(target).children(".home-window-body").height(bodyHeight);
}

/*打开dialog*/
function homeDialogOpen2(target){
    $(target).addClass("show");
    $(target).children(".home-window-body").height(bodyHeight);
}