<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ERM生态环境资源管理平台</title>
    <link href="${request.contextPath}/static/css/login.css" rel="stylesheet">
	<#include "/header.ftl"/>
</head>
<body class="white">
<div class="login-hd">
    <div class="left-bg"></div>
    <div class="right-bg"></div>
    <div class="hd-inner">
    	<!-- 
    		<span class="logo"></span>
    	-->
        <span class=""></span>
        <span class="split"></span>
        <span class="sys-name">厦门智慧指间科技有限公司</span>
    </div>
</div>

<div style="margin: 20px;font-size: 20px;">机器码：</div>
<div style="margin: 20px;"><pre>${hardwarecode}</pre></div>
<input id="downHardWareCode" type="button" value="下载机器码"/>
<div style="margin-bottom: 10px">
			<label class="textbox-label textbox-label-before" title="文件选择">文件选择:</label>		    
		    <div id="uploader" class="uploader-container">
			    <div class="btns">
			    	<div class="webuploader-pick-btn">
			    		<div class="webuploader-pick easyui-linkbutton btn-blue">
				    		选择
				    	</div>
				    	<div class="webuploader-pick-invisible">
				    		<form id="ff" method="post" enctype="multipart/form-data">
								<input type="file" name="file" id="file" multiple="multiple" class="webuploader-element-invisible" onChange="changeFile(event,this);"/>
								<label class="label-uploader"></label>
							</form>
				    	</div>
			    	</div>	
			        <button id="ctlBtn" class="easyui-linkbutton btn-green hide" onclick="uploadFile()">上传</button>
			        <button id="deleteBtn" class="easyui-linkbutton btn-red hide" onclick="deleteFile(this)">删除</button>
			    </div>
			</div>
			<!--用来存放文件信息-->
			<div id="thelist" class="uploader-list"></div>		       
		</div>
<div class="error-info" style="margin: 20px;">本系统需要授权，请与<a href="http://www.xmzhzj.com" target="_blank">厦门智慧指间科技有限公司</a>(www.xmzhzj.com)联系。</div>
</body>
</html>

<script type="text/javascript">
    $(function () {
        $("#downHardWareCode").on('click', function () {
            window.location.href= "${request.contextPath}" + '/license/downloadHardWareCode';
        });
    });

    /* --------------------------上传附件功能开始------------------------------------------------- */
    function uploadFile() {
        $("#ff").form('submit', {
            url: '${request.contextPath}/license/uploadLicenseFile',
            data: $("#ff").serialize(),
            success: function (result) {
                //var resultObj = JSON.parse(result);
                console.log("-"+result+"-")
                //$("#fileId").textbox('setValue',result);
                $.messager.show({
                    title: '提示框',
                    msg: result,
                    timeout: 500,
                    showType: 'show',
                    style: {
                        right: '',
                        top: document.body.scrollTop + document.documentElement.scrollTop,
                        bottom: ''
                    }
                });
            }
        });
    }
    //删除全部上传
    function deleteFile(my){
        $(my).addClass("hide");
        $(my).prev().addClass("hide");
        $("#thelist").html("");

    }
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
    }
    //判断元素是否存在于数组中
    function isInArray(arr,value){
        var index = $.inArray(value,arr);
        if(index >= 0){
            return true;
        }
        return false;
    }
    //判断类型，图片预览
    function UploadImg(i,obj,$container,srcUrlName){
        var $target=$container.find(".file-img").eq(i);
        var file = obj;
        //图片显示预览
        if(srcUrlName=="jpg"||srcUrlName=="png"||srcUrlName=="gif"){
            //判断浏览器是否支持FileReader接口
            if (typeof FileReader == 'undefined') {
                //console.log("当前浏览器不支持FileReader接口");
                return false;
                //使选择控件不可操作
                //$(".file-img-box").css("display", "none");
            }
            var reader = new FileReader();
            reader.onerror = function (e) {
                //console.log("读取异常....");
                return false;
            }
            reader.onload = function (e) {
                $target.attr("src",this.result);
                $target.addClass("type-image");
                //img.src = e.target.result;
                //或者 img.src = this.result;  //e.target == this
            }
            reader.readAsDataURL(file);
        }
    }
    //添加文件列表
    function addUploadLi(flieName,size,srcUrl,$aim,i) {
        var hide=" style='display:none;'";
        if (!(i>=0)){
            hide=" style='display:none;'";
            $aim.html("");
        }
        i=i||0;
        size=size==""?size:"<div class='info-item'>"+size+"</div>"
        var html="<div class='uploader-file-box uploader-type-warning'>\
			    		<div class='file-img-box'>\
			    			<img class='file-img' alt='' src='' />\
			    		</div>\
			    		<div class='file-other-box'>\
			    			<div class='progress-box'>\
			    				<div class='progress-bar'>\
			    					<span style='width:80%;'></span>\
			    				</div>\
			    			</div>\
			    			<div class='file-info-box'>"+size+"<div class='info-item'>"+flieName+"</div>\
			    			</div>\
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
        $target.attr("src",srcUrl);
    }
    function getFileSrcUrl (tvalue){
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
        var srcUrl = "${request.contextPath}/static/images/file-"+srcUrlName+".png";
        return [srcUrl,srcUrlName];
    }
    function changeFile(e,obj){
        tvalue=obj.value
        e = e || window.event;
        var target= e.target || e.srcElement; //获取document 对象的引用
        var flieName = "";
        var size = "";
        var $aim = $('#thelist');
        $('#thelist').html("");
        if(tvalue != ''){
            //判断是否支持files
            if (target.files && target.files[0]) {
                flieName = e.currentTarget.files[0].name;
                size=renderSize(e.currentTarget.files[0].size);
                addUploadLi(flieName,size,getFileSrcUrl(flieName)[0],$aim,$aim.find(".file-img").length);//添加文件列表
                UploadImg($aim.find(".file-img").length-1,e.currentTarget.files[0],$aim,getFileSrcUrl(flieName)[1]);
            }else {
                //获取文件名
                var idx=tvalue.lastIndexOf('\\');
                if (idx != -1){
                    flieName = tvalue.substr(idx+1).toUpperCase();
                    flieName = flieName.toLowerCase( );
                }
                addUploadLi(flieName,size,getFileSrcUrl (flieName)[0],$aim);//添加文件列表
                //获取文件地址
                obj.select();
                var srcUrl= document.selection.createRange().text;
                //获取文件大小
                //图片预览
                var srcUrlName=getFileSrcUrl (flieName)[1];
                if(srcUrlName=="jpg"||srcUrlName=="png"||srcUrlName=="gif"){
                    var imgHTML='<div class="file-img type-image" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + srcUrl + '\'"></div>';
                    $aim.find(".file-img-box").html(imgHTML);
                }
            }

        }

        $("#ctlBtn").removeClass("hide");
        $("#deleteBtn").removeClass("hide");
    }
    $(function(){
        //添加附件
        $("body").on( 'click','.webuploader-pick-btn', function() {
            $("#file").trigger('click');
        });
        $("body").on( 'click','#file', function(e) {
            e.stopPropagation();
        });
        //附件移除
        $("body").on( 'click','.uploader-file-box .easyui-linkbutton.delete', function() {
            $(this).parents(".uploader-file-box").remove();
        });
        //附件取消上传
        $("body").on( 'click','.uploader-file-box .easyui-linkbutton.cancel', function() {
            $(this).parents(".uploader-file-box").remove();
        });
        //单个附件上传
        $("body").on( 'click','.uploader-file-box .easyui-linkbutton.upload', function() {
            uploadFile();
        });
    });
    /* --------------------------上传附件功能结束------------------------------------------------- */

</script>
