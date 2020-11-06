<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title> 漳州生态云</title>
	<link rel="shortcut icon" type="image/x-icon" href="${request.contextPath}/static/images/favicon.ico" />
	<link  rel="stylesheet" type="text/css"  href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
	<link  rel="stylesheet" type="text/css"  href="${request.contextPath}/static/css/base_sso.css" />
	<link  rel="stylesheet" type="text/css"  href="${request.contextPath}/static/css/login_sso.css" />
	<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
	<script src="${request.contextPath}/static/layer/layer.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/Chart-1.0.1-beta.4.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
</head>
<body ondragstart="return false;">
	<div class="login-bg" id="video">
	
		<video loop="loop" muted="muted" preload="auto" poster="${request.contextPath}/static/images/login_bg.jpg" style="top: 0;left: 0;width: 100%;height: 100%;opacity: 1;object-fit: cover;" autoplay="autoplay">
			<source src="${request.contextPath}/static/images/login_bg.mp4" type="video/mp4">
			<source src="${request.contextPath}/static/images/login_bg.webm" type="video/webm">
			<source src="${request.contextPath}/static/images/login_bg.ogg" type="video/ogg">
			<object data="${request.contextPath}/static/images/login_bg.mp4" width="100%" height="100%">
				<embed src="${request.contextPath}/static/images/login_bg.swf" width="100%" height="100%">
			</object>
		</video>
	
	</div>
	<div class="wrapper">
		<div class="login-wrapper">
			<!-- logo -->
			<img  class="logo-img user-select-none" src="${request.contextPath}/static/images/login-logo.png" alt=""/>
			<div class="login">
				<form class="form-horizontal"  action="${request.contextPath}/login" method="post">
					<div class="control-group">
						<input class="form-control" id="username" name="username" placeholder="请输入用户名" value="${username1!''}" type="text" maxlength="50"/> 
						<input type="password" id="password" name="password" class="form-control" value="" placeholder="请输入密码" maxlength="50" />
						<input type="hidden" id="new_login" name="new_login"/>	
						<button type="submit" class="btn btn-login">登 录</button>
					</div>
					
					<#if error?exists>
						<script>
							layer.alert('${message!''}${tips!''}', {icon: 5});
						</script>
					</#if>
					
					<#if RequestParameters['errorMsgNewLogin']??>
						<script>	                   	
							layer.confirm('用户已经登录,是否强制登录.', {
							  btn: ['是', '否']//按钮
							}, function(){
							  $("#username").val("${username1!''}"); 
							  $("#password").val("${password!''}"); 
							  $("#new_login").val("new_login");
							  $(".form-horizontal").submit(); 
							}, function(){
							});
						</script>
	                </#if>
	                
					<div class="control-group ca">
					</div>
				</form>
			</div>
		</div>
	</div>	
	<!-- bottom over-->
	<div class="login-bottom">
		Copyright &copy; <a href="#">福建中兴电子科技有限公司</a>    电话：0597-2997999    闽ICP备13016998号
	</div>
	<!-- bottom over-->
</body>

<script type="text/javascript">
	
	function downAdroidApk(){
		layer.open({
		  type: 1 //Page层类型
		  ,area: ['400px', '430px']
		  ,title: '你好，请扫描二维码下载apk。'
		  ,shade: 0.6 //遮罩透明度
		  ,maxmin: false //允许全屏最小化
		  ,anim: 1 //0-6的动画形式，-1不开启
		  ,content: '<img style="margin:50px auto;display:block;" src="${request.contextPath}/static/images/androidApk.png" alt=""/>'
		});    
	}
</script>
<script type="text/javascript">
	 if(IEVersion()>=6){
	 	var videoHeight=document.body.clientWidth*1080/1920;
		var videoTop=document.body.clientHeight-videoHeight;
		document.getElementById("video").style.top=videoTop+"px";
	 }
	 function IEVersion() {
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
        var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
        var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
        if(isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if(fIEVersion == 7) {
                return 7;
            } else if(fIEVersion == 8) {
                return 8;
            } else if(fIEVersion == 9) {
                return 9;
            } else if(fIEVersion == 10) {
                return 10;
            } else {
                return 6;//IE版本<=7
            }   
        } else if(isEdge) {
            return 'edge';//edge
        } else if(isIE11) {
            return 11; //IE11  
        }else{
            return -1;//不是ie浏览器
        }
    }
</script>
</html>