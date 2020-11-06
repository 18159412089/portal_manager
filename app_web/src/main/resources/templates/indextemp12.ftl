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
<!-- Swiper CSS js -->
<#--<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">-->
<#--<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>-->

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<style type="text/css">
    
</style>
<!-- 头部 -->
<header class="home-air-header-container">
	<div class="header-logo">
		<h1 class="logo-text" style="letter-spacing: 3px;">
			漳州生态云
			<div class="btn-switch-tv">TV</div>
		</h1>
	</div>
	<div class="header-nav p-right">
        <div class="atmosphere-nav">
            <a class="nav-item-a select-tag" href="${request.contextPath}/environment/hugeData">
                <span class="title">大气环境</span>
            </a>
            <a class="nav-item-a" href="${request.contextPath}/environment/waterDataShow">
                <span class="title">水环境</span>
            </a>
            <a class="nav-item-a" href="${request.contextPath}/main">
                <span class="title">生态环境问题</span>
            </a>
        </div>
    </div>
    <div class="header-other p-left">
        <span id="weatherDate">2018年9月20日</span>
        <span class="icon iconcustom icon-zhire"></span>
        <span id="weather">多云  北风1~2级</span>
        <span id="wind">多云  北风1~2级</span>
        <span id="temperature">多云  北风1~2级</span>
        <a href="${request.contextPath}/index" class="open-link-tag" target="_blank">进入系统</a>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-air-container">

<!-- 监控情况 -->
<div class="home-layout" id="monitoringDetails">
<!--首页面板-->
	<div class="home-air-panel">
		<div class="home-air-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shipinjiankong1" ></span>
				<span>监控情况</span>
			</span>
			<span class="other" style="display: none">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-content row">
				<div class="grid-info">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-jigou1"></span>
					</div>
					<div class="panel-right">
						<div>行政区</div>
						<div><span>154</span></div>
					</div>
				</div>
				<div class="grid-info">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-dianziweilan1"></span>
					</div>
					<div class="panel-right">
						<div>测点</div>
						<div><span>681,367</span></div>
					</div>
				</div>
				<div class="grid-info">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-wuranyuan1"></span>
					</div>
					<div class="panel-right">
						<div>废气排口</div>
						<div><span>650,545</span></div>
					</div>
				</div>
				<div class="grid-info">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-luzhang"></span>
					</div>
					<div class="panel-right">
						<div>工地</div>
						<div><span>154</span></div>
					</div>
				</div>
				<div class="grid-info">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-gongchang2"></span>
					</div>
					<div class="panel-right">
						<div>污普废气企业</div>
						<div><span>154</span></div>
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
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>年目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<a href="#" target="" class="more fr atmosphere-open">详情</a>
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
									<div class="value">23</div>
									<div class="name down">20%</div>
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
									<div class="value">23</div>
									<div class="name up">20%</div>
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
									<div class="value">23</div>
									<div class="name up">20%</div>
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
									<div class="value">23</div>
									<div class="name down">20%</div>
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
									<div class="value">23</div>
									<div class="name up">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 purple">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area">一氧化碳</div>
									<div class="value">23</div>
									<div class="name up">20%</div>
								</div>								
							</div>							
						</div>						
					</div>
				</div>				
			</div>
			<!--  -->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="#" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>首要污染物</span>
					</span>					
				</div>			
				<div class="row" id="primaryPollutants">
					<div class="col-xs-4">
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
										<div>二氧化氮</div>
									</div>						
								</div>		
				            </div>
				        </div>			
					</div>
					<div class="col-xs-4">
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
										<div>臭氧</div>
									</div>						
								</div>		
				            </div>
				        </div>			
					</div>
					<div class="col-xs-4">
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
										<div>PM10</div>
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
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>2019年全年空气质量</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body" id="airQuality">
			<!--面板主内容-->
			<div class="box-body">				
				<div class="box-title">本市空气质量优良天数138，优良率97.87%</div>
				<div class="box-top">
					<!-- <a href="#" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>2019年全年空气质量差</span>
					</span>					
				</div>
				<div class="sub-title">影响达标流域</div>				
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
									<div class="name">龙文区</div>
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
									<div class="name">芗城区</div>
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
									<div class="name">龙海市</div>
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
					<!-- <a href="#" target="" class="more fr">详情</a> -->
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
									<div class="name">龙海市</div>
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
									<div class="name">龙海市</div>
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
									<div class="name">龙海市</div>
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
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>六项指标考核目标</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body row" id="sixIndicators">
				<div class="col-xs-6">
					<div id="AQILiquidfill" style="width: 100%;height: 220px;"></div>
				</div>
				<div class="col-xs-6">
					<div class="air-text-box" style="width: 100%;height: 220px;">
						<div class="air-text">
							<div class="title">空气质量考核目标</div>
							<div class="name">
								<div>97.80 已达标</div>
								<div>所剩考核还有38天</div>
							</div>
						</div>						
					</div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="completed">已完成</span>
						<span>目标：二氧化硫</span>
					</div>				
					<div class="sub-title">完成情况：SO2</div>				
					<div class="chart-box" id="pictorialBarChart"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete">未达标</span>
						<span>目标：PM2.5</span>
					</div>				
					<div class="sub-title">完成情况：PM2.5</div>				
					<div class="chart-box" id="pictorialBarChart2"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="completed">已完成</span>
						<span>目标：二氧化硫</span>
					</div>				
					<div class="sub-title">完成情况：SO2</div>				
					<div class="chart-box" id="pictorialBarChart3"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete">未达标</span>
						<span>目标：PM2.5</span>
					</div>				
					<div class="sub-title">完成情况：PM2.5</div>				
					<div class="chart-box" id="pictorialBarChart4"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="completed">已完成</span>
						<span>目标：二氧化硫</span>
					</div>				
					<div class="sub-title">完成情况：SO2</div>				
					<div class="chart-box" id="pictorialBarChart5"></div>
				</div>
				<div class="col-xs-6">
					<div class="sub-title">
						<span class="incomplete">未达标</span>
						<span>目标：PM2.5</span>
					</div>				
					<div class="sub-title">完成情况：PM2.5</div>				
					<div class="chart-box" id="pictorialBarChart6"></div>
				</div>
				
				
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
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>日目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-air-panel-body">
			<!--面板主内容-->
			<div class="box-body box-content target-manage-list">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-orange">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-red">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-purple">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-crimson">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
								</div>						
							</div>		
			            </div>
			        </div>
				</div>
				<div class="item">
					<div class="home-border-panel air-gray">
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
									<div class="area">平和县</div>
									<div class="name">Ⅰ</div>
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
                <a class="select-tag">市区-龙文区（9</a>
				<a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>
                <a>市区-龙文区（9）</a>

                <#--<div class="swiper-container" >-->
                    <#--<div class="swiper-wrapper" >-->
                        <#--<div class="swiper-slide">-->
                           <#---->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                        <#--<div class="swiper-slide">-->
                            <#--<a>市区-龙文区（9）</a>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
                <!--<span class="more-tag"><img src="images/more-icon.png"></span>-->

                <!--<div class="swiper-button-prev"></div>-->
                <#--<div class="swiper-button-next  more-tag"></div>-->
            </div>
            <div class="option-list">
                <a class="select-tag">达标大气（3）</a>  <a>达标大气（3）</a>
            </div>
            <div class="list-data">
                <div class="item">
                    <h5>
                        <span>县前直街 <label>截止2019年05月23日</label></span>
                        <a class="details-tag">详情</a>
                    </h5>
                    <div class="item-info">
                        <table>
                            <tr class="select-row">
                                <td><span>PM2.5：55</span></td>
                                <td><span>不达标，超标10微克/立方米</span></td>
                            </tr>
                            <tr class="select-row2">
                                <td><span>二氧化碳：20</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr class="select-row3">
                                <td><span>一氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr class="select-row4">
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr class="select-row5">
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                            <tr class="select-row6">
                                <td><span>二氧化硫：16</span></td>
                                <td><span>达标</span></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>县前直街 <label>截止2019年05月23日</label></span>
                        <a class="details-tag">详情</a>
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
                <div class="item">
                    <h5>
                        <span>县前直街 <label>截止2019年05月23日</label></span>
                        <a class="details-tag">详情</a>
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
            <a class="return-tag ">
                <span class="icon iconcustom"></span>
            </a>
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/gas-left-icon.png">
                <span>市区龙文区 - 县前直街详情</span>
                <img src="${request.contextPath}/static/images/new-popup/gas-right-icon.png">
            </h3>
           <div class="details-table">
               <table class="layui-hide" id="water-table"></table>
           </div>
        </div>
    </div>
</div>
<!--  大气详情弹窗 结束 -->

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">  
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
    	
    	
    	
    	/*---------------------------------------考核目标-------------------------------------------*/
        var pictorialBarChart = echarts.init(document.getElementById('pictorialBarChart'));
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
                            color:'#61f651',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart.setOption(pictorialBarOption);
        
        var pictorialBarChart2 = echarts.init(document.getElementById('pictorialBarChart2'));
        var pictorialBarOption2 ={
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
                            color:'#ffbf26',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart2.setOption(pictorialBarOption2);
        
        var pictorialBarChart3 = echarts.init(document.getElementById('pictorialBarChart3'));
        var pictorialBarOption3 ={
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
                            color:'#00b3eb',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart3.setOption(pictorialBarOption3);
        
        var pictorialBarChart4 = echarts.init(document.getElementById('pictorialBarChart4'));
        var pictorialBarOption4 ={
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
                            color:'#fe8a57',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart4.setOption(pictorialBarOption4);
        
        var pictorialBarChart5 = echarts.init(document.getElementById('pictorialBarChart5'));
        var pictorialBarOption5 ={
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
                            color:'#49b949',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart5.setOption(pictorialBarOption5);
        
        var pictorialBarChart6 = echarts.init(document.getElementById('pictorialBarChart6'));
        var pictorialBarOption6 ={
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
                            color:'#ff6262',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart6.setOption(pictorialBarOption6);
        
        /*------------------------水球-AQI----------------------------*/
        var AQILiquidfill = echarts.init(document.getElementById('AQILiquidfill'));
        var AQILiquidfillOption = {        		
            series: {
                name: 'AQI指数',
                type: 'liquidFill',
				center:['50%', '50%'],
                data: [0.36],
                radius: '70%',
                color: ['#ff6262'],
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
                        var text="优";
                        var str='{t|AQI}\n{p|'+ param.value*100 + '}\n{t|'+text+'}';
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

    $(".atmosphere-open").click(function () {
        $(".max-atmosphere-box").css("display","flex");
        //切换
        var swiper = new Swiper('.swiper-container', {
            slidesPerView: viewNub,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    })

    // 大气弹窗关闭
    $(".atmosphere-close").click(function () {
        $(".new-atmosphere-show").css("display","none")
    })


    // 大气弹窗 导航栏点击切换样式
    $(".option-box a").click(function () {
        $(".option-box a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })

    // 大气弹窗 二级导航点击切换样式
    $(".option-list a").click(function () {
        $(".option-list a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })


    layui.use(['layer','element','table'], function(){ //添加layui模块：弹出层、tab选项卡、数据表格
        var layer = layui.layer
                ,element = layui.element
                ,table = layui.table;
        //数据表格
        table.render({
            elem: '#water-table'
            ,theme: '#0f61b5'
            //,url:'/demo/table/user/'
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: [ 'prev', 'page', 'next'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                //,count:20//数据总数
                ,limit:12 //每页显示的条数
                ,groups: 5 //只显示 5 个连续页码
                ,first: false //不显示首页
                ,last: false //不显示尾页
                ,count: 100 //总页数
                ,theme: '#0f61b5'
                //,skip: true //开启跳页
                ,jump: function(obj, first){
                    if(!first){
                        layer.msg('第'+ obj.curr +'页', {offset: 'b'});
                    }
                }

            }
            ,cols: [[
                {field:'id', width:'10%', title: '监测时间',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username', title: '监测站点',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username',  title: 'AQI',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username',  title: 'PM2.5(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username', title: 'PM10(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username', title: 'SO2(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username',  title: 'NO2(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username',  title: 'O3(μg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username',  title: 'CO(mg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}
                ,{field:'username', title: 'CO(mg/m3)',style:'background: rgb(14, 37, 51); color: #c4ecff;'}

            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': 'rgb(14, 37, 51)', 'color': '#c4ecff'});
            }

            ,data: [{
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"

            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }, {
                "id": "2019-3-29"
                ,"username": "杜甫"
                ,"username": "杜甫"
                ,"username": "22"
                ,"username": "3"
                ,"username": "5"
                ,"username": "8"
                ,"username": "23"
                ,"username": "4"
                ,"username": "6"
            }]
        });
        //详情弹窗
        $(".details-tag").click(function () {
            $(".max-atmosphere-box").css("display","none")
            $(".details-atmosphere").css("display","flex")
            table.resize("water-table")

        })
    });



</script>
</html>