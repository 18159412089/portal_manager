<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>水环境-大数据</title>

</head>
<!-- body -->
<body class="TV-screen-container" style="overflow: auto;">
<#include "/decorators/header.ftl"/>
<link href="${request.contextPath}/static/layui/css/layui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>
<style type="text/css">
    .col-xs-2{ width:19.666667%; }
</style>
<!-- 头部 -->
<header class="home-water-header-container">
	<div class="header-logo"><h1 class="logo-text" style="letter-spacing: 3px;"> 漳州生态云 - 水环境 <div class="btn-switch-tv">TV</div></h1></div>
	<div class="header-nav p-right">
        <ul class="water-nav">
            <li class="nav-item">
                <a class="nav-item-a" href="${request.contextPath}/environment/hugeData">
                    <span class="title">大气环境</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="indextemp10.ftl" class="nav-item-a select-tag">
                    <span class="title">水环境</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="indextemp11.ftl" class="nav-item-a select-tag">
                    <span class="title">生态环境问题</span>
                </a>
            </li>
		<#--<li class="nav-item">-->
		<#--<a class="nav-item-a" href="${request.contextPath}/main">-->
		<#--<span class="title">生态环境问题</span>-->
		<#--</a>-->
		<#--</li>-->
        </ul>
	</div>
	<div class="header-other p-left">
		<span><span class="icon iconcustom icon-zhire"></span>多云  北风1~2级</span>
		<span>2018年9月20日</span>
        <a href="${request.contextPath}/index" target="_blank">进入系统</a>
	</div>
</header>
<!-- 头部 over  -->

<div class="home-water-container">

<!-- 监控情况 -->
<div class="home-layout" id="monitoringDetails">
<!--首页面板-->
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shipinjiankong1" ></span>
				<span>监控情况</span>
			</span>
			<span class="other" style="display: none">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-content row">
				<div class="grid-info col-xs-2">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-shuiku1"></span>
					</div>
					<div class="panel-right">
						<div>污水处理厂</div>
						<div><span>154</span></div>
					</div>
				</div>
				<div class="grid-info col-xs-2">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-paifang2"></span>
					</div>
					<div class="panel-right">
						<div>常规口</div>
						<div><span>681,367</span></div>
					</div>
				</div>
				<div class="grid-info col-xs-2">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-qiyexinxi3"></span>
					</div>
					<div class="panel-right">
						<div>污普废水企业</div>
						<div><span>650,545</span></div>
					</div>
				</div>
				<div class="grid-info col-xs-2">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-shuiba"></span>
					</div>
					<div class="panel-right">
						<div>微型水质自动站</div>
						<div><span>154</span></div>
					</div>
				</div>
				<div class="grid-info col-xs-2">
					<div class="panel-left ani duration05">
						<span class="icon iconcustom icon-shuiku2"></span>
					</div>
					<div class="panel-right">
						<div>小流域</div>
						<div><span>154</span></div>
					</div>
				</div>
				<#--<div class="grid-info col-xs-2">-->
					<#--<div class="panel-left ani duration05">-->
						<#--<span class="icon iconcustom icon-shuibengzhan"></span>-->
					<#--</div>-->
					<#--<div class="panel-right">-->
						<#--<div>湖库</div>-->
						<#--<div><span>14</span></div>-->
					<#--</div>-->
				<#--</div>-->
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
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>国考断面年目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<a href="#" target="" class="more fr water-open">详情</a>
					<span class="title">
						 <span>未达标断面</span>
					</span>					
				</div>			
				<div class="row">
					<div class="col-xs-6">
						<div class="basin-name-container circle-1 red">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
								</div>						
							</div>						
						</div>						
					</div>
					<div class="col-xs-6">
						<div class="basin-name-container circle-1 yellow">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>省考断面年目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<a href="#" target="" class="more fr">详情</a>
					<span class="title">
						<span>省考断面Ⅰ～Ⅲ类水质比例达90%以上</span>
					</span>					
				</div>
				<div class="sub-title">未达标断面</div>			
				<div class="row">
					<div class="col-xs-4">
						<div class="basin-name-container circle-2 orange">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
								</div>						
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-2 red">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
								</div>						
							</div>							
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-2 purple">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>小流域断面目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<a href="#" target="" class="more fr">详情</a>
					<span class="title">
						<span>小流域断面Ⅰ～Ⅲ类水质比例达58.4%以上</span>
					</span>					
				</div>
				<div class="sub-title">影响达标流域</div>				
				<div class="row">
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 yellow">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
					<a href="#" target="" class="more fr">详情</a>
					<span class="title">
						<span>小流域不升反降流域</span>
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
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
									<div class="area"></div>
									<div class="name">南靖上洋</div>
								</div>						
							</div>						
						</div>						
					</div>
					<div class="col-xs-4">
						<div class="basin-name-container circle-3 green">
							<div class="basin-bg">
								<div class="bg-img bg-1"></div>
								<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
							</div>
							<div class="basin-text-box">
								<div class="basin-text">
									<div class="area"></div>
									<div class="name">南靖上洋</div>
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
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>考核目标</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="#" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>国考断面</span>
					</span>
				</div>
				<div class="sub-title">
					<span class="incomplete">未达标</span>
					<span><span class="em">目标：</span>国考断面Ⅰ～Ⅲ类水质达到比例87.5%</span>				
				</div>				
				<div class="sub-title"><span class="em">完成情况：</span>国考断面Ⅰ～Ⅲ类水质达到比例67.5%</div>				
				<div class="chart-box" id="pictorialBarChart"></div>
			</div>
			<!--面板主内容 over-->
			
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="#" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>省考断面</span>
					</span>					
				</div>
				<div class="sub-title">				
					<span class="completed">已完成</span>
					<span><span class="em">目标：</span>省考断面Ⅰ～Ⅲ类水质达到比例87.5%</span>
				</div>				
				<div class="sub-title">
					<span><span class="em">完成情况：</span>省考断面Ⅰ～Ⅲ类水质达到比例67.5%</span>
				</div>				
				<div class="chart-box" id="pictorialBarChart2"></div>
			</div>
			<!--面板主内容 over-->
			
			<!--面板主内容-->
			<div class="box-body">
				<div class="box-top">
					<!-- <a href="#" target="" class="more fr">详情</a> -->
					<span class="title">
						<span>小流域</span>
					</span>					
				</div>
				<div class="layui-form">
					<div class="layui-inline">
				     <select name="" lay-filter="basin">
				       <option value="" id="reachScale">小流域考核断面Ⅰ～Ⅲ类水质比例达76.4%以上</option>
				       <option value="0" id="ReduceScale">北京</option>
				     </select>
				   </div>
				</div>
				<div class="sub-title">
					<span class="completed">已完成</span>
					<span><span class="em">目标：</span>小流域考核断面Ⅰ～Ⅲ类水质达到比例87.5%</span>
				</div>				
				<div class="sub-title">
					<span><span class="em">完成情况：</span>自建站点考核断面Ⅰ～Ⅲ类水质比例达58.4%以上</span>
				</div>				
				<div class="chart-box" id="pictorialBarChart3"></div>
			</div>
			
		</div>
	</div>
	<!--首页面板 over-->
	
	
</div>
<!-- 中  over-->
<div class="ca"></div>
<!-- 日目标管理 -->
<div class="home-layout" id="targetManage">
<!--首页面板-->
	<div class="home-water-panel">
		<div class="home-water-panel-header">
			<!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
			<span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>日目标管理</span>
			</span>
			<span class="other">2019.01.01~2019.05.28</span>
		</div>
		<div class="home-water-panel-body">
			<!--面板主内容-->
			<div class="box-body target-manage-list">
				
		       <div class="home-water-option">
		           <a class="select-tag ">达标大气</a>  <a>达标fsfsf大</a>  <a>达标sfsf大</a>  <a>达标sfsf大</a>
		       </div>
				
				<div class="item">
					<div class="home-border-panel water-blue">
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
					<div class="home-border-panel water-blue">
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
					<div class="home-border-panel water-green">
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
					<div class="home-border-panel water-yellow">
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
					<div class="home-border-panel water-orange">
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
					<div class="home-border-panel water-red">
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
					<div class="home-border-panel water-gray">
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
					<div class="home-border-panel water-yellow">
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





<!--  水弹窗  开始 -->
<div class="new-water-show">
    <div class="center-box">
        <a class="water-close"><img src="${request.contextPath}/static/images/new-popup/water-close-icon_03.png"></a>
        <div class="data-info">
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/left-icon.png">
                <span> 国控断面详情 </span>
                <img src="${request.contextPath}/static/images/new-popup/right-icon.png">
            </h3>
            <div class="option-box">
                <a class="select-tag">达标断面 </a>
                <a>未达标断面 </a>
            </div>
            <div class="option-list">
                <a class="select-tag">龙岩(2)</a>  <a>龙岩(2)</a>  <a>龙岩(2)</a>  <a>龙岩(2)</a>
            </div>
            <div class="list-data">
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a >详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/drop-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month2">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month3">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month4">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month5">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month6">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/rise-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/rise-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span>目标：III</span>
                            <span>2019年均值：III</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data">
                            <div class="month-item">
                                <span>1月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>2月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>3月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>4月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item alone-month">
                                <span>5月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>6月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>7月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>8月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>9月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>10月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>11月</span>
                                <span>III</span>
                            </div>
                            <div class="month-item">
                                <span>12月</span>
                                <span>III</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  水弹窗 结束 -->




</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	layui.use('form', function(){
	  var form = layui.form;
	  //监听提交
	  form.on('select(basin)', function(data){
	    alert(data.value);
	    alert(data.elem[data.value].innerText);
	    console.log(data.elem);
	    return false;
	  });
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
            top:'18',
            left: '80',
            right: '20',
            bottom: '18',
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
                            color:'#ff6262',
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
                            color:'#61f651',
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
                            color:'#61f651',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar
                

            ],
        };
        pictorialBarChart3.setOption(pictorialBarOption3);
        
       

    });

</script>

<!--  弹窗  js -->
<script>

    //水环境弹窗
    $(".water-open").click(function () {
        $(".new-water-show").css("display","flex")
    })
    //水环境弹窗隐藏
    $(".water-close").click(function () {
        $(".new-water-show").css("display","none")
    })

    //水环境头部 日目标管理 点击切换样式
   $(".home-water-option a").click(function () {
       $(".home-water-option a").removeClass("select-tag")
       $(this).addClass("select-tag")
   })
	//水环境头部 导航 点击切换样式
	$(".water-nav li a").click(function () {
        $(".water-nav li a").removeClass("nav-item-select")
        $(this).addClass("nav-item-select")
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

</script>

</html>