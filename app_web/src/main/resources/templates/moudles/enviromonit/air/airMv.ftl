<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>视频</title>
</head>
<body style="overflow: auto;">
<video src="${request.contextPath}/static/js/moudles/enviromonit/air/${name}" controls="controls">
您的浏览器不支持 video 标签。
</video>
</body>

</html>