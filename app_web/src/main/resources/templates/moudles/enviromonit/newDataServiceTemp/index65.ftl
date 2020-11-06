<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>监测站AQI</title>
</head>
<!-- body -->
<body >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout p10" >
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                <input class="easyui-combobox" name="regionName" value="${regionCode!}" id="regionName"
                       style="width:200px;"
                       data-options="url:'${request.contextPath}/enviromonit/water/wtCityPoint/getPointRegionList',
                                                    valueField:'id',
                                                    textField:'text',
                                                    onSelect:function(params){
	                                                    $('#pointName').combobox('clear');
	                                                    $('#pointName').combobox('reload','${request.contextPath}/enviromonit/water/wtCityPoint/getPointListByRegion?type=2&regionCode='+params.id)}" />

                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                <input id="pointName" name="pointName" value="${pointCode!}" style="width: 200px" class="easyui-combobox "
                       data-options="url:'' ,
                                                    valueField:'id',
                                                    textField:'text'" />
            </div>
            <#--<div class="inline-block">
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
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:false,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>-->
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                <input id="dataTime" name="dataTime" class="easyui-datebox" style="width:156px;">
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <#--<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出数据</a>-->
            <a href="javascript:void(0)" onClick=" Ams.exportPdfById('airPrimaryPollutant','超标天数(环比)')"  class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
        </form>

    </div>
    <!-- 搜索栏 over-->

    <div class="chart-group">
        <!-- 数据信息 -->
        <div class="data-info-layout ">
            <div class="other">
                <div class="inline-block">
                    <span class="control-label">监测时间：</span>
                    <span class="control-content" id="jcsj"> </span>
                </div>
                <div class="inline-block">
                    <span class="control-label">监测站点：</span>
                    <span class="control-content" id="poName"></span>
                </div>
            </div>
            <div class="row">
                <div class="item col-xs-4">
                    <div class="cell-title" id="datetime1">2019年06月01日</div>
                    <div class="cell-content">
                        <div class="inline-block">
                            <span>超标：</span>
                            <span class="em" id="times1">0次</span>
                        </div>
                        <div class="inline-block">
                            <span>污染物：</span>
                            <span class="em" id="pollute1">PH</span>
                        </div>
                    </div>
                </div>
                <div class="item col-xs-4">
                    <div class="cell-title" id="datetime2">2019年06月01日</div>
                    <div class="cell-content">
                        <div class="inline-block">
                            <span>超标：</span>
                            <span class="em" id="times2">0次</span>
                        </div>
                        <div class="inline-block">
                            <span>污染物：</span>
                            <span class="em" id="pollute2">PH</span>
                        </div>
                    </div>
                </div>
                <div class="item col-xs-4">
                    <div class="cell-title" id="datetime3">2019年06月01日与2018年06月01日环比</div>
                    <div class="cell-content">
                        <div class="inline-block" id="describe">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 数据信息over -->
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
                <div id="airPrimaryPollutant" style="width: 100%;height: 420px;"></div>
            </div>
        </div>
    </div>

</div>
</body>
<script>
    var poName;
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
    /*单选按钮组*/
    $(".radio-button-group").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        doSearch();
    });
    
    $(function () {
	    $('#dataTime').datebox().datebox('calendar').calendar({
			validator: function(date){
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return d1>=date;
			}
		});
	    $('#dataTime').datebox('setValue',getNowDate(0).substring(0,10));
	    var jcsj = $('#dataTime').val();
	    $("#jcsj").html(jcsj);
		
		
       


    })

    function doSearch(){
    	var dataTime= $("#dataTime").val().trim();
    	$("#jcsj").html(dataTime);
	    poName = $("#pointName").combobox("getText");
	    $("#poName").html(poName);
    	getCharts();
    	getHeadData();
    }

    function getHeadData(){
    	var text = $("#pollutatngroup").find("span[class = 'active' ]").text();
    	var dataTime= $("#dataTime").val().trim();
		var selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
    	var pointName = $("#pointName").val().trim();
    	$.ajax({
			type : 'POST',
			url : "/enviromonit/water/wtDataServiceCompared/pollutionAnalysisSequential",
			data : {
			    "pointCode" : pointName,
				"dataTime" : dataTime,
				"polluteCode" : selectPollutant,
				"category" : 2
			},
			success : function(result) {//datetime1  times1  pollute
				var timescurr = result[0].times;
				var dataTimecurr = result[0].dataTime;
    			var timesYest = result[1].times;
    			var dataTimeYest = result[1].dataTime;
    			$("#datetime1").html(dataTimecurr);
    			$("#times1").html(timescurr+"次");
    			$("#datetime2").html(dataTimeYest);
    			$("#times2").html(timesYest+"次");
    			$("#pollute1").html(text);
    			$("#pollute2").html(text);
    			if(parseInt(timescurr)<parseInt(timesYest)){
    				var times = parseInt(timesYest)-parseInt(timescurr);
    				var ht = '<span>下降：</span><span class="em down">'+times+'次</span>';
    			}else if(parseInt(timescurr)>parseInt(timesYest)){
    				var times = parseInt(timescurr)-parseInt(timesYest);
    				var ht = '<span>增长：</span><span class="em up">'+times+'次</span>';
    			}else{
    				var ht = '<span>不增不减：</span><span class="em">0次</span>';
    			}
   				$("#describe").html(ht);
    			
			},
			error: function(){
				
			}
 		}); 
    }
    
    function getCharts(){
    	var dataTime= $("#dataTime").val().trim();
		var selectPollutant = $("#pollutatngroup").find("span[class = 'active' ]").attr("name");
    	var pointName = $("#pointName").val().trim();
    	var airPrimaryPollutantChart = echarts.init(document.getElementById('airPrimaryPollutant'));
    	if(isNoEmpty(dataTime)){
    		$.ajax({
                type : "GET",
                url : "/enviromonit/water/wtDataServiceCompared/getDataServiceSequential",
                async : false,
                dataType : "json",
                data : {
    				    "pointCode" : pointName,
    					"dataTime" : dataTime,
    					"polluteCode" : selectPollutant,
    					"category" : 2
    				},
                success : function(data) {
                	 // 基于准备好的dom，初始化echarts实例
                    
                    var airPrimaryPollutantOption= {
                        tooltip : {
                            trigger: 'axis',
                            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                type : ''        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        legend: {
                            top:7,
                            data: []
                        },
                        title: {
                            text: poName,
                            top:5,
                            textStyle:{ //设置主标题风格
                                fontSize: 14,
                                color:'#404040',
                                fontWeight:100,
                            },
                        },


                        grid: {
                            top:'50',
                            left: '10',
                            right: '10',
                            bottom: '10',
                            containLabel: true
                        },
                        xAxis:  {
                            type: 'category',
                            data: data.names

                        },
                        yAxis: {
                            type: 'value',
                            splitNumber:12
                        },

                        series: [
                            {
                                name:'pH值',
                                type:'line',
                                symbol: 'circle',
                                symbolSize:6,
                                smooth:false,
                                itemStyle:{
                                    normal: {

                                        color: '#2ba4e9'
                                    }
                                },
                                data:data.valueCurr
                            },
                            {
                                name:'pH值',
                                type:'line',
                                symbol: 'triangle',
                                symbolSize:6,
                                smooth:false,
                                itemStyle:{
                                    normal: {
                                        color: '#ff6262'
                                    }
                                },
                                data:data.valueYest
                            }

                        ]

                    };
                    // 使用刚指定的配置项和数据显示图表。
                    airPrimaryPollutantChart.setOption(airPrimaryPollutantOption);

                }
            });
    	}
    	window.onresize = function() {
            $('#airPrimaryPollutant').width('100%');
            airPrimaryPollutantChart.resize();
        }
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
</script>
</html>