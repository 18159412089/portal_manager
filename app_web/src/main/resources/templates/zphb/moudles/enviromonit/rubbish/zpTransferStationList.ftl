<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>垃圾处理厂管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
					<input id="queryQymc" name="qymc" class="easyui-textbox" label="企业名称:" style="width: 200px;">
					<input id="queryQylx" name="qylx" class="easyui-textbox" label="企业类型:" style="width: 200px;">
					<input id="queryQydz" name="qydz" class="easyui-textbox" label="企业地址:" style="width: 200px;">
					<input id="queryChannelIds" name="channelIds" class="easyui-textbox" label="监控通道ID:" style="width: 200px;">
					<#--<input id="queryId" name="id" class="easyui-textbox" label="ID:" style="width: 200px;">
					<input id="queryWrybm" name="wrybm" class="easyui-textbox" label="污染源编码:" style="width: 200px;">
					<<input id="queryWrymc" name="wrymc" class="easyui-textbox" label="标准污染源名称:" style="width: 200px;">
					<input id="queryJc" name="jc" class="easyui-textbox" label="简称:" style="width: 200px;">
					<input id="queryGmbm" name="gmbm" class="easyui-textbox" label="规模编码:" style="width: 200px;">

					<input id="queryCym" name="cym" class="easyui-textbox" label="曾用名:" style="width: 200px;">

					<input id="queryZclx" name="zclx" class="easyui-textbox" label="登记注册类型:" style="width: 200px;">
					<input id="querySshy" name="sshy" class="easyui-textbox" label="所属行业:" style="width: 200px;">
					<input id="queryHydm" name="hydm" class="easyui-textbox" label="行业代码:" style="width: 200px;">

					<input id="queryFrdm" name="frdm" class="easyui-textbox" label="法人代码:" style="width: 200px;">
					<input id="queryDbmc" name="dbmc" class="easyui-textbox" label="法人代表姓名:" style="width: 200px;">
					<input id="queryDh" name="dh" class="easyui-textbox" label="电话:" style="width: 200px;">
					<input id="queryHbbm" name="hbbm" class="easyui-textbox" label="污染源环保部门:" style="width: 200px;">
					<#--<input id="queryLbbm" name="lbbm" class="easyui-textbox" label="单位类别编码:" style="width: 200px;">
					<input id="querySsly" name="ssly" class="easyui-textbox" label="所属流域:" style="width: 200px;">
					<input id="queryLybm" name="lybm" class="easyui-textbox" label="所属流域编码:" style="width: 200px;">
					<input id="queryGzcd" name="gzcd" class="easyui-textbox" label="关注程度:" style="width: 200px;">
					<input id="queryKysj" name="kysj" class="easyui-textbox" label="开业时间（投产日期）:" style="width: 200px;">
			<#--		<input id="queryJd" name="jd" class="easyui-textbox" label="经度:" style="width: 200px;">
					<input id="queryWd" name="wd" class="easyui-textbox" label="纬度:" style="width: 200px;">
					<input id="queryWz" name="wz" class="easyui-textbox" label="网址:" style="width: 200px;">
					<input id="queryJglx" name="jglx" class="easyui-textbox" label="污染源监管类型:" style="width: 200px;">
					<input id="queryGyyqmc" name="gyyqmc" class="easyui-textbox" label="所在工业园区名称:" style="width: 200px;">
				<#--	<input id="queryYb" name="yb" class="easyui-textbox" label="邮编:" style="width: 200px;">
					<input id="queryHblxr" name="hblxr" class="easyui-textbox" label="环保联系人:" style="width: 200px;">
					<input id="queryHblxrdh" name="hblxrdh" class="easyui-textbox" label="环保联系人电话:" style="width: 200px;">
					<input id="queryHblxrsj" name="hblxrsj" class="easyui-textbox" label="环保联系人手机:" style="width: 200px;">
					<input id="queryHblxrcz" name="hblxrcz" class="easyui-textbox" label="环保联系人传真:" style="width: 200px;">-->
				<#--	<input id="queryYhmc" name="yhmc" class="easyui-textbox" label="银行名称:" style="width: 200px;">
					<input id="queryYhzh" name="yhzh" class="easyui-textbox" label="银行账户:" style="width: 200px;">
					<input id="queryYxdz" name="yxdz" class="easyui-textbox" label="邮箱地址:" style="width: 200px;">
					<input id="queryCz" name="cz" class="easyui-textbox" label="传真:" style="width: 200px;">
					<input id="queryZzhbrys" name="zzhbrys" class="easyui-textbox" label="专职环保人员数:" style="width: 200px;">
					<input id="queryTxdz" name="txdz" class="easyui-textbox" label="通讯地址:" style="width: 200px;">
					<input id="queryWryzrr" name="wryzrr" class="easyui-textbox" label="污染源责任人:" style="width: 200px;">
					<input id="queryLxr" name="lxr" class="easyui-textbox" label="联系人:" style="width: 200px;">
					<input id="queryLsgx" name="lsgx" class="easyui-textbox" label="隶属关系:" style="width: 200px;">
					<input id="queryDwzz" name="dwzz" class="easyui-textbox" label="单位资质:" style="width: 200px;">
					<input id="queryBzlx" name="bzlx" class="easyui-textbox" label="总投资币种类型:" style="width: 200px;">
					<input id="queryZtz" name="ztz" class="easyui-textbox" label="总投资（万元）:" style="width: 200px;">
					<input id="queryHbztzbz" name="hbztzbz" class="easyui-textbox" label="环保总投资币种:" style="width: 200px;">
					<input id="queryHbtz" name="hbtz" class="easyui-textbox" label="环保投资（万元）:" style="width: 200px;">
					<input id="queryXzqmc" name="xzqmc" class="easyui-textbox" label="行政区名称:" style="width: 200px;">
					<input id="queryXzqdm" name="xzqdm" class="easyui-textbox" label="行政区代码:" style="width: 200px;">
					<input id="queryEpCode" name="epCode" class="easyui-textbox" label="企业编码:" style="width: 200px;">
					<input id="querySeqno" name="seqno" class="easyui-textbox" label="序号:" style="width: 200px;">-->
					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<br>

					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newZpTransferStation()">新增</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editZpTransferStation()">修改</a>

					<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteZpTransferStation()">删除</a>

				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newZpTransferStation()">新增</a>
				<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editZpTransferStation()">修改</a>
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteZpTransferStation()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/zphb/rubbish/zpTransferStation/zpTransferStationList"
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
					<th field="id" width="10%"  >ID</th>
					<th field="qymc" width="10%">企业名称</th>
					<th field="qylx" width="10%">企业类型</th>
					<th field="qydz" width="10%">企业地址</th>
					<th field="jd" width="10%">经度</th>
					<th field="wd" width="10%">纬度</th>
					<th field="yb" width="10%">邮编</th>
					<th field="txdz" width="10%">通讯地址</th>
					<th field="channelIds" width="10%">监控通道ID</th>
					<th field="seqno" width="10%">序号</th>
					<th field="wrybm" width="10%">污染源编码</th>
					<th field="wrymc" width="10%">标准污染源名称</th>
					<th field="jc" width="10%">简称</th>
					<th field="gmbm" width="10%">规模编码</th>

					<th field="cym" width="10%">曾用名</th>

					<th field="zclx" width="10%">登记注册类型</th>
					<th field="sshy" width="10%">所属行业</th>
					<th field="hydm" width="10%">行业代码</th>

					<th field="frdm" width="10%">法人代码</th>
					<th field="dbmc" width="10%">法人代表姓名</th>
					<th field="dh" width="10%">电话</th>
					<th field="hbbm" width="10%">污染源环保部门</th>
					<th field="lbbm" width="10%">单位类别编码</th>
					<th field="ssly" width="10%">所属流域</th>
					<th field="lybm" width="10%">所属流域编码</th>
					<th field="gzcd" width="10%">关注程度</th>
					<th field="kysj" width="10%">开业时间（投产日期）</th>

					<th field="wz" width="10%">网址</th>
					<th field="jglx" width="10%">污染源监管类型</th>
					<th field="gyyqmc" width="10%">所在工业园区名称</th>

					<th field="hblxr" width="10%">环保联系人</th>
					<th field="hblxrdh" width="10%">环保联系人电话</th>
					<th field="hblxrsj" width="10%">环保联系人手机</th>
					<th field="hblxrcz" width="10%">环保联系人传真</th>
					<th field="yhmc" width="10%">银行名称</th>
					<th field="yhzh" width="10%">银行账户</th>
					<th field="yxdz" width="10%">邮箱地址</th>
					<th field="cz" width="10%">传真</th>
					<th field="zzhbrys" width="10%">专职环保人员数</th>

					<th field="wryzrr" width="10%">污染源责任人</th>
					<th field="lxr" width="10%">联系人</th>
					<th field="lsgx" width="10%">隶属关系</th>
					<th field="dwzz" width="10%">单位资质</th>
					<th field="bzlx" width="10%">总投资币种类型</th>
					<th field="ztz" width="10%">总投资（万元）</th>
					<th field="hbztzbz" width="10%">环保总投资币种</th>
					<th field="hbtz" width="10%">环保投资（万元）</th>
					<th field="xzqmc" width="10%">行政区名称</th>
					<th field="xzqdm" width="10%">行政区代码</th>
					<th field="epCode" width="10%">企业编码</th>

				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="id" hidden="true" />
			<#--<div style="margin-bottom: 10px">
				<input name="id" id="id" class="easyui-textbox" required="true" label="ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>-->
			<div style="margin-bottom: 10px">
				<input name="wrybm" id="wrybm" class="easyui-textbox" required="true" label="污染源编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wrymc" id="wrymc" class="easyui-textbox" required="true" label="标准污染源名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jc" id="jc" class="easyui-textbox" required="true" label="简称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="gmbm" id="gmbm" class="easyui-textbox" required="true" label="规模编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qymc" id="qymc" class="easyui-textbox" required="true" label="企业名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cym" id="cym" class="easyui-textbox" required="true" label="曾用名:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qylx" id="qylx" class="easyui-textbox" required="true" label="企业类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zclx" id="zclx" class="easyui-textbox" required="true" label="登记注册类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sshy" id="sshy" class="easyui-textbox" required="true" label="所属行业:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hydm" id="hydm" class="easyui-textbox" required="true" label="行业代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qydz" id="qydz" class="easyui-textbox" required="true" label="企业地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="frdm" id="frdm" class="easyui-textbox" required="true" label="法人代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dbmc" id="dbmc" class="easyui-textbox" required="true" label="法人代表姓名:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dh" id="dh" class="easyui-textbox" required="true" label="电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hbbm" id="hbbm" class="easyui-textbox" required="true" label="污染源环保部门:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lbbm" id="lbbm" class="easyui-textbox" required="true" label="单位类别编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ssly" id="ssly" class="easyui-textbox" required="true" label="所属流域:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lybm" id="lybm" class="easyui-textbox" required="true" label="所属流域编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<#--<div style="margin-bottom: 10px">
				<input name="gzcd" id="gzcd" class="easyui-textbox" required="true" label="关注程度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="kysj" id="kysj" class="easyui-textbox" required="true" label="开业时间（投产日期）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jd" id="jd" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wd" id="wd" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wz" id="wz" class="easyui-textbox" required="true" label="网址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jglx" id="jglx" class="easyui-textbox" required="true" label="污染源监管类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="gyyqmc" id="gyyqmc" class="easyui-textbox" required="true" label="所在工业园区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yb" id="yb" class="easyui-textbox" required="true" label="邮编:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hblxr" id="hblxr" class="easyui-textbox" required="true" label="环保联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hblxrdh" id="hblxrdh" class="easyui-textbox" required="true" label="环保联系人电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hblxrsj" id="hblxrsj" class="easyui-textbox" required="true" label="环保联系人手机:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hblxrcz" id="hblxrcz" class="easyui-textbox" required="true" label="环保联系人传真:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yhmc" id="yhmc" class="easyui-textbox" required="true" label="银行名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yhzh" id="yhzh" class="easyui-textbox" required="true" label="银行账户:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="yxdz" id="yxdz" class="easyui-textbox" required="true" label="邮箱地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="cz" id="cz" class="easyui-textbox" required="true" label="传真:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zzhbrys" id="zzhbrys" class="easyui-textbox" required="true" label="专职环保人员数:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="txdz" id="txdz" class="easyui-textbox" required="true" label="通讯地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wryzrr" id="wryzrr" class="easyui-textbox" required="true" label="污染源责任人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lxr" id="lxr" class="easyui-textbox" required="true" label="联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lsgx" id="lsgx" class="easyui-textbox" required="true" label="隶属关系:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dwzz" id="dwzz" class="easyui-textbox" required="true" label="单位资质:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="bzlx" id="bzlx" class="easyui-textbox" required="true" label="总投资币种类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ztz" id="ztz" class="easyui-textbox" required="true" label="总投资（万元）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hbztzbz" id="hbztzbz" class="easyui-textbox" required="true" label="环保总投资币种:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hbtz" id="hbtz" class="easyui-textbox" required="true" label="环保投资（万元）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="xzqmc" id="xzqmc" class="easyui-textbox" required="true" label="行政区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="xzqdm" id="xzqdm" class="easyui-textbox" required="true" label="行政区代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="epCode" id="epCode" class="easyui-textbox" required="true" label="企业编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="channelIds" id="channelIds" class="easyui-textbox" required="true" label="监控通道ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="seqno" id="seqno" class="easyui-textbox" required="true" label="序号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>-->
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveZpTransferStation()" style="width: 90px">保存</a>
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
				/*id: $("#queryId").val().trim(),
				wrybm: $("#queryWrybm").val().trim(),
				wrymc: $("#queryWrymc").val().trim(),
				jc: $("#queryJc").val().trim(),
				gmbm: $("#queryGmbm").val().trim(),

				cym: $("#queryCym").val().trim(),

				zclx: $("#queryZclx").val().trim(),
				sshy: $("#querySshy").val().trim(),
				hydm: $("#queryHydm").val().trim(),

				frdm: $("#queryFrdm").val().trim(),
				dbmc: $("#queryDbmc").val().trim(),
				dh: $("#queryDh").val().trim(),
				hbbm: $("#queryHbbm").val().trim(),
				lbbm: $("#queryLbbm").val().trim(),
				ssly: $("#querySsly").val().trim(),
				lybm: $("#queryLybm").val().trim(),
				gzcd: $("#queryGzcd").val().trim(),
				kysj: $("#queryKysj").val().trim(),
				jd: $("#queryJd").val().trim(),
				wd: $("#queryWd").val().trim(),
				wz: $("#queryWz").val().trim(),
				jglx: $("#queryJglx").val().trim(),
				gyyqmc: $("#queryGyyqmc").val().trim(),
				yb: $("#queryYb").val().trim(),
				hblxr: $("#queryHblxr").val().trim(),
				hblxrdh: $("#queryHblxrdh").val().trim(),
				hblxrsj: $("#queryHblxrsj").val().trim(),
				hblxrcz: $("#queryHblxrcz").val().trim(),
				yhmc: $("#queryYhmc").val().trim(),
				yhzh: $("#queryYhzh").val().trim(),
				yxdz: $("#queryYxdz").val().trim(),
				cz: $("#queryCz").val().trim(),
				zzhbrys: $("#queryZzhbrys").val().trim(),
				txdz: $("#queryTxdz").val().trim(),
				wryzrr: $("#queryWryzrr").val().trim(),
				lxr: $("#queryLxr").val().trim(),
				lsgx: $("#queryLsgx").val().trim(),
				dwzz: $("#queryDwzz").val().trim(),
				bzlx: $("#queryBzlx").val().trim(),
				ztz: $("#queryZtz").val().trim(),
				hbztzbz: $("#queryHbztzbz").val().trim(),
				hbtz: $("#queryHbtz").val().trim(),
				xzqmc: $("#queryXzqmc").val().trim(),
				xzqdm: $("#queryXzqdm").val().trim(),
				epCode: $("#queryEpCode").val().trim(),

				seqno: $("#querySeqno").val().trim(),*/
				qymc: $("#queryQymc").val().trim(),
				qylx: $("#queryQylx").val().trim(),
				qydz: $("#queryQydz").val().trim(),
				channelIds: $("#queryChannelIds").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newZpTransferStation() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增垃圾处理厂');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/zphb/rubbish/zpTransferStation/saveZpTransferStation';
		}

		function editZpTransferStation() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/zphb/rubbish/zpTransferStation/getZpTransferStation',
					data: {'id': row.id},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改垃圾处理厂');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/zphb/rubbish/zpTransferStation/saveZpTransferStation';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveZpTransferStation() {
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

		function deleteZpTransferStation() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/zphb/rubbish/zpTransferStation/deleteZpTransferStation',
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
</script>
</body>
</html>
