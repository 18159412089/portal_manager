<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>在线月监测数据</title>
	<#include "/header.ftl"/>
	<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
	<style type="text/css">
		.layui-input{
			display: inline;
		}
	</style>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div  id="searchBar" class="searchBar">
            <form id="searchForm">
            	<div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="选择站点">选择站点：</label>
                    <input class="easyui-combobox" name="pointName" id="pointName" prompt="全部" data-options="
						url:'/enviromonit/water/wtCityPoint/getPointsList?type=2',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
                           style="width:156px;height:33px;">
				</div>
			    <div class="inline-block">
                  <label  class="textbox-label textbox-label-before" title="监测时间">监测时间：</label>
                  <input id="startTime" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
			   </div>
            	<div class="inline-block">
                    <span>-</span>
                    <input id="endTime" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
				</div>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
            </form>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
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
            <th field="yearNumber" width="140px" formatter="Ams.tooltipFormat">年</th>
            <th field="monthNumber" width="120px" formatter="Ams.tooltipFormat">月</th>
            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">监测站点</th>
            <th field="w01010" width="120px" formatter="Ams.redFontFormat">水温</th>
            <th field="w01001" width="120px" formatter="Ams.redFontFormat">PH值</th>
            <th field="w01009" width="120px" formatter="Ams.redFontFormat">溶解氧</th>
            <th field="w01014" width="120px" formatter="Ams.redFontFormat">电导率</th>
            <th field="w01003" width="120px" formatter="Ams.redFontFormat">浑浊度</th>
            <th field="w01019" width="120px" formatter="Ams.redFontFormat">高锰酸盐指数</th>
            <th field="w21003" width="120px" formatter="Ams.redFontFormat">氨氮（NH3-N）</th>
            <th field="w21011" width="120px" formatter="Ams.redFontFormat">总磷（以P计）</th>
            <th field="w21001" width="120px" formatter="Ams.redFontFormat">总氮（以氮计）</th>
            <th field="targetQuality" width="60px" formatter="Ams.tooltipFormat">目标水质</th>
            <th field="resultQuality" width="60px" formatter="Ams.tooltipFormat">测试水质</th>
            <th field="polluteNames" width="160px" formatter="Ams.tooltipFormat">超标污染物</th>
        </tr>
        </thead>
    </table>
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script>
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年选择器
		var startTime = laydate.render({
			elem: '#startTime',
			type: 'month',
			format: 'yyyy-M',
			max: getNowDate(0),
			//value: getNowDate(30),
			btns: ['confirm'],
			done: function(text,date){
                var d2 = new Date();
                $("#endTime").val("");
				endTime.config.max = {
					year: d2.getFullYear(),
					month: d2.getMonth(),
					date: date.date
				};
				endTime.config.min = {
					year: date.year,
					month: date.month-1,
					date: date.date
				}
			}
		});
		
		//年月选择器
		var endTime = laydate.render({
			elem: '#endTime',
			type: 'month',
			format: 'yyyy-M',
			//value: getNowDate(0),
			min: getNowDate(365)+"-1",
			max: getNowDate(0)+"-1",
			
			btns: ['confirm'],
			done: function(text,date){ 
			}
		});
		
		window.doReset = function(){
	        $("#searchBar").find("#searchForm").form('clear');
	        var start = new Date(getNowDate(365));
	        var end = new Date();
	        endTime.config.max = {
					year: end.getFullYear(),
					month: end.getMonth(),
					date: end.getDate()
				};
			endTime.config.min = {
				year: start.getFullYear(),
				month: start.getMonth(),
				date: start.getDate()
			}
	        $("#startTime").val(getNowDate(365));
			$("#endTime").val(getNowDate(0));
	        doSearch();
	    }
	});
	$(function(){
		$("#startTime").val(getNowDate(365));
		$("#endTime").val(getNowDate(0));
		doSearch();
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
    	var startTime= $("#startTime").val().trim();
    	var endTime = $("#endTime").val().trim();
    	if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
    		$('#dg').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtMonthData/getPageList',
    		    queryParams: {
    		    	pointName: $("#pointName").val().trim(),
    	            startTime: startTime,
    	            endTime: endTime
    		    }
    		});
    	}
    	
    }

    
    
  //获取时间格式化(cutDay为往前几天，0为当天)
	function getNowDate(cutDay) {
		var d = new Date();
		var nowDateTime = d.getTime() - cutDay*60000*60*24;
		d.setTime(nowDateTime);
		var year = d.getFullYear();
		var month = d.getMonth()+1;
		var date = d.getDate();
		var currentdate = year+"-"+month;
	    return currentdate;
	}
  
	function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
    function exportData() {
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var pointName = $("#pointName").val().trim();
        if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
            $('#dg').datagrid({
                url: '${request.contextPath}/enviromonit/water/wtMonthData/getPageList',
                queryParams: {
                    pointName: $("#pointName").val().trim(),
                    startTime: startTime,
                    endTime: endTime
                }
            });
            window.open(Ams.ctxPath + '/enviromonit/water/wtMonthData/export?pointName='+pointName+'&startTime='+startTime+'&endTime='+endTime);
        }
    }
</script>
</body>
</html>