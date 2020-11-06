<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>水质分析-省数据分析-水环境</title>

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
									multiple:false,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>			            	
			               	<div id = "timeInputDiv" class = "inline-block">
								    <label class="textbox-label textbox-label-before" title="时间">时间:</label>
									<input id="timedatetime" type="text" class="layui-input laydate-test" data-type="date" style="width:380px;">
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
				    		<div class="inline-block hide">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
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
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">水质分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
				    	<div  id= "timegoup" class="radio-button-group style-btn-group">
							<span  name="datetime" class="active">时</span>
							<span  name="date">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
						<a href="javascript:void(0)" class="easyui-linkbutton btn-blue"  onClick=" Ams.exportPdfById('waterAnalysis','水质分析（国控）')" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>

					   </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">				    	
				    	<div  id="waterAnalysis"  class="chart-box">
				    	</div>				    
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
						            <th field="pointQuality" width="120px">目标水质</th>
						            <th field="reslutQuality" width="120px">当前水质</th>
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
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar2">
			        <!-- 搜索栏 -->
			        <div id="searchBar2" class="searchBar">
			            <form id="searchForm2">
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				             	<input class="easyui-combobox" name="regionName1" value="${pointCode!}" id="regionName1" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointRegionList',
									method:'get',
 									editable:false,
									valueField:'id',
									textField:'text',
									multiple:false,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
							<div id = "timeInputDiv1" class = "inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
								<input id="timedatetime1" type="text" class="layui-input laydate-test" data-type="date" style="width:380px;">
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
				    		<div class="inline-block hide">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
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
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">水质分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
						<div  id= "timegoup1" class="radio-button-group style-btn-group">
							<span  name="datetime" class="active">时</span>
							<span  name="date">日</span>
							<span  name="month">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)" onClick=" Ams.exportPdfById('waterAnalysis1','水质分析（省控）')"  class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
				    </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">				    	
				    	<div  id="waterAnalysis1"  class="chart-box">
				    	</div>				    
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
		            </thead>
		                 <thead>
						        <tr>
						            <th field="pointName" width="140px" >监测站点</th>
						            <th field="pointCode" width="120px">站点编号</th>
						            <th field="pointQuality" width="120px">目标水质</th>
						            <th field="reslutQuality" width="120px">当前水质</th>
						        </tr>
       				 </thead>		
		        </table>
				<!-- 数据列表 over-->
			</div>
		</div>
		<!-- 标签页——2 over-->
		
		<!-- 标签页——2 -->
		<!-- <div title="小流域" style="padding:10px">
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

    var category = 1; //国控 1 省控 2 小流域 3
	var timeType = "DATETIME";
    $.parser.onComplete = function () {
  	   $('#regionName').combobox('setValue','350600');
  	   $('#regionName1').combobox('setValue','350600');
       $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    
    };
	 function init(){
		initDateInput('#timedatetime','datetime','0');
		initDateInput('#timedatetime1','datetime','0');
		showRightTimeInputByTimeType("datetime","");
		showRightTimeInputByTimeType("datetime","1");
     }
	init();
	/*单选按钮组*/
	$(".radio-button-group").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        timeType =  $( $(this).find(".active").context).attr("name")
		if (category == 1){
			selectTimeType(timeType,"");
		} else {
			selectTimeType(timeType,"1");
		}

    });

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



	function doSearch(){
		 timeType =  $("#timegoup").find("span[class = 'active' ]").attr("name");
		 initNationalProvice(1);
		 initNationalProviceForm(1);
	     getTopLast3Data(1);
	}
	
	function doSearch1(){
		 timeType =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
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


	var  waterAnalysis1 = null
    $(function(){   
    	 /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
        	var selectType = $(this).attr("date-select");
        	var $target=$(this).parents(".datagrid").find(".chartBar");
        	if($(this).attr("date-select")=="chart"){
        		$target.removeClass("hide");
        	}else{
        		$target.addClass("hide");
        	}
        	switch(selectType){
        	  case "text" :
        	 		break;
        	  case "chart" :
        		   break;
        	}
         });
        /*数据列表与图表的切换*/
        initDataGrid( $('#dg1'));
       
        /*数据列表与图表的切换*/
       
        $("#tabs").tabs({
        	onSelect:function(title,index){
  			switch(index){
	        	case 0 :
					category = 1 ;
 					doSearch();

	        	break;
	        	case 1 :
	        		 initDataGrid( $('#dg2'));
	        		if(waterAnalysis1 == null){
	        			 waterAnalysis1 = echarts.init(document.getElementById('waterAnalysis1'));     	
	        		}
					category = 2 ;
	        		doSearch1();
	        		break;
	        	case 2 :
	        		break;
        	 }
        	}
        });
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
        doSearch();
    });
        //国控省控级别
        var  waterAnalysis = null ;

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
        		  type =  $("#timegoup").find("span[class = 'active' ]").attr("name"); 
        	   	  regionCode = $("#regionName").combobox('getValue');
				  var date= getTimeValue(type,"");
                  startTime = date['sdate'];
            	  endTime =   date['edate'];
        	}else{
        		  type =  $("#timegoup1").find("span[class = 'active' ]").attr("name"); 
        	   	  regionCode = $("#regionName1").combobox('getValue');
				  var date= getTimeValue(type,"1");
				  startTime = date['sdate'];
				  endTime =   date['edate'];
        	}
            if(regionCode == "") {
			  	return ;
			}
        	$.ajax({
				type: "post",
				url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getRankingQualityDataByTime",
				data : {
					'regionCode':regionCode,
			        "category" : category,
					"type"     :type,
					"startTime": startTime,
					"endTime"  : endTime
				},
				dataType: "json",
				success: function(result){
					var names = result.names;
					var levelNums = result.levelNums;
					var levelNames = result.levelNames;
					var s = [];
					  for(var i = 0 ; i < levelNums.length;i++){
						s.push({name:levelNames[i],value:levelNums[i],itemStyle:{normal:{color: getLeverColor(levelNums[i]) }}});
					}  
					setEcharts(names,s,category);
				},
				error: function(r){console.log(r);}
			});
		}
        function initNationalProviceForm(tempCategory){
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
	      	   	  regionCode = $("#regionName1").combobox('getValue');
				 var date= getTimeValue(type,"1");
				 startTime = date['sdate'];
				 endTime =   date['edate'];
	      	}
			if(regionCode == "") {
				Ams.wornMsg("地区不能为空！");
				return ;
			}
        	  $.ajax({
     			type : 'POST',
     			url:  Ams.ctxPath + "/enviromonit/water/wtCityHourData/getRankingQualityDataByTimeForm",
     			data : {
     				'regionCode':regionCode,
			        "category" :category,
					"type"     :type,
					"startTime": startTime,
					"endTime"  : endTime
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
	      	   	  regionCode = $("#regionName1").combobox('getValue');
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
									"<span>污染物：</span>"+
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
										"<span>污染物：</span>"+
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
      
        function setEcharts(names,levelNums,category){
        	if(category == 1){
              	waterAnalysis.clear();
        	}else{
        	 	waterAnalysis1.clear();        		
        	}
   			option = {
					// title : {
					// 	text : '水质分析'
					// },
        		    tooltip : {
        		        trigger: 'axis',
        		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
        		            type : ''        // 默认为直线，可选为：'line' | 'shadow'
        		        },
        		        formatter: function (params) {
        		             return params[0].axisValue+' : ' + params[0].data.name;
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
        
        
        //根据等级获取颜色值
        //[1-2类：#2BA4E9，3类：#45B97C，4类：#FFFF00，5类：#F47920，劣5：#D02032，暂无数据：#B8B8B8]
        function getLeverColor(leverNum){
        	 
        	var color = "";
        	switch(leverNum){
        	case 1 :
        		color= "#2BA4E9";
        		break;
        	case 2 :
        		color= "#2BA4E9";
        		break;
        	case 3 :
        		color= "#45B97C";
        		break;
        	case 4 :
        		color= "#FFFF00";
        		break;
        	case 5 :
        		color= "#F47920";
        		break;
        	case 6 :
        		color= "#D02032";
        		break;
        	default :
        		color= "#B8B8B8";
        			break;
        	}
        	return color;
        }

</script>
</html>