<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>风险单元基本信息管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="风险单元名称">风险单元名称:</label>
                       <input id="queryDISCHARGEPORTNAME" name="DISCHARGEPORTNAME" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="主要化学物质名称">主要化学物质名称:</label>
                        <input id="queryCHEMISTRYNAME" name="CHEMISTRYNAME" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="事故应急池是否是自流式">事故应急池是否是自流式:</label>
                        <input id="queryWHETHERTHESCOOP" name="WHETHERTHESCOOP" class="easyui-textbox" style="width: 200px;">
					</div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="是否有泄露报警装置">是否有泄露报警装置：</label>
                        <input id="queryFkIsalarmdevice" name="fkIsalarmdevice" class="easyui-textbox" style="width: 200px;"><br/>
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="是否接入远程监控网">是否接入远程监控网：</label>
                       <input id="queryFkIscontrol" name="fkIscontrol" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="事故废水排放去向">事故废水排放去向：</label>
                       <input id="queryFkDischarge" name="fkDischarge" class="easyui-textbox" style="width: 200px;">
				   </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="风险单元类型">风险单元类型：</label>
                      <input id="queryFkDischargeporttype" name="fkDischargeporttype" class="easyui-textbox" style="width: 200px;">
				  </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiskBaseUnitInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiskBaseUnitInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiskBaseUnitInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/risk/riskBaseUnitInfo/riskBaseUnitInfoList"
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
					<th field="dischargeportname" width="10%">风险单元名称</th>
					<th field="riskBaseInfo" width="10%" formatter="getEnterName">企业名称</th>
					<th field="chemistryname" width="10%">主要化学物质名称</th>
					<th field="riskcharacteristicsother" width="10%">风险特征其他</th>
					<th field="emergencydevice" width="10%">泄漏气体紧急处置装置</th>
					<th field="fkIsfacilities" width="10%">是否有污水排放口监控及关闭设施</th>
					<th field="seepagecontrolmeasures" width="10%">防渗具体措施</th>
					<th field="fkIsalarmpool" width="10%">是否有事故应急池：有，无</th>
					<th field="chemistrycontent" width="10%">主要化学物质年现存量（吨）</th>
					
					<th field="riskcharacteristicstemperature" width="10%">风险特征反应条件高温高压</th>

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
				<input name="GUID" id="GUID" class="easyui-textbox" required="true" label="企业ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RISKCHARACTERISTICSOTHER" id="RISKCHARACTERISTICSOTHER" class="easyui-textbox" required="true" label="风险特征其他:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="EMERGENCYDEVICE" id="EMERGENCYDEVICE" class="easyui-textbox" required="true" label="泄漏气体紧急处置装置:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsfacilities" id="fkIsfacilities" class="easyui-textbox" required="true" label="是否有污水排放口监控及关闭设施:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SEEPAGECONTROLMEASURES" id="SEEPAGECONTROLMEASURES" class="easyui-textbox" required="true" label="防渗具体措施：若有，注明材料名称，如高密度聚乙烯防渗膜、低密度聚乙烯防渗膜、线性低密度聚乙烯防渗膜、土工布等。:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RISKCHARACTERISTICSLEAKAGE" id="RISKCHARACTERISTICSLEAKAGE" class="easyui-textbox" required="true" label="风险特征化学物质易泄露:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsalarmpool" id="fkIsalarmpool" class="easyui-textbox" required="true" label="是否有事故应急池：有，无:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkStoremode" id="fkStoremode" class="easyui-textbox" required="true" label="贮存方式:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CHEMISTRYCONTENT" id="CHEMISTRYCONTENT" class="easyui-textbox" required="true" label="主要化学物质年现存量（吨）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DISCHARGEPORTNAME" id="DISCHARGEPORTNAME" class="easyui-textbox" required="true" label="风险单元名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RISKCHARACTERISTICSTEMPERATURE" id="RISKCHARACTERISTICSTEMPERATURE" class="easyui-textbox" required="true" label="风险特征反应条件高温高压:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ID" id="ID" class="easyui-textbox" required="true" label="唯一标识:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsswitch" id="fkIsswitch" class="easyui-textbox" required="true" label="是否有清污分流切换阀门：有，无:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ALARMPOOLSIZE" id="ALARMPOOLSIZE" class="easyui-textbox" required="true" label="事故应急池容积（立方米）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsclean" id="fkIsclean" class="easyui-textbox" required="true" label="是否有清净下水排放缓冲池或雨水收集池:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WHETHERTHESCOOP" id="WHETHERTHESCOOP" class="easyui-textbox" required="true" label="事故应急池是否是自流式:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RISKCHARACTERISTICSPOISON" id="RISKCHARACTERISTICSPOISON" class="easyui-textbox" required="true" label="风险特征毒性:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsalarmdevice" id="fkIsalarmdevice" class="easyui-textbox" required="true" label="是否有泄露报警装置：是否在有毒有害、易燃易爆气体贮存区、使用点等处设置气体泄漏探测器，探测有毒有害、可燃气体的泄漏，当气体泄漏达到报警浓度时，气体监视系统发出声光报警信号。:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIswhethernetworksound" id="fkIswhethernetworksound" class="easyui-textbox" required="true" label="事故应急池配套导流管网是否健全:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsleakage" id="fkIsleakage" class="easyui-textbox" required="true" label="是否有地面防渗材料：在风险单元区域内是否铺设防渗材料。有，无:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="COFFERDAMHEIGHT" id="COFFERDAMHEIGHT" class="easyui-textbox" required="true" label="围堰高度（米）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="COFFERDAMSIZE" id="COFFERDAMSIZE" class="easyui-textbox" required="true" label="围堰有效容积（立方米）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIscontrol" id="fkIscontrol" class="easyui-textbox" required="true" label="是否接入远程监控网：厂内的气/液体泄漏侦测、报警系统接入何级环保部门的远程监控网络系统联网，并给出联网终端名称、级别。:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkDischarge" id="fkDischarge" class="easyui-textbox" required="true" label="事故废水排放去向：1、进入厂区的污水处理系统；2、进入事故应急池；3、进入清净下水系统或雨水排水系统；4 其他:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RISKCHARACTERISTICSEXPLOSIVE" id="RISKCHARACTERISTICSEXPLOSIVE" class="easyui-textbox" required="true" label="风险特征易燃易爆:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CONTROLREMARKS" id="CONTROLREMARKS" class="easyui-textbox" required="true" label="远程监控网说明:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CHEMISTRYMAX" id="CHEMISTRYMAX" class="easyui-textbox" required="true" label="主要化学物质单日最大贮存量（吨）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIsrainshuntswitchvalve" id="fkIsrainshuntswitchvalve" class="easyui-textbox" required="true" label="是否由雨污分流切换阀:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkDischargeporttype" id="fkDischargeporttype" class="easyui-textbox" required="true" label="风险单元类型：罐区、装置区、其他设施:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIssane" id="fkIssane" class="easyui-textbox" required="true" label="雨水收集池配套导流管网是否健全:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CUSHIONPOOLSIZE" id="CUSHIONPOOLSIZE" class="easyui-textbox" required="true" label="雨水收集池容积（立方米）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIscofferdam" id="fkIscofferdam" class="easyui-textbox" required="true" label="是否有围堰：有，无:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SUBMITTEDTIME" id="SUBMITTEDTIME" class="easyui-textbox" required="true" label="提交时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkIspoisonousgases" id="fkIspoisonousgases" class="easyui-textbox" required="true" label="是否有有毒有害气体:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="UPDATETIME" id="UPDATETIME" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CHEMISTRYNAME" id="CHEMISTRYNAME" class="easyui-textbox" required="true" label="主要化学物质名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiskBaseUnitInfo()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		 data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" />
			<table class="table insp-table">
				<tbody class="form-table">
				<tr>
					<td class="title tr">风险单元名称</td>
					<td class="con">
						<input id="DISCHARGEPORTNAME" name="DISCHARGEPORTNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">主要化学物质名称</td>
					<td class="con">
						<input id="CHEMISTRYNAME" name="CHEMISTRYNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr><tr>
					<td class="title tr">风险特征其他</td>
					<td class="con">
						<input id="RISKCHARACTERISTICSOTHER" name="RISKCHARACTERISTICSOTHER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">泄漏气体紧急处置装置</td>
					<td class="con">
						<input id="EMERGENCYDEVICE" name="EMERGENCYDEVICE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr><tr>
					<td class="title tr">是否有污水排放口监控及关闭设施</td>
					<td class="con">
						<input id="fkIsfacilities" name="fkIsfacilities" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">防渗具体措施</td>
					<td class="con">
						<input id="SEEPAGECONTROLMEASURES" name="SEEPAGECONTROLMEASURES" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">风险特征化学物质易泄露</td>
					<td class="con">
						<input id="RISKCHARACTERISTICSLEAKAGE" name="RISKCHARACTERISTICSLEAKAGE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">是否有事故应急池</td>
					<td class="con">
						<input id="fkIsalarmpool" name="fkIsalarmpool" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">贮存方式</td>
					<td class="con">
						<input id="fkStoremode" name="fkStoremode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">主要化学物质年现存量（吨）</td>
					<td class="con">
						<input id="CHEMISTRYCONTENT" name="CHEMISTRYCONTENT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">风险特征反应条件高温高压</td>
					<td class="con">
						<input id="RISKCHARACTERISTICSTEMPERATURE" name="RISKCHARACTERISTICSTEMPERATURE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">是否有清污分流切换阀门</td>
					<td class="con">
						<input id="fkIsswitch" name="fkIsswitch" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">事故应急池容积（立方米）</td>
					<td class="con">
						<input id="ALARMPOOLSIZE" name="ALARMPOOLSIZE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">是否有清净下水排放缓冲池或雨水收集池</td>
					<td class="con">
						<input id="fkIsclean" name="fkIsclean" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">事故应急池是否是自流式</td>
					<td class="con">
						<input id="WHETHERTHESCOOP" name="WHETHERTHESCOOP" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">风险特征毒性</td>
					<td class="con">
						<input id="RISKCHARACTERISTICSPOISON" name="RISKCHARACTERISTICSPOISON" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有泄露报警装置</td>
					<td class="con">
						<input id="fkIsalarmdevice" name="fkIsalarmdevice" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">事故应急池配套导流管网是否健全</td>
					<td class="con">
						<input id="fkIswhethernetworksound" name="fkIswhethernetworksound" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有地面防渗材料：</td>
					<td class="con">
						<input id="fkIsleakage" name="fkIsleakage" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">围堰高度（米）</td>
					<td class="con">
						<input id="POSTALADDRESS" name="POSTALADDRESS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">围堰有效容积（立方米）</td>
					<td class="con">
						<input id="COFFERDAMSIZE" name="COFFERDAMSIZE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">是否接入远程监控网</td>
					<td class="con">
						<input id="fkIscontrol" name="fkIscontrol" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">事故废水排放去向</td>
					<td class="con">
						<input id="fkDischarge" name="fkDischarge" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">主要化学物质单日最大贮存量（吨）</td>
					<td class="con">
						<input id="CHEMISTRYMAX" name="CHEMISTRYMAX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否由雨污分流切换阀</td>
					<td class="con">
						<input id="fkIsrainshuntswitchvalve" name="fkIsrainshuntswitchvalve" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">风险单元类型</td>
					<td class="con">
						<input id="fkDischargeporttype" name="fkDischargeporttype" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">雨水收集池配套导流管网是否健全</td>
					<td class="con">
						<input id="fkIssane" name="fkIssane" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">雨水收集池容积（立方米）</td>
					<td class="con">
						<input id="CUSHIONPOOLSIZE" name="CUSHIONPOOLSIZE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有围堰</td>
					<td class="con">
						<input id="fkIscofferdam" name="fkIscofferdam" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
					<td class="title tr">提交时间</td>
					<td class="con">
						<input id="SUBMITTEDTIME" name="SUBMITTEDTIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title tr">是否有有毒有害气体</td>
					<td class="con">
						<input id="fkIspoisonousgases" name="fkIspoisonousgases" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
		function getEnterName(val,row){  
		    if(val) return val.entername;  
		    else return "";  
		}  
		
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		 
		function doSearch() {
			$('#dg').datagrid('load', {
			 
				DISCHARGEPORTNAME: $("#queryDISCHARGEPORTNAME").val().trim(),
				WHETHERTHESCOOP: $("#queryWHETHERTHESCOOP").val().trim(),
				fkIsalarmdevice: $("#queryFkIsalarmdevice").val().trim(),
				fkIscontrol: $("#queryFkIscontrol").val().trim(),
				fkDischarge: $("#queryFkDischarge").val().trim(),
				fkDischargeporttype: $("#queryFkDischargeporttype").val().trim(),
			 
				CHEMISTRYNAME: $("#queryCHEMISTRYNAME").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiskBaseUnitInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增风险单元基本信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/risk/riskBaseUnitInfo/saveRiskBaseUnitInfo';
		}

		function editRiskBaseUnitInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/risk/riskBaseUnitInfo/getRiskBaseUnitInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改风险单元基本信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/risk/riskBaseUnitInfo/saveRiskBaseUnitInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiskBaseUnitInfo() {
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

		function deleteRiskBaseUnitInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/risk/riskBaseUnitInfo/deleteRiskBaseUnitInfo',
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
			var rowId = row.id;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
		}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/risk/riskBaseUnitInfo/getRiskBaseUnitInfo',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '风险单元信息数据明细');
					console.info(result);
					var SUBMITTEDTIME = result.SUBMITTEDTIME;
					if(SUBMITTEDTIME != null){
						result.SUBMITTEDTIME = timestampToTime(SUBMITTEDTIME);
					}
					var UPDATETIME = result.UPDATETIME;
					if(UPDATETIME != null) {
						result.UPDATETIME = timestampToTime(UPDATETIME);
					}
					$('#fm-detail').form('load', result);
				},
				dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/risk/riskBaseUnitInfo/getListExport' +
					'?DISCHARGEPORTNAME='+$("#queryDISCHARGEPORTNAME").val().trim()+
					'&WHETHERTHESCOOP='+$("#queryWHETHERTHESCOOP").val().trim()+
					'&fkIsalarmdevice='+$("#queryFkIsalarmdevice").val().trim()+
					'&fkIscontrol='+$("#queryFkIscontrol").val().trim()+
					'&fkDischarge='+$("#queryFkDischarge").val().trim()+
					'&fkDischargeporttype='+$("#queryFkDischargeporttype").val().trim()+
					'&CHEMISTRYNAME='+$("#queryCHEMISTRYNAME").val().trim());
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
