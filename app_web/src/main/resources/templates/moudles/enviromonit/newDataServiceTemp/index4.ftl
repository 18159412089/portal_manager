<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>省接口 - 气基础资料</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
	<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
	<div id="toolbar1">
	       <!-- 搜索栏 -->
	       <div id="searchBar1" class="searchBar">
	           <form id="searchForm1">
				   <div class="inline-block">
					   <label class="textbox-label textbox-label-before" title="地区">地区:</label>
					   <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"
							  prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'post',
									editable:false,
									valueField:'uuid',
						          textField:'name',
									multiple:true,
									panelHeight:'350px'"
							  style="width:200px;"/>
				   </div>
	               <div class="inline-block">
					<label class="textbox-label textbox-label-before" title="时间">时间:</label>
		            <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
		            <label>-</label>
		            <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
		        </div>
		        <#--<div class="inline-block" style="display: none">
		        	<label class="textbox-label textbox-label-before" title="时间">污染因子:</label>
		            <div class="selectBox-container" style="width:200px;">
						<a href="javascript:void(0)" class="easyui-linkbutton select-button btn-orange">因子选择</a>
						<div class="select-panel">
							<div class="easyui-panel" title="污染物" style="width:560px;height:200px;padding:10px;" data-options="footer:'#ft',tools:'#tt'">
								<div id="selectGrop">
									<!--复选框&ndash;&gt;
									<label class="form-checkbox">
										<input name="type" type="checkbox" value="" checked="checked"/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">行政区</span>
									</label>
									<label class="form-checkbox">
										<input name="type" type="checkbox" value=""/>
										<span class="lbl">测点</span>
									</label>
									<!--复选框 over&ndash;&gt;
								</div>
							</div>
							<div id="tt">
								<label class="form-checkbox">
									<input name="type" type="checkbox" value="" class="all"/>
									<span class="lbl">全选</span>
								</label>
							</div>										
							<div class="tr" id="ft">
								<button type="button" class="btnSure btn-blue l-btn">确定</button>
							</div>										
						</div>
					</div>
		            
		        </div>       -->
	               <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
	                  onclick="doSearch()">查询</a>
	               <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
	                  onclick="doReset()">重置</a>
	           </form>
	       </div>
	       <!-- 搜索栏 over-->
	       <!-- 操作栏-->
	    <div class="optionBar">
	    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro()">导出数据</a>
	    	<#--<a href="javascript:void(0)" class="easyui-linkbutton btn-purple" data-options="iconCls:'iconcustom icon-xiazai1'">导入模板</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'iconcustom icon-xiazai2'">模板下载</a>
	    	-->
	    </div>
	    <!-- 操作栏 over-->
	   </div>
	   <!-- 工具栏 over-->

	<!-- 数据列表-->
	<table id="dg" class="easyui-datagrid" url="" toolbar="#toolbar1"
		   url="${request.contextPath}/environment/debriefing/list"
		   data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		<thead>
		<tr>
			<th field="monitorTime" width="190px" formatter="Ams.timeDateFormat">监测时间</th>
			<th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区</th>
			<th field="pointName" width="170px" formatter="Ams.tooltipFormat">监测站点</th>
			<!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
            <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
			<#--<th field="aqi" width="160px" id="AQI" styler="Ams.setAQIBackground">AQI</th>-->
			<th field="pm25" width="160px" id="PM2.5" id="" formatter="Ams.tooltipFormat">PM2.5(μg/m3)</th>
			<th field="pm10" width="160px" id="PM10" formatter="Ams.tooltipFormat">PM10(μg/m3)</th>
			<th field="so2" width="160px" id="SO2" formatter="Ams.tooltipFormat">SO2(μg/m3)</th>
			<th field="no2" width="160px" id="NO2" formatter="Ams.tooltipFormat">NO2(μg/m3)</th>
			<th field="o38" width="160px" id="O3" formatter="Ams.tooltipFormat">O3(μg/m3)</th>
			<th field="co" width="160px" id="CO" formatter="Ams.tooltipFormat">CO(mg/m3)</th>
			<!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
		</tr>
		</thead>
	</table>
	<!-- 数据列表 over-->
</div>
</body>
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

        });
        
        
    });


	/**
	 * 查询所有
	 */
	function doSearch() {
		var startTime = $("#startTime").val().trim();
		var endTime = $("#endTime").val().trim();
		if (Ams.isNoEmpty(startTime) && Ams.isNoEmpty(endTime)) {
			$('#dg').datagrid({
				url: Ams.ctxPath + '/enviromonit/airHourData/list',
				queryParams: {
					codeRegion: $("#regionName").val().trim(),
					pointType: '0',
					startTime: startTime,
					endTime: endTime,
					flag: 'hour'
				}
			});
		}
	}
	/**
	 * 重置按钮
	 */
	function doReset() {
		$("#searchForm1" ).form('clear');
		$('#startTime' ).datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
		$('#endTime' ).datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
		doSearch();
	}

	/**
	 * 导出省控数据excel
	 */
	function exportExlPro(){
		var regionName = $("#regionName").val().trim();
		var startTime= $("#startTime").val().trim();
		var endTime = $("#endTime").val().trim();
		var u = Ams.ctxPath + '/enviromonit/airHourData/list';
		var f = 'hour';
		var tle = '省接口-气基础资料';
		window.location.href = u + "?datatype=2&codeRegion=" + regionName  + "&startTime=" + startTime + "&endTime=" + endTime + "&pointType=0"
				 + "&flag=" + f + "&exportExl=exportExl" + "&exportTitle=" + tle;
	}
	function getjsTime() {
		var jcTime = "";
		var startTime = $("#startTime").val().trim();
		var endTime = $("#endTime").val().trim();
		if (pointType == 0) {
			if (flag == "hour")
				jcTime = startTime + " 00:00" + "~" + endTime + " 23:59";
			if (flag == "day") {
				jcTime = startTime + "~" + endTime
			}
			if (flag == "month") {
				jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
			}
			if (flag == "year") {
				jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
			}
		} else {
			if (flag2 == "hour")
				jcTime = startTime + " 00:00" + "~" + endTime + " 23:59";
			if (flag2 == "day") {
				jcTime = startTime + "~" + endTime;
			}
			if (flag2 == "month") {
				jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7)
			}
			if (flag2 == "year") {
				jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4)
			}
		}
		return jcTime;
	}
</script>
</html>