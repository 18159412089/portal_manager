
//创建图片对象
//---------------国家站点图标----------//
 
 var icon1 = new fjzx.map.Icon(
		 "/static/images/water_lv1.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );

 var icon2 = new fjzx.map.Icon(
		 "/static/images/water_lv2.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );
 
 var icon3 = new fjzx.map.Icon(  
		 "/static/images/water_lv3.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );
 
 var icon4 =new fjzx.map.Icon( //Ⅴ
		 "/static/images/water_lv4.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );
 
 var icon5 =new fjzx.map.Icon( //劣Ⅴ
		 "/static/images/water_lv5.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );
 var icon6 = new fjzx.map.Icon( //未知
		 "/static/images/water_lv6.png", 
		 { size:new fjzx.map.Size(30, 30),
	       imgSize:new fjzx.map.Size(30, 30),
		   anchor:new fjzx.map.Point(0, 30)
		 }
 );
 
 //---------------省站点图标---------------//
 
 var icon21 = new fjzx.map.Icon( // Ⅰ类和Ⅱ类质量图标
		 "/static/images/water_lv1.png",
		 { size:new fjzx.map.Size(20, 20),
	       imgSize:new fjzx.map.Size(20, 20),
		   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var icon22 = new fjzx.map.Icon(//Ⅲ
		 "/static/images/water_lv2.png",
		 {     
			   size:new fjzx.map.Size(20, 20),
		       imgSize:new fjzx.map.Size(20, 20),
			   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var icon23 = new fjzx.map.Icon( //Ⅳ
		 "/static/images/water_lv3.png",
		 {     
			   size:new fjzx.map.Size(20, 20),
		       imgSize:new fjzx.map.Size(20, 20),
			   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var icon24 =  new fjzx.map.Icon(//Ⅴ
		 "/static/images/water_lv4.png",
		 {     
			   size:new fjzx.map.Size(20, 20),
		       imgSize:new fjzx.map.Size(20, 20),
			   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var icon25 = new fjzx.map.Icon( //劣Ⅴ
		 "/static/images/water_lv5.png",
		 {     
			   size:new fjzx.map.Size(20, 20),
		       imgSize:new fjzx.map.Size(20, 20),
			   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var icon26 = new fjzx.map.Icon( //未知
		 "/static/images/water_lv6.png",
		 {     
			   size:new fjzx.map.Size(20, 20),
		       imgSize:new fjzx.map.Size(20, 20),
			   anchor:new fjzx.map.Point(10, 20)
		 }
 );
 
 var outfall_icon =new fjzx.map.Icon( //排口
		 "/static/images/water_outfall.png",
		 {     
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 var outfall2_icon =new fjzx.map.Icon( //排口
		 "/static/images/water_outfall2.png",
		 {     
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 
 var sewagePlant_icon = new fjzx.map.Icon( //排口
		 "/static/images/water_sewagePlant.png",
		 {     
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 var sewagePlant2_icon = new fjzx.map.Icon( //排口
		 "/static/images/water_sewagePlant2.png",
		 {     
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 
 var  patrol_icon = new fjzx.map.Icon( //巡河
		 "/static/images/patrol.png",
		 {     
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 var reservoir_icon = new fjzx.map.Icon( //排口
		 "/static/images/reservoir.png",
		 {
			   size:new fjzx.map.Size(25, 25),
		       imgSize:new fjzx.map.Size(25, 25),
			   anchor:new fjzx.map.Point(12, 25)
		 }
 );
 
 var wpfsqy_icon = new fjzx.map.Icon( //水库
	"/static/images/water/wpfsqy.png",{
		size:new fjzx.map.Size(25, 25),
		imgSize:new fjzx.map.Size(25, 25),
		anchor:new fjzx.map.Point(12, 25)
});
var water_case_icon = new fjzx.map.Icon(
    "/static/images/water_case.png",
    {
        size: new fjzx.map.Size(25, 25),
        imgSize: new fjzx.map.Size(25, 25),
        anchor: new fjzx.map.Point(12, 25)
    }
);

$.parser.onComplete = function() {
	$("#loadingDiv").fadeOut("normal", function() {
		$(this).remove();
	});
};

function addTab(subtitle, id) {
	var $targetTabs = $(".tabs-panel");
	var $targetContent = $targetTabs.siblings(".tabs-content");
	if (!hasTabs(subtitle)) {
		var tabsId = '#mapTabs_' + id;
		var tabsHTML = '<li class="tabs-item">\
					<a class="tabs-inner active" data-target="#mapTabs_' + id + '">' + subtitle + '</a>\
				</li>';

		$targetTabs.find(".tabs-inner").removeClass('active');
		$targetContent.find(".body-box").hide();
		$targetTabs.append(tabsHTML);
		$(tabsId).show();
		$('#' + id + 'Dg').datagrid("options").url = $(tabsId).attr("url");
		$('#' + id + 'Dg').datagrid('load', {});
	}
}

function tabClose(id) {
	var $targetTabs = $(".tabs-panel");
	var $targetContent = $targetTabs.siblings(".map-panel-body");
	var tabsId = '#mapTabs_' + id;
	$("[data-target='" + tabsId + "']").remove();
	$(tabsId).hide();
	selectTab($targetTabs.find(".tabs-inner").length - 1);
}

function selectTab(index) {
	var $targetTabs = $(".tabs-panel");
	$targetTabs.find(".tabs-inner").eq(index).trigger("click");
}

function hasTabs(title) {
	$(".tabs-panel").find(".tabs-inner").each(function() {
		if ($(this).text() === title) {
			return true;
		}
	});
}

$(".map-panel-header").on("click", function() {
	var $target = $(this).parent();
	if ($target.hasClass("collapsed")) {
		$target.removeClass("collapsed");
	} else {
		$target.addClass("collapsed");
	}
});

$("#timeList,#polluteCodeList").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchWaterPointBar();
});

$("#basin_polluteList").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchAnalysis();
});

$("#basin_polluteList_tb").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchAnalysis_tb();
});

$("#basin_polluteList_njdb").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchAnalysis_njdb();
});

$("#outfallTimeList,#outfallPltCodeList").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchConHourBar();
});

$("#reservoirTimeList").on("click", "span", function() {
	$(this).siblings("span").removeClass("active");
	$(this).addClass("active");
	searchConDayBar();
});

/*tabs*/
$('.tabs-panel').on('click', '.tabs-inner', function() {
	$(this).parents(".tabs-panel").find(".tabs-inner").removeClass('active');
	$(this).addClass('active');
	var target = $(this).attr("data-target");
	$(target).show();
	$(target).siblings(".body-box").hide();
});

/*筛选与tabs的联动*/
$('.filter-content').on('click', '.no-choice', function() {
	var cl_n = $(this);
	var subtitle = $(this).attr("title");
	var tid = $(this).attr("id");
	if (cl_n.hasClass('choiced')) {
		cl_n.removeClass('choiced');
		tabClose(tid);
	} else {
		$(".map-panel").find(".map-panel-body").css({"height":"550px"});
		cl_n.addClass('choiced');
		addTab(subtitle, tid);
	}
});

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
	var seconds = d.getSeconds();openPointDlg
	if (seconds >= 0 && seconds <= 9) {
		seconds = "0" + seconds;
	}
	var currentdate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
	return currentdate;
}

function addOtherPoints() {
	var checkboxs = "";
	for (var i = 0; i < pointsData.length; i++) {
		if (selectedPointInfo.mn != pointsData[i].mn) {
			checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_mnname" type="checkbox" value="'
				+ pointsData[i].mn + '"/><span class="lbl">' + pointsData[i].mnname + '</span></label>';
		}
	}
	for (var i = 0; i < miniMonitorData.length; i++) {
		if (selectedPointInfo.mn != miniMonitorData[i].mn) {
			checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_mnname" type="checkbox" value="'
				+ miniMonitorData[i].mn + '"/><span class="lbl">' + miniMonitorData[i].mnname + '</span></label>';
		}
	}
	$("#monitorList").html(checkboxs);
}
