var map = null;
var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";

		function initMapSurfaceAir() {
		    var longitude = "117.62";
            var latitude = "24.13";
			map = initMap({
				target : "mapDiv",
				center : [ parseFloat(longitude), parseFloat(latitude) ],
				layers : fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
				zoom: 10.5,
                minZoom: 10.5,
                maxZoom: 23
			});
			map.render();
			//加载漳浦县区域
			setZpxArea();
			
			var separation = 8;// 子组件展开时的间距。
            var size = 60;
            $('div.basemap-toggle').on({
                mouseenter: function (e) {
                    expand(e);
                },
                mouseleave: function (e) {
                    collapse(e);
                }
            });
            $('div.basemap-toggle').find('.basemap').click(function(){
                // 已经选中则返回。
                if (!!$(this).attr("selected")) {
                    return;
                }
                var layerGroupName = $(this).attr("layer-group-name");
                $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index',0);

                // 标记选中状态。
                $(this).attr("selected", "selected");
                //$(this).css("z-index", 10000);
                $(this).animate({
                    top: 0
                }, 200);
                collapse(0);
                // 显示当前底图。
                map.getLayers().forEach(function(layer,i){
                    if(layer instanceof ol.layer.Group){
                        layer.getLayers().forEach(function(sublayer,j){
                            map.removeLayer(sublayer);
                        });
                    }
                });
                var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
                console.log(layerGroup);
                console.log($(this));
                map.setLayerGroup(layerGroup);
                // 加载漳浦县区域
                setZpxArea();
            });

            function expand() {
                var $domNode = $('div.basemap-toggle');
                var baseMaps = $domNode.children(".basemap");
                var count = 0;
                // 如果已经展开，则返回。
                if (!!$domNode.attr("expand")) {
                    return;
                }
                // 标记展开状态。
                $domNode.attr("expand", "expand");
                // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
                $domNode.css("height", (size + separation) * baseMaps.length + "px");
                for (var i = 0; i < baseMaps.length; i++) {
                    // 如果不是选中项则执行展开并显示。
                    console.log(!$(baseMaps[i]).attr("selected"));
                    if (!$(baseMaps[i]).attr("selected")) {
                        count++;
                        $(baseMaps[i]).css("display", "block");
                        $(baseMaps[i]).animate({
                            top: "+=" + (size + separation) * count
                        }, 300, function (count) {
                            $(this).css("display", "block");
                            $(this).css("top", (size + separation) * count + "px");
                        });
                    }
                }
            }

            function collapse(time) {
                var $domNode = $('div.basemap-toggle');
                var baseMaps = $domNode.children(".basemap");
                var count = 0;
                if (Object.prototype.toString.call(time) !== "[object Number]") {
                    time = 200;
                }
                // 如果没有展开，则返回。
                if (!$domNode.attr("expand")) {
                    return false;
                }
                // 移出展开状态标记。
                $domNode.removeAttr("expand");
                $domNode.css("height", size + "px");
                for (var i = 0; i < baseMaps.length; i++) {
                    // 如果不是选中项则执行收起并隐藏。
                    if (!$(baseMaps[i]).attr("selected")) {
                        count++;
                        $(baseMaps[i]).animate({
                            top: "-=0"
                        }, time, function () {
                            $(this).css("display", "none");
                            $(this).css("top", 0);
                        });
                    }
                }
            }
		}
initMapSurfaceAir();

var labelArray = new Array(); //文本数组

var newTime;

//创建排气口图片对象
var icon15 = new fjzx.map.Icon(
	"/static/images/air/export.png",
	{ size:new fjzx.map.Size(30, 30),
	  imgSize:new fjzx.map.Size(30, 30),
	  anchor:new fjzx.map.Point(0, 30)
	}
);
//创建排气口图片对象(超标)
var exportoverIcon = new fjzx.map.Icon(
	"/static/images/air/exportover.png",
	{ size:new fjzx.map.Size(30, 30),
		imgSize:new fjzx.map.Size(30, 30),
		anchor:new fjzx.map.Point(0, 30)
	}
);



var export2 = new fjzx.map.Icon(
    "/static/images/air/export2.png",
    { size:new fjzx.map.Size(30, 30),
  	  imgSize:new fjzx.map.Size(30, 30),
  	  anchor:new fjzx.map.Point(0, 30)
  	}
);

//创建在建工地图片对象
var icon16 = new fjzx.map.Icon(
    "/static/images/air/site.png",
    { size:new fjzx.map.Size(30, 30),
  	  imgSize:new fjzx.map.Size(30, 30),
  	  anchor:new fjzx.map.Point(0, 30)
  	}
);
//污普排气企业图片
var waste_gas = new fjzx.map.Icon(
    "/static/images/air/waste_gas.png",
    { size:new fjzx.map.Size(30, 30),
  	  imgSize:new fjzx.map.Size(30, 30),
  	  anchor:new fjzx.map.Point(0, 30)
  	}
);


/*更新地图中心*/
function updateMap(longitude,latitude,pointCode,monitrorTime,color,cityName,pointType){
	if(pointType == '1'){
		// 用于生成该城市下的监测站点的排名
		ranking(pointType,'0',pointCode);
		size = 13;
		map.getView().setZoom(size);
		map.setCenter([ parseFloat(longitude), parseFloat(latitude) ]);
		map.render();
		f = 1; //标记点击过排名
		remove(labelArray);
		remove(cityPoint);
		remove(monitorPoint);
		//creatMarker("0",$("span.ant-radio-button-checked input").val(),pointCode);
		creatMarker("0",$(".point-group .select-point").attr("value"),pointCode);
		code = pointCode;
	}else{
		map.setCenter([ parseFloat(longitude), parseFloat(latitude) ]);
	}
}

function updateMp(longitude,latitude){
	map.getView().setZoom(13);
	map.setCenter([ parseFloat(longitude), parseFloat(latitude) ]);
	map.render();
}

function initView(map,factor){
	if(map.getView().getZoom()<=10.5 && size != map.getView().getZoom()){
		if(size == 0 ) {
			size = map.getView().getZoom();
			return 0;
		}
		if(size<=10.5){
			size = map.getView().getZoom();
			return 0;
		}
		remove(labelArray);
		size = map.getView().getZoom();
		remove(monitorPoint);
		creatMarker("1",factor);
		ranking("1","1");//第一个值是站点类型 第二个是站点级别	
		
		
	}else if(map.getView().getZoom()>10.5 && size != map.getView().getZoom()){
		if(size >10.5 ) {
			size = map.getView().getZoom();
			//map.removeOverLay(markerInfoWin);
			return 0;
		}
		remove(labelArray);
		size = map.getView().getZoom();
		remove(cityPoint);
		creatMarker("0",factor);
		ranking("0","0");
	}
}


$(function () {
	/*滚动条*/
    $("#filterBox").mCustomScrollbar({
		theme:"light-3",
		scrollButtons:{
			enable:true
		}
	});
    /*对比*/
	$('body').on('click','.select-button',function () {
        $(this).next().addClass('show');
    });
	/*取消*/
    $('body').on('click','.cancel',function () {
        $(this).parents(".select-panel").removeClass('show');
        
    });
    /*tabs*/
    $('.tabs-panel').on('click','.tabs-inner',function () {
        $(this).parents(".tabs-panel").find(".tabs-inner").removeClass('active');
        $(this).addClass('active');
        var target=$(this).attr("data-target");
        $(target).show();
        $(target).siblings(".body-box").hide();
    });
    /*筛选与tabs的联动*/
    $('.filter-content').on('click','.no-choice',function () {
        var cl_n=$(this);
        var subtitle=$(this).attr("title");
        var tid=$(this).attr("id");
        if(cl_n.hasClass('choiced')){
            cl_n.removeClass('choiced');
            if(tid=='truck'){
            	clearTruckArea();
            } else if(tid == 'noFireworksArea') {
            	clearNoFireworksArea();
            } else {
            	tabClose(tid);
            }

			if ($(".choiced").length == 0) {
				$("#map-panel2"). find(".map-panel-body").css({"height":"auto"});
			}
        }else{
            cl_n.addClass('choiced');
			if(tid=='truck') {
				layTruckArea(map);
				map.centerAndZoom(new T.LngLat(117.66941,24.53135), 12);
			} else if(tid == 'noFireworksArea') {
            	layNoFireworksArea(map);
            } else {
    	    	addTab(subtitle,tid);
    	    }
			$("#map-panel2"). find(".map-panel-body").css({"height":"545px"});
		}
	});
    
    
    /*地图监听事件 删除和添加地图上的点*/
    map.on('moveend', function (e) {
    	//var factor = $("span.ant-radio-button-checked input").val();
    	var factor = $(".point-group .select-point").attr("value");
    	if(f == 1){
    		if(map.getView().getZoom()<10.5 && size != map.getView().getZoom()){
        		if(size < 10.5 ) {
        			size = map.getView().getZoom();
        			return 0;
        		}
        		remove(labelArray);
        		size = map.getView().getZoom();
        		
        		remove(monitorPoint);
        		creatMarker("1",factor);
        		ranking("1","1");
        		f=0;
        	}
    		
    	}
    	// 没点击排名的时候，地图放大和缩小就显示对应的城市站点或者监测站点（所有）
    	if(f == 0) {
    		initView(map,factor)
    	}
    	
    })
	loadAirData();
})   
/*查询*/
function doOutSearch(id) {
    if(id == 'enterprise'){
    	$('#'+id+'Dg').datagrid('load', {
    		outName: $("#queryOutName").val().trim()
       	});
    }else if(id == 'construction'){
    	$('#'+id+'Dg').datagrid('load', {
    		name: $("#containerName").val().trim()
       	});
    }
}
function addTab(subtitle,id) {
	var $targetTabs=$(".tabs-panel");
	var $targetContent=$targetTabs.siblings(".tabs-content");
    if (!hasTabs(subtitle)) {
    	var tabsId='#mapTabs_'+id;
		var tabsHTML='<li class="tabs-item">\
				<a class="tabs-inner active" data-target="#mapTabs_'+id+'">'+subtitle+'</a>\
			</li>';
        $targetTabs.find(".tabs-inner").removeClass('active');		        
        $targetContent.find(".body-box").hide();
        $targetTabs.append(tabsHTML);
        $(tabsId).show();
        $('#'+id+'Dg').datagrid("options").url = $(tabsId).attr("url");
        $('#'+id+'Dg').datagrid('load', {});
        console.log(tabsId);
    }
    if(id == 'enterprise'){
    	creatPeMonitorPoint(2);
    }else if(id == 'construction'){
    	creatConstruction()
    }
}

function miniMonitorSearch() {
    $('#miniMonitorDg').datagrid('load', {
    	pointName: $("#pointName").val().trim()
    });
}

//鼠标回车事件  【空气自建站点】
Ams.inputText_enterKeyEvent('pointName',miniMonitorSearch);

//空气自建站点列表中的双击事件
$("#miniMonitorDg").datagrid({
    onDblClickRow: function (index, row) {
        map.setCenter(new fjzx.map.Point(row.longitude,row.latitude));
        $.ajax({   
            type: 'POST',
            dataType : 'json',
            url: Ams.ctxPath+'/zphb/enviromonit/airMonitorPoint/getPointsInfo',
            data: {pointCode:row.pointCode },   
            success: function(data){   
                showAir(data,2);
            }   
        });
        
    }
 });

//废气排口列表中的双击事件
$("#enterpriseDg").datagrid({
    onDblClickRow: function (index, row) {
        map.setCenter(new fjzx.map.Point(row.longValue,row.latValue));
        showEnterprise(row);
    }
 });

//工地列表中的双击事件
$("#constructionDg").datagrid({
    onDblClickRow: function (index, row) {
        map.setCenter(new fjzx.map.Point(row.longitude,row.latitude));
        showContainer(row);
    }
 });

//废气排口列表中的双击事件
$("#wpfqqyDg").datagrid({
    onDblClickRow: function (index, row) {
        map.setCenter(new fjzx.map.Point(row.lng,row.lat));
        getWpfqqyInfo(row);
        $('#wpfqDg').dialog('open').dialog('center').dialog('setTitle', '企业详情');
    }
 });

// 【废气排口】
function enterpriseSearch() {
    $('#enterpriseDg').datagrid('load', {
    	outName: $("#outName").val().trim()
    });
}
//鼠标回车事件  【废气排口】
Ams.inputText_enterKeyEvent('outName',enterpriseSearch);

// 【工地】
function constructionSearch() {
    $('#constructionDg').datagrid('load', {
    	name: $("#constructionName").val().trim()
    });
}

//鼠标回车事件  【工地】
Ams.inputText_enterKeyEvent('constructionName',constructionSearch);

function getMiniMonitor(){
	if ($("#miniMonitor").hasClass('choiced')) {
		$("#pointName").textbox('setValue', '');
		remove(builtPoint);
	} else {
		//creatMarker("2",$("span.ant-radio-button-checked input").val());
		creatMarker("2", $(".point-group .select-point").attr("value"));
	}
}

function tabClose(id) {			
	var $targetTabs=$(".tabs-panel");
	var $targetContent=$targetTabs.siblings(".map-panel-body");
	var tabsId='#mapTabs_'+id;
	$("[data-target='"+tabsId+"']").remove();
	$(tabsId).hide();
    selectTab($targetTabs.find(".tabs-inner").length-1);
    if(id == 'enterprise'){
    	$("#outName").textbox('setValue', '');
    	$("#outSearchBar").find("#outSearchForm").form('clear');
    	remove(peMonitorPoint);
    }else if(id == 'construction'){
    	$("#constructionName").textbox('setValue', '');
    	$("#containerSearchBar").find("#containerSearchForm").form('clear');
    	remove(construction);
    }
}
function selectTab(index) {			
	var $targetTabs=$(".tabs-panel");
	$targetTabs.find(".tabs-inner").eq(index).trigger("click");
}

function hasTabs(title){
	$(".tabs-panel").find(".tabs-inner").each(function(){
		if($(this).text()===title){
			return true;
		}
	});
}


/*删除地图上的点*/
function remove(marker){
	for (var i =0 ; i < marker.length; i++) { //倒序删除避免长度发生变化
			map.removeOverlay(marker[i]);
		}
}
 		
/*-------------------------------采用jquery easyui loading css效果   ----------------------------------*/ 
        
function ajaxLoading(){   
    $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:(($(document.body).outerWidth(true) - 190) / 2),top:($(window).height()- 100) / 2,width:"200px",height:"50px" });   
}   
function ajaxLoadEnd(){   
     $(".datagrid-mask-msg").remove();               
} 
		
/*判断值是否为空*/
function isNull(value){
	if(value == null){
		return '-';
	}else{
		return value;
	}
}

//年数据大屏展示中点击大气中的监控情况进入1行政区,2测点,3废气排口,4工地,5工业废气企
function loadAirData() {
	var target =$("#targetId").val();
	if (target == 1) {//行政区不作处理

	} else if (target == 2) {//本页空气自建站点
		getMiniMonitor()
		$("#miniMonitor").addClass("choiced");
		addTab("空气自建站点", "miniMonitor")
	} else if (target == 3) {
		$("#enterprise").addClass("choiced");
		addTab("废气排口", "enterprise")
	} else if (target == 4) {
		$("#construction").addClass("choiced");
		addTab("工地", "construction")
	} else if (target == 5) {
		getWpfqqy();
		$("#wpfqqy").addClass("choiced");
		addTab("工业废气企业", "wpfqqy")
	}
}
