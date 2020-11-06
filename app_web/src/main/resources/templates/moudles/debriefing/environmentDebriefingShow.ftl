<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>环保督察</title>

</head>
<style>
	.file-list li{
		margin-top:10px;
	}
	.file-list a{
		font-size:20px;
		color:#000000;
		text-decoration:none;
	}
</style>
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/mainMap.css"/>
<#include "/toolbar.ftl">

<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
   <!-- main -->
	<div id="mapDiv" class="map-wrapper" style="position:fixed;bottom:0;"></div>
	<!-- 地图层 -->

    <!-- 图例  -->
	<div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;">
		<div class="title">
			<div class="item">完成</div>
			<div class="item">整治中</div>
			<div class="item">滞后</div>
		</div>
		<div class="grade-legend">
			<div class="item excellent"></div>
			<div class="item good"></div>
			<div class="item moderate"></div>
		</div>
	</div>
	
	<!-- <div class="map-panel" style="position:absolute;top:86px;right:58px;">
        <div class="map-panel-header">
			<span class="title"><span class="icon iconcustom icon-zhedie3"></span>汇报文件</span>
        </div>
        <div class="map-panel-body" style="height: 540px;width:400px;position: relative;background: none;">
            <div class="body-box" id="filterBox" style="width:320px;height:auto;margin-left:80px; border-bottom: 1px solid #fff;border-color: rgba(255,255,255,0.15);">
				<div class="filter-container" style="margin-bottom: 12px;">
			        <div class="filter-box">
			            <div class="filter-title">文件</div>
			            <div class="filter-content">
			            	<ul class="file-list">
			            		<li><a href="http://www.baidu.com" target="_blank">1313212312</a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            		<li><a><font>1313212312</font></a></li>
			            	</ul>
			            </div>
			        </div>

			    </div>
			</div>
            
            <ul class="tabs-panel" style="top:220px;margin-right: -80px;">
			</ul>            
        </div>
    </div> -->
    <!-- 图例 over -->
    <!-- main over -->

</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:80%;height:80%" data-options="closed:true,modal:true,border:'thin'">
	<div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:100%;">
		<div title="简介" style="width:100%;height:100%;" onclick="pauseVideo()">
			<table style="width:99%;height:95%;margin:5px;">
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;" align="center" valign="middle"><font color="#999999" size="3" style="margin:35px">项目名称：</font></td>
		    		<td width="80%"><label id="name" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">项目简介：</font></td>
		    		<td width="80%"><label id="details" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">项目进度：</font></td>
		    		<td width="80%"><label id="status" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">所属地市：</font></td>
		    		<td width="80%"><label id="city" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">整改时限：</font></td>
		    		<td width="80%"><label id="timelimit" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">拟市级验收时间：</font></td>
		    		<td width="80%"><label id="pctime" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">实际市级验收时间：</font></td>
		    		<td width="80%"><label id="actime" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">拟行业审查时间：</font></td>
		    		<td width="80%"><label id="pttime" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">实际行业审查时间：</font></td>
		    		<td width="80%"><label id="attime" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">完成行业审查时间：</font></td>
		    		<td width="80%"><label id="overtime" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">是否超时：</font></td>
		    		<td width="80%"><label id="isover" style="width:100%;font-size:16px;"></label></td>
		    	</tr>
		    	<tr style="height:50px;vertical-align: middle;background:#F4F4F4;">
		    		<td style="width:20%;"><font color="#999999" size="3" style="margin:35px">项目图片：</font></td>
		    		<td width="80%"><img style="withd:200px;height:200px;" id="picture"></td>
		    	</tr>
		    </table>
		</div>
		<!-- <div title="视频">
			<p align="center" style="height:99%"><video id="video" controls="controls" preload>您的浏览器不支持 video 标签。</video></p>
		</div> -->
		<div title="附件">
			<table id="dg3" class="easyui-datagrid" style="width:100%;height:auto;"
	           data-options="
	            rownumbers:true,
	            singleSelect:true,
	            striped:true,
	            autoRowHeight:true,
	            fitColumns:true,
	            fit:true">
		        <thead>
		        <tr>
		            <th field="name" width="120">附件</th>
		            <th field="createDate" width="50" align="center" formatter="attachList">操作</th>
		        </tr>
		        </thead>
		    </table>		
		</div>
	</div>
</div>

<!-- 修改用户密码窗口 -->
<#include "/passwordModify.ftl"/>
<!-- 数据分析和详细信息窗口 -->
<#include "/moudles/enviromonit/air/airAnalysis.ftl"/>
<!-- 数据分析和详细信息窗口 -->
<#include "/moudles/enviromonit/air/enterpriseAnalysis.ftl"/>
<!-- 在建工地详细信息 -->
<#include "/moudles/enviromonit/air/projectAnalysis.ftl"/>

<script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<script>

	$.parser.onComplete = function () {
	    $("#loadingDiv").fadeOut("normal", function () {
	        $(this).remove();
	    });
	};
	
	var icon1 = new T.Icon({
	    iconUrl: "/static/images/air/city_1.png",
	    iconSize: new T.Point(35, 35),
	    iconAnchor: new T.Point(10, 25)
	});
	var icon2 = new T.Icon({
	    iconUrl: "/static/images/air/city_2.png",
	    iconSize: new T.Point(35, 35),
	    iconAnchor: new T.Point(10, 25)
	});
	var icon4 = new T.Icon({
	    iconUrl: "/static/images/air/city_4.png",
	    iconSize: new T.Point(35, 35),
	    iconAnchor: new T.Point(10, 25)
	});
	
    $(window).resize(function () {
    });
	
	$(function(){
		
	    $('.tabs-first').attr("onclick","pauseVideo()");
		
		//初始化地图对象
		var map = new T.Map("mapDiv");
	    //设置显示地图的中心点和级别
	    
	    map.centerAndZoom(new T.LngLat(117.64349, 24.51925), 9);
	
	    $.ajax({
			type: "POST",
			url:  Ams.ctxPath + "/environment/debriefing/debriefingList",
			dataType: "json",
			success: function(result){
				for (var i=0;i< result.length;i++) {
					var icon;
					var row = {};
					if("0"==result[i].stauts){
						icon=icon4;
					}else if("1"==result[i].stauts){
						icon=icon2;
					}else{
						icon=icon1;
					}
					row = new T.Marker(new T.LngLat(result[i].longitude, result[i].latitude),{icon:icon});
					add(row,result[i]);
					row.id = i;
			        map.addOverLay(row);
	           		addHandler(result[i],row);
				}
			}
		});
	});
	
	/*点击事件*/
    function addHandler(data,marker){
    	/* var markerInfoWin = new T.InfoWindow();
        var sContent = "<label>"+data.name+"</label></br><img style='width: 200px;height: 200px;' src='${request.contextPath}/environment/attach/file?uuid=" + data.picture + "'/>";
        markerInfoWin.setContent(sContent); */
		marker.addEventListener("mouseover", function () {
	        marker.openInfoWindow(picture(data.name, data.picture));
		});
	    marker.addEventListener("mouseout", function () {
	        marker.closeInfoWindow();
		});
        marker.addEventListener("click",function(e){
        	details(data.uuid);
        });
    }
    
    /*添加点位各种信息*/
   function add(row,data){
		row.uuid = data.uuid;
		row.latitude = data.latitude;
		row.longitude = data.longitude;
		row.picture = data.picture;
		row.name = data.name;
		row.status = data.status;
   }
    
   function picture(name, picture){
	   var markerInfoWin = new T.InfoWindow();
       var sContent = "<label>"+name+"</label></br><img style='width: 200px;height: 200px;' src='${request.contextPath}/environment/attach/file?uuid=" + picture + "'/>";
       markerInfoWin.setContent(sContent);
       return markerInfoWin;
	}
	
	function details(uuid){
    	$('#dlg').dialog('open').dialog('center').dialog('setTitle', '项目汇报');
		$.ajax({
			type: "POST",
			url: Ams.ctxPath + "/environment/debrief/details/getByDebriefing",
			dataType: "json",
			data : {
				debriefing : uuid
			},
			success: function(result){
    			if(result.name!=null)
					$('#dlg #name').text(result.name);
				else
					$('#dlg #name').text("");
    			if(result.status!=null)
					$('#dlg #status').text(result.status);
				else
					$('#dlg #status').text("");
    			if(result.details!=null)
					$('#dlg #details').text(result.details);
				else
					$('#dlg #details').text("");
    			if(result.city!=null)
					$('#dlg #city').text(result.city);
				else
					$('#dlg #city').text("");
    			if(result.timelimit!=null)
					$('#dlg #timelimit').text(result.timelimit);
				else
					$('#dlg #timelimit').text("");
    			if(result.pctime!=null)
					$('#dlg #pctime').text(result.pctime);
				else
					$('#dlg #pctime').text("");
    			if(result.actime!=null)
					$('#dlg #actime').text(result.actime);
				else
					$('#dlg #actime').text("");
    			if(result.pttime!=null)
					$('#dlg #pttime').text(result.pttime);
				else
					$('#dlg #pttime').text("");
    			if(result.attime!=null)
					$('#dlg #attime').text(result.attime);
				else
					$('#dlg #attime').text("");
    			if(result.overtime!=null)
					$('#dlg #overtime').text(result.overtime);
				else
					$('#dlg #overtime').text("");
    			if(result.isover!=null){
    				if(result.isover==0){
						$('#dlg #overtime').text('按时');
    				}else{
						$('#dlg #overtime').text('超时');
    				}
    			}else
					$('#dlg #overtime').text("");
    			if(result.picture!=null)
					$('#dlg #picture').attr("src", Ams.ctxPath + "/environment/attach/file?uuid=" + result.picture);
    			if(result.video!=null){
    				$('#dlg #video').attr("src", Ams.ctxPath + "/environment/attach/video?uuid=" + result.video);
    				var withd_parent = $(".panel-body").width();
    				$('#dlg #video').attr("style","withd:"+withd_parent+"px;height:99%;");
    			}
			}
		});
		$('#dg3').datagrid({
		    url: Ams.ctxPath + '/environment/debrief/details/getAttachListByDebriefing',
		    queryParams:{
		    	debriefing :uuid
		    }
		});
	}
	
	function attachList(value,row,index){
    	var mongoid = row.mongoid;
    	var file = row.name;
    	if(typeMatch(imgExt, file)){
    		return "<a href='#' class='easyui-linkbutton' onClick=\"openImg('"+mongoid+"')\">看图</a>";
    	}else if(typeMatch(videoExt, file)){
    		return "<a href='#' class='easyui-linkbutton' onClick=\"openVideo('"+mongoid+"')\">播放</a>";
    	}else if(typeMatch(pdfExt, file)){
    		return "<a href='/environment/attach/download/"+mongoid+"/1' class='easyui-linkbutton' target='_blank'>查看</a>";
    	}else{
    		return "<a href='#' class='easyui-linkbutton' onClick=\"download2('"+mongoid+"')\">下载</a>";
    	}
    }
	
	function download2(mongoid){
    	var url = Ams.ctxPath + '/environment/attach/down?mongoid='+mongoid;
    	window.location.href=url;
    }
	
	function openPdf(mongoid){
	    var newWindow = window.open('');
	    newWindow.document.write('<video src="${request.contextPath}/environment/attach/file2?mongoid='+mongoid+'" controls="controls" preload/>');//换成你需要的地址
	    return false;
	}
	
	function openVideo(mongoid){
	    var newWindow = window.open('');
	    newWindow.document.write('<video src="${request.contextPath}/environment/attach/file2?mongoid='+mongoid+'" controls="controls" preload/>');//换成你需要的地址
	    return false;
	}
	
	function openImg(mongoid){
	    var newWindow = window.open('');
	    newWindow.document.write('<img src="${request.contextPath}/environment/attach/file2?mongoid='+mongoid+'"/>');//换成你需要的地址
	    return false;
	}

    $("#dlg").dialog({
    	onClose: function () {
    		if ($('#dlg #video').get(0).paused) {
    			//$('#video').get(0).play();
    		} else {
    			pauseVideo();
    		}
    	}
    });
    
    function pauseVideo(){
    	$('#dlg #video').get(0).pause();
    }
    
	//企业列表以及监测数据列表面板的收起与展开 --start--
	$(".map-panel-header").on("click", function() {
		closeMapPanel($(this));
	});

	function closeMapPanel(this_) {
		var $target = this_.parent();
		if ($target.hasClass("collapsed")) {
			$target.removeClass("collapsed");
		} else {
			$target.addClass("collapsed");
		}
	}

	var imgExt = new Array(".png",".jpg",".jpeg",".bmp",".gif");//图片文件的后缀名
	var videoExt = new Array(".mp4");//视频文件的后缀名
	var docExt = new Array(".doc",".docx");//word文件的后缀名
	var xlsExt = new Array(".xls",".xlsx");//excel文件的后缀名
	var cssExt = new Array(".css");//css文件的后缀名
	var jsExt = new Array(".js");//js文件的后缀名
	var pdfExt = new Array(".pdf");//pdf文件的后缀名

	//获取文件名后缀名
	String.prototype.extension = function(){
	    var ext = null;
	    var name = this.toLowerCase();
	    var i = name.lastIndexOf(".");
	    if(i > -1){
	    var ext = name.substring(i);
	    }
	    return ext;
	}

	//判断Array中是否包含某个值
	Array.prototype.contain = function(obj){
	    for(var i=0; i<this.length; i++){
	        if(this[i] === obj)
	            return true;
	    }
	    return false;
	};

	function typeMatch(type, filename){
	    var ext = filename.extension();
	    if(type.contain(ext)){        
	        return true;
	    }
	    return false;
	}    
</script>

</body>

</html>