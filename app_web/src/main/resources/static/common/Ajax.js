var AlAjax = function(action,ops) {  
	this.options = $.extend({
			requestType : 'POST',
			dataType : 'JSON',
			async : true,
			mask : true,
			callback : function(){}
	}, ops);
	this.action = (action.startsWith(Ams.ctxPath)||action.startsWith('http')) ? action : Ams.ctxPath + action;
};	
AlAjax.prototype = {
	constructor : AlAjax,
		
	submitForm : function(form) {
		this.doSubmit($(form).serializeObject());
	},
	
	doSubmit : function(params) {
		this.params = params;
		this.run();
	},  
		 
	run : function(){
		if (this.options.mask) {
	        $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
	    }
	    callback = this.options.callback;
		$.ajax(this.action,{
			type : this.options.requestType,
			data : this.params,
			async : this.options.async,
			success : function(data) {
				if (callback) {
					callback.apply(this, [ data ]);
				}
			},
			complete:function(res,status){
                $.messager.progress('close');
            },
			error : function(response, success) {
				alert(response.responseText);
			}
		});    		
	}  
};
