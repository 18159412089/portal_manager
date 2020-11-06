/*
 *文件上传 
 */
/*-----------------
 * Selector(#picker)
 * $(Selector).fileUploader(options);
 * --------------*/
(function ($) {
	var uploaderArray=[];
	var methods = {
        init: function (options) {
            return this.each(function () {
                $(window).bind('resize.fileUploader', methods.reposition);
            });

        },
        destroy: function () {
            return this.each(function () {
                $(window).unbind('.fileUploader');
            })

        },
        hide: function () {
            //...
        },
        update: function (content) {
            //...
        },
        //添加文件
        addUploadLi:function(flie,$aim,i) {
	  		var hide=" style='display:none;'";
	  		if (!(i>=0)){
	  			hide=" style='display:none;'";
	  			$aim.html("");
	  		}
	  		i=i||0;
	  		size=flie.size==""?flie.size:"<div class='info-item'>"+flie.size+"</div>"
	        var html="<div id='"+flie.id+"' class='uploader-file-box uploader-type-warning'>\
			    		<div class='file-img-box'>\
			    			<img class='file-img' alt='' src='' />\
			    		</div>\
			    		<div class='file-other-box'>\
			    			<div class='progress-box'>\
			    				<div class='progress-bar'>\
			    					<span style='width:0%;'></span>\
			    				</div>\
			    			</div>\
			    			<div class='file-info-box'>"+size+"<div class='info-item'>"+flie.name+"</div>\
			    			</div>\
			    			<div class='state'>等待上传</div>\
			    			<div class='btns'"+hide+">\
			    				<button class='easyui-linkbutton btn-blue upload l-btn l-btn-small'>上传</button>\
								<button class='easyui-linkbutton btn-warning cancel l-btn l-btn-small'>取消</button>\
			    				<button class='easyui-linkbutton btn-danger delete l-btn l-btn-small'>删除</button>\
			    			</div>\
			    		</div>\
					</div>";	

	   		$aim.append(html);
	   		//显示图标
			var $target=$aim.find(".file-img").eq(i);
	        $target.attr("src",flie.srcUrl);
	    },
	    //判断类型，图片预览
	    uploadImg:function(i,obj,$container,srcUrlName,uploader){
	    	var $target=$container.find(".file-img").eq(i);
	        var file = obj;        
			//图片显示预览
	        if(srcUrlName=="jpg"||srcUrlName=="png"||srcUrlName=="gif"){
	        	uploader.makeThumb( file, function( error, ret ) {
	                if ( !error ) {
	                	$target.attr("src",ret);
	                	$target.addClass("type-image");
	                }
	            });        	
			}		
	    },
	    getFileSrcUrl: function (tvalue,basePath){
	    	basePath=basePath?basePath:"";
	  		var suffixName;
	  		//获取后缀名
	        var idxs=tvalue.lastIndexOf('.');
	        if (idxs != -1){   
	        	suffixName = tvalue.substr(idxs+1).toUpperCase();   
	        	suffixName = suffixName.toLowerCase( );                
	        }
	        var srcUrlName = "more";
	        var iconArray=  [
		        	{ "name":"zip", "suffix":[ "7Z", "rar", "zip" ] },
	 	        { "name":"doc", "suffix":[ "docx", "doc"] },
	 	        { "name":"ppt", "suffix":[ "pptx", "ppt"] },
	 	        { "name":"xls", "suffix":[ "xlsx", "xls"] },
	 	        { "name":"mp4", "suffix":[ "avi", "rm","rmvb","wmv","mp4" ] },
	 	        { "name":"jpg", "suffix":[ "jpg"] },
	 	        { "name":"png", "suffix":[ "png"] },
	 	        { "name":"gif", "suffix":[ "gif"] },
	 	        { "name":"pdf", "suffix":[ "pdf"] },
	 	        { "name":"mp3", "suffix":[ "mp3"] },
	 	        { "name":"mov", "suffix":[ "mov"] },
	 	        { "name":"flv", "suffix":[ "flv"] },
	 	        { "name":"exe", "suffix":[ "exe"] }
	 	    ];
			//处理后缀名
	        for(var i = 0; i < iconArray.length; i++){
	            if(isInArray(iconArray[i].suffix,suffixName)){
	            	srcUrlName=iconArray[i].name;
	            	break;
	            }
	        }
	        var srcUrl = basePath+"/static/images/file-"+srcUrlName+".png";
	        return [srcUrl,srcUrlName];
	  	}
	    
	    
	    
    };
	$.fn.fileUploader = function (options) {
		var BasePath = $("base").attr("contextPath");		
		if(!isJson(options)){
			if (methods[options]) {
	            return methods[options].apply(this, Array.prototype.slice.call(arguments, 1));
	        } else if (typeof options === 'object' || !options) {
	            return methods.init.apply(this, arguments);
	        } else {
	            $.error('Method ' + options + ' does not exist on jQuery.fileUploader');
	        }
		}else{
			options = $.extend({
		    	contextPath:BasePath,//基础路径
		        container: ".multiple-file-container", //文件上传控件的容器
				swf:BasePath+'/static/upload/Uploader.swf',//swf文件路径
				accept:null//文件接收类型
		    }, options || {});
			
			return this.each(function () {
				var obj = $(this);
	            var $container= obj.parents(options.container),
				$starUpload=$container.find(".start-upload"),
				$list = $container.find('.thelist'),
		    	state = 'pending';
			    //修改上传控件title
			    //$container.find(".multiple-title h3").html(options.title);
			    //创建文件上传实例
			    var uploader = WebUploader.create({
			    	 
			        // 不压缩image
			        resize: false,
			
			        // swf文件路径
			        swf: options.swf,
			
			    	// 文件接收服务端。
			   		server: options.server,
			   		
			   		accept:options.accept,
			   		compress :options.compress ,
			   		fileSizeLimit : 100*1024*1024,//限制文件大小为100M
			        // 选择文件的按钮。可选。
			        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
			        //pick: '#'+obj.attr("id"),
			        pick:obj,
			        thumb:{
			        	    width: 60,
			        	    height: 60,
			        	    // 图片质量，只有type为`image/jpeg`的时候才有效。
			        	    quality: 70,
			        	    // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
			        	    allowMagnify: false,
			        	    // 是否允许裁剪。
			        	    crop: false,
			        	    // 为空的话则保留原有图片格式。
			        	    // 否则强制转换成指定的类型。
			        	    type: 'image/jpeg'
			        },
			        duplicate :options.duplicate
			    });
			    /*不允许重置fileUploader
			     * if(!inArrayJSON(uploaderArray,"name",this.id)){
				    uploaderArray.push({"name":this.id,"object":uploader});
			    }*/
			    uploaderArray.push({"name":this.id,"object":uploader});
			    /*****
			     * 
			     * ****/
			    //重置
			    methods.reset=function () {
			    	return this.each(function(){
			    		var id=$(this).attr("id");
			    		console.log(id);
			            var uploaderObj=getArrayJSONObject(uploaderArray,"name",id)[0]["object"];
			            uploaderObj.reset();
				    	$(this).parents(options.container).find('.thelist').html("");
			    	});
		            
		        };
		        //上传
		        methods.upload=function (index) {
		        	return this.each(function(){
		        		var id=$(this).attr("id");
		        		var uploaderObj=getArrayJSONObject(uploaderArray,"name",id)[0]["object"];	
		        		if(index){
		        			uploaderObj.upload(uploaderObj.getFiles()[index]);
		        		}else{
		        			uploaderObj.upload(uploaderObj.getFiles());
		        		}
		        		
		        	});
		        	
		        };
		        //重新上传
		        methods.retry=function (index) {
		        	return this.each(function(){
		        		var id=$(this).attr("id");
		        		var uploaderObj=getArrayJSONObject(uploaderArray,"name",id)[0]["object"];	
		        		if(index){
		        			uploaderObj.retry(uploaderObj.getFiles()[index]);
		        		}else{
		        			uploaderObj.retry(uploaderObj.getFiles());
		        		}
		        		
		        	});
		        	
		        };
		        //删除
		        methods.removeFile=function (index) {
		        	return this.each(function(){
		        		var id=$(this).attr("id");
		        		var uploaderObj=getArrayJSONObject(uploaderArray,"name",id)[0]["object"];	
		        		if(index){
		        			uploaderObj.removeFile(uploaderObj.getFiles()[index]);
		        			$(this).parents(options.container).find('.thelist').children().eq(index).remove();
		        		}else{
		        			uploaderObj.removeFile(uploaderObj.getFiles());
		        			$(this).parents(options.container).find('.thelist').html("");
		        		}
		        		
		        	});
		        	
		        };
		        /*****
			     * 
			     * ****/
			    
			    // 当有文件添加进来的时候
			    uploader.on( 'fileQueued', function( file ) {
			    	var processedFile= new Object();
			    	processedFile.id=file.id;
			    	processedFile.name=file.name;			    	
			    	processedFile.size=renderSize(file.size);
			    	processedFile.srcUrl=methods.getFileSrcUrl(file.name,options.contextPath)[0];
			    	processedFile.srcUrlName=methods.getFileSrcUrl(file.name,options.contextPath)[1];//后缀
			    	//是否单文件
			    	if(options.fileNumLimit==1){
			    		$list.html("");
			    		methods.addUploadLi(processedFile,$list,$list.find(".file-img").length);
			    	}else{
			    		var html='<tr id="' + processedFile.id + '">\
							<td class="file-img">\
								<div class="file-img-inner"><img class="file-img" alt="" src="'+processedFile.srcUrl+'"/></div>\
							</td>\
							<td class="info">' + processedFile.name + '</td>\
							<td class="info">' + processedFile.size + '</td>\
							<td class="upload-progress">\
								<div class="outer-line">\
									<div class="inner-border" style="width: 0%"></div>\
								</div>\
							</td>\
							<td class="state">等待上传</td>\
							<td class="operation-btn">\
								<a class="btn btn-blue btn-single-start">上传</a>\
								<a class="btn btn-danger btn-delete" >删除</a>\
							</td>\
						</tr>';
						/*<a class="btn btn-warning btn-cancel">取消</a>\*/
				    	$list.append(html);
			    	} 
			    	$starUpload.removeClass("show-hidden");        
			        //图片格式生成缩略图、其他格式生成各自图标
			    	methods.uploadImg($list.find(".file-img").length-1,file,$list,processedFile.srcUrlName,uploader);
			    });
			    
			    //文件开始上传前触发
			    uploader.on( 'uploadBeforeSend', function() {
			        if(typeof(options.uploadBeforeSend)=="function"){
                        options.uploadBeforeSend();
                    }
			        console.log("上传结束");
			    });
			    //文件开始上传前触发，一个文件只会触发一次。
			    uploader.on( 'uploadStart', function( file ) {
			    	var $li = $( '#'+file.id );
			    	$li.find('td.state').text('上传中');
			    	$li.find('td.operation-btn').html("<a class='btn btn-warning btn-stop'>暂停</a><a class='btn btn-danger btn-delete'>删除</a>");
			    });
			    // 文件上传过程中创建进度条实时显示。
			    uploader.on( 'uploadProgress', function( file, percentage ) {
			        var $li = $( '#'+file.id ),
			        	$percent;
			        //console.log(percentage);
			        if(options.fileNumLimit==1){ 
			        	$li.removeClass("uploader-type-warning").removeClass("uploader-type-error").addClass("uploader-type-start");
			        	$percent=$li.find(".progress-bar span");
			        	$percent.css( 'width', percentage * 100 + '%' );
			        	$li.find('.file-other-box .state').text('上传中...');
			        }else{
				        $percent = $li.find('.upload-progress .outer-line .inner-border');
				        // 避免重复创建
				        if ( !$percent.length ) {
				            $percent = $('<div class="outer-line">' +
				              '<div class="inner-border" role="progressbar" style="width: 0%">' +'</div>' +
				            '</div>');
				            $li.find('.upload-progress').append($percent);
					   }				        
				        $percent.css( 'width', percentage * 100 + '%' );
			        }
			        
			    });
			    uploader.on( 'uploadSuccess', function( file , result) {
			    	var $li = $( '#'+file.id );
			    	//新增修改弹出框——需要返回文件id的
			    	//(不是弹出框的不需要加这个)
			    	if(!isEmpty(options.dlg)){
			    		var fileidsObj = $("#"+options.dlg).find("#"+options.fileId);
			        	var fileIds = fileidsObj.textbox("getValue");
			        	if(fileIds){
			        		fileIds += ","+result._raw 
			        		fileidsObj.textbox("setValue",fileIds);
			        	}else{
			        		fileidsObj.textbox("setValue",result._raw);
			        	}
			    	}else{
			    		var msg = result.message;
			    		if(result.type=='E'){
			    			$li.removeClass("uploader-type-start").removeClass("uploader-type-error").addClass("uploader-type-end");
			            	$li.find('.file-other-box .state').text(msg).css('color','red');
			    			return;
			    		}
			    	}
			    	if(options.fileNumLimit==1){ 
			        	$li.removeClass("uploader-type-start").removeClass("uploader-type-error").addClass("uploader-type-end");
			        	$li.find('.file-other-box .state').text('已上传');
			        }else{
			        	$li.find('td.state').text('已上传').css('color','#000');
			        	$li.find('td.upload-progress').children('.outer-line').css('border-color','#248bea').children('.inner-border').css('background-color','#248bea');
			        	$li.find('td.operation-btn').html("<a class='btn btn-danger btn-delete'>删除文件</a>");
			        }
			        if(typeof(options.uploadSuccess)=="function"){
			    	    options.uploadSuccess();
                    }
			    });
			
			    uploader.on( 'uploadError', function( file ) {
			    	var $li = $( '#'+file.id );
			    	if(options.fileNumLimit==1){ 
			        	$li.removeClass("uploader-type-start").addClass("uploader-type-error");
			        	$li.find('.file-other-box .state').text('上传出错');
			        }else{
			        	$li.find('td.state').text('上传出错').css('color','red');
			        	$li.find('td.upload-progress').children('.outer-line').css('border-color','#8f8f8f').children('.inner-border').css('background-color','#8f8f8f');
			        	$li.find('td.operation-btn').html("<a class='btn btn-warning btn-again'>重新上传</a><a class='btn btn-danger btn-delete'>删除文件</a>");
			        }
			        if(typeof(options.uploadError)=="function"){
			    	    options.uploadError();
                    }
			    });
			
			    uploader.on("error",function (type) {
			    	if (type == "Q_EXCEED_SIZE_LIMIT") {
			    		//alert("文件大小不能超过100M！");
			    		$.messager.alert('提示', '文件大小不能超过100M！');
			    	}else if (type == "Q_TYPE_DENIED") {
			    		//alert("文件类型选择错误！");
			    		$.messager.alert('提示', '文件类型选择错误！');
			    	}else{
			    		$.messager.alert("错误代码："+type+",请联系管理员解决！")
			    	}
			    });
			    
			    uploader.on( 'all', function( type ) {
			        if ( type === 'startUpload' ) {
			            state = 'uploading';
			        } else if ( type === 'stopUpload' ) {
			            state = 'paused';
			        } else if ( type === 'uploadFinished' ) {
			            state = 'done';
			        }
			        if ( state === 'uploading' ) {
			        	$starUpload.html('<span class="fa fa-pause"></span> 暂停上传');
			        } else {
			        	$starUpload.html('<span class="iconfont icon-upload"></span> 开始上传');
			        }
			    });
			    
			    $starUpload.on( 'click', function() {
			        if ( state === 'uploading' ) {
			            uploader.stop();
			        } else {
			            uploader.upload();
			        }
			    }); 
			    
			    //删除按钮、上传按钮、取消按钮、重新上传按钮点击事件
			    $list.on('click','.btn-delete',function(){
			 	   	var $target=$(this).parents("tr");
			 	   	//console.log("点击删除");
			 	   	uploader.removeFile($target.attr("id"),true);
			 	   	$target.remove();
			    	//console.log(uploader.getFile($target.attr("id")));
			     });
			    $list.on('click','.btn-single-start',function(){
			 	    var $target=$(this).parents("tr"); 
			    	//console.log("点击上传"+$target.index());
			    	//console.log(uploader.getFile($target.attr("id")));
			 	    uploader.upload($target.attr("id"));
			    });
			    $list.on('click','.btn-cancel',function(){
			 	    var $target=$(this).parents("tr"); 
			 	    uploader.cancelFile($target.attr("id"));
			    });
			    //暂停
			    $list.on('click','.btn-stop',function(){
			    	var $target=$(this).parents("tr"); 
			    	uploader.stop($target.attr("id"),true);
			    	$(this).text("继续").removeClass("btn-warning").removeClass("btn-stop").addClass("btn-blue").addClass("btn-continue");
			    });
			    //继续
			    $list.on('click','.btn-continue',function(){
			    	var $target=$(this).parents("tr"); 
			    	uploader.upload($target.attr("id"));
			    	$(this).text("暂停").removeClass("btn-blue").removeClass("btn-continue").addClass("btn-warning").addClass("btn-stop");
			    });
			    $list.on('click','.btn-again',function(){
			 	    var $target=$(this).parents("tr"); 
			 	    uploader.retry($target.attr("id"));
			    }); 

	        });


		}
		
		
	};
	
	
   
})(jQuery);

//格式化文件大小
function renderSize(value){
    if(null==value||value==''){
        return "0 Bytes";
    }
    var unitArr = new Array("Bytes","KB","MB","GB","TB","PB","EB","ZB","YB");
    var index=0;
    var srcsize = parseFloat(value);
    index=Math.floor(Math.log(srcsize)/Math.log(1024));
    var size =srcsize/Math.pow(1024,index);
    size=size.toFixed(2);//保留的小数位数
    return size+unitArr[index];
};
//判断元素是否存在于数组中
function isInArray(arr,value){
    var index = $.inArray(value,arr);
    if(index >= 0){
        return true;
    }
    return false;
};
//获取数组中相符JSON
function getArrayJSONObject(arr,jsonName,value){
	var array = new Array();
	for(var i in arr){
		if(arr[i][jsonName]===value){
			array.push(arr[i]);
		}
	 
	}
	return array;
};
function inArrayJSON(arr,jsonName,value){
	var array = new Array();
	var index=0;
	for(var i in arr){
		if(arr[i][jsonName]===value){
			array.push(arr[i]);
			index++;
		}
		
	}
	console.log(index);
	if(index > 0){
        return true;
    }
    return false;
};


//判断字符是否为空的方法
function isEmpty(obj){
    if(typeof obj == "undefined" || obj == null || obj == ""){
        return true;
    }else{
        return false;
    }
}
//判断对象是否为Json的方法
function isJson(obj) {
	if (typeof obj == 'string') {
		return false;
    }else{
    	try {
        	var str=JSON.stringify(obj);
            if(typeof obj == 'object' && str && obj ){
                return true;
            }else{
                return false;
            }
        } catch(e) {
            console.log('error：'+obj+'!!!'+e);
            return false;
        }
    }
    
	
	/*判断字符是否为Json的方法
	 * if (typeof str == 'string') {
		console.log('string');
		try {
        	//var obj=JSON.parse(str);
            if(typeof obj == 'object' && obj ){
            	console.log('object');
                return true;
            }else{
            	console.log('string');
                return false;
            }
        } catch(e) {
            //console.log('error：'+str+'!!!'+e);
            return false;
        }
		
    }else{
    	console.log('no string');
    	console.log(JSON.parse(str));
    	return false;
    }*/
	
}
	    