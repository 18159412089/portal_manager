<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>突出生态环境问题-大数据</title>

</head>
<!-- body -->
<body class="TV-screen-container">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudInspector.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>
<!-- Swiper CSS js -->
<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<style type="text/css">
    
</style>
<!-- 头部 -->
<header class="home-inspector-header-container">
	<div class="header-logo">
		<h1 class="logo-text" style="letter-spacing: 3px;">
			漳州生态环境数据资源中心
			<div class="btn-switch-tv">TV</div>
		</h1>
	</div>
	<div class="header-nav p-right">
		<#--<ul class="atmosphere-nav">-->
            <#--<li class="nav-item">-->
                <#--<a class="nav-item-a nav-item-select">-->
                    <#--<span class="title">大气环境</span>-->
                <#--</a>-->
            <#--</li>-->
            <#--<li class="nav-item">-->
                <#--<a class="nav-item-a" >-->
                    <#--<span class="title">水环境</span>-->
                <#--</a>-->
            <#--</li>-->
		<#--</ul>-->
           <div class="option-box">
                <a href="${request.contextPath}/indextemp12.ftl" >大气环境 </a>
                <a href="${request.contextPath}/indextemp10.ftl" >水环境</a>
                <a href="${request.contextPath}/indextemp11.ftl" class="select-tag">突出生态环境问题</a>
            </div>
	</div>
	<div class="header-other p-left">
		<span><span class="icon iconcustom icon-zhire"></span>多云  北风1~2级</span>
		<span>2018年9月20日</span>
        <a href="${request.contextPath}/index" target="_blank">进入系统</a>
	</div>
</header>
<!-- 头部 over  -->

<div class="home-inspector-container">
<!-- 左 -->
<div class="home-layout fl" id="home-left">
	<!--首页面板-->
	<div class="home-inspector-panel">
		<div class="home-inspector-panel-header">
			<a href="#" target="" class="more fr summary-tag">详情</a>
			<span class="title">
				<span class="icon iconcustom icon-renwuguanli1" ></span>
				<span>尚未启动任务</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body">
			<!--面板主内容-->
			<div class="box-body">					
				<div class="row" id="">
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 green">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="name">垃圾渗滤液</div>
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
									<div class="name">垃圾渗滤液</div>
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
									<div class="name">垃圾渗滤液</div>
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

	<!--首页面板-->
	<div class="home-inspector-panel">
		<div class="home-inspector-panel-header">
			<a href="#" target="" class="more fr">详情</a>
			<span class="title">
				<span class="icon iconcustom icon-renwuguanli1" ></span>
				<span>超过序时进度</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body">
			<!--面板主内容-->
			<div class="box-body">					
				<div class="row" id="">
					<div class="col-xs-4">
						<div class="basin-name-container circle-1 red">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="name">垃圾渗滤液</div>
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
									<div class="name">垃圾渗滤液</div>
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
									<div class="name">垃圾渗滤液</div>
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
	<div class="home-inspector-panel">
		<div class="home-inspector-panel-header">
			<a href="#" target="" class="more fr">详情</a>
			<span class="title">
				<span class="icon iconcustom icon-quxiaoguanlian4" ></span>
				<span>完成销号超过30天验收</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body" id="">
			<!--面板主内容-->
			<div class="box-body">
				<div class="layui-tab layui-tab-inspector">
				  <ul class="layui-tab-title">
				    <li class="layui-this">县级验收</li>
				    <li>市级验收</li>
				    <li>行业验收</li>
				    <li>行业审核</li>
				  </ul>
				  <div class="layui-tab-content">
				    <div class="layui-tab-item layui-show row">
						<div class="col-xs-4">
							<div class="basin-name-container circle-3 yellow">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">垃圾渗滤液</div>
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
										<div class="name">垃圾渗滤液</div>
									</div>						
								</div>							
							</div>						
						</div>					
						<div class="col-xs-4">
							<div class="basin-name-container circle-3 purple">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">垃圾渗滤液</div>
									</div>						
								</div>							
							</div>						
						</div>	
					</div>
				    <div class="layui-tab-item row">内容2</div>
				    <div class="layui-tab-item row">内容3</div>
				    <div class="layui-tab-item row">内容4</div>
				  </div>
				</div>								
			</div>
			<!--面板主内容 over-->
				
		</div>
	</div>
	<!--首页面板 over-->
<!--首页面板-->
	<div class="home-inspector-panel" id="earlyWarning">
		<div class="home-inspector-panel-header">
			<a href="#" target=""  class="more fr warning-tag">详情</a>
			<span class="title">
				<span class="icon iconcustom icon-fengxian1" ></span>
				<span>整改汇总预警</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body" id="">
			<!--面板主内容-->
			<div class="box-body row">
				<div class="col-xs-12">
					<div class="sub-title">
						<span>龙海市汽车拆解</span>
					</div>				
					<div class="sub-title">
						<span class="item">责任人：黄渤</span>
						<span class="item">整改时限：2019-03-06</span>
						<div class="state executing">
							<div>执行中</div>
							<div>剩余10天</div>
						</div>
					</div>				
					<div class="chart-box" id="pictorialBarChart"></div>
				</div>	
				<div class="col-xs-12">
					<div class="sub-title">
						<span>龙海市汽车拆解</span>
					</div>				
					<div class="sub-title">
						<span class="item">责任人：黄渤</span>
						<span class="item">整改时限：2019-03-06</span>
						<div class="state unexpired">
							<div>执行中</div>
							<div>剩余10天</div>
						</div>
					</div>			
					<div class="chart-box" id="pictorialBarChart2"></div>
				</div>
				<div class="col-xs-12">
					<div class="sub-title">
						<span>龙海市汽车拆解</span>
					</div>				
					<div class="sub-title">
						<span class="item">责任人：黄渤</span>
						<span class="item">整改时限：2019-03-06</span>
						<div class="state expired">
							<div>执行中</div>
							<div>剩余10天</div>
						</div>
					</div>		
					<div class="chart-box" id="pictorialBarChart3"></div>
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
	<div class="home-inspector-panel">
		<div class="home-inspector-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-huanjing1" ></span>
				<span>突出生态环境问题</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body">
			<!--面板主内容-->
			<div class="box-body" id="highlightingProblems">
				<div class="layui-tab layui-tab-inspector">
				  <ul class="layui-tab-title">
				    <li class="layui-this">整改汇总</li>
				    <li>交账销号</li>
				  </ul>
				  <div class="layui-tab-content">
				    <div class="layui-tab-item layui-show row">
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">我市中央环保督察问题</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">尚未启动任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">未达到序时进度任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">达到序时进度任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">超过序时进度任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">完成整改任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">完成交账销号任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
					
					</div>
				    <div class="layui-tab-item row">
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">已完成整改销号任务</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">已完成县级验收</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">已完成市级验收</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">已提交行业验收</div>
											<div class="name">658个</div>
										</div>						
									</div>		
					            </div>
					        </div>
						</div>
						<div class="item col-xs-6">
							<div class="home-border-panel inspector-red">
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
											<div class="area">已完成行业审查</div>
											<div class="name">658个</div>
										</div>						
									</div>		
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
<!-- 中  over-->
<div class="ca"></div>
<!-- 日目标管理 -->
<div class="home-layout" id="urbanDistribution">
<!--首页面板-->
	<div class="home-inspector-panel">
		<div class="home-inspector-panel-header">
			<a href="#" target="" class="more fr city-tag">详情</a>
			<span class="title">
				<span class="icon iconcustom icon-huanjing4" ></span>
				<span>城市分布</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-inspector-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="layui-tab layui-tab-inspector">
				  <ul class="layui-tab-title">
				    <li class="layui-this">整改汇总</li>
				    <li>交账销号</li>
				  </ul>
				  <div class="layui-tab-content">
				  	<div class="layui-tab-item layui-show ca">
				  		<div class="item">
							<div class="basin-name-container circle-2 orange">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 red">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 purple">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 yellow">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 blue">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 green">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 orange">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 red">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
						<div class="item">
							<div class="basin-name-container circle-2 purple">
								<div class="basin-bg">
									<div class="bg-img bg-1"></div>
									<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
								</div>
								<div class="basin-text-box">
									<div class="basin-text">
										<div class="name">华安县</div>
										<div>5个</div>
									</div>						
								</div>						
							</div>
						</div>
				  	</div>
				  	<div class="layui-tab-item ca">
				  		内容2
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

<#-- 汇总整改 弹窗开始-->
<div class="new-supervision-show max-supervision-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-close">
                返回
			</a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 汇总整改 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box summary-box">
                <div class="option-box">
                    <a class="select-tag">达标断 </a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                    <a>达标断面</a>
                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="supervisio-table" style="">
                    </table>

                    <!--分页容器-->
                    <div id="page-container" class="page-supervision">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--查看详情弹窗开始-->
<div class="new-supervision-show details-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-max">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 渗滤液得不到妥善处理 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--查看详情表格-->
            <div class="spacing-box look-details-box">
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="details-table">
                    </table>

                    <!--分页容器-->
                    <div id="details-container" class="page-supervision"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--汇总预警 弹窗开始-->
<div class="new-supervision-show warning-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-close">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 汇总整改预警 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--汇总预警 -->
            <div class="list-warning">
                <div class="spacing-box spacing-list">
                    <div class="details-text">
                        <h5 >sfsfs</h5>
                        <div class="part-font">
                            <div class="data-item">
                                <span >问题描述</span>
                                <span >危险废物处置能力缺口问题</span>
                            </div>
                            <div class="data-item">
                                <span >整改任务具体要求</span>
                                <span>十五、一些地方对保护区内违法养殖查处不严，清退不力，漳州市漳江口红树林国家级自然保护区核心区有养殖面积323公顷，缓冲区有239公顷，2013年以来养殖面积仍在扩大，
核心区和缓冲区分别新增养殖面积约20公顷和11公顷。对保护区内的非法养殖问题实行分类处理。</span>
                            </div>
                            <div class="data-item">
                                <span >目前进展情况及存在问题</span>
                                <span >1.针对2003年以来违规扩大养殖面积。全面拆除2003年以来新增50.70公顷的养殖池塘堤岸、管理房、闸门等设施，加强日常巡护、无人机监控等监测措施，严格监控确保整改成
效，截至目前，没有发现返养行为。 2.针对2003年以前核心区缓冲区存在的养殖池塘。完成保护区范围内涉及15个村1001户716.58公顷养殖池塘调查建档工作。</span>
                            </div>
                        </div>
                        <div class="part-date">
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">行政区划：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">所属城市：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人电话：</span>
                                <span class="control-content">18865658888</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任单位：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头单位：</span>
                                <span class="control-content">厦门智慧指间</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任部门</span>
                                <span class="control-content"></span>';
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">配合单位：</span>
                                <span class="control-content">厦门</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及人员：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">创建时间：</span>';
                                <span class="control-content">2019-06-01</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及部门：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">整改时限：</span>
                                <span class="control-content">2019-06-04</span>
                            </div>
                        </div>
                        <div class="footer-font">
                            <span>完成交账销号</span>
                        </div>
                    </div>
                    <div class="details-text">
                        <h5 >sfsfs</h5>
                        <div class="part-font">
                            <div class="data-item">
                                <span >问题描述</span>
                                <span >危险废物处置能力缺口问题</span>
                            </div>
                            <div class="data-item">
                                <span >整改任务具体要求</span>
                                <span>十五、一些地方对保护区内违法养殖查处不严，清退不力，漳州市漳江口红树林国家级自然保护区核心区有养殖面积323公顷，缓冲区有239公顷，2013年以来养殖面积仍在扩大，
核心区和缓冲区分别新增养殖面积约20公顷和11公顷。对保护区内的非法养殖问题实行分类处理。</span>
                            </div>
                            <div class="data-item">
                                <span >目前进展情况及存在问题</span>
                                <span >1.针对2003年以来违规扩大养殖面积。全面拆除2003年以来新增50.70公顷的养殖池塘堤岸、管理房、闸门等设施，加强日常巡护、无人机监控等监测措施，严格监控确保整改成
效，截至目前，没有发现返养行为。 2.针对2003年以前核心区缓冲区存在的养殖池塘。完成保护区范围内涉及15个村1001户716.58公顷养殖池塘调查建档工作。</span>
                            </div>
                        </div>
                        <div class="part-date">
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">行政区划：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">所属城市：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人电话：</span>
                                <span class="control-content">18865658888</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任单位：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头单位：</span>
                                <span class="control-content">厦门智慧指间</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任部门：</span>
                                <span class="control-content"></span>';
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">配合单位：</span>
                                <span class="control-content">厦门</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及人员：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">创建时间：</span>';
                                <span class="control-content">2019-06-01</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及部门：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">整改时限：</span>
                                <span class="control-content">2019-06-04</span>
                            </div>
                        </div>
                        <div class="footer-font">
                            <span>完成交账销号</span>
                        </div>
                    </div>
                </div>
                <!--分页容器-->
                <div id="warning-container" class="page-supervision"></div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#-- 整改城市分布 弹窗开始-->
<div class="new-supervision-show city-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <#--<a class="return-tag return-close">-->
                <#--<span class="icon iconcustom"></span>-->
            <#--</a>-->

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 整改城市分布 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box city-box">
                <div class="option-box">
                    <a class="select-tag">达标断 </a>
                    <a>达标断面</a>
                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="city-table" style="">
                    </table>

                    <!--分页容器-->
                    <div id="page-container" class="page-supervision">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--城市详情弹窗开始-->
<div class="new-supervision-show details-city-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-city">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 城市详情 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--查看详情表格-->
            <div class="spacing-box look-city-box">
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="details-city-table">
                    </table>

                    <!--分页容器-->
                    <div id="details-container-city" class="page-supervision"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<#--弹窗结束 -->

</body>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript">  
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    layui.use('element', function(){
    	  var element = layui.element;
    	  
    	 
    	});
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
   	        show: false
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
            left: '20',
            right: '100',
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
                            color:'#fe8a57',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart3.setOption(pictorialBarOption3);

    });

</script>

<script>

    $(".option-box a").click(function () {
        $(".option-box a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })

    $(".supervision-close").click(function () {
        $(".new-supervision-show").hide()
    })

    layui.use(['layer','laypage','table'], function(){
        var layer = layui.layer
                ,laypage= layui.laypage
                ,table = layui.table;
        /**
         * 数据表格
         */
        table.render({
            elem: '#supervisio-table'
            ,theme: '#ff6666'
            ,cols: [[
                {field:'id1', title: '描述',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id2',width:'20%', title: '状态',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id1": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='look-tag'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, {
                "id1": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='look-tag'><span class=\"icon iconcustom look-icon\"></span>查看</a>"

            }, {
                "id1": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='look-tag'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, {
                "id1": "2019-3-29"
                ,"id2": "杜甫"
                ,"id3": "<a class='look-tag'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, ]
        });

        /**
         * 详情数据
         */
        table.render({
            elem: '#details-table'
            ,theme: '#ff6666'
            ,cols: [[
                {field:'id',width:'40%', title: '任务具体整改要求',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id',width:'40%', title: '目前进展情况及存在问题',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id', title: '完成情况',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 《生活垃圾填埋场污染控制标准》规定，2011年7月起生活垃圾填埋场应自行处理渗滤液并满足达标排放要求。标准实施后，福建省在“十二五”相关规划中提出要求，但落实和监管不够到位。督察发现，全省县级及以上地区的53个垃圾填埋场中，8个未建设渗滤液处置设施，16个渗滤液超标排放。"
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "

            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, ],
        });

        /**
         * 城市详情
         */
        table.render({
            elem: '#details-city-table'
            ,theme: '#ff6666'
            ,cols: [[
                {field:'id',width:'40%', title: '任务具体整改要求',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id',width:'40%', title: '目前进展情况及存在问题',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id', title: '完成情况',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 《生活垃圾填埋场污染控制标准》规定，2011年7月起生活垃圾填埋场应自行处理渗滤液并满足达标排放要求。标准实施后，福建省在“十二五”相关规划中提出要求，但落实和监管不够到位。督察发现，全省县级及以上地区的53个垃圾填埋场中，8个未建设渗滤液处置设施，16个渗滤液超标排放。"
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "

            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, ],
        });

        /**
         * 城市表格
         */
        table.render({
            elem: '#city-table'
            ,theme: '#ff6666'
            ,cols: [[
                {field:'id1', title: '描述',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id2',width:'20%', title: '状态',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id1": "垃圾渗滤液得不到有效处置"
                ,"id2": "尚未启动"
                ,"id3": "<a class='look-city'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, {
                "id1": "垃圾渗滤液得不到有效处置"
                ,"id2": "尚未启动"
                ,"id3": "<a class='look-city'><span class=\"icon iconcustom look-icon\"></span>查看</a>"

            }, {
                "id1": "垃圾渗滤液得不到有效处置"
                ,"id2": "尚未启动"
                ,"id3": "<a class='look-city'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, {
                "id1": "垃圾渗滤液得不到有效处置"
                ,"id2": "尚未启动"
                ,"id3": "<a class='look-city'><span class=\"icon iconcustom look-icon\"></span>查看</a>"
            }, ]
        });

        /**
         * 分页栏
         */
        laypage.render({
            elem: 'page-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 详情分页栏
         */
        laypage.render({
            elem: 'details-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 预警分页栏
         */

        /**
         * 城市分页栏
         */
        laypage.render({
            elem: 'page-details-city', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 城市详情分页栏
         */
        laypage.render({
            elem: 'details-container-city', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 预警分页栏
         */
        laypage.render({
            elem: 'warning-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

         //汇总整改弹窗
        $(".summary-tag").click(function () {
            $(".max-supervision-show").css("display","flex")
            table.resize("supervisio-table")
        })

        //查看详情弹窗
        $(".look-tag").click(function () {
            $(".details-show").css("display","flex")
            $(".max-supervision-show").hide()
            table.resize("details-table")
        })

		// 预警弹窗
		$(".warning-tag").click(function () {
            $(".warning-show").css("display","flex")
        })

        // 城市分布弹窗
        $(".city-tag").click(function () {
            $(".city-show").css("display","flex")
            table.resize("city-table")
        })

        // 城市弹窗详情
        $(".look-city").click(function () {
            $(".details-city-show").css("display","flex");
            $(".city-show").css("display","none")
            table.resize("details-city-table")
        })

        $(".return-city").click(function () {
            $(".details-city-show").css("display","none");
            $(".city-show").css("display","flex")
        })

		// 返回按钮
		$(".return-close").click(function () {
            $(".new-supervision-show").css("display","none")
        })



		$(".return-max").click(function () {
            $(".details-show").css("display","none")
            $(".max-supervision-show").css("display","flex")
        })

    });





</script>
</html>