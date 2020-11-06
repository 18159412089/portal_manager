<head>
	<title>
        <sitemesh:write property='title'/>
    </title>
    <link rel="shortcut icon" href="${request.contextPath}/static/logo.ico">
<#-- uimaker主题-->
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/easyui.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/icon.css"/>
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/upload/webuploader.css">
<#-- bootstrap主题-->
<#--<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/bootstrap/easyui.css"/>-->
<#-- default主题-->
<#--<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/default/easyui.css"/>-->

    <!-- 自定义css -->
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/icon.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/IconExtension.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css"/>

    <link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/mCustomScrollbar/jquery.mCustomScrollbar.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/base.css?v=1"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/platform.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/css/progressbar.css" />
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/providers.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
    <#--<link rel="stylesheet" href="${request.contextPath}/static/css/yl.css"/>-->
    <#--<link rel="stylesheet" href="${request.contextPath}/static/css/theme.zhangPu.blue.css"/>--><!--漳浦项目时取消注释-->

<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${request.contextPath}/static/plugin/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="${request.contextPath}/static/plugin/echarts/echarts.min.js"></script>
<script src="${request.contextPath}/static/js/echarts-liquidfill.js"></script>
<script src="${request.contextPath}/static/mCustomScrollbar/jquery.mCustomScrollbar.js"></script>
<script src="${request.contextPath}/static/common/Ams.js"></script>
<script src="${request.contextPath}/static/js/html2canvas.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/jsPdf.debug.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.easyui.common.min.js"></script>
<script src="${request.contextPath}/static/layer/layer.js"></script>

<#--<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/swiper.min.css"></link>-->
    <#--<script src="${request.contextPath}/static/js/swiper.min.js"></script>-->
    <!-- layui js 引用 -->
    <script src="${request.contextPath}/static/layui/layui.js"></script>

	<sitemesh:write property='head'/>
    <style>
        .navbar .header-nav:after{content: "";display: block;clear:both;}
        .navbar .header-nav>li{
            display: block;
            float: left;
        }
        .navbar .header-nav>li>a {
            margin:0;
            padding:0;
            width:110px;
            height:70px;
            color:#fff;
            text-align:center;
            font-size:14px;
            text-shadow:none;
            display:block;
            overflow:hidden;
            text-decoration:none;
        }
        .navbar .header-nav>li>a .icon{font-size:28px;margin-top: 14px;}
        .navbar .header-nav>li>a .title{margin:0;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;display: block;}
        .navbar .header-nav>li:hover>a
        ,.navbar .header-nav>li>a:focus
        ,.navbar .header-nav>li.active>a:focus
        ,.navbar .header-nav>li.active>a
        ,.navbar .header-nav>li.active:hover>a {
            color:#4a4a4a;background: #fff;
            -webkit-box-shadow:none;
            -moz-box-shadow:none;
            box-shadow:none;
        }
        .navbar .header-nav{position:static;}
        /*.navbar .header-nav>li.active>a{background:#eef3ee;} */
        .navbar .header-nav>li:hover > .dropdown-nav{display:block;}
        .dropdown-nav{position:absolute;top: 100%;left: 0;right:0;z-index: 1000;padding:0 10px;
            display: none;background:#fff;border-bottom:1px solid #cacaca;
        }
        .dropdown-nav .dropdown-nav{background:#f2f2f2;display: none;}
        .dropdown-nav > div{display:inline-block;}
        .dropdown-nav > div >a {display:inline-block;
            margin:0;
            padding:12px 0;
            width:120px;
            color:#4a4a4a;
            text-align:center;
            font-size:14px;
            text-decoration:none;
        }
        .dropdown-nav > div >a:hover{text-decoration:none;}
        .dropdown-nav > div:hover >a{background:#f2f2f2;}
        .dropdown-nav > div:hover .dropdown-nav{display:block;}
        .dropdown-nav > div >a .icon{font-size:28px;}
        .dropdown-nav > div >a .title{margin:0;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;}
        .dropdown-nav > div >a:hover
        ,.dropdown-nav > div >a:focus{color:#268AEA;}




            .input-content{
                text-align: center;
            }
        }

    </style>

    <script type="text/javascript">

        Ams.addCtx("${request.contextPath}");

        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 400,
                modal: true,
                shadow: true,
                closed: true,
                height: 170,
                resizable: false
            });
        }

        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }


        //修改密码
        function editPwd() {

            var $newPwd = $('#txtNewPass');
            var $repeatPwd = $('#txtRePass');

            if ($newPwd.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($repeatPwd.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newPwd.val() != $repeatPwd.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }

            $.post('/sys/user/editPwd?newPwd=' + $newPwd.val(), function (data) {
                window.location.href = '${request.contextPath}/logout';
            })

        }
        //弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
        function msgShow(title, msgString, msgType) {
            $.messager.alert(title, msgString, msgType);
        }

        $(function () {

            openPwd();

            $('#editpass').click(function () {
                $('#w').window('open');
            });

            $('#btnEp').click(function () {
                editPwd();
            })

            $('#btnCancel').click(function () {
                closePwd();
            })

            $('#loginOut').click(function () {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {
                    if (r) {
                        //location.href = '${request.contextPath}/logout';
                        location.href = '${request.contextPath}/loginOut';
                    }
                });
            })
            $('#omDownload').click(function () {
                window.location = "https://140.237.73.123:8088/zz-sso-server-web/static/webPlugin/资源中心-用户操作手册.doc";
            })
        });
    </script>
    <#--根据自己模板所需要的木块添加 css  只需包含在head标签即可-->
    <sitemesh:write property='head'/>

</head>