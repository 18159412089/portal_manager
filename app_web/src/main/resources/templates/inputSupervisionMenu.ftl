<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 突出生态环境问题
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
                <#-- <@sec.authorize access="hasAuthority('LEADER') OR hasAuthority('ADMIN')"> -->
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe630;</i>
                        <span class="pf-opt-name" id="editRole" onclick="enterEdit()">退出编辑</span>
                    </a>
                </li>
                <#-- </@sec.authorize> -->
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
                    <a href="${request.contextPath}/environment/rectifition/show" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">总体情况</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/rectifition/rectifitionListIntex" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">整改汇总表</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/envCancellationAccount/show" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">销号概况</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/envCancellationAccount/index" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">销号汇总表</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/debrief/StandingBook" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">具体台账</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/rectifition/responsibleList" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">责任名单</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/distributeMap/map?authority=1" target="_self">
                        <i class="icon iconcustom icon-zichan3"></i>
                        <div class="title">地图分布</div>
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
<script>
    /*头部导航翻页按钮*/
    var pageNub = $(".nav-ul-tag").height() / 70;
    var page = 0;
    var flag = 1;//判断是否是第一次加载
    var liwith = 0;//li的长度等于多少根据li长度判断是多少页;
    /*头部导航翻页按钮*/
    $(function () {
        $.ajax({
            type: 'GET',
            url: Ams.ctxPath + '/sys/menu/getSecondMenu',
            data: {pid: '3c1e3468-4b23-4d7c-a17a-8d43799cf67d'},
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
        
        $('.nav-ul-tag').find('li').each(function (index) {
            if ($(this).find('a')[0].href.split("?")[0] == window.location.href.split("?")[0]) {
                $(this).addClass("select-link");
                liwith += $(this).outerWidth();
                page = parseInt(liwith / 640) + 1;
                getpage(page)
            } else {
                $(this).removeClass("select-link");
                liwith += $(this).outerWidth();
            }
            $(this).click(function () {
                if ($(this).find('a')[0].href == window.location.href) {
                    return false;
                }
            })
        });
        if (pageNub > 1) {
            $(".nav-menu-tag").show()
        } else {
            $(".nav-menu-tag").hide()
        }
//        getPage(3)
        //上一页
        $(".nav-prev").click(function () {
            if (page == 1) {
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")
            }
            if (page > 1) {
                page--
                if (page == 1) {
                    $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu");
                    $(this).addClass("invalid-menu")
                } else {
                    var Remainder = $(".nav-ul-tag").height() - (70 * (page))
                    $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu")
                }
            }
        })
        /*下一页*/
        $(".nav-next").click(function () {
            if (page != pageNub) {
                page++
            }
            if (page == pageNub) {
                var Remainder = $(".nav-ul-tag").height() - 70;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")

            }
            if (page < pageNub && page != pageNub) {
                var Remainder = $(".nav-ul-tag").height() - (70 * (page))
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        })

        function getpage(s) {
            page = s
            if (page == pageNub) {
                var Remainder = $(".nav-ul-tag").height() - 70;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(".nav-menu-tag .nav-next").addClass("invalid-menu")

            }
            if (page == 1) {
                $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu");
                $(".nav-menu-tag .nav-prev").addClass("invalid-menu")
            }
            if (page > 1 && page != pageNub) {
                var Remainder = $(".nav-ul-tag").height() - (70 * (page))
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        }
    })
</script>