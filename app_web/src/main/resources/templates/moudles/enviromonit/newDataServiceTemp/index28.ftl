<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>均值比较（按城市）-省数据分析-水环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
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
				             	<input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointRegionList',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
							<div id = "timeInputDiv" class = "inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
								<input id="timedate" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timemonth" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timeyear" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
							</div>
					                        
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch()">查询</a>
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset()">重置</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label hide">监测时间：</span>
				    			<span class="control-content hide">2019年06月</span>
				    		</div>
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">均值排名前三</div>
				    			<div class="cell-content">
									 <div id= "gktopdiv" class="cell-content">
								     </div>									
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">均值排名后三</div>
				    			<div class="cell-content">
									  <div id= "gklastdiv" class="cell-content">
								     </div>						
								</div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->
				    
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">均值比较分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
						<div  id= "timegoup" class="radio-button-group style-btn-group">
							<span  name="date" class="active">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)"   class="easyui-linkbutton btn-blue" onClick="Ams.exportPdfById('waterAnalysis','均值分析城市(国控)')" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
				    </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">
				    	<div class="optionBar tc">
					    	<!-- 单选按钮组 -->	    	
					    	<div id="pollutatngroup" class="radio-button-group style-btn-group">
								<span class="active" name ="W01001">PH</span>
								<span name ="W01009">溶解氧</span>
								<span name ="W01019">高锰酸盐</span>
								<span name ="W21003">氨氮</span>
								<span name ="W21011">总磷</span>
								<span name ="W01017">五日生化需氧量</span>
							</div>
					    	<!-- 单选按钮组 over-->
					    </div>				    	
				    	<div   id="waterAnalysis" class="chart-box"> </div>				    
				    </div>
				    <!-- 图表栏 over-->				    
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
		               data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		       
		             <thead>
						        <tr>
						            <th field="pointName" width="140px" >监测站点</th>
						            <th field="pointCode" width="120px">站点编号</th>
						            <th field="pollutantName" width="120px">监测因子</th>
						            <th field="avgValue" width="120px">监测因子均值</th>
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
				             	<input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName1" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointRegionList',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
							<div id = "timeInputDiv1" class = "inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
								<input id="timedate1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timemonth1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
								<input id="timeyear1" type="text" class="layui-input laydate-test" data-type="date" style="width:350px;">
							</div>
					                        
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch1()">查询</a>
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset1()">重置</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label hide">监测时间：</span>
				    			<span class="control-content hide">2019年06月</span>
				    		</div>
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">均值排名前三</div>
				    			<div class="cell-content">
									 <div id= "gktopdiv1" class="cell-content">
								     </div>									
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">均值排名后三</div>
				    			<div class="cell-content">
									  <div id= "gklastdiv1" class="cell-content">
								     </div>						
								</div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->
				    
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">均值比较分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
				    	<div id="timegoup1" class="radio-button-group style-btn-group">
							<span  name="date" class="active">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)" onClick="Ams.exportPdfById('waterAnalysis1','均值分析城市(省控)')" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
				    </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">
				    	<div class="optionBar tc">
					    	<!-- 单选按钮组 -->	    	
					    	<div id="pollutatngroup1" class="radio-button-group style-btn-group">
								<span class="active" name ="W01001">PH</span>
								<span name ="W01009">溶解氧</span>
								<span name ="W01019">高锰酸盐</span>
								<span name ="W21003">氨氮</span>
								<span name ="W21011">总磷</span>
								<span name ="W01017">五日生化需氧量</span>
							</div>
					    	<!-- 单选按钮组 over-->
					    </div>				    	
				    	<div   id="waterAnalysis1" class="chart-box"> </div>				    
				    </div>
				    <!-- 图表栏 over-->				    
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
		               data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		       
		             <thead>
						        <tr>
						            <th field="pointName" width="140px" >监测站点</th>
						            <th field="pointCode" width="120px">站点编号</th>
						            <th field="pollutantName" width="120px">监测因子</th>
						            <th field="avgValue" width="120px">监测因子均值</th>
						        </tr>
       				    </thead>			
		        </table>
				<!-- 数据列表 over-->
			</div>	
		</div>
		<!-- 标签页——2 over-->
		
		<!-- 标签页——2 -->
	<!-- 	<div title="小流域" style="padding:10px">
			小流域		
		</div> -->
		<!-- 标签页——2 over-->
		
		
	</div>
	<!-- tabs 标签页 over -->

</div>
</body>
<script src="${request.contextPath}/static/js/initWaterMapLayUi.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/waterDataAnalysis.js"></script>
<script>
    $.parser.onComplete = function () {
    	$('#regionName').combobox('setValue','350600');
    	 $('#regionName1').combobox('setValue','350600');
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
      
    };
	var category = "";
    var timeType = null;
    var selectPollutant = null ;
    var  waterAnalysis = null ;
    var  waterAnalysis1 = null

   	init();
   	function doSearch(){
		  timeType =  $("#timegoup").find("span[class = 'active' ]").attr("name");
		  selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
		  initNationalProvice(1);
		  initNationalProviceForm(1);
	      getTopLast3Data(1);
	}
	function doSearch1(){
		  timeType =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
		  selectPollutant = $("#pollutatngroup1").find("span[class = 'active' ]").attr("name");
		  initNationalProvice(2);
		  initNationalProviceForm(2);
	      getTopLast3Data(2);
	}

	function doReset() {
		$("#searchBar1").find("#searchForm1").form('reset');
		doSearch();
	}
	function doReset1() {
		$("#searchBar2").find("#searchForm2").form('reset');
		doSearch1();
	}
    //获取前后3名数据
    function getTopLast3Data(tempCategory){
        	var regionCode = null;
        	var startTime  = null;
        	var endTime    = null;
        	var  category = tempCategory;
        	var type = timeType;
        	if(category == 1){
        		 selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
				regionCode = $("#regionName").combobox('getValues');
				var date= getTimeValue(type,"");
				startTime = date['sdate'];
				endTime =   date['edate'];;
	      	}else{
	      		 selectPollutant = $("#pollutatngroup1").find("span[class = 'active' ]").attr("name");
	      	   	  regionCode = $("#regionName1").combobox('getValues');
				 var date= getTimeValue(type,"1");
				 startTime = date['sdate'];
				 endTime =   date['edate'];;
	      	}
		if(regionCode == "") {
			return ;
		}
           $.ajax({
   			type : 'POST',
   			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getTopLast3AvgQualityDataByTime",
   			data : {
   				   'pollutantCode':selectPollutant,
   					'regionCode': changeString(regionCode),
			       "category" :category,
					"type"     :type,
					"startTime": startTime,
					"endTime"  : endTime,
					'flag' : 0
				},
   			success : function(result) {
   				$("#gklastdiv").empty();
   				$("#gktopdiv").empty();
   				$("#gklastdiv1").empty();
   				$("#gktopdiv1").empty();
				 var topstr = "";
				 var laststr = "";
				 if(typeof (result.top3)!="undefined") {
					 for (var i = 0; i < result.top3.length; i++) {
						 topstr += "<div class='inline-block'>" +
								 "<div class='inline-block'>" +
								 "<span>" + result.top3[i].pointName + "：</span>" +
								 "<span class='em'>" + result.top3[i].avgValue + "</span>" +
								 "</div>"
						 "</div>";
					 }
					 for (var i = 0; i < result.last3.length; i++) {
						 laststr += "<div class='inline-block'>" +
								 "<div class='inline-block'>" +
								 "<span>" + result.last3[i].pointName + "：</span>" +
								 "<span class='em'>" + result.last3[i].avgValue + "</span>" +
								 "</div>"
						 "</div>";
					 }
					 if (category == 1) {
						 $("#gklastdiv").append(laststr);
						 $("#gktopdiv").append(topstr);
					 } else {
						 $("#gklastdiv1").append(laststr);
						 $("#gktopdiv1").append(topstr);
					 }
				 }
   			 },
   			error: function(){
   			}
   		}); 
        	
        }
  //国控省控级别
    function  initNationalProvice(tempCategory){
    	var regionCode = null;
    	var startTime  = null;
    	var endTime    = null;
    	if(waterAnalysis == null ){
    		waterAnalysis = echarts.init(document.getElementById('waterAnalysis'));
         }
    	var  category = tempCategory;
    	var type = null;
    	
    	if(category == 1){
    		 selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
    		  type = $("#timegoup").find("span[class = 'active' ]").attr("name");
    	   	  regionCode = $("#regionName").combobox('getValues');
			 var date= getTimeValue(type,"");
			 startTime = date['sdate'];
			 endTime =   date['edate'];;
    	}else{
    		 selectPollutant = $("#pollutatngroup1").find("span[class = 'active' ]").attr("name");
    		  type =  $("#timegoup1").find("span[class = 'active' ]").attr("name"); 
    	   	  regionCode = $("#regionName1").combobox('getValues');
			 var date= getTimeValue(type,"1");
			 startTime = date['sdate'];
			 endTime =   date['edate'];;
    	}
		if(regionCode == "") {
			return ;
		}
    	$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getRankingQualityDataForPollutant",
			data : {
				'pollutantCode':selectPollutant,
				'regionCode': changeString(regionCode),
		        'category' : category,
				'type'     :type,
				'startTime': startTime,
				'endTime'  : endTime,
				'flag' : 0
			},
			dataType: "json",
			success: function(result){
				var names = result.names;
				if( typeof (names)!="undefined") {
					var avgValues = result.avgValues;
					var s = [];
					for (var i = 0; i < names.length; i++) {
						s.push({name: names[i], value: avgValues[i]});
					}

					setEcharts(names, s, category);
				}else{
					if(category == 1){
						waterAnalysis.clear();
					}else{
						waterAnalysis1.clear();
					}
				}
			},
			error: function(r){console.log(r);}
		});
	}
    function changeString(strobj){
    	var s = "";
        for(var i = 0 ;i <strobj.length;i++){
    		s =strobj[i]+','+s;
    	}  
    	   return  s.substring(0,s.length-1);
    }
  
    function initNationalProviceForm(tempCategory){
    	var regionCode = null;
    	var startTime  = null;
    	var endTime    = null;
    	var  category = tempCategory;
    	var type = timeType;

    	if(category == 1){
    		  selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
      	   	  regionCode = $("#regionName").combobox('getValues');
			  var date= getTimeValue(type,"");
			  startTime = date['sdate'];
			  endTime =   date['edate'];

      	}else{
      		  selectPollutant = $("#pollutatngroup1").find("span[class = 'active' ]").attr("name");
      	   	  regionCode = $("#regionName1").combobox('getValues');
			 var date= getTimeValue(type,"1");
			 startTime = date['sdate'];
			 endTime =   date['edate'];;
      	}
		if(regionCode == "") {
			return ;
		}
    	  $.ajax({
 			type : 'POST',
 			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getAvgPollutantDataByTimeForm",
 			data : {
 				'pollutantCode':selectPollutant,
 				'regionCode': changeString(regionCode),
		        "category" :category,
				"type"     :type,
				"startTime": startTime,
				"endTime"  : endTime,
				'flag' : 0
			},
 			success : function(result) {
 				if(category==1)
 			       $("#dg1").datagrid("loadData",result);
 				else{
 				   $("#dg2").datagrid("loadData",result);
 				}
 			 },
 			error: function(){
 			}
 		});  
     }
	function init(){
		initDateInput('#timedate','date','0');
		initDateInput('#timedate1','date','0');
		showRightTimeInputByTimeType("date","");
		showRightTimeInputByTimeType("date","1");
	}
   	
    function setEcharts(names,levelNums,category){
    	if(category == 1){
          	waterAnalysis.clear();
    	}else{
    	 	waterAnalysis1.clear();        		
    	}
			option = {
    		    title:{
    		    	name :"均值分析（城市)"
				},
    		    tooltip : {
    		        trigger: 'axis',
    		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    		            type : ''        // 默认为直线，可选为：'line' | 'shadow'
    		        },
    		        formatter: function (params) {
    		        	   return params[0].axisValue+' : ' + params[0].data.value;
    		        }
    		    },
    		    xAxis: {
    		        type: 'category',
    		        data: names
    		    },
    		    yAxis: {
    		        type: 'value'
    		    },
    		    series: [{
					barWidth : 30,
    		        data: levelNums,
    		        type: 'bar'
    		    }]
    		};
    	if(category == 1){
			waterAnalysis.setOption(option);
    	}else{
    		waterAnalysis1.setOption(option);		
    	}
	}
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
				doSearch1()
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
        /*单选按钮组*/
		var timeTypeArr = ["datetime","date","month","year"];
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
			timeType =  $( $(this).find(".active").context).attr("name");
			if( $.inArray(timeType,timeTypeArr)!="-1") {
                 console.log(timeType);
				if (category == "") {
					selectTimeType(timeType, "");
				} else {
					selectTimeType(timeType, "1");
				}
			}else{
				if (category == "") {
					doSearch();
				} else {
					doSearch1();
				}

			}

        });
        /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
/*         	console.log($(this).attr("date-select")); */
        	var $target=$(this).parents(".datagrid").find(".chartBar");
        	if($(this).attr("date-select")=="chart"){
        		$target.removeClass("hide");
        	}else{
        		$target.addClass("hide");
        	}

        });
     /*数据列表与图表的切换*/
       
		initDataGrid( $('#dg1'));
        
        /**/
        $("#tabs").tabs({
        	onSelect:function(title,index){
        		switch(index){
	        	case 0 :
					category = "" ;
	        		doSearch();
	        	break;
	        	case 1 :
					 category = "1" ;
	        		 initDataGrid( $('#dg2'));
	        		if(waterAnalysis1 == null){
	        			 waterAnalysis1 = echarts.init(document.getElementById('waterAnalysis1'));     	
	        		}
	        		doSearch1();
	        		break;
	        	case 2 :
	        		break;
        	 }
        	}
        });
        doSearch();
        /*数据列表与图表的切换*/
        function initDataGrid(dg){
        	dg.datagrid({
            	onBeforeLoad: function(){
            		var toolbar=$(this).datagrid("options").toolbar;
            		var chartHeight=$(this).datagrid("options").height-$(toolbar).height();
            		$(toolbar).children(".chartBar").height(chartHeight); 
            	}        	
            }); 
        }
    });
    

    
</script>
</html>