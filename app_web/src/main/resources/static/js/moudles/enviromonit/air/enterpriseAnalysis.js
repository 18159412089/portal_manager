var enterpriseTypeBar = echarts.init(document
		.getElementById('enterpriseTypeBar'));//废气排口的图表
var peMonitorPoint = new Array(); //排气口

$(function() {
	$(".radio-button-group3").on("click", "span", function() {
		$(this).siblings("span").removeClass("active");
		$(this).addClass("active");
		searchConHourBar();
	});
	$(".radio-button-group4").on("click", "span", function() {
		$(this).siblings("span").removeClass("active");
		$(this).addClass("active");
		searchConHourBar();
	});
	$("#enterpriseListContainer").mCustomScrollbar({
		theme : "light-3",
		scrollButtons : {
			enable : true
		}
	});
	$("#selectEnterpriseGropContainer").mCustomScrollbar({
		theme : "light-3",
		scrollButtons : {
			enable : true
		},
		autoHideScrollbar : true
	});
	$('body').on('click', '.btnEnterpriseSure', function() {
		$(this).parents(".select-panel").removeClass('show');

		searchConHourBar();
	});

})
/*添加有废弃排口的企业监测点*/
function creatPeMonitorPoint(type) {

	//向地图上添加自定义标注
	$.post('/enterprise/peenterprisedata/getPeEnterpriseDataInfo?outType='
			+ type, {}, function(data) {

		$.each(data, function(i) {
			var marker;
			var row = {};
			if ('' != data[i].cameraid && undefined != data[i].cameraid) {

				row = new fjzx.map.Marker(new fjzx.map.Point(data[i].longValue,
						data[i].latValue), {
					icon : export2,
					map : map,
					title : data[i].peName
				});
			} else {
				var iconTemp = null ;
				if(data[i].pointStatus == "over"){
					iconTemp = exportoverIcon ;
				}else{
					iconTemp = icon15 ;
				}
			row = new fjzx.map.Marker(new fjzx.map.Point(data[i].longValue,
						data[i].latValue), {
					icon : iconTemp,
					map : map,
					title : data[i].peName
				});
			}
			row.id = i;
			peMonitorPoint.push(row)
			map.addOverlay(row);

			addClickHandler(data[i], row);

		});
	}, "json");

	/*点击事件*/
	function addClickHandler(data, marker) {
		marker.addClick(function(e) {
			showEnterprise(data);
		});
	}

	/*鼠标移动到指点地点触发*/
	function onMouseOver(m, lnglats, e) {
		var point = e.lnglat;
		var h = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color: #ffffff;"
				+ "'>"
				+ "<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"
				+ lnglats[m.id].peName
				+ "</b>"
				+ "<sub>点击可查看详情<sub></sub></sub></li><li>企业名称:"
				+ lnglats[m.id].peName
				+ "</li><li>地址："
				+ lnglats[m.id].address
				+ "</li><li>经度："
				+ isNull(lnglats[m.id].longitude)
				+ "</li><li>纬度："
				+ isNull(lnglats[m.id].latitude)
				+ "</li></ul>";
		markerInfoWin = new T.InfoWindow(h, {
			offset : new T.Point(0, -30),
			closeButton : false
		}); // 创建信息窗口对象
		map.openInfoWindow(markerInfoWin, point); //开启信息窗口
	}

}
/*废气排口窗口显示*/
function showEnterprise(data) {

	$("#enterpriseInfo")[0].innerHTML = "<span style='width:99%;'>公司名称："
			+ isNull(data.peName) + "</span><br>"
			+ "<span style='width:99%;'>地址：" + isNull(data.address) + "</span>"
			+ "<span style='width:99%;'>经度：" + isNull(data.longValue)
			+ "</span><br>" + "<span style='width:99%;'>纬度："
			+ isNull(data.latValue) + "</span><br>";

	$("#enterpriseName").html(data.name);
	if ('' != data.cameraid && undefined != data.cameraid) {
		document.getElementById('cameraView').innerHTML = '<a href="'
				+ Ams.ctxPath
				+ '/camera/localCameraController/mpvSingle?cameraId='
				+ data.cameraid + '" target="_blank" class="title-link-tag">视频监控</a>';
	} else {
		document.getElementById('cameraView').innerHTML = '';
	}
	var tempData = data;
	$.ajax({
        type : 'POST',
        url : '/monitorPoint/pemonitorpoint/listNoPage',
        async : false,
        data : {
            outType : 2,
            peId : tempData.peId
        },
        success : function(data) {
            var listHtml = '';
            $
                    .each(
                            data,
                            function(i) {
                                /*	if(i==0){*/
                                var checked = '';
                                if(i==0){
                                    checked='checked="checked"';
                                }
                                listHtml += "<label class='form-radio'> <input name='enterpriseType' type='radio' "+checked+" value='"
                                        + data[i][0]
                                        + "'/>"
                                        + "<span class='lbl' >"
                                        + data[i][1]
                                        + "</span></label>";
                                /*}else{
                                    listHtml += "<label class='form-checkbox'> <input name='enterpriseType' type='checkbox'  value='"+data[i][0]+"'/>"
                                     +"<span class='lbl' >"+data[i][1]+"</span></label>";
                                }*/
                            });
            $("#selectEnterpriseGrop")[0].innerHTML = listHtml;
        },
        error : function(jqXHR, textStatus, errorThrown) {
        },
        dataType : 'json'
    });
	var spans = '';
	/*添加因子*/
	$.ajax({
		type : "post",
		url : Ams.ctxPath + '/monitorPoint/pemonitorpoint/getFactor',
		async : false,
		data : {
			peId : data.peId,
			outType : 2
		},
		success : function(result) {
			for (var i = 0; i < result.length; i++) {
				if (i == 0) {
					spans += '<span class="active" value="' + result[i][0] + '" >' + result[i][1] + '</span>';
				} else {
					spans += '<span value="' + result[i][0] + '" >' + result[i][1] + '</span>';
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
	$("#enterpriseList").html(spans);
	var option = '';
	var day = [
	    {'key' : '24', 'text' : '24小时'},
        {'key' : '72', 'text' : '72小时'}
       // {'key' : '2400', 'text' : '240小时'}
    ];

	for (var i = 0; i < day.length; i++) {
		if (i == 0) {
			option += "<span class='active' timeData='" + day[i].key + "'>" + day[i].text + "</span>"
		} else {
			option += "<span  timeData='" + day[i].key + "'>" + day[i].text + "</span>"
		}
	}

	$("#optionEnterprise")[0].innerHTML = option;
	$('#enterpriseWindow').window('open');
	searchConHourBar();
}
/*废气排口图表显示*/
function searchConHourBar() {

	var citys = $("input[name='enterpriseType']:checked");
	var names = "";
	for (var i = 0; i < citys.length; i++) {
		names += $(citys[i]).val() + ",";
	}
	var code = $(".radio-button-group3 .active").attr("value")
	$.ajax({
		type : "post",
		url : '/monitorPoint/pemonitorpoint/getConHourchart',
		async : true,
		data : {
			outputId : names,
			outType : "2",
			hours : $(".radio-button-group4 .active").attr("timeData"),
			code : code
		},
		success : function(result) {
			enterpriseTypeBar.clear();
			var series = result.series;
			var time = result.xAxis;
			var pollutantStandardMap = result.pollutantStandardMap;
			var legend = result.legend;
			var visualMap = {
				top: 50,
				right: 10,
				pieces: [
					{gt: 0, lte: 0, color: '#209913'},
				],
				outOfRange: {color: '#ff0000'}
			};
            if(series.length>0){

                var lowLimit =Number( typeof(pollutantStandardMap.lowLimit) == 'undefined' ? 0 : pollutantStandardMap.lowLimit);
                var upLimit = Number(typeof(pollutantStandardMap.upLimit) == 'undefined' ? 0 : pollutantStandardMap.upLimit);

                series = series[0];
                series.markLine = {
                    name: 'SO2',
                    silent: false,
                    data: [
                        {yAxis: lowLimit},
                        {yAxis: upLimit}
                    ]
                }
                 visualMap = {
                    top: 50,
                    right: 10,
                    pieces: [
                        {gt: lowLimit, lte: upLimit, color: '#209913'},
                    ],
                    outOfRange: {color: '#ff0000'}
                }
            }
			enterpriseTypeBar.setOption({
				tooltip : {
					trigger : 'axis',//trigger: 'item'
					axisPointer : { // 坐标轴指示器，坐标轴触发有效
						type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
				},
				title : {
					text : $(".radio-button-group3 .active").text() + result.unit,
					textStyle : {fontSize : 16, color : '#000000'},
					left : '10',
					top : '10'
				},
				toolbox : {
					show : true,
					iconStyle : {borderColor : '#000000'},
					feature : {
						magicType : {show: true,type: [ 'line' ]},
						saveAsImage : {show : true},
						restore : {show : true}
					}
				},
				textStyle : {color : '#000000'},
				grid : {top : '80', left : '50', right : '30', bottom : '10', containLabel : true},
				legend : {data : legend, textStyle : {color : '#000000'}},
				xAxis : [ {
					type : 'category',
					axisLabel : {type : 'category'},
					data : time
				} ],
				yAxis : [{type : 'value'}],
                visualMap: visualMap,
				series : series
			});
            console.log(pollutantStandardMap);
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}

function getLimitValueByMonitorPointId(outputId){
    $.ajax({
        type : "post",
        url : '/factormanual/PeFactorManual/getPeFactorManualLimit',
        async : true,
        dataType : 'json',
        data : {
            outputId : outputId
        },
        success : function(res) {
            console.log(res);
        },
        error : function(jqXHR, textStatus, errorThrown) {
        }
    });
}