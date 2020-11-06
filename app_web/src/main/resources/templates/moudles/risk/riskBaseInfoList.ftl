<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>风险源基本信息管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="单位名称">单位名称:</label>
                       <input id="queryENTERNAME" name="ENTERNAME" class="easyui-textbox" style="width: 170px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行业类别">行业类别:</label>
                        <input id="queryFkTrade" name="fkTrade" class="easyui-textbox" style="width: 170px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="组织结构代码">组织结构代码:</label>
                        <input id="queryFkEntercode" name="fkEntercode" class="easyui-textbox" style="width: 170px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行政区划">行政区划:</label>
                        <input id="queryFkRegion" name="fkRegion" class="easyui-textbox" style="width: 170px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="环评审批部门">环评审批部门:</label>
                       <input id="queryAPPROVALDEPARTMENT" name="APPROVALDEPARTMENT" class="easyui-textbox" style="width: 170px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiskBaseInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiskBaseInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiskBaseInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/risk/riskBaseInfo/riskBaseInfoList"
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
					
					<th formatter="Ams.tooltipFormat" field="entername" width="13%">单位名称</th>
					<th formatter="Ams.tooltipFormat" field="fkTrade" width="13%">行业类别</th>
					<th formatter="Ams.tooltipFormat" field="introduction" width="10%">简介</th>
					<th formatter="Ams.tooltipFormat" field="corpname" width="10%">法人代表</th>
					<th formatter="Ams.tooltipFormat" field="telephone" width="10%">联系电话</th>
					<th formatter="Ams.tooltipFormat" field="fkRegion" width="10%">行政区划</th>
					<th formatter="Ams.tooltipFormat" field="fkEntercode" width="10%">组织结构代码</th>
					<th formatter="Ams.tooltipFormat" field="enteraddress" width="15%">地址</th>
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
				<input name="fkIsriskreport" id="fkIsriskreport" class="easyui-textbox" required="true" label="是否编制风险评估报告：是、否:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsplan" id="fkIsplan" class="easyui-textbox" required="true" label="是否有突发环境事件应急预案：是、否:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkTrade" id="fkTrade" class="easyui-textbox" required="true" label="行业类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GUID" id="GUID" class="easyui-textbox" required="true" label="企业ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkRegion" id="fkRegion" class="easyui-textbox" required="true" label="行政区划:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkAttention" id="fkAttention" class="easyui-textbox" required="true" label="关注程度：国控、省控、市控:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="EMERGENCYEVENTSCOUNT" id="EMERGENCYEVENTSCOUNT" class="easyui-textbox" required="true" label="历年发生突发环境事件时间、次数:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LATITUDE" id="LATITUDE" class="easyui-textbox" required="true" label="中心纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="APPROVALTIME" id="APPROVALTIME" class="easyui-textbox" required="true" label="环评审批时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkEntercode" id="fkEntercode" class="easyui-textbox" required="true" label="组织结构代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsplanrrcord" id="fkIsplanrrcord" class="easyui-textbox" required="true" label="是否有突发环境事件应急预案备案：是、否:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="INTRODUCTION" id="INTRODUCTION" class="easyui-textbox" required="true" label="简介:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERADDRESS" id="ENTERADDRESS" class="easyui-textbox" required="true" label="地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERNAME" id="ENTERNAME" class="easyui-textbox" required="true" label="单位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CREATEYEAR" id="CREATEYEAR" class="easyui-textbox" required="true" label="建厂时间（年月）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="APPROVALDOCUMENTNUMBER" id="APPROVALDOCUMENTNUMBER" class="easyui-textbox" required="true" label="环评审批文号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POSTALADDRESS" id="POSTALADDRESS" class="easyui-textbox" required="true" label="通讯地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="APPROVALDEPARTMENT" id="APPROVALDEPARTMENT" class="easyui-textbox" required="true" label="环评审批部门:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FAX" id="FAX" class="easyui-textbox" required="true" label="传真号码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GRAPHICALPLAN" id="GRAPHICALPLAN" class="easyui-textbox" required="true" label="图形化预案标记（1：有，其他：无）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="REQUESTNUMBER" id="REQUESTNUMBER" class="easyui-textbox" required="true" label="审核编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="THREETIME" id="THREETIME" class="easyui-textbox" required="true" label="“三同时”环保验收时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkEnvironmentalrank" id="fkEnvironmentalrank" class="easyui-textbox" required="true" label="环境风险等级：一般、较大、重大:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TELEPHONE" id="TELEPHONE" class="easyui-textbox" required="true" label="联系电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIndustryarealevel" id="fkIndustryarealevel" class="easyui-textbox" required="true" label="所在工业园区级别：国家级、省级、省级以下:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DUTYCALLS" id="DUTYCALLS" class="easyui-textbox" required="true" label="企业值班电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LATEUPYEAR" id="LATEUPYEAR" class="easyui-textbox" required="true" label="最新改扩建时间（年月）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="THREEDOCUMENTNUMBER" id="THREEDOCUMENTNUMBER" class="easyui-textbox" required="true" label="“三同时”环保验收文号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="INDUSTRYAREANAME" id="INDUSTRYAREANAME" class="easyui-textbox" required="true" label="所在工业园区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CORPNAME" id="CORPNAME" class="easyui-textbox" required="true" label="法人代表:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="EMERGENCYTRAINING" id="EMERGENCYTRAINING" class="easyui-textbox" required="true" label="环境应急培训情况:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkWsystem" id="fkWsystem" class="easyui-textbox" required="true" label="所属流域:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FLOORSPACE" id="FLOORSPACE" class="easyui-textbox" required="true" label="厂区面积（m2）。:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="THREEDEPARTMENT" id="THREEDEPARTMENT" class="easyui-textbox" required="true" label="“三同时”环保验收部门:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LONGITUDE" id="LONGITUDE" class="easyui-textbox" required="true" label="中心经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SUBMITTEDTIME" id="SUBMITTEDTIME" class="easyui-textbox" required="true" label="申报时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="EMERGENCYDRILLS" id="EMERGENCYDRILLS" class="easyui-textbox" required="true" label="环境应急演练情况:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="UPDATETIME" id="UPDATETIME" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiskBaseInfo()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		 data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" />
			<table class="table insp-table">
				<tbody class="form-table">
				<tr>
					<td class="title tr">单位名称</td>
					<td class="con">
						<input id="ENTERNAME" name="ENTERNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">行业类别</td>
					<td class="con">
						<input id="fkTrade" name="fkTrade" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr><tr>
					<td class="title tr">简介</td>
					<td class="con">
						<input id="INTRODUCTION" name="INTRODUCTION" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">法人代表</td>
					<td class="con">
						<input id="CORPNAME" name="CORPNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr><tr>
					<td class="title tr">联系电话</td>
					<td class="con">
						<input id="TELEPHONE" name="TELEPHONE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">行政区划</td>
					<td class="con">
						<input id="fkRegion" name="fkRegion" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">组织结构代码</td>
					<td class="con">
						<input id="fkEntercode" name="fkEntercode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">地址</td>
					<td class="con">
						<input id="ENTERADDRESS" name="ENTERADDRESS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">中心纬度</td>
					<td class="con">
						<input id="LATITUDE" name="LATITUDE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">中心经度</td>
					<td class="con">
						<input id="LONGITUDE" name="LONGITUDE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">关注程度</td>
					<td class="con">
						<input id="fkAttention" name="fkAttention" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">历年发生突发环境事件时间、次数</td>
					<td class="con">
						<input id="EMERGENCYEVENTSCOUNT" name="EMERGENCYEVENTSCOUNT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有突发环境事件应急预案备案</td>
					<td class="con">
						<input id="fkIsplanrrcord" name="fkIsplanrrcord" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">是否编制风险评估报告</td>
					<td class="con">
						<input id="fkIsriskreport" name="fkIsriskreport" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有突发环境事件应急预案</td>
					<td class="con">
						<input id="fkIsplan" name="fkIsplan" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">建厂时间（年月）</td>
					<td class="con">
						<input id="CREATEYEAR" name="CREATEYEAR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环评审批文号</td>
					<td class="con">
						<input id="APPROVALDOCUMENTNUMBER" name="APPROVALDOCUMENTNUMBER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">环评审批部门</td>
					<td class="con">
						<input id="APPROVALDEPARTMENT" name="APPROVALDEPARTMENT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环评审批时间</td>
					<td class="con">
						<input id="APPROVALTIME" name="APPROVALTIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">通讯地址</td>
					<td class="con">
						<input id="POSTALADDRESS" name="POSTALADDRESS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">传真号码</td>
					<td class="con">
						<input id="FAX" name="FAX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">图形化预案标记</td>
					<td class="con">
						<input id="GRAPHICALPLAN" name="GRAPHICALPLAN" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环境风险等级</td>
					<td class="con">
						<input id="fkEnvironmentalrank" name="fkEnvironmentalrank" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">所在工业园区级别</td>
					<td class="con">
						<input id="fkIndustryarealevel" name="fkIndustryarealevel" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">所在工业园区名称</td>
					<td class="con">
						<input id="INDUSTRYAREANAME" name="INDUSTRYAREANAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">所属流域</td>
					<td class="con">
						<input id="fkWsystem" name="fkWsystem" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">企业值班电话</td>
					<td class="con">
						<input id="DUTYCALLS" name="DUTYCALLS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">最新改扩建时间</td>
					<td class="con">
						<input id="LATEUPYEAR" name="LATEUPYEAR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环保验收文号</td>
					<td class="con">
						<input id="THREEDOCUMENTNUMBER" name="THREEDOCUMENTNUMBER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">环保验收部门</td>
					<td class="con">
						<input id="THREEDEPARTMENT" name="THREEDEPARTMENT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环保验收时间</td>
					<td class="con">
						<input id="THREETIME" name="THREETIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">环境应急培训情况</td>
					<td class="con">
						<input id="EMERGENCYTRAINING" name="EMERGENCYTRAINING" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">厂区面积（m2）</td>
					<td class="con">
						<input id="FLOORSPACE" name="FLOORSPACE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">申报时间</td>
					<td class="con">
						<input id="SUBMITTEDTIME" name="SUBMITTEDTIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">环境应急演练情况</td>
					<td class="con">
						<input id="EMERGENCYDRILLS" name="EMERGENCYDRILLS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">更新时间</td>
					<td class="con">
						<input id="UPDATETIME" name="UPDATETIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
	 
		function doSearch() {
			$('#dg').datagrid('load', {
				ENTERNAME: $("#queryENTERNAME").val().trim(),
				fkTrade: $("#queryFkTrade").val().trim(),
				fkEntercode: $("#queryFkEntercode").val().trim(),
				fkRegion: $("#queryFkRegion").val().trim(),
				APPROVALDEPARTMENT: $("#queryAPPROVALDEPARTMENT").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiskBaseInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增风险源基本信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/risk/riskBaseInfo/saveRiskBaseInfo';
		}

		function editRiskBaseInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/risk/riskBaseInfo/getRiskBaseInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改风险源基本信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/risk/riskBaseInfo/saveRiskBaseInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiskBaseInfo() {
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

		function deleteRiskBaseInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/risk/riskBaseInfo/deleteRiskBaseInfo',
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
			var rowId = row.guid;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
		}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/risk/riskBaseInfo/getRiskBaseInfo',
				data: {'uuid': rowId},
				success: function (result) {
					console.info(result)
					if(result.SUBMITTEDTIME!=null){
						result.SUBMITTEDTIME = timestampToTime(result.SUBMITTEDTIME);
					}
					if(result.UPDATETIME!=null){
						result.UPDATETIME = timestampToTime(result.UPDATETIME);
					}

					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '风险源基本信息数据明细');
					$('#fm-detail').form('load', result);
				},
				dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/risk/riskBaseInfo/getListExport' +
					'?ENTERNAME='+$("#queryENTERNAME").val().trim()+
					'&fkTrade='+$("#queryFkTrade").val().trim()+
					'&fkEntercode='+$("#queryFkEntercode").val().trim()+
					'&fkRegion='+$("#queryFkRegion").val().trim()+
					'&APPROVALDEPARTMENT='+$("#queryAPPROVALDEPARTMENT").val().trim());
		}

		function timestampToTime(timestamp) {
			var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
			Y = date.getFullYear() + '-';
			M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
			D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
			h = (date.getHours()<10?'0'+(date.getHours()):date.getHours())+ ':';
			m = (date.getMinutes()<10?'0'+(date.getMinutes()):date.getMinutes()) + ':';
			s = (date.getSeconds()<10?'0'+(date.getSeconds()):date.getSeconds());
			return Y + M + D + h + m + s;
		}
</script>
</body>
</html>
