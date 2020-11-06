var BasePath = "https://140.237.73.123:9041/EpaProblemProcessing/";

MACRO_PACKAGE_DEFINE("fjzx.download");
//fjzx.download具有的方法一览
fjzx.download.functionList = {
	//创建下载组件的工厂函数
	createDownloader: function(){}
};
//fjzx.download方法实现
fjzx.download = {
	//创建下载组件的工厂函数
	createDownloader: function(uploadDownloadControllerId){
		return new fjzx.download.Downloader(uploadDownloadControllerId);
	}
};

fjzx.download.Downloader = function(uploadDownloadControllerId){
	this._uploadDownloadControllerId = uploadDownloadControllerId;
};
fjzx.download.Downloader.prototype = {
	download: function(params){
		var htmlStr = '<div class="loading-container">\
			<div class="loading-box">\
				<div class="loading-img"></div>\
				<div class="loading-text">正在加载中...</div>\
			</div>\
		</div>';
		//$(".fjzx-prog-page-tabs-container").append(htmlStr);
		var thisDownloader = this;
		/*this._doHead(params,function(){
			thisDownloader._doGet(params);
		});*/
        thisDownloader._doGet(params);
	},
	_doHead: function(params,onHeadOkCallback){
		var data = {uploadDownloadControllerId: this._uploadDownloadControllerId};
		for(elm in params){
			data[elm] = params[elm];
		}
		var options = {
			url: BasePath+"do.download",
			type: "head",
			data: data,
		    success: function (data, status, xhr) {
		        var resultData = JSON.parse(decodeURIComponent(xhr.getResponseHeader("UploadDownloadMessage")));
		        if(resultData.code==="ok"){
		        	if(typeof(onHeadOkCallback)==="function")
		        		onHeadOkCallback();
		        }else{
		        	if(resultData.type=="AccessException")
		        		fjzx.ui.showLoginDialog(function(){
		        			onHeadOkCallback();
		        		});
		        	else
		        		alert(resultData.msg);
		        }
		    }
		};
		$.ajax(options);
	},
	_doGet: function(params){
		var data = {uploadDownloadControllerId: this._uploadDownloadControllerId};
		for(elm in params){
			data[elm] = params[elm];
		}
		
		var $form=$("<form></form>");//定义一个form表单
		$form.hide();
		
		$form.attr("target","");
		$form.attr("method","post");
		$form.attr("action",BasePath+"do.download");
		
		for(elm in data){
			var $input = $("<input type='hidden'></input>");
			$input.attr("name",elm);
			$input.val(data[elm]);
			$form.append($input);
		}
		
		$("body").append($form);//将表单放置在web中
		
		$form.submit().remove();//表单提交
		/*var downloadGetSession = setInterval(function(){
            WebService.service("DownloadGetSession.service?getDownloadGetSession",params,function(data){
                if(data.downloadStatus=='END'){
                    $(".loading-container").hide();
                    clearInterval(downloadGetSession);
                }
			},function(){

			});
        }, 1500);*/
	}
};