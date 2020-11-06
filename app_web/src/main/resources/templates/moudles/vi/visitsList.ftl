<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>信访投诉管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="信件编号">信件编号:</label>
                       <input id="queryLettercode" name="lettercode" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="来源系统">来源系统:</label>
                       <input id="querySource" name="source" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="案件来源">案件来源:</label>
                       <input id="queryResourcel" name="resourcel" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="案件属性">案件属性:</label>
                        <input id="queryAttribute" name="attribute" class="easyui-textbox" style="width: 200px;">
					</div>
				  	<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newVisits()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editVisits()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteVisits()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/vi/visits/visitsList"
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
					<th formatter="Ams.tooltipFormat" field="lettercode" width="10%">信件编号</th>
					<th formatter="Ams.tooltipFormat" field="source" width="10%">来源系统 </th>
					<th formatter="Ams.tooltipFormat" field="resourcel" width="10%">案件来源</th>
					<th formatter="Ams.tooltipFormat" field="attribute" width="10%">案件属性</th>
					<th formatter="Ams.tooltipFormat" field="petitiontime" width="13%">办理时间</th>
					<th formatter="Ams.tooltipFormat" field="inserttime" width="11%">登记时间</th>
					<th formatter="Ams.tooltipFormat" field="pename" width="11%">被举报单位名称</th>
					<!-- <th field="peaddr" width="13%">被举报单位地址</th> -->
					<th formatter="Ams.tooltipFormat" field="peticontent" width="20%">举报内容</th>
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
				<input name="isfight" id="isfight" class="easyui-textbox" required="true" label="是否群体事件（1是；0否）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hanldtype" id="hanldtype" class="easyui-textbox" required="true" label="转办状态（0，转办；1，市级督办；2，省级督办）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="petitiontime" id="petitiontime" class="easyui-textbox" required="true" label="办理时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="notacceptreason" id="notacceptreason" class="easyui-textbox" required="true" label="不办理原因:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="feedbackstatus" id="feedbackstatus" class="easyui-textbox" required="true" label="处理反馈状态（0：反馈；1：市级督办反馈；2：省级督办反馈）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lettercode" id="lettercode" class="easyui-textbox" required="true" label="信件编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="pollutiontype" id="pollutiontype" class="easyui-textbox" required="true" label="污染类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="industrytype" id="industrytype" class="easyui-textbox" required="true" label="行业类别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="attribute" id="attribute" class="easyui-textbox" required="true" label="案件属性:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="source" id="source" class="easyui-textbox" required="true" label="来源系统（1本系统登记；2厅长信箱；3历史数据；4:12369）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="pollutioncounty" id="pollutioncounty" class="easyui-textbox" required="true" label="被举报单位所在区县:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="petitioner" id="petitioner" class="easyui-textbox" required="true" label="举报人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="isrepeat" id="isrepeat" class="easyui-textbox" required="true" label="是否重复件 :" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="petitionacceptperson" id="petitionacceptperson" class="easyui-textbox" required="true" label="受信人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="eventaddr" id="eventaddr" class="easyui-textbox" required="true" label="事发地:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="peticontent" id="peticontent" class="easyui-textbox" required="true" label="举报内容:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="isaccept" id="isaccept" class="easyui-textbox" required="true" label="是否办理 :" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="inserttime" id="inserttime" class="easyui-textbox" required="true" label="登记时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="petitioneraddr" id="petitioneraddr" class="easyui-textbox" required="true" label="举报人地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		 
			<div style="margin-bottom: 10px">
				<input name="pollutioncity" id="pollutioncity" class="easyui-textbox" required="true" label="被举报单位所在地级市:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="isvalid" id="isvalid" class="easyui-textbox" required="true" label="是否有效件（1是；0否）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="managementperiod" id="managementperiod" class="easyui-textbox" required="true" label="办理期限:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="pename" id="pename" class="easyui-textbox" required="true" label="被举报单位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="peaddr" id="peaddr" class="easyui-textbox" required="true" label="被举报单位地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="resourcel" id="resourcel" class="easyui-textbox" required="true" label="案件来源:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="petitionertel" id="petitionertel" class="easyui-textbox" required="true" label="举报人电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveVisits()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">信件编号</td>
		                <td class="con">
		                	<input id="LETTERCODE" name="LETTERCODE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">来源系统</td>
						<td class="con">
							<input id="SOURCE" name="SOURCE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">案件来源</td>
		                <td class="con">
		                	<input id="RESOURCEL" name="RESOURCEL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">案件属性</td>
						<td class="con">
							<input id="ATTRIBUTE" name="ATTRIBUTE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">是否群体事件</td>
		                <td class="con">
		                	<input id="ISFIGHT" name="ISFIGHT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">转办状态</td>
						<td class="con">
							<input id="HANLDTYPE" name="HANLDTYPE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">办理时间</td>
		                <td class="con">
		                	<input id="PETITIONTIME" name="PETITIONTIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">不办理原因</td>
						<td class="con">
							<input id="NOTACCEPTREASON" name="NOTACCEPTREASON" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">处理反馈状态</td>
		                <td class="con">
		                	<input id="FEEDBACKSTATUS" name="FEEDBACKSTATUS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">是否重复件</td>
						<td class="con">
							<input id="ISREPEAT" name="ISREPEAT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">是否有效件</td>
		                <td class="con">
		                	<input id="ISVALID" name="ISVALID" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">是否办理</td>
						<td class="con">
							<input id="ISACCEPT" name="ISACCEPT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">受信人</td>
		                <td class="con">
		                	<input id="PETITIONACCEPTPERSON" name="PETITIONACCEPTPERSON" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">事发地</td>
		                <td class="con">
		                	<input id="EVENTADDR" name="EVENTADDR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">登记时间</td>
		                <td class="con">
		                	<input id="INSERTTIME" name="INSERTTIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">办理期限</td>
		                <td class="con">
		                	<input id="MANAGEMENTPERIOD" name="MANAGEMENTPERIOD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">污染类别</td>
		                <td class="con">
		                	<input id="POLLUTIONTYPE" name="POLLUTIONTYPE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">行业类别</td>
		                <td class="con">
		                	<input id="INDUSTRYTYPE" name="INDUSTRYTYPE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">被举报单位名称</td>
		                <td class="con">
		                	<input id="PENAME" name="PENAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">被举报单位地址</td>
		                <td class="con">
		                	<input id="PEADDR" name="PEADDR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">被举报单位所在地级市</td>
		                <td class="con">
		                	<input id="POLLUTIONCITY" name="POLLUTIONCITY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">被举报单位所在区县</td>
		                <td class="con">
		                	<input id="POLLUTIONCOUNTY" name="POLLUTIONCOUNTY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">举报人</td>
		                <td class="con">
		                	<input id="PETITIONER" name="PETITIONER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">举报人电话</td>
		                <td class="con">
		                	<input id="PETITIONERTEL" name="PETITIONERTEL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">举报人地址</td>
		                <td class="con">
		                	<input id="PETITIONERADDR" name="PETITIONERADDR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">举报内容</td>
		                <td class="con">
		                	<input id="PETICONTENT" name="PETICONTENT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">更新时间</td>
		                <td class="con">
		                	<input id="updatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				lettercode: $("#queryLettercode").val().trim(),
				source: $("#querySource").val(),
				resourcel: $("#queryResourcel").val(),
				attribute: $("#queryAttribute").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newVisits() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增信访投诉');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/vi/visits/saveVisits';
		}

		function editVisits() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/vi/visits/getVisits',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改信访投诉');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/vi/visits/saveVisits';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveVisits() {
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

		function deleteVisits() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/vi/visits/deleteVisits',
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
			var rowId = row.petiid;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/vi/visits/getVisits',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '信访投诉数据明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/vi/visits/getListExport' +
					'?lettercode='+$("#queryLettercode").val().trim()+
					'&source='+$("#querySource").val()+
					'&resourcel='+$("#queryResourcel").val()+
					'&attribute='+$("#queryAttribute").val().trim());
		}
</script>
</body>
</html>
