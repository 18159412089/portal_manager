<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ERM生态环境资源管理平台</title>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/base.css"/>
    <link href="${request.contextPath}/static/css/login.css" rel="stylesheet">
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>

</head>
<body class="white">
<div class="login-hd">
    <div class="left-bg"></div>
    <div class="right-bg"></div>
    <div class="hd-inner">
        <span class="logo"></span>
        <span class="split"></span>
        <span class="sys-name">ERM生态环境资源管理平台</span>
    </div>
</div>

<div style="margin: 20px;font-size: 20px;">授权信息：</div>
<div style="margin: 20px;"><pre>${licenseInfoText}</pre></div>
<div class="error-info" style="margin: 20px;">如若有疑义，请与<a href="http://www.fjzxdz.cn" target="_blank">福建中兴电子科技有限公司</a>(www.fjzxdz.cn)联系。</div>
</body>
</html>

<script type="text/javascript">
    $(function () {
        $("#kaptcha").on('click', function () {
            $("#kaptcha").attr('src', '${request.contextPath}/kaptcha?' + Math.floor(Math.random() * 100)).fadeIn();
        });
    });
</script>
