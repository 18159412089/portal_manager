<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 一本账
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
                <#--<@sec.authorize access="hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN') OR hasRole('ROLE_LEADER')">-->
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe630;</i>
                        <span class="pf-opt-name" id="editRole" onclick="enterEdit()">进入编辑</span>
                    </a>
                </li>
                <#-- </@sec.authorize>-->
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
                <li>
                    <a href="${request.contextPath}/index" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <div class="title">首页</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/attach/environmentAttachDisplay?authority=1"
                       target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">总体情况</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/attach/environmentAttachTask?authority=1"
                       target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">总体情况汇总表</div>
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
        data: {pid: 'f14c8fe4-1855-4fc4-8eda-749ce3db9c4c'},
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
                    htm += '<li class="select-link"><a href="' + url + '?authority=1" title=' + result[i].name + ' tab_id="d4" target="' + target + '">'
                    + '<i class="icon iconcustom ' + result[i].icon + '"></i><span class="title">'
                    + result[i].name + '</span></a></li>';
                } else {
                    htm += '<li><a href="' + url + '?authority=1" title=' + result[i].name + ' tab_id="d4" target="' + target + '">'
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