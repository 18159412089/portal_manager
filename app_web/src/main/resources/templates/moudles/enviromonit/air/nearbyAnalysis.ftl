<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html>
<head>
    <meta charset="UTF-8">
    <title>大气周边分析</title>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/easyui.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/icon.css"/>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="${request.contextPath}/static/plugin/echarts/echarts.min.js"></script>
    <script src="${request.contextPath}/static/js/echarts-liquidfill.js"></script>
    <script src="${request.contextPath}/static/mCustomScrollbar/jquery.mCustomScrollbar.js"></script>
    <script src="${request.contextPath}/static/common/Ams.js"></script>
</head>
<body>
<div class="easyui-layout" fit=true>
    <div style="margin:20px 0;"></div>
    <div class="easyui-tabs easyui-tabs-bg" data-options="tabWidth:112" style="width:100%px;height:600px">
        <div title="污染源" style="padding:10px">
            <table id="tt" class="easyui-datagrid" style="width:100%;height:250px"
            url="${request.contextPath}/enviromonit/air/nearbyAnalysis/peList?code=${code}&range=${range}"
            sortName="c1" sortOrder="desc"
            rownumbers="true" pagination="false" fitColumns=true fit=true singleSelect=true>
		        <thead>
		            <tr>
		                <th field="peName" width="100" formatter="Ams.tooltipFormat">企业名称</th>
		                <th field="name" width="80" formatter="Ams.tooltipFormat">排口名称</th>
		                <th field="measureTime" width="80" align="right">最新监测时间</th>
		                <th field="c1" width="80" align="right" sortable="true">NOx折算浓度</th>
		                <th field="c2" width="80" align="right" sortable="true">烟气流量</th>
		                <th field="c3" width="80" align="right" sortable="true">排放速率</th>
		                <th field="cz" width="80" align="center" formatter="formatView">操作</th>
		            </tr>
		        </thead>
		    </table>
        </div>
        <div title="工地" style="padding:10px">
            <table id="tt2" class="easyui-datagrid" style="width:100%;height:250px"
            url="${request.contextPath}/enviromonit/air/nearbyAnalysis/projectList?code=${code}&range=${range}"
            sortName="builtValue" sortOrder="desc"
            rownumbers="true" pagination="false" fitColumns=true fit=true singleSelect=true>
		        <thead>
		            <tr>
		                <th field="name" width="100" formatter="Ams.tooltipFormat">工地名称</th>
		                <th field="builtValue" width="80" align="right" sortable="true">工地规模</th>
		                <th field="address" width="80" align="left" formatter="Ams.tooltipFormat">地址</th>
		                <th field="remark" width="80" align="left" formatter="Ams.tooltipFormat">备注</th>
		            </tr>
		        </thead>
		    </table>
        </div>
    </div>
</div>    
<!--   历史数据分析     -->
<div id="peDlg" title="历史数据分析" class="easyui-dialog" style="width: 1000px; height: 600px; background: #adadad;"
	data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
	<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
		<div data-options="region:'west'" class="radio-button-group radio-button-group1 style-list fl" style="width:100px;">
			<span id="nox" class="active" value="1">NOx折算浓度</span>
			<span value="2">烟气流量</span>
			<span value="3">排放速率</span>
		</div>
		<div data-options="region:'center'" style="padding:5px;background:#eee;">
			<div class="radio-button-group radio-button-group2" style="height: 20px; width: 500px; padding:10px;">
				<span id="24hour" class="active" value="24">24小时</span>
				<span value="72">72小时</span>
			</div>
			<div id="peAnalysisBar" style="height: 500px; width: 100%;"></div>
		</div>
	</div>
</div>

	<script>
		var selectedOutputId = "";
        Ams.addCtx("${request.contextPath}");
        $(function () {
        	$(".radio-button-group1,.radio-button-group2").on("click", "span", function () {
        		$(this).siblings("span").removeClass("active");
        		$(this).addClass("active");
        		getConHourchart();
        	});
        	$("#peDlg").dialog({
    			onClose: function () {
    				$(".radio-button-group1,.radio-button-group2").children("span").removeClass("active");
    				$("#nox").addClass("active");
    				$("#24hour").addClass("active");
    			}
    		});
        });
        function formatView(value,row,index){
    		return '<a href="javascript:void(0)" class="easyui-linkbutton" onClick="viewChart(\''+row.outputId+'\')">历史数据分析</a>';
		}
        function viewChart(outputId) {
        	$('#peDlg').dialog('open').dialog('center');
        	selectedOutputId = outputId;
        	getConHourchart();
        }
        function getConHourchart(){
        	var peAnalysisBar = echarts.init(document.getElementById("peAnalysisBar"));
        	$.ajax({
        		type : 'POST',
        		url : '/enviromonit/air/nearbyAnalysis/getConHourchart',
        		async : true,
        		data : {
        			outputId : selectedOutputId,
        			codeIndex : $(".radio-button-group1 .active").attr("value"),
        			hours : $(".radio-button-group2 .active").attr("value")
        		},
        		success : function(data) {
        			peAnalysisBar.hideLoading();
        			peAnalysisBar.clear();
        			var series = data.series;
                    var time = data.xAxis;
                    var legend = data.legend;
					peAnalysisBar.setOption({        //加载数据图表
        				tooltip : {
        	                trigger: 'axis',//trigger: 'item'
        	                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
        	                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        	                }
        	            },
        				title: {
        	                text: $(".radio-button-group1 .active").text(),
        	                textStyle:{
        	                    fontSize: 16,
        	                    color:'#000000'
        					},
        	                left:'10',
        					top:'10'
        	            },
        	            toolbox : {
        					show : true,
        					iconStyle : {
        						borderColor : '#000000'
        					},
        					feature : {
        						saveAsImage : {
        							show : true
        						}
        					}
        				},
        	            textStyle: {
        	                color:'#000000'
        	            },
        	            grid: {
        	                top:'80',
        	                left: '50',
        	                right: '30',
        	                bottom: '10',
        	                containLabel: true
        	            },
        	            legend: {
        	                data:legend,
        	                textStyle: {
        	                    color:'#000000'
        	                },
        	            },
                        xAxis: [{
                        	type : 'category',
                        	axisLabel:{
                                type:'category',
                            },
                            data:  time
                        }],
                         yAxis : [{
        			            type : 'value'
        			        }],  
                        series: series
                    });
        		},
        		error : function(jqXHR, textStatus, errorThrown) {
        		},
        		dataType : 'json'
        	});
        	
        }
    </script>
</body>
</html>