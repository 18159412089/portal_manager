var miniMonitors = new Array();
var miniMonitorData = new Array();
function getMiniMonitor(){
	if ($("#miniMonitor").hasClass('choiced')) {
		$("#pointNameQuery").textbox('setValue', '');
		for (var i = 0; i < miniMonitors.length; i++) {
			map.removeOverlay(miniMonitors[i]);
		}
		miniMonitors = new Array();
	} else {
	
	$.ajax({
		type : "post",
		url : "/enviromonit/water/nationalSurfaceWater/listNoPage",
		async : true,
		data : {polluteCode :  $("span.ant-radio-button-checked input").val(), category:"3"},
		//data : {polluteCode :  $(".point-group .select-point").attr("value"), category:"3"},
		success : function(result) {
			var data = result.data;
			for (var i = 0; i < data.length; i++) {
				var icon = icon6;
				var color = "#b8b8b8";
				if (data[i].quality == "Ⅰ" || data[i].quality == "Ⅱ") {
					icon = icon1;
					color = "#2ba4e9";
				} else if (data[i].quality == "Ⅲ") {
					icon = icon2;
					color = "#45b97c";
				} else if (data[i].quality == "Ⅳ") {
					icon = icon3;
					color = "#FFFF00";
				} else if (data[i].quality == "Ⅴ") {
					icon = icon4;
					color = "#f47920";
				} else if (data[i].quality == "劣Ⅴ") {
					icon = icon5;
					color = "#d02032";
				}
		 
	            var clickDiv = null ;
	            	clickDiv = "<div style='width: 120px;text-align: center'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
	            	+"<div id='monitor_"+data[i].mn+"' style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;"
					+"background-color:"+color+"' onclick='openPointDlg(JSON.stringify(miniMonitorData["+i+"]))'>"+data[i].value+"</div>"
					+"</div><p style='font-weight:bold;'>"+data[i].mnname+"</p></div>";
	            //创建pint
	            var point = new fjzx.map.Point(data[i].lng, data[i].lat);
				//创建地图marker点 
	            var  myMarker = new fjzx.map.Marker(point, {
	        	    markerHtml : clickDiv,
					map : map,
					isShowIcon :false,
					title:data[i].mnname,
					id:data[i].mn
				});
	            miniMonitors.push(myMarker);
				map.addOverlay(myMarker);
				if(miniMonitorData.length!=data.length){
					miniMonitorData.push(data[i]);
				}
			}
		 
		},
		error : function() {},
		dataType : 'json'
	});
	}
};

//微型自动监测站列表中的双击事件
$("#miniMonitorDg").datagrid({
 	onDblClickRow: function (index, row) {
		map.setCenter(new fjzx.map.Point(row.lng,row.lat));
		openPointDlg(JSON.stringify(row));
 	}
 });
