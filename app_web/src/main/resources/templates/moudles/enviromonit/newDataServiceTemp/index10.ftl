<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>污染物分析-省数据分析-大气环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
	<!-- tabs 标签页 -->
	<div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
		<!-- 标签页——1 -->
		<div title="省实时监测" style="padding:10px">
			<!-- 数据列表页面 -->
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar1">
			        <!-- 搜索栏 -->
			        <div id="searchBar1" class="searchBar">
			            <form id="searchForm1">
			                <div class="inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
					            <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
					            <label>-</label>
					            <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
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
				    			<span class="control-content" id="dateFormat2"></span>
				    		</div>
				    		
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">首要污染物排名前三</div>
				    			<div class="cell-content" id="topThree" style="height: 35px">
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">首要污染物排名后三</div>
				    			<div class="cell-content" id="bottomThree" style="height: 35px">
								</div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div id="titleBar" class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">首要污染物分析</h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
				    	<div id="choseDate" class="radio-button-group style-btn-group">
							<span id="choseMonth" class="active">月</span>
							<span id="choseYear">年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onClick="downloadImpByChart('charts')">导出图片</a>
				    </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">
				    	<div class="optionBar tc">
					    	<!-- 单选按钮组 -->
					    	<div id="factoryBar" class="radio-button-group style-btn-group">
								<span class="active">PM2.5</span>
								<span>PM10</span>
								<span>NO2</span>
								<span>CO</span>
								<span>O3</span>
								<span>SO2</span>
							</div>
					    	<!-- 单选按钮组 over-->
					    </div>	    	
				    	<div id="charts" class="chart-box"></div>
				    </div>
				    <!-- 图表栏 over-->		
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg1" class="easyui-datagrid" toolbar="#toolbar1"
		            data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						fitColumns:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		            <thead>
			            <tr>
			                <th field="monitortime" width="150">监测日期</th>
			                <th field="regionname" width="100">地区</th>
			                <#--<th field="pointname" width="150" align="center">站点</th>-->
			                <th field="pollute" width="120" align="center">首要污染物</th>
			                <th field="dayCount" width="120" align="center">监测天数</th>
			                <th field="monitorCount" width="120" align="center">监测次数</th>
			            </tr>
		            </thead>
		        </table>
				<!-- 数据列表 over-->
			</div>
			<!-- 数据列表页面 over-->		
		</div>
		<!-- 标签页——1 over-->
		
		<!-- 标签页——2
		<div title="自建实时监测" style="padding:10px">
			自建实时监测		
		</div>-->
		<!-- 标签页——2 over-->
		
		
		
		
	</div>
	<!-- tabs 标签页 over -->

</div>
</body>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/airDataAnalysis.js"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
			$('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
			$('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
			doSearch();
        });
    };
    
    $(function(){
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if(getTitle() == "文字"){
            	doSearchWords();
            }else{
            	doSearchCharts();
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
        /**/
        $("#tabs").tabs({
        	onSelect:function(title,index){
        		console.log(index);
        	}
        });
        
    });
    
    function doSearchCharts(){
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airPollute/analysisCharts',
            data:{
				dateType : getDateType(),
            	factory : getFactory(),
            	pointType : "city",
            	start : getStart(),
            	end : getEnd()
            },
            async:true,
            success: function (result) {
				var charts = echarts.init(document.getElementById('charts'));
				if(JSON.stringify(result) == "{}"){
					charts.hideLoading();
					charts.clear();
					return;
				}
            	setCharts(charts, result.charts.title, result.charts.xAxis, result.charts.series);
            	console.info(result.words.bottom);
            	if(result.words.bottom != null){
            		var bottomHtml = "";
            		$("#bottomThree").html(bottomHtml);
            		for(var i=0;i<result.words.bottom.length;i++){
            			var temp = result.words.bottom[i];
            			bottomHtml += '<div class="inline-block"><div class="inline-block">'
            					+'<span>'+temp.name+getFactory()+'：</span><span class="em">'
            					+ temp.value +'</span>次</div></div>'; 
                	}
            		$("#bottomThree").html(bottomHtml);
            	}

            	if(result.words.top != null){
	            	var topHtml = "";
	        		$("#topThree").html(topHtml);
	        		for(var i=0;i<result.words.top.length;i++){
            			var temp = result.words.top[i];
	        			topHtml += '<div class="inline-block"><div class="inline-block">'
	        					+'<span>'+temp.name+getFactory()+'：</span><span class="em">'
	        					+ temp.value +'</span>次</div></div>'; 
	            	}
	        		$("#topThree").html(topHtml);
            	}
            }
		});
    }
    
    function doSearchWords(){
        $('#dg1').datagrid({
            url: Ams.ctxPath + '/enviromonit/airPollute/analysisWords', //获取数据后台接口
            method:"GET",
            queryParams:{
            	dateType : getDateType(),
            	pointType : "city",
				start : getStart(),
				end : getEnd()
            },
            striped:true,
            loadMsg:"正在努力加载数据,表格渲染中...",
            onLoadSuccess: function (data) {
                console.log(data);
                if (data == null){
                    //自定义页面信息加载框
                    msgShow("error","请求数据为空!",'warning');
                }
            },
        });
    }
    
    function doSearch(){
		var end = getEnd().split("-");
		var start = getStart().split("-");
		var dateFormat2 = start[0]+"年"+start[1]+"月"+start[2]+"日~"+end[0]+"年"+end[1]+"月"+end[2]+"日";
		$("#dateFormat2").html(dateFormat2);
	    doSearchCharts();
	    doSearchWords();
    }
    
	function doReset(){
		$('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
		$('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
        doSearch();
	}

	function getStart(){
		return $("#startTime").val();
	}

	function getEnd(){
		return $("#endTime").val();
	}
	
	function getFactory(){
		return $("#factoryBar span.active").text();
	}
	
	function getTitle(){
		return $("#titleBar span.active").text();
	}
	
	function getDateType(){
		var dateType = $("#choseDate span.active").text();
		if(dateType == "年"){
			
		}else{
			
		}
		return dateType;
	}
</script>
</html>