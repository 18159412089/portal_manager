/*头部导航翻页按钮*/
var pageNub = $(".nav-ul-tag").height() / 70;
var page = 0;
var flag = 1;//判断是否是第一次加载
var liwith=0;//li的长度等于多少根据li长度判断是多少页;
/*头部导航翻页按钮*/
$(function () {
    $('.nav-ul-tag').find('li').each(function (index) {
        if ($(this).find('a')[0].href.split("menu")[0] == window.location.href.split("menu")[0]) {
            $(this).addClass("select-link");
            liwith += $(this).outerWidth();
            page = parseInt(liwith / 640)+1;
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
    if(pageNub>1){
        $(".nav-menu-tag").show()
    }else {
        $(".nav-menu-tag").hide()
    }
//        getPage(3)
    //上一页
    $(".nav-prev").click(function () {
        if(page==1){
            $(".nav-menu-tag a").removeClass("invalid-menu")
            $(this).addClass("invalid-menu")
        }
        if(page>1){
            page--
            if(page==1){
                $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu");
                $(this).addClass("invalid-menu")
            }else{
                var Remainder = $(".nav-ul-tag").height()- (70*(page))
                $(".nav-ul-tag").animate({'margin-top': "-"+Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        }
    })
    /*下一页*/
    $(".nav-next").click(function () {
        if(page!=pageNub){
            page++
        }
        if(page==pageNub){
            var Remainder = $(".nav-ul-tag").height() -70;
            $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
            $(".nav-menu-tag a").removeClass("invalid-menu")
            $(this).addClass("invalid-menu")

        }
        if(page<pageNub &&page!=pageNub){
            var Remainder = $(".nav-ul-tag").height() - (70 * (page))
            $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
            $(".nav-menu-tag a").removeClass("invalid-menu")
        }
    })
    function getpage(s){
        page=s
        if(page==pageNub){
            var Remainder = $(".nav-ul-tag").height() -70;
            $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
            $(".nav-menu-tag a").removeClass("invalid-menu")
            $(".nav-menu-tag .nav-next").addClass("invalid-menu")

        }
        if(page==1){
            $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
            $(".nav-menu-tag a").removeClass("invalid-menu");
            $(".nav-menu-tag .nav-prev").addClass("invalid-menu")
        }
        if(page>1&&page!=pageNub){
            var Remainder = $(".nav-ul-tag").height()- (70*(page))
            $(".nav-ul-tag").animate({'margin-top': "-"+Remainder}, 250);
            $(".nav-menu-tag a").removeClass("invalid-menu")
        }
    }
})
