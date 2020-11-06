<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>小河流域数据更新操作人员</title> <#include "/header.ftl"/>
</head>
<body>
	<div class="easyui-layout" fit=true id="printid">
		<#include "/common/loadingDiv.ftl"/>
		<@sec.authorize access="hasRole('ROLE_CITY')">
         <input id="city_id" value="1" type="hidden"> 
		</@sec.authorize>
		<@sec.authorize access="hasRole('ROLE_TOWN')">
         <input id="city_id" value="0" type="hidden"> 
		</@sec.authorize>
		<div id="toolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newMenu()">小河流域分配</a>
		</div>
		<div class="easyui-layout" fit=true>
			<table id="dg" class="easyui-datagrid"
				style="width: 100%; height: auto;" toolbar="#toolbar"
				data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100]">
				<thead>
					<tr>
						<th field="name" width="55%">名称</th>
						<th field="opera" width="120px"
							data-options="formatter : editRiverMonitor">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 小河流域对应操作人员列表 -->
		<div id="menuDlg" class="easyui-dialog"
			style="width: 50%; height: 100%;"
			data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
			<div style="width: 50%; height: 100%;" class="fl"
				data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
				<table id="tg1" class="easyui-datagrid fl" style="width: 30%; padding: 3px"	url="${request.contextPath}/enviromonit/waterData/getUserList"
					idField="id" treeField="name" data-options="singleSelect:true"
					fit=true>
					<thead id="">
						<tr>
							<th field="name" width="98%">用户名</th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- 小河流域列表 -->
			<div style="width: 49%; height: 100%;" class="fr"
				data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
				<table id="dg1" fit=true>
				</table>
				<br/>
				<table id="unkownRiver" fit=true ">
				    <tr><th colspan="2" width="98%" ">未知所属县城的流域</th></tr>
				</table>
			</div>
		</div>
	</div>
	<div id="menuDlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveSelectRiverToUser()"
			style="width: 90px">保存</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#menuDlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script>
		$.parser.onComplete = function() {
			$("#loadingDiv").fadeOut("normal", function() {
				$(this).remove();
			});
		};

		function iconFormat(value, row, index) {
			return typeof row.icon !== "undefined" ? '<label class="icon ' + row.icon + '" >&nbsp;&nbsp;&nbsp;&nbsp;</label>'
					: '<label class="icon" ></label>';
		}
		 $('#tg1').datagrid(
				    {
				    	onClickRow : function(index,row){
				    		TownList(row.id);
				    		RiverUnknownTown();
					}
				});  
		function newMenu() {
		  $('#tg1').datagrid("selectRow", 0);
		  var row = $('#tg1').datagrid('getSelected');
	       TownList(row.id);
	       RiverUnknownTown();
		   $('#menuDlg').dialog('open').dialog('center').dialog('setTitle','选择用户管理流域');
		}
		$(function() {
			var checkedIds;
			doSearch();
		})
		
		
		
		function doSearch() {
			$('#dg').datagrid(
							{
								url : "${request.contextPath}/enviromonit/waterData/getUserPage",
							});
		}

		function TownList(uid) {//河流监测点 
			$.ajax({
					type : 'POST',
					url : "/enviromonit/waterData/listRiverMonitor",
					data : {"uid":uid},
					success : function(result) {
						checkedIds=new Array();
						var newTable = "";
						var check='';
						for (var i = 0; i < result.length; i++) {
							if (i % 2 == 0) {
								newTable += "<tr>"
							}
							if(result[i].check==1){
								checkedIds.push(result[i].uuid)
								check="checked=checked";
							}else{
								check='';
							}
							newTable += "<td style='width:30%'><input type='checkbox' "+check+" value="+result[i].uuid+">"
									+ result[i].monitorName + "</td>";
							if ((i % 2 == 1 || i == result.length - 1)
									&& i != 1) {
								newTable += "</tr>"
							}
						}
						$("#dg1").empty().append(newTable);
						},
						dataType : 'json'
					});
		}
		function  RiverUnknownTown() {//未知所属县的流域 
			$.ajax({
					type : 'POST',
					url : "/enviromonit/waterData/listRiverUnkownTown",
					success : function(result) {
						
						if(result==null||result.length==0||result==undefined){
							$("#unkownRiver").empty("")
						}
						var newTable = "";
						for (var i = 0; i < result.length; i++) {
							if (i % 2 == 0) {
								newTable += "<tr>"
							}
							newTable += "<td style='width:30%'><input type='checkbox' value="+result[i].uuid+">"
									+ result[i].monitorName + "</td>";
							if ((i % 2 == 1 || i == result.length - 1)
									&& i != 1) {
								newTable += "</tr>"
							}
						}
						$("#unkownRiver tr:not(:first-child)").empty("");
						$("#unkownRiver").append(newTable);
						},
						dataType : 'json'
					});
		}
		
		//保存选择的流域到用户
		function saveSelectRiverToUser() {
			var node = $('#tg1').treegrid('getSelected');
			var array = getCheckBoxVal();
			if (node == null) {
				$.messager.alert('提示', '请选择用户！');
				return;
			}
			$.ajax({
				type : 'POST',
				url : "${request.contextPath}/enviromonit/waterData/updateWtBasinMonitor",
				data : {
					"uid" : node.id,
					"checkVal" : array.join(","),
					"checkedId":checkedIds.join(",")
				},
				success : function(result) {
 						if (result.message ==0) {
                           		 Ams.error('操作失败！');
							} else {
                           		 Ams.success('操作成功！');
							}
 				},
						dataType : 'json'
					})
			TownList();
			$('#menuDlg').dialog('close');
		}

		function getCheckBoxVal() {
			var array = new Array();
			$(":checkbox").each(function(index, item) {
				if ($(item).is(':checked')) {
					array.push($(item).val())
				}
			})
			return array;
		}
		//操作 
		function editRiverMonitor(val, row, index) {
			if($("#city_id").val()==1){
				return '<a href="javascript:void(0)" class="easyui-linkbutton" onclick="watchUserRiver('+index+')">审核/编辑</a>';
			}else {
				return '<a href="javascript:void(0)" class="easyui-linkbutton" onclick="watchUserRiver('+index+')">录入/编辑</a>';
			}
		    
		}
		
		
		function watchUserRiver(index){  
	    	$('#dg').datagrid('selectRow',index);
	        var row = $('#dg').datagrid('getSelected');  
	        if (row){ 
	        	window.open(Ams.ctxPath+'/enviromonit/waterData/watchUserRiver?userName='+encodeURI(row.name)+"&uuid="+row.uuid+"&loginName="+row.loginname); 
	        }  
	    }  
	</script>
</body>
</html>