<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>省海洋与渔业厅数据管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="站点编号">站点编号:</label>
                        <input id="queryZDBH" name="ZDBH" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
                       <input id="queryZDMC" name="ZDMC" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newSeaSiteData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editSeaSiteData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteSeaSiteData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/sea/seaSiteData/seaSiteDataList"
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
					<th formatter="Ams.tooltipFormat" field="zdbh" width="10%">站点编号</th>
					<th formatter="Ams.tooltipFormat" field="zdmc" width="10%">站点名称</th>
					<th formatter="Ams.tooltipFormat" field="sw" width="10%">水温</th>
					<th formatter="Ams.tooltipFormat" field="yls" width="10%">叶绿素</th>
					<th formatter="Ams.tooltipFormat" field="ljy" width="10%">溶解氧</th>
					<th formatter="Ams.tooltipFormat" field="ljybhd" width="10%">溶解氧饱和度mg/l</th>
					<th formatter="Ams.tooltipFormat" field="ddl" width="10%">导电率mmho/cm</th>
					<th field="jcsj" width="11%">采样时间</th>
					<th field="rksj" width="11%" formatter="Ams.timeDateFormat">入库时间</th>
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
				<input name="SD" id="SD" class="easyui-textbox" required="true" label="湿度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YLS" id="YLS" class="easyui-textbox" required="true" label="叶绿素:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PSYND" id="PSYND" class="easyui-textbox" required="true" label="磷酸盐浓度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="rhEnc" id="rhEnc" class="easyui-textbox" required="true" label="雨量_ENC:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wdEdc" id="wdEdc" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LJY" id="LJY" class="easyui-textbox" required="true" label="溶解氧:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YD" id="YD" class="easyui-textbox" required="true" label="盐度 千分:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FX" id="FX" class="easyui-textbox" required="true" label="风向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DDL" id="DDL" class="easyui-textbox" required="true" label="导电率mmho/cm:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZD" id="ZD" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZDBH" id="ZDBH" class="easyui-textbox" required="true" label="站点编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XSYND" id="XSYND" class="easyui-textbox" required="true" label="硝酸盐浓度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QW" id="QW" class="easyui-textbox" required="true" label="气温:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="FS" id="FS" class="easyui-textbox" required="true" label="风速:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZDMC" id="ZDMC" class="easyui-textbox" required="true" label="站点名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LJYBHD" id="LJYBHD" class="easyui-textbox" required="true" label="溶解氧饱和度mg/l:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PH" id="PH" class="easyui-textbox" required="true" label="PH:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YXSYND" id="YXSYND" class="easyui-textbox" required="true" label="亚硝酸盐浓度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SW" id="SW" class="easyui-textbox" required="true" label="水温:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BCSD" id="BCSD" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JCSJ" id="JCSJ" class="easyui-textbox" required="true" label="采样时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QY" id="QY" class="easyui-textbox" required="true" label="气压:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BCYD" id="BCYD" class="easyui-textbox" required="true" label="表层盐度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjw" id="updatetimeRjw" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RKSJ" id="RKSJ" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveSeaSiteData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">站点编号</td>
		                <td class="con">
		                	<input id="ZDBH" name="ZDBH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">站点名称</td>
						<td class="con">
							<input id="ZDMC" name="ZDMC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">湿度</td>
		                <td class="con">
		                	<input id="SD" name="SD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">温度</td>
						<td class="con">
							<input id="WDEDC" name="WDEDC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">气温</td>
		                <td class="con">
		                	<input id="QW" name="QW" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水温</td>
		                <td class="con">
		                	<input id="SW" name="SW" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">磷酸盐浓度</td>
		                <td class="con">
		                	<input id="PSYND" name="PSYND" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">叶绿素</td>
						<td class="con">
							<input id="YLS" name="YLS" yls="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">雨量</td>
		                <td class="con">
		                	<input id="RHENC" name="RHENC" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">溶解氧</td>
						<td class="con">
							<input id="LJY" name="LJY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
						<td class="title tr">风向</td>
						<td class="con">
							<input id="FX" name="FX" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		                <td class="title tr">风速</td>
		                <td class="con">
		                	<input id="FS" name="FS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">导电率mmho/cm</td>
		                <td class="con">
		                	<input id="DDL" name="DDL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">硝酸盐浓度</td>
						<td class="con">
							<input id="XSYND" name="XSYND" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">盐度 千分</td>
		                <td class="con">
		                	<input id="YD" name="YD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">溶解氧饱和度mg/l</td>
		                <td class="con">
		                	<input id="LJYBHD" name="LJYBHD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">PH</td>
		                <td class="con">
		                	<input id="PH" name="PH" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">亚硝酸盐浓度</td>
		                <td class="con">
		                	<input id="YXSYND" name="YXSYND" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">表层水温</td>
		                <td class="con">
		                	<input id="BCSD" name="BCSD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">采样时间</td>
		                <td class="con">
		                	<input id="JCSJ" name="JCSJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">气压</td>
		                <td class="con">
		                	<input id="QY" name="QY" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">表层盐度</td>
		                <td class="con">
		                	<input id="BCYD" name="BCYD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">入库时间</td>
		                <td class="con">
		                	<input id="RKSJ" name="RKSJ" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">更新时间</td>
		                <td class="con">
		                	<input id="updatetimeRjw" name="updatetimeRjw" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
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
				ZDBH: $("#queryZDBH").val().trim(),
				ZDMC: $("#queryZDMC").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newSeaSiteData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增省海洋与渔业厅数据');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/sea/seaSiteData/saveSeaSiteData';
		}

		function editSeaSiteData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/sea/seaSiteData/getSeaSiteData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改省海洋与渔业厅数据');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/sea/seaSiteData/saveSeaSiteData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveSeaSiteData() {
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

		function deleteSeaSiteData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/sea/seaSiteData/deleteSeaSiteData',
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
			var rowId = row.zdbh+"_"+row.jcsj;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/sea/seaSiteData/getSeaSiteData',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '省海洋与渔业厅数据明细');
					result.RKSJ=Ams.dateFormat(result.RKSJ);
					result.updatetimeRjw=Ams.dateFormat(result.updatetimeRjw);
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/sea/seaSiteData/getListExport' +
					'?ZDBH='+$("#queryZDBH").val().trim()+
					'&ZDMC='+$("#queryZDMC").val().trim());
		}
</script>
</body>
</html>
