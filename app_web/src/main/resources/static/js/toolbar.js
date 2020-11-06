/**********************************************************
 ##########################################################
 ###################  前台菜单栏的js  ###################
 ##########################################################
 **********************************************************/


$(function () {
/*	var frontMenu = eval($('#frontMenu').val());
	InitMenuBar(frontMenu);*/
	
	$.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/sys/menu/getFrontMenu',
        success: function (data) {
        	//首页导航先不动态加载
        	InitMenuBar(data);
        },
        dataType: 'json'
    });
	
});

//初始化前端菜单栏
function InitMenuBar(menus) {
	var menuBar='';
	var bar = '';
	menuBar += '<ul>';
    $.each(menus, function (i, n) {
        var menuList = '';
        var active = '';
        if (n.url == window.location.pathname){
            //url相同时为选中状态
            active = 'class="active"';
        }
        if(n.url == "#") {
            menuList += '<li><a href="#" target="_self">'
                + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
        } else if(n.url == "*") {
            //url=*时    获取子菜单中的URL
            var childrenUrl = '';
            if (typeof n.children !== "undefined" && n.children != null) {
                childrenUrl = n.children[0].url;
            }
            if(childrenUrl.indexOf("*") != -1){
                menuList += '<li><a href="'+ childrenUrl.replace("*","") +'" target="_blank">'
                + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
            }else{
                menuList += '<li><a href="'+ childrenUrl +'" target="_self">'
                + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
            }
        } else {
            var url = n.url;
            if(url.indexOf("*") != -1){
                menuList += '<li><a href="'+ url.replace("*","") +'" target="_blank">'
                + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
            }else{
                menuList += '<li '+ active +'><a href="'+ url +'" target="_self">'
                + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
            }
        }
        
        if(n.url != "*") {
            //URL!=*的 才加载子菜单
            if (typeof n.children !== "undefined" && n.children != null) {
                var length = n.children.length;
                if(length>10){
                    menuList += '<ul class="second-level many-columns">';
                }else{
                    menuList += '<ul class="second-level">';
                }
                $.each(n.children, function (j, o) {
                    var url = o.url;
                    if(url.indexOf("*") != -1){
                        menuList += '<li><a href="'+ url.replace("*","") +'" target="_blank" tab_id="d4" title="'+ o.name +'">'
                            + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ o.name +'</span></a></li>';
                    }else{
                        menuList += '<li><a href="'+ url +'" target="_self" tab_id="d4" title="'+ o.name +'">'
                        + '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ o.name +'</span></a></li>';
                    }
                });
                menuList += '</ul>';
            }
        }
        
        /*if(n.url != "#"){
        	var url = n.url;
        	if(url.indexOf("*") != -1){
        		menuList += '<li><a href="'+ url.replace("*","") +'" target="_blank">'
        		+ '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
        	}else{
        		menuList += '<li><a href="'+ n.url +'" target="_self">'
        		+ '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
        	}
        }else{
        	menuList += '<li><a href="#" target="_self">'
        	+ '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a>';
        }
        if (typeof n.children !== "undefined" && n.children != null) {
        	var length = n.children.length;
        	if(length>10){
            	menuList += '<ul class="second-level many-columns">';
        	}else{
            	menuList += '<ul class="second-level">';
        	}
            $.each(n.children, function (j, o) {
            	var url = o.url;
            	if(url.indexOf("*") != -1){
            		menuList += '<li><a href="'+ url.replace("*","") +'" target="_blank" tab_id="d4" title="'+ o.name +'">'
						+ '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ o.name +'</span></a></li>';
            	}else{
            		menuList += '<li><a href="'+ url +'" target="_self" tab_id="d4" title="'+ o.name +'">'
					+ '<i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ o.name +'</span></a></li>';
            	}
            });
            menuList += '</ul>';
        }*/
        menuList += '</li>';
        bar += menuList;
    });
    menuBar += bar + '</ul>';
    $(".nav-box").html(menuBar);
}
