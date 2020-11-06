$.extend($.fn.datagrid.defaults, {
	onBeforeFetch: function(page){},
	onFetch: function(page, rows){}
});
 
 
var myview = $.extend({},$.fn.datagrid.defaults.view,{
    onAfterRender:function(target){
        $.fn.datagrid.defaults.view.onAfterRender.call(this,target);
        var opts = $(target).datagrid('options');
        var vc = $(target).datagrid('getPanel').children('div.datagrid-view');
 
        vc.children('div.datagrid-empty').remove();
        if (!$(target).datagrid('getRows').length){
        	 alert(3);
        	 console.log(opts.emptyMsg);
            var d = $('<div class="datagrid-empty"></div>').html(opts.emptyMsg || 'no records').appendTo(vc);
            d.css({
                position:'absolute',
                left:0,
                top:50,
                width:'100%',
                textAlign:'center'
            });
        }
    }
});