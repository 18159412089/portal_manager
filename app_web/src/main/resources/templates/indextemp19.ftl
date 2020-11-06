<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>云平台调度古雷应急演练</title>

</head>
<!-- body -->
<body class="">
<#include "/common/loadingDiv.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudAir.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/animate.min.css" >
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/wow.min.js"></script>

<script>

    new WOW().init();
</script>
<!-- 头部 -->
<header class="home-air-header-container">
	<div class="header-logo">
		<h1 class="logo-text" style="letter-spacing: 3px;">
			云平台调度古雷应急演练
            <div class="btn-switch-tv">web</div>
		</h1>
	</div>
	<div class="header-nav p-right">
        
        <div class="atmosphere-nav">
            <ul>
                <li>
                    <a class="nav-item-a select-tag" href="#">
                    <span class="title">开启预警演练</span>
                     <i class="icon iconcustom drop-icon"></i>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="#">
                        <span class="title">开启应急方案</span>
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
        <a style="background: blue;padding:0 10px;display: inline-block" class="animation-link">动画</a>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-air-container">
	<!-- 左 -->
	<div class="home-layout fl" id="home-left">
		<!--首页面板-->
		<div class="home-panel">
			<div class="home-panel-bg">
				<div class="bg-top-left"></div>
				<div class="bg-top-right"></div>
				<div class="bg-bottom-left"></div>
				<div class="bg-bottom-right"></div>
			</div>			
			<div class="box-bg box-btn">
            	航拍视频全景
            </div>
		</div>
		<!--首页面板 over-->	
		<!--首页面板-->
		<div class="home-panel" id="personnel">
			<div class="home-panel-bg">
				<div class="bg-top-left"></div>
				<div class="bg-top-right"></div>
				<div class="bg-bottom-left"></div>
				<div class="bg-bottom-right"></div>
			</div>	
			<!--面板主内容-->
               <div class="personnel-list-container">
                   <ul>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children" style="display: block">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function video-tag"><span class="icon iconcustom icon-xinxi1"></span>短信</div>
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-shipin2"></span>视频</div>
											<div id="" class="function connection-tag "><span class="icon iconcustom icon-dingwei3"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>
							
							
							
							<ul>
								<li class="item">
			                       	<div class="personnel-parent">
						            	二级网格员
						            </div>                       
			                       	<div class="personnel-children" style="display: block">
				                        <div class="personnel-info">
											<div class="personnel-header">
												<img class="header-img" src="/static/images/personal-head.png">
											</div>
											<div class="personnel-content">
												<div class="info">
													<div class="name fl">杨博文</div>
													<div class="fr">
														<div id="" class="function video-tag"><span class="icon iconcustom icon-shipin2"></span>视频</div>
														<div id="" class="function connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
													</div>
												</div>
												<div class="address">
													<span>所属网络：</span><span>漳州市</span>
												</div>
												<div class="address">
													<span>网络等级：</span><span>一级网格员</span>
												</div>
												<div class="address">
													<span>联系方式：</span><span></span>
												</div>
											</div>
										</div>
										<div class="personnel-info offline-user">
											<div class="personnel-header">
												<img class="header-img" src="/static/images/personal-head.png">
											</div>
											<div class="personnel-content">
												<div class="info">
													<div class="name fl">杨博文</div>
													<div class="fr">
														<div id="" class="function"><span class="icon iconcustom icon-shipin2"></span>视频</div>
														<div id="" class="function connection-tag "><span class="icon iconcustom icon-dingwei3"></span>连线</div>
													</div>
												</div>
												<div class="address">
													<span>企业网格员</span>
												</div>									
											</div>
										</div>
										
										
										<ul>
											<li class="item">
						                       	<div class="personnel-parent">
									            	三级网格员
									            </div>                       
						                       	<div class="personnel-children" style="display: block">
							                        <div class="personnel-info">
														<div class="personnel-header">
															<img class="header-img" src="/static/images/personal-head.png">
														</div>
														<div class="personnel-content">
															<div class="info">
																<div class="name fl">杨博文</div>
																<div class="fr">
																	<div id="" class="function video-tag"><span class="icon iconcustom icon-shipin2"></span>视频</div>
																	<div id="" class="function connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
																</div>
															</div>
															<div class="address">
																<span>所属网络：</span><span>漳州市</span>
															</div>
															<div class="address">
																<span>网络等级：</span><span>一级网格员</span>
															</div>
															<div class="address">
																<span>联系方式：</span><span></span>
															</div>
														</div>
													</div>
													<div class="personnel-info offline-user">
														<div class="personnel-header">
															<img class="header-img" src="/static/images/personal-head.png">
														</div>
														<div class="personnel-content">
															<div class="info">
																<div class="name fl">杨博文</div>
																<div class="fr">
																	<div id="" class="function"><span class="icon iconcustom icon-shipin2"></span>视频</div>
																	<div id="" class="function connection-tag "><span class="icon iconcustom icon-dingwei3"></span>连线</div>
																</div>
															</div>
															<div class="address">
																<span>企业网格员</span>
															</div>									
														</div>
													</div>								
												 </div>	
						                       </li>
										
										
										</ul>
										
										
																		
									 </div>	
			                       </li>
							
							
							</ul>
							
							
															
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	环保应急人员
			            </div>                       
                       	<div class="personnel-children"  style="display: block">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-shipin2"></span>视频</div>
											<div id="" class="function connection-tag connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-xinxi1"></span>视频</div>
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-luyinduijiang1"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-dingwei3"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-dingwei3"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function connection-tag"><span class="icon iconcustom icon-dingwei3"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>							
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>							
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>							
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       <li class="item">
                       	<div class="personnel-parent">
			            	网格员
			            </div>                       
                       	<div class="personnel-children">
	                        <div class="personnel-info">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>							
										</div>
									</div>
									<div class="address">
										<span>所属网络：</span><span>漳州市</span>
									</div>
									<div class="address">
										<span>网络等级：</span><span>一级网格员</span>
									</div>
									<div class="address">
										<span>联系方式：</span><span></span>
									</div>
								</div>
							</div>
							<div class="personnel-info offline-user">
								<div class="personnel-header">
									<img class="header-img" src="/static/images/personal-head.png">
								</div>
								<div class="personnel-content">
									<div class="info">
										<div class="name fl">杨博文</div>
										<div class="fr">
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>视频</div>							
											<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>连线</div>							
										</div>
									</div>
									<div class="address">
										<span>企业网格员</span>
									</div>									
								</div>
							</div>								
						 </div>	
                       </li>
                       
                   </ul>
               </div>
			<!--面板主内容 over-->
		</div>
		<!--首页面板 over-->		
	</div>
	<!-- 左  over-->
	<!-- 右 -->
	<!-- 最新上报案件 -->
	<div class="home-layout fr" id="newCase">
        <div class="btn-collapse" data-toggle="shown" data-target="#newCase">
            <span class="icon fa-angle-left"></span>
        </div>
		<!--首页面板-->
		<div class="home-panel">
			<div class="home-panel-bg">
				<div class="bg-top-left"></div>
				<div class="bg-top-right"></div>
				<div class="bg-bottom-left"></div>
				<div class="bg-bottom-right"></div>
			</div>			
			<div class="home-panel-body">
				
				<!--面板主内容-->
                <div class="time-axis-container">
                    <ul>
                        <li class="item highlight">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                        <li class="item">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                        <li class="item">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                        <li class="item">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                        <li class="item">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                        <li class="item">
                            <a href="" class="time-axis-box">
                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span></div>
                                <div class="con">
                                    <div class="title">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
				<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->	
	</div>
	<!-- 最新上报案件  over-->
	<!-- 右  over-->
	<!-- 地图 -->
	<div class="home-layout oh" id="homeMap">
		<!--首页面板-->
		<div class="home-panel-border">
            <div class="home-border-panel-bg ">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-center-left-top"></div>
                <div class="bg-center-left-bottom"></div>
                <div class="bg-center-right-top"></div>
                <div class="bg-center-right-bottom"></div>
                <div class="bg-bottom-right"></div>
                <div class="bg-bottom-left"></div>
            </div>
			<div class="home-panel-body">
				<div class="home-panel-bg home-border-panel-not">
					<div class="bg-top-left"></div>
					<div class="bg-top-right"></div>
					<div class="bg-bottom-left"></div>
					<div class="bg-bottom-right"></div>
                    <!--面板主内容-->
                    <div class="map-container">
                        <div class="map-tool"></div>
                        <div class="map-wrapper"></div><!--地图图层-->

					   <div class="" style="position: absolute;top: 30%;left: 30%;">
						   <div class="map-info-item" >
							   <div class="exceed-box">
								   <table>
									   <tr>
										   <th><span>二氧化氮：87</span></th>
										   <td><span class="font-color">超标</span></td>
									   </tr>
									   <tr>
										   <th><span>二氧化氮：87</span></th>
										   <td><span class="font-color">超标</span></td>
									   </tr>
									   <tr>
										   <th><span>二氧化氮：87</span></th>
										   <td><span class="font-color">超标</span></td>
									   </tr>
									   <tr>
										   <th><span>二氧化氮：87</span></th>
										   <td><span class="font-color">超标</span></td>
									   </tr>
									   <tr>
										   <td colspan="2"><span>XXXX网格员  发送短信</span></td>
									   </tr>
								   </table>
							   </div>
							   <div class="map-sign-tag cyan-sign-tag" >
								   <div class="sign-info sign-back"><span class="sign-nub"><i class="icon iconcustom icon-fanhui2"></i></span><span class="sign-name">漳州市</span></div>
							   </div>
						   </div>
					   </div>


						<div class="" style="position: absolute;top: 50%;left: 5%;">
							<div class="map-info-item" >
								<div class="exceed-box">
									<table>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<td colspan="2"><span>XXXX网格员  发送短信</span></td>
										</tr>
									</table>
								</div>
								<div class="map-sign-tag cyan-sign-tag" >
									<div class="sign-info sign-back"><span class="sign-nub"><i class="icon iconcustom icon-fanhui2"></i></span><span class="sign-name">漳州市</span></div>
								</div>
							</div>
						</div>

						<div class="" style="position: absolute;right: 20%;top: 50%">
							<div class="map-info-item">
								<div class="exceed-box">
									<table>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<th><span>二氧化氮：87</span></th>
											<td><span class="font-color">超标</span></td>
										</tr>
										<tr>
											<td colspan="2"><span>XXXX网格员  发送短信</span></td>
										</tr>
									</table>
								</div>
								<div class="map-sign-tag crimson-sign-tag" >
									<div class="sign-info sign-back"><span class="sign-nub"><i class="icon iconcustom icon-fanhui2"></i></span><span class="sign-name">漳州市</span></div>
								</div>
							</div>
						</div>


					<div class="animated-box">
                        <div class="run-box">
                            <img class="run-icon wow fadeInUp animated bounceOut"  data-wow-delay="0.3s"  src="/static/images/run-icon.png">
                            <img class="border-img wow fadeInUp animated bounceOut" data-wow-delay="0.5s" src="/static/images/border-icon1.png">
                        </div>
                        <div class="run-box run-box2">
                            <img class="run-icon wow fadeInUp animated bounceOut" data-wow-delay="0.8s"  src="/static/images/run-icon.png">
                            <img class="border-img wow fadeInUp animated bounceOut" data-wow-delay="1.1s"  src="/static/images/border-icon2.png">
                        </div>
                        <div class="run-box run-box3">
                            <img class="run-icon wow fadeInUp animated bounceOut" data-wow-delay="1.4s"  src="/static/images/run-icon.png">
                            <img class="border-img wow fadeInUp animated bounceOut" data-wow-delay="1.9s"  src="/static/images/border-icon3.png">
                        </div>
                        <div class="run-box run-box4">
                            <img class="border-img wow fadeInUp animated"  data-wow-delay="2.2s" src="/static/images/borde-icon4.png">
                            <img class="run-icon wow fadeInUp animated" data-wow-delay="2.6s"  src="/static/images/run-icon.png">
                        </div>

                    </div>


                    </div>
                    <!--面板主内容 over-->
				</div>
			</div>
		</div>
		<!--首页面板 over-->
	</div>
	<!-- 地图  over-->
	<div class="ca"></div>

</div>


<!--弹窗-->
<div id="dd" class="easyui-dialog" style="width:900px;height:600px;"
    data-options="title:'在线视频调度',closed: true,resizable:true,maximizable:true">
    <div class="online-video-container">
    	<div class="online-video-header">
    		<div class="fr">
    			<div class="btn-group">
					<div class="btn active">
						视频
					</div>
					<div class="btn">
						路径
					</div>
				</div>
    		</div>
    		<div class="title">刘荣斌</div>
    	</div>
    	<div class="online-video-content">
    		<div class="video-box">
    			<div class="video-main-box"></div>
    			<div class="video-self-box"></div>
    			<div class="video-info">
    				<span class="item"><span class="icon iconcustom icon-shipin2"></span></span>
    				<span class="item">刘炳荣</span>
					<span class="item">1路</span>
					<span class="item">实时视频中……</span>
    			</div>
    			<div class="video-operate">
    				<div class="btn dial-up"><span class="icon iconcustom icon-dianhua"></span></div>
    				<div class="btn hang-up"><span class="icon iconcustom icon-guaduandianhua"></span></div>
    			</div>
    		</div>    	
    	</div>
    </div>
</div>
<!--弹窗 over-->

<!--通话弹窗-->
<div class="news-show call-show" style="display: none" >
    <div class="news-title">
        <span class="title">请选择预约时间</span>
        <span class="icon iconcustom icon-shanchu3 icon-tag close-call"></span>
    </div>
    <div class="content">
        <div class="icon-part">
            <span class="icon iconcustom icon-renyuan1"></span>
            <span class="icon iconcustom icon-jiantou1-b"></span>
            <span class="icon iconcustom icon-zhihuizhongxin2"></span>
        </div>
        <p>企业网格员呼叫中</p>
        <div class="call-tag">
            <span><i class="icon iconcustom icon-dianhua"></i></span>
            <span><i class="icon iconcustom icon-guaduandianhua"></i></span>
        </div>
    </div>
</div>

<!--通话弹窗over-->

<!--短信弹窗-->
<div class="news-show success-box" style="display: none">
    <div class="news-title">
        <span class="title">请选择预约时间</span>
        <span class="icon iconcustom icon-shanchu3 icon-tag close-success"></span>
    </div>
    <div class="content">
        <div class="icon-part2">
            <span class="icon iconcustom icon-queren2"></span>
        </div>
        <p>短信发送成功</p>
        <span class="confirm-tag">确认</span>
    </div>
</div>
<!--短信弹窗 over-->

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">  
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    /*打开dialog*/
    function dialogOpen(target){    	
    	var sWidth=$(target).dialog('panel').outerWidth();
    	var pWidth=$(target).dialog('panel').parent().outerWidth();
    	var sHeight=$(target).dialog('panel').outerHeight();
    	var pHeight=$(target).dialog('panel').parent().outerHeight();
    	
    	sWidth=sWidth<pWidth?sWidth:pWidth-40;
    	sHeight=sHeight<pHeight?sHeight:pHeight-40;
    	
    	var sLeft=(pWidth-sWidth)/2;
    	var sTop=(pHeight-sHeight)/2;
    	
        $(target).dialog('open').panel('resize',{
       		width: sWidth,
       		height: sHeight,
       		left:sLeft,
       		top:sTop
       	});
    }
    $(function () {
        //右边列表的缩起/展开小按钮
        $('body').on('click','[data-toggle="shown"]',function(){
            var target = $(this).attr("data-target");
            var $target = $(target);
            if($target.hasClass("show")){
                $target.removeClass("show");
                $(this).removeClass("active");
            }else {
                $target.addClass("show");
                $(this).addClass("active");
            }
        });
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
    	$(".personnel-list-container").on("click",".personnel-parent",function(){
    		var $p=$(this);
    		$p.siblings(".personnel-children").slideToggle("slow",function(){
                if($(this).is(":visible")){
                    //alert("显示");
                	$p.removeClass("collapsed");
                }else{
                    //alert("隐藏");
                	$p.addClass("collapsed");
                };
    		});
    		
    	});
    	
    	//打开弹窗
    	//dialogOpen('#dd');
		$(".video-tag").click(function () {
            dialogOpen('#dd');
        })
        
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
         var tex =$(this).find("span").text();
         switch (tex){
             case "开启预警演练":
                 $(this).find("span").text("演练开始中");
                 break
             case "演练开始中":
                 $(this).find("span").text("开启预警演练");
                 break
             case "开启应急方案":
                 $(this).find("span").text("警报解除");
                 break
             case "警报解除":
                 $(this).find("span").text("开启应急方案");
                 break
         }
        $(".atmosphere-nav li a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })


    //小屏菜单栏
    $(".p-right .select-tag").click(function(){
        if( $(".atmosphere-nav").css("height")=="70px"){
            $(".atmosphere-nav").css("height","auto")
        }else{
            $(".atmosphere-nav").css("height","70px")
        }
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

<script>
    //开启通话弹窗事件
	$(".connection-tag").click(function () {
		$(".call-show").show()
    })

    //关闭通话弹窗事件
    $(".close-call").click(function () {
        $(".call-show").hide()
    })

    //关闭短信发送成功弹窗
    $(".close-success").click(function () {
        $(".success-box").hide()
    })

    // 确认按钮点击事件
    $(".confirm-tag").click(function () {
        $(".success-box").hide()
    })
    
    $(".animation-link").click(function () {
        if($(".animated-box").css("display")=="none"){
            $(".animated-box").show()
        }else {
            $(".animated-box").hide()
        }
    })
</script>
</html>