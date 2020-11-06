<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>近岸海域监测数据管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div  id="searchBar" class="searchBar">
				<form id="searchForm">
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="站位名称">站位名称:</label>
                      <input id="queryStationName" name="stationName" class="easyui-textbox" style="width: 200px;">
				  </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="点位级别">点位级别:</label>
                      <input id="queryDwjb" name="dwjb" class="easyui-textbox" style="width: 200px;">
				  </div>
                 <div class="inline-block">
                     <label  class="textbox-label textbox-label-before" title="国控编码">国控编码:</label>
                     <input id="queryGkCode" name="gkCode" class="easyui-textbox" style="width: 200px;">
				 </div>
					<!-- <input id="querySkCode" name="skCode" class="easyui-textbox" label="省控编码:" style="width: 200px;"> -->
					 
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newSiteMonitorData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editSiteMonitorData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteSiteMonitorData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
					url="${request.contextPath}/area/siteMonitorData/siteMonitorDataList"
				data-options="
					rownumbers:false,
					singleSelect:true,
					striped:true,
					autoRowHeight:false,
					fitColumns:false,
					fit:true,
					pagination:true,
					pageSize:10,
					pageList:[10,30,50]">
			<thead>
				<tr>
					<th formatter="Ams.tooltipFormat" field="stationName" width="10%">站位名称</th>
					<th formatter="Ams.tooltipFormat" field="dwjb" width="10%">点位级别</th>
					<th formatter="Ams.tooltipFormat" field="gkCode" width="10%">国控站位编码</th>
					<th field="skCode" width="10%" formatter="getSkCode">省控站位编码</th>
					<th formatter="Ams.tooltipFormat" field="jclx" width="10%">监测类型</th>
					<th field="jcsj" width="11%" formatter="getJcsj">监测时间</th>
					<th formatter="Ams.tooltipFormat" field="gnlb" width="10%">功能类别</th>
					<th formatter="Ams.tooltipFormat" field="sqdm" width="10%">水期代码</th>
					<th formatter="Ams.tooltipFormat" field="sjmc" width="10%">水期名称</th>
					<th field="operate" width="8%" formatter ="formatView">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="uuid" hidden="true" /> 
			<div style="margin-bottom: 10px">
				<input name="bbp" id="bbp" class="easyui-textbox" required="true" label="甲基对硫磷:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dissolvedO2" id="dissolvedO2" class="easyui-textbox" required="true" label="溶解氧:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="mlll" id="mlll" class="easyui-textbox" required="true" label="滴滴涕:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hxg" id="hxg" class="easyui-textbox" required="true" label="阴离子表面活性剂:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="gnlb" id="gnlb" class="easyui-textbox" required="true" label="功能类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yjlp" id="yjlp" class="easyui-textbox" required="true" label="透明度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qw" id="qw" class="easyui-textbox" required="true" label="叶绿素:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="gkCode" id="gkCode" class="easyui-textbox" required="true" label="国控站位编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zn" id="zn" class="easyui-textbox" required="true" label="砷:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="me" id="me" class="easyui-textbox" required="true" label="铁:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yjl" id="yjl" class="easyui-textbox" required="true" label="锰:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="flza" id="flza" class="easyui-textbox" required="true" label="风速:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cod" id="cod" class="easyui-textbox" required="true" label="化学需氧量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="stationName" id="stationName" class="easyui-textbox" required="true" label="站位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zl" id="zl" class="easyui-textbox" required="true" label="六价铬:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jcsj" id="jcsj" class="easyui-textbox" required="true" label="监测时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yjd" id="yjd" class="easyui-textbox" required="true" label="非离子氨:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="syl" id="syl" class="easyui-textbox" required="true" label="氨氮:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wrshxyl" id="wrshxyl" class="easyui-textbox" required="true" label="粪大肠菌群:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qy" id="qy" class="easyui-textbox" required="true" label="气温:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="szmb" id="szmb" class="easyui-textbox" required="true" label="水质目标:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fe" id="fe" class="easyui-textbox" required="true" label="有机碳:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ddd" id="ddd" class="easyui-textbox" required="true" label="六六六:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="xfw" id="xfw" class="easyui-textbox" required="true" label="悬浮物:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yd" id="yd" class="easyui-textbox" required="true" label="盐度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yjt" id="yjt" class="easyui-textbox" required="true" label="活性硅酸盐:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jjdll" id="jjdll" class="easyui-textbox" required="true" label="马拉硫磷,:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ad" id="ad" class="easyui-textbox" required="true" label="硝酸盐氮:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ni" id="ni" class="easyui-textbox" required="true" label="硒:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="chlorophyll" id="chlorophyll" class="easyui-textbox" required="true" label="有机磷:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="tmd" id="tmd" class="easyui-textbox" required="true" label="采样水深:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lbdm" id="lbdm" class="easyui-textbox" required="true" label="无机氮:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yxsyd" id="yxsyd" class="easyui-textbox" required="true" label="亚硝酸盐氮:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ljg" id="ljg" class="easyui-textbox" required="true" label="五日生化需氧量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hff" id="hff" class="easyui-textbox" required="true" label="硫化物:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dwjb" id="dwjb" class="easyui-textbox" required="true" label="点位级别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fx" id="fx" class="easyui-textbox" required="true" label="气压:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fs" id="fs" class="easyui-textbox" required="true" label="风向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ss" id="ss" class="easyui-textbox" required="true" label="有机氯:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jclx" id="jclx" class="easyui-textbox" required="true" label="监测类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fdcjq" id="fdcjq" class="easyui-textbox" required="true" label="大肠菌群:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qhw" id="qhw" class="easyui-textbox" required="true" label="镍:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sw" id="sw" class="easyui-textbox" required="true" label="水温:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dcjq" id="dcjq" class="easyui-textbox" required="true" label="锌:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="skCode" id="skCode" class="easyui-textbox" required="true" label="省控站位编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hg" id="hg" class="easyui-textbox" required="true" label="石油类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lhw" id="lhw" class="easyui-textbox" required="true" label="氰化物:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cx" id="cx" class="easyui-textbox" required="true" label="潮汛:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="se" id="se" class="easyui-textbox" required="true" label="总铬:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cu" id="cu" class="easyui-textbox" required="true" label="汞:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ylz" id="ylz" class="easyui-textbox" required="true" label="苯并芘:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cs" id="cs" class="easyui-textbox" required="true" label="潮时:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="si" id="si" class="easyui-textbox" required="true" label="镉:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cbxm" id="cbxm" class="easyui-textbox" required="true" label="超标项目:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="tqms" id="tqms" class="easyui-textbox" required="true" label="天气描述:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="no3n" id="no3n" class="easyui-textbox" required="true" label="亚硝酸盐氮:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hyl" id="hyl" class="easyui-textbox" required="true" label="活性磷酸盐:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lb" id="lb" class="easyui-textbox" required="true" label="类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ph" id="ph" class="easyui-textbox" required="true" label="PH:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sjmc" id="sjmc" class="easyui-textbox" required="true" label="类别代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cd" id="cd" class="easyui-textbox" required="true" label="铅:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cyss" id="cyss" class="easyui-textbox" required="true" label="水深:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sqdm" id="sqdm" class="easyui-textbox" required="true" label="水期代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="pb" id="pb" class="easyui-textbox" required="true" label="铜:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lll" id="lll" class="easyui-textbox" required="true" label="挥发酚:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="asDwjb" id="asDwjb" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveSiteMonitorData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">站位名称</td>
		                <td class="con">
		                	<input id="stationName" name="stationName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">点位级别</td>
						<td class="con">
							<input id="dwjb" name="dwjb" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">国控站位编码</td>
		                <td class="con">
		                	<input id="gkCode" name="gkCode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">省控站位编码</td>
						<td class="con">
							<input id="skCode1" name="skCode1" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">监测类型</td>
		                <td class="con">
		                	<input id="jclx" name="jclx" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">监测时间</td>
						<td class="con">
							<input id="jcsj1" name="jcsj1" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">功能类别</td>
		                <td class="con">
		                	<input id="gnlb" name="gnlb" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">类别</td>
						<td class="con">
							<input id="lb" name="lb" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">水期名称</td>
		                <td class="con">
		                	<input id="sjmc" name="sjmc" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水期代码</td>
						<td class="con">
							<input id="sqdm" name="sqdm" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">超标项目</td>
		                <td class="con">
		                	<input id="cbxm" name="cbxm" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">天气描述</td>
						<td class="con">
							<input id="tqms" name="tqms" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">甲基对硫磷</td>
		                <td class="con">
		                	<input id="bbp" name="bbp" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">溶解氧</td>
		                <td class="con">
		                	<input id="dissolvedo2" name="dissolvedo2" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">滴滴涕</td>
		                <td class="con">
		                	<input id="mlll" name="mlll" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">阴离子表面活性剂</td>
		                <td class="con">
		                	<input id="hxg" name="hxg" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">透明度</td>
		                <td class="con">
		                	<input id="yjlp" name="yjlp" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">叶绿素</td>
		                <td class="con">
		                	<input id="qw" name="qw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">砷</td>
		                <td class="con">
		                	<input id="zn" name="zn" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">铁</td>
		                <td class="con">
		                	<input id="me" name="me" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">锰</td>
		                <td class="con">
		                	<input id="yjl" name="yjl" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">风速</td>
		                <td class="con">
		                	<input id="flza" name="flza" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">化学需氧量</td>
		                <td class="con">
		                	<input id="cod" name="cod" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">六价铬</td>
		                <td class="con">
		                	<input id="zl" name="zl" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">非离子氨</td>
		                <td class="con">
		                	<input id="yjd" name="yjd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">氨氮</td>
		                <td class="con">
		                	<input id="syl" name="syl" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">粪大肠菌群</td>
		                <td class="con">
		                	<input id="wrshxyl" name="wrshxyl" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">气温</td>
		                <td class="con">
		                	<input id="qy" name="qy" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">水质目标</td>
		                <td class="con">
		                	<input id="szmb" name="szmb" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">有机碳</td>
		                <td class="con">
		                	<input id="fe" name="fe" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">六六六</td>
		                <td class="con">
		                	<input id="ddd" name="ddd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">悬浮物</td>
		                <td class="con">
		                	<input id="xfw" name="xfw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">盐度</td>
		                <td class="con">
		                	<input id="yd" name="yd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">活性硅酸盐</td>
		                <td class="con">
		                	<input id="yjt" name="yjt" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">马拉硫磷</td>
		                <td class="con">
		                	<input id="jjdll" name="jjdll" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">硝酸盐氮</td>
		                <td class="con">
		                	<input id="ad" name="ad" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">硒</td>
		                <td class="con">
		                	<input id="ni" name="ni" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">有机磷</td>
		                <td class="con">
		                	<input id="chlorophyll" name="chlorophyll" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">采样水深</td>
		                <td class="con">
		                	<input id="tmd" name="tmd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">无机氮</td>
		                <td class="con">
		                	<input id="lbdm" name="lbdm" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">亚硝酸盐氮</td>
		                <td class="con">
		                	<input id="yxsyd" name="yxsyd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">五日生化需氧量</td>
		                <td class="con">
		                	<input id="ljg" name="ljg" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">硫化物</td>
		                <td class="con">
		                	<input id="hff" name="hff" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">气压</td>
		                <td class="con">
		                	<input id="fx" name="fx" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">风向</td>
		                <td class="con">
		                	<input id="fs" name="fs" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">有机氯</td>
		                <td class="con">
		                	<input id="ss" name="ss" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">大肠菌群</td>
		                <td class="con">
		                	<input id="fdcjq" name="fdcjq" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">镍</td>
		                <td class="con">
		                	<input id="qhw" name="qhw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">锌</td>
		                <td class="con">
		                	<input id="dcjq" name="dcjq" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水温</td>
		                <td class="con">
		                	<input id="sw" name="sw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">石油类</td>
		                <td class="con">
		                	<input id="hg" name="hg" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">氰化物</td>
		                <td class="con">
		                	<input id="lhw" name="lhw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">潮汛</td>
		                <td class="con">
		                	<input id="cx" name="cx" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">总铬</td>
		                <td class="con">
		                	<input id="se" name="se" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">汞</td>
		                <td class="con">
		                	<input id="cu" name="cu" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">苯并芘</td>
		                <td class="con">
		                	<input id="ylz" name="ylz" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">潮时</td>
		                <td class="con">
		                	<input id="cs" name="cs" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">亚硝酸盐氮</td>
		                <td class="con">
		                	<input id="no3n" name="no3n" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">活性磷酸盐</td>
		                <td class="con">
		                	<input id="hyl" name="hyl" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">PH</td>
		                <td class="con">
		                	<input id="ph" name="ph" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">铅</td>
		                <td class="con">
		                	<input id="cd" name="cd" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">铜</td>
		                <td class="con">
		                	<input id="pb" name="pb" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">镉</td>
		                <td class="con">
		                	<input id="si" name="si" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		                <td class="title tr">水深</td>
		                <td class="con">
		                	<input id="cyss" name="cyss" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">发酚</td>
		                <td class="con">
		                	<input id="lll" name="lll" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		        </tbody>
		    </table>
		</form>
	</div>
	
	<div id="dlg-detail-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-detail').dialog('close')" style="width: 90px">返回</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};
		
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		function getSkCode(value, row, index) {
			var skCode = row.siteMonitorDataPk.skCode;
			return skCode;
		}
		function getJcsj(value, row, index) {
			var jcsj = Ams.timeDateFormat(row.siteMonitorDataPk.jcsj);
			return jcsj;
		}
		function doSearch() {
			$('#dg').datagrid('load', {
				stationName: $("#queryStationName").val().trim(),
				dwjb: $("#queryDwjb").val().trim(),
				gkCode: $("#queryGkCode").val().trim(),
				/* skCode: $("#querySkCode").val().trim(), */
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newSiteMonitorData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增近岸海域监测数据');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/area/siteMonitorData/saveSiteMonitorData';
		}

		function editSiteMonitorData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/area/siteMonitorData/getSiteMonitorData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改近岸海域监测数据');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/area/siteMonitorData/saveSiteMonitorData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveSiteMonitorData() {
			$('#fm').form('submit', {
				url: url,
				onSubmit: function () {
					return $(this).form('validate');
				},
				success: function (result) {
					var result = JSON.parse(result);
					if (result.type == 'E') {
						Ams.error(result.message);
					} else {
						$('#dlg').dialog('close');
						$('#dg').datagrid('load');
					}
				}
			});
		}

		function deleteSiteMonitorData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/area/siteMonitorData/deleteSiteMonitorData',
							data: {'uuid': row.uuid},
							success: function (result) {
								var result = eval(result);
								if (result.type == 'E') {
									Ams.error(result.message);
								} else {
									$('#dg').datagrid('load');
								}
							},
							dataType: 'json'
						});
					}
				});
			} else {
				$.messager.alert('提示', '请选择一条要删除的记录！');
			}
		}
		

		function formatView(value,row){
			var rowId = row.siteMonitorDataPk.skCode+"_"+row.siteMonitorDataPk.jcsj;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/area/siteMonitorData/getSiteMonitorData',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '近岸海域监测数据明细');
					$('#fm-detail').form('load', result);
					$("#skCode1").textbox('setValue',result.siteMonitorDataPk.skCode)
					$("#jcsj1").textbox('setValue',result.siteMonitorDataPk.JCSJ)
				},
			dataType: 'json'
			});
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/area/siteMonitorData/getListExport' +
					'?stationName='+$("#queryStationName").val().trim()+
					'&dwjb='+$("#queryDwjb").val().trim()+
					'&gkCode='+$("#queryGkCode").val().trim());
		}
</script>
</body>
</html>
