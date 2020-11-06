<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>实时监测-省数据分析-水环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<div class="easyui-layout" fit=true>

	<!-- tabs 标签页 -->
	<div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
		<!-- 标签页——1 -->
		<div title="国控断面" style="padding:10px">
			<!-- 数据列表页面 -->
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar1">
			        <!-- 搜索栏 -->
			        <div id="searchBar1" class="searchBar">
			            <form id="searchForm1">
			            	<div class="inline-block">
                               <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                               <input class="easyui-combobox" name="regionName" value="${regionCode!}" id="regionName"
                               	 style="width:200px;"/>
	                                                    
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
								<input id="pointName" name="pointName" value="${pointCode!}" style="width: 200px" class="easyui-combobox "/>
			                </div>
			            	<!-- <div class="inline-block">
								<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				             	<input class="easyui-combobox" name="regionName" value="${regionCode!}" id="regionName" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointRegionList',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
				             	<input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=1',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>-->
							<div id = "timeInputDiv" class = "inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
								<input id="timedatetime" type="text" class="layui-input laydate-test" data-type="date" style="width:380px;">
								<input id="timedate" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timemonth" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timeyear" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
							</div>
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch()">查询</a>
			                <!-- <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset()">重置</a> -->
			                   <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出数据</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 操作栏-->
				    <!-- <div class="optionBar">
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出数据</a>
				    </div> -->
				    <!-- 操作栏 over-->
				    <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content" id="jcsj"></span>
				    		</div>
				    		<!-- <div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div> -->
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">水质排名前三</div>
				    			<div class="cell-content">
									 <div id= "gktopdiv" class="cell-content">
								     </div>									
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">水质排名后三</div>
				    			<div class="cell-content">
									  <div id= "gklastdiv" class="cell-content">
								     </div>						
								</div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->
				    		    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
						<div  id= "timegoup" class="radio-button-group style-btn-group">
							<span  name="datetime" class="active">时</span>
							<span  name="date">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    </div>
				    		
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg1" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar1"
		           data-options="
		            rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:false,
		            fitColumns:true,
		            fit:true,
		            pagination:true,
		            pageSize:20,
		            pageList:[20,50,100]">
		        <thead>
		        <tr>
		            <th field="datatime" width="180px" formatter="Ams.timeDateFormat">监测时间</th>
		            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">监测站点</th>
		            <th field="targetQuality" width="100px" formatter="Ams.tooltipFormat">目标水质</th>
		            <th field="resultQuality" width="100px" formatter="Ams.tooltipFormat">抽取水质</th>
		            <th field="w01010" width="120px" formatter="Ams.redFontFormat">水温</th>
		            <th field="w01001" width="120px" formatter="Ams.redFontFormat">PH值</th>
		            <th field="w01009" width="120px" formatter="Ams.redFontFormat">溶解氧</th>
		            <th field="w01014" width="120px" formatter="Ams.redFontFormat">电导率</th>
		            <th field="w01003" width="120px" formatter="Ams.redFontFormat">浑浊度</th>
		            <th field="w01019" width="120px" formatter="Ams.redFontFormat">高锰酸盐指数</th>
		            <th field="w21003" width="120px" formatter="Ams.redFontFormat">氨氮（NH3-N）</th>
		            <th field="w21011" width="120px" formatter="Ams.redFontFormat">总磷（以P计）</th>
		            <th field="w21001" width="120px" formatter="Ams.redFontFormat">总氮（以氮计）</th>
		            <th field="polluteNames" width="160px" formatter="Ams.tooltipFormat">超标污染物</th>
		        </tr>
		        </thead>
		    </table>
				<!-- 数据列表 over-->
			</div>
			<!-- 数据列表页面 over-->		
		</div>
		<!-- 标签页——1 over-->
		
		<!-- 标签页——2 -->
		<div title="省控断面" style="padding:10px">
			<!-- 数据列表页面 -->
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar2">
			        <!-- 搜索栏 -->
			        <div id="searchBar2" class="searchBar">
			            <form id="searchForm2">
			            	<div class="inline-block">
                               <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                               <input class="easyui-combobox" name="regionName2" value="${regionCode!}" id="regionName2"
                               	 style="width:200px;"
									data-options="url:'${request.contextPath}/enviromonit/water/wtCityPoint/getPointRegionList',
                                                    valueField:'id',
                                                    textField:'text',
                                                    onSelect:function(params){
	                                                    $('#pointName2').combobox('clear');
	                                                    $('#pointName2').combobox('reload','${request.contextPath}/enviromonit/water/wtCityPoint/getPointListByRegion?type=2&regionCode='+params.id)}" />
	                                                    
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
								<input id="pointName2" name="pointName2" value="${pointCode!}" style="width: 200px" class="easyui-combobox "
									data-options="url:'' ,
                                                    valueField:'id',
                                                    textField:'text'" />
			                </div>
			            	<!-- <div class="inline-block">
								<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				             	<input class="easyui-combobox" name="regionName2" value="${regionCode!}" id="regionName2" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointRegionList',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
				             	<input class="easyui-combobox" name="pointName2" value="${pointCode!}" id="pointName2" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div> -->
							<div id = "timeInputDiv1" class = "inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
								<input id="timedatetime1" type="text" class="layui-input laydate-test" data-type="date" style="width:380px;">
								<input id="timedate1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timemonth1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timeyear1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
							</div>

			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch2()">查询</a>
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset2()">重置</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 操作栏-->
				    <div class="optionBar">
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro()">导出数据</a>
				    </div>
				    <!-- 操作栏 over-->
				    <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content" id="jcsj2"></span>
				    		</div>
				    		<!-- <div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div> -->
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">水质排名前三</div>
				    			<div id= "gktopdiv1" class="cell-content">
								 </div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">水质排名后三</div>
				    		     <div id= "gklastdiv1" class="cell-content">
								 </div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->
				    		    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
						<div  id= "timegoup1" class="radio-button-group style-btn-group">
							<span  name="datetime" class="active">时</span>
							<span  name="date">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    </div>
				    		
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg2" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar2"
		           data-options="
		            rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:false,
		            fitColumns:true,
		            fit:true,
		            pagination:true,
		            pageSize:20,
		            pageList:[20,50,100]">
		        <thead>
		        <tr>
		            <th field="datatime" width="180px" formatter="Ams.timeDateFormat">监测时间</th>
		            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">监测站点</th>
		            <th field="targetQuality" width="100px" formatter="Ams.tooltipFormat">目标水质</th>
		            <th field="resultQuality" width="100px" formatter="Ams.tooltipFormat">抽取水质</th>
		            <th field="w01010" width="120px" formatter="Ams.redFontFormat">水温</th>
		            <th field="w01001" width="120px" formatter="Ams.redFontFormat">PH值</th>
		            <th field="w01009" width="120px" formatter="Ams.redFontFormat">溶解氧</th>
		            <th field="w01014" width="120px" formatter="Ams.redFontFormat">电导率</th>
		            <th field="w01003" width="120px" formatter="Ams.redFontFormat">浑浊度</th>
		            <th field="w01019" width="120px" formatter="Ams.redFontFormat">高锰酸盐指数</th>
		            <th field="w21003" width="120px" formatter="Ams.redFontFormat">氨氮（NH3-N）</th>
		            <th field="w21011" width="120px" formatter="Ams.redFontFormat">总磷（以P计）</th>
		            <th field="w21001" width="120px" formatter="Ams.redFontFormat">总氮（以氮计）</th>
		            <th field="polluteNames" width="160px" formatter="Ams.tooltipFormat">超标污染物</th>
		        </tr>
		        </thead>
		    </table>
				<!-- 数据列表 over-->
			</div>
		</div>
		<!-- 标签页——2 over-->
	</div>
	<!-- tabs 标签页 over -->

</div>
</body>
<script src="${request.contextPath}/static/js/initWaterMapLayUi.js" charset="utf-8"></script>
<script>

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
	initCombobox($("#regionName"),$("#pointName"));
	initCombobox($("#regionName2"),$("#pointName2"));
	//初始化下拉框
    function initCombobox(targetRegionCombobox,targetPointNameCombobox){
		targetRegionCombobox.combobox({
			url: "${request.contextPath}/enviromonit/water/wtCityPoint/getPointRegionList",
			valueField: 'id',//值字段
			textField: 'text',//显示字段
			method: 'POST',
			editable: false,//不可编辑只能选择
			prompt:"请选择",
			onChange: function (newValue, oldValue) {
					targetPointNameCombobox.combobox('clear');
			},
			onSelect: function (obj) {
				   targetPointNameCombobox.combobox({
					url: "${request.contextPath}/enviromonit/water/wtCityPoint/getPointListByRegionCode?regionCode="+obj.id,
					valueField: "id",
					textField: "text",
					panelHeight: "auto",
					multiple:true,//多选
					editable: false //不允许手动输入
				});
			}
		});
	}



	var category = ""; //国控 1 省控 2 小流域 3
	var timeType = "DATETIME";

	function init(){
		initDateInput('#timedatetime','datetime','0');
		initDateInput('#timedatetime1','datetime','0');
		showRightTimeInputByTimeType("datetime","");
		showRightTimeInputByTimeType("datetime","1");
	}
	init();
	// 根据显示时间控件  tabType:国控 ，省控
	function  showRightTimeInputByTimeType(timeType,category){
		$("#timeInputDiv"+category).find("input").addClass("hide");
		$("#time"+timeType+category).removeClass("hide");

	}
	//切换时间控件
	function selectTimeType(timeType,category) {

		if(typeof (timeType)!="undefined") {
			showRightTimeInputByTimeType(timeType,category);
			var timeTypeLow = timeType.toLowerCase();
			var idStr = null ;
			idStr = "#time"+timeType+category;
			initDateInput(idStr, timeTypeLow, '0');
			if(category == ""){
				doSearch()
			}else{
			 //	doReset()
			}
		}
	}
	//获取时间  开始时间date['sdate'  , 结束时间date['edate']
	function  getTimeValue(timeType,category) {
		if(typeof (timeType)!="undefined") {
			var idStr = "#time" + timeType+category;
			var timeTypeLow = timeType.toLowerCase();
			var date = getHandleDate(idStr, timeTypeLow, '0');
			return date;
		}
	}
	$(function(){
    	/*因子选择*/
        $('body').on('click','.btnSure',function () {
        	var $target=$(this).parents(".select-panel");
        	$target.removeClass('show');
        	$target.off("change.selectAll",".all");
        });
        $('body').on('click','.select-button',function () {
        	var $target=$(this).next();
        	$target.addClass('show');
        	$target.on("change.selectAll",".all",function () {
        		if($(this).prop("checked")){
        			$target.find('input[name='+$(this).prop("name")+']').prop("checked",true);        			
        		}else{
        			$target.find('input[name='+$(this).prop("name")+']').prop("checked",false);
        		}
        		
        	});
        });
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
			timeType =  $( $(this).find(".active").context).attr("name")

			if (category == ""){
				selectTimeType(timeType,"");
			} else {
				selectTimeType(timeType,"1");
			}
        });

		/**/
        $("#tabs").tabs({
        	onSelect:function(title,index){
        	    var jcsj = getNowDate(0);
        		if(index == 1){
					category = 1;

        	    	$("#jcsj2").html(jcsj);
        			//doSearchTab2();
        		}else{
					category = "";
        	    	$("#jcsj").html(jcsj);
        	    	//doReset();
        		}

        	}
        });
        
        
    });
	var timeType = "DATETIME";
	$(function(){
		var jcsj = getNowDate(0);
	    $("#jcsj").html(jcsj);

         doSearch();
	});
	$.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
		type =  $("#timegoup").find("span[class = 'active' ]").attr("name");
		var date= getTimeValue(type,"");
		startTime = date['sdate'];
		endTime =   date['edate'];

    	if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
    		$('#dg1').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtHourData/getPageListNative',
    		    queryParams: {
    		    	regionName: $("#regionName").val().trim(),
    		    	pointName: $("#pointName").val().trim(),
    	            startTime: startTime ,
    	            endTime: endTime
    		    },
    		    onLoadSuccess: function(data){
    				//填充颜色
    				 var trs = $(this).prev().find('div.datagrid-body').find('tr');
    		          for(var i = 0 ; i<trs.length;i++){
    		        	  for (var j = 2; j < trs[0].cells.length; j++) {
    		        		  trs[i].cells[j].style.cssText = changeLevelColor($(trs[i].cells[j]).text());
    		        	  }
    		         }		          
    		   }
    		});
    	}
    	getTopLast3Data(1);
    }

    function doReset() {
        $("#searchBar1").find("#searchForm1").form('clear');
        doSearch();
    }
    

    function doSearchTab2(){
        doSearch2();
    }

    function doSearch2() {
		type =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
		var date= getTimeValue(type,"1");
		startTime = date['sdate'];
		endTime =   date['edate'];
    	if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
    		$('#dg2').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtHourData/getPageListProvince',
    		    queryParams: {
    		    	regionName: $("#regionName2").val().trim(),
    		    	pointName: $("#pointName2").val().trim(),
    	            startTime: startTime,
    	            endTime: endTime
    		    },
    		    onLoadSuccess: function(data){
    				//填充颜色
    				 var trs = $(this).prev().find('div.datagrid-body').find('tr');
    		          for(var i = 0 ; i<trs.length;i++){
    		        	  for (var j = 2; j < trs[0].cells.length; j++) {
    		        		  trs[i].cells[j].style.cssText = changeLevelColor($(trs[i].cells[j]).text());
    		        	  }
    		         }		          
    		   }
    		});
    	}
    	getTopLast3Data(2);
    }

    function doReset2() {
        $("#searchBar2").find("#searchForm2").form('clear');
        doSearch2();
    }
    
    /**
     * 导出国控数据excel
     */
    function exportExl(){
    	var regionName = $("#regionName").val().trim();
    	var pointName = $("#pointName").val().trim();
		type =  $("#timegoup").find("span[class = 'active' ]").attr("name");
		var date= getTimeValue(type,"");
		startTime = date['sdate'];
		endTime =   date['edate'];
    	window.location.href = "${request.contextPath}/enviromonit/water/wtHourData/getListExport?datatype=1&regionName="+regionName+"&pointName="+pointName+"&startTime="+startTime+"&endTime="+endTime;
    }
    /**
     * 导出省控数据excel
     */
    function exportExlPro(){
    	var regionName = $("#regionName2").val().trim();
    	var pointName = $("#pointName2").val().trim();
		type =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
		var date= getTimeValue(type,"1");
		startTime = date['sdate'];
		endTime =   date['edate'];
    	window.location.href = "${request.contextPath}/enviromonit/water/wtHourData/getListExport?datatype=2&regionName="+regionName+"&pointName="+pointName+"&startTime="+startTime+"&endTime="+endTime;
    }
    
  //获取时间格式化(cutDay为往前几天，0为当天)
	function getNowDate(cutDay) {
		var d = new Date();
		var nowDateTime = d.getTime() - cutDay*60000*60*24;
		d.setTime(nowDateTime);
		var year = d.getFullYear();
		var month = d.getMonth()+1;
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
		var currentdate = year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
	    return currentdate;
	}
  
	function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
	
	function changeLevelColor(str){
    	var color = 'background-color:#b8b8b8;';
    	switch(str){
    	case "Ⅰ":
    		color = 'background-color:#2ba4e9;';
    	  break;
    	case "Ⅱ":
    		color = 'background-color:#2ba4e9;';
  		  break;
    	case "Ⅲ":
    		color = 'background-color:#45b97c;';
  		  break;
    	case "Ⅳ":
    		color = 'background-color:#FFFF00;';
  		  break;
    	case "Ⅴ":
    		color = 'background-color:#f47920;';
  		  break;
    	case "劣Ⅴ":
    		color = 'background-color:#d02032;';
 		  break;
    	default:
    		color = 'background-color:#ffffff;';
  		  break;
    	}
    	return color;
    }
	var timeType = "datetime";
	function getTopLast3Data(tempCategory){
    	var regionCode = null;
    	var startTime  = null;
    	var endTime    = null;
    	var  category = tempCategory;
    	var type = timeType;
    	if(category == 1){
      	   	  regionCode = $("#regionName").combobox('getValue');
			  var date= getTimeValue(type,"");
			  startTime = date['sdate'];
			   endTime =   date['edate'];
      	}else{
      	   	 regionCode = $("#regionName2").combobox('getValue');
			 var date= getTimeValue(type,"1");
			 startTime = date['sdate'];
			 endTime =   date['edate'];
      	}
    	if(regionCode == "") {
			return ;
		}
       $.ajax({
			type : 'POST',
			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getTopLast3RankingQualityDataByTime",
			data : {
				   'regionCode':regionCode,
		        "category" :category,
				"type"     :type,
				"startTime": startTime,
				"endTime"  : endTime
			},
			success : function(result) {
				 $("#gklastdiv").empty();
				 $("#gktopdiv").empty();
				 $("#gklastdiv1").empty();
				 $("#gktopdiv1").empty();
				 var topstr = "";
				 var laststr = "";
				 for(var i = 0 ; i < result.top3.length;i++){
					topstr += "<div class='inline-block'>"+
								"<div class='inline-block'>"+
									"<span>"+result.top3[i].pointName+"：</span>"+
									"<span class='em'>"+result.top3[i].reslutQuality+"</span>"+
								"</div>" +
								"<div class='inline-block'>"+
									"<span>首污</span>"+
									"<span class='em'>"+result.top3[i].overPollutant+"</span>"+
								"</div>"+
				   		 "</div>" ;
				  }
				 for(var i = 0 ; i < result.last3.length;i++){
					 laststr += "<div class='inline-block'>"+
									"<div class='inline-block'>"+
										"<span>"+result.last3[i].pointName+"：</span>"+
										"<span class='em'>"+result.last3[i].reslutQuality+"</span>"+
									"</div>" +
									"<div class='inline-block'>"+
										"<span>首污</span>"+
										"<span class='em'>"+result.last3[i].overPollutant+"</span>"+
									"</div>"+
					   		 "</div>" ;
					  }
				 if(category == 1){
					$("#gklastdiv").append(laststr);
					$("#gktopdiv").append(topstr);					 
				 }else{
					 $("#gklastdiv1").append(laststr);
				     $("#gktopdiv1").append(topstr);			
				 }
			 },
			error: function(){
			}
		}); 
    	
    }
</script>
</html>