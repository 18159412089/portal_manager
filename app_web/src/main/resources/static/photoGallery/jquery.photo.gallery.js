
(function($) {

var windowMargin = 0; //加多边距的宽高，使得图片看起来有边框效果
  
//图片查看器
$.fn.extend({
  	
	photoGallery: function(options) {
		var isFirefox = navigator.userAgent.indexOf("Firefox") > -1 ;
		var MOUSEWHEEL_EVENT = isFirefox ? "DOMMouseScroll" : "mousewheel";
		var defaults = {
      		//图片缩放倍率
 	 		ratio : 1.2, 
 	 		//右下角缩略图宽度
 	 		thumbnailsWidth : 180, 
			//右下角缩略图高度
 	 	 	thumbnailsHeight : 120, 
 	 	 	//HTML模版
 	 	 	template : {
	 	 	 	//操作工具
	 	 	 	OPERTATION : '<div class="oper">' +
								'<span class="prev"><i class="icon_tool-prev" title="上一张"></i></span>' +
								'<span class="next"><i class="icon_tool-next" title="下一张"></i></span>' +
							 '</div>' +
							 '<div class="tool">' +
							 	'<div class="toolct">' +
								 	'<span class="oper_fullscreen" title="全屏查看"><i class="icon_tool-fullscreen"></i></span>' +
								 	'<span class="oper_play" title="播放"><i class="icon_tool-play"></i></span>' +
									'<span class="oper_bigger" title="放大图片"><i class="icon_tool-bigger"></i></span>' +
									'<span class="oper_smaller" title="缩小图片"><i class="icon_tool-smaller"></i></span>' +
									'<span class="oper_rotate" title="向右旋转"><i class="icon_tool-rotate"></i></span>' +
				     				'<span class="oper_download" title="下载文件"><i class="icon_tool-download"></i></span>' +
								'</div>' +
							 '</div>',
				//缩略图
				THUMBNAILS : "<div class='thumbnails'>" +
				  		  	 	'<span class="thumbClose" title="关闭缩略图"><i class="icon_close-small"></i></span>' +
				  		  		'<img ondragstart="return false;"/>' +
				  		  		'<div class="thumbDrag"><span></span></div>' +
				  		 	 "</div>",
				//大图
				IMAGE : '<img class="image" ondragstart="return false;"/>' 	 	 	
 	 	 	}
		};
      
		var o = $.extend(defaults, options),
        	$gallery = $(this);
      	$gallery.append(o.template.OPERTATION).append(o.template.THUMBNAILS);  
      	
      	var $tool = $(this).find(".tool"),
			$fullscreen = $(this).find(".oper_fullscreen"),
			$playVideo = $(this).find(".oper_play"),
			$bigger = $(this).find(".oper_bigger"),
			$smaller =  $(this).find(".oper_smaller"),
			$rotate = $(this).find(".oper_rotate"),
			$download = $(this).find(".oper_download"),
			$prev = $(this).find(".prev"),
			$next = $(this).find(".next"),
			$thumbnails = $(this).find(".thumbnails"),
			$image,
			$thumbImg,
			imageWidth,
			imageHeight,
			imgRatio,
			dragX,
			dragY,
			cW,
			cH,
			w,h,isVertical,
			thumbX,
			thumbY;

		//上一张
		$prev.on('click',function(){
			$(this).addClass("active");
      		if(o.activeIndex > 0) {
      			o.activeIndex--;
      		}
  			toggleImage();
      	});
      	/*.on("mouseover",function(e){
      		if(o.activeIndex > 0)
  	   			$(this).addClass("active");
  	  	}).on("mouseout",function(e){
  			$(this).removeClass("active"); 
  	  	});	*/ 
  	  
  	  	//下一张
      	$next.on('click',function(){
      		$(this).addClass("active");
      		if(o.activeIndex < o.imgs.length -1) {
      			o.activeIndex++;
      		}
      		toggleImage();
      	});
      	/*.on("mouseover",function(e){
      		if(o.activeIndex < o.imgs.length -1)
  	   			$(this).addClass("active");
  	 	}).on("mouseout",function(e){
  	  		$(this).removeClass("active"); 
  	  	});*/
       
  	  	//缩略图
      	$thumbnails.css({
			height: o.thumbnailsHeight,
			width : o.thumbnailsWidth
	  	}).on("mouseenter",function(e){
  			thumbX = -1;
  	 	}).on("mousedown",function(e){
  	 		thumbX=e.pageX || e.clientX;
			thumbY=e.pageY || e.clientY;

			cW = document.body.clientWidth;
			cH = document.body.clientHeight;
  	  		e.stopPropagation(); 
  		}).on("mousemove",function(e){
  	  		if(thumbX > 0){
	   	  		var nextDragX=e.pageX || e.clientX;
				var nextDragY=e.pageY || e.clientY;
				var $td= $(this).find(".thumbDrag"),
			    	imageWidth = $image.width(),
					imageHeight = $image.height(),
					thumbImgWidth = $thumbImg.width(),
					thumbImgHeight = $thumbImg.height(),
					left =parseFloat($td.css("left")) +  (nextDragX - thumbX),
					top =parseFloat($td.css("top")) + (nextDragY - thumbY),
					w = $td.width(),
					h = $td.height(),
					it,
					il,
					maxL,
					maxT;
			
				if(isVertical){
					thumbImgWidth = [thumbImgHeight, thumbImgHeight = thumbImgWidth][0];
					imageWidth = [imageHeight, imageHeight = imageWidth][0];
				}
				it = (o.thumbnailsHeight - thumbImgHeight) / 2 ,
				il = (o.thumbnailsWidth - thumbImgWidth) / 2,
				maxL = o.thumbnailsWidth - w - il - 2, //减去2像素边框部分
				maxT = o.thumbnailsHeight - h - it - 2;
				
				if(left < il ) left = il;
				else if(left > maxL) left = maxL;
			
				if(top < it ) top = it;
				else if(top > maxT) top = maxT;
				
				$td.css({
					left : left,
					top : top
				})
				thumbX=nextDragX;
				thumbY=nextDragY; 	  

				if(imageWidth < cW) left = (cW - imageWidth) / 2;
				else left = -imageWidth * (left-il) / thumbImgWidth;
			 
				if(imageHeight < cH ) top = (cH - imageHeight) / 2;
				else top = -imageHeight * (top-it) / thumbImgHeight;
			
				$image.offset({
					left : left,
					top : top
				});
  	  		}
  	 	}).on("mouseup",function(e){
  	  		thumbX = -1;
  	 	});
				  	 
	 	$thumbnails.find(".thumbClose").on("click",function(){
	  		$thumbnails.hide();
	  	});
    	  
      	//显示工具栏
  	  	$gallery.on("mouseover",function(e){
  	  		$tool.show();
  	  	
  	  	}).on("mouseenter",function(e){
			dragX = -1;
		}).on("mouseout",function(e){
			$tool.hide();
		}).on("mousedown",function(e){
  	 		dragX=e.pageX || e.clientX;
			dragY=e.pageY || e.clientY;

			cW = document.body.clientWidth;
			cH = document.body.clientHeight;
  	  		e.stopPropagation(); 
  	  	}).on("mousemove",function(e){
  	  		if(dragX > 0){
	   	  		var nextDragX=e.pageX || e.clientX;
				var nextDragY=e.pageY || e.clientY ;
				var o = $image.offset(),
					left =o.left +  (nextDragX - dragX),
					top =o.top + (nextDragY - dragY),
					w = $image.width(),
					h = $image.height();
			
				if(isVertical){
					w = [h, h = w][0];
				}
				if(w > cW){
					if(left > 0){
						left = 0 ;
					}
					else if(left < cW - w){
						left = cW - w;
					}
				}else{
					left = o.left;
				}
				if(h > cH){
					if(top > 0){
						top = 0 ;
					}
					else if(top < cH - h){
						top = cH - h;
					} 
				} else{
					top = o.top;
				}	
			
				$image.offset({
					left : left,
					top : top
				});
				dragX=nextDragX;
				dragY=nextDragY; 	  
				setThumbnails(); //缩略图拖拽点
  	  		}
  	 	}).on("mouseup",function(e){
  	  		dragX = -1;
  	  	});
  	    
  	  	//全屏
		var isMax,preWidth, preHeight, preTop, preLeft;
  	 	$fullscreen.on("click", function(){
  	 		//var $activeDiv = $(top.document.body).find('div.fjzx-prog-frame-tabs-content-active');
  	 		var $activeDiv = null;
  	 		try{
  	 			$activeDiv = $(top.document.body);
  	 		}catch(err){
  	 		//假如因为跨域问题无法获取顶层document
  	 			$activeDiv = $(window.parent.document.body);
  	 		}
  	 		
  	 		var cW = $activeDiv.width();
  	 		var cH = $activeDiv.height();
  	 		var iW = o.imgs[o.activeIndex].imgWidth;
  	 		var iH = o.imgs[o.activeIndex].imgHeight;
  	 		
  	 		var w,h;
			var sunWidth = cW;
			var sunHeight = (iH/iW) * cW;
			if(sunHeight > cH){
				h = cH;
				w = h / (iH/iW);
			}else{
				w = cW;
				h = (iH/iW) * w;
			}
  	 		
  	 		var imgStr = '<table style="position:absolute;top:0;left:0;z-index:10000;width:100%;height:100%;background:rgba(0,0,0,0.9);">\
  	 							<tr>\
  	 								<td>\
  	 									<div style="margin:0 auto;text-align:center;">\
  	 										<div style="position:relative;display:inline-block;">\
								  	 			<img style="width:'+w+'px;height:'+h+'px;" \
													src="'+o.imgs[o.activeIndex].url+'" />\
												<img class="closeMaxBigImg" style="background:rgba(255,0,0,0.85);position:absolute;top:0;right:0;width:25px;height:25px;" \
													src="/static/photoGallery/icon/close_big.png" title="退出全屏" />\
											</div>\
  	 									</div>\
  	 								</td>\
  	 							</tr>\
  	 						</table>';
			$activeDiv.append(imgStr);
			
			$('table img.closeMaxBigImg',$activeDiv).click(function(){
				$(this).closest('table').remove();
			});
			
  	 		/*
			var parentD = window.parent.document,
				J = $(parentD.getElementById("J_pg"));
			if(!isMax){
				isMax = true;
				preWidth = document.body.clientWidth;
				preHeight = document.body.clientHeight;
				preTop = J.css("top");
				preLeft = J.css("left");
				J.css({
					top: 0,
					left : 0,
					width : parentD.body.clientWidth,
					height : parentD.body.clientHeight,
				});
			} else{
				isMax = false;
				J.css({
					top: preTop,
					left : preLeft,
					width : preWidth,
					height : preHeight
				});
			}
			*/
  	  	});
  	 	
  	 	//播放
  	 	$playVideo.on("click", function(){
			window.open(o.imgs[o.activeIndex].path);
  	  	});
  	  
  	  	//放大图片
  	  	$bigger.on("click", function(){
  	  		biggerImage();
  	  	});
  	  
  	  	//缩小图片
  	 	$smaller.on("click", function(){
			smallerImage();
  	  	});
  	  
  	  	//旋转
  	  	$rotate.on("click", function(){
  	  	
  	  		var rotateClass = $image.attr("class").match(/(rotate)(\d*)/);

  	  		if(rotateClass){
  	  			var nextDeg = (rotateClass[2] * 1 + 90) % 360;
				$image.removeClass(rotateClass[0]).addClass("rotate" + nextDeg);
  	  			$thumbImg.removeClass(rotateClass[0]).addClass("rotate" + nextDeg);
  	  			resizeImage(nextDeg);
  	  			resizeThumbImg(nextDeg);
  	  			isVertical = nextDeg == 90 || nextDeg == 270;
  	  		} else{
  	  			$image.addClass("rotate90");
  	  			$thumbImg.addClass("rotate90");
  	  			resizeImage("90");
  	  			resizeThumbImg("90");
  	  			isVertical = true;
  	  		}
  	  	});

  	  	//下载
  	 	$download.on("click", function(e){
  	  		var imgUrl = $image.attr("src");
  	   		if(!imgUrl) return;
  	   		console.log(o.imgs[o.activeIndex].downloadPath);
			window.open(o.imgs[o.activeIndex].downloadPath);
  	  	});
  	  
	  	$(window).on("resize",function(){
	  		setImagePosition();
	  	});
		
		if(document.attachEvent){
			document.attachEvent("on"+MOUSEWHEEL_EVENT, function(e){
				mouseWheelScroll(e);
			});
		} else if(document.addEventListener){
			document.addEventListener(MOUSEWHEEL_EVENT, function(e){
				mouseWheelScroll(e);
			}, false);
		}	
		
		function mouseWheelScroll(e){
			var _delta = parseInt(e.wheelDelta || -e.detail);
	    	//向上滚动
	  		if (_delta > 0) {
        		biggerImage();
        	}
        	//向下滚动
        	else {
            	smallerImage();
        	}
		}
		
	  	//键盘左右键
	  	document.onkeydown = function(e){
	  		e = e || window.event;
	  		if (e.keyCode) {
			   	if(e.keyCode == 37 ){ //left
			    	if(o.activeIndex > 0) o.activeIndex--;
			  		toggleImage();	
			   	}
		  	   	if(e.keyCode == 39 ){ //right
		        	if(o.activeIndex < o.imgs.length -1) o.activeIndex++;
	      			toggleImage();
			   	}
			}
	 	};
		
	  	function init(){
  	    	toggleImage();
  	    
  	    	$(o.imgs).each(function(i, img){
	  	    	$(o.template.IMAGE)
	  	    		.appendTo($gallery)
	  	    		.attr("src", img.url)
	  	    		.attr("index", i)
	  	    		.css({
				  	 	width : img.imgWidth,
				  	 	height : img.imgHeight,
				  	 	left : (cW - img.imgWidth)/2,
				  	 	top: (cH - img.imgHeight)/2
			  	}).on("dblclick", function(){
				  	//app.window.close();
				}); ;
	  	    });
  	    	$image = $(".image[index='"+o.activeIndex+"']", $gallery).addClass("active");
	  	}
	  	
	  	function showGJ(){
	  		if(o.imgs.length===1){
	  			$gallery.find('.oper .prev i').attr('style','display:none;');
	  			$gallery.find('.oper .next i').attr('style','display:none;');
	  		}else{
	  			if(o.activeIndex == 0){
	  				$gallery.find('.oper .prev i').attr('style','display:none;');
	  				$gallery.find('.oper .next i').attr('style','display:inline-block;');
	  			}else if(o.activeIndex == o.imgs.length -1){
	  				$gallery.find('.oper .prev i').attr('style','display:inline-block;');
	  				$gallery.find('.oper .next i').attr('style','display:none;');
	  			}else{
	  				$gallery.find('.oper .prev i').attr('style','display:inline-block;');
	  				$gallery.find('.oper .next i').attr('style','display:inline-block;');
	  			}
	  		}
	  		
	  		if(o.imgs[o.activeIndex].type==="VIDEO"){
  				$gallery.find('.toolct span.oper_play').attr('style','display:inline-block;');
  			}else{
  				$gallery.find('.toolct span.oper_play').attr('style','display:none;');
  			}
	  	}
	  
	  	function toggleImage(){
	    	imageWidth = o.imgs[o.activeIndex].imgWidth;
       		imageHeight = o.imgs[o.activeIndex].imgHeight;
       		imgRatio = imageWidth/ imageHeight;
        	cW = document.body.clientWidth;
			cH = document.body.clientHeight;
			$(".image", $gallery).removeClass("active");
			$image = $(".image[index='"+o.activeIndex+"']", $gallery).addClass("active").css({
				width : imageWidth,
				height : imageHeight
			}).removeClass("rotate0 rotate90 rotate180 rotate270");
	  		$thumbImg = $thumbnails.find("img").attr("src", o.imgs[o.activeIndex].url);	
	  		$thumbnails.find("img").removeAttr("class").removeAttr("style");
	  		isVertical = false;
	  		$thumbnails.hide();
	  		$prev.removeClass("active");
	  		$next.removeClass("active");
	  		setImagePosition();
	  		showGJ();
	  	}	
	  
	  	function biggerImage(){
  			var w = $image.width(),
  	  	 		h = $image.height(),
  	  	 		nextW = w * o.ratio,
  	  	 		nextH = h * o.ratio;
		 	if(nextW - w < 1) nextW = Math.ceil(nextW);
  	  	 	var percent =  (nextW / imageWidth * 100).toFixed(0) ;
  	  	 	if(percent > 90 && percent < 110){
  	  	 		percent = 100;
  	  	 		nextW = imageWidth;
  	  	 		nextH = imageHeight;
  	  		}
  	  	 	else if(percent > 1600) {
  	  	 		percent = 1600;
  	  	 		nextW = imageWidth * 16;
  	  	 		nextH = imageHeight * 16; 
  	  	 	}

  	  	 	$image.width(nextW).height(nextH);
  	  	 	setImagePosition();
  	  	 	showPercentTip(percent);
  	  	 	showThumbnails(nextW, nextH);
	  	}
	  
	  	function smallerImage(){
	  		var w = $image.width(),
  	  	 		h = $image.height(),
  	  	 		nextW,
  	  	 		nextH;
  	  	 	var percent =  (w / o.ratio / imageWidth * 100).toFixed(0) ;
  	  	 	if(percent < 5) {
  	 			percent = 5;
  	  	 		nextW = imageWidth / 20;
  	  	 		nextH = imageHeight / 20;
  	  	 	}
  	  	 	else if(percent > 90 && percent < 110){
  	  	 		percent = 100;
   	  	 		nextW = imageWidth;
  	  	 		nextH = imageHeight;
  	  	 	} else{
  	  	 		nextW = w / o.ratio;
  	  	 		nextH = h / o.ratio; 
  	  	 	}
  	  	 
  	  	 	$image.width(nextW).height(nextH);
  	  	 	setImagePosition();
  	  	 	showPercentTip(percent);
  	  	 	showThumbnails(nextW, nextH);
	  	}
	  
	  	//显示缩略图
	  	function showThumbnails(width, height){
	  		if(isVertical) width = [height, height = width][0];
	  		if(width > document.body.clientWidth || height > document.body.clientHeight){
	  			$thumbnails.show();
	  			setThumbnails();
	  		} else{
	  			$thumbnails.hide();
	  		}	  
	  	}
	  
	  	//重置图片宽高
	  	function resizeImage(rotateDeg){
	  	
	  		var mH = document.body.clientHeight - windowMargin,
  	  			mW = document.body.clientWidth - windowMargin;
	  		if(rotateDeg == '90' || rotateDeg == '270'){
	  			mW = [mH, mH = mW][0];
	  		}

	  		var width, height;
	  		width = Math.min(imageWidth, mW);
	  		height = Math.min(imageHeight, mH);
		
	  		if(width / height > imgRatio){
	  			width = height * imgRatio;
	  		} else{
	  			height = width / imgRatio;
	  		}

	  		$image.css({
				width:width,
				height:height
  			});
  			setImagePosition();
	  	}
	  
	  	function resizeThumbImg(rotateDeg){
	  		var maxW = o.thumbnailsWidth, maxH = o.thumbnailsHeight;
	  		if(rotateDeg == '90' || rotateDeg == '270'){
	  			maxW = [maxH, maxH = maxW][0];
	  		}
	  		$thumbImg.css({
	  			maxWidth : maxW,
	  			maxHeight : maxH
	  		});
	  		$thumbnails.hide();
	  	}
	  
	  	//显示百分比提示
	  	function showPercentTip(percent){
	    	$gallery.find(".percentTip").remove();
	  		$("<div class='percentTip'><span>"+percent+"%</span></div>").appendTo($gallery).fadeOut(1500);
	  	}
	  
  	  	//设置图片位置
	  	function setImagePosition(){
	  		var w = $image.width(),
	  	    	h = $image.height(),
  	  			cW = document.body.clientWidth,
  	  			cH = document.body.clientHeight;

  	  		var left = (cW - w)/2,
				top = (cH - h)/2;

  			$image.css("left", left +"px").css("top", top+"px");
	  	}
	  
	  	//设置缩略图拖拽区域
	  	function setThumbnails(){
	  		var $img = $thumbnails.find("img"),
  				sW = $img.width(),
  				sH = $img.height(),
  				w = $image.width(),
  				h =  $image.height(),
  				imf = $image.offset(),
  				imfl = imf.left,
  				imft = imf.top,
  				cW = document.body.clientWidth,
				cH = document.body.clientHeight,
				tW,
				tH,
				tl,
				tt;
	
			if(isVertical){
				sW = [sH, sH = sW][0];
				w = [h, h = w][0];
			}

			tW = sW / (w / cW);
			if(w < cW) tW = sW;
			tH = sH / (h / cH);
			if(h < cH) tH = sH;
			tl = (o.thumbnailsWidth - sW)/2 + -imfl/w * sW ;
			if(w < cW) tl = (o.thumbnailsWidth - sW)/2;
			tt = (o.thumbnailsHeight - sH)/2 + -imft/h * sH ;
			if(h < cH) tt = (o.thumbnailsHeight - sH)/2;
			$thumbnails.find(".thumbDrag").css({
				width: tW,
				height: tH,
				left: tl,
				top: tt
			});
	  	}
	  
  	  	init();
		return this;
	}
});

var activeIndex=0,
	imgs = [],
	winHeight,
	winWidth,
	$divObj;
function getImgResouce(imgObjs,index,sum){
	if(index<=sum){
		var imgTemp = new Image();
		imgTemp.src = imgObjs[index].src;
		
		imgTemp.onload = function(){
			var img = imgTemp;
			var url = imgObjs[index].src,
			nH = img.height,
			nW = img.width,
			ratio  = nW / nH,
			w = nW,
			h = nH;
			
			var sunWidth = winWidth;
			var sunHeight = (nH/nW) * winWidth;
			if(sunHeight > winHeight){
				h = winHeight;
				w = h / (nH/nW);
			}else{
				w = winWidth;
				h = (nH/nW) * w;
			}
			
			imgs.push({
				url: url, 
				imgHeight : h,
				imgWidth : w,
				downloadPath: imgObjs[index].downloadPath,
				type: imgObjs[index].type,
				path: imgObjs[index].path
			});
			
			index++;
			getImgResouce(imgObjs,index,imgObjs.length-1);
		};
		
		imgTemp.onerror = function(){	
			imgs.push({
				url: 'icon/img_error.png',
				imgHeight : 87,
				imgWidth : 110,
				downloadPath: imgObjs[index].downloadPath,
				type: imgObjs[index].type,
				path: imgObjs[index].path
			});
			
			index++;
			getImgResouce(imgObjs,index,imgObjs.length-1);
		};
	}else{
		localStorage["photoGalleryImgs"] = JSON.stringify(imgs); //因为此字符串可能是base64字符，appgo无法传
		localStorage["photoGalleryActiveIndex"] = activeIndex; 

		//$("#J_pg").remove();
		$("<iframe></iframe").appendTo($divObj)
			.attr("id", "J_pg")
			.attr("src", "/static/photoGallery/gallery.html")
			.css({
				position : "absolute",
				left : '0px',
				top : '46px',
				width : '100%',
				height : $divObj.height(),
				border: '0px solid #6D6D6D'
			})
			.css('z-index','10000');
	}
}
  
$.extend({
	//打开图片查看器
	openPhotoGallery : function(obj,divObj,index){
		//放在这边是为了避免图片加载不成功的情况下会显示上次的图片列表
		$("#J_pg").remove();
		
		$divObj = $(divObj);
		
		activeIndex = index?index:0;
		
		if(obj.length<0){
			return;
		}
		
		winHeight = $divObj[0].clientHeight,
		winWidth = $divObj[0].clientWidth;
		
		var l_i_w = 86;
		var l_i_h = 86;
		var l_i_top = (winHeight-l_i_h)/2;
		var l_i_left = (winWidth-l_i_w)/2;
		$divObj.append('<img id="J_pg_loading" src="/static/photoGallery/icon/loading.gif" style="width:'+l_i_w+'px;height:'+l_i_h+'px;position:absolute;top:'+l_i_top+'px;left:'+l_i_left+'px;z-index:10005;" />');
		
		imgs = [];
		getImgResouce(obj,0,obj.length-1);
	},
	//做初始化
	initGallery : function(){
        var activeIndex = localStorage["photoGalleryActiveIndex"],
        	imgs = JSON.parse(localStorage["photoGalleryImgs"]);
        
		localStorage.removeItem("photoGalleryActiveIndex");
		localStorage.removeItem("photoGalleryImgs");
       
		$(".gallery").photoGallery({
			imgs : imgs,
			activeIndex:activeIndex
		});
		
		$('.gallerys img#J_pg_loading', window.parent.document).remove();
		
		/*
		$(".closeWin").click(function(){
			var _parent =  window.parent || window.top,
				_jg = _parent.document.getElementById("J_pg");
				
			$(_jg).remove();
		});
		*/
	}
});
  
})(jQuery);
