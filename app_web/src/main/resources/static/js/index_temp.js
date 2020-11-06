/**********************************************************
 ##########################################################
 ###################  首页的js  ###################
 ##########################################################
 **********************************************************/


$(function () {
    tabClose();
    tabCloseEven();
    InitTopMenu();
    $('#topMenu a').click(function () {
        if ($(this).attr('id') === $('#topMenu .active').attr('id')) {
            return;
        }
        $('#topMenu a').removeClass('active');
        $(this).addClass('active');

        var children = "";
        for (var i = 0; i < menus.length; i++) {
            if ($(this).attr('id') === menus[i].id) {
                children = menus[i].children;
            }
        }
        cleanNav();
        if (typeof children !== "undefined") {
            InitLeftMenu(children)
        }
    });
    if (typeof menus[0] !== "undefined" && typeof menus[0].children !== "undefined") {
        InitLeftMenu(menus[0].children);
    }

    $('#tabs').tabs().tabs({
    	/*tab标签页 切换刷新*/
        /*onSelect: function (title) {
            var currTab = $('#tabs').tabs('getTab', title);
            var iframe = $(currTab.panel('options').content);
            var src = iframe.attr('src');
            if (src)
                $('#tabs').tabs('update', {tab: currTab, options: {content: createFrame(src)}});
        }*/
    });
    
    //头部菜单翻页
    var page = 0,
    pages = ($('.pf-nav').height() / 70) - 1;

	if(pages === 0){
	  $('.pf-nav-prev,.pf-nav-next').hide();
	}
	$(document).on('click', '.pf-nav-prev,.pf-nav-next', function(){
	
	
	  if($(this).hasClass('disabled')) return;
	  if($(this).hasClass('pf-nav-next')){
	    page++;
	    $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
	    if(page == pages){
	      $(this).addClass('disabled');
	      $('.pf-nav-prev').removeClass('disabled');
	    }else{
	      $('.pf-nav-prev').removeClass('disabled');
	    }
	    
	  }else{
	    page--;
	    $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
	    if(page == 0){
	      $(this).addClass('disabled');
	      $('.pf-nav-next').removeClass('disabled');
	    }else{
	      $('.pf-nav-next').removeClass('disabled');
	    }
	    
	  }
	});
	//左侧菜单收起
    $(document).on('click', '.toggle-icon', function() {
        $(this).closest("#pf-bd").toggleClass("toggle");
        setTimeout(function(){
        	$(window).resize();
        },300)
    });
    
     

})

//初始化顶部菜单
function InitTopMenu() {
    var menuList = "";
    for (var i = 0; i < menus.length; i++) {
        menuList += "<li class='pf-nav-item'>" +
            "<a href='#' id='" + menus[i].id +
            "'><span class='iconfont'>"+"&#xe63f;"+"</span><span class='pf-nav-title'>" + menus[i].name + "</span></a></li>";
    }
    $("#topMenu").empty();
    $("#topMenu").append(menuList);
    if (typeof menus[0] !== "undefined" && typeof menus[0].id !== "undefined") {
        $("#" + menus[0].id).addClass("active")
    }
}

//切换一级菜单清除左边选项
function cleanNav() {
    var panels = $('#nav').accordion('panels');
    var titles='';  
    if (panels){  
        $.each(panels, function(i) {  
            var title = panels[i].panel("options").title;  
            titles += title+',';  
        })  
    }   
    var arr_title = new Array();   
    arr_title = titles.split(",");  
    for (i=0;i<arr_title.length ;i++ )   
    {   
        if(arr_title[i] != ""){  
            $('#nav').accordion("remove",arr_title[i]);  
        }  
    } 
}

//初始化左侧菜单
function InitLeftMenu(children) {
    $("#nav").accordion({animate: false});

    $.each(children, function (i, n) {
        var menuList = '';
        menuList += '<ul>';
        if (typeof n.children !== "undefined") {
            $.each(n.children, function (j, o) {
                menuList += '<li>' +
                    '<a href="#" id="' + o.id + '" rel="' + o.url + '" icon="' + o.icon + '"><i class="iconfont">&#xe617;</i>' +
                    /*'<span class="icon ' + o.icon + '" >&nbsp;</span>' +*//*二级图标*/
                    '<span class="nav">' + o.name + '</span></a>' +
                    '</li> ';
            })
        }
        menuList += '</ul>';

        $('#nav').accordion('add', {
            title: '<span class="iconfont sider-nav-icon" >&#xe69a;</span><span class="sider-nav-title">'+n.name+'</span><i class="iconfont">&#xe642;</i>',
            content: menuList
         // ,iconCls: 'icon ' + n.icon /*一级图标class*/
        });
    });

    $('.easyui-accordion li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var url = Ams.ctxPath + $(this).attr("rel");
        var menuid = $(this).attr("id");
        var icon = $(this).attr("icon");

        addTab(tabTitle, url, icon);
        $('.easyui-accordion li').removeClass("active");
        $(this).parent().addClass("active");
    })/*.hover(function () {
        $(this).parent().addClass("hover");
    }, function () {
        $(this).parent().removeClass("hover");
    })*/;

    //选中第一个
    var panels = $('#nav').accordion('panels');
    if (null != panels && panels.length > 0) {
        var t = panels[0].panel('options').title;
        $('#nav').accordion('select', t);
    }
}

function addTab(subtitle, url, icon) {
    if (!$('#tabs').tabs('exists', subtitle)) {
        $('#tabs').tabs('add', {
            title: subtitle,
            content: createFrame(url),
            closable: true,
            icon: icon
        });
    } else {
    	$('#tabs').tabs('select', subtitle);
   // 	$('#mm-tabupdate').click();
    	var tab = $('#tabs').tabs('getTab',subtitle);
    	var iframe = $(tab.panel('options').content);
        var src = iframe.attr('src');
        if (src)
            $('#tabs').tabs('update', {tab: tab, options: {content: createFrame(url)}});
    }
    tabClose();
}

function createFrame(url) {
    return '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;padding:10px;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;"></iframe>';
}

function tabClose() {
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
