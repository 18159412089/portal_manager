<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>污染源自动监控企业信息表管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="污染源名称">污染源名称:</label>
									<input id="queryPeName" name="queryPeName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="行政区划编码">行政区划编码:</label>
									<select id="queryOrgCode" name="queryOrgCode" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="单位类别编码">单位类别编码:</label>
									<select id="queryUnitTypeCode" name="queryUnitTypeCode" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="企业规模编码">企业规模编码:</label>
									<select id="querySizeCode" name="querySizeCode" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="所有制类型">所有制类型:</label>
									<select id="queryHavingName" name="queryHavingName" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="行业类别">行业类别:</label>
									<select id="queryTradeCode" name="queryTradeCode" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a> 
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<@sec.authorize access= "hasAuthority('enterprise:peenterprisedata:add')" > 
				<a href="#" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newPeEnterpriseData()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('enterprise:peenterprisedata:edit')" > 
				<a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editPeEnterpriseData()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('enterprise:peenterprisedata:delete')" > 
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePeEnterpriseData()">删除</a>
			</@sec.authorize>
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/enterprise/peenterprisedata/peEnterpriseDataList"
				data-options="
					rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:true,
		            fitColumns:true,
		            fit:true,
		            pagination:true,
		            pageSize:10,
		            pageList:[10,30,50]">
			<thead>
				<tr>
							<th field="peCode" width="10">污染源编号</th>
							<th field="peName" width="10">污染源名称</th>
							<th field="orgCode" width="10">行政区划编码</th>
							<th field="unitTypeCode" width="10">单位类别编码</th>
							<th field="sizeCode" width="10">企业规模编码</th>
							<th field="havingName" width="10">所有制类型</th>
							<th field="tradeCode" width="10">行业类别</th>
							<th field="riverCode" width="10">流域编码</th>
							<th field="address" width="10">地址</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="污染源主键">污染源主键:</label>
								<input id="peId" name="peId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="污染源编号">污染源编号:</label>
								<input id="peCode" name="peCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="污染源名称">污染源名称:</label>
								<input id="peName" name="peName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="行政区划编码">行政区划编码:</label>
								<select id="orgCode" name="orgCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="单位类别编码">单位类别编码:</label>
								<select id="unitTypeCode" name="unitTypeCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="企业规模编码">企业规模编码:</label>
								<select id="sizeCode" name="sizeCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="所有制类型">所有制类型:</label>
								<select id="havingName" name="havingName" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="行业类别">行业类别:</label>
								<select id="tradeCode" name="tradeCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流域编码">流域编码:</label>
								<select id="riverCode" name="riverCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="地址">地址:</label>
								<input id="address" name="address" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="法人代码">法人代码:</label>
								<input id="lawCode" name="lawCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="法人代表">法人代表:</label>
								<input id="lawAgency" name="lawAgency" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="经度">经度:</label>
								<input id="longValue" name="longValue" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="纬度">纬度:</label>
								<input id="latValue" name="latValue" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="投产日期">投产日期:</label>
							<input id="startDate" name="startDate" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="邮箱">邮箱:</label>
								<input id="email" name="email" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="通讯地址">通讯地址:</label>
								<input id="mailAddress" name="mailAddress" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="邮政编码">邮政编码:</label>
								<input id="zipCode" name="zipCode" class="easyui-textbox" data-options="validType:'maxLength[20]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="负责人">负责人:</label>
								<input id="envPrincipal" name="envPrincipal" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="电话">电话:</label>
								<input id="tel" name="tel" class="easyui-textbox" data-options="validType:'maxLength[30]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="传真">传真:</label>
								<input id="fax" name="fax" class="easyui-textbox" data-options="validType:'maxLength[30]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="移动电话">移动电话:</label>
								<input id="mobile" name="mobile" class="easyui-textbox" data-options="validType:'maxLength[20]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="产生污染物介绍">产生污染物介绍:</label>
							<input id="curStatus" name="curStatus" class="easyui-textbox" data-options="multiline:true" style="width: 200px;height: 120px">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="生产设施情况介绍">生产设施情况介绍:</label>
							<input id="production" name="production" class="easyui-textbox" data-options="multiline:true" style="width: 200px;height: 120px">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="特殊类型">特殊类型:</label>
								<select id="peType" name="peType" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="停用启用状态">停用启用状态:</label>
							<input id="status" name="status" class="easyui-textbox" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="通讯联系">通讯联系:</label>
							<input id="contact" name="contact" class="easyui-textbox" data-options="multiline:true" style="width: 200px;height: 120px">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="污染治理设施介绍">污染治理设施介绍:</label>
							<input id="pollutionControl" name="pollutionControl" class="easyui-textbox" data-options="multiline:true" style="width: 200px;height: 120px">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="其他">其他:</label>
							<input id="others" name="others" class="easyui-textbox" data-options="multiline:true" style="width: 200px;height: 120px">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="更新日期">更新日期:</label>
							<input id="updateTime" name="updateTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="新增日期">新增日期:</label>
							<input id="insertTime" name="insertTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="废气控制级别">废气控制级别:</label>
								<select id="gasType" name="gasType" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="废水控制级别">废水控制级别:</label>
								<select id="waterType" name="waterType" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="所属区域">所属区域:</label>
								<select id="rgnCode" name="rgnCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePeEnterpriseData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};
		
	    $(function () {
	        var dgPager = $('#dg').datagrid().datagrid('getPager');
	        dgPager.pagination({
	        	layout:[ 'list','sep', 'first', 'prev', 'links', 'next', 'last', 'manual'],
	        	links:8
	        });
	        
	    });
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		
		function doSearch() {
			if(!$('#searchForm').form('validate')){
                return;
            }
			$('#dg').datagrid('load', {
				peName: $("#queryPeName").val().trim(),
				orgCode: $("#queryOrgCode").val(),
				unitTypeCode: $("#queryUnitTypeCode").val(),
				sizeCode: $("#querySizeCode").val(),
				havingName: $("#queryHavingName").val(),
				tradeCode: $("#queryTradeCode").val(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newPeEnterpriseData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增污染源自动监控企业信息表');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/enterprise/peenterprisedata/savePeEnterpriseData';
		}

		function editPeEnterpriseData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/enterprise/peenterprisedata/getPeEnterpriseData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改污染源自动监控企业信息表');
						$('#fm').form('load', result.peEnterpriseData);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/enterprise/peenterprisedata/savePeEnterpriseData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePeEnterpriseData() {
            if(!$('#fm').form('validate')){
                return;
            }
            $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
            $.ajax({
                type: "POST",
                dataType: "json",
                url: url,
                data: $('#fm').serialize(),
                success: function (result) {
                	$.messager.progress('close');
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#dlg').dialog('close');
                        $('#dg').datagrid('load');
                    }
                }
            });
        }

		function deletePeEnterpriseData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/enterprise/peenterprisedata/deletePeEnterpriseData',
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
</script>
</body>
</html>
