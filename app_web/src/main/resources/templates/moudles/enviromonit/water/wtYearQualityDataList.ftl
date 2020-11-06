<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>国家水质年监测结果数据</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
            	<label class="control-label">选择年份：</label>
            	<input class="easyui-combobox" name="queryYear" id="queryYear" data-options="
						url:'${request.contextPath}/enviromonit/water/wtDayData/getYearList',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'130px'"
						style="width:100px;height:30px;">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
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
            fit:true">
        <thead>
        <tr>
            <th field="pointName" width="140px" formatter="Ams.tooltipFormat">断面名称</th>
            <th field="pointQuality" width="100px" formatter="Ams.tooltipFormat">水质考核类别</th>
            <th field="01mm" width="100px" formatter="Ams.tooltipFormat">1月水质</th>
            <th field="02mm" width="100px" formatter="Ams.tooltipFormat">2月水质</th>
            <th field="03mm" width="100px" formatter="Ams.tooltipFormat">3月水质</th>
            <th field="04mm" width="100px" formatter="Ams.tooltipFormat">4月水质</th>
            <th field="05mm" width="100px" formatter="Ams.tooltipFormat">5月水质</th>
            <th field="06mm" width="100px" formatter="Ams.tooltipFormat">6月水质</th>
            <th field="07mm" width="100px" formatter="Ams.tooltipFormat">7月水质</th>
            <th field="08mm" width="100px" formatter="Ams.tooltipFormat">8月水质</th>
            <th field="09mm" width="100px" formatter="Ams.tooltipFormat">9月水质</th>
            <th field="10mm" width="100px" formatter="Ams.tooltipFormat">10月水质</th>
            <th field="11mm" width="100px" formatter="Ams.tooltipFormat">11月水质</th>
            <th field="12mm" width="100px" formatter="Ams.tooltipFormat">12月水质</th>
            <th field="1-12mm" width="100px" formatter="Ams.tooltipFormat">1-12月均值水质</th>
            <th field="polluteName" width="140px" formatter="Ams.tooltipFormat">超III类因子</th>
        </tr>
        </thead>
    </table>
</div>
<script>
	
	
	
	$(function(){
		var i=1;
		$("#queryYear").combobox({
			onLoadSuccess: function () { //数据加载完毕事件
				var date = new Date();
				var year = date.getFullYear();
				$(this).combobox('select', year);
				if(i==1){
					doSearch();
					i++;
				}
				
			}
		})
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
    	var queryYear= $("#queryYear").combobox('getValue')
    	console.log(queryYear);
    	if(isNoEmpty(queryYear)){
    		$('#dg').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtCityHourData/getYearDataQuality',
    		    queryParams: {
    		    	queryYear: queryYear
    		    }
    		});
    	}
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        var date = new Date();
		var year = date.getFullYear();
        $("#queryYear").combobox('select',year);
        doSearch();
    }
    
  
	function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
</script>
</body>
</html>