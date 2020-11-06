<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>大气环境-大数据</title>

</head>
<!-- body -->
<body class="TV-screen-container">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudAir.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<!-- Swiper CSS js -->
<style type="text/css">
    .panel-right{
		cursor:pointer;
	}
</style>
<!-- 头部 -->
<header class="home-air-header-container">
	<div class="header-logo"><h1 class="logo-text" style="letter-spacing: 3px;"> 漳州生态云 - 大气环境 <div class="btn-switch-tv">Web</div></h1></div>
	<div class="header-nav p-right">
        <a href="${request.contextPath}/index" class="open-link-tag" target="_blank">进入系统</a>
		<div class="atmosphere-box">
            <div class="atmosphere-nav">
				<ul>
					<li>  <a class="nav-item-a select-tag" href="javascript:void(0)">
                        <span class="title">大气环境</span>  <i class="icon iconcustom drop-icon"></i>
                    </a></li>
                    <li>
                        <a class="nav-item-a" href="${request.contextPath}/environment/waterDataShow">
                            <span class="title">水环境</span>
                        </a>
                    </li>
                    <li>
                        <a class="nav-item-a" href="${request.contextPath}/environment/main">
                            <span class="title">生态环境问题</span>
                        </a>
                    </li>
				</ul>


            </div>
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

<!-- 监控情况 -->
<div class="home-layout" id="monitoringDetails">
<!--首页面板-->
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shipinjiankong1" ></span>
				<span>监控情况</span>
			</span>
			<span class="other monitorTime">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-content row">
				<div class="grid-info" onclick="monitorDataClick(1)">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-jigou1"></span>
					</div>
					<div class="panel-right">
						<div>行政区</div>
						<div><span id="county">154</span></div>
					</div>
				</div>
				<div class="grid-info" onclick="monitorDataClick(2)" >
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-dianziweilan1"></span>
					</div>
					<div class="panel-right">
						<div>监测点</div>
						<div><span id="monitorPoint">681,367</span></div>
					</div>
				</div>
				<div class="grid-info" onclick="monitorDataClick(3)">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-wuranyuan1"></span>
					</div>
					<div class="panel-right">
						<div>废气排口</div>
						<div><span id="wasteGas">650,545</span></div>
					</div>
				</div>
				<div class="grid-info" onclick="monitorDataClick(4)">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-luzhang"></span>
					</div>
					<div class="panel-right">
						<div>工地</div>
						<div><span id="construction">154</span></div>
					</div>
				</div>
				<div class="grid-info" onclick="monitorDataClick(5)">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-gongchang2"></span>
					</div>
					<div class="panel-right">
						<div>工业废气企业</div>
						<div><span id="gasEnterprise">154</span></div>
					</div>
				</div>				
			</div>

			<!--面板主内容 over-->
		</div>
	</div>
	<!--首页面板 over-->
</div>
<!-- 监控情况  over-->

<!-- 左 -->
<div class="home-layout fl" id="home-left">
<!--首页面板-->
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>年目标管理</span>
			</span>
			<span class="other monitorTime">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<a href="javascript:void(0)" target="" class="more fr atmosphere-open">详情</a>
					<span class="title">
						<span>2019年全年六项指标</span>
					</span>					
				</div>			
				<div class="row" id="yearSixIndicators">
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 green">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">二氧化氮</div>
									<div class="value" id="ysi-no2">23</div>
									<div class="name" id="ysi-no2-rate">20%</div>
								</div>						
							</div>						
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 blue">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">臭氧</div>
									<div class="value" id="ysi-o3">23</div>
									<div class="name up" id="ysi-o3-rate">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 yellow">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">PM10</div>
									<div class="value" id="ysi-pm10">23</div>
									<div class="name up" id="ysi-pm10-rate">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 orange">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">PM2.5</div>
									<div class="value" id="ysi-pm25">23</div>
									<div class="name down" id="ysi-pm25-rate">20%</div>
								</div>						
							</div>						
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 red">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">二氧化硫</div>
									<div class="value" id="ysi-so2">23</div>
									<div class="name up" id="ysi-so2-rate">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 purple" id="color-">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">一氧化碳</div>
									<div class="value" id="ysi-co">23</div>
									<div class="name up" id="ysi-co-rate">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
				</div>				
			</div>
			<!--  -->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="javascript:void(0)" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>首要污染物</span>
					</span>					
				</div>			
				<div class="row" id="primaryPollutants">
					<div class="col-xs-12">
						<div class="home-border-panel air-yellow">
				        	<div class="home-border-panel-bg">
				        		<div class="bg-top-left"></div>
				        		<div class="bg-top-center"></div>
				        		<div class="bg-top-right"></div>
				        		<div class="bg-center-left"></div>
				        		<div class="bg-center-center"></div>
				        		<div class="bg-center-right"></div>
				        		<div class="bg-bottom-right"></div>
				        		<div class="bg-bottom-center"></div>
				        		<div class="bg-bottom-left"></div>
				        	</div>
				            <div class="home-border-panel-body">				            
								<div class="target-text-box">
									<div class="target-text">
										<div id="pollute">二氧化氮</div>
									</div>						
								</div>		
				            </div>
				        </div>			
					</div>
				</div>				
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
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>2019年全年空气质量</span>
			</span>
			<span class="other monitorTime">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body" id="airQuality">
			<!--面板主内容-->
			<div class="box-body">				
				<div class="box-title" id="titleQuelity">本市空气质量优良天数138，优良率97.87%</div>
				<div class="box-top">
					<!-- <a href="javascript:void(0)" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>2019年全年空气质量差</span>
					</span>					
				</div>
				<div class="row">
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 red">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">1</div>
									<div class="name" id="poolOne">龙文区</div>
								</div>						
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 orange">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">2</div>
									<div class="name" id="poolTwo">芗城区</div>
								</div>						
							</div>							
						</div>						
					</div>					
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 yellow">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">3</div>
									<div class="name" id="poolThree">龙海市</div>
								</div>						
							</div>							
						</div>						
					</div>
				</div>				
			</div>
			<!--面板主内容 over-->
			
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="javascript:void(0)" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>2019年全年空气质量优</span>
					</span>					
				</div>			
				<div class="row">
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 green">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">1</div>
									<div class="name" id="goodOne">龙海市</div>
								</div>						
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 blue">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">2</div>
									<div class="name" id="goodTwo">龙海市</div>
								</div>						
							</div>						
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 yellow">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="value">3</div>
									<div class="name" id="goodThree">龙海市</div>
								</div>						
							</div>							
						</div>						
					</div>
				</div>				
			</div>
			<!--面板主内容 over-->
			
		</div>
	</div>
	<!--首页面板 over-->
	
	
</div>
<!-- 右  over-->
<!-- 中 -->
<div class="home-layout oh" id="home-center">
<!--首页面板-->
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>六项指标考核目标</span>
			</span>
            <span class="select-box">
				<select>
					<option value="0">国控</option>
					<option value="1">省控</option>
				</select>
			</span>
			<span class="other monitorTime">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body row" id="sixIndicators">
				<div class="col-xs-4">
					<div id="AQILiquidfill" style="width: 100%;height: 220px;"></div>
				</div>
				<div class="col-xs-8" id="remark">
					<div class="air-text-box" style="width: 100%;height: 220px;">
						<div class="air-text">
							<div class="title">空气质量考核目标</div>
							<div class="name">
								<div id="quelityStandard">97.80 已达标</div>
								<div id="surplusDays">所剩考核还有38天</div>
							</div>
						</div>						
					</div>					
				</div>
				<div id="6yz">
				</div>
				<!-- <div class="col-xs-6">
					<div class="sub-title">
						<span class="completed" id="standard-no2">已完成</span>
						<span>目标：二氧化氮</span>
					</div>				
					<div class="sub-title">完成情况：NO2</div>				
					<div class="chart-box" id="pictorialBarChart"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete" id="standard-o3">已完成</span>
						<span>目标：臭氧</span>
					</div>				
					<div class="sub-title">完成情况：O3</div>				
					<div class="chart-box" id="pictorialBarChart2"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="completed" id="standard-pm10">已完成</span>
						<span>目标：PM10</span>
					</div>				
					<div class="sub-title">完成情况：PM10</div>				
					<div class="chart-box" id="pictorialBarChart3"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete" id="standard-pm25">已完成</span>
						<span>目标：PM2.5</span>
					</div>				
					<div class="sub-title">完成情况：PM2.5</div>				
					<div class="chart-box" id="pictorialBarChart4"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="completed" id="standard-so2">已完成</span>
						<span>目标：二氧化硫</span>
					</div>				
					<div class="sub-title">完成情况：SO2</div>				
					<div class="chart-box" id="pictorialBarChart5"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete" id="standard-co">已完成</span>
						<span>目标：一氧化碳</span>
					</div>				
					<div class="sub-title">完成情况：CO</div>				
					<div class="chart-box" id="pictorialBarChart6"></div>
				</div> -->
			</div>
			<!--面板主内容 over-->
			
		</div>
	</div>
	<!--首页面板 over-->
	
	
</div>
<!-- 中  over-->
<div class="ca"></div>
<!-- 日目标管理 -->
<div class="home-layout" id="targetManage">
<!--首页面板-->
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>日目标管理</span>
			</span>
			<span class="other" id="day-time">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body box-content target-manage-list" id="monitorData">
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">AQI</div>
									<div class="name" id="day-aqi">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">PM10 剩余浓度</div>
									<div class="name" id="day-pm10">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">PM2.5 剩余浓度</div>
									<div class="name" id="day-pm25">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">SO2 剩余浓度</div>
									<div class="name" id="day-so2">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">NO2 剩余浓度 </div>
									<div class="name" id="day-no2">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">CO 剩余浓度</div>
									<div class="name" id="day-co">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-green">
			        	<div class="home-border-panel-bg">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			        	<div class="home-border-panel-bg active ani">
			        		<div class="bg-top-left"></div>
			        		<div class="bg-top-center"></div>
			        		<div class="bg-top-right"></div>
			        		<div class="bg-center-left"></div>
			        		<div class="bg-center-center"></div>
			        		<div class="bg-center-right"></div>
			        		<div class="bg-bottom-right"></div>
			        		<div class="bg-bottom-center"></div>
			        		<div class="bg-bottom-left"></div>
			        	</div>
			            <div class="home-border-panel-body">				            
							<div class="target-text-box">
								<div class="target-text">
									<div class="area">O3 剩余浓度</div>
									<div class="name" id="day-o3">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				
			</div>

			<!--面板主内容 over-->
		</div>
	</div>
	<!--首页面板 over-->
</div>
<!-- 日目标管理  over-->

</div>
<!--  大气弹窗  开始 -->
<div class="new-atmosphere-show max-atmosphere-box">
    <div class="center-box">
        <a class="atmosphere-close"><img src="${request.contextPath}/static/images/new-popup/gas-close.png"></a>
        <div class="data-info">
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/gas-left-icon.png">
                <span>大气指数详情</span>
                <img src="${request.contextPath}/static/images/new-popup/gas-right-icon.png">
            </h3>
            <div class="option-box">
            	<!-- <a class="select-tag"><input type="hidden" value="350600"/>漳州市区（7）</a> -->
                <a class="select-tag"><input type="hidden" value="350602"/>漳州市-芗城区（4）</a>
                <a><input type="hidden" value="350603"/>漳州市-龙文区（3）</a>
                <a><input type="hidden" value="350681"/>龙海市（3）</a>
                <a><input type="hidden" value="350622"/>云霄县（2）</a>
                <a><input type="hidden" value="350629"/>华安县（2）</a>
                <a><input type="hidden" value="350627"/>南靖县（2）</a>
                <a><input type="hidden" value="350626"/>东山县（2）</a>
                <a><input type="hidden" value="350628"/>平和县（2）</a>
                <a><input type="hidden" value="350623"/>漳浦县（2）</a>
                <a><input type="hidden" value="350624"/>诏安县（2）</a>
                <a><input type="hidden" value="350625"/>长泰县（2）</a>

                <!--<span class="more-tag"><img src="images/more-icon.png"></span>-->

                <!--<div class="swiper-button-prev"></div>-->
                <!--<div class="swiper-button-next  more-tag"></div>-->
            </div>
            <div class="option-list">
                <a class="select-tag" id="standard">达标大气（3）</a>  <a id="unstandard">达标大气（3）</a>
            </div>
            <div class="list-data" id="addDetail" style="">
                <div class="item">
                    <h5>
                        <span>县前直街 <label>截止2019年05月23日</label></span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <table>
                            <tr class="select-row">
                                <td><span>PM2.5：55</span></td>
                                <td><span>不达标，超标10微克/立方米</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化碳：20</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>一氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="list-data" id="addUnStandard" style="display:none;">
                <div class="item">
                    <h5>
                        <span>县前直街 <label>截止2019年05月23日</label></span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <table>
                            <tr class="select-row">
                                <td><span>PM2.5：55</span></td>
                                <td><span>不达标，超标10微克/立方米</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化碳：20</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>一氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr>
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  大气弹窗 结束 -->

<!--  大气详情弹窗  开始 -->
<div class="new-atmosphere-show details-atmosphere">
    <div class="center-box">
        <a class="atmosphere-close"><img src="${request.contextPath}/static/images/new-popup/gas-close.png"></a>
        <div class="data-info">
            <a class="return-tag  ">
                <span class="icon iconcustom"></span>
            </a>
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/gas-left-icon.png">
                <span id="pointName">市区龙文区 - 县前直街详情</span>
                <img src="${request.contextPath}/static/images/new-popup/gas-right-icon.png">
            </h3>
			<div class="details-table">
                <table id="water-table" lay-filter="test" class="layui-hide">

				</table>
			</div>
        </div>
    </div>
</div>
<!--  大气详情弹窗 结束 -->

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">  

    //60秒钟之后跳转到指定的页面
    //window.setTimeout('window.location.href="${request.contextPath}/environment/waterDataShow"', 60000); 
    
	var date=new Date;
	var year=date.getFullYear(); 
	var month=date.getMonth()+1;
	if(month<=10){
		month = "0"+month;
	}
	var startTime = year+"-01";
	var endTime = year+"-"+month;

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var placeHolderStyle = {
        normal: {
            color: '#f2f2f2'
        },
        emphasis: {
            color: '#f2f2f2'
        }
    };
    var labelSetting = {
   	    normal: {
   	        show: true,
   	     	position: 'left',
   	        offset: [-10, 0],
   	        textStyle: {
   	            fontSize: 16,
   	            color:'auto'
   	        },formatter:'{c}%'
   	    }
   	};
    var fullBgBar = {
        name:"full_bg",
        type: 'pictorialBar',
        itemStyle: {
            normal: {
                color: '#fff',
                opacity:0.15
            }
        },
        barWidth:'100%',
        symbol: 'rect',
        symbolSize: [2,'100%'],
        symbolMargin:'150%',
        symbolRepeat: true,
        silent: true,
        barGap: '-100%', // Make series be overlap
        data: [100],
        zlevel:-1

    };
    var pictorialBarGrid={
            top:'10',
            left: '80',
            right: '20',
            bottom: '10',
            containLabel: true
    };
    var pictorialBarYAxis={
        data: ['reindeer'],
        inverse: true,
        axisLine: {show: false},
        axisTick: {show: false},
        axisLabel:{show: false},
        axisPointer: {show: false}
    };
    var pictorialBarXAxis={
        splitLine: {show: false},
        axisLabel: {show: false},
        axisTick: {show: false},
        axisLine: {show: false}
    };	
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
    $(function () {
    	/*--------------------定时动画--------------------------*/
    	$("#targetManage .ani").each(function(index){
    		var $t=$(this);
    		var el=$t.get(0);
    		var animationEvent=whichAnimationEvent(el);
    		animationEvent && el.addEventListener(animationEvent, function() {
    			$t.removeClass("ani-flash1");    			
    	    });
    		setTimeout(function(){
				$t.addClass("ani-flash1");
			},1000*index);
    		var myVar=setInterval(function(){
    			setTimeout(function(){
    				$t.addClass("ani-flash1");
    			},1000*index);
    		},8000);
        });
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
    		},6000);
        });
    	//var dayNum  = date.getDate()-1;
    	var day1 = new Date();
    	day1.setTime(day1.getTime()-24*60*60*1000);
    	 
		$('.monitorTime').html(year+".01"+".01"+" ~ "+year+"."+(day1.getMonth()+1)+"."+day1.getDate());
    	/*---------------------------------天气--------------------------------------------------*/
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/getWeather',
            async:true,
            success: function (data) {
            	var result = eval('(' + data + ')');
            	var weather = result.results[0].weather_data[0];
            	if(weather.date!=null){
	            	$('#weatherDate').html(weather.date);
            	}else{
            		$('#weatherDate').html("-");
            	}
            	if(weather.wind!=null){
	            	$('#wind').html(weather.wind);
            	}else{
            		$('#wind').html("-");
            	}
            	if(weather.weather!=null){
	            	$('#weather').html(weather.weather);
					$('#weatherIcon').removeClass();
					$('#weatherIcon').addClass(Ams.weatherIcon(weather.weather));
            	}else{
            		$('#weather').html("-");
            	}
            	if(weather.temperature!=null){
	            	$('#temperature').html(weather.temperature);
            	}else{
            		$('#temperature').html("-");
            	}
            }
		});
    	/*---------------------------------监控情况--------------------------------------------------*/
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/getMonitoringData',
            async:true,
            success: function (data) {
	            if(data.工地!=null){
					$('#construction').html(data.工地);
				}else{
					$('#construction').html("-");
				}
	            if(data.废气排口!=null){
					$('#wasteGas').html(data.废气排口);
				}else{
					$('#wasteGas').html("-");
				}
	            if(data.污普废气排口!=null){
					$('#gasEnterprise').html(data.污普废气排口);
				}else{
					$('#gasEnterprise').html("-");
				}
	            if(data.监测点!=null){
					$('#monitorPoint').html(data.监测点);
				}else{
					$('#monitorPoint').html("-");
				}
	            if(data.行政区!=null){
					$('#county').html(data.行政区);
				}else{
					$('#county').html("-");
				}
            }
		});
    	
    	getSixIndicatrixByYear();
    	
    	/*---------------------------------年目标管理--------------------------------------------------*/
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTB',
            data:{
            	startTime : year+"-01",
            	endTime : year+"-"+month,
            },
            async:true,
            success: function (data) {
            	console.info(data)
            	var codeValue = data[1];
            	var rate = data[3];
            	var color = data[4];
            	var html = "";
            	$("#yearSixIndicators").html("");
            	var codeAry = new Array("CO","NO2","SO2","O3","PM10","PM25");
            	var nameAry = new Array("一氧化碳","二氧化氮","二氧化硫","臭氧","PM10","PM2.5");
            	for(var i=0;i<codeAry.length;i++){
            		var status = "";
            		var rateValue = rate[codeAry[i]];
            		if(rateValue.indexOf("-")>-1){
            			status = "down";
            		}else if(rateValue != "0.0%"){
            			status = "up";
            		}
            		html += '<div class="col-xs-4"><div class="basin-name-container circle-1 '+color[codeAry[i]]+'">'
            			+'<div class="basin-bg"><div class="bg-img bg-1"></div><div class="bg-img bg-2 ani '
            			+'ani-clockwiseRotate linear infinite duration5"></div></div><div class="basin-text-box">'
            			+'<div class="basin-text"><div class="area">'+nameAry[i]+'</div><div class="value">'
            			+codeValue[codeAry[i]]+'</div><div class="name '+status+'">'+rateValue+'</div></div></div></div></div>';
            	}
            	$("#yearSixIndicators").html(html);
            }
		});
    	
    	/*---------------------------------全年空气质量--------------------------------------------------*/
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/AirQualityByYear/getAirYearOnYearAnalysis',
            async:true,
            data:{
            	startTime : year+"-01",
            	endTime : year+"-"+month,
            	export : "no"
            },
            success: function (data) {
            	var result = eval('(' + data + ')');
            	var poolOne=result[0].pointName;
            	var poolTwo=result[1].pointName;
            	var poolThree=result[2].pointName;
            	var goodOne=result[3].pointName;
            	var goodTwo=result[4].pointName;
            	var goodThree=result[5].pointName;
            	if(poolOne!=null){
            		$('#poolOne').html(poolOne);
            		$('#poolOne').click(function(){
						clickDiastrict(poolOne);
					});
            	}else{
            		$('#poolOne').html("-");
            	}
            	if(poolTwo!=null){
            		$('#poolTwo').html(poolTwo);
					$('#poolTwo').click(function(){
						clickDiastrict(poolTwov);
					});
            	}else{
            		$('#poolTwo').html("-");
            	}
            	if(poolThree!=null){
            		$('#poolThree').html(poolThree);
					$('#poolThree').click(function(){
						clickDiastrict(poolThree);
					});
            	}else{
            		$('#poolThree').html("-");
            	}
            	if(goodOne!=null){
            		$('#goodOne').html(goodOne);
					$('#goodOne').click(function(){
						clickDiastrict(goodOne);
					});
            	}else{
            		$('#goodOne').html("-");
            	}
            	if(goodTwo!=null){
            		$('#goodTwo').html(goodTwo);
					$('#goodTwo').click(function(){
						clickDiastrict(goodTwo);
					});
            	}else{
            		$('#goodTwo').html("-");
            	}
            	if(goodThree!=null){
            		$('#goodThree').html(goodThree);
					$('#goodThree').click(function(){
						clickDiastrict(goodThree);
					});
            	}else{
            		$('#goodThree').html("-");
            	}
            }
    	});
    	
    	/*-----------------------------大气指数详情------------------------------------*/
    	detail_two('350602');
    	/*-----------------------------日管理------------------------------------*/
    	showAirTodayInfo();
    });
	

    var viewNub = 7;// 大气弹窗 导航栏显示的个数
    var swiperNub = $(".swiper-wrapper .swiper-slide").length;//  大气弹窗 获取导航栏 item  的个数
    if(swiperNub>viewNub){
        $(".more-tag").show();
    }else{
        $(".more-tag").hide();
    }

    //大气头部 导航 点击切换样式
    $(".atmosphere-nav  a").click(function () {
        $(".atmosphere-nav a").removeClass("select-tag ");
        $(this).addClass("select-tag ");
    })

    $(".atmosphere-open").click(function () {
    	$(".max-atmosphere-box").css("display","flex");
        //切换
//        var swiper = new Swiper('.swiper-container', {
//            slidesPerView: viewNub,
//            pagination: {
//                el: '.swiper-pagination',
//                clickable: true,
//            },
//            navigation: {
//                nextEl: '.swiper-button-next',
//                prevEl: '.swiper-button-prev',
//            },
//        });
    });
    $(".return-tag").click(function () {
		$(".details-atmosphere").hide()
        $(".max-atmosphere-box").css("display","flex")
    })

    // 大气弹窗关闭
    $(".atmosphere-close").click(function () {
        $(".new-atmosphere-show").css("display","none")
    });

    // 大气弹窗 导航栏点击切换样式
    $(".option-box a").click(function () {
        $(".option-box a").removeClass("select-tag");
        $(this).addClass("select-tag");
        var point=$(this).find('input').val();//$(" input").val();

    	$('#addDetail').html("");
    	$('#addUnStandard').html("");
		/*-----------------------------大气指数详情------------------------------------*/
    	detail_two(point);
    });

    // 大气弹窗 二级导航点击切换样式
    $(".option-list a").click(function () {
        $(".option-list a").removeClass("select-tag");
        $(this).addClass("select-tag");
        if($('#standard').attr("class") == "select-tag"){
        	$('#addUnStandard').hide();
        	$('#addDetail').show();
        }
        if($('#unstandard').attr("class") == "select-tag"){
        	$('#addUnStandard').show();
        	$('#addDetail').hide();
        }
    });
    //小屏菜单栏
    $(".p-right .select-tag").click(function(){

        if( $(".atmosphere-nav").is('.select')){
			$(".atmosphere-nav").removeClass("select")
			$(".atmosphere-nav").css("height","60px")
		}else{
			$(".atmosphere-nav").addClass("select")
            $(".atmosphere-nav").css("height","auto")
		}
    })
    
    layui.use(['layer','element','table'], function(){ //添加layui模块：弹出层、tab选项卡、数据表格
        var layer = layui.layer
                ,element = layui.element
                ,table = layui.table;
        //数据表格
        table.render({
            elem: '#water-table',
            theme: '#0f61b5',
            loading:false,
            url: Ams.ctxPath + '/environment/hugeData/sixIndicatrixByC_M',
            cols: [[
                {field:'TIME', title: '监测时间',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'PointName', title: '监测站点',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'AQI', title: 'AQI',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'PM25',  title: 'PM2.5(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'PM10', title: 'PM10(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'NO2', title: 'NO2(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'SO2', title: 'SO2(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'O3',  title: 'O3(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'CO',  title: 'CO(mg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}

            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': 'rgb(14, 37, 51)', 'color': '#c4ecff'});
            }
        	,id: 'testReload'
        });
        
        window.openDetail = function(pointCode,pointName){
        	$(".max-atmosphere-box").css("display","none");
            $(".details-atmosphere").css("display","flex");
            $("#pointName").html(pointName+"详情");
        	table.reload('testReload', {
        		where: {
                    'CountyCode': pointCode
                }
            });
            table.resize("water-table")
        }
        
    });
    
    function detail_two(point){
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/sixIndicatrixByCounty',
            async:true,
            data:{
            	CountyCode : point
            },
            success: function (result) {
            	console.info(result)
            	var html = "";
            	var data = result.standard;
            	var undata = result.unstandard;
            	$('#standard').html("达标大气（"+data.length+"）");
            	$('#unstandard').html("不达标大气（"+undata.length+"）");
            	for(var i=0;i<data.length;i++){
            		var value = data[i].data;
            		html +='<div class="item"><h5><span>'+data[i].PonitName+' <label>截止'+year+'年'+month+'月'+date.getDate()+'日</label></span>'
            			+'<a onclick="openDetail(\''+data[i].PonitCode+'\',\''+data[i].PonitName+'\')">详情</a>'
            			+'</h5><div class="item-info"><table><tr><td><span>二氧化氮：'+value.NO2+'</span></td><td><span>'+data[i].PM25+'</span>'
            			+'</td></tr><tr><td><span>臭氧：'+value.O3+'</span></td><td><span>'+data[i].O3+'</span></td></tr>'
            			+'<tr><td><span>PM10：'+value.PM10+'</span></td><td><span>'+data[i].PM10+'</span></td></tr>'
            			+'<tr><td><span>PM2.5：'+value.PM25+'</span></td><td><span>'+data[i].PM25+'</span></td></tr>'
            			+'<tr><td><span>二氧化硫：'+value.SO2+'</span></td><td><span>'+data[i].SO2+'</span></td></tr>'
            			+'<tr><td><span>一氧化碳：'+value.CO+'</span></td><td><span>'+data[i].CO+'</span></td></tr></table></div></div>';
            	}
            	$('#addDetail').html(html);
            	var unhtml="";
            	for(var i=0;i<undata.length;i++){
            		var value = undata[i].data;
            		var no2 = "";
            		if(undata[i].NO2!="达标"){
            			no2 = ' class="select-row"';
            		}
            		var co = "";
            		if(undata[i].CO!="达标"){
            			co = ' class="select-row"';
            		}
            		var so2 = "";
            		if(undata[i].SO2!="达标"){
            			so2 = ' class="select-row"';
            		}
            		var o3 = "";
            		if(undata[i].O3!="达标"){
            			o3 = ' class="select-row"';
            		}
            		var pm10 = "";
            		if(undata[i].PM10!="达标"){
            			pm10 = ' class="select-row"';
            		}
            		var pm25 = "";
            		if(undata[i].PM25!="达标"){
            			pm25 = ' class="select-row"';
            		}
            		
            		unhtml +='<div class="item"><h5><span>'+undata[i].PonitName+' <label>截止'+year+'年'+month+'月'+date.getDate()+'日</label></span>'
            			+'<a onclick="openDetail(\''+data[i].PonitCode+'\',\''+data[i].PonitName+'\')">详情</a>'
            			+'</h5><div class="item-info"><table><tr'+no2+'><td><span>二氧化氮：'+value.NO2+'</span></td><td><span>'+undata[i].PM25+'</span>'
            			+'</td></tr><tr'+o3+'><td><span>臭氧：'+value.O3+'</span></td><td><span>'+undata[i].O3+'</span></td></tr>'
            			+'<tr'+pm10+'><td><span>PM10：'+value.PM10+'</span></td><td><span>'+undata[i].PM10+'</span></td></tr>'
            			+'<tr'+pm25+'><td><span>PM2.5：'+value.PM25+'</span></td><td><span>'+undata[i].PM25+'</span></td></tr>'
            			+'<tr'+so2+'><td><span>二氧化硫：'+value.SO2+'</span></td><td><span>'+undata[i].SO2+'</span></td></tr>'
            			+'<tr'+co+'><td><span>一氧化碳：'+value.CO+'</span></td><td><span>'+undata[i].CO+'</span></td></tr></table></div></div>';
            	}
            	$('#addUnStandard').html(unhtml);
            }
        });
    }
    
    function showAirTodayInfo(){
    	var  time = date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
    	$.ajax({
			type: "post",
			url:  Ams.ctxPath + "/environment/hugeData/getAirQuantity",
			data : {
            	pointCode :'350600'
			},
			dataType: "json",
			success: function(result){
				//$('#day-time').html(year+"-"+month+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds());
				$('#day-time').html(result.time);
				console.info(result.color)
				/*------------------------水球-AQI----------------------------*/
		        var AQILiquidfill = echarts.init(document.getElementById('AQILiquidfill'));
		        var AQILiquidfillOption = {        		
		            series: {
		                name: 'AQI指数',
		                type: 'liquidFill',
						center:['50%', '50%'],
		                data: result.aqi,
		                radius: '70%',
		                color: [result.color],
		                itemStyle: {
		                    opacity: 1,
		                    shadowBlur: 0
		                },emphasis: {
		                    itemStyle: {
		                        opacity: 0.9
		                    }
		                },
		                label: {
		                	formatter: function(param) {
		                        var text=result.status;
		                        var str='{t|AQI}\n{p|'+ Math.round(param.value*100) + '}\n{t|'+text+'}';
		                        return str;
		                    },
		                    color: '#404040',
		                    fontWeight:'normal',
		                    rich: {
		                        p: {
		                            fontSize: 36,
		                            padding:[3,0,9,0]
		            
		                        },
		                        t: {
		                            fontSize: 20
		                        }
		                    }
		                },
		                backgroundStyle: {
		                    color: 'rgba(255,255,255,0.75)',
		                    shadowColor: 'rgba(0,0,0,0.2)',
		                    shadowBlur: 6,
		                    shadowOffsetX: 6,
		                    shadowOffsetY: 6
		                },
		                outline: {
		                    show: false                        
		                }

		            }
		        };
		        AQILiquidfill.setOption(AQILiquidfillOption);
				var data = result.list;
				var html = "";
				for(var i=0;i<data.length;i++){
					html += '<div class="item"><div class="home-border-panel '+data[i].color+'"><div class="home-border-panel-bg">'
						+'<div class="bg-top-left"></div><div class="bg-top-center"></div><div class="bg-top-right">'
						+'</div><div class="bg-center-left"></div><div class="bg-center-center"></div><div class="bg-center-right">'
						+'</div><div class="bg-bottom-right"></div><div class="bg-bottom-center"></div><div class="bg-bottom-left">'
						+'</div></div><div class="home-border-panel-bg active ani ani-flash duration2 linear infinite"><div class="bg-top-left">'
						+'</div><div class="bg-top-center"></div><div class="bg-top-right"></div><div class="bg-center-left"></div>'
						+'<div class="bg-center-center"></div><div class="bg-center-right"></div><div class="bg-bottom-right"></div>'
						+'<div class="bg-bottom-center"></div><div class="bg-bottom-left"></div></div><div class="home-border-panel-body">'
						+'<div class="target-text-box"><div class="target-text"><div class="area">'+data[i].name+'</div><div class="name">'
						+data[i].value+'</div></div></div></div></div></div>';
				}
				$('#monitorData').html(html);
			},
			error: function(r){console.log(r);}
		});
    }

    $('.select-box').on('change',function(data) {
        getSixIndicatrixByYear();
    });
    function getSixIndicatrixByYear(){
        var category = $('.select-box').find("option:selected")[0].value;
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/sixIndicatrixByYear',
            async:true,
            data:{category : category},
            success: function (data) {
                console.info(data)
                /* var rate = data.rate;
                var factoty = data.factory;
                var all = data.all;
                var html = "";
                $("#yearSixIndicators").html("");
                for(var i=0;i<all.length;i++){
                    var status = '';
                    var rate = all[i].rate;
                    if(rate<0){
                        status = "down";
                        rate = -1*Math.round(rate*100)+"%";
                    }else{
                        status = "up";
                        rate = Math.round(rate*100)+"%";
                    }
                    html += '<div class="col-xs-4"><div class="basin-name-container circle-1 '+all[i].color+'">'
                        +'<div class="basin-bg"><div class="bg-img bg-1"></div><div class="bg-img bg-2 ani '
                        +'ani-clockwiseRotate linear infinite duration5"></div></div><div class="basin-text-box">'
                        +'<div class="basin-text"><div class="area">'+all[i].chzName+'</div><div class="value">'
                        +all[i].value+'</div><div class="name '+status+'">'+rate+'</div></div></div></div></div>';
                }
                $("#yearSixIndicators").html(html); */
                $('#pollute').html(data.pollute);
                var standard = data.standard;
                var index = data.index;
                /*---------------------------------全年空气质量-----------------------------------------*/
                var target = data.target;
                var targetHtml = "";
                $("#6yz").html(targetHtml);
                for(var i=0;i<target.length;i++){
                    var class_ = 'class="completed"';
                    if(target[i].remark!='已完成'){
                        var class_ = 'class="incomplete"';
                    }
                    targetHtml += '<div class="col-xs-6"><div class="sub-title"><span '+class_+'>'
                        +target[i].remark+'</span><span>目标：'+target[i].chzName+'：'+target[i].index+'</span></div>'
                        +'<div class="sub-title">完成情况：'+target[i].name+'：'+target[i].value+' '
                        +target[i].unit+'</div><div class="chart-box" id="pictorialBarChart'+i+'"></div></div>';
                }
                $("#6yz").html(targetHtml);
                for(var i=0;i<target.length;i++){
                    var pictorialBarChart = echarts.init(document.getElementById('pictorialBarChart'+i));
                    var pictorialBarOption ={
                        grid: pictorialBarGrid,
                        yAxis: pictorialBarYAxis,
                        xAxis: pictorialBarXAxis,
                        series: [
                            {
                                name: '国考断面-目标',
                                type: 'pictorialBar',
                                barGap: 0,
                                label:labelSetting,
                                barWidth:'100%',
                                symbol: 'rect',
                                symbolSize: [2,'100%'],
                                symbolMargin:'150%',
                                symbolRepeat: true,
                                itemStyle:{
                                    normal:{
                                        color:target[i].color,
                                    }
                                },
                                data: target[i].rate
                            },fullBgBar
                        ],
                    };
                    pictorialBarChart.setOption(pictorialBarOption);
                }
            }
        });
        
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/airComplianceRate/list2',
            async:true,
            data:{
                startTime : year+"-01",
                endTime : year+"-"+month,
                category : category
            },
            success: function (data) {
                var result = eval('(' + data + ')');
                console.info(result)
                $('#quelityStandard').html("-");
                if(result!=null){
                    $('#quelityStandard').html(result[0].standard+" 已达标");
                    if(category==0){
                        $('#titleQuelity').html("本市空气质量优良天数"+result[0].goodDay+"，优良率"+result[0].standard);
                    }
                }
                $('#surplusDays').html("比去年同期污染天数减少16天。<br />为达到考核目标超标天数应控制在"+ result[0].surplusDays +"天内");
            }
        });
        
    }
    
    /*切换大屏*/
    $(".btn-switch-tv").click(function(){
        var text=$(this).text();
        if(text==="Web"){
            $("body").removeClass("TV-screen-container");
            $(this).text("TV");
        }else{
            $("body").addClass("TV-screen-container");
            $(this).text("Web");
        }
    });
//年数据大屏展示中点击大气中的监控情况进入1行政区,2测点,3废气排口,4工地,5工业废气企业

function monitorDataClick(target){//监测站点跳转
	window.open("/enviromonit/airEnvironment?pid=7c4eb149-2475-4cad-97c9-e4760938de3f&target="+target)
}
function clickDiastrict(pointName){//点击行政区跳转
	window.open(encodeURI("/enviromonit/airEnvironment?pid=7c4eb149-2475-4cad-97c9-e4760938de3f&pointName="+pointName))
}

</script>
</html>