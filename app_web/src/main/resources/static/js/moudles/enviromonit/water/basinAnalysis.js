var basinPoints = new Array(); // 流域站点数组
var basinLines = null;
var basinDatas = new Array(); // 流域数据数组
var basinName;
var pollutionAnalysis = echarts.init(document.getElementById('waterBasinBar'));
var pollutionAnalysis_tb = echarts.init(document.getElementById('waterBasinBar_tb'));
var pollutionAnalysis_njdb = echarts.init(document.getElementById('waterBasinBar_njdb'));
var riverApp = null;

// 小流域
function basinSearch() {
    $('#basinDg').datagrid('load', {
    	monitorName: $("#monitorName").val().trim()
    });
}

//鼠标回车事件  【小流域】
Ams.inputText_enterKeyEvent('monitorName',basinSearch);

//微型自动监测站列表中的双击事件
$("#basinDg").datagrid({
 	onDblClickRow: function (index, row) {
		map.setCenter(new fjzx.map.Point(row.lng,row.lat));
		openBasinDlg(JSON.stringify(row));
 	}
 });

function getRiverBasin(){
    getBasin();
    if ($("#basin").hasClass('choiced')) {
        //移除水系图层图例
        // $(".legend").remove();
		$(".legend-item-box").hide();

		//Ipad 横屏 调整
		if( $(window).width()<1025){
			$(".basemap-toggle").css("left","16px")
		}

        //移除水系图层
        riverApp.map.layerManager.removeSpecialById(window.appConfig.river.id);
        // //移除水系图层底图
        riverApp.map.control.baseMap.clearBaseMapLayer();
    } else {
        //引入水系图层
		$(".legend-item-box").show();
        riverApp = new fjzx.map.river.app(window, jQuery, ol, layer,map);
        //ipad 横屏 调整
    	if( $(window).width()<1025){
			$(".basemap-toggle").css("left","180px")
		}

    }
}

function getBasin() {
	if ($("#basin").hasClass('choiced')) {
		$("#monitorName").textbox('setValue', '');
		clearBasin();
		clearPolicy();
	} else {
		layPolicy(map);
		$.ajax({
			type : "post",
			url : "/enviromonit/water/nationalSurfaceWater/getBasinMonitor",
			async : true,
			success : function(result) {
				var data = result.data;
				var geoJSONArr = [] ;
				if(basinLines == null)
					basinLines = initDrawGeoLine(map);
				for (var i = 0; i < data.length; i++) {
					basinDatas[i] = data[i];
					
					var color = "#b8b8b8";
					if (data[i].resultQuality == "Ⅰ" || data[i].resultQuality == "Ⅱ") {
						color = "#2ba4e9";
					} else if (data[i].resultQuality == "Ⅲ") {
						color = "#45b97c";
					} else if (data[i].resultQuality == "Ⅳ") {
						color = "#FFFF00";
					} else if (data[i].resultQuality == "Ⅴ") {
						color = "#f47920";
					} else if (data[i].resultQuality == "劣Ⅴ") {
						color = "#d02032";
					}
					var clickDiv = null ;
		            clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
		            	+"<div style='border-radius: 15px;height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;"
						+"background-color:"+color+"' onclick='openBasinDlg(JSON.stringify(basinDatas["+i+"]))'>"+data[i].resultQuality+"</div>"
						+"</div><p style='font-weight:bold;'>"+data[i].name+"</p></div>";
		            //创建pint
		            var point = new fjzx.map.Point(data[i].lng, data[i].lat);
					//创建地图marker点 
		            var  myMarker = new fjzx.map.Marker(point, {
		        	    markerHtml : clickDiv,
						map : map,
						isShowIcon :false,
						title:data[i].name,
						id:data[i].mn
					});
					map.addOverlay(myMarker);
					basinPoints[i] = myMarker;
					
					if(data[i].lines != ""){
						var points=[];
						var arr = data[i].lines.split(';');
						for(var j=0;j<arr.length;j++){
							var arr2 = arr[j].split(',');
							points.push([parseFloat(arr2[0]),parseFloat(arr2[1])]);
						}
						//根据格式绘制单条线段
						var feature = {"layout":"XY","coordinates":points,"type":"LineString","featureId":i,"pencilColor":color};
						geoJSONArr.push({"feature":JSON.stringify(feature),"name":"","id":i});
						
					}
				}
				basinLines.load(geoJSONArr); 
			},
			error : function() {
			},
			dataType : 'json'
		});
	}

}

function clearBasin() {
	for (var i = 0; i < basinPoints.length; i++) {
		map.removeOverlay(basinPoints[i]);
	}
	drawGeojson.clearGeoJSON();
	basinLines.clearGeoJSON();
	basinPoints = new Array();
}

function openBasinDlg(info) {
	info = JSON.parse(info);
	getBasinInfo(info);
	basinName=info.name;
	searchAnalysis();
	searchAnalysis_tb();
	searchAnalysis_njdb();
    // doSearch_one(info);
	$('#basinDlg').dialog('open').dialog('center').dialog('setTitle','断面详情与分析');
	$('#basin_tabs').tabs('select',"简介详情");
	//getFactorCount();
	//}
}

//点位详情信息
function getBasinInfo(info) {
	document.getElementById('basinName').innerHTML = info.name;
    $('#spanFileId').html(info.name+'文档');
    $('#spanDetailId').html(info.name+'详情');
	document.getElementById('basinMonitorTime').innerHTML = info.yearNumber+" 年 " + info.monthNumber+" 月 ";
	var pid = $('#pid').val();
    $("#fjlbid").attr("href",encodeURI("/environment/waterAttachment/river?pid="+pid+"&pointCode="+info.code+"&pointName="+info.name));//附件列表
	var target = Ams.isNoEmpty(info.targetQuality)?info.targetQuality:"";
	var resultQuality = Ams.isNoEmpty(info.resultQuality)?info.resultQuality:"";
	var resultColor = "black";
	if((resultQuality== "Ⅳ"||resultQuality=="Ⅴ"||resultQuality=="劣Ⅴ") && resultQuality!=target){
		resultColor = "red";
	}
    $.ajax({
        type : "post",
        url: "/environment/waterAttachment/list",
        data : {
            pointCode: info.code,
            showDetail: 'show',
            isShow:'1',
			source:'0',
            enable:1
        },
        async : false,
        success : function(result) {
            var data = result.rows;
            var lth  = data.length;

            var tableHtml ='<tr><td style=\'width:250px;background:#f6f6f6;text-align:center;\'>序号</td><td style=\'width:250px;background:#f6f6f6;text-align:center;\'>文档</td>' +
				'<td style=\'width:250px;background:#f6f6f6;text-align:center;\'>上传时间</td>' +
				'<td style=\'width:250px;background:#f6f6f6;text-align:center;\' >操作</td></tr>';
            for( var i=0;i<lth;i++){
                tableHtml += "<tr><td style='width:150px;text-align:center;'>" +(i+1) + "</td>" +
					"<td style='width:150px;text-align:center;'>" + data[i].name + "</td>" +
                    "<td style='width:150px;text-align:center;'>"+timeDateFormat(data[i].createDate)+"</td>" +
                    "<td style='width:150px;text-align:center;'>"+seeAttach(data[i].mongoid,data[i].type)+"</td></tr>";
            }
           document.getElementById('dg1').innerHTML = tableHtml;
//			document.getElementById('basinInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
//			+ '<span>纬度：' + info.lat + '</span><span>所属河流：' + data.river + '</span>'
//			+ '<span>所属流域：' + data.basin + '</span><span>流域面积(平方公里)：' + data.basinArea + '</span>'
//			+ '<span>境内流域面积(平方公里)：' + data.insideBasinArea + '</span><span>河道长(公里)：' + data.riverLength + '</span>'
//			+ '<span>境内河道长(公里)：' + data.insideRiverLength + '</span><span>多年平均流量(立方米／秒)：' + data.flow + '</span>'
//			+ '<span>河道坡率(‰)：' + data.slopeRatio + '</span><span>流域形状系数(F/L2)：' + data.basinShapeCoefficient + '</span>'
//			+ '<span>目标水质：' + target + '</span><span style="color:'+resultColor+'">综合水质评价：' + resultQuality + '</span>';
        },
        error : function() {
        },
        dataType : 'json'
    });
	$.ajax({
		type : "post",
		url : "/enviromonit/water/nationalSurfaceWater/getOtherBasinMonitorInfo",
		data : {monitorName : info.name},
		async : false,
		success : function(result) {
			var data = result.data;
			var tableHtml = "<tr><td style='width:250px;background:#f6f6f6;text-align:center;'>所属河流</td><td style='width:150px;text-align:center;'>" + data.river + "</td>" +
			"<td style='width:250px;background:#f6f6f6;text-align:center;'>所属流域</td><td style='width:150px;text-align:center;'>" + data.basin + "</td></tr>" +
			"<tr><td style='width:250px;background:#f6f6f6;text-align:center;'>流域面积(平方公里)</td><td style='width:150px;text-align:center;'>" + data.basinArea + "</td>" +
			"<td style='width:250px;background:#f6f6f6;text-align:center;'>境内流域面积(平方公里)</td><td style='width:150px;text-align:center;'>" + data.insideBasinArea + "</td></tr>" +
			"<tr><td style='width:250px;background:#f6f6f6;text-align:center;'>河道长(公里)</td><td style='width:150px;text-align:center;'>" + data.riverLength + "</td>" +
			"<td style='width:250px;background:#f6f6f6;text-align:center;'>境内河道长(公里)</td><td style='width:150px;text-align:center;'>" + data.insideRiverLength + "</td></tr>" +
			"<tr><td style='width:250px;background:#f6f6f6;text-align:center;'>多年平均流量(立方米／秒)</td><td style='width:150px;text-align:center;'>" + data.flow + "</td>" +
			"<td style='width:250px;background:#f6f6f6;text-align:center;'>河道坡率(‰)</td><td style='width:150px;text-align:center;'>" + data.slopeRatio + "</td></tr>" +
			"<tr><td style='width:250px;background:#f6f6f6;text-align:center;'>流域形状系数(F/L2)</td><td style='width:150px;text-align:center;'>" + data.basinShapeCoefficient + "</td></tr>";
			document.getElementById('tb_otherInfo').innerHTML = tableHtml;
//			document.getElementById('basinInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
//			+ '<span>纬度：' + info.lat + '</span><span>所属河流：' + data.river + '</span>'
//			+ '<span>所属流域：' + data.basin + '</span><span>流域面积(平方公里)：' + data.basinArea + '</span>'
//			+ '<span>境内流域面积(平方公里)：' + data.insideBasinArea + '</span><span>河道长(公里)：' + data.riverLength + '</span>'
//			+ '<span>境内河道长(公里)：' + data.insideRiverLength + '</span><span>多年平均流量(立方米／秒)：' + data.flow + '</span>'
//			+ '<span>河道坡率(‰)：' + data.slopeRatio + '</span><span>流域形状系数(F/L2)：' + data.basinShapeCoefficient + '</span>'
//			+ '<span>目标水质：' + target + '</span><span style="color:'+resultColor+'">综合水质评价：' + resultQuality + '</span>';
		},
		error : function() {
		},
		dataType : 'json'
	});

	document.getElementById('basinInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
	+ '<span>纬度：' + info.lat + '</span><span>目标水质：' + target + '</span>'
	+ '<span style="color:'+resultColor+'">综合水质评价：' + resultQuality + '</span>';

	var phLevel = Ams.fmtByWtQuality(info.phLevel);
	var rjyLevel = Ams.fmtByWtQuality(info.rjyLevel);
	var gmsyLevel = Ams.fmtByWtQuality(info.gmsyLevel);
	var bodLevel = Ams.fmtByWtQuality(info.bodLevel);
	var andanLevel = Ams.fmtByWtQuality(info.andanLevel);
	var zlLevel = Ams.fmtByWtQuality(info.zlLevel);
	var tableHtml = "<tr><td class='tit'>因子名称</td><td class='tit'>数值</td><td class='tit'>级别</td></tr>" +
			"<tr><td class='con'>PH值</td>" +
			"<td class='con' style ='color:"+getColor(target,phLevel)+"'>" + info.phValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,phLevel)+"'>" + phLevel + "</td></tr>" +
			"<tr><td class='con'>溶解氧</td>" +
			"<td class='con' style ='color:"+getColor(target,rjyLevel)+"'>" + info.rjyValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,rjyLevel)+"'>" + rjyLevel + "</td></tr>" +
			"<tr><td class='con'>高锰酸盐指数</td>" +
			"<td class='con' style ='color:"+getColor(target,gmsyLevel)+"'>" + info.gmsyValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,gmsyLevel)+"'>" + gmsyLevel + "</td></tr>" +
			"<tr><td class='con'>五日生化需氧量</td>" +
			"<td class='con' style ='color:"+getColor(target,bodLevel)+"'>" + info.bodValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,bodLevel)+"'>" + bodLevel + "</td></tr>" +
			"<tr><td class='con'>氨氮</td>" +
			"<td class='con' style ='color:"+getColor(target,andanLevel)+"'>" + info.andanValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,andanLevel)+"'>" + andanLevel + "</td></tr>" +
			"<tr><td class='con'>总磷</td>" +
			"<td class='con' style ='color:"+getColor(target,zlLevel)+"'>" + info.zlValue + "</td>" +
			"<td class='con' style ='color:"+getColor(target,zlLevel)+"'>" + zlLevel + "</td></tr>";
	document.getElementById('basinTableInfo').innerHTML = tableHtml;
	//if(info.analysis==""){
		$('#basin_tabs').tabs('getTab',"概况与分析").panel('options').tab.hide();//隐藏tab页
	    //$("#basinAnalysis").hide();//隐藏tab内容
	//}else{
	//	$('#basin_tabs').tabs('getTab',"概况与分析").panel('options').tab.show();//显示tab页
	//	document.getElementById('basinText').innerHTML = info.analysis;
	//}
}

function getColor(targetQualtiy,resultQuality){
	var resultColor = "black";
	if((resultQuality== "Ⅳ"||resultQuality=="Ⅴ"||resultQuality=="劣Ⅴ") && resultQuality!=targetQualtiy){
		resultColor = "red";
	}
	return resultColor;
}


function searchAnalysis(){
	var date=new Date;
	var thisYear = date.getFullYear();
	var lastYear = date.getFullYear()-1;
	var polluteCode = $('#basin_polluteList span.active').attr('value')
	if(basinName != undefined || basinName != null || basinName==""){
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/nationalSurfaceWater/getBasinYearAnalysis",
			data : {
				name : basinName,
				thisYear:thisYear, 
				lastYear:lastYear,
				polluteCode:polluteCode
			},
			dataType: "json",
			success: function(data){
				setEcharts(data.title, data.xAxis, data.seriesData);
			},
			error: function(r){console.log(r);}
		});
	}
}

function searchAnalysis_tb(){
	var polluteCode = $('#basin_polluteList_tb span.active').attr('value')
	if(basinName != undefined || basinName != null || basinName==""){
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/nationalSurfaceWater/getBasinYearAnalysis_tb",
			data : {
				name : basinName,
				polluteCode:polluteCode
			},
			dataType: "json",
			success: function(data){
				setEcharts_tb(data.title, data.xAxis, data.seriesData);
			},
			error: function(r){console.log(r);}
		});
	}
}

function searchAnalysis_njdb(){
	var date=new Date;
	var thisYear = date.getFullYear();
	var lastYear = date.getFullYear()-1;
	var polluteCode = $('#basin_polluteList_njdb span.active').attr('value')
	if(basinName != undefined || basinName != null || basinName==""){
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/nationalSurfaceWater/getBasinYearAnalysis_njdb",
			data : {
				name : basinName,
				thisYear:thisYear, 
				lastYear:lastYear,
				polluteCode:polluteCode
			},
			dataType: "json",
			success: function(data){
				setEcharts_njdb( data.title, data.xAxis, data.seriesData);
			},
			error: function(r){console.log(r);}
		});
	}
}

function setEcharts(title, xAxis, seriesData){
	pollutionAnalysis.clear();
	var option = {
			 title: {
				 text: title,
	             textStyle:{
	                fontSize: 16,
	                color : '#000000'
				},
	            left:'10',
				top:'10'
	        },
	        textStyle : {
	    		color : '#000000'
	    	},
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : xAxis,
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:title,
		            type:'bar',
		            barWidth: '60%',
		            data:seriesData
		        }
		    ]
		};
	pollutionAnalysis.setOption(option);
}

function setEcharts_tb(title, xAxis, seriesData){
	pollutionAnalysis_tb.clear();
	option = {
			 title: {
				 text: title,
	             textStyle:{
	                fontSize: 16,
	                color : '#000000'
				},
	            left:'10',
				top:'10'
	        },
	        textStyle : {
	    		color : '#000000'
	    	},
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : xAxis,
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:title,
		            type:'bar',
		            barWidth: '60%',
		            data:seriesData
		        }
		    ]
		};
	pollutionAnalysis_tb.setOption(option);
}

function setEcharts_njdb(title, xAxis, seriesData){
	pollutionAnalysis_njdb.clear();
	var option = {
			title: {
				 text: title,
	             textStyle:{
	                fontSize: 16,
	                color : '#000000'
				},
	            left:'10',
				top:'10'
	        },
	        textStyle : {
	    		color : '#000000'
	    	},
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : xAxis,
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            type:'bar',
		            barWidth: '60%',
		            data:seriesData
		        }
		    ]
        };
	pollutionAnalysis_njdb.setOption(option);
}

function seeAttach(mongoid,type) {
    if (type == 3) {
        return "<div>"+Ams.setImageSee()+"<a href='javascript:onClick=play(\"" + mongoid + "\")' class='easyui-linkbutton'>查看</a>";
    } else {
        return "<div>"+Ams.setImageSee()+"<a href='/environment/waterAttachment/download/" + mongoid + "/" + type + "' class='easyui-linkbutton' target='_blank'>查看</a></div>";
    }
}

function timeDateFormat(value) {
    var temp = Ams.dateFormat(value, 'yyyy-MM-dd HH:mm:ss');
    if ('' == temp) {
        return '';
    }
    return "<span title='" + temp + "'>" + temp + "</span>";
}