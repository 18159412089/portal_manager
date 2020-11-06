<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水利厅水文站点管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="测站编码">测站编码:</label>
                       <input id="querySTCD" name="STCD" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="测站名称">测站名称:</label>
                       <input id="querySTNM" name="STNM" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="站类">站类:</label>
                       <input id="querySTTP" name="STTP" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="站址">站址:</label>
                        <input id="querySTLC" name="STLC" class="easyui-textbox" style="width: 200px;"><br>
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="行政区划码">行政区划码:</label>
                       <input id="queryADDVCD" name="ADDVCD" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="河流名称">河流名称:</label>
                       <input id="queryRVNM" name="RVNM" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="流域名称">流域名称:</label>
                        <input id="queryBSNM" name="BSNM" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="水系名称">水系名称:</label>
                       <input id="queryHNNM" name="HNNM" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newWtcdSiteInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editWtcdSiteInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteWtcdSiteInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/wtcd/wtcdSiteInfo/wtcdSiteInfoList"
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
					<th formatter="Ams.tooltipFormat" field="stcd" width="10%">测站编码</th>
					<th formatter="Ams.tooltipFormat" field="stnm" width="10%">测站名称</th>
					<th formatter="Ams.tooltipFormat" field="sttp" width="10%">站类</th>
					<th formatter="Ams.tooltipFormat" field="stlc" width="10%">站址</th>
					<th formatter="Ams.tooltipFormat" field="addvcd" width="10%">行政区划码</th>
					<th formatter="Ams.tooltipFormat" field="essym" width="10%">建站年月</th>
					<th formatter="Ams.tooltipFormat" field="hnnm" width="10%">水系名称</th>
					<th formatter="Ams.tooltipFormat" field="bsnm" width="10%">流域名称</th>
					<th formatter="Ams.tooltipFormat" field="rvnm" width="10%">河流名称</th>
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
				<input name="PHCD" id="PHCD" class="easyui-textbox" required="true" label="拼音码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="USFL" id="USFL" class="easyui-textbox" required="true" label="启用标志:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DTPR" id="DTPR" class="easyui-textbox" required="true" label="基面修正值:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STTP" id="STTP" class="easyui-textbox" required="true" label="站类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DRNA" id="DRNA" class="easyui-textbox" required="true" label="集水面积:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DTMEL" id="DTMEL" class="easyui-textbox" required="true" label="基面高程:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BGFRYM" id="BGFRYM" class="easyui-textbox" required="true" label="始报年月:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LOCALITY" id="LOCALITY" class="easyui-textbox" required="true" label="交换管理单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DSTRVM" id="DSTRVM" class="easyui-textbox" required="true" label="至河口距离:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STLC" id="STLC" class="easyui-textbox" required="true" label="站址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ADDVCD" id="ADDVCD" class="easyui-textbox" required="true" label="行政区划码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STCD" id="STCD" class="easyui-textbox" required="true" label="测站编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LTTD" id="LTTD" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RVNM" id="RVNM" class="easyui-textbox" required="true" label="河流名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STAZT" id="STAZT" class="easyui-textbox" required="true" label="测站方位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LGTD" id="LGTD" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="COMMENTS" id="COMMENTS" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BSNM" id="BSNM" class="easyui-textbox" required="true" label="流域名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ESSYM" id="ESSYM" class="easyui-textbox" required="true" label="建站年月:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ADMAUTH" id="ADMAUTH" class="easyui-textbox" required="true" label="信息管理单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STNM" id="STNM" class="easyui-textbox" required="true" label="测站名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ATCUNIT" id="ATCUNIT" class="easyui-textbox" required="true" label="隶属行业单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DTMNM" id="DTMNM" class="easyui-textbox" required="true" label="基面名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FRGRD" id="FRGRD" class="easyui-textbox" required="true" label="报汛等级:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HNNM" id="HNNM" class="easyui-textbox" required="true" label="水系名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STBK" id="STBK" class="easyui-textbox" required="true" label="测站岸别:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="MODITIME" id="MODITIME" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveWtcdSiteInfo()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">测站编码</td>
		                <td class="con">
		                	<input id="stcd" name="STCD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">测站名称</td>
						<td class="con">
							<input id="STNM" name="STNM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">站类</td>
		                <td class="con">
		                	<input id="STTP" name="STTP" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">站址</td>
						<td class="con">
							<input id="STLC" name="STLC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">行政区划码</td>
		                <td class="con">
		                	<input id="ADDVCD" name="ADDVCD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">隶属行业单位</td>
						<td class="con">
							<input id="ATCUNIT" name="ATCUNIT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">交换管理单位</td>
		                <td class="con">
		                	<input id="locality" name="locality" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">信息管理单位</td>
						<td class="con">
							<input id="ADMAUTH" name="ADMAUTH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">建站年月</td>
		                <td class="con">
		                	<input id="ESSYM" name="ESSYM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">测站方位</td>
						<td class="con">
							<input id="STAZT" name="STAZT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">测站岸别</td>
		                <td class="con">
		                	<input id="STBK" name="STBK" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">拼音码</td>
						<td class="con">
							<input id="PHCD" name="PHCD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">启用标志</td>
		                <td class="con">
		                	<input id="USFL" name="USFL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水系名称</td>
		                <td class="con">
		                	<input id="HNNM" name="HNNM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">流域名称</td>
		                <td class="con">
		                	<input id="BSNM" name="BSNM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">河流名称</td>
		                <td class="con">
		                	<input id="RVNM" name="RVNM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">基面名称</td>
		                <td class="con">
		                	<input id="DTMNM" name="DTMNM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">报汛等级</td>
		                <td class="con">
		                	<input id="FRGRD" name="FRGRD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">基面修正值</td>
		                <td class="con">
		                	<input id="DTPR" name="DTPR" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">基面高程</td>
		                <td class="con">
		                	<input id="DTMEL" name="DTMEL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">集水面积</td>
		                <td class="con">
		                	<input id="DRNA" name="DRNA" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">始报年月</td>
		                <td class="con">
		                	<input id="BGFRYM" name="BGFRYM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">至河口距离</td>
		                <td class="con">
		                	<input id="DSTRVM" name="DSTRVM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">更新时间</td>
		                <td class="con">
		                	<input id="updatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">经度</td>
		                <td class="con">
		                	<input id="LTTD" name="LTTD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">纬度</td>
		                <td class="con">
		                	<input id="LGTD" name="LGTD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">时间</td>
		                <td class="con">
		                	<input id="MODITIME" name="MODITIME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">备注</td>
		                <td class="con">
		                	<input id="COMMENTS" name="COMMENTS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				STTP: $("#querySTTP").val().trim(),
				STLC: $("#querySTLC").val().trim(),
				ADDVCD: $("#queryADDVCD").val().trim(),
				STCD: $("#querySTCD").val().trim(),
				RVNM: $("#queryRVNM").val().trim(),
				BSNM: $("#queryBSNM").val().trim(),
				STNM: $("#querySTNM").val().trim(),
				HNNM: $("#queryHNNM").val().trim()
				/* updatetimeRjwa: $("#queryUpdatetimeRjwa").val().trim(),
				MODITIME: $("#queryMODITIME").val().trim(), */
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newWtcdSiteInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水利厅水文站点');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/wtcd/wtcdSiteInfo/saveWtcdSiteInfo';
		}

		function editWtcdSiteInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/wtcd/wtcdSiteInfo/getWtcdSiteInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水利厅水文站点');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/wtcd/wtcdSiteInfo/saveWtcdSiteInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveWtcdSiteInfo() {
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

		function deleteWtcdSiteInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/wtcd/wtcdSiteInfo/deleteWtcdSiteInfo',
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
			var rowId = row.stcd;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/wtcd/wtcdSiteInfo/getWtcdSiteInfo',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '水利厅水文站点基本信息明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/wtcd/wtcdSiteInfo/getListExport' +
					'?STTP='+$("#querySTTP").val().trim()+
					'&STLC='+$("#querySTLC").val().trim()+
					'&ADDVCD='+$("#queryADDVCD").val().trim()+
					'&STCD='+$("#querySTCD").val().trim()+
					'&RVNM='+$("#queryRVNM").val().trim()+
					'&BSNM='+$("#queryBSNM").val().trim()+
					'&STNM='+$("#querySTNM").val().trim()+
					'&HNNM='+$("#queryHNNM").val().trim());
		}
</script>
</body>
</html>
