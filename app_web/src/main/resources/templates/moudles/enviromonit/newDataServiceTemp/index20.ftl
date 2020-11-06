<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>监测站-省数据分析-大气环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<!-- 数据列表页面 -->
<div class="easyui-layout">
	<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
	<div id="toolbar1">
        <!-- 搜索栏 -->
        <div id="searchBar1" class="searchBar">
            <form id="searchForm1">
            	<div class="inline-block">
					<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				    <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"/>
	            </div>
            	<div class="inline-block">
					<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
	             	<input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName"/>
	            </div>			            	           	
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
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" onclick="Ams.exportPdfById('imgPdf','监测站-省数据分析-大气环境')" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
            </form>
        </div>
        <!-- 搜索栏 over-->

		<div class="chart-group" id="imgPdf">
			<!-- 数据信息 -->
			<div class="data-info-layout">
				<div class="other">
					<div class="inline-block">
						<span class="control-label">监测时间：</span>
						<span class="control-content" id="dateFormat2"></span>
					</div>
					<div class="inline-block">
						<span class="control-label">监测站点：</span>
						<span class="control-content" id="points"></span>
					</div>
				</div>
				<div class="row" id="words">
				</div>

			</div>
			<!-- 数据信息  over-->

			<!-- 图表栏-->
			<div class="chartBar" id="parent0">
				<div class="chart-box" id="chart0" style="height: 400px;"></div>
			</div>
			<!-- 图表栏 over-->

		</div>
	    <!-- 工具栏 over-->
    </div>
	
</div>
<!-- 数据列表页面 over-->	
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
			$('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
			$('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
			setQx(doSearch);
        });
    };

	/**
	 * 重置按钮
	 */
	function doReset() {
		$("#searchForm1").form('clear');
		$('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
		$('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
		setQx(doSearch);
	}

    
    function setQx(doSearch){
		$("#regionName").combobox({
			url: "${request.contextPath}/enviromonit/airMonitorPoint/getCity?all=1",
			valueField: 'uuid',//值字段
			textField: 'name',//显示字段
			method: 'POST',
			editable: false,//不可编辑只能选择
			value: '  请选择  ',
			onLoadSuccess: function () {
				//数据加载完毕事件,选中第一个数值
				var data = $(this).combobox('getData');
				data[data.length]
				if(data.length != 0){
					$(this).combobox('select', data[0].uuid);
				}
			},
			onSelect: function (obj) {
				//$("#pointName").combobox("setValue", '  请选择  ');//清除市列表

				$("#pointName").combobox({
					url: "${request.contextPath}/enviromonit/airMonitorPoint/getPointByCity?parent="+obj.uuid,
					valueField: "uuid",
					textField: "name",
					panelHeight: "auto",
					multiple:true,//多选
					editable: false, //不允许手动输入
					onLoadSuccess: function () {
						//数据加载完毕事件,选中第一个数值
						var data = $(this).combobox('getData');
						data[data.length]
						if(data.length != 0){
							$(this).combobox('select', data[0].uuid);
							doSearch.call();
						}
					}
				});
			}
		});
	}
 	
    $(function(){
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");

        });
        
    });
	var startTime;
	var endTime;
    function doSearch(){
		startTime = $("#startTime").val().trim();
		endTime = $("#endTime").val().trim();
		var loadIndex = layer.load(1, {
			shade: [0.1, '#fff']
		});
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/airDataService/getPointDateByHour",
			data : {
				"type" : 'day',
				"points" : getPointName(),
				"startTime" : startTime,
				"endTime" : endTime
			},
			dataType: "json",
			success: function(result){
				var array = $('#parent0').nextAll();
				for(var i=0;i<array.length;i++){
					array[i].remove();
				}
				console.info(result);
				for(var j=0;j<result.length-1;j++){
					$("#parent"+j).after("<div class='chartBar' id='parent"+(j+1)+"'>"+
					"<div id='chart"+(j+1)+"' class='chart-box' style='height: 400px;'></div></div>");
				}
				for(var j in result){
					var pollutionAnalysis = echarts.init(document.getElementById('chart'+j));
					setAllSitesBar(pollutionAnalysis, result[j].county, result[j].xAxis, result[j].series);
				}
				layer.close(loadIndex);
			},
			error: function(r){
				console.log(r);
			}
		});
		
		var date = getStart().split("-");
		var endT = getEnd().split("-");
		var dateFormat = date[0]+"年"+date[1]+"月"+date[2]+"日";
		var dateFormat2 = date[0]+"年"+date[1]+"月"+date[2]+"日~"+endT[0]+"年"+endT[1]+"月"+endT[2]+"日";
		$("#dateFormat2").html(dateFormat2);
		$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/enviromonit/airPoint/analysisCharts",
			data : {
				"pointName" : getPointName(),
				"start" : startTime,
				"end" : endTime
			},
			dataType: "json",
			success: function(result){
				var j = 0;
				var html = "";
				var point = "";
				for(var i = 0;i < result.length; i++){
					console.log(result);
					if(j==3){
						point = point.substr(0, point.length-1);
						break;
					}
					html += '<div class="item col-xs-4"><div class="cell-title">'+result[i].name+'均值：</div><div class="cell-content"><div>'+
					        '<div class="inline-block"><span>PM2.5：</span><span class="em '+result[i].PM25Status+'">'+result[i].PM25+'</span></div>'+
					        '<div class="inline-block"><span>PM10：</span><span class="em '+result[i].PM10Status+'">'+result[i].PM10+'</span></div>'+
							'<div class="inline-block"><span>SO2：</span><span class="em '+result[i].SO2Status+'">'+result[i].SO2+'</span></div></div>'+
							'<div><div class="inline-block"><span>NO2：</span><span class="em '+result[i].NO2Status+'">'+result[i].NO2+'</span>'+
							'</div><div class="inline-block"><span>CO：</span><span class="em '+result[i].COStatus+'">'+result[i].CO+'</span>'+
							'</div><div class="inline-block"><span>O3：</span><span class="em '+result[i].O3Status+'">'+result[i].O3+'</span>'+
							'</div></div></div></div>';
					point += result[i].name+"、";
					j++;
				}
				$('#words').html(html);
				$("#points").html(point);
			},
			error: function(r){console.log(r);}
		});
	}
    
    function getPointName(){
		var pointName = $('#pointName').combobox('getValues');
    	if(pointName == "all"){
    		var result = "";
    		var data = $('#pointName').combobox('getData');
    		for(var i=0;i<data.length;i++){
    			if(data[i].uuid != "all"){
	    			result += data[i].uuid + ',';
    			}
            }
    		result = result.substr(0,result.length-1);
    		return result;
    	}
    	return pointName.toString();
	}
	
	function getStart(){
		return startTime;
	}
	
	function getEnd(){
		return endTime;
	}
	
	function setAllSitesBar(pollutionAnalysis, title, xAxis, series){
		pollutionAnalysis.clear();
		var option = {
                title: {
                    text: title,
                    textStyle:{
                        fontSize: 16
    				},
                    left:'10',
    				top:'10'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : ''        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    left: '10',
                    top: 'center',
                    iconStyle: {
                    	borderColor: '#000000'
                    },
                    feature: {
                        saveAsImage: {show: true}
                    }
                },
                legend: {
                    orient: 'horizontal',
                    top: '8%',
                    right:'30',                        
                    data: ['PM2.5','PM10','SO2','NO2','CO','O3-8h'],
                    selected: {
    					'PM2.5': true,
    					'PM10': false,
    					'SO2': false,
    					'NO2': false,
    					'CO': false,
    					'O3-8h': false
    				}
                },
                grid: {
                    top:'80',
                    left: '50',
                    right: '30',
                    bottom: '10',
                    containLabel: true
                },
                xAxis:  {
                    type: 'category',
                    axisLabel:{
                        type:'category'
                    },
                    data: xAxis
                },
                yAxis: [{
                    type: 'value',
                    axisLabel:{
                        formatter:'{value}(μg/m3)'
                    }
                },{
                	type: 'value',
                	axisLabel:{
                        formatter:'{value}(mg/m3)'
                    }
                }],
                series: series
            };
		pollutionAnalysis.setOption(option);
	}
</script>
</html>