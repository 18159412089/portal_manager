<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<input type="hidden" id="pid" value="${pid!}"/>
<style>
    #pf-hd{ height: 62px;}
    #pf-hd .pf-logo{ line-height: 62px;}
    .nav-container .nav-box >ul >li{height: 62px;}
    .nav-container .nav-box >ul .select-link a{ line-height: 62px;}
    .nav-container .nav-box >ul >li >a{line-height: 62px; }
    .nav-container .nav-menu-tag a{margin-top: 3px;}
    #pf-hd .pf-user{height: 62px;line-height: 62px; }
    #pf-hd .pf-user .pf-user-panel{ top: 62px;}
    .nav-container .nav-box{height: 62px}


</style>
<div id="pf-hd">
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
            <ul class="pf-user-opt" id="operateId">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <#if pid??&& pid=="fe3bd39d-7442-461f-8e39-e97aac9d60a4">
                    <li>
                        <a href="javascript:void(0);">
                            <i class="iconfont">&#xe630;</i>
                            <#if authority??&& authority=="1">
                                <span class="pf-opt-name" id="editRole" onclick="enterEdit()">进入编辑</span>
                            <#else>
                                <span class="pf-opt-name" id="editRole" onclick="enterEdit()">退出编辑</span>
                            </#if>
                        </a>
                    </li>
                </#if>
                <li class="pf-modify-pwd" id="editpass">
                    <a href="#">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload">
                    <a href="#">
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
    <#--  当导航只有一级开始-->

    <div class="nav-container">
        <div class="child-item">
            <ul id="data">

            </ul>
        </div>
        <div class="nav-box">
            <ul class="nav-ul-tag" id="second">
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
<script>
    var menus = "";
    $(function () {
        // 二级菜单事件
        var s_this;
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/sys/menu/getFrontSecondAndChileMenu',
            data: {
                pids: $("#pid").val()//"8cc443b5-53d2-4db0-b2f7-f0901df961ea"
            },
            // beforeSend: ajaxLoading,
            success: function (data) {
                menus = data;
                var second = '<li><a href="${request.contextPath}/index" target="_self"><span class="title">首页</span></a></li>';
                $.each(data, function (i, o) {
                    var target = "_blank";
                    if (o.url.indexOf("*") == -1) {
                        target = "_self";
                    }
                    var isSelected = "";
                    if (windowPathName.indexOf(o.url) != -1) {
                        isSelected = 'class="select-link"';
                    }
                    var url = o.url.replace("*", "");
                    if (url == "#") {
                        url = ""
                    } else {
                        url = 'href="' + url + '"';
                    }
                    second += '<li ' + isSelected + '><a ' + url + ' target="' + target + '"><span class="title">' + o.name + '</span></a></li>';
                });

                $("#second").html(second);
                mouseOprate();
                getPageNum();
                getChildrenColor();
            }
        });
    });
</script>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var navHeight = 62;
    function getPageNum() {
        var pageNub = $(".nav-ul-tag").height() / navHeight;// 计算当前页数
        var page = 1;// 当前所在页码

        if (pageNub > 1) {
            $(".nav-menu-tag").show()
        } else {
            $(".nav-menu-tag").hide()
        }
//        getPage(3)

        //上一页
        $(".nav-prev").click(function () {
            console.log(page)
            if (page == 1) {
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")
            }
            if (page > 1) {
                console.log(page)
                page--
                if (page == 1) {
                    $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu");
                    $(this).addClass("invalid-menu")
                } else {
                    var Remainder = $(".nav-ul-tag").height() - (navHeight * (page))
                    $(".nav-ul-tag").animate({'margin-top': "-" + (page - 1) * navHeight}, 250);
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
                var Remainder = $(".nav-ul-tag").height() - navHeight;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")

            }
            if (page < pageNub && page != pageNub) {
                $(".nav-ul-tag").animate({'margin-top': "-" + (page - 1) * navHeight}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        })

        // 设置当前页数
        function getpage() {

            if (page == pageNub) {
                var Remainder = $(".nav-ul-tag").height() - navHeight;
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
                $(".nav-ul-tag").animate({'margin-top': "-" + (page - 1) * navHeight}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        }

        //页面加载获取当前页数
        getpage()

        $(".a").click(function () {
            if ($(this).hasClass('active')) {
                // 包含active
                $(this).removeClass('active')
                // 然后移除多选操作
            } else {
                // 不包含
                $(this).addClass('active')
                // 然后添加多选操作
            }
        })
    }

    function mouseOprate() {
        $(".nav-ul-tag").find("li").mouseover(function () {
            s_this = $(this).text().trim();
            var left = $(this).offset().left;
            $(".child-item").css("left", left + "px");
            //----------添加hover-tag
            $(".nav-ul-tag").find("li").removeClass("hover-tag")
            var flag = false;
            $.each(menus, function (j, o) {
                if (s_this == o.name && o.children != null) {
                    flag = true;
                    var three = "";
                    $.each(o.children, function (i, n) {
                        var target = "_blank";
                        if (n.url.indexOf("*") == -1) {
                            target = "_self";
                        }
                        three += '<li><a href="' + n.url.replace("*", "") + '" target="' + target + '"><i class="icon iconcustom ' + n.icon + '"></i><span class="title">' + n.name + '</span></a></li>';
                    });
                    console.info(three)
                    $("#data").html(three);
                }
            });
            if (!flag) {
                $(".child-item").hide();
            } else {
                $(".child-item").show();
            }
            $(".nav-ul-tag").find("li").mouseout(function () {
                $(".child-item").hide()
            });
            $(".child-item").mouseover(function () {
                $(this).show()
                $(this).addClass("select-link")
            });
            $(".child-item").find("a").each(function () {
                if (windowPathName.indexOf($(this).attr("href").replace("&authority=1","")) != -1 && $(this).attr("href") != "*") {
                    $(this).parent("li").addClass("select_tag")
                }
            });
        });
    }

    var windowPathName = window.location.href;
    var childTreeName;

    function getChildrenColor() {
        $.each(menus, function (j, o) {
            if(Ams.isNoEmpty(o.children))
            $.each(o.children, function (index, obj) {
                if (windowPathName.indexOf(obj.url.replace("&authority=1","")) != -1 && $(this).attr("href") != "*") {
                    $(this).parent("li").addClass("select_tag")
                    $(".nav-ul-tag").find("li").each(function () {
                        if ($(this).text().trim() == o.name) {
                            childTreeName = o.name;
                            $(this).addClass("select-link");
                        }
                    });
                }
            })
        });
        $(".child-item").mouseout(function () {
            $(this).hide()
            $(this).removeClass("select-link")
        });
    }

    //进入或者退出编辑模式
    function enterEdit() {
        var authority = $("#authority").val();
        var href = window.location.href;
        //1进入编辑  2 退出编辑
        if (authority == '1') {
            window.location.href = href.replace("&authority=1", "&authority=2");
        } else {
            window.location.href = href.replace("&authority=2", "&authority=1");
        }
    }
</script>