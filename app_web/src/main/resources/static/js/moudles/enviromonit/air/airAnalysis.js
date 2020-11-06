var AirtypeBar = echarts.init(document.getElementById('AirtypeBar')); //城市和监测站点的图表

var cityPoint = new Array(); //城市站点
var monitorPoint = new Array();  //监测站点
var builtPoint = new Array(); //自建站点
$(function () {
	$(".radio-button-group1").on("click", "span", function () {
		$(this).siblings("span").removeClass("active");
		$(this).addClass("active");
		searchAirChar();
	});
	$(".radio-button-group2").on("click", "span", function () {
		$(this).siblings("span").removeClass("active");
		$(this).addClass("active");
		searchAirChar();
	});
	$("#selectGropContainer").mCustomScrollbar({
		theme:"light-3",
		scrollButtons:{
			enable:true
		}
	});
	
	$("#radioListContainer").mCustomScrollbar({
		theme:"light-3",
		scrollButtons:{
			enable:true
		},
		autoHideScrollbar: true
	});
	/*确定*/
    $('body').on('click','.btnSure',function () {
        $(this).parents(".select-panel").removeClass('show');
        searchAirChar();
    });
})
// 用于周边分析输入公里数值的判断
$(document).ready(function() {  
	    //敲击按键时触发  
	    $("#distance").bind("keypress", function(event) {  
		    var event= event || window.event;  
		    var getValue = $(this).val();  
		    //控制第一个不能输入小数点"."  
		    if (getValue.length == 0 && event.which == 46) {   
		        event.preventDefault();  
		        return;  
		    }  
		    //控制只能输入一个小数点"."  
		    if (getValue.indexOf('.') != -1 && event.which == 46) {  
		        event.preventDefault();   
		        return;  
		    }
		    //控制小数点后只能输入两位数
		    if(getValue.indexOf('.')!=-1 && getValue.length-getValue.indexOf('.')>2){
		        event.preventDefault();   
		        return;  
		    }
		    //控制只能输入的值  
		    if (event.which && (event.which < 48 || event.which > 57) && event.which != 8 && event.which != 46) {  
		        event.preventDefault();  
		         return;  
		        }  
	    })  
	    //失去焦点是触发  
	    $("#distance").bind("blur", function(event) {  
		    var value = $(this).val(), reg = /\.$/;  
		    if (reg.test(value)) {  
			    value = value.replace(reg, "");  
			    $(this).val(value);  
		    }  
	    })
		$('#peripheralAnalysis').window({
	       onBeforeClose:function(){ 
	    	   $("#distance").val("");
	       }
	   }); 
}); 



/*点击事件*/
function show(obj,type){
	var jsObject = JSON.parse($(obj).attr("dataStr"))
	showAir(jsObject,type);
}  	
/*城市或站点排名*/
function ranking(pointType,level,pointCode){
	 $.ajax({   
        type: 'POST',   
        dataType : 'json',  
        url: '/enviromonit/airHourData/rankingOrderByAQI',   
        data: {pointType:pointType,pointCode:pointCode },   
        beforeSend: ajaxLoading,  
        success: function(data){   
        	
            ajaxLoadEnd();  
            <!-- 根据不同状态 将“good” 更换 （excellent good mild moderate severe dangerous）-->
			var listHtml=''; 
			var j = 0;
			$.each(data,function(i){ 
				var color;
				var text;
				if(data[i].color < 0){
					color = 'not_data';
				}else if(data[i].color <=50){
					color ='excellent';
					text ='';
				}else if(data[i].color <= 100){
					color ='good';
				}else if(data[i].color <= 150){
					color ='mild';
				}else if(data[i].color <= 200){
					color ='moderate';
				}else if(data[i].color <= 300){
					color ='severe';
				}else if(data[i].color <= 500){
					color ='dangerous';
				}
				listHtml +="<li class='item' onclick='updateMap("+data[i].longitude+","+data[i].latitude+","+data[i].pointCode+",\""+data[i].monitrorTime+"\""+",\""+color+"\""+",\""+data[i].pointName+"\""+","+data[i].pointType+")'><span class='ranking'><span>"+(i+1)+"</span></span>";
				listHtml +="<span class='title'>"+data[i].pointName+"</span>";
				listHtml +="<span class='newTime'>"+data[i].monitrorTime+"</span>";
				listHtml +="<span class='data'><span class='"+color+"'>"+data[i].aqi+"</span></span></li>";
				if(data[i].pointName==$("#pointNameId").val()){//大气环境年数据展示点击全年空气质量跳转显示情况
                    updateMap(data[i].longitude,data[i].latitude,data[i].pointCode,data[i].monitrorTime,color,data[i].pointName,data[i].pointType);
                }
			}); 
			$("#city").html(listHtml); 
			
    	}   
	}); 

}
/*城市站点和监测站点的窗口显示*/
var point=""; //站点的编号
function showAir (data,type){
	var typePoint ="";
	var get =""
		if(type== '1'){
			get ="getCity";
			typePoint ="城市：";
		}else if(type== '0') {
			get ="getPonit";
			typePoint = "站点："
		}else if(type== '2'){
			get ="getPonit";
			typePoint = "自建："
		}
	
	$("#airInfo")[0].innerHTML="<span>经度："+data.longitude+"</span>"
	+"<span>纬度："+data.latitude+"</span>"
	+"<span>"+typePoint+data.pointName+"</span>"
	+"<span>更新时间："+data.monitrorTime+"</span>"
	+"<span>AQI："+isNull(data.aqi)+"</span>"
	+"<span>PM2.5："+isNull(data.PM2)+"</span>"
	+"<span>PM10："+isNull(data.PM10)+"</span>"
	+"<span>CO："+isNull(data.CO)+"</span>"
	+"<span>No2："+isNull(data.No2)+"</span>"
	+"<span>O3："+isNull(data.O3)+"</span>"
	+"<span>So2："+isNull(data.So2)+"</span>";
	//+"</br><input type='button' value='周边分析' onclick='peripheralAnalysis("+isNull(data.pointCode)+")'/>";
	
	$("#monitrorTime").html(data.monitrorTime);
	$("#cityName").html(data.pointName);
	var code = data.pointCode;
	
	$.ajax({
		type : 'POST',
		url : '/enviromonit/airMonitorPoint/getChildrenPointByType',
		async : false,
		data: {type:type,pointCode:data.pointCode},
		success : function(data) {
			var listHtml=''; 
			$.each(data,function(i){ 
				if(code != data[i].uuid){
					listHtml += "<label class='form-checkbox'> <input name='cityType' type='checkbox'  value='"+data[i].uuid+"'/>"
	                 +"<span class='lbl' >"+data[i].name+"</span></label>";
				}
				
			}); 
			$("#selectGrop")[0].innerHTML=listHtml;
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
	var radio = '';
	var pollute = [{'key':'aqi','text':'AQI'},{'key':'A34004','text':'PM2.5'},{'key':'A34002','text':'PM10'},{'key':'A21004','text':'NO2'},{'key':'A21005','text':'CO'},{'key':'A05024','text':'O3'},{'key':'A21026','text':'SO2'}];
	for ( var i = 0; i <pollute.length; i++){
		if(i == 0){
			radio +="<span class='active'  timeData='"+pollute[i].key+"'>"+pollute[i].text+"</span>";
		}else{
			radio +="<span  timeData='"+pollute[i].key+"'>"+pollute[i].text+"</span>";
		}
	}
	var option = '';
	var day = [{'key':'24h','text':'24小时'},{'key':'30d','text':'30天'},{'key':'1y','text':'1年'}];
	
	for ( var i = 0; i <day.length; i++){
		if(i == 0){
			option +="<span class='active' timeData='"+day[i].key+"'>"+day[i].text+"</span>"
		}else{
			option +="<span  timeData='"+day[i].key+"'>"+day[i].text+"</span>"
		}
	}
	
	$("#radioList")[0].innerHTML=radio;
	$("#option")[0].innerHTML=option;
    $('#air').window('open');
    point = code+",";
    searchAirChar();
}

/*城市站点和监测站点的图表显示*/
function searchAirChar(){
	var pointCode = point;
    var citys = $("input[name='cityType']:checked");
    for(var i=0;i<citys.length;i++){ 
    	pointCode += $(citys[i]).val() +","; 
	} 
	$.ajax({
		type : 'POST',
		url : '/enviromonit/airEnvironment/getDataAnalysisCityPoint',
		async : true,
		data : {
			polluteName : $(".radio-button-group1 .active").attr("timeData"),
			pointCode : pointCode,
			time : $(".radio-button-group2 .active").attr("timeData")
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
	                    color:'#000000'
					},
	                left:'10',
					top:'10'
	            },
	            toolbox : {
					show : true,
					iconStyle : {
						borderColor : '#000000'
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
	                color:'#000000'
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
	                    color:'#000000'
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
function peripheralAnalysis(pointCode){
	$("#pointCode").val(pointCode);
	$('#peripheralAnalysis').window('open');
	
}
function selectPeripheral(){
	var pointCode = $("#pointCode").val().trim();
	var distance = $("#distance").val().trim();
	if(distance){
		window.open(Ams.ctxPath+"/enviromonit/air/nearbyAnalysis?code="+pointCode+"&range="+distance);
		$('#peripheralAnalysis').window('close');
	}else{
		alert("请填写范围数值");
	}
	
	
}
function close(){
	self.parent.$('#peripheralAnalysis').window('close');
}

/*地图上各种点的添加*/
/*添加城市和监测点*/
function creatMarker(type,factor,pointCode){
	//向地图上添加自定义标注
	$.ajax({   
	    type: 'POST',   
	    dataType : 'json',  
	    async: false,
	    url: Ams.ctxPath+'/enviromonit/airMonitorPoint/getCityByType',   
	    data: {type:type,factor:factor,pointCode:pointCode },   
	    success: function(data){   
	    	
	    	var markes = [];
		  	$.each(data,function(i){
		  		if(data[i].longitude == '-' && data[i].latitude == '-'){
		  			return true;
				}
		  		var marker;
	            //设置信息窗口要显示的内容
	            var color = "#b8b8b8";
	            var clas = "map-sign-tag";
				if (data[i].color >=0 && data[i].color <=50) {
					color = "#00E400";
					clas = "map-sign-tag green-sign-tag";
				} else if (data[i].color >=51 && data[i].color <=100) {
					color = "#CFCF00";
					clas = "map-sign-tag yellow-sign-tag";
				} else if (data[i].color >=101 && data[i].color <=150) {
					color = "#FF7E00";
					clas = "map-sign-tag red-sign-tag";
				} else if (data[i].color >=151 && data[i].color <=200) {
					color = "#FF0000";
					clas = "map-sign-tag violet-sign-tag";
				} else if (data[i].color >=201 && data[i].color <=300) {
					color = "#99004C";
					clas = "map-sign-tag brown-sign-tag";
				} else if (data[i].color >=301 && data[i].color <=500) {
					color = "#7E0023";
					clas = "map-sign-tag blue-sign-tag";
				}
				//创建信息窗口对象
				var html = "";
				if(type == 2){
				    html = "<div class ='infowindow' style='width: 120px;text-align: center;cursor:pointer;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>" +
	              "<div style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;background-color:"+
	              color+"' dataStr='"+JSON.stringify(data[i])+"' onclick= 'show(this,"+type+");'>"+data[i].value+
	              "</div></div><div class='tdt-infowindow-tip-container'><div class='tdt-infowindow-tip'></div></div><div  >"+data[i].pointName+"</div></div>";
				} else {
				    html = "<div class='infowindow " + clas + "' dataStr='"+JSON.stringify(data[i])+"' onclick= 'show(this,"+type+");'><div class='sign-info'><span class='sign-nub'>" + data[i].value + "</span><span class='sign-name'>"
				    + data[i].pointName + "</span></div></div>";
				}
				
				//创建pint
				var point = new fjzx.map.Point(data[i].longitude ,data[i].latitude);
				var myMarker = new fjzx.map.Marker(point, {
		        	    markerHtml : html,
						map : map,
						isShowIcon :false,
				});
				map.addOverlay(myMarker);
	  			if(type == '1'){
					cityPoint[i] = myMarker;
				}
				else if(type == '0'){
					monitorPoint[i] = myMarker;
				}else if(type == '2'){
					builtPoint[i] = myMarker;
				}
				//向地图上添加信息窗口
		  	});
		}   
	}); 
	
}


function creatAir(type,factor,pointCode){
	//向地图上添加自定义标注

	$.ajax({   
	    type: 'POST',   
	    dataType : 'json',  
	    url: Ams.ctxPath+'/enviromonit/airMonitorPoint/getCityByType',   
	    data: {type:type,factor:factor,pointCode:pointCode },   
	    success: function(data){   
	    	
		  	$.each(data,function(i){
	            //创建信息窗口对象
	            //设置信息窗口要显示的内容
		  		if(data[i].longitude == '-' && data[i].latitude == '-'){
		  			return true;
				}
	            var color = "#b8b8b8";
	            var clas = "map-sign-tag";
                if (data[i].color >=0 && data[i].color <=50) {
                    color = "#00E400";
                    clas = "map-sign-tag green-sign-tag";
                } else if (data[i].color >=51 && data[i].color <=100) {
                    color = "#CFCF00";
                    clas = "map-sign-tag yellow-sign-tag";
                } else if (data[i].color >=101 && data[i].color <=150) {
                    color = "#FF7E00";
                    clas = "map-sign-tag red-sign-tag";
                } else if (data[i].color >=151 && data[i].color <=200) {
                    color = "#FF0000";
                    clas = "map-sign-tag violet-sign-tag";
                } else if (data[i].color >=201 && data[i].color <=300) {
                    color = "#99004C";
                    clas = "map-sign-tag brown-sign-tag";
                } else if (data[i].color >=301 && data[i].color <=500) {
                    color = "#7E0023";
                    clas = "map-sign-tag blue-sign-tag";
                }
				//创建信息窗口对象
				var html = "";
                if(type == 2){
                    html = "<div class ='infowindow' style='width: 120px;text-align: center;cursor:pointer;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>" +
                  "<div style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;background-color:"+
                  color+"' dataStr='"+JSON.stringify(data[i])+"' onclick= 'show(this,"+type+");'>"+data[i].value+
                  "</div></div><div class='tdt-infowindow-tip-container'><div class='tdt-infowindow-tip'></div></div><div  >"+data[i].pointName+"</div></div>";
                } else {
                    html = "<div class='infowindow " + clas + "' dataStr='"+JSON.stringify(data[i])+"' onclick= 'show(this,"+type+");'><div class='sign-info'><span class='sign-nub'>" + data[i].value + "</span><span class='sign-name'>"
                    + data[i].pointName + "</span></div></div>";
                }
                
                if(type == '1'){
					var markerHtml = cityPoint[i].getElement();
					$(markerHtml).find(".infowindow").html(html);	
				} else if(type == '0'){
					var markerHtml= monitorPoint[i].getElement();
					$(markerHtml).find(".infowindow").html(html);	
				} else if(type == '2'){
					var markerHtml= builtPoint[i].getElement();
					$(markerHtml).find(".infowindow").html(html);
				}
				
		  	});
			
		}   
	}); 
	
}


