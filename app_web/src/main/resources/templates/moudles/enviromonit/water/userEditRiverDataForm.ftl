<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>小河流域数据更新表单</title> <#include "/header.ftl"/>
</head>
<body>
	<div></div>
	<div class="easyui-layout" fit=true style="padding: 3px">
		<#include "/common/loadingDiv.ftl"/>
		<div id="toolbar">
		    <#if name??>
			<a href="javascript:void(0)" class="easyui-linkbutton">河流管理用户:${name!}</a>
			</#if>
			<input id="uuid" value="${uuid!}" type="hidden"> <input
				id="loginName" value="${loginName!}" type="hidden">
		</div>
		<@sec.authorize access="hasRole('ROLE_CITY')">
         <input id="city_id" value="1" type="hidden"> 
		</@sec.authorize>
		<@sec.authorize access="hasRole('ROLE_TOWN')">
         <input id="city_id" value="0" type="hidden"> 
		</@sec.authorize>
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
						<th field="monitorName" width="25%">名称</th>
						<th field="opera1" width="25%"
							data-options="formatter : updataRiver">补全资料</th>
						<th field="opera2" data-options="formatter : format" width="15%">更新时间</th>
						<th field="state" width="25%" data-options="formatter : state">状态</th>
						<th field="opera" width="120px"
							data-options="formatter : editDelete">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="menuDlg" class="easyui-dialog"
			style="width: 50%; height: 100%;"
			data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
		</div>
		<div id="menuDlg-buttons" style="padding-right: 46px">
		       <@sec.authorize access="hasRole('ROLE_CITY')">
			  <a href="javascript:void(0)" id="examine_id"  class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="examine()"
				style="width: 90px">通过</a>
				</@sec.authorize>
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="submitWtBasinMonitor(0)"
				style="width: 90px">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-cancel"
				onclick="javascript:$('#menuDlg').dialog('close')"
				style="width: 90px">取消</a>
		</div>
	</div>
	<script>
		$.parser.onComplete = function() {
			$("#loadingDiv").fadeOut("normal", function() {
				$(this).remove();
			});
		};

		$('#dg').datagrid({
			url : "/enviromonit/waterData/listUserRiver",
			queryParams : {
				uid : $("#uuid").val(),
				loginName : $("#loginName").val()
			}
		});
		//操作 
		function editDelete(val, row, index) {
			if($("#city_id").val()==1){
				return '<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit('
				+ index + ')">审核/编辑</a>';
			}else {
				return '<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit('
				+ index + ')">录入/编辑</a>';
			}
			
		}
		//操作 
		function updataRiver(val, row, index) {
			return '<span>补全资料</span>';
		}
		//操作 
		function state(val, row, index) {
			if (val == 0) {
				return '<span>待审核</span>';
			} else {
				return '<span>通过</span>';
			}
		}
		function add0(m) {
			return m < 10 ? '0' + m : m
		}
		function format(val, row, index) {
			if (row.updateTime == null) {
				return "";
			}
			var time = new Date(Number(row.updateTime));
			var y = time.getFullYear();
			var m = time.getMonth() + 1;
			var d = time.getDate();
			var h = time.getHours();
			var mm = time.getMinutes();
			var s = time.getSeconds();
			return y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':'
					+ add0(mm) + ':' + add0(s);
		}
		function edit(index) {
			$('#dg').datagrid('selectRow', index);// 关键在这里  
			var row = $('#dg').datagrid('getSelected');
			$("#menuDlg").empty().append(getlist(row));
			$('#menuDlg').dialog('open').dialog('center').dialog('setTitle',
					'监测点名称' + row.monitorName);
		}

		function getlist(data) {
			if(data.state==1){
				$("#examine_id").text("已通过");
			}else{
				$("#examine_id").text("通过");
			} 
			var newFormWord = "";
			newFormWord += "<form id='fm-detail' method='post' novalidate > <table class='table'><tbody class='form-table'>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>监测点名称</td>";
			newFormWord += "<td class='con'><input id='entercode' name='monitorName' class='easyui-textbox'   style='width: 188px;' value="
					+ trimNull(data.monitorName) + " ></td>";
			newFormWord += "<td class='title tr'>经度</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='longitude' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.longitude) + "  ></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>纬度</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='latitude' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.latitude) + "  ></td>";
					newFormWord += "<td class='title tr'>监测点编码</td>";
					newFormWord += "<td class='con'><input id='entercode' name='monitorCode' class='easyui-textbox'   style='width: 188px;' value="
							+ trimNull(data.monitorCode) + " ></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>所属河流</td>";
			newFormWord += "<td class='con'><input id='entercode' name='river' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.river) + "  ></td>";
			newFormWord += "<td class='title tr'>所属流域</td>";
			newFormWord += "<td class='con'><input id='entercode' name='basin' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.basin) + "  ></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>流域面积(平方公里)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='basinArea' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.basinArea) + "  ></td>";
			newFormWord += "<td class='title tr'>境内流域面积(平方公里)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='insideBasinArea' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.insideBasinArea) + "></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>河道长(公里)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='riverLength' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.riverLength) + "></td>";
			newFormWord += "<td class='title tr'>境内河道长(公里)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='insideRiverLength' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.insideRiverLength) + "></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>多年平均流量(立方米／秒)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number'  name='averageFlow' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.averageFlow) + "></td>";
			newFormWord += "<td class='title tr'>河道坡率(‰)</td>";
			newFormWord += "<td class='con'><input id='entercode' type='number' name='slopeRatio' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.slopeRatio) + "></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>流域形状系数(F/L2)</td>";
			newFormWord += "<td class='con'><input id='entercode' name='basinShapeCoefficient' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.basinShapeCoefficient) + "></td>";
			newFormWord += "<td class='title tr'>所属区县</td>";
			newFormWord += "<td class='con'><input style='border: 0px;outline:none;cursor: pointer;' readonly='readonly' id='entercode' name='county' class='easyui-textbox'  style='width: 188px;'  value="
					+ trimNull(data.county) + "></td>";
			newFormWord += "</tr>";
			newFormWord += "<tr>";
			newFormWord += "<td class='title tr'>断面类型</td>";
			newFormWord += "<td class='con'><input id='entercode' name='type' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.type) + "></td>";
			newFormWord += "<td class='title tr'>交界城市(上游-下游)</td>";
			newFormWord += "<td class='con'><input id='entercode' name='bordorCity' class='easyui-textbox'  style='width: 188px;' value="
					+ trimNull(data.bordorCity) + "></td>";
			newFormWord += "<tr>"
			newFormWord += "<td class='title tr' colspan='4' align='left'>概况与分析</td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='con' colspan='4'><textarea id='entercode' name='analysis' class='easyui-textbox'  style='width: 100%;'  >"
				+ trimNull(data.analysis) + "</textarea></td>";
			newFormWord += "</tr>"
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='title tr' colspan='4' align='left' >农业种植</td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='con' colspan='4'><textarea placeholder='例：农田数量（亩）' name='africulture' style='width:100%'>"
					+ trimNull(data.africulture) + "</textarea></td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='title tr' colspan='4' align='left' >生活污水</td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='con' colspan='4'><textarea placeholder='例：涉及村、镇名称和人口数量，其中，已实现集中市政污水处理设施收集处理的量，已实现简易污水处理设施收集处理的量（三格化粪池、），尚未实现收集处理的量。'  name='liveSewage' style='width:100%'>"
					+ trimNull(data.liveSewage) + "</textarea></td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='title tr' colspan='4' align='left' >工业源</td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='con' colspan='4'><textarea placeholder='例：涉水工业企业量、排水量、主要废水因子' name='industrySource' style='width:100%'>"
					+ trimNull(data.industrySource) + "</textarea></td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='title tr' colspan='4' align='left' >其他</td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<td class='con' colspan='4'><textarea placeholder='其它'  name='other' style='width:100%'>"
					+ trimNull(data.other) + "</textarea></td>";
			newFormWord += "</tr>"
			newFormWord += "<tr>"
			newFormWord += "<input type='hidden' name='userid' style='width:100%' value="
					+ trimNull(data.userid) + "> ";
			newFormWord += "<input  type='hidden' style='border: 0px;outline:none;cursor: pointer;' id='entercode' readonly='readonly' name='uuid' class='easyui-textbox'   style='width: 188px;' value="
				+ trimNull(data.uuid) + ">";
					
			newFormWord += "</tr>"
			newFormWord += "</tbody></table></form><br/>";
			return newFormWord;
		}
         //修改:审核功能
		function submitWtBasinMonitor(state) {
			var params = $("#fm-detail").serialize();
			var url1 = "/enviromonit/waterData/editWtBasinMonitor";
			if (state == 1) {
				url1 = "/enviromonit/waterData/examine";
			}
			$.ajax({
				type : "POST",
				url : url1,
				data : params,
				success : function(result) {
					if (result.message == 0) {
                        Ams.error('操作失败！');
					} else {
                        Ams.success('操作成功！');
					}
					;
					$('#dg').datagrid({
						url : "/enviromonit/waterData/listUserRiver",
						queryParams : {
							uid : $("#uuid").val(),
							loginName : $("#loginName").val()
						}
					});
				}
			});

			$('#menuDlg').dialog('close');
		}
		function trimNull(dataStr) {
			if (dataStr == null || dataStr == "underfinded") {
				return "";
			}
			return dataStr
		}
		function examine() {
			submitWtBasinMonitor(1);
		}
	</script>
</body>
</html>