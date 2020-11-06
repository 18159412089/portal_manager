(function($){
	function createunitbox(target){
		var opts = $.data(target, 'unitbox').options;
		$(target).textbox($.extend({}, opts));
		$(target).textbox('textbox').bind("click", function () { 
			$('#bb').dialog('open').dialog('center').dialog('setTitle', '新增部门');
		})
	}
	
	$.fn.unitbox = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.unitbox.methods[options];
			if (method){
				return method(this, param);
			} else {
				return this.textbox(options, param);
			}
		}
		
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'unitbox');
			
			
			if (state){
				$.extend(state.options, options);
			} else {
				$.data(this, 'unitbox', {
					options: $.extend({}, $.fn.unitbox.defaults, $.fn.unitbox.parseOptions(this), options)
				});
			}
			createunitbox(this);
		});
	};
	
	$.fn.unitbox.methods = {
		options: function(jq){
			return $.data(jq[0], 'unitbox').options;
		}
	};
	
	$.fn.unitbox.parseOptions = function(target){
		var t = $(target);
		return $.extend({}, $.fn.textbox.parseOptions(target), {
			selectType: (t.attr('selectType') ? t.attr('selectType') : undefined)
		});
	};
	
	$.fn.unitbox.defaults = $.extend({}, $.fn.textbox.defaults, {
		selectType:"Dept"
	});
	$.fn.unitbox.defaults.icons = [{
        iconCls: 'icon-clear',
        handler: function (e) {
            $(e.handleObj.data.target).unitbox('clear');
        }
    }];
	$.parser.plugins.push("unitbox");
})(jQuery);