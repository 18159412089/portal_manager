<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>辐射企业信息管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div id="searchBar" class="searchBar">
				<form id="searchForm">
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="单位名称">单位名称:</label>
                        <input id="queryENTERNAME" name="ENTERNAME" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="许可证号">许可证号:</label>
                       <input id="queryXKZH" name="XKZH" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="行业类别">行业类别:</label>
                       <input id="queryHYLB" name="HYLB" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="法定代表人">法定代表人:</label>
                       <input id="queryFDDBR" name="FDDBR" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="法人电话">法人电话:</label>
                        <input id="queryFRDH" name="FRDH" class="easyui-textbox" style="width: 200px;"><br>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="联系人">联系人:</label>
                        <input id="queryLXR" name="LXR" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="联系电话">联系电话:</label>
                        <input id="queryLXDH" name="LXDH" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="所在市区">所在市区:</label>
                        <input id="querySZSQ" name="SZSQ" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="所在区县">所在区县:</label>
                        <input id="querySZQX" name="SZQX" class="easyui-textbox" style="width: 200px;">
					</div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRadEnterpriseInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRadEnterpriseInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRadEnterpriseInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rad/radEnterpriseInfo/radEnterpriseInfoList"
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
					<th formatter="Ams.tooltipFormat" field="entername" width="10%">单位名称</th>
					<th formatter="Ams.tooltipFormat" field="fddbr" width="10%">法定代表人</th>
					<th formatter="Ams.tooltipFormat" field="frdh" width="10%">法人电话</th>
					<th formatter="Ams.tooltipFormat" field="xkzfzjg" width="10%">许可证发证机关</th>
					<th formatter="Ams.tooltipFormat" field="xkzh" width="10%">许可证号</th>
					<th formatter="Ams.tooltipFormat" field="szsq" width="10%">所在市区</th>
					<th formatter="Ams.tooltipFormat" field="szqx" width="10%">所在区县</th>
					<th formatter="Ams.tooltipFormat" field="zcdz" width="10%">注册地址</th>
					<th formatter="Ams.tooltipFormat" field="hylb" width="10%">行业类别</th>
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
				<input name="XKZFZJG" id="XKZFZJG" class="easyui-textbox" required="true" label="许可证发证机关:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XKZH" id="XKZH" class="easyui-textbox" required="true" label="许可证号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LXR" id="LXR" class="easyui-textbox" required="true" label="联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGCZ" id="FSGLJGCZ" class="easyui-textbox" required="true" label="辐射管理机构传真:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JDD" id="JDD" class="easyui-textbox" required="true" label="经度度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZCDZ" id="ZCDZ" class="easyui-textbox" required="true" label="注册地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HYLB" id="HYLB" class="easyui-textbox" required="true" label="行业类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JDF" id="JDF" class="easyui-textbox" required="true" label="经度分:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LXDH" id="LXDH" class="easyui-textbox" required="true" label="联系电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXDYB" id="TXDYB" class="easyui-textbox" required="true" label="通讯地邮编:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SZSQ" id="SZSQ" class="easyui-textbox" required="true" label="所在市区:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BZ" id="BZ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSYSCHDZL" id="FSYSCHDZL" class="easyui-textbox" required="true" label="放射源生产活动种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SXZZSCHDZL" id="SXZZSCHDZL" class="easyui-textbox" required="true" label="射线装置生产活动种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XKZBFTJ" id="XKZBFTJ" class="easyui-textbox" required="true" label="许可证颁发条件:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SY" id="SY" class="easyui-textbox" required="true" label="使用（含收贮）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YXSHD" id="YXSHD" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FDDBR" id="FDDBR" class="easyui-textbox" required="true" label="法定代表人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERNAME" id="ENTERNAME" class="easyui-textbox" required="true" label="单位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WDM" id="WDM" class="easyui-textbox" required="true" label="纬度秒:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JDM" id="JDM" class="easyui-textbox" required="true" label="经度秒:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FRDH" id="FRDH" class="easyui-textbox" required="true" label="法人电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SZQX" id="SZQX" class="easyui-textbox" required="true" label="所在区县:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERID" id="ENTERID" class="easyui-textbox" required="true" label="自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WDF" id="WDF" class="easyui-textbox" required="true" label="纬度分:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SXZZSYHDZL" id="SXZZSYHDZL" class="easyui-textbox" required="true" label="射线装置使用活动种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXDZ" id="TXDZ" class="easyui-textbox" required="true" label="通讯地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SZSF" id="SZSF" class="easyui-textbox" required="true" label="所在省份:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WDD" id="WDD" class="easyui-textbox" required="true" label="纬度度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DWZT" id="DWZT" class="easyui-textbox" required="true" label="单位状态:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SXZZSYIL" id="SXZZSYIL" class="easyui-textbox" required="true" label="射线装置使用（含建造）I类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZCDYB" id="ZCDYB" class="easyui-textbox" required="true" label="注册地邮编:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XKZSXRQ" id="XKZSXRQ" class="easyui-textbox" required="true" label="许可证生效日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZZJGDM" id="ZZJGDM" class="easyui-textbox" required="true" label="组织机构代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGFZRDH" id="FSGLJGFZRDH" class="easyui-textbox" required="true" label="辐射管理机构负责人电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XKZASXRQ" id="XKZASXRQ" class="easyui-textbox" required="true" label="许可证失效日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SXZZXSHDZL" id="SXZZXSHDZL" class="easyui-textbox" required="true" label="射线装置销售活动种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGLXR" id="FSGLJGLXR" class="easyui-textbox" required="true" label="辐射管理机构联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGMC" id="FSGLJGMC" class="easyui-textbox" required="true" label="辐射管理机构名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FMFFSWZHDZL" id="FMFFSWZHDZL" class="easyui-textbox" required="true" label="非密封放射物质活动种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGLXRSJ" id="FSGLJGLXRSJ" class="easyui-textbox" required="true" label="辐射管理机构联系人手机:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FMFFSWZHDFW" id="FMFFSWZHDFW" class="easyui-textbox" required="true" label="非密封放射物质活动范围:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSYSYHD" id="FSYSYHD" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FRZJLX" id="FRZJLX" class="easyui-textbox" required="true" label="法人证件类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FRZJHM" id="FRZJHM" class="easyui-textbox" required="true" label="法人证件号码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSGLJGLXRDZYJ" id="FSGLJGLXRDZYJ" class="easyui-textbox" required="true" label="辐射管理机构联系人电子邮件:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZYYYLY" id="ZYYYLY" class="easyui-textbox" required="true" label="主要应用领域:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRadEnterpriseInfo()" style="width: 90px">保存</a>
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
						<td class="title tr">组织机构代码</td>
						<td class="con">
							<input id="ZZJGDM" name="ZZJGDM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">法定代表人</td>
		                <td class="con">
		                	<input id="FDDBR" name="FDDBR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">法人电话</td>
						<td class="con">
							<input id="FRDH" name="FRDH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">法人证件类型</td>
		                <td class="con">
		                	<input id="FRZJLX" name="FRZJLX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">法人证件号码</td>
						<td class="con">
							<input id="FRZJHM" name="FRZJHM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">许可证发证机关</td>
		                <td class="con">
		                	<input id="XKZFZJG" name="XKZFZJG" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">许可证号</td>
						<td class="con">
							<input id="XKZH" name="XKZH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">联系人</td>
		                <td class="con">
		                	<input id="LXR" name="LXR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">联系电话</td>
						<td class="con">
							<input id="LXDH" name="LXDH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">所在省份</td>
		                <td class="con">
		                	<input id="SZSF" name="SZSF" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">所在市区</td>
						<td class="con">
							<input id="SZSQ" name="SZSQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">所在区县</td>
		                <td class="con">
		                	<input id="SZQX" name="SZQX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">注册地址</td>
		                <td class="con">
		                	<input id="ZCDZ" name="ZCDZ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">行业类别</td>
		                <td class="con">
		                	<input id="HYLB" name="HYLB" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">辐射管理机构传真</td>
		                <td class="con">
		                	<input id="FSGLJGCZ" name="FSGLJGCZ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">更新时间</td>
		                <td class="con">
		                	<input id="updatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">通讯地邮编</td>
		                <td class="con">
		                	<input id="TXDYB" name="TXDYB" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">放射源生产活动种类</td>
		                <td class="con">
		                	<input id="FSYSCHDZL" name="FSYSCHDZL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">放射源销售活动种类</td>
		                <td class="con">
		                	<input id="YXSHD" name="YXSHD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">射线装置生产活动种类</td>
		                <td class="con">
		                	<input id="SXZZSCHDZL" name="SXZZSCHDZL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">射线装置使用活动种类</td>
		                <td class="con">
		                	<input id="SXZZSYHDZL" name="SXZZSYHDZL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">射线装置销售活动种类</td>
		                <td class="con">
		                	<input id="SXZZXSHDZL" name="SXZZXSHDZL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">非密封放射物质活动种类</td>
		                <td class="con">
		                	<input id="FMFFSWZHDZL" name="FMFFSWZHDZL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">许可证颁发条件</td>
		                <td class="con">
		                	<input id="XKZBFTJ" name="XKZBFTJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">使用（含收贮）</td>
		                <td class="con">
		                	<input id="SY" name="SY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">经度度</td>
		                <td class="con">
		                	<input id="JDD" name="JDD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">经度分</td>
		                <td class="con">
		                	<input id="JDF" name="JDF" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">经度秒</td>
		                <td class="con">
		                	<input id="JDM" name="JDM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		                <td class="title tr">纬度度</td>
		                <td class="con">
		                	<input id="WDD" name="WDD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">纬度分</td>
		                <td class="con">
		                	<input id="WDF" name="WDF" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">纬度秒</td>
		                <td class="con">
		                	<input id="WDM" name="WDM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">通讯地址</td>
		                <td class="con">
		                	<input id="TXDZ" name="TXDZ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">单位状态</td>
		                <td class="con">
		                	<input id="DWZT" name="DWZT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">射线装置使用（含建造）I类</td>
		                <td class="con">
		                	<input id="SXZZSYIL" name="SXZZSYIL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">注册地邮编</td>
		                <td class="con">
		                	<input id="ZCDYB" name="ZCDYB" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">许可证生效日期</td>
		                <td class="con">
		                	<input id="XKZSXRQ" name="XKZSXRQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">辐射管理机构负责人电话</td>
		                <td class="con">
		                	<input id="FSGLJGFZRDH" name="FSGLJGFZRDH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">许可证失效日期</td>
		                <td class="con">
		                	<input id="XKZASXRQ" name="XKZASXRQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">辐射管理机构联系人</td>
		                <td class="con">
		                	<input id="FSGLJGLXR" name="FSGLJGLXR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">辐射管理机构名称</td>
		                <td class="con">
		                	<input id="FSGLJGMC" name="FSGLJGMC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">射管理机构联系人手机</td>
		                <td class="con">
		                	<input id="FSGLJGLXRSJ" name="FSGLJGLXRSJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">非密封放射物质活动范围</td>
		                <td class="con">
		                	<input id="FMFFSWZHDFW" name="FMFFSWZHDFW" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">放射源使用活动种类</td>
		                <td class="con">
		                	<input id="FSYSYHD" name="FSYSYHD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">辐射管理机构联系人电子邮件</td>
		                <td class="con">
		                	<input id="FSGLJGLXRDZYJ" name="FSGLJGLXRDZYJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">主要应用领域</td>
		                <td class="con">
		                	<input id="ZYYYLY" name="ZYYYLY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">备注</td>
		                <td class="con">
		                	<input id="BZ" name="BZ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				XKZH: $("#queryXKZH").val().trim(),
				LXR: $("#queryLXR").val().trim(),
				HYLB: $("#queryHYLB").val().trim(),
				LXDH: $("#queryLXDH").val().trim(),
				SZSQ: $("#querySZSQ").val().trim(),
				FDDBR: $("#queryFDDBR").val().trim(),
				ENTERNAME: $("#queryENTERNAME").val().trim(),
				FRDH: $("#queryFRDH").val().trim(),
				SZQX: $("#querySZQX").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRadEnterpriseInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增辐射企业信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rad/radEnterpriseInfo/saveRadEnterpriseInfo';
		}

		function editRadEnterpriseInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rad/radEnterpriseInfo/getRadEnterpriseInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改辐射企业信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rad/radEnterpriseInfo/saveRadEnterpriseInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRadEnterpriseInfo() {
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

		function deleteRadEnterpriseInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rad/radEnterpriseInfo/deleteRadEnterpriseInfo',
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
			var rowId = row.enterid;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/rad/radEnterpriseInfo/getRadEnterpriseInfo',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '辐射企业信息数据明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rad/radEnterpriseInfo/getListExport' +
					'?XKZH='+$("#queryXKZH").val().trim()+
					'&LXR='+$("#queryLXR").val().trim()+
					'&HYLB='+$("#queryHYLB").val().trim()+
					'&LXDH='+$("#queryLXDH").val().trim()+
					'&SZSQ='+$("#querySZSQ").val().trim()+
					'&FDDBR='+$("#queryFDDBR").val().trim()+
					'&ENTERNAME='+$("#queryENTERNAME").val().trim()+
					'&FRDH='+$("#queryFRDH").val().trim()+
					'&SZQX='+$("#querySZQX").val().trim());
		}
</script>
</body>
</html>
