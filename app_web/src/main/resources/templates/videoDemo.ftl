<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE HTML>
<html>
<head>
    <title>视频直播</title>
    <meta charset="utf-8">
    <!-- 航拍视频相关 -->
    <link href="${request.contextPath}/static/css/video-js.css" rel="stylesheet">
    <!-- If you'd like to support IE8 -->
    <script src="${request.contextPath}/static/js/videojs-ie8.min.js"></script>
</head>
<body>
<video id="my-video" class="video-js" controls preload="auto" width="890px" height="550px"
       poster="" data-setup="{}">
    <source src="${rtmp}" type="rtmp/flv">
    <p class="vjs-no-js">播放视频需要启用 JavaScript，推荐使用支持HTML5的浏览器访问。
        To view this video please enable JavaScript, and consider upgrading to a web browser that
        <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
    </p>
</video>
<script src="${request.contextPath}/static/js/video.js"></script>
</body>
</html>