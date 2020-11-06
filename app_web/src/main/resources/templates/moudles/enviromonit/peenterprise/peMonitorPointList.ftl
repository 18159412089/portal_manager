<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>monitorPoint管理</title> 
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
							<label class="textbox-label textbox-label-before" title="排放口类型">排放口类型:</label>
									<input id="queryOutfallType" name="queryOutfallType" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="排污口编号">排污口编号:</label>
									<input id="queryCode" name="queryCode" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="排污口名称">排污口名称:</label>
									<input id="queryName" name="queryName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="企业ID">企业ID:</label>
									<input id="queryPeId" name="queryPeId" class="easyui-textbox" style="width: 200px;" data-options="validType:'number'">
							</div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="MN号">MN号:</label>
									<input id="queryCsn" name="queryCsn" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否上传日数据">是否上传日数据:</label>
									<input id="queryIsPutDaily" name="queryIsPutDaily" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否上传小时数据">是否上传小时数据:</label>
									<input id="queryIsPutHour" name="queryIsPutHour" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否上传分钟数据">是否上传分钟数据:</label>
									<input id="queryIsPutMin" name="queryIsPutMin" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否发住E通平台">是否发住E通平台:</label>
									<input id="queryEtongTran" name="queryEtongTran" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="流域">流域:</label>
									<input id="queryRiver" name="queryRiver" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否省关注">是否省关注:</label>
									<input id="queryIsProvinceConcerned" name="queryIsProvinceConcerned" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="启用状态">启用状态:</label>
									<input id="queryEnableStatus" name="queryEnableStatus" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否市关注">是否市关注:</label>
									<input id="queryIsCityConcerned" name="queryIsCityConcerned" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否区关注">是否区关注:</label>
									<input id="queryIsAreaConcerned" name="queryIsAreaConcerned" class="easyui-textbox" style="width: 200px;">
							</div>
						
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<@sec.authorize access= "hasAuthority('monitorPoint:pemonitorpoint:add')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newPeMonitorPoint()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('monitorPoint:pemonitorpoint:edit')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editPeMonitorPoint()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('monitorPoint:pemonitorpoint:delete')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePeMonitorPoint()">删除</a>
			</@sec.authorize>
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/monitorPoint/pemonitorpoint/peMonitorPointList"
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
							<th field="outfallType" width="10">排放口类型</th>
							<th field="code" width="10">排污口编号</th>
							<th field="name" width="10">排污口名称</th>
							<th field="pos" width="10">排污口位置</th>
							<th field="gafTypeCode" width="10">功能区类别</th>
							<th field="fuelCode" width="10">燃料分类</th>
							<th field="burnCode" width="10">燃料方式</th>
							<th field="peId" width="10">企业ID</th>
							<th field="csn" width="10">MN号</th>
							<th field="river" width="10">流域</th>
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
						<label class="textbox-label textbox-label-before" title="主键">主键:</label>
								<input id="outputId" name="outputId" class="easyui-textbox" data-options="validType:'maxLength[22]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排放口类型">排放口类型:</label>
								<input id="outfallType" name="outfallType" class="easyui-textbox" data-options="validType:'maxLength[20]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排污口编号">排污口编号:</label>
								<input id="code" name="code" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排污口名称">排污口名称:</label>
								<input id="name" name="name" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排污口位置">排污口位置:</label>
								<input id="pos" name="pos" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="功能区类别">功能区类别:</label>
								<input id="gafTypeCode" name="gafTypeCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排放规律">排放规律:</label>
								<input id="gorCode" name="gorCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="燃料分类">燃料分类:</label>
								<input id="fuelCode" name="fuelCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="燃料方式">燃料方式:</label>
								<input id="burnCode" name="burnCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="标志牌安装形式">标志牌安装形式:</label>
								<input id="symbolStyle" name="symbolStyle" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="企业ID">企业ID:</label>
								<input id="peId" name="peId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="显示顺序">显示顺序:</label>
								<input id="seqNo" name="seqNo" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排污许可证编号">排污许可证编号:</label>
								<input id="licenceCode" name="licenceCode" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="允许污染物的排放量">允许污染物的排放量:</label>
								<input id="allowPluLet" name="allowPluLet" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="状态">状态:</label>
								<input id="status" name="status" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="监控显示">监控显示:</label>
								<input id="hiddenOutput" name="hiddenOutput" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否导出">是否导出:</label>
								<input id="isexport" name="isexport" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="股票显示">股票显示:</label>
								<input id="stockShow" name="stockShow" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="经度">经度:</label>
								<input id="longitude" name="longitude" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="纬度">纬度:</label>
								<input id="latitude" name="latitude" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="标准空气过剩系数">标准空气过剩系数:</label>
								<input id="airCoefficient" name="airCoefficient" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="单台出力">单台出力:</label>
								<input id="singleOutput" name="singleOutput" class="easyui-textbox" data-options="validType:'maxLength[500]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="锅炉类型">锅炉类型:</label>
								<input id="boilerType" name="boilerType" class="easyui-textbox" data-options="validType:'maxLength[500]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="MN号">MN号:</label>
								<input id="csn" name="csn" class="easyui-textbox" data-options="validType:'maxLength[25]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="访问密码">访问密码:</label>
								<input id="pwd" name="pwd" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="IP地址">IP地址:</label>
								<input id="ipAddress" name="ipAddress" class="easyui-textbox" data-options="validType:'maxLength[20]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="端口号">端口号:</label>
								<input id="port" name="port" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="上传周期">上传周期:</label>
								<input id="cyc" name="cyc" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="生产厂家">生产厂家:</label>
								<input id="product" name="product" class="easyui-textbox" data-options="validType:'maxLength[120]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="联系人">联系人:</label>
								<input id="contact" name="contact" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="联系方式">联系方式:</label>
								<input id="contactNum" name="contactNum" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否上传日数据">是否上传日数据:</label>
								<input id="isPutDaily" name="isPutDaily" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否上传小时数据">是否上传小时数据:</label>
								<input id="isPutHour" name="isPutHour" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否上传分钟数据">是否上传分钟数据:</label>
								<input id="isPutMin" name="isPutMin" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="上传">上传:</label>
								<input id="upTran" name="upTran" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="下发">下发:</label>
								<input id="downTran" name="downTran" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否发住E通平台">是否发住E通平台:</label>
								<input id="etongTran" name="etongTran" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流量上传单位">流量上传单位:</label>
								<input id="unitTranslate" name="unitTranslate" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="更新时间">更新时间:</label>
							<input id="updateTime" name="updateTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="更新用户id">更新用户id:</label>
								<input id="updateUserId" name="updateUserId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="插入时间">插入时间:</label>
							<input id="insertTime" name="insertTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="插入用户id">插入用户id:</label>
								<input id="insertUserId" name="insertUserId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流域">流域:</label>
								<input id="river" name="river" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流向方向">流向方向:</label>
								<input id="direction" name="direction" class="easyui-textbox" data-options="validType:'maxLength[16]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="运营商">运营商:</label>
								<input id="operator" name="operator" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否省关注">是否省关注:</label>
								<input id="isProvinceConcerned" name="isProvinceConcerned" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="报备停产">报备停产:</label>
								<input id="reportStop" name="reportStop" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="启用状态">启用状态:</label>
								<input id="enableStatus" name="enableStatus" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="安装位置类型">安装位置类型:</label>
								<input id="siteType" name="siteType" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="实际日处理量">实际日处理量:</label>
								<input id="actualDailyCapacity" name="actualDailyCapacity" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="第一次上传数据时间">第一次上传数据时间:</label>
							<input id="firstUploadData" name="firstUploadData" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否市关注">是否市关注:</label>
								<input id="isCityConcerned" name="isCityConcerned" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否区关注">是否区关注:</label>
								<input id="isAreaConcerned" name="isAreaConcerned" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePeMonitorPoint()" style="width: 90px">保存</a>
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
				outfallType: $("#queryOutfallType").val().trim(),
				code: $("#queryCode").val().trim(),
				name: $("#queryName").val().trim(),
				peId: $("#queryPeId").val().trim(),
				csn: $("#queryCsn").val().trim(),
				isPutDaily: $("#queryIsPutDaily").val().trim(),
				isPutHour: $("#queryIsPutHour").val().trim(),
				isPutMin: $("#queryIsPutMin").val().trim(),
				etongTran: $("#queryEtongTran").val().trim(),
				river: $("#queryRiver").val().trim(),
				isProvinceConcerned: $("#queryIsProvinceConcerned").val().trim(),
				enableStatus: $("#queryEnableStatus").val().trim(),
				isCityConcerned: $("#queryIsCityConcerned").val().trim(),
				isAreaConcerned: $("#queryIsAreaConcerned").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newPeMonitorPoint() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增monitorPoint');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/monitorPoint/pemonitorpoint/savePeMonitorPoint';
		}

		function editPeMonitorPoint() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/monitorPoint/pemonitorpoint/getPeMonitorPoint',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改monitorPoint');
						$('#fm').form('load', result.peMonitorPoint);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/monitorPoint/pemonitorpoint/savePeMonitorPoint';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePeMonitorPoint() {
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

		function deletePeMonitorPoint() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/monitorPoint/pemonitorpoint/deletePeMonitorPoint',
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
