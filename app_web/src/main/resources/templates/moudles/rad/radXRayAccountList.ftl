<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>射线装置台账管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="装置名称">装置名称:</label>
                       <input id="queryZZMC" name="zzmc" class="easyui-textbox" style="width: 200px;">
				   </div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="装置类型">装置类型:</label>
                        <input id="queryZZLX" name="zzlx" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="来源">来源:</label>
                       <input id="queryLY" name="ly" class="easyui-textbox" style="width: 200px;">
				   </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="场所">场所:</label>
                      <input id="queryCS" name="cs" class="easyui-textbox" style="width: 200px;">
				  </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="审核人">审核人:</label>
                       <input id="querySHR" name="shr" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRadXRayAccount()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRadXRayAccount()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRadXRayAccount()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rad/radXRayAccount/radXRayAccountList"
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
					<th field="radEnterpriseInfo" width="10%" formatter="getEnterpriseName">辐射企业</th>
					<th formatter="Ams.tooltipFormat" field="zzmc" width="10%">装置名称</th>
					<th formatter="Ams.tooltipFormat" field="zzlx" width="10%">装置类型</th>
					<th formatter="Ams.tooltipFormat" field="yt" width="10%">用途</th>
					<th formatter="Ams.tooltipFormat" field="ly" width="13%">来源</th>
					<th formatter="Ams.tooltipFormat" field="cs" width="13%">场所</th>
					<th formatter="Ams.tooltipFormat" field="ggxh" width="10%">规格型号</th>
					<th formatter="Ams.tooltipFormat" field="shr" width="10%">审核人</th>
					<th formatter="Ams.tooltipFormat" field="sflstz" width="10%">是否历史台帐</th>
					<th formatter="Ams.tooltipFormat" field="updatetimeRjwa" width="11%">更新时间</th>
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
				<input name="ENTERID" id="ENTERID" class="easyui-textbox" required="true" label="单位自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZZLX" id="ZZLX" class="easyui-textbox" required="true" label="装置类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SHR" id="SHR" class="easyui-textbox" required="true" label="审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LY" id="LY" class="easyui-textbox" required="true" label="来源:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CS" id="CS" class="easyui-textbox" required="true" label="场所:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PKID" id="PKID" class="easyui-textbox" required="true" label="自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GGXH" id="GGXH" class="easyui-textbox" required="true" label="规格型号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SHRQ" id="SHRQ" class="easyui-textbox" required="true" label="审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QXSHRQ" id="QXSHRQ" class="easyui-textbox" required="true" label="去向审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BZ" id="BZ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DY" id="DY" class="easyui-textbox" required="true" label="电压:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QXSHR" id="QXSHR" class="easyui-textbox" required="true" label="去向审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QX" id="QX" class="easyui-textbox" required="true" label="去向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DL" id="DL" class="easyui-textbox" required="true" label="电流:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SFLSTZ" id="SFLSTZ" class="easyui-textbox" required="true" label="是否历史台帐:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GL" id="GL" class="easyui-textbox" required="true" label="功率:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZZMC" id="ZZMC" class="easyui-textbox" required="true" label="装置名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YT" id="YT" class="easyui-textbox" required="true" label="用途:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRadXRayAccount()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">装置名称</td>
		                <td class="con">
		                	<input id="ZZMC" name="ZZMC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">装置类型</td>
						<td class="con">
							<input id="ZZLX" name="ZZLX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">用途</td>
		                <td class="con">
		                	<input id="YT" name="YT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
						<td class="title tr">规格型号</td>
						<td class="con">
							<input id="GGXH" name="GGXH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
						<td class="title tr">功率</td>
		                <td class="con">
		                	<input id="GL" name="GL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		                <td class="title tr">电压</td>
		                <td class="con">
		                	<input id="DY" name="DY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">电流</td>
		                <td class="con">
		                	<input id="DL" name="DL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				ZZMC: $("#queryZZMC").val().trim(),
				ZZLX: $("#queryZZLX").val().trim(),
				SHR: $("#querySHR").val().trim(),
				LY: $("#queryLY").val().trim(),
				CS: $("#queryCS").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRadXRayAccount() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增射线装置台账');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rad/radXRayAccount/saveRadXRayAccount';
		}

		function editRadXRayAccount() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rad/radXRayAccount/getRadXRayAccount',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改射线装置台账');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rad/radXRayAccount/saveRadXRayAccount';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRadXRayAccount() {
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

		function deleteRadXRayAccount() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rad/radXRayAccount/deleteRadXRayAccount',
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
				url: Ams.ctxPath + '/rad/radXRayAccount/getRadXRayAccount',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '射线装置台账数据明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rad/radXRayAccount/getListExport' +
					'?ZZMC='+$("#queryZZMC").val().trim()+
					'&ZZLX='+$("#queryZZLX").val().trim()+
					'&SHR='+$("#querySHR").val().trim()+
					'&LY='+$("#queryLY").val().trim()+
					'&CS='+$("#queryCS").val().trim());
		}
</script>
</body>
</html>
