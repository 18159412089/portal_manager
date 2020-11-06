<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>漳州环保决策指挥中心</title>
	<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
	<#include "/decorators/header.ftl"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
	
	
	<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
	
	<style type="text/css">
	    
	</style>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<div class="map-container">
	<div class="map-wrapper"></div><!-- 地图层  -->
	<!-- 工具栏 -->
	<div class="map-app-container">
		<div class="btn-tool" data-toggle="shown" data-target=".map-user-container">
			<span class="icon iconcustom icon-renyuan2"></span>
		</div>
	</div>
	<!-- 工具栏 over -->
	<!--人员列表-->    
	<div class="map-user-container show">
		<div class="map-user-box">
			<!--人员信息-->
			<div class="user-number">
				<div class="user-online"><span class="icon entypo-user"></span> 在线：<span id="onlineUserNum">2</span></div>
				<div class="user-offline"><span class="icon entypo-user"></span> 总数：<span id="allUserNum">2316</span></div>
				<div class="close" data-close=".map-user-container">×</div>
			</div>
			<!--人员信息 over-->
			<!--搜索框-->
			<div class="user-search">
				<div class="user-search-box">
					<input id="user-search-input" class="map-search-input" placeholder="搜索人员..." value="" type="text">
					<button id="user-search-button" class="user-search-button" title="搜索" type="button"><span class="icon fa-search"></span></button>
				</div>
			</div>
			<!--搜索框 over-->
			<!--功能按钮-->
			<div class="user-button">
				<div class="button" id="userSearch">
					<span class="icon iconcustom icon-shaixuan1"></span>筛选
				</div>
				<div class="button" id="userRefresh">
					<span class="icon iconcustom icon-shuaxin1"></span>刷新
				</div>
			</div>
			<!--功能按钮 over-->
			<div class="filter-container">
				<div class="btn-group">
					<div class="btn all active">
						全部
					</div>
					<div class="btn online">
						在线
					</div>
				</div>
			</div>
			<!--所有人员-->
			<div id="userListDiv" class="user-list-container all">
			
				<div class="personnel-info offline-user">
					<div class="personnel-header">
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>							
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
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>							
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
				<div class="personnel-info">
					<div class="personnel-header">
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>							
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
				
			</div>
			<div id="user-pagination" class="pagination-box all ca" style="display: block;">
                <div id="page-container" class="page-container"></div>
			</div>
			<!--所有人员  over-->
			<!--在线人员  -->
			<div id="onlineListDiv" class="user-list-container online">
			
				<div class="personnel-info offline-user">
					<div class="personnel-header">
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
                                <div id="" class="function video-tag"><span class="icon iconcustom icon-shipin2"></span>视频</div>
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>
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
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>							
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
				<div class="personnel-info">
					<div class="personnel-header">
						<img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
					</div>
					<div class="personnel-content">
						<div class="info">
							<div class="name fl">杨博文</div>
							<div class="fr">
								<div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>							
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
				
			</div>
			<div id="user-pagination" class="pagination-box all ca" >
                <div id="page-container2" class="page-container"></div>
			</div>
			<!--在线人员  over-->
		</div>
	</div>
	<!--人员列表 over-->
	
	<!--案件列表-->
	<div class="map-caselist-container show">
		<!--地图应用 切换-->
		<div class="map-app-container">
			<div class="filter-marker-container style-tabs">
				<div class="btn-group">
					<div class="btn grid-all">
						<span class="icon fa-screenshot"></span><span>网格数据</span>
					</div>
					<div class="btn task active">
						<span class="icon iconcustom icon-renwuguanli1"></span><span>任务管理</span>
					</div>
					<div class="btn report">
						<span class="icon iconcustom icon-huanjing1"></span><span>环境事件</span>
					</div>
					<div class="btn petition">
						<span class="icon iconcustom icon-xuncha1"></span><span>巡检事件</span>
					</div>
					<div class="btn cult">
						<span class="icon iconcustom icon-shenhe1"></span><span>专项排查</span>
					</div>
				</div>
			</div>
		
		</div>	
		<!--地图应用 切换 over-->
		<div class="btn-collapse active" data-toggle="shown" data-target=".map-caselist-container">
			<span class="icon fa-angle-left"></span>
		</div>
		<div class="map-case-list-box">
			<div class="map-case-list allCaseList">
				<div class="list-title">
					环境事件
					<div class="user-button fr">
						<div class="btn btn-case-list active" data-radio="caselist">
							<span class="icon iconcustom icon-xiangqing1"></span>
						</div>
						<div class="btn btn-case-chart" data-radio="caselist">
							<span class="icon iconcustom icon-shujujiankong2"></span>
						</div>
						<div class="btn btn-find">
							<span class="icon iconcustom icon-shaixuan1"></span>
						</div>
						<div class="btn btn-refresh">
							<span class="icon iconcustom icon-shuaxin1"></span>
						</div>
					</div>
					<div class="search-container">
						<div>
							<input id="searchInput" class="search-input" placeholder="存在问题描述" type="text"/>
						</div>
						<div>
							<fjzx:componentCustomDate fjzx_field_strat="reportTimeStart" fjzx_field_end="reportTimeEnd" fjzx_field_name="searchReportTime" fjzx_field_tip_name="上报时间"></fjzx:componentCustomDate>
						</div>
						<div style="display:none;">
							<fjzx:componentDate fjzx_nullable="true" fjzx_field_name="reportTimeStart" fjzx_field_placeholder="上报时间开始" fjzx_field_tip_name="上报时间开始" fjzx_style="width:256px;"></fjzx:componentDate>
						</div>
						<div style="display:none;">
							<fjzx:componentDate fjzx_nullable="true" fjzx_field_name="reportTimeEnd" fjzx_field_placeholder="上报时间结束" fjzx_field_tip_name="上报时间结束" fjzx_style="width:256px;"></fjzx:componentDate>
						</div>
						<div style="margin-top:10px;">
							<button id="btn-search" class="easyui-linkbutton btn-primary" type="submit">
								<span class="icon fa-search"> 查询</span>
							</button>
						</div>
					</div>
					
				</div>
				<!-- 搜索 -->
				<div class="user-search">
					<div class="user-search-box">
						<input id="user-search-input" class="map-search-input"  placeholder="搜索..." value="" type="text"/>
						<button id="user-search-button" class="user-search-button" title="搜索" type="button"><span class="icon fa-search"></span></button>
					</div>
				</div>
				<div class="filter-container">
					<div class="btn-group">
						<div class="btn all active" data-statusType = "">
							<span>全部</span>
						</div>
						<div class="btn waiting" data-statusType = "REGISTER">
							<span>已登记</span>
						</div>
					</div>				
				</div>
				<ul style="position:absolute;top:132px;bottom:36px;left: 0;right: 0;overflow:auto;" id="reportList">
					<li>				          				
					  <div class="task-list-box">
						  <div class="task-content">
						      <div class="task-title">西湖生态园片区棚户区改造01地块施工扬尘较大</div>
						      <ul class="mui-table-view task-info-list">
						        <li><span class="icon entypo-location"></span>中国福建省漳州市芗城区胜利西路381号在智能快装集成装饰附近</li>	
						        <li><span class="icon entypo-user"></span>黄金兰<div class="task-other r"> 2019-08-02 06:56:34 </div></li>
						      </ul>
						      <div class="task-list-top">
						        <div class="task-style mui-pull-right disable"> 结案</div>
						        <div class="task-opt-list">
						          <div class="btn-opt">
						            <span class="icon iconcustom icon-dingwei3"></span>定位
						          </div>
						          <div class="btn-opt show-case-detail" data-id="1ES8rjB355sa76IDqr8PGW">
						            <span class="icon iconcustom icon-shenhe1"></span>详情
						          </div>
						        </div>
						      </div>
					      </div>
				      </div>
				    </li>
					<li>				          				
					  <div class="task-list-box">
						  <div class="task-content">
						      <div class="task-title">西湖生态园片区棚户区改造01地块施工扬尘较大</div>
						      <ul class="mui-table-view task-info-list">
						        <li><span class="icon entypo-location"></span>中国福建省漳州市芗城区胜利西路381号在智能快装集成装饰附近</li>	
						        <li><span class="icon entypo-user"></span>黄金兰<div class="task-other r"> 2019-08-02 06:56:34 </div></li>
						      </ul>
						      <div class="task-list-top">
						        <div class="task-style mui-pull-right waiting"> 待处理 </div>
						        <div class="task-opt-list">
						          <div class="btn-opt">
						            <span class="icon iconcustom icon-dingwei3"></span>定位
						          </div>
						          <div class="btn-opt show-case-detail" data-id="1ES8rjB355sa76IDqr8PGW">
						            <span class="icon iconcustom icon-shenhe1"></span>详情
						          </div>
						        </div>
						      </div>
					      </div>
				      </div>
				    </li>
					<li>				          				
					  <div class="task-list-box">
						  <div class="task-content">
						      <div class="task-title">西湖生态园片区棚户区改造01地块施工扬尘较大</div>
						      <ul class="mui-table-view task-info-list">
						        <li><span class="icon entypo-location"></span>中国福建省漳州市芗城区胜利西路381号在智能快装集成装饰附近</li>	
						        <li><span class="icon entypo-user"></span>黄金兰<div class="task-other r"> 2019-08-02 06:56:34 </div></li>
						      </ul>
						      <div class="task-list-top">
						        <div class="task-style mui-pull-right completed"> 处理中 </div>
						        <div class="task-opt-list">
						          <div class="btn-opt">
						            <span class="icon iconcustom icon-dingwei3"></span>定位
						          </div>
						          <div class="btn-opt show-case-detail" data-id="1ES8rjB355sa76IDqr8PGW">
						            <span class="icon iconcustom icon-shenhe1"></span>详情
						          </div>
						        </div>
						      </div>
					      </div>
				      </div>
				    </li>
					<li>				          				
					  <div class="task-list-box">
						  <div class="task-content">
						      <div class="task-title">西湖生态园片区棚户区改造01地块施工扬尘较大</div>
						      <ul class="mui-table-view task-info-list">
						        <li><span class="icon entypo-location"></span>中国福建省漳州市芗城区胜利西路381号在智能快装集成装饰附近</li>	
						        <li><span class="icon entypo-user"></span>黄金兰<div class="task-other r"> 2019-08-02 06:56:34 </div></li>
						      </ul>
						      <div class="task-list-top">
						        <div class="task-style mui-pull-right waiting"> 待处理 </div>
						        <div class="task-opt-list">
						          <div class="btn-opt">
						            <span class="icon iconcustom icon-dingwei3"></span>定位
						          </div>
						          <div class="btn-opt show-case-detail" data-id="1ES8rjB355sa76IDqr8PGW">
						            <span class="icon iconcustom icon-shenhe1"></span>详情
						          </div>
						        </div>
						      </div>
					      </div>
				      </div>
				    </li>
				
				</ul>
				<div class="pagination-box ca">
					<ul class="pagination" id="paginationContent"></ul>
				</div>
				<!-- 统计数据 -->
				<div class="case-chart-container">			
					<!-- 进度条 -->
					<div class="case-chart-progress">
						<div class="progress-container">
							<div class="case-icon fl" style="background:#ed7474;">
								<span class="icon iconcustom icon-renwuguanli1"></span>
							</div>						
							<div class="progress-percent fr">80%</div>
							<div class="oh">
								<div class="case-title">
									<span class="state">待处理</span>
									<span>12</span>件
								</div>
								<div class="progress">
									<div class="progress-bar" data-type="progressbar" aria-valuenow="80" aria-valuemax="100" bar-bgColor="#ededed" bar-color="#ed7474" bar-stroke-width="12" bar-font="auto"></div>
								</div>
							</div>
						</div>
						<div class="progress-container">
							<div class="case-icon fl" style="background:#f8af1d;">
								<span class="icon iconcustom icon-renwu2"></span>
							</div>						
							<div class="progress-percent fr">80%</div>
							<div class="oh">
								<div class="case-title">
									<span class="state">处理中</span>
									<span>12</span>件
								</div>
								<div class="progress">
									<div class="progress-bar" data-type="progressbar" aria-valuenow="80" aria-valuemax="100" bar-bgColor="#ededed" bar-color="#f8af1d" bar-stroke-width="12" bar-font="auto"></div>
								</div>
							</div>
						</div>
						<div class="progress-container">
							<div class="case-icon fl" style="background:#42abff;">
								<span class="icon iconcustom icon-renwu1"></span>
							</div>						
							<div class="progress-percent fr">80%</div>
							<div class="oh">
								<div class="case-title">
									<span class="state">结案</span>
									<span>12</span>件
								</div>
								<div class="progress">
									<div class="progress-bar" data-type="progressbar" aria-valuenow="80" aria-valuemax="100" bar-bgColor="#ededed" bar-color="#42abff" bar-stroke-width="12" bar-font="auto"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- 进度条   over-->
					<!-- 总计-->
					<div class="case-total-container">
						<div class="number">135</div>
						<div class="title">环境事件总数</div>
					</div>
					<!-- 总计   over-->
					<!-- chart环形图-->
					<div style="width: 100%;height: 250px;">
						<div id="caseChart" style="width:100%;height:100%;"></div>
					</div>
					<!-- chart环形图   over-->
					
					
				</div>
				<!-- 统计数据  over-->
				
				
				
			</div>
		
		</div>
		
	
	</div>
</div>
<!--弹窗-->
<div id="dd" class="easyui-dialog" title="My Dialog"   style="width:900px;height:600px;"
    data-options="title:'在线视频调度',closed: true,resizable:true,modal:true,maximizable:true">
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

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">  
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    layui.use('laypage', function(){
        var laypage = layui.laypage;
        //执行一个laypage实例
        laypage.render({
            elem: 'page-container'
            ,count: 1000
            ,first: false
            ,last: false
            ,theme:'#45b97c'
            ,groups:3

        });

        laypage.render({
            elem: 'page-container2'
            ,count: 1000
            ,first: false
            ,last: false
            ,theme:'#45b97c'
            ,groups:3

        });
//        laypage.render({
//            elem: '', //注意，这里的 test1 是 ID，不用加 # 号
//            count: 10,//数据总数，从服务端得到
//            theme:'#45b97c',
//            groups:3
//
//        });
    });
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
      	//右边列表左边的菜单栏，显示菜单被选中状态
	    $('.btn-group').on('click','.btn',function(){
        	var $parent = $(this).parents('.btn-group');
        	var $all = $parent.find(".btn");
        	$all.removeClass("active");
            $(this).addClass("active");
        });
	  	//右边列表左边的菜单栏
        $('.filter-marker-container .btn-group').on('click','.btn',function(){
            var $target = $('.map-caselist-container');
			if(!$target.hasClass("show")){
				$target.addClass("show");
				$target.find('.btn-collapse').addClass("active");
			}
        	
            if($(this).hasClass("task")){
            	$(".map-caselist-container .map-case-list").hide();
            	$(".map-case-list.task").show();
            }
            if($(this).hasClass("report")){
            	$(".map-caselist-container .map-case-list").hide();
            	$(".map-case-list.report").show();
            }
            if($(this).hasClass("petition")){
            	$(".map-caselist-container .map-case-list").hide();
            	$(".map-case-list.petition").show();
            }
            if($(this).hasClass("cult")){
            	$(".map-caselist-container .map-case-list").hide();
            	$(".map-case-list.cult").show();
            }
            if($(this).hasClass("grid-all")){
            	
            }
        });
      
      
    	//人员列表框的关闭按钮，即缩起人员列表框
        $("[data-close]").on('click',function(){
            var $t = $(this);
            var $target = $($t.attr("data-close"));
            if($target.hasClass("show")){
                $target.removeClass("show");
            }else{
                $target.addClass("show");
            }
        });
      //小于1366人员列表默认关闭
		var body_w = $('body').width();
		if(body_w<1366){
			$('.map-user-container').removeClass('show');
		}
		if(body_w<1200){
			var $target = $('.map-caselist-container');
			$target.removeClass("show");
			$target.find('.btn-collapse').removeClass("active");
		}
		
		//人员列表记录点击效果
        $('.user-list-container').on('click','.personnel-info',function(){
			$(this).siblings(".personnel-info").removeClass("active");
			$(this).addClass("active");
        });
      //人员列表状态按钮
        $('.map-user-box .btn-group').on('click','.btn',function(){
        	$(".map-user-container .user-list-container").hide();
        	$(".map-user-container .pagination-box").hide();
            if($(this).hasClass("all")){
            	//全部
            	$(".map-user-container .user-list-container.all").show();
            	$(".map-user-container .pagination-box.all").show();
            }
            if($(this).hasClass("online")){
            	//在线
            	$(".map-user-container .user-list-container.online").show();
            	$(".map-user-container .pagination-box.online").show();
            }
        });
    	
      
      /*------
      	右侧列表
      --------*/
        $('.allCaseList').children("ul").on('click','li',function(){
			$(this).siblings("li").removeClass("active");
			$(this).addClass("active");
			//方法				
        });
		
	    //btn-group
	    $('.btn-group').on('click','.btn',function(){
        	var $parent=$(this).parents('.btn-group');
        	var $all=$parent.find(".btn");
        	$all.removeClass("active");
            $(this).addClass("active");
        });
	    
        $("#btn-search").click(function(){
        	$("#user-search-input").val($("#searchInput").val());
        	
    		$('.search-container').css('display','none');
    		$(this).removeClass("active");
        });
        $("#user-search-button").click(function(){
        	$("#searchInput").val($("#user-search-input").val());
        	
        	$('.search-container').css('display','none');
    		$(this).removeClass("active");
        });


        $(".btn-find").click(function(){
        	var display = $('.search-container').css('display');
        	
        	if(display==="none"){
        		$('.search-container').css('display','block');
        		$(this).addClass("active");
        	}else{
        		$('.search-container').css('display','none');
        		$(this).removeClass("active");
        	}
        });
        
        
        
        /*---------------------------------------环境事件pie-------------------------------------------*/
		// 基于准备好的dom，初始化echarts实例
		var caseChartChart = echarts.init(document.getElementById('caseChart'));
		var caseChartOption = {
			/* title: {
				text: '',
				left: 'center',
				top: '3%',
				textStyle: {
					color: '#464646',
					fontSize:'14',
					fontWeight:'normal'
				}
			}, */
			tooltip : {
				trigger: 'item',
				formatter: "{a} <br/>{b} : {c} ({d}%)"
			},
			legend: {
				orient: 'horizontal',
				width:'80%',
				left: 'center',
				bottom: '3%',
				itemWidth:16,
				itemHeight:10,
				textStyle:{
					color:"#464646",
					fontSize:12
				},
				data: ['待处理','处理中','结案']
			},
			series : [
				{
					name: '环境事件',
					type: 'pie',
					radius : ['35%', '60%'],
					center: ['50%', '45%'],
					label: {
		                normal: {
		                    formatter: '{tit|{b}}\n{c}件，{d}%',
		                    rich: {
		                        tit: {
		                            fontSize:14,
		                            color: '#666',
		                            lineHeight: 22
		                        }
		                    }
		                }
		            },
					data:[
						{value:850, name:'待处理',itemStyle: {normal: {color: '#ed7474'}}},
						{value:42, name:'处理中',itemStyle: {normal: {color: '#f8af1d'}}},
						{value:235, name:'结案',itemStyle: {normal: {color: '#42abff'}}}
					],						
					itemStyle: {
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					}
				}
			]
		};
		
		/*数据图表的显示隐藏*/
        if($(".case-chart-container").hasClass("show")){
        	alert("444");
        	$(".btn-case-chart").trigger("click.data.radio");
			// 使用刚指定的配置项和数据显示图表。
			caseChartChart.setOption(caseChartOption);
        }
        $("body").on("click.show","[data-radio]",function(){
        	alert("444555");
        	var $t=$(this);
        	if($t.hasClass("btn-case-chart")){
        		$(".case-chart-container").addClass("show");
        		//刷新数据图表
        		caseChartChart.resize();
    			caseChartChart.setOption(caseChartOption);
        	}else{
        		$(".case-chart-container").removeClass("show");
        	}
        });
      
      
      
      
    	//打开弹窗
    	//dialogOpen('#dd');
		$(".video-tag").click(function () {
            dialogOpen('#dd');
        })
    });
    $(window).resize(function() {
		//监听窗口变化，小于1366人员列表默认关闭
		var body_w = $('body').width();
		if(body_w<1366){
			$('.map-user-container').removeClass('show');
		}else{
			$('.map-user-container').addClass('show');
		}
		
		var $target = $('.map-caselist-container');
		if(body_w<1200){
			$target.removeClass("show");
			$target.find('.btn-collapse').removeClass("active");
		}else{
			$target.addClass("show");
			$target.find('.btn-collapse').addClass("active");
		}
	});

</script>

</html>