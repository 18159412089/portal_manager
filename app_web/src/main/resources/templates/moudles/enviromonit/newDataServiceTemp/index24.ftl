<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>污染物分析-省数据分析-水环境</title>

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
							<div class="inline-block">
								<span class="control-label">监测时间：</span>
								<span class="control-content" id="timedatetimetxt"></span>
							</div>
						</div>
						<div class="row">
							<div class="item col-xs-6">
								<div class="cell-title">超标次数排名前三</div>
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
				    	
				    	<h2 class="title">污染物分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
						<!-- 单选按钮组 -->
						<div  id= "timegoup" class="radio-button-group style-btn-group">
							<span  name="month"  class="active">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onClick="downloadImpByChart('chartId')">导出图片</a>
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
                        <div class="chart-box">
                            <div id="chartId" style="width: 100%;height: 420px;"></div>
                        </div>
                    </div>
                    <!-- 图表栏 over-->				    
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
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
                        <th field="pointName" width="30%" align="center">站点名称</th>
                        <th field="nums" width="30%" align="center">超标天数</th>
                    </tr>
                    </thead>
                </table>
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
				             	<input class="easyui-combobox" name="regionName2" value="${pointCode!}" id="regionName2" prompt="全部" data-options=" 
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
			        
				    <!-- 数据信息 -->
					<div class="data-info-layout">
						<div class="other">
							<div class="inline-block">
								<span class="control-label">监测时间：</span>
								<span class="control-content" id="timedatetimetxt1"></span>
							</div>
						</div>
						<div class="row">
							<div class="item col-xs-6">
								<div class="cell-title">超标次数排名前三</div>
								<div class="cell-content">
									<div id= "gktopdiv1" class="cell-content">
									</div>
								</div>
							</div>
							<div class="item col-xs-6">
								<div class="cell-title">超标次数排名后三</div>
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
				    	
				    	<h2 class="title">污染物分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
						<!-- 单选按钮组 -->
						<div  id= "timegoup1" class="radio-button-group style-btn-group">
							<span  name="month"  class="active">月</span>
							<span  name="year">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onClick="downloadImpByChart('chartId2')">导出图片</a>
				    </div>
				    
				     <!-- 图表栏-->
                    <div class="chartBar">
                    	<div class="optionBar tc">
					    	<!-- 单选按钮组 -->	    	
					    	<div id="pollutatngroup2" class="radio-button-group style-btn-group">
								<span class="active" name ="W01001">PH</span>
								<span name ="W01009">溶解氧</span>
								<span name ="W01019">高锰酸盐</span>
								<span name ="W21003">氨氮</span>
								<span name ="W21011">总磷</span>
								<span name ="W01017">五日生化需氧量</span>
							</div>
					    </div>		
				    	<!-- 单选按钮组 over-->
                        <div class="chart-box">
                            <div id="chartId2" style="width: 100%;height: 420px;"></div>
                        </div>
                    </div>
                    <!-- 图表栏 over-->				    
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
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
                        <th field="pointName" width="30%" align="center">站点名称</th>
                        <th field="nums" width="30%" align="center">超标天数</th>
                    </tr>
                    </thead>
                </table>
			</div>
			<!-- 数据列表页面 over-->		
		</div>
		<!-- 标签页——2 over-->
	</div>
	<!-- tabs 标签页 over --> 

</div>
</body>
<script src="${request.contextPath}/static/js/initWaterMapLayUi.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/waterDataAnalysis.js"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
	var timeTypeArr = ["datetime","date","month","year"];
	var category = 1; //国控 1 省控 2 小流域 3
    var timeType = null;

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
	        $("#timeInputDiv" + category).find("input").addClass("hide");
			$("#time" + timeType + category).removeClass("hide");

	}
	//切换时间控件
	function selectTimeType(timeType,category) {

		if(typeof (timeType)!="undefined") {
			if( $.inArray(timeType,timeTypeArr)!="-1") {
				showRightTimeInputByTimeType(timeType, category);
				var timeTypeLow = timeType.toLowerCase();
				var idStr = null;
				idStr = "#time" + timeType + category;
				initDateInput(idStr, timeTypeLow, '0');
			}
			if(category == ""){
				doSearch()
			}else{
				doSearch2()
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
	function init(){
		initDateInput('#timemonth','month','0');
		initDateInput('#timemonth1','month','0');
		showRightTimeInputByTimeType("month","");
		showRightTimeInputByTimeType("month","1");
	}

	$(function(){
		init();

    	/*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
			timeType =  $( $(this).find(".active").context).attr("name");

			if( $.inArray(timeType,timeTypeArr)!="-1") {
				/*if (category == "") {
					selectTimeType(timeType, "");
				} else {
					selectTimeType(timeType, "1");
				}*/
			}else{
 				/*if (category == "") {
					doSearch();
				} else {
					doSearch2();
				}*/

			}
        });
        /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
        	var $target=$(this).parents(".datagrid").find(".chartBar");
        	if($(this).attr("date-select")=="chart"){
        		$target.removeClass("hide");
        	}else{
        		$target.addClass("hide");
        	}

        });
        /*数据列表与图表的切换*/
        $('#dg1').datagrid({
        	onBeforeLoad: function(){
        		var toolbar=$(this).datagrid("options").toolbar;
        		var chartHeight=$(this).datagrid("options").height-$(toolbar).height();
        		$(toolbar).children(".chartBar").height(chartHeight);
        		
        	}        	
        });
        initDataGrid( $('#dg1'));
        /**/
        $("#tabs").tabs({
        	onSelect:function(title,index){
        		switch(index){
	        	case 0 :
					category = 1;
	        		doSearch();
 					break;
	        	case 1 :
					category = 2 ;
	        		initDataGrid( $('#dg2'));
	        		doSearch2();

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
        
    });

    function doSearch() {
    	timeType =  $("#timegoup").find("span[class = 'active' ]").attr("name");
		selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
		var myChart = echarts.init(document.getElementById('chartId'));
		var timedatetime=$('#timemonth').val();
		if("year"==timeType){
			timedatetime=$('#timeyear').val();
		}
		$("#timedatetimetxt").html(timedatetime);
		getData(1,myChart);
		initForm(1);
    }
	function doSearch2() {
		timeType =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
		selectPollutant = $("#pollutatngroup2").find("span[class = 'active' ]").attr("name");
		var myChart = echarts.init(document.getElementById('chartId2'));
		var timedatetime=$('#timemonth1').val();
		if("year"==timeType){
			timedatetime=$('#timeyear1').val();
		}
		$("#timedatetimetxt1").html(timedatetime);
		getData(2,myChart);
		initForm(2);
    }


	function doReset() {
		$("#searchBar1").find("#searchForm1").form('reset');
		doSearch();
	}
	function doReset2() {
		$("#searchBar2").find("#searchForm2").form('reset');
		doSearch2();
	}

    function getData(categoryType,myChart){
    	var regionCode = null;
    	var startTime  = null;
    	var endTime    = null;
    	var  category = categoryType;
    	var type = timeType;
    	if(category == 1){
    		  type =      $("#timegoup").find("span[class = 'active' ]").attr("name");
    	   	  regionCode = $("#regionName").val();
			 var date= getTimeValue(type,"");
			 startTime = date['sdate'];
			 endTime =   date['edate'];
    	}else{
    		  type =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
    	   	  regionCode = $("#regionName2").val();
			  var date= getTimeValue(type,"1");
			  startTime = date['sdate'];
			  endTime =   date['edate'];
    	}
        $.ajax({
            type : "GET",
            url : "/environment/waterPollutionAnalysis/pollutionAnalysis",
            async : false,
            dataType : "json",
            data : {
				   'pollutantCode':selectPollutant,
				   'regionCode':regionCode,
			        "category" :category,
					"type"     :type,
					"startTime": startTime,
					"endTime"  : endTime
				},
            success : function(data) {
                // 基于准备好的dom，初始化echarts实例
               option = {
           			// title : {
           			// 	text : '污染物分析'
           			// },

				    color: ['#3398DB'],
				    tooltip : {
				        trigger: 'axis',
				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				            type : ''        // 默认为直线，可选为：'line' | 'shadow'
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
				            data : data.namelist,
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
							barWidth : 30,
						    name:'超标次数',
				            type:'bar',
				            data:data.numlist
				        }
				    ]
				};
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }
        });
    }

    function initForm(tempCategory){
    	var regionCode = null;
    	var startTime  = null;
    	var endTime    = null;
    	var  category = tempCategory;
    	var type = timeType;

    	if(category == 1){
	  		  type =      $("#timegoup").find("span[class = 'active' ]").attr("name");
	  	   	  regionCode = $("#regionName").val();
			var date= getTimeValue(type,"");
			startTime = date['sdate'];
			endTime =   date['edate'];
		 }else{
	  		  type =  $("#timegoup1").find("span[class = 'active' ]").attr("name");
	  	   	  regionCode = $("#regionName2").val();
			var date= getTimeValue(type,"1");
			startTime = date['sdate'];
			endTime =   date['edate'];
	  	}

   	    $.ajax({
			type : 'POST',
			url : "/environment/waterPollutionAnalysis/pollutionAnalysisList",
            data : {
			    "pollutantCode": selectPollutant,
			    "regionCode": regionCode,
		        "category" : category,
				"type"     : type,
				"startTime": startTime,
				"endTime"  : endTime
			},
			success : function(result){
				if(category==1)
			       $("#dg1").datagrid("loadData",result);
				else{
				   $("#dg2").datagrid("loadData",result);
				}
			},
			error: function(){
				
			}
 		});

		$.ajax({
			type : 'POST',
			url : "/environment/waterPollutionAnalysis/pollutionAnalysisOrderList",
			data : {
				"pollutantCode": selectPollutant,
				"regionCode": regionCode,
				"category" : category,
				"type"     : type,
				"startTime": startTime,
				"endTime"  : endTime
			},
			success : function(result){

				$("#gklastdiv").empty();
				$("#gktopdiv").empty();
				$("#gklastdiv1").empty();
				$("#gktopdiv1").empty();
				var topstr = "";
				var laststr = "";
				if(typeof (result.top3)!="undefined") {
					for(var i = 0 ; i < result.top3.length;i++){
						topstr += "<div class='inline-block'>"+
								"<div class='inline-block'>"+
								"<span>"+result.top3[i].pointName+"：</span>"+
								"<span class='em'>"+result.top3[i].nums+"</span>"+
								"</div>"
						"</div>" ;
					}
					for(var i = 0 ; i < result.last3.length;i++){
						laststr += "<div class='inline-block'>"+
								"<div class='inline-block'>"+
								"<span>"+result.last3[i].pointName+"：</span>"+
								"<span class='em'>"+result.last3[i].nums+"</span>"+
								"</div>"
						"</div>" ;
					}
					if(category == 1){
						$("#gklastdiv").append(laststr);
						$("#gktopdiv").append(topstr);
					}else{
						$("#gklastdiv1").append(laststr);
						$("#gktopdiv1").append(topstr);
					}}
			},
			error: function(){

			}
		});

	}
    
</script>
</html>