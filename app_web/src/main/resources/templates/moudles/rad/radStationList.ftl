<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>辐射基站管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="基站编号">基站编号:</label>
                       <input id="queryJZBH" name="JZBH" class="easyui-textbox" style="width: 150px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="基站名称">基站名称:</label>
                        <input id="queryJZNAME" name="JZNAME" class="easyui-textbox" style="width: 150px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="市">市:</label>
                       <!-- <input id="queryUpdatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" label="更新时间:" style="width: 150px;"> -->
                       <input id="queryCODEREGIONSHI" name="CODEREGIONSHI" class="easyui-textbox" style="width: 150px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="区县">区县:</label>
                        <input id="queryCODEREGIONXIAN" name="CODEREGIONXIAN" class="easyui-textbox" style="width: 150px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="地址">地址:</label>
                       <input id="queryENTERADDRESS" name="ENTERADDRESS" class="easyui-textbox" style="width: 150px;">
				   </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="区域类型">区域类型:</label>
                      <input id="queryQYLX" name="QYLX" class="easyui-textbox" style="width: 150px;">
				  </div>
					<!-- <input id="queryLXSJ" name="LXSJ" class="easyui-textbox" label="立项时间:" style="width: 150px;">
					<input id="queryTXJHFS" name="TXJHFS" class="easyui-textbox" label="天线极化方式:" style="width: 150px;"> -->
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRadStation()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRadStation()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRadStation()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rad/radStation/radStationList"
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
					<th formatter="Ams.tooltipFormat" field="jzbh" width="10%">编号</th>
					<th formatter="Ams.tooltipFormat" field="jzname" width="10%">基站名称</th>
					<th formatter="Ams.tooltipFormat" field="coderegionshi" width="10%">市</th>
					<th formatter="Ams.tooltipFormat" field="coderegionxian" width="10%">区县</th>
					<th formatter="Ams.tooltipFormat" field="enteraddress" width="10%">地址</th>
					<th formatter="Ams.tooltipFormat" field="qylx" width="10%">区域类型</th>
					<th formatter="Ams.tooltipFormat" field="fsjxh" width="10%">发射机型号</th>
					<th formatter="Ams.tooltipFormat" field="txxqj" width="10%">天线下倾角</th>
					<th formatter="Ams.tooltipFormat" field="ysgzlx" width="10%">验收共站类型</th>
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
				<input name="FSJXH" id="FSJXH" class="easyui-textbox" required="true" label="发射机型号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXXQJ" id="TXXQJ" class="easyui-textbox" required="true" label="天线下倾角:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SJFCBH" id="SJFCBH" class="easyui-textbox" required="true" label="数据分册编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JZNAME" id="JZNAME" class="easyui-textbox" required="true" label="基站名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="MGSQZPS" id="MGSQZPS" class="easyui-textbox" required="true" label="每个扇区的载频数:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PKID" id="PKID" class="easyui-textbox" required="true" label="ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXJSLX" id="TXJSLX" class="easyui-textbox" required="true" label="验收天线架设类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BCGL" id="BCGL" class="easyui-textbox" required="true" label="标称功率(W):" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LATITUDE" id="LATITUDE" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FSJCS" id="FSJCS" class="easyui-textbox" required="true" label="发射机厂商:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CODEREGIONSHI" id="CODEREGIONSHI" class="easyui-textbox" required="true" label="市:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CODEREGIONXIAN" id="CODEREGIONXIAN" class="easyui-textbox" required="true" label="区县:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YSGZLX" id="YSGZLX" class="easyui-textbox" required="true" label="验收共站类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LXSJ" id="LXSJ" class="easyui-textbox" required="true" label="立项时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERADDRESS" id="ENTERADDRESS" class="easyui-textbox" required="true" label="地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXFXJ" id="TXFXJ" class="easyui-textbox" required="true" label="天地方向角:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LONGITUDE" id="LONGITUDE" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXSM" id="TXSM" class="easyui-textbox" required="true" label="天线数目:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXLDGD" id="TXLDGD" class="easyui-textbox" required="true" label="天线离地高度（M）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QYLX" id="QYLX" class="easyui-textbox" required="true" label="区域类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXJHFS" id="TXJHFS" class="easyui-textbox" required="true" label="天线极化方式:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TXZY" id="TXZY" class="easyui-textbox" required="true" label="天线增益(dBi):" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JZBH" id="JZBH" class="easyui-textbox" required="true" label="编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRadStation()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">编号</td>
		                <td class="con">
		                	<input id="JZBH" name="JZBH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">基站名称</td>
						<td class="con">
							<input id="JZNAME" name="JZNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">市</td>
		                <td class="con">
		                	<input id="CODEREGIONSHI" name="CODEREGIONSHI" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">区县</td>
						<td class="con">
							<input id="CODEREGIONXIAN" name="CODEREGIONXIAN" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">地址</td>
		                <td class="con">
		                	<input id="ENTERADDRESS" name="ENTERADDRESS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">发射机型号</td>
						<td class="con">
							<input id="FSJXH" name="FSJXH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">经度</td>
		                <td class="con">
		                	<input id="LONGITUDE" name="LONGITUDE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">纬度</td>
						<td class="con">
							<input id="LATITUDE" name="LATITUDE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">天线下倾角</td>
		                <td class="con">
		                	<input id="TXXQJ" name="TXXQJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">数据分册编号</td>
						<td class="con">
							<input id="SJFCBH" name="SJFCBH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">每个扇区的载频数</td>
		                <td class="con">
		                	<input id="MGSQZPS" name="MGSQZPS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">验收天线架设类型</td>
						<td class="con">
							<input id="TXJSLX" name="TXJSLX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">标称功率(W)</td>
		                <td class="con">
		                	<input id="BCGL" name="BCGL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">发射机厂商</td>
		                <td class="con">
		                	<input id="FSJCS" name="FSJCS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">验收共站类型</td>
		                <td class="con">
		                	<input id="YSGZLX" name="YSGZLX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">立项时间</td>
		                <td class="con">
		                	<input id="LXSJ" name="LXSJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">天地方向角</td>
		                <td class="con">
		                	<input id="TXFXJ" name="TXFXJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">天线数目</td>
		                <td class="con">
		                	<input id="TXSM" name="TXSM" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">天线离地高度（M）</td>
		                <td class="con">
		                	<input id="TXLDGD" name="TXLDGD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">区域类型</td>
		                <td class="con">
		                	<input id="QYLX" name="QYLX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">天线极化方式</td>
		                <td class="con">
		                	<input id="TXJHFS" name="TXJHFS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">天线增益(dBi)</td>
		                <td class="con">
		                	<input id="TXZY" name="TXZY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				JZBH: $("#queryJZBH").val().trim(),
				JZNAME: $("#queryJZNAME").val().trim(),
				/* updatetimeRjwa: $("#queryUpdatetimeRjwa").val(), */
				CODEREGIONSHI: $("#queryCODEREGIONSHI").val().trim(),
				CODEREGIONXIAN: $("#queryCODEREGIONXIAN").val().trim(),
				ENTERADDRESS: $("#queryENTERADDRESS").val().trim(),
				QYLX: $("#queryQYLX").val().trim(),
				/* LXSJ: $("#queryLXSJ").val(),
				TXJSLX: $("#queryTXJSLX").val() */
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRadStation() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增辐射基站');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rad/radStation/saveRadStation';
		}

		function editRadStation() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rad/radStation/getRadStation',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改辐射基站');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rad/radStation/saveRadStation';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRadStation() {
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

		function deleteRadStation() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rad/radStation/deleteRadStation',
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
				url: Ams.ctxPath + '/rad/radStation/getRadStation',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '辐射基站明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rad/radStation/getListExport' +
					'?JZBH='+$("#queryJZBH").val().trim()+
					'&JZNAME='+$("#queryJZNAME").val().trim()+
					'&CODEREGIONSHI='+$("#queryCODEREGIONSHI").val().trim()+
					'&CODEREGIONXIAN='+$("#queryCODEREGIONXIAN").val().trim()+
					'&ENTERADDRESS='+$("#queryENTERADDRESS").val().trim()+
					'&QYLX='+$("#queryQYLX").val().trim());
		}
</script>
</body>
</html>
