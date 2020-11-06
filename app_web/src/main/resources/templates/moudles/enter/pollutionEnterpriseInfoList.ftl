<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>污染源档案企业信息管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div id="toolbar">
			<div id="searchBar" class="searchBar">
				<form id="searchForm">
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="污染源编码">污染源编码:</label>
                      <input id="queryEntercode" name="entercode" class="easyui-textbox" style="width: 200px;">
				  </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="标准污染源名称">企业名称:</label>
                       <input id="queryEntername" name="entername" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <#-- <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="企业名称">企业名称:</label>
                        <input id="queryCompanyname" name="companyname" class="easyui-textbox" style="width: 200px;">
					</div> -->
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="所属行业">所属行业:</label>
                        <input id="queryTrade" name="trade" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="企业类型">企业类型:</label>
<#--                       <input id="queryCodeEntertype" name="codeEntertype" class="easyui-textbox" style="width: 200px;"><br>-->
					   <input id="queryCodeEntertype" class="easyui-combobox" name="codeEntertype" style="height: 32px; width: 200px;" data-options="
							url:'/enter/pollutionEnterpriseInfo/getEnterType',
							method:'post',
							valueField:'id',
							textField:'name',
							multiple:false,
							panelHeight:'auto'">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="企业地址">企业地址:</label>
                       <input id="queryEnteraddress" name="enteraddress" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="行政区代码">行政区代码:</label>
                       <input id="queryCodeRegion" name="codeRegion" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行政区名称">行政区名称:</label>
                        <input id="queryRegionname" name="regionname" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                     <label  class="textbox-label textbox-label-before" title="所属流域">所属流域:</label>
<#--                     <input id="queryWsystem" name="wsystem" class="easyui-textbox" style="width: 200px;">-->
					   <input id="queryCodeEntertype" class="easyui-combobox" name="codeEntertype" style="height: 32px; width: 200px;" data-options="
							url:'/enter/pollutionEnterpriseInfo/getWsystem',
							method:'post',
							valueField:'id',
							textField:'name',
							multiple:false,
							panelHeight:'auto'">
				   </div>
					<!-- <input id="queryUpdatetime" name="updatetime" class="easyui-textbox" label="最后更新时间:" style="width: 200px;"> -->
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newPollutionEnterpriseInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editPollutionEnterpriseInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePollutionEnterpriseInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/enter/pollutionEnterpriseInfo/pollutionEnterpriseInfoList"
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
					<th formatter="Ams.tooltipFormat"  field="entercode" width="10%">污染源编码</th>
					<th formatter="Ams.tooltipFormat"  field="entername" width="15%">企业名称</th>
					<#-- <th formatter="Ams.tooltipFormat"  field="companyname" width="10%">企业名称</th> -->
					<th formatter="Ams.tooltipFormat"  field="codeEntertype" width="10%">企业类型</th>
					<th formatter="Ams.tooltipFormat"  field="codeRegistertype" width="10%">登记注册类型</th>
					<th formatter="Ams.tooltipFormat"  field="trade" width="10%">所属行业</th>
					<th formatter="Ams.tooltipFormat"  field="codeTrade" width="10%">行业代码</th>
					<th formatter="Ams.tooltipFormat"  field="enteraddress" width="10%">企业地址</th>
					<th formatter="Ams.tooltipFormat"  field="wsystem" width="10%">所属流域</th>
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
				<input name="codeAttentiondegree" id="codeAttentiondegree" class="easyui-textbox" required="true" label="关注程度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="entercode" id="entercode" class="easyui-textbox" required="true" label="污染源编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="envinvestmoneytype" id="envinvestmoneytype" class="easyui-textbox" required="true" label="环保总投资币种:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeEntertype" id="codeEntertype" class="easyui-textbox" required="true" label="企业类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="psenvironmentdept" id="psenvironmentdept" class="easyui-textbox" required="true" label="污染源环保部门:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeUnittypecode" id="codeUnittypecode" class="easyui-textbox" required="true" label="单位类别编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="createtime" id="createtime" class="easyui-textbox" required="true" label="开业时间（投产日期）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="latitude" id="latitude" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="website" id="website" class="easyui-textbox" required="true" label="网址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeControllevel" id="codeControllevel" class="easyui-textbox" required="true" label="污染源监管类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="moneytype" id="moneytype" class="easyui-textbox" required="true" label="总投资币种类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeIndustryareaname" id="codeIndustryareaname" class="easyui-textbox" required="true" label="所在工业园区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="standenterid" id="standenterid" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="postalcode" id="postalcode" class="easyui-textbox" required="true" label="邮编:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeEntersize" id="codeEntersize" class="easyui-textbox" required="true" label="污染源规模编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="enteraddress" id="enteraddress" class="easyui-textbox" required="true" label="企业地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="entername" id="entername" class="easyui-textbox" required="true" label="标准污染源名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environtel" id="environtel" class="easyui-textbox" required="true" label="环保联系人电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="bankname" id="bankname" class="easyui-textbox" required="true" label="银行名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="email" id="email" class="easyui-textbox" required="true" label="邮箱地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environphone" id="environphone" class="easyui-textbox" required="true" label="环保联系人手机:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="corpcode" id="corpcode" class="easyui-textbox" required="true" label="法人代码，格式:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="historyentername" id="historyentername" class="easyui-textbox" required="true" label="曾用名:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environinvest" id="environinvest" class="easyui-textbox" required="true" label="环保投资（万元）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fax" id="fax" class="easyui-textbox" required="true" label="传真:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environmentmans" id="environmentmans" class="easyui-textbox" required="true" label="专职环保人员数:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="bankcode" id="bankcode" class="easyui-textbox" required="true" label="银行账户:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="companyname" id="companyname" class="easyui-textbox" required="true" label="企业名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="communicateaddr" id="communicateaddr" class="easyui-textbox" required="true" label="通讯地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="trade" id="trade" class="easyui-textbox" required="true" label="所属行业:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dutyperson" id="dutyperson" class="easyui-textbox" required="true" label="污染源责任人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environlinkmen" id="environlinkmen" class="easyui-textbox" required="true" label="环保联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="regionname" id="regionname" class="easyui-textbox" required="true" label="行政区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="telephone" id="telephone" class="easyui-textbox" required="true" label="电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="totalinvest" id="totalinvest" class="easyui-textbox" required="true" label="总投资（万元）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeTrade" id="codeTrade" class="easyui-textbox" required="true" label="行业代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeRegion" id="codeRegion" class="easyui-textbox" required="true" label="行政区代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="corpname" id="corpname" class="easyui-textbox" required="true" label="法人代表姓名:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeRegistertype" id="codeRegistertype" class="easyui-textbox" required="true" label="登记注册类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="linkman" id="linkman" class="easyui-textbox" required="true" label="联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeEnterrelation" id="codeEnterrelation" class="easyui-textbox" required="true" label="隶属关系:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="shortname" id="shortname" class="easyui-textbox" required="true" label="简称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeQualification" id="codeQualification" class="easyui-textbox" required="true" label="单位资质:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="longitude" id="longitude" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wsystem" id="wsystem" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="environfax" id="environfax" class="easyui-textbox" required="true" label="环保联系人传真:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeWsystem" id="codeWsystem" class="easyui-textbox" required="true" label="所属流域:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetime" id="updatetime" class="easyui-textbox" required="true" label="最后更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePollutionEnterpriseInfo()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>
<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">污染源编码</td>
		                <td class="con">
		                	<input id="entercode" name="entercode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">标准污染源名称</td>
						<td class="con">
							<input id="entername" name="entername" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">简称</td>
		                <td class="con">
		                	<input id="shortname" name="shortname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">污染源规模编码</td>
						<td class="con">
							<input id="codeEntersize" name="codeEntersize" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">企业名称</td>
		                <td class="con">
		                	<input id="companyname" name="companyname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">曾用名</td>
						<td class="con">
							<input id="historyentername" name="historyentername" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">企业类型</td>
		                <td class="con">
		                	<input id="codeEntertype" name="codeEntertype" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">登记注册类型</td>
						<td class="con">
							<input id="codeRegistertype" name="codeRegistertype" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">所属行业</td>
		                <td class="con">
		                	<input id="trade" name="trade" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">行业代码</td>
						<td class="con">
							<input id="codeTrade" name="codeTrade" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">企业地址</td>
		                <td class="con">
		                	<input id="enteraddress" name="enteraddress" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">法人代码</td>
						<td class="con">
							<input id="corpcode" name="corpcode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">法人代表姓名</td>
		                <td class="con">
		                	<input id="corpname" name="corpname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">电话</td>
		                <td class="con">
		                	<input id="telephone" name="telephone" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">污染源环保部门</td>
		                <td class="con">
		                	<input id="psenvironmentdept" name="psenvironmentdept" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">单位类别编码</td>
		                <td class="con">
		                	<input id="codeUnittypecode" name="codeUnittypecode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">所属流域</td>
		                <td class="con">
		                	<input id="wsystem" name="wsystem" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">所属流域编码</td>
		                <td class="con">
		                	<input id="codeWsystem" name="codeWsystem" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">关注程度</td>
		                <td class="con">
		                	<input id="codeAttentiondegree" name="codeAttentiondegree" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">开业时间（投产日期）</td>
		                <td class="con">
		                	<input id="createtime" name="createtime" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">经度</td>
		                <td class="con">
		                	<input id="longitude" name="longitude" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">纬度</td>
		                <td class="con">
		                	<input id="latitude" name="latitude" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">网址</td>
		                <td class="con">
		                	<input id="website" name="website" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">污染源监管类型</td>
		                <td class="con">
		                	<input id="codeControllevel" name="codeControllevel" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">所在工业园区名称</td>
		                <td class="con">
		                	<input id="codeIndustryareaname" name="codeIndustryareaname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">邮编</td>
		                <td class="con">
		                	<input id="postalcode" name="postalcode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">环保联系人</td>
		                <td class="con">
		                	<input id="environlinkmen" name="environlinkmen" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">环保联系人电话</td>
		                <td class="con">
		                	<input id="environtel" name="environtel" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">环保联系人手机</td>
		                <td class="con">
		                	<input id="environphone" name="environphone" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">环保联系人传真</td>
		                <td class="con">
		                	<input id="environfax" name="environfax" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">银行名称</td>
		                <td class="con">
		                	<input id="bankname" name="bankname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">银行账户</td>
		                <td class="con">
		                	<input id="bankcode" name="bankcode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">邮箱地址</td>
		                <td class="con">
		                	<input id="email" name="email" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">传真</td>
		                <td class="con">
		                	<input id="fax" name="fax" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">专职环保人员数</td>
		                <td class="con">
		                	<input id="environmentmans" name="environmentmans" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">通讯地址</td>
		                <td class="con">
		                	<input id="communicateaddr" name="communicateaddr" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">污染源责任人</td>
		                <td class="con">
		                	<input id="dutyperson" name="dutyperson" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">联系人</td>
		                <td class="con">
		                	<input id="linkman" name="linkman" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">隶属关系</td>
		                <td class="con">
		                	<input id="codeEnterrelation" name="codeEnterrelation" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">单位资质</td>
		                <td class="con">
		                	<input id="codeQualification" name="codeQualification" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">总投资币种类型</td>
		                <td class="con">
		                	<input id="moneytype" name="moneytype" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">总投资（万元）</td>
		                <td class="con">
		                	<input id="totalinvest" name="totalinvest" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">环保总投资币种</td>
		                <td class="con">
		                	<input id="envinvestmoneytype" name="envinvestmoneytype" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">环保投资（万元）</td>
		                <td class="con">
		                	<input id="environinvest" name="environinvest" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">行政区名称</td>
		                <td class="con">
		                	<input id="regionname" name="regionname" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">行政区代码</td>
		                <td class="con">
		                	<input id="codeRegion" name="codeRegion" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">最后更新时间</td>
		                <td class="con">
		                	<input id="updatetime" name="updatetime" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				entercode: $("#queryEntercode").val().trim(),
				enteraddress: $("#queryEnteraddress").val().trim(),
				entername: $("#queryEntername").val().trim(),
				/* companyname: $("#queryCompanyname").val().trim(), */
				codeEntertype: $("#queryCodeEntertype").val().trim(),
				trade: $("#queryTrade").val().trim(),
				codeRegion: $("#queryCodeRegion").val().trim(),
				regionname: $("#queryRegionname").val().trim(),
				wsystem: $("#queryWsystem").val()
				/* updatetime: $("#queryUpdatetime").val(), */
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}


		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/enter/pollutionEnterpriseInfo/getListExport' +
					'?entercode='+$("#queryEntercode").val().trim()+
					'&enteraddress='+$("#queryEnteraddress").val().trim()+
					'&entername='+$("#queryEntername").val().trim()+
				/*	'&companyname='+$("#queryCompanyname").val().trim()+*/
					'&codeEntertype='+$("#queryCodeEntertype").val().trim()+
					'&trade='+$("#queryTrade").val().trim()+
					'&codeRegion='+$("#queryCodeRegion").val().trim()+
					'&regionname='+$("#queryRegionname").val().trim()+
					'&wsystem='+$("#queryWsystem").val().trim());
		}
		
		function newPollutionEnterpriseInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增污染源档案企业信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/enter/pollutionEnterpriseInfo/savePollutionEnterpriseInfo';
		}

		function editPollutionEnterpriseInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/enter/pollutionEnterpriseInfo/getPollutionEnterpriseInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改污染源档案企业信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/enter/pollutionEnterpriseInfo/savePollutionEnterpriseInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePollutionEnterpriseInfo() {
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

		function deletePollutionEnterpriseInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/enter/pollutionEnterpriseInfo/deletePollutionEnterpriseInfo',
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
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+row.standenterid+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/enter/pollutionEnterpriseInfo/getPollutionEnterpriseInfo',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '污染源档案企业信息明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			}); 
		}
</script>
</body>
</html>
