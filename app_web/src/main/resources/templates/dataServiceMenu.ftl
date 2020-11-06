<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<style>
    .nav-box {
        float: left;
    }

    #pf-hd .pf-logo {
        border-right: 1px solid #45b97c;
    }

    .nav-box > ul > li {
        position: relative;
        float: left;
        min-width: 110px;
    }

    .nav-box > ul > li > a {
        width: 100%;
        display: inline-block;
        text-align: center;
        color: white;
        font-size: 15px;
        height: 70px;
    }

    .nav-box > ul > li > a i {
        display: inline-block;
        font-size: 28px;
        margin-top: 10px;
    }

    .nav-box > ul > li > a span {
        display: inline-block;
        width: 100%;
        font-size: 14px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    .nav-box > ul > li:hover a {
        background-color: white;
        color: #504f4f
    }

    .nav-box > ul > li:hover > .second-level {
        display: block
    }

    .nav-box > ul > li.active > a {
        color: #4a4a4a;
        background: #fff;
        -webkit-box-shadow: none;
        -moz-box-shadow: none;
        box-shadow: none;
    }

    .nav-box > ul > li.active > a {
        background: #eef3ee;
    }

    .nav-box > ul > li > .second-level {
        position: absolute;
        top: 70px;
        left: 0;
        display: none;
        box-shadow: 2px 2px 8px #e3e3e3;
        overflow: hidden;
    }

    .nav-box > ul > li > .many-columns {
        width: 516px;
        background-color: white
    }

    .nav-box > ul > li > .second-level li {
        background-color: white;
        width: 258px;
        float: left;
    }

    .nav-box > ul > li > .second-level li > a {
        display: inline-block;
        padding: 14px 12px;
        width: 100%
    }

    .nav-box > ul > li > .second-level li > a:hover {
        background-color: #7ccda4
    }

    .nav-box > ul > li > .second-level li > a:hover i {
        color: white
    }

    .nav-box > ul > li > .second-level li > a:hover span {
        color: white
    }

    .nav-box > ul > li > .second-level li > a i {
        font-size: 28px;
        border: 0px;
        float: left;
    }

    .nav-box > ul > li > .second-level li > a span {
        display: inline-block;
        margin-left: 15px;
        overflow: hidden;
        font-size: 16px;
        float: left
    }

    .nav-box > ul > li .select-a {
        background-color: white !important;
        pointer-events：none
    }

    .nav-box > ul > li .select-a i {
        color: white
    }

    .nav-box > ul > li .select-a span {
        color: white
    }

    .nav-box-one {
        display: none
    }

    .nav-container {
        display: inline-block
    }

    .switch-tag {
        display: inline-block;
        color: #bbb8b8;
        height: 70px;
        padding: 14px 0;
        width: 24px;
        margin-left: 20px;
    }

    .switch-tag span {
        display: inline-block;
        width: 24px;
        float: left;
        font-size: 16px;
        padding: 2px 0;
        text-align: center;
        cursor: pointer;
        background-color: #fbfbfb;
        border-top-left-radius: 4px;
        border-top-right-radius: 4px;
    }

    .switch-tag span:nth-child(2) {
        margin-top: 4px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
    }

    .switch-tag span:hover {
        color: #45b97c !important;
    }

    @media screen and (max-width: 1450px) {
        .nav-box > ul > li {
            min-width: 96px;
            max-width: 100px;
        }
    }
</style>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 数据服务
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
                    <a href="${request.contextPath}/env/mainPage/main.do?type=AQI&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">空气环境质量</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=waterData&menu=dataServiceMenu"
                       tab_id="d4" target="_self">
                        <i class="icon iconcustom icon-shidu1"></i>
                        <span class="title">水环境质量</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=HYD&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-shuidianzhan"></i>
                        <span class="title">水电站</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/wtcd/mainPage/main.do?type=WTCD&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-shuiliting"></i>
                        <span class="title">水利厅数据</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=AREA&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-jinanhaiyangdianweixinxi"></i>
                        <span class="title">近岸海域</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/rivers/mainPage/main.do?type=RIVERS&menu=dataServiceMenu"
                       tab_id="d4" target="_self">
                        <i class="icon iconcustom icon-ruhaiheliudianweixinxi"></i>
                        <span class="title">入海河流信息</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/sea/mainPage/main.do?type=SEA&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-haiyangyuyuye"></i>
                        <span class="title">省海洋与渔业厅数据</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=pollutantSource&menu=dataServiceMenu"
                       tab_id="d4" target="_self">
                        <i class="icon iconcustom icon-shidu2"></i>
                        <span class="title">污染源专题</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enter/mainPage/main.do?type=ENTER&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-shidu2"></i>
                        <span class="title">污染源档案</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=VI&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-tousu1"></i>
                        <span class="title">信访投诉</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/env/mainPage/main.do?type=HAZ&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <span class="title">固危废管理</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/rad/mainPage/main.do?type=RAD&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-fangsheyuan1"></i>
                        <span class="title">核与辐射管理</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/risk/mainPage/main.do?type=RISK&menu=dataServiceMenu" tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-fengxianwuzhi2"></i>
                        <span class="title">风险源信息</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/baseinfo/mainPage/main.do?type=BASEINFO&menu=dataServiceMenu"
                       tab_id="d4"
                       target="_self">
                        <i class="icon iconcustom icon-shuiliting"></i>
                        <span class="title">环境质量基本信息</span>
                    </a>
                </li>
            </ul>
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
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/poc/menu.js" charset="utf-8"></script>
<script>
$(function() {
    $.ajax({
        type: 'GET',
        url: Ams.ctxPath + '/sys/menu/getSecondMenu',
        data: {pid: '190481ab-289b-496d-87ee-ae3548c75445'},
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
                if ((window.location.pathname + window.location.search) == url) {
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