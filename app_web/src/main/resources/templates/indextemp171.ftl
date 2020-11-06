<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>实时动态数据-大数据</title>

</head>
<!-- body -->
<body class="">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudAir.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudData.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>


<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<style type="text/css">

</style>
<!-- 头部 -->
<header class="home-air-header-container">
	<div class="header-logo">
		<h1 class="logo-text" style="letter-spacing: 3px;">
			实时动态数据
			<div class="btn-switch-tv">TV</div>
		</h1>
	</div>
	<div class="header-nav p-right">
        <a href="${request.contextPath}/index" class="open-link-tag" target="_blank">进入系统</a>
        <div class="atmosphere-nav">
            <ul>
                <li>
                    <a class="nav-item-a select-tag">
                    <span class="title">大气环境</span>
                     <i class="icon iconcustom drop-icon"></i>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="${request.contextPath}/environment/waterDataShow">
                        <span class="title">水环境</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="${request.contextPath}/main">
                        <span class="title">生态环境问题</span>
                    </a>
                </li>
            </ul>



        </div>
    </div>
    <div class="header-other p-left">
        <span id="weatherDate">2018年9月20日</span>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云  北风1~2级</span>
        <span id="wind">多云  北风1~2级</span>
        <span id="temperature">多云  北风1~2级</span>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-air-container">
	<!-- 左 -->
	<div class="home-layout fl" id="home-left">
		<!--首页面板-->
		<div class="home-air-panel" id="waterMonitoring">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr">详情</a>
				<span class="title">
					<span class="icon iconcustom icon-shidu1" ></span>
					<span>水质自动实时监测</span>
				</span>
				<span class="other">实时：2019.7.13  10:00</span>
			</div>
			<div class="home-air-panel-body">
				<!--面板主内容-->
				<div class="home-ranking-list">
					<!-- 数据列表-->
					<table id="waterMonitoringTable" class="easyui-datagrid" url=""
						   style="height:100%"
			               data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
			            <thead>
				            <tr>
				                <th align="center" field="type" width="80">排名</th>
				                <th align="center" field="value" width="150">监测站点</th>
				                <th align="center" field="AQI" width="100">目标水质</th>
				                <th align="center" field="AQI2" width="100">抽取水质</th>
				                <th align="center" field="AQI3" width="150">首要污染物</th>
				            </tr>
			            </thead>
			            <tbody>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">2</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">3</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">4</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">5</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">6</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">7</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">8</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">9</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">10</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">11</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">12</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">13</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>

						</tbody>
			        </table>
					<!-- 数据列表 over-->
				</div>
				<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->
		<!--首页面板-->
		<div class="home-air-panel" id="todayWeather">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr">详情</a>
				<span class="title">
					<span class="icon iconcustom iconduoyun" ></span>
					<span>今日天气</span>
				</span>
				<span class="other">7:30更新</span>
			</div>
			<div class="home-air-panel-body">
				<!--面板主内容-->
				<div class="box-body">
					<div class="sub-title">
						<span>10:00</span>实况
					</div>
					<div class="weather-mian">
						<span class="icon iconcustom icon-wenduji2"></span>
						<span><span class="em">26</span>℃</span>
					</div>
					<ul class="weather-info-list">
						<li class="item">
							<span class="icon iconcustom icon-shidu1"></span>
							<span class="text">相对湿度</span>
							<span class="text">71%</span>
						</li>
						<li class="item">
							<span class="icon iconcustom icon-songfeng"></span>
							<span class="text">东南风</span>
							<span class="text">2级</span>
						</li>
						<li class="item">
							<span class="icon iconcustom icon-huanjing1"></span>
							<span class="text">50</span>
							<span class="text">优</span>
						</li>
					</ul>
				</div>
				<div class="box-body">
					<div class="sub-title">
						<span>12日</span>白天
					</div>
					<div class="weather-mian">
						<span class="icon iconcustom iconxiaoyu"></span>
						<div>小雨</div>
					</div>
					<div class="weather-temperature">
						<span>34℃</span>
					</div>
					<ul class="weather-info-list">
						<li class="item">
							<div class="icon iconcustom icon-songfeng"></div>
							<div class="text">东南风</div>
							<div class="text">2级</div>
						</li>
						<li class="item">
							<div class="icon iconcustom icon-zhire"></div>
							<div class="text">日出</div>
							<div class="text">05:27</span>
						</li>
					</ul>
				</div>
				<div class="box-body">
					<div class="sub-title">
						<span>12日</span>夜间
					</div>
					<div class="weather-mian">
						<span class="icon iconcustom iconxiaoyu"></span>
						<div>小雨</div>
					</div>
					<div class="weather-temperature">
						<span>24℃</span>
					</div>
					<ul class="weather-info-list">
						<li class="item">
							<div class="icon iconcustom icon-songfeng"></div>
							<div class="text">东南风</div>
							<div class="text">2级</div>
						</li>
						<li class="item">
							<div class="icon iconcustom icon-zhire"></div>
							<div class="text">日落</div>
							<div class="text">19:01</span>
						</li>
					</ul>
				</div>
				<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->
	</div>
	<!-- 左  over-->
	<!-- 右 -->
	<div class="home-layout fr" id="home-right">
		<!--首页面板-->
		<div class="home-air-panel" id="monitoringDetails">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr">详情</a>
				<span class="title">
					<span class="icon iconcustom icon-shujucaiji1" ></span>
					<span>网格化事件上报实时数据</span>
				</span>
				<span class="other">实时：2019.7.13  10:00</span>
			</div>
			<div class="home-air-panel-body">
				<!--面板主内容-->
				<div class="box-content row">
					<div class="grid-info">
						<div class="panel-left ani duration05">
							<span class="icon iconcustom icon-renyuan2"></span>
						</div>
						<div class="panel-right">
							<div>网格化人员</div>
							<div><span>154</span></div>
						</div>
					</div>
					<div class="grid-info">
						<div class="panel-left ani duration05">
							<span class="icon iconcustom icon-renwuguanli2"></span>
						</div>
						<div class="panel-right">
							<div>事件数量</div>
							<div><span title="68001,367">6800万</span></div>
						</div>
					</div>
					<div class="grid-info">
						<div class="panel-left ani duration05">
							<span class="icon iconcustom icon-jibenxinxi2"></span>
						</div>
						<div class="panel-right">
							<div>已处理事件</div>
							<div><span>650</span></div>
						</div>
					</div>
					<div class="grid-info">
						<div class="panel-left ani duration05">
							<span class="icon iconcustom icon-renwu2"></span>
						</div>
						<div class="panel-right">
							<div>待处理事件</div>
							<div><span>154</span></div>
						</div>
					</div>

				</div>
				<div class="data-table-box">
					<div class="home-ranking-list">
						<!-- 数据列表-->
						<table id="monitoringDetailsTable" class="easyui-datagrid" url=""
							   style="height:100%"
				               data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
				            <thead>
					            <tr>
					                <th align="center" field="type" width="80">排名</th>
					                <th align="center" field="value" width="150">监测站点</th>
					                <th align="center" field="AQI" width="100">目标水质</th>
					                <th align="center" field="AQI2" width="100">抽取水质</th>
					                <th align="center" field="AQI3" width="150">首要污染物</th>
					            </tr>
				            </thead>
				            <tbody>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">2</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">3</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">4</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">5</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">6</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">7</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">8</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">9</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">10</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">11</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">12</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">13</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>
								<tr>
									<td><span class="ranking">1</span></td>
									<td>南靖靖城桥</td>
									<td>5</td>
									<td>5</td>
									<td>5</td>
								</tr>

							</tbody>
				        </table>
						<!-- 数据列表 over-->
					</div>
				</div>
				<!--面板主内容 over-->
			</div>

		</div>
		<!--首页面板 over-->
		<!--首页面板-->
		<div class="home-air-panel" id="videoSurveillance">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr" id="video-details">详情</a>
				<span class="title">
					<span class="icon iconcustom icon-shipinjiankong1" ></span>
					<span>视频监控</span>
				</span>
				<span class="other">2019.01.01~2019.05.28</span>
			</div>
			<div class="home-air-panel-body">
                <#--<#include "/common/loadingDiv.ftl"/>
                <div style='display:none;'>
                    userName:<select id="SelectUser" name="user"  style="width:152px"></select>
                    netZone:<select id="SelectNet" name="net" style="width:152px"></select>
                </div>
                <div style='display:none;'>
                    预览类型：
                    <select id="PlayType" style="width:100pix">
                        <option value="0" selected="true">空闲窗口预览</option>
                        <option value="1">选中窗口预览</option>
                        <option value="2">指定窗口预览</option>
                    </select>
                    <select id="seledWndIndex" style="width:40px"></select>
                </div>
                <div class="tree" style="width:250px;height:100%;float:left;overflow:auto;display:none;">
                    <ul id="planTree" class="ztree" width="100%"></ul>
                </div>
                <div class="ActiveX" style="overflow:hidden;height:100%;width: 100%; border: 1px solid red;">
                    <object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
                </div>-->

                    <div style="width: 100%;height: 400px;">
                        <div class="hide-div">
                            <div style='display:none;'>
                                userName:<select id="SelectUser" name="user"  style="width:152px"></select>
                                netZone:<select id="SelectNet" name="net" style="width:152px"></select>
                            </div>
                            <div style='display:none;'>
                                预览类型：
                                <select id="PlayType" style="width:100pix">
                                    <option value="0" selected="true">空闲窗口预览</option>
                                    <option value="1">选中窗口预览</option>
                                    <option value="2">指定窗口预览</option>
                                </select>
                                <select id="seledWndIndex" style="width:40px"></select>
                            </div>
                        </div>
		                <#include "/common/loadingDiv.ftl"/>
                        <div style="display:none;">
                            <div class="search-container">
                                <input type="text" style="height: 25px;" class="search-input"/>
                                <button type="button" class="search-button"><i class="fa fa-search"></i> 搜索</button>
                                <button type="button" class="sync-button"><i class="fa fa-refresh"></i> 同步</button>
                            </div>
                        </div>
                        <div class="tree" style="width:250px;height:100%;float:left;overflow:auto;display:none;">
                            <ul id="planTree" class="ztree" width="100%"></ul>
                        </div>
                        <!-- style="Margin-left:tree.width -->
                        <div class="ActiveX" style="overflow:hidden;height:100%; width: 100%;">
                            <object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
                        </div>
                    </div>
			</div>
		</div>
		<!--首页面板 over-->


	</div>
	<!-- 右  over-->
	<!-- 中 -->
	<div class="home-layout oh" id="home-center">
		<!--首页面板-->
		<div class="home-air-panel" id="provinceRanking">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr">详情</a>
				<span class="title">
					<span class="icon iconcustom icon-liebiao" ></span>
					<span>省AQI排名</span>
				</span>
				<span class="other">2019.01.01~2019.05.28</span>
			</div>
			<div class="home-air-panel-body">
				<!--面板主内容-->
				<div class="home-ranking-list">
					<!-- 数据列表-->
					<table id="provinceRankingTable" class="easyui-datagrid" url=""
						   style="height:100%"
			               data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
			            <thead>
				            <tr>
				                <th align="center" field="type" width="80">排名</th>
				                <th align="center" field="value" width="150">监测站点</th>
				                <th align="center" field="AQI" width="100">目标水质</th>
				                <th align="center" field="AQI2" width="100">抽取水质</th>
				                <th align="center" field="AQI3" width="150">首要污染物</th>
				            </tr>
			            </thead>
			            <tbody>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">2</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">3</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">4</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">5</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">6</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">7</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">8</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">9</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">10</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">11</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">12</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">13</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>

						</tbody>
			        </table>
					<!-- 数据列表 over-->
				</div>
				<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->
		<!--首页面板-->
		<div class="home-air-panel" id="countyRanking">
			<div class="home-air-panel-header">
				<a href="#" target="" class="more fr">详情</a>
				<span class="title">
					<span class="icon iconcustom icon-liebiao" ></span>
					<span>区县AQI排名</span>
				</span>
				<span class="other">2019.01.01~2019.05.28</span>
			</div>
			<div class="home-air-panel-body">
				<!--面板主内容-->
				<div class="home-ranking-list">
				<!-- 数据列表-->
					<table id="countyRankingTable" class="easyui-datagrid" url=""
						   style="height:100%"
			               data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
			            <thead>
				            <tr>
				                <th align="center" field="type" width="80">排名</th>
				                <th align="center" field="value" width="150">监测站点</th>
				                <th align="center" field="AQI" width="100">目标水质</th>
				                <th align="center" field="AQI2" width="100">抽取水质</th>
				                <th align="center" field="AQI3" width="150">首要污染物</th>
				            </tr>
			            </thead>
			            <tbody>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">2</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">3</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">4</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">5</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">6</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">7</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">8</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">9</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">10</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">11</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">12</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">13</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>
							<tr>
								<td><span class="ranking">1</span></td>
								<td>南靖靖城桥</td>
								<td>5</td>
								<td>5</td>
								<td>5</td>
							</tr>

						</tbody>
			        </table>
					<!-- 数据列表 over-->
				</div>
				<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->

	</div>
	<!-- 中  over-->
	<div class="ca"></div>
</div>

<div id="monitorDlg" class="easyui-dialog" style="z-index: 10000;width:900px;background:#ADADAD;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
            <div title="监控列表" selected="true">
                <div class="panel-group-container">
                    <div class="panel-group-top">
                        <span id="pointName"></span>
                        <span class="subtext fr" id="monitorList">&emsp;<a target="view_window">监控列表</a></span>
                        <span class="subtext fr" id="monitorTime"></span>
                    </div>
                    <div class="panel-group-body">
                        <div class="panel-info" id="pointInfo">
                        </div>
                        <div class="panel-table">
                            <table class="table-info alone-table pdfview-table" id="pointTableInfo">
                                <thead>
                                    <tr>
                                        <td class="tit">序号</td>
                                        <td class="tit">数值</td>
                                        <td class="tit">监控名称</td>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--  大气详情弹窗  开始 -->
<div class="new-atmosphere-show video-details">
    <div class="center-box">
        <a class="atmosphere-close"><img src="${request.contextPath}/static/images/new-popup/gas-close.png"></a>

        <div class="data-info">

            <a class="return-tag ">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/gas-left-icon.png">
                <span>详情</span>
                <img src="${request.contextPath}/static/images/new-popup/gas-right-icon.png">
            </h3>
            <div class="title-head">
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="名称">名称:</label>
                    <input id="queryHNNM" name="HNNM" class="easyui-textbox" style="width: 200px;">
                </div>
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="地点">地点:</label>
                    <input id="queryHNNM" name="HNNM" class="easyui-textbox" style="width: 200px;">
                </div>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置查询条件</a>
            </div>
            <div class="details-table not-top">
                <table class="layui-hide" id="video-table">
				</table>
            </div>
        </div>
    </div>
</div>
<!--  大气详情弹窗 结束 -->

</body>
<script type="text/javascript" src="${request.contextPath}/static/camera/md5.js"></script>
<script src="${request.contextPath}/static/camera/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script src ="${request.contextPath}/static/camera/localMpv.js"></script>
<!-- 选择窗口时间 -->
<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    /**
     * 暂时使用延迟播放方式解决异步问题，以后还需要利用回调函数的方式进行优化
     */
    var cameraList = [];
    setTimeout(function(){
        getCameraList("");
    },10000);
    function getCameraList(searchInput){
        startPreview('10ea393c1de04b5c9b7e247cc99dbbe8', 0, 0);
        startPreview('a5a0218584444f10a4e2eaf24e8e7898', 0, 1);
        startPreview('9014453dd7e4488c851727c552e4f9ca', 0, 2);
        startPreview('21f63a6d131c4e589f6f46fc622bc638', 0, 3);

        return;

        $.ajax({
            type: "POST",
            url:  Ams.ctxPath + "/camera/localCameraController/getCameraList",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                searchInput: searchInput
            }),
            success: function(data){
                var cameraList = [];
                data.forEach(function(value,index){
                    //nodeType为3的节点数据才是监控摄像头
                    if('3'==value.nodeType){
                        cameraList.push(value);
                        if(windowIndex<5){
                            startPreview(value.id, playType, windowIndex);
                            windowIndex++;
                        }
                    }
                });
                //console.log(cameraList);
            }
        });
    }

    $("#cameraList").click(function(){
        cameraList.forEach(function(camera, index){
            var iconSkin = camera.iconSkin;
            var id = camera.id;
            var name = camera.name;
            var nodeType = camera.nodeType;
            var pId = camera.pId;

            var row = "<tr data-id='"+id+"'>\
                <td class='con'>" + index + "</td>\
                <td class='con' style =''>" + name + "</td>\
                <td class='con previewCamera' style =''>查看</td>\
            </tr>";
            var $row = $(row);
            $row.find(".previewCamera").click(function(){
                var id = $row.attr("data-id");
            });
            $("#pointTableInfo").find("tbody").append($row);
        });
    }


    function whichAnimationEvent(el){
        var t;
        var animations = {
          'animation':'animationend',
          'OAnimation':'oAnimationEnd',
          'MozAnimation':'animationend',
          'WebkitAnimation':'webkitAnimationEnd',
          'MsAnimation':'msAnimationEnd'
        }
        for(t in animations){
            if( el.style[t] !== undefined ){
                return animations[t];
            }
        }
    }
    //console.log(whichAnimationEvent());
    /* var animationEvent = whichAnimationEvent(el);
    animationEvent && e.addEventListener(animationEvent, function() {
    	console.log('Animation 完成!  原生JavaScript回调执行!');
    }); */
    $(function () {
    	/*切换大屏*/
        $(".btn-switch-tv").click(function(){
            var text=$(this).text();
            if(text==="TV"){
                $("body").removeClass("TV-screen-container");
                $(this).text("Web");

            }else{
                $("body").addClass("TV-screen-container");
                $(this).text("TV");
            }

        });

    	/*--------------------定时动画--------------------------*/
    	$("#monitoringDetails .ani").each(function(index){
    		var $t=$(this);
    		var el=$t.get(0);
    		var animationEvent=whichAnimationEvent(el);
    		animationEvent && el.addEventListener(animationEvent, function() {
    			$t.removeClass("ani-extrusion");
    	    });
    		setTimeout(function(){
				$t.addClass("ani-extrusion");
			},1000*index);
    		var myVar=setInterval(function(){
    			setTimeout(function(){
    				$t.addClass("ani-extrusion");
    			},1000*index);
    		},4000);
        });



    });

</script>

<script type="text/javascript">

    var viewNub = 7;// 大气弹窗 导航栏显示的个数
//    var swiperNub = $(".swiper-wrapper .swiper-slide").length;//  大气弹窗 获取导航栏 item  的个数
//    if(swiperNub>viewNub){
//        $(".more-tag").show()
//    }else{
//        $(".more-tag").hide()
//    }

    //大气头部 导航 点击切换样式
    $(".atmosphere-nav li a").click(function () {
        $(".atmosphere-nav li a").removeClass("nav-item-select")
        $(this).addClass("nav-item-select")
    })


    //小屏菜单栏
    $(".p-right .select-tag").click(function(){
        if( $(".atmosphere-nav").css("height")=="70px"){
            $(".atmosphere-nav").css("height","auto")
        }else{
            $(".atmosphere-nav").css("height","70px")
        }
    })

    // 详情弹窗
    $("#video-details").click(function () {
        $(".video-details").css("display","flex")
    })

	$(".atmosphere-close").click(function () {
        $(".video-details").css("display","none")
    })
    layui.use([ 'laypage', 'table'], function(){
        var laypage = layui.laypage //分页
             ,table = layui.table //表格
        table.render({
            elem: '#video-table'
            ,height: 420
            ,title: '用户表'
            ,cols: [[
                 {field:'id', width:150, title: '名称'}
                ,{field:'id2', width:150, title: '地点'}
                ,{field:'id3', width:150, title: '操作'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': 'rgb(14, 37, 51)', 'color': '#c4ecff'});
            }
            ,data: [{
                "id": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='play-link'>播放</a>"

            }, {
                "id": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='play-link'>播放</a>"
            }, {
                "id": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='play-link'>播放</a>"
            }]

        });

    })



    $(function () {
        /*---------------------------------天气--------------------------------------------------*/
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/getWeather',
            async: true,
            success: function (data) {
                var result = eval('(' + data + ')');
                var weather = result.results[0].weather_data[0];
                if (weather.date != null) {
                    $('#weatherDate').html(weather.date);
                } else {
                    $('#weatherDate').html("-");
                }
                if (weather.wind != null) {
                    $('#wind').html(weather.wind);
                } else {
                    $('#wind').html("-");
                }
                if (weather.weather != null) {
                    $('#weather').html(weather.weather);
                    $('#weatherIcon').removeClass();
                    $('#weatherIcon').addClass(Ams.weatherIcon(weather.weather));
                } else {
                    $('#weather').html("-");
                }
                if (weather.temperature != null) {
                    $('#temperature').html(weather.temperature);
                } else {
                    $('#temperature').html("-");
                }
            }
        });
    })


</script>
</html>