<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳浦-首页</title>
    <link rel="shortcut icon" href="${request.contextPath}/static/logo.ico">
    <!-- 第三方 css -->
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/easyui.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/mCustomScrollbar/jquery.mCustomScrollbar.css"/>
    <!-- 自定义 css -->
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/base.css?v=1"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/platform.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/providers.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css"/>
    <!-- 主题 css -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/theme.zhangPu.css"/>
    <!-- js 在底部 -->
</head>
<!-- body -->
<body class="home-bg">
<!-- 头部 -->
<header class="home-header-container">
    <div class="header-logo">
        <h1 class="logo-text">漳浦生态环境数据汇聚平台</h1>
    </div>
</header>
<!-- 头部 over  -->
<div id="pf-md">
    <div class="home-links-container">
        <div class="home-links-table">
            <div class="home-links-table-cell">
                <!-- 链接  -->
                <div class="home-links-wrapper">
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-shidu2"></div>
                                    <div class="name">水环境</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom iconyintian"></div>
                                    <div class="name">大气环境</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-dubananjian1"></div>
                                    <div class="name">环保督查督办</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-ditu1"></div>
                                    <div class="name">环保一张图</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href=""https://140.237.73.123:8081/enter/mainPage/main.do?type=ENTER&amp;menu=dataServiceMenu&amp;pid=b5585e44-6432-47f0-897e-c074d1f73228"">
                                    <div class="icon iconcustom icon-baobiaotongji1"></div>
                                    <div class="name">年度数据大屏</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-qiyexinxi3"></div>
                                    <div class="name">企业信息</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-wulian2"></div>
                                    <div class="name">网格化</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="link-item">
                        <div class="home-links-box">
                            <div class="link-bg">
                                <div class="bg-img bg-1"></div>
                                <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                            </div>
                            <div class="link-text-box">
                                <a class="link-text" href="">
                                    <div class="icon iconcustom icon-shebeiguanli2"></div>
                                    <div class="name">系统管理</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 链接 over  -->
            </div>

        </div>
    </div>

</div>
</body>
<!-- 基础 js -->
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
<!-- 页面 js -->
<script type="text/javascript">


    $(function () {

    });
    $(window).resize(function() {


    });


</script>

</html>
