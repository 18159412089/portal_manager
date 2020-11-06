<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 大气环境
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
    <div  class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
            <!-- <li class="active">-->
                <li class="select-link">
                    <a href="${request.contextPath}/index" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
            <li>
                <a href="${request.contextPath}/enviromonit/airEnvironment" tab_id="d4" title="空气质量">
                    <i class="icon iconcustom icon-huanjing2"></i>
                    <span class="title">大气环境服务</span>
                </a>
            </li>
            <li class="item-link">
                <a href="${request.contextPath}/env/mainPage/main.do?type=newAirDataService&menu=airEnvironmentMenu"
                 tab_id="d4" title="数据服务" target="_self">
                    <i class="icon iconcustom icon-huanjing2"></i>
                    <span class="title">数据服务</span>
                </a>
            </li>
            <li>
                <a href="${request.contextPath}/environment/debrief/airIndex" tab_id="d4" title="空气质量">
                    <i class="icon iconcustom icon-huanjing2"></i>
                    <span class="title">大气环境汇报</span>
                </a>
            </li>
            <li>
                <a href="http://carbon.nju.edu.cn/cn/" tab_id="d4" title="空气质量预报" target="_blank">
                    <i class="icon iconcustom icon-huanjing2"></i>
                    <span class="title">空气质量预报</span>
                </a>
            </li>
            
            <li  >
				<a href="http://www.weather.com.cn/weather/101230601.shtml" tab_id="d4" title="漳州天气网" target="_blank">
              <i class="icon iconcustom icon-huanjing2"></i>
              <span class="title">漳州天气网</span>
             </a>
           </li>
           
           <li  >
				<a href="https://www.windy.com/?24.513,117.656,5,i:pressure" tab_id="d4" title="Windy MAP" target="_blank">
             <i class="icon iconcustom icon-huanjing2"></i>
             <span class="title">风向地图</span>
            </a>
          </li>
            <li class="item-link">
                <a href="https://airwise.zc12369.com/" tab_id="d4" title="AIR WISE" target="_blank">
                    <i class="icon iconcustom icon-huanjing2"></i>
                    <span class="title">AIR WISE</span>
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
            type : 'POST',
            url : Ams.ctxPath + '/sys/menu/getSecondMenu',
            data : {
                pid : "7c4eb149-2475-4cad-97c9-e4760938de3f"
            },
            async : true,
            success : function(data) {
                //InitMenuBar(data);
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
            dataType : 'json'
        });
    });

    //初始化前端菜单栏
    function InitMenuBar(menus) {
        var menuBar = '<ul class="nav header-nav">';
        var bar = '<li><a href="${request.contextPath}/index" target="_self">'
            + '<div class="icon iconcustom icon-shouye1"></div><div class="title">首页</div></a></li>';
        $.each(menus, function(i, n) {
            var menuList = '';
            var active = '';
            if (n.url == window.location.pathname) {
                active = 'class="active"';
            }
            if (n.url == "#") {
                menuList += '<li><a href="#" target="_self">' + '<i class="icon iconcustom '
                        + n.icon +'"></i><span class="title">' + n.name + '</span></a>';
            } else if (n.url == "*") {
                var childrenUrl = '';
                if (typeof n.children !== "undefined" && n.children != null) {
                    childrenUrl = n.children[0].url;
                }
                if (childrenUrl.indexOf("*") != -1) {
                    menuList += '<li><a href="' + childrenUrl.replace("*", "") + '" target="_blank">'
                            + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">' + n.name + '</span></a>';
                } else {
                    menuList += '<li><a href="'+ childrenUrl +'" target="_self">' + '<i class="icon iconcustom '
                            + n.icon +'"></i><span class="title">'+ n.name + '</span></a>';
                }
            } else {
                var url = n.url;
                if (url.indexOf("*") != -1) {
                    menuList += '<li><a href="' + url.replace("*", "") + '" target="_blank">' + '<i class="icon iconcustom '
                            + n.icon +'"></i><span class="title">' + n.name + '</span></a>';
                } else {
                    menuList += '<li '+ active +'><a href="'+ url +'" target="_self">' + '<i class="icon iconcustom '
                            + n.icon +'"></i><span class="title">'+ n.name + '</span></a>';
                }
            }

            if (n.url != "*") {
                if (typeof n.children !== "undefined" && n.children != null) {
                    var length = n.children.length;
                    if (length > 10) {
                        menuList += '<ul class="second-level many-columns">';
                    } else {
                        menuList += '<ul class="second-level">';
                    }
                    $.each(n.children, function(j, o) {
                        var url = o.url;
                        if (url.indexOf("*") != -1) {
                            menuList += '<li><a href="' + url.replace("*", "") + '" target="_blank" tab_id="d4" title="' + o.name + '">'
                                    + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">' + o.name + '</span></a></li>';
                        } else {
                            menuList += '<li><a href="'+ url +'" target="_self" tab_id="d4" title="'+ o.name +'">'
                                    + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">' + o.name + '</span></a></li>';
                        }
                    });
                    menuList += '</ul>';
                }
            }

            menuList += '</li>';
            bar += menuList;
        });
        menuBar += bar + '</ul>';
        $(".navbar").html(menuBar);
    }

</script>