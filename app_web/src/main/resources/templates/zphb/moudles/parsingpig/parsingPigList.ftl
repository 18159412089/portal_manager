<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>养殖业管理管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
					<div class="inline-block">
						<label  class="textbox-label textbox-label-before" title="农场">农场:</label>
						<input id="queryNc" name="nc" class="easyui-textbox" style="width: 170px;">
					</div>
					<div class="inline-block">
						<label  class="textbox-label textbox-label-before" title="养殖场名称">养殖场名称:</label>
						<input id="queryYzc" name="yzc" class="easyui-textbox" style="width: 170px;">
					</div>
					<div class="inline-block">
						<label  class="textbox-label textbox-label-before" title="统一社会信用代码">统一社会信用代码:</label>
						<input id="queryXydm" name="xydm" class="easyui-textbox" style="width: 170px;">
					</div>
					<div class="inline-block">
						<label  class="textbox-label textbox-label-before" title="企业编码">企业编码:</label>
						<input id="queryEpCode" name="epCode" class="easyui-textbox" style="width: 170px;">
					</div>

					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>

			<form id="uplodFile" method="post" enctype="multipart/form-data">
				<a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newParsingPig()" >新增</a>
				<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editParsingPig()">修改</a>
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="deleteParsingPig()">删除</a>
				<a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-save'" onclick="downloadFile()">导入模板下载</a>
				<a href="#" name="xlsxfile" id="importFile" class="easyui-filebox btn-purple" data-options="accept:'application/vnd.ms-excel'"></a>
			</form>
			<!--
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newParsingPig()">新增</a>
				<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editParsingPig()">修改</a>
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteParsingPig()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/zphb/parsingPig/parsingPigList"
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
					<th field="nc" width="10%">农场</th>
					<th field="yzc" width="10%">养殖场名称</th>
					<th field="frdb" width="10%">法人代表</th>
					<th field="xxdz" width="10%">详细地址</th>
					<th field="lxdh" width="10%">联系电话</th>
					<th field="sfz" width="10%">身份证号码</th>
					<th field="xydm" width="10%">统一社会信用代码</th>
					<th field="epCode" width="10%">企业编码</th>
					<th field="seqno" width="10%">序号</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 600px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="id" hidden="true" />
			<div style="margin-bottom:10px">
				<label class="textbox-label textbox-label-before" title="农场">农场:</label>
				<input name="nc" id="nc" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom:10px">
				<label class="textbox-label textbox-label-before" title="养殖场名称">养殖场名称:</label>
				<input name="yzc" id="yzc" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="法人代表">法人代表:</label>
				<input name="frdb" id="frdb" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="详细地址">详细地址:</label>
				<input name="xxdz" id="xxdz" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="联系电话">联系电话:</label>
				<input name="lxdh" id="lxdh" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="环评规模(头)">环评规模(头):</label>
				<input name="hpgm" id="hpgm" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="是否办理环评网上备案">是否办理环评网上备案:</label>
				<input name="wsba" id="wsba" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="粪污主要设施">粪污主要设施:</label>
				<input name="zyss" id="zyss" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="畜禽标识代码">畜禽标识代码:</label>
				<input name="bsdm" id="bsdm" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="畜禽养殖代码">畜禽养殖代码:</label>
				<input name="yzdm" id="yzdm" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="身份证号码">身份证号码:</label>
				<input name="sfz" id="sfz" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="统一社会信用代码">统一社会信用代码:</label>
				<input name="xydm" id="xydm" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="动物防疫条件合格证号">动物防疫条件合格证号:</label>
				<input name="hgzh" id="hgzh" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="种畜禽生产经营许可证号">种畜禽生产经营许可证号:</label>
				<input name="xkzh" id="xkzh" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="经度">经度:</label>
				<input name="jd" id="jd" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="纬度">纬度:</label>
				<input name="wd" id="wd" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="企业编码">企业编码:</label>
				<input name="epCode" id="epCode" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="监控通道ID">监控通道ID:</label>
				<input name="channelIds" id="channelIds" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
			<div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="序号">序号:</label>
				<input name="seqno" id="seqno" class="easyui-textbox" required="true" style="width:200px"/>
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveParsingPig()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
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
				nc: $("#queryNc").val().trim(),
				yzc: $("#queryYzc").val().trim(),
				xydm: $("#queryXydm").val().trim(),
				epCode: $("#queryEpCode").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newParsingPig() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增养殖业管理');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/zphb/parsingPig/saveParsingPig';
			console.log(url);
		}

		function editParsingPig() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/zphb/parsingPig/getParsingPig',
					data: {'id': row.id},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改养殖业管理');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/zphb/parsingPig/saveParsingPig';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveParsingPig() {
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

		function deleteParsingPig() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/zphb/parsingPig/deleteParsingPig',
							data: {'id': row.id},
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


		/**
		 * 导入
		 **/
		$('#importFile').filebox({
			buttonText: '批量导入',
			buttonAlign: 'center',
			buttonIcon: 'iconcustom icon-xiazai1',
			clear:true ,
			onChange: function (newVal,oldVal) {
				var suffix = newVal.substring(newVal.lastIndexOf('.') + 1, newVal.length);
				if (suffix != 'xls' && suffix !='xlsx') {
					Ams.error('只能导入后缀为xls或xlsx的文件');
					return;
				}
				$.messager.confirm("提示信息", "确认导入文件：<br/>"+newVal+"？", function (r) {
					if (r) {
						$.messager.progress({title: '提示', msg: '数据导入中......', text: ''});
						$('#uplodFile').form('submit', {
							url: Ams.ctxPath + "/zphb/parsingPig/importFile",
							onSubmit: function () {
								var isValid = $(this).form('validate');
								if (!isValid){
									$.messager.progress('close');	// hide progress bar while the form is invalid
								}
								return isValid;
							},
							success: function (result) {
								var result = JSON.parse(result);
								if (result.type == 'E') {
									$.messager.confirm("提示信息",result.message);
								} else {
									Ams.success(result.message);
								}
								$("#filebox_file_id_2").val('');
								$.messager.progress('close');
								doSearch();
							}
						});
					} else {
						$("#filebox_file_id_2").val('');
					}
				});
			}
		})
		//导入模板下载
		function downloadFile(){
			var $eleForm = $("<form method='get'></form>");
			$eleForm.attr("action","${request.contextPath}/static/js/moudles/zp/templates/养殖场数据录入模板.xls");
			$(document.body).append($eleForm);
			//提交表单，实现下载
			$eleForm.submit();
		}
</script>
</body>
</html>
