<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>企业综合分析</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<div id="pf-hd" style="position: absolute;width:100%;">
	<span class="pf-logo">
   		<img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
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
                <li class="pf-modify-pwd">
                    <a href="#" id="editpass">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li class="pf-logout">
                    <a href="#" id="loginOut">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
    <!-- main -->
    <div class="map-wrapper" style="background: url('${request.contextPath}/static/images/map_bg.png') center;"></div>
    <!-- 地图层(真实添加地图时，删除style) -->


    <!-- 图例  -->
    <div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;">
        <div class="grade-legend">
            <div class="legend">
                <span class="item level-1"></span>Ⅰ
                <span class="item level-2"></span>Ⅱ
                <span class="item level-3"></span>Ⅲ
                <span class="item level-4"></span>Ⅳ <br/>
                <span class="item level-5"></span>Ⅴ
                <span class="item level-6"></span>Ⅵ
                <span class="item level-0"></span>劣Ⅴ
                <span class="item"></span>未知
            </div>
        </div>
    </div>
    <!-- 图例 over -->

    <div class="map-panel panel-top" style="position:absolute;top:86px;left:30px;width:360px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				企业综合分析监控
			</span>
         </div>
         <div class="map-panel-body" style="height: 448px;">
         	<div class="map-panel-subtext tl">
         		<span class="title">AQI指数</span>
         		<div class="info">
					<span>对健康影响情况：空气质量令人满意，基本无空气污染</span>
					<span>建议采取的措施：各类人群可正常活动</span>
				</div>
         	</div>
         	<div class="panel-group-container" id="cityPanel" style="height: 300px;">         		
         		<div class="panel-group-box">
         			<div class="panel-group-top">
         				各监测站点实时数据：<span class="subtext fr">单位：μg/m3（CO为mg/m3）</span>
         			</div>
         			<div class="panel-group-body" style="height: 170px;">
         				<table id="dg" class="easyui-datagrid" style="width:100%;height:100%"
						       url="${request.contextPath}/sys/role/list" data-options="
										rownumbers:false,
						                striped:true,
										fitColumns:true">
						    <thead>
						    <tr>
						        <th field="name" width="120">名称</th>
						        <th field="code" width="120">编号</th>
						        <th field="num" width="60">排序</th>
						        <th field="remark" width="60">备注</th>
						        <th field="updateDate" width="100">修改时间</th>
						    </tr>
						    </thead>
						</table>	
         			</div>
         		</div>
         		
         		
         	</div>
         </div>
    </div>

    <div class="map-panel panel-top collapsed" style="position:absolute;left:240px;bottom:18px;right:58px;">
        <div class="map-panel-header">
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				企业排口综合分析数据详情
			</span>
        </div>
        <div class="map-panel-body" style="height: 264px;width:100%;">
            <div class="panel-group-container oh" style="height: 100%;">
                    <div class="panel-group-top">
                       XXX 企业<span class="subtext fr">2019.1.18  14:43</span>
                    </div>
                    <div class="panel-group-body" style="height: 223px;">
                        <table id="dg" class="easyui-datagrid" style="width:100%px;height:100%"
						       url="${request.contextPath}/sys/role/list" data-options="
										rownumbers:false,
						                striped:true,
										fitColumns:true">
						    <thead>
						    <tr>
						        <th field="name" width="120">名称</th>
						        <th field="code" width="120">编号</th>
						        <th field="num" width="60">排序</th>
						        <th field="remark" width="60">备注</th>
						        <th field="updateDate" width="100">修改时间</th>
						    </tr>
						    </thead>
						</table>	
                    </div>
                </div>


        </div>
    </div>



    <!-- main over -->
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function () {
        $(".map-panel-header").on("click", function () {
            var $target = $(this).parent();
            if ($target.hasClass("collapsed")) {
                $target.removeClass("collapsed");
                WaterPollutionBar.resize();
                WatertypeBar.resize();
                WaterIndexBar.resize();
            } else {
                $target.addClass("collapsed");
            }
        });

        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");

        });



        


    });
    $(window).resize(function () {

    });

</script>

</body>

</html>