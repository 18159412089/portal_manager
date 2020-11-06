/**********************************************************
 ##########################################################
 ###################  首页的js  ###################
 ##########################################################
 **********************************************************/

var menu = "";

$(function () {
    tabClose();
    tabCloseEven();
    $('#tabs').tabs().tabs({
        /*tab标签页 切换刷新*/
        onSelect: function (title) {
            var currTab = $('#tabs').tabs('getTab', title);
            var iframe = $(currTab.panel('options').content);
            var src = iframe.attr('src');
            $('.easyui-accordion li').removeClass("active");
            $('.easyui-accordion li').each(function () {
               if( $(this).find("a").find("span").text()==title){
                   $(this).addClass("active").parent().parent().show()
                   $(this).addClass("active")
               }
           })





            if (src)
                $('#tabs').tabs('update', {tab: currTab, options: {content: createFrame(src)}});

        }
    });


    $(document).on('click', '.toggle-icon', function () {
        $(this).closest("#pf-bd").toggleClass("toggle");
        setTimeout(function () {
            $(window).resize();
        }, 300)
    });
    //使用动态菜单不需要使用后端请求testData
    //     return;
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/env/mainPage/testData.do',
        data: {
            type: $("#type").val()
        },
        async: true,
        success: function (result) {
            var menus = eval(result);
            menu = menus;

            if ($("#category").val() != "") {
                var id = "";
                var pointCode = $("#pointCode").val();
                var category = $("#category").val();
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();

                if (category == "1") {
                    id = "8511a160-e9a7-4617-9104-4c696eb601aa";
                } else if (category == "2") {
                    id = "8511a160-e9a7-4617-9104-4c69632a8aa"
                } else if (category == "3") {
                    id = "8511a160-e9a7-4617-9104-4c69eacb18aa";
                } else if (category == "4") {
                    id = "9841111a-7808-4a48-bf10-5d5a3fa01d12";
                } else if (category == "5") {
                    id = "9222206a-7808-4a48-bf10-5d5a3fa01d11";
                } else if (category == "6") {//大屏展示实时数据显示(水质自动实时监测)点击详情跳转标注当category==6的情况
                    id = "8511a160-e9a7-4617-9104-4c69eacb18aa";
                    InitLeftMenu(menus, id, 0, 0, 0);
                    return;
                } else if (category == "7") {//大屏展示实时数据显示(水质自动实时监测)点击详情跳转标注当category==6的情况
	                id = "8511a460-e9a7-4617-9104-4c696eb601aa";
	                InitLeftMenu(menus, id);
	                return;
	            }

                if (category == "4" || category == "5") {
                    InitLeftMenu(menus, id);
                } else {
                    InitLeftMenu(menus, id, pointCode, startTime, endTime);
                }
            } else {
                InitLeftMenu2(menus);
                var children = menus[0].children;
                addTab(children[0].name, Ams.ctxPath + children[0].url, children.id);
            }
        }
    });

});

//初始化左侧菜单
function InitLeftMenu2(children) {
    $("#nav").accordion({animate: false});
    var firstChoose = true;
    $.each(children, function (i, n) {
        var flag = false;
        var menuList = '';
        menuList += '<ul>';
        if (typeof n.children !== "undefined") {
            if (n.url != "#") {
                menuList += '<li>' +
                    '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + n.name + '</span></a>' +
                    '</li> ';
            }
            $.each(n.children, function (j, o) {
                if (firstChoose) {
                    flag = true;
	                menuList += '<li class="active">' +
	                    '<a href="#" id="' + o.id + '" rel="' + o.url.replace("*", "") + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
	                    '<span class="nav">' + o.name + '</span></a>' +
	                    '</li> ';
	                firstChoose = false;
                }else{
	                menuList += '<li>' +
                    '<a href="#" id="' + o.id + '" rel="' + o.url.replace("*", "") + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + o.name + '</span></a>' +
                    '</li> ';
                }
            });
        } else {
            menuList += '<li>' +
                '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                '<span class="nav">' + n.name + '</span></a>' +
                '</li> ';
        }
        menuList += '</ul>';

        $('#nav').accordion('add', {
            title: '<span class="iconfont sider-nav-icon" >&#xe69a;</span><span class="sider-nav-title">' + n.name + '</span><i class="iconfont">&#xe642;</i>',
            content: menuList,
            selected: flag
        });

        flag = false;
    });

    $('.easyui-accordion li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var url = Ams.ctxPath + $(this).attr("rel");
        var menuid = $(this).attr("id");
        var icon = $(this).attr("icon");

        addTab(tabTitle, url, icon, menuid);
        $('.easyui-accordion li').removeClass("active");
        $(this).parent().addClass("active");
    });
}

//初始化左侧菜单并选中指定url
function InitLeftMenu(children, id, pointCode, startTime, endTime) {
    $("#nav").accordion({animate: false});
    var response_url = "";
    var response_name = "";
    var response_id = "";

    $.each(children, function (i, n) {
        var flag = false;
        var menuList = '';
        menuList += '<ul>';
        if (typeof n.children !== "undefined") {
            if (n.url != "#") {
                menuList += '<li>' +
                    '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + n.name + '</span></a>' +
                    '</li> ';
            }
            $.each(n.children, function (j, o) {
                var clazz = "";
                if (o.id == id) {
                    flag = true;
                    clazz = ' class="active"';
                    response_url = o.url.replace("*", "");
                    response_name = o.name;
                    response_id = o.id;
                }
                menuList += '<li' + clazz + '>' +
                    '<a href="#" id="' + o.id + '" rel="' + o.url.replace("*", "") + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + o.name + '</span></a>' +
                    '</li> ';
            });
        } else {
            menuList += '<li>' +
                '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                '<span class="nav">' + n.name + '</span></a>' +
                '</li> ';
        }
        menuList += '</ul>';

        $('#nav').accordion('add', {
            title: '<span class="iconfont sider-nav-icon" >&#xe69a;</span><span class="sider-nav-title">' + n.name + '</span><i class="iconfont">&#xe642;</i>',
            content: menuList,
            selected: flag
        });
        flag = false;
    });

    $('.easyui-accordion li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var url = Ams.ctxPath + $(this).attr("rel");
        var menuid = $(this).attr("id");
        var icon = $(this).attr("icon");

        addTab(tabTitle, url, icon, menuid);
        $('.easyui-accordion li').removeClass("active");
        $(this).parent().addClass("active");
    });

    addTab(response_name, Ams.ctxPath + response_url + "?pointCode=" + pointCode + "&startTime=" + startTime + "&endTime=" + endTime, "icon-2012081511767", id)
}

//初始化左侧菜单并选中指定air 的  url
function InitLeftMenu(children, id) {
    $("#nav").accordion({animate: false});
    var response_url = "";
    var response_name = "";
    var response_id = "";

    $.each(children, function (i, n) {
        var flag = false;
        var menuList = '';
        menuList += '<ul>';
        if (typeof n.children !== "undefined") {
            if (n.url != "#") {
                menuList += '<li>' +
                    '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + n.name + '</span></a>' +
                    '</li> ';
            }
            $.each(n.children, function (j, o) {
                var clazz = "";
                if (o.id == id) {
                    flag = true;
                    clazz = ' class="active"';
                    response_url = o.url.replace("*", "");
                    response_name = o.name;
                    response_id = o.id;
                }
                menuList += '<li' + clazz + '>' +
                    '<a href="#" id="' + o.id + '" rel="' + o.url.replace("*", "") + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + o.name + '</span></a>' +
                    '</li> ';
            });
        } else {
            menuList += '<li>' +
                '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                '<span class="nav">' + n.name + '</span></a>' +
                '</li> ';
        }
        menuList += '</ul>';

        $('#nav').accordion('add', {
            title: '<span class="iconfont sider-nav-icon" >&#xe69a;</span><span class="sider-nav-title">' + n.name + '</span><i class="iconfont">&#xe642;</i>',
            content: menuList,
            selected: flag
        });
        flag = false;
    });

    $('.easyui-accordion li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var url = Ams.ctxPath + $(this).attr("rel");
        var menuid = $(this).attr("id");
        var icon = $(this).attr("icon");

        addTab(tabTitle, url, icon, menuid);
        $('.easyui-accordion li').removeClass("active");
        $(this).parent().addClass("active");
        console.info($(this).parent().attr("id"))
    });

    addTab(response_name, Ams.ctxPath + response_url, "icon-2012081511767", response_id)
}

function refreshLeftMenu(children, id){
    $("#nav").accordion({animate: false});
	$("#nav").html("");
    $.each(children, function (i, n) {
        var flag = false;
        var menuList = '';
        menuList += '<ul>';
        if (typeof n.children !== "undefined") {
            if (n.url != "#") {
                menuList += '<li>' +
                    '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + n.name + '</span></a>' +
                    '</li> ';
            }
            $.each(n.children, function (j, o) {
                var clazz = "";
                if (o.id == id) {
                    flag = true;
                    clazz = ' class="active"';
                }
                menuList += '<li' + clazz + '>' +
                    '<a href="#" id="' + o.id + '" rel="' + o.url.replace("*", "") + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
                    '<span class="nav">' + o.name + '</span></a>' +
                    '</li> ';
            });
        } else {
            menuList += '<li>' +
                '<a href="#" id="' + n.id + '" rel="' + n.url.replace("*", "") + '" icon="' + n.icon + '"><i class="iconfont">&#xe617;</i>' +
                '<span class="nav">' + n.name + '</span></a>' +
                '</li> ';
        }
        menuList += '</ul>';

        $('#nav').accordion('add', {
            title: '<span class="iconfont sider-nav-icon" >&#xe69a;</span><span class="sider-nav-title">' + n.name + '</span><i class="iconfont">&#xe642;</i>',
            content: menuList,
            selected: flag
        });
        flag = false;
    });

    $('.easyui-accordion li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var url = Ams.ctxPath + $(this).attr("rel");
        var menuid = $(this).attr("id");
        var icon = $(this).attr("icon");

        addTab(tabTitle, url, icon, menuid);
        $('.easyui-accordion li').removeClass("active");
        $(this).parent().addClass("active");
    });
}

function addTab(subtitle, url, icon, id) {
    if (!$('#tabs').tabs('exists', subtitle)) {
        $('#tabs').tabs('add', {
        	id:id,
            title: subtitle,
            content: createFrame(url),
            closable: true,
            icon: icon
        });
    } else {
        $('#tabs').tabs('select', subtitle);
        // 	$('#mm-tabupdate').click();
        var tab = $('#tabs').tabs('getTab', subtitle);
        var iframe = $(tab.panel('options').content);
        var src = iframe.attr('src');
        if (src)
            $('#tabs').tabs('update', {tab: tab, options: {content: createFrame(url)}});
    }
    tabClose(id);
}

function createFrame(url) {
    return '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;padding:10px;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;"></iframe>';
}

function tabClose(id) {
    /*双击关闭TAB选项卡*/
    $(".tabs-inner").dblclick(function () {
        var subtitle = $(this).children(".tabs-closable").text();
        $('#tabs').tabs('close', subtitle);
    })
    /*为选项卡绑定右键*/
    $(".tabs-inner").bind('contextmenu', function (e) {
        $('#mm').menu('show', {
            left: e.pageX,
            top: e.pageY
        });

        var subtitle = $(this).children(".tabs-closable").text();

        $('#mm').data("currtab", subtitle);
        $('#tabs').tabs('select', subtitle);
        return false;
    });
    $(".tabs-inner").bind('click', function (e) {
    	var tabTitle = ($(this).find(".tabs-title").html());
    	$(this).attr('id', id);
//    	console.info(id);
//    	refreshLeftMenu(menu, id);
//    	$('#nav .panel').accordion('selected',false);
    	$('.easyui-accordion li').removeClass("active");
    	$('.easyui-accordion li #'+id).parent().addClass("active");
    });
}

//绑定右键菜单事件
function tabCloseEven() {
    //刷新
    $('#mm-tabupdate').click(function () {
        var currTab = $('#tabs').tabs('getSelected');
        var url = $(currTab.panel('options').content).attr('src');
        $('#tabs').tabs('update', {
            tab: currTab,
            options: {
                content: createFrame(url)
            }
        })
    })
    //关闭当前
    $('#mm-tabclose').click(function () {
        var currtab_title = $('#mm').data("currtab");
        $('#tabs').tabs('close', currtab_title);
    })
    //全部关闭
    $('#mm-tabcloseall').click(function () {
        $('.tabs-inner span').each(function (i, n) {
            var t = $(n).text();
            $('#tabs').tabs('close', t);
        });
    });
    //关闭除当前之外的TAB
    $('#mm-tabcloseother').click(function () {
        $('#mm-tabcloseright').click();
        $('#mm-tabcloseleft').click();
    });
    //关闭当前右侧的TAB
    $('#mm-tabcloseright').click(function () {
        var nextall = $('.tabs-selected').nextAll();
        if (nextall.length === 0) {
            //msgShow('系统提示','后边没有啦~~','error');
            return false;
        }
        nextall.each(function (i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tabs').tabs('close', t);
        });
        return false;
    });
    //关闭当前左侧的TAB
    $('#mm-tabcloseleft').click(function () {
        var prevall = $('.tabs-selected').prevAll();
        if (prevall.length === 0) {
            return false;
        }
        prevall.each(function (i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tabs').tabs('close', t);
        });
        return false;
    });

    //退出
    $("#mm-exit").click(function () {
        $('#mm').menu('hide');
    })
}

//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
    $.messager.alert(title, msgString, msgType);
}
