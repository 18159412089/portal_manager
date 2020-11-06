<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 水环境
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
                    <a href="#">
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
                    <a href="#">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
                <li class="select-link">
                    <a href="${request.contextPath}/index" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/water/nationalSurfaceWater" tab_id="d4" title="国家水质自动检测"
                       target="_self">
                        <i class="icon iconcustom icon-shidu1"></i>
                        <span class="title">水环境服务</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=newWaterDataService&menu=waterEnvironmentMenu"
                       tab_id="d4" title="数据服务" target="_self">
                        <i class="icon iconcustom icon-huanjing3"></i>
                        <span class="title">数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/water/nationalSurfaceWater/waterIndex" tab_id="d4"
                       title="水环境图表" target="_self">
                        <i class="icon iconcustom icon-shidu1"></i>
                        <span class="title">水环境汇报</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/hydposition/hydpositoninfo/hydPositionMap" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-shuidianzhan"></i>
                        <span class="title">水电站</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/sea/seaSiteInfo/gotoSeaInfoMap" tab_id="d4" title="省海洋与渔业厅"
                       target="_self">
                        <i class="icon iconcustom icon-haiyangyuyuye"></i>
                        <span class="title">省海洋与渔业厅</span>
                    </a>
                </li>
                <li>
                    <a href='${request.contextPath}/wtcd/wtcdMap/wtcdMap.do?menu=waterEnvironmentMenu'
                       tab_id="d4" title="水利厅数据" target="_self">
                        <i class="icon iconcustom icon-shuiliting"></i>
                        <span class="title">水利厅数据</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/rivers/riversSiteInfo/gotoRiversSiteMap" tab_id="d4" title="省海洋与渔业厅"
                       target="_self">
                        <i class="icon iconcustom icon-ruhaiheliudianweixinxi"></i>
                        <span class="title">入海河流信息</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/area/siteInfo/gotoAreaSiteInfoMap" tab_id="d4" title="近岸海域信息"
                       target="_self">
                        <i class="icon iconcustom icon-jinanhaiyangdianweixinxi"></i>
                        <span class="title">近岸海域信息</span>
                    </a>
                </li>
                <li>
                    <a href="https://140.237.73.123:8092/JointServiceBase" target="_blank" tab_id="d4"
                       title="网格员任务派发" target="_self">
                        <i class="icon iconcustom icon-jinanhaiyangdianweixinxi"></i>
                        <span class="title">网格员任务派发</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/water/userContcatInfo/index" tab_id="d4" title="应急短信下发"
                       target="_self">
                        <i class="icon iconcustom icon-shidu1"></i>
                        <span class="title">应急短信下发</span>
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
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/poc/menu.js" charset="utf-8"></script>
<script>

$(function() {
    $.ajax({
        type: 'GET',
        url: Ams.ctxPath + '/sys/menu/getSecondMenu',
        data: {pid: 'd7aa1b75-6893-4091-8452-9c9a1ebf8369'},
        success: function (result) {
            var data = eval(result);
            var url = "";
            var target = "_self";
            var htm = '<li><a href="${request.contextPath}/index" target="_self">'
                + '<i class="icon iconcustom icon-shouye1"></i><span class="title">首页</span></a></li>';
            for(var i=0; i<result.length; i++){
                if (result[i].url.indexOf("*") != -1) {
                    url = result[i].url.replace("*", "");
                    target = "_blank";
                } else {
                    url = result[i].url;
                    target = "_self";
                }
                if (window.location.pathname == url) {
                    htm += '<li class="select-link"><a href="' + url + '" title=' + result[i].name + ' tab_id="d4" target="' + target + '">'
                    + '<i class="icon iconcustom ' + result[i].icon + '"></i><span class="title">'
                    + result[i].name + '</span></a></li>';
                } else {
	                htm += '<li><a href="' + url + '" title=' + result[i].name + ' tab_id="d4" target="' + target + '">'
	                    + '<i class="icon iconcustom ' + result[i].icon + '"></i><span class="title">'
	                    + result[i].name + '</span></a></li>';
                }
            }
            $(".nav-ul-tag").html(htm);
        },
        dataType: 'json'
    });
});
</script>