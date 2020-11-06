<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>污染溯源</title>

</head>
<!-- body -->
<body class="">
<#include "/common/loadingDiv.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/animate.min.css" >
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/wow.min.js"></script>

<script>


</script>
<!-- 头部 -->
<div id="pf-hd"  class="pf-head">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云-水环境
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="${request.contextPath}/static/images/main/user.png" alt="">
        </div>
        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
        <i class="iconfont xiala">&#xe607;</i>

        <div class="pf-user-panel">
            <ul class="pf-user-opt">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <li class="pf-modify-pwd" id="editpass">
                    <a href="#" >
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload">
                    <a href="#" >
                        <i class="iconfont">&#xe670;</i>
                        <span class="pf-opt-name">下载操作手册</span>
                    </a>
                </li>
                <li class="pf-logout" id="loginOut">
                    <a href="#" >
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
<#--  当导航只有一级开始-->
    <div  class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
                <li class="select-link">
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li >
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-gongzuoguanli1"></i>
                        <span class="title">水环境服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-fenzhi"></i>
                        <span class="title"> 污染溯源</span>
                    </a>
                </li>
                <li>
                    <a href="#" target="_blank">
                        <i class="icon iconcustom icon-shuju2""></i>
                        <span class="title"> 数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-jianguan1"></i>
                        <span class="title"> 总体情况</span>
                    </a>
                </li>
                <li>
                    <a  href="#"  target="_blank">
                        <i class="icon iconcustom icon-jibenxinxi1"></i>
                        <span class="title">一河一策</span>
                    </a>
                </li>


            </ul>
        </div>
        <div class="nav-menu-tag">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>

</div>
<!-- 头部 over  -->
<!-- 主体 -->
<div class="home-pollute-container">
    <div class="home-panel-bg">
        <div class="bg-left"></div>
        <div class="bg-right"></div>
        <div class="bg-bottom-left"></div>
        <div class="bg-bottom-right"></div>
        <div class="bg-bottom"></div>
    </div>
	<!-- 左 -->
	<div class="home-layout fl" id="home-left">
		<!--首页面板-->
		<div class="home-panel">
            <div class="home-panel-header">
                <a href="${request.contextPath}/indextemp20" target="" class="more fr">详情</a>
                <span class="title">
					<span>九龙江</span>
				</span>
            </div>
            <div class="home-panel-body">
			<!--面板主内容-->
				<a href="${request.contextPath}/indextemp20" class="map-info-container">
					<div class="map-info-img">
                        <img src="${request.contextPath}/static/images/pollute/map_img.png" alt=""/>
					</div>
                    <div class="map-info-content">
						<ul class="map-info-list">
							<li class="item">
								<div class="title">国控断面</div>
								<div>4个</div>
							</li>
							<li class="item">
								<div class="title">污水处理厂</div>
								<div>12座</div>
							</li>
							<li class="item">
								<div class="title">水闸</div>
								<div>15座</div>
							</li>
							<li class="item">
								<div class="title">总处理能力</div>
								<div>35万吨</div>
							</li>
						</ul>

					</div>
				</a>
			<!--面板主内容 over-->
			</div>
		</div>
		<!--首页面板 over-->
        <!--首页面板-->
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>九龙江</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="map-info-container">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/pollute/map_img.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div>4个</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div>12座</div>
                            </li>
                            <li class="item">
                                <div class="title">水闸</div>
                                <div>15座</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>35万吨</div>
                            </li>
                        </ul>

                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>九龙江</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="map-info-container">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/pollute/map_img.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div>4个</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div>12座</div>
                            </li>
                            <li class="item">
                                <div class="title">水闸</div>
                                <div>15座</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>35万吨</div>
                            </li>
                        </ul>

                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-panel">
            <div class="home-panel-header">
                <span class="title">
					<span>九龙江</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="map-info-container">
                    <div class="map-info-img">
                        <img src="${request.contextPath}/static/images/pollute/map_img.png" alt="">
                    </div>
                    <div class="map-info-content">
                        <ul class="map-info-list">
                            <li class="item">
                                <div class="title">国控断面</div>
                                <div>4个</div>
                            </li>
                            <li class="item">
                                <div class="title">污水处理厂</div>
                                <div>12座</div>
                            </li>
                            <li class="item">
                                <div class="title">水闸</div>
                                <div>15座</div>
                            </li>
                            <li class="item">
                                <div class="title">总处理能力</div>
                                <div>35万吨</div>
                            </li>
                        </ul>

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
        <div class="home-panel" id="rankingTOP10">
            <div class="home-panel-header">
                <span class="title">
					<span>预计排放企业top10</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="" class="easyui-datagrid" url=""
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
        <div class="home-panel" id="rankingTOP5">
            <div class="home-panel-header">
                <span class="title">
					<span>实际与预计不符TOP5</span>
				</span>
            </div>
            <div class="home-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="" class="easyui-datagrid" url=""
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
	<!-- 右  over-->
	<!-- 地图 -->
	<div class="home-layout oh" id="homeMap">
		<!--首页面板-->
        <div class="home-panel">
            <!--面板主内容-->
            <div class="map-container">
                <div class="map-tool"></div>
                <div class="map-wrapper"></div><!--地图图层-->


            </div>
            <!--面板主内容 over-->
        </div>
		<!--首页面板 over-->
	</div>
	<!-- 地图  over-->
	<div class="ca"></div>

</div>
<!-- 主体 over  -->


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

    	
    	//打开弹窗
    	//dialogOpen('#dd');

        
    });

</script>


</html>