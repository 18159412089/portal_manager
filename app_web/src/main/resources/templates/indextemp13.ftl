<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>数据服务静态示例</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout p10" fit=true>
	<!-- tabs 标签页 -->
	<div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
		<!-- 标签页——1 -->
		<div title="省实时监测" style="padding:10px">
			<!-- 数据列表页面 -->
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar1">
			        <!-- 搜索栏 -->
			        <div id="searchBar1" class="searchBar">
			            <form id="searchForm1">
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				             	<input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
				             	<input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			                <div class="inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
					            <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
					            <label>-</label>
					            <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
					        </div>
					        <div class="inline-block">
					        	<label class="textbox-label textbox-label-before" title="时间">污染因子:</label>
					            <div class="selectBox-container" style="width:200px;">
									<a href="javascript:void(0)" class="easyui-linkbutton select-button btn-orange">因子选择</a>
									<div class="select-panel">
										<div class="easyui-panel" title="污染物" style="width:560px;height:200px;padding:10px;" data-options="footer:'#ft',tools:'#tt'">
											<div id="selectGrop">
												<!--复选框-->
												<label class="form-checkbox">
													<input name="type" type="checkbox" value="" checked="checked"/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<!--复选框 over-->											
											</div>
										</div>
										<div id="tt">
											<label class="form-checkbox">
												<input name="type" type="checkbox" value="" class="all"/>
												<span class="lbl">全选</span>
											</label>
										</div>										
										<div class="tr" id="ft">
											<button type="button" class="btnSure btn-blue l-btn">确定</button>
										</div>										
									</div>
								</div>
					            
					        </div>                    
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch()">查询</a>
			                <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset()">重置</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 操作栏-->
				    <div class="optionBar">
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'"  onclick="$('#dlg').dialog('open')">导出数据</a>
				    	<div id="dlg" class="easyui-dialog" title="导出EXECL" data-options="iconCls:'iconcustom icon-shujudaochu1',closed:true" style="width:450px;padding:10px;display: none;">
							<div class="from-box">
								<div class="display-block">			                	
									<label class="form-radio">
						                <input name="pageNumber" type="radio" value="" checked="true"/>
						                <span class="lbl">所有页码数据</span>
						            </label>
								</div>	
								<div class="display-block">			                	
									<label class="form-radio">
						                <input name="pageNumber" type="radio" value="" />
						                <span class="lbl">导出</span>
						            </label>					                                    
						            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="1" data-options=" 
										method:'get',
										editable:false,
										valueField:'id',
										textField:'text',
										multiple:true,
										panelHeight:'350px'"
										style="width:70px;"/>页数据
								</div>	
								<div class="display-block">			                	
									<label class="form-radio">
						                <input name="pageNumber" type="radio" value="" />
						                <span class="lbl">导出</span>
						            </label>					                                    
						            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="1" data-options=" 
										method:'get',
										editable:false,
										valueField:'id',
										textField:'text',
										multiple:true,
										panelHeight:'350px'"
										style="width:70px;"/>
									<label>至</label>	
						            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="1" data-options=" 
										method:'get',
										editable:false,
										valueField:'id',
										textField:'text',
										multiple:true,
										panelHeight:'350px'"
										style="width:70px;"/>									
									页数据
								</div>	
								<div class="display-block exported-fields">
				                	<div class="mb10">导出字段：</div>
				                	<div class="display-block">
				                		<label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" />
							                <span class="lbl">PM2.5</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">PM10</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">SO2</span>
							            </label>
				                		<label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" />
							                <span class="lbl">NO2</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">O3</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">CO</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">O3</span>
							            </label>
							            <label class="form-checkbox">
							                <input name="checkbox12" type="checkbox" value="" checked="true"/>
							                <span class="lbl">CO</span>
							            </label>
				                	</div>
				                	
								</div>
								
								<div class="tr">
									<a href="javascript:void(0)" class="easyui-linkbutton btn-primary">确定</a>
								</div>							
							</div>
						</div>
				    </div>
				    <!-- 操作栏 over-->
				    <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">AQI排名前三</div>
				    			<div class="cell-content">
									<div class="inline-block">
										<div class="inline-block">
											<span>龙文环保局：</span>
					    					<span class="em">9</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>
									<div class="inline-block">
										<div class="inline-block">
											<span>金峰管委会：</span>
					    					<span class="em">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
									<div class="inline-block">
										<div class="inline-block">
											<span>科华公司：</span>
					    					<span class="em">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">AQI排名后三</div>
				    			<div class="cell-content">
									<div class="inline-block">
										<div class="inline-block">
											<span>龙文环保局：</span>
					    					<span class="em">9</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>
									<div class="inline-block">
										<div class="inline-block">
											<span>金峰管委会：</span>
					    					<span class="em down">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
									<div class="inline-block">
										<div class="inline-block">
											<span>科华公司：</span>
					    					<span class="em up">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
								</div>
				    		</div>
				    	</div>
				    </div>
				    <!-- 数据信息  over-->
				    <!-- 标题栏 -->
				    <div class="titleBar tc">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group change-chart fr">
							<span class="active" date-select="chart">图表</span>
							<span date-select="text">文字</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    	
				    	<h2 class="title">数据标题-均值比较（按城市）<span class="subtitle">监测天数：30天</span></h2>
				    	
				    </div>	
				    <!-- 标题栏 over -->			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group">
							<span class="active">时</span>
							<span>日</span>
							<span>月</span>
							<span>年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    </div>
				    
				    <!-- 图表栏-->
				    <div class="chartBar">
				    	<div class="optionBar tc">
					    	<!-- 单选按钮组 -->
					    	<div class="radio-button-group style-btn-group">
								<span class="active">SO2</span>
								<span>NO2</span>
								<span>NO2</span>
								<span>NO2</span>
								<span>PM10</span>
								<span>PM10</span>
							</div>
					    	<!-- 单选按钮组 over-->
					    </div>
				    	<div class="chart-box">
							  <div id="airPrimaryPollutant" style="width: 100%;height: 420px;"></div>
						</div>
				    
				    </div>
				    <!-- 图表栏 over-->				    
				    
			    </div>
			    <!-- 工具栏 over-->
			    
				<!-- 数据列表-->
				<table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
		               data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		            <thead>
			            <tr>
			                <th field="type" width="100">监测日期</th>
			                <th field="value" width="100">地区</th>
			                <th field="AQI" width="100" align="center">AQI</th>
			                 <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
			            </tr>
		            </thead>
		            <tbody>
						<tr>
							<td>001</td>
							<td>name1</td>
							<td>5</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>10</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>20</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>30</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>40</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>50</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>-</td>
						</tr>
					</tbody>		
		        </table>
				<!-- 数据列表 over-->
			</div>
			<!-- 数据列表页面 over-->		
		</div>
		<!-- 标签页——1 over-->
		
		<!-- 标签页——2 -->
		<div title="自建实时监测" style="padding:10px">
			<!-- 数据列表页面 -->
			<div class="easyui-layout" fit=true>
				<!-- 工具栏----id与easyui-datagrid的toolbar一致-->
				<div id="toolbar2">
			        <!-- 搜索栏 -->
			        <div id="searchBar2" class="searchBar">
			            <form id="searchForm2">
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="地区">地区:</label>
				             	<input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName2" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			            	<div class="inline-block">
								<label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
				             	<input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName2" prompt="全部" data-options=" 
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
									style="width:200px;"/>
				            </div>
			                <div class="inline-block">
								<label class="textbox-label textbox-label-before" title="时间">时间:</label>
					            <input id="startTime2" name="startTime" class="easyui-datebox" style="width:156px;">
					            <label>-</label>
					            <input id="endTime2" name="endTime" class="easyui-datebox" style="width:156px;">
					        </div>
					        <div class="inline-block">
					        	<label class="textbox-label textbox-label-before" title="时间">污染因子:</label>
					            <div class="selectBox-container" style="width:200px;">
									<a href="javascript:void(0)" class="easyui-linkbutton select-button btn-orange">因子选择</a>
									<div class="select-panel">
										<div class="easyui-panel" title="污染物" style="width:560px;height:200px;padding:10px;" data-options="footer:'#ft2',tools:'#tt2'">
											<div id="selectGrop">
												<!--复选框-->
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value="1" checked="checked"/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value="2"/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value="3"/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value="4"/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">行政区</span>
												</label>
												<label class="form-checkbox">
													<input name="type2" type="checkbox" value=""/>
													<span class="lbl">测点</span>
												</label>
												<!--复选框 over-->											
											</div>
										</div>
										<div id="tt2">
											<label class="form-checkbox">
												<input name="type2" type="checkbox" value="" class="all"/>
												<span class="lbl">全选</span>
											</label>
										</div>										
										<div class="tr" id="ft2">
											<button type="button" class="btnSure btn-blue l-btn">确定</button>
										</div>										
									</div>
								</div>
					            
					        </div>                    
			                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
			                   onclick="doSearch()">查询</a>
			                <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
			                   onclick="doReset()">重置</a>
			            </form>
			        </div>
			        <!-- 搜索栏 over-->
			        <!-- 操作栏-->
				    <div class="optionBar">
				    	<!-- <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newParentDict()">新增</a>
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editParentDict()">修改</a> -->
				    	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出数据</a>
				    	<!-- <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delDict()">删除</a> -->
				    </div>
				    <!-- 操作栏 over-->
				    <!-- 数据信息 -->
				    <div class="data-info-layout">
				    	<div class="other">
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
				    		<div class="inline-block">
				    			<span class="control-label">监测时间：</span>
				    			<span class="control-content">2019-06-01 19:00:00</span>
				    		</div>
				    	</div>
				    	<div class="row">
				    		<div class="item col-xs-6">
				    			<div class="cell-title">AQI排名前三</div>
				    			<div class="cell-content">
									<div class="inline-block">
										<div class="inline-block">
											<span>龙文环保局：</span>
					    					<span class="em">9</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>
									<div class="inline-block">
										<div class="inline-block">
											<span>金峰管委会：</span>
					    					<span class="em">18</span>
										</div>
										<div class="inline-block">   科华公司：18   首污 PM2.5
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
									<div class="inline-block">
										<div class="inline-block">
											<span>科华公司：</span>
					    					<span class="em">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
								</div>
				    		</div>
				    		<div class="item col-xs-6">
				    			<div class="cell-title">AQI排名后三</div>
				    			<div class="cell-content">
									<div class="inline-block">
										<div class="inline-block">
											<span>龙文环保局：</span>
					    					<span class="em">9</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>
									<div class="inline-block">
										<div class="inline-block">
											<span>金峰管委会：</span>
					    					<span class="em down">18</span>
										</div>
										<div class="inline-block">   科华公司：18   首污 PM2.5
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
									<div class="inline-block">
										<div class="inline-block">
											<span>科华公司：</span>
					    					<span class="em up">18</span>
										</div>
										<div class="inline-block">
											<span>首污</span>
					    					<span class="em">PM2.5</span>
										</div>
									</div>									
								</div>
				    		</div>
				    	</div>
				    	
				    </div>
				    <!-- 数据信息  over-->	
				    			    
				    <div class="optionBar">
				    	<!-- 单选按钮组 -->
				    	<div class="radio-button-group style-btn-group">
							<span class="active">时</span>
							<span>日</span>
							<span>月</span>
							<span>年</span>
						</div>
				    	<!-- 单选按钮组 over-->
				    </div>
				    
			    </div>
			    <!-- 工具栏 over-->
				<!-- 数据列表-->
				<table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
		               data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
		            <thead>
			            <tr>
			                <th field="type" width="100">监测日期</th>
			                <th field="value" width="100">地区</th>
			                <th field="AQI" width="100" align="center"
			                 styler="Ams.setAQIBackground">AQI</th>
			            </tr>
		            </thead>
		            <tbody>
						<tr>
							<td>001</td>
							<td>name1</td>
							<td>5</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>10</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>20</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>30</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>40</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>50</td>
						</tr>
						<tr>
							<td>002</td>
							<td>name2</td>
							<td>-</td>
						</tr>
					</tbody>		
		        </table>
				<!-- 数据列表 over-->
			</div>
			<!-- 数据列表页面 over-->		
		</div>
		<!-- 标签页——2 over-->
		
		
	</div>
	<!-- tabs 标签页 over -->

</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
 	
    $(function(){
    	/*因子选择*/
        $('body').on('click','.btnSure',function () {
        	var $target=$(this).parents(".select-panel");
        	$target.removeClass('show');
        	$target.off("change.selectAll",".all");

        	//获取选中的值
            var $chenckbox =$("#selectGrop").find(".form-checkbox");
            var  nub= $chenckbox.length; // 获取checkbox 个数
            var nublist=[];//存放被选中值
            for(var i = 0; i<nub;i++){
                if($chenckbox.eq(i).find("input").is(':checked')){
                    $chenckbox.eq(i).find("span").text()
                     nublist.push( "key:"+ i+"  val:"+$chenckbox.eq(i).find("span").text())
                }
            }
            console.log(nublist)
        });
        $('body').on('click','.select-button',function () {
        	var $target=$(this).next();
        	$target.addClass('show');
        	$target.on("change.selectAll",".all",function () {
        		if($(this).prop("checked")){
        			$target.find('input[name='+$(this).prop("name")+']').prop("checked",true);        			
        		}else{
        			$target.find('input[name='+$(this).prop("name")+']').prop("checked",false);
        		}
        		
        	});
        });
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");

        });
        /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
        	console.log($(this).attr("date-select"));
        	var $target=$(this).parents(".datagrid").find(".chartBar");
        	if($(this).attr("date-select")=="chart"){
        		$target.removeClass("hide");
        	}else{
        		$target.addClass("hide");
        	}

        });
        /*数据列表与图表的切换*/
        $('#dg1').datagrid({
        	onBeforeLoad: function(){
        		var toolbar=$(this).datagrid("options").toolbar;
        		var chartHeight=$(this).datagrid("options").height-$(toolbar).height();
        		var $chartbar=$(toolbar).children(".chartBar").height(chartHeight);
        	}        	
        });
        /*数据列表尺寸改变重新计算图表大小*/
        $('#dg1').datagrid("getPanel").panel({
            onResize:function(width, height){
            	var toolbar=$('#dg1').datagrid("options").toolbar;
        		var chartHeight=$('#dg1').datagrid("options").height-$(toolbar).height();
        		var $chartbar=$(toolbar).children(".chartBar").height(chartHeight);
            }
        });
        /**/
        $("#tabs").tabs({
        	onSelect:function(title,index){
        		console.log(index);
        	}
        });
    });


    $(function () {
        /*---------------------------------------图表-------------------------------------------*/
        // 基于准备好的dom，初始化echarts实例
        var airPrimaryPollutantChart = echarts.init(document.getElementById('airPrimaryPollutant'));
        var airPrimaryPollutantOption= {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                top:7,
                data: ['NO2','PM10','PM2.5','O3','CO','SO2']
            },
            title: {
                text: '蓝田湖',
                top:5,
                textStyle:{ //设置主标题风格
                    fontSize: 14,
                    color:'#404040',
                    fontWeight:100,
                },
            },


            grid: {
                top:'50',
                left: '10',
                right: '10',
                bottom: '10',
                containLabel: true
            },
            xAxis:  {
                type: 'category',
                data: ['2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00']

            },
            yAxis: {
                type: 'value',
                splitNumber:6,
                min: 0,
                max: 15
            },

            series: [
                {
                    name:'NO2',
                    type:'line',
                    symbol: 'circle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {

                            color: '#2ba4e9'
                        }
                    },
                    data:[3,9,4,2,4,5,7,8,9,9,10,6]
                },
                {
                    name:'PM10',
                    type:'line',
                    symbol: 'triangle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#ff6262'
                        }
                    },
                    data:[5,6,7,7,6,9,12,2,3,6,4,4]
                }
                ,
                {
                    name:'PM2.5',
                    type:'line',
                    symbol: 'star',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#fe8a57'
                        }
                    },
                    data:[3,4,5,6,2,6,8,9,7,10,6,5]
                }
                ,
                {
                    name:'CO',
                    type:'line',
                    symbol: 'star',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#ffbf26'
                        }
                    },
                    data:[10,5,9,6,11,8,13,14,9,6,3,3]
                }
                ,
                {
                    name:'O3',
                    type:'line',
                    symbol: 'diamond',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#9587f1'
                        }
                    },
                    data:[1,2,5,6,8,4,2,7,9,8,2,2]
                }
                ,
                {
                    name:'SO2',
                    type:'line',
                    symbol: 'triangle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#3fa15a'
                        }
                    },
                    data:[5,7,8,10,11,2,8,6,9,3,6,10]
                }

            ]

        };
        // 使用刚指定的配置项和数据显示图表。
        airPrimaryPollutantChart.setOption(airPrimaryPollutantOption);

        window.onresize = function() {
            $('#airPrimaryPollutant').width('100%');
            airPrimaryPollutantChart.resize();
        }
	})


</script>
</html>