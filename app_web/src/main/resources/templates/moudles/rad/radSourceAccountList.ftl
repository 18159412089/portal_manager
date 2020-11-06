<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>放射源台账管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="标号">标号:</label>
                       <input id="queryBH" name="BH" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="核素名称">核素名称:</label>
                        <input id="queryHSMC" name="HSMC" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="放射源编码">放射源编码:</label>
                       <input id="queryFSYBM" name="FSYBM" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="放射源类别">放射源类别:</label>
                        <input id="queryFSYLB" name="FSYLB" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="来源">来源:</label>
                        <input id="queryLY" name="LY" class="easyui-textbox" style="width: 200px;"><br/>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="场所">场所:</label>
                        <input id="queryCS" name="CS" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="审核人">审核人:</label>
                       <input id="querySHR" name="SHR" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRadSourceAccount()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRadSourceAccount()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRadSourceAccount()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rad/radSourceAccount/radSourceAccountList"
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
					<th  field="radEnterpriseInfo" width="13%" formatter="getEnterpriseName">辐射企业</th>
					<th formatter="Ams.tooltipFormat" field="bh" width="10%">标号</th>
					<th formatter="Ams.tooltipFormat" field="hsmc" width="10%">核素名称</th>
					<th formatter="Ams.tooltipFormat" field="fsybm" width="10%">放射源编码</th>
					<th formatter="Ams.tooltipFormat" field="fsylb" width="10%">放射源类别</th>
					<th formatter="Ams.tooltipFormat" field="fsyyt" width="10%">放射源用途</th>
					<th formatter="Ams.tooltipFormat" field="ly" width="10%">来源</th>
					<th formatter="Ams.tooltipFormat" field="cs" width="13%">场所</th>
					<th formatter="Ams.tooltipFormat" field="cchd" width="10%">出厂活度</th>
					<th formatter="Ams.tooltipFormat" field="sflstz" width="10%">是否历史台帐</th>
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
				<input name="SHR" id="SHR" class="easyui-textbox" required="true" label="审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERID" id="ENTERID" class="easyui-textbox" required="true" label="单位自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LY" id="LY" class="easyui-textbox" required="true" label="来源:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CS" id="CS" class="easyui-textbox" required="true" label="场所:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PKID" id="PKID" class="easyui-textbox" required="true" label="ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CCRQ" id="CCRQ" class="easyui-textbox" required="true" label="出厂日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SHRQ" id="SHRQ" class="easyui-textbox" required="true" label="审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QXSHRQ" id="QXSHRQ" class="easyui-textbox" required="true" label="去向审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSYYT" id="FSYYT" class="easyui-textbox" required="true" label="放射源用途:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BZ" id="BZ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QXSHR" id="QXSHR" class="easyui-textbox" required="true" label="去向审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HSMC" id="HSMC" class="easyui-textbox" required="true" label="核素名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QX" id="QX" class="easyui-textbox" required="true" label="去向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CCHD" id="CCHD" class="easyui-textbox" required="true" label="出厂活度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BH" id="BH" class="easyui-textbox" required="true" label="标号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSYLB" id="FSYLB" class="easyui-textbox" required="true" label="放射源类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SFLSTZ" id="SFLSTZ" class="easyui-textbox" required="true" label="是否历史台帐:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSYBM" id="FSYBM" class="easyui-textbox" required="true" label="放射源编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZT" id="ZT" class="easyui-textbox" required="true" label="状态:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRadSourceAccount()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">标号</td>
		                <td class="con">
		                	<input id="BH" name="BH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">核素名称</td>
						<td class="con">
							<input id="HSMC" name="HSMC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">放射源编码</td>
		                <td class="con">
		                	<input id="FSYBM" name="FSYBM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">放射源类别</td>
						<td class="con">
							<input id="FSYLB" name="FSYLB" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">放射源用途</td>
		                <td class="con">
		                	<input id="FSYYT" name="FSYYT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">来源</td>
						<td class="con">
							<input id="LY" name="LY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">场所</td>
		                <td class="con">
		                	<input id="CS" name="CS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">出厂日期</td>
						<td class="con">
							<input id="CCRQ" name="CCRQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">审核人</td>
		                <td class="con">
		                	<input id="SHR" name="SHR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">审核日期</td>
						<td class="con">
							<input id="SHRQ" name="SHRQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">去向</td>
		                <td class="con">
		                	<input id="QX" name="QX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">去向审核人</td>
						<td class="con">
							<input id="QXSHR" name="QXSHR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">去向审核日期</td>
		                <td class="con">
		                	<input id="QXSHRQ" name="QXSHRQ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">出厂活度</td>
		                <td class="con">
		                	<input id="CCHD" name="CCHD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">是否历史台帐</td>
		                <td class="con">
		                	<input id="SFLSTZ" name="SFLSTZ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">更新时间</td>
		                <td class="con">
		                	<input id="updatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">状态</td>
		                <td class="con">
		                	<input id="ZT" name="ZT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
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

		function getEnterpriseName(val,row){  
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
				BH: $("#queryBH").val().trim(),
				HSMC: $("#queryHSMC").val().trim(),
				FSYBM: $("#queryFSYBM").val().trim(),
				FSYLB: $("#queryFSYLB").val().trim(),
				SHR: $("#querySHR").val().trim(),
				LY: $("#queryLY").val().trim(),
				CS: $("#queryCS").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRadSourceAccount() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增放射源台账');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rad/radSourceAccount/saveRadSourceAccount';
		}

		function editRadSourceAccount() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rad/radSourceAccount/getRadSourceAccount',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改放射源台账');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rad/radSourceAccount/saveRadSourceAccount';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRadSourceAccount() {
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

		function deleteRadSourceAccount() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rad/radSourceAccount/deleteRadSourceAccount',
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
			var rowId = row.pkid;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/rad/radSourceAccount/getRadSourceAccount',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '放射源台账数据明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rad/radSourceAccount/getListExport' +
					'?BH='+$("#queryBH").val().trim()+
					'&HSMC='+$("#queryHSMC").val().trim()+
					'&FSYBM='+$("#queryFSYBM").val().trim()+
					'&FSYLB='+$("#queryFSYLB").val().trim()+
					'&SHR='+$("#querySHR").val().trim()+
					'&LY='+$("#queryLY").val().trim()+
					'&CS='+$("#queryCS").val().trim());
		}
</script>
</body>
</html>
