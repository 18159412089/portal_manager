/**
 * 
 */
/*打开dialog*/
function homeDialogOpen(target){
    var sWidth=$(target).outerWidth();
    var pWidth=$(target).parent().outerWidth();
    var sHeight=$(target).outerHeight();
    var pHeight=$(target).parent().outerHeight();

    sWidth=sWidth<pWidth?sWidth:pWidth-40;
    sHeight=sHeight<pHeight?sHeight:pHeight-40;
    bodyHeight=sHeight-176;
    var sLeft=(pWidth-sWidth)/2;
    var sTop=(pHeight-sHeight)/2;

    $(target).addClass("show").css({
        "left":sLeft+"px",
        "top":sTop+"px",
        "width":sWidth+"px",
        "height":sHeight+"px"
    });
    $(target).children(".home-window-body").height(bodyHeight);
}
var pri_panel_h;
$(function(){
    //右边列表的缩起/展开小按钮
    $('body').on('click','[data-toggle="shown"]',function(){
        var target = $(this).attr("data-target");
        var $target = $(target);
        if($target.hasClass("show")){
            $target.removeClass("show");
            $(this).removeClass("active");
        }else {
            $target.addClass("show");
            $(this).addClass("active");
        }
    });
	//右边列表的缩起/展开小按钮
    $('.panel-collapse-container').on('click','.panel-collapse-header',function(e){
        var $this = $(this);
        var $target = $this.siblings(".panel-collapse-body");
        var $table=$target.find(".easyui-datagrid");
        var $tables=$this.offsetParent().find(".easyui-datagrid");
        /*$target.slideToggle(function(){
            if($(this).is(":visible")){
                $this.removeClass("collapsed");
            }else{
                $this.addClass("collapsed");
            };
        });*/
        if ($this.hasClass("collapsed")){
            $target.slideDown(function () {
                //如果存在easyui-datagrid展开后刷新表格大小
                if($target.find(".easyui-datagrid").length){
                    $tables.datagrid("resize").datagrid("resize");
                }
            });
            //如果存在easyui-datagrid刷新显示表格
            if($target.find(".easyui-datagrid").length) {
                //用于判断第一次展开刷新easyUI-table
                if ($table.datagrid("getPanel").width() === 0) {
                    setTimeout(
                        function () {
                            $table.datagrid("resize").datagrid("resize");
                        }
                     ,100);
                }
            }
            $this.removeClass("collapsed");
		}else {
            $target.slideUp(function () {
                //如果存在easyui-datagrid折叠后刷新表格大小
                if($target.find(".easyui-datagrid").length){
                    $tables.datagrid("resize").datagrid("resize");
                }
            });
            $this.addClass("collapsed");
		}
    });

	//pri_panel_h=$(".panel.window.window-thinborder.panel-htop").height();
	//dialog_Auto_Height();

    //大屏弹出框关闭
    $("body").on("click",".home-window-header .close",function () {
        $(this).parents(".home-window").removeClass("show");
    })

});
$(window).resize(function(){
    //dialog_Auto_Height();
});
function dialog_Auto_Height(){	
	var panel_h=$(".panel.window.window-thinborder.panel-htop").height();
	var body_h=$("html.panel-fit body.panel-noscroll").height();
	var h=body_h-160;
	if(panel_h>body_h || pri_panel_h>panel_h ){
		$("#dlg").css({"height":h+"px"});
		$(".window-shadow").css({"height":h+"px"});
/*	    $('#dlg').dialog({
	        height:h
	    }).dialog("open").dialog('center').dialog('setTitle','新增部门');*/
	}
	
}


