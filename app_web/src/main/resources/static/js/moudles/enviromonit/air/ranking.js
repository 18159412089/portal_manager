//站点排名查询
function rankingPoint(){
	$('#provinceRankingTable').datagrid({
	    url: Ams.ctxPath+'/enviromonit/airHourData/rankingOrderByAQI',
	    queryParams: {
	    	pointType: '0'
		},
		onLoadSuccess:function(){
			var rows = $("#provinceRankingTable").datagrid("getRows");
            if(rows.length != 0){
            	 $("#provinceRanking .other").html(rows[0].monitrorTime);
            }
	    	 loopScrollOdj("provinceRanking",50,40);
		},
		onDblClickRow:function(rowIndex,rowData){
            window.open("/enviromonit/airEnvironment/detail?pid=7c4eb149-2475-4cad-97c9-e4760938de3f&airPointCode="+rowData.pointCode+"&airPointType=0");
        }
	});
}
//区县排名查询
function rankingCity(){
	$('#countyRankingTable').datagrid({
	    url: Ams.ctxPath+'/enviromonit/airHourData/rankingOrderByAQI',
	    queryParams: {
	    	pointType: '1'
		},
		onLoadSuccess:function(){
			var rows = $("#countyRankingTable").datagrid("getRows");
            if(rows.length != 0){
            	 $("#countyRanking .other").html(rows[0].monitrorTime);
            }
	      loopScrollOdj("countyRanking",50,40);
		},
		onDblClickRow:function(rowIndex,rowData){
            window.open("/enviromonit/airEnvironment/detail?pid=7c4eb149-2475-4cad-97c9-e4760938de3f&airPointCode="+rowData.pointCode+"&airPointType=1");
        }
	}); 
}

function rankingWater(){
	$('#waterMonitoringTable').datagrid({
		url: Ams.ctxPath+'/enviromonit/water/wtHourData/getWtRealTimeData',
		onLoadSuccess:function(){
			var rows = $("#waterMonitoringTable").datagrid("getRows");
			if(rows.length != 0){
				$("#waterMonitoring .other").html('实时：'+Ams.dateFormat(rows[0].datatime,'yyyy-MM-dd HH:mm'));
			}
			 loopScrollOdj("waterMonitoring",50,40);
		},
		onDblClickRow:function(rowIndex,rowData){
            window.open("/enviromonit/water/nationalSurfaceWater?pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369&waterPointCode="+rowData.pointCode);
        }
	});
}
function rankingMonitoringDetailsTable(){
	$('#monitoringDetailsTable').datagrid({
		url: Ams.ctxPath+'/gridRemote/service/getCommonlyCaseList',
		onLoadSuccess:function(){
			/*var rows = $("#monitoringDetailsTable").datagrid("getRows");
            if(rows.length != 0){
                $("#monitoringDetails .other").html('实时：'+Ams.dateFormat(rows[0].reportTime,'yyyy-MM-dd HH:mm'));
            }*/
			  loopScrollOdj("monitoringDetails",50,40);
		}
	});
}
//序号文字样式
function numStyle(value,row,index){ 	
	 return  '<span class="ranking">'+value+'</span>';
 } 
//天气状况
function weather(){
	$.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/environment/hugeData/getWeather',
        async:true,
        success: function (data) {
        	var result = eval('(' + data + ')');
        	console.info(result)
        	$("#wTime").html(result.date);
        	$("#wAddre").html(result.results[0].currentCity);
        	var wData = result.results[0].weather_data;
        	var temp = wData[0].date.substring(wData[0].date.indexOf("：")+1,wData[0].date.indexOf("℃"));
        	$("#wTemp").html(temp);
        	$(".wWind").html(wData[0].wind);
        	$("#wDayP").attr('src',wData[0].dayPictureUrl);
        	$("#wNightP").attr('src',wData[0].nightPictureUrl);
        	var temperature = wData[0].temperature;
        	$("#wDayTemp").html(temperature.substring(0,temperature.indexOf(" ")));
        	$("#wNightTemp").html(temperature.substring(temperature.indexOf(" ")+3,temperature.indexOf("℃")));
        	
        	var humidity = Math.floor(Math.random()*10)+63;
        	$("#humidity").html(humidity);
        }
	});
}

/*---简单循环滚动---*/
function loopScroll($obj,offset,speed){
	setTimeout(function(){
		$obj.animate({scrollTop:offset},speed,'linear',function(){
			$obj.scrollTop(0);
		});
	},1000);
	
}
function loopScrollOdj(objname,speed,delay) {
	var obj,offset;
	delay=delay?delay:0;
    this.obj = obj = $("#"+objname+" .home-ranking-list .datagrid-body");
    this.objC = this.obj.children(".datagrid-btable");
    this.offset = offset = this.objC.height()-this.obj.height()+delay;
    this.speed = speed = speed*this.offset;
    this.lFunction = function(){
    	loopScroll(this.obj,this.offset,this.speed);
    }
    this.lFunction();
    this.Scroll=self.setInterval(function(){
    		loopScroll(obj,offset,speed)
    },this.speed);
    this.clearScroll=function(){
    	clearInterval(this.Scroll);
    };
}

