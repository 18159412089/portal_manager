<style>
    #pf-hd{ height: 62px;}
    #pf-hd .pf-logo{ line-height: 62px;}
    .nav-container .nav-box >ul >li{height: 62px;}
    .nav-container .nav-box >ul .select-link a{ line-height: 62px;}
    .nav-container .nav-box >ul >li >a{line-height: 62px; }
    .nav-container .nav-menu-tag a{margin-top: 3px;}
    #pf-hd .pf-user{height: 62px;line-height: 62px; }
    #pf-hd .pf-user .pf-user-panel{ top: 62px;}
    .nav-container .nav-box{ height: 62px;}
</style>
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
<script>
    var url = window.location.href;
    var pathname = window.location.pathname;
    $(document).ready(function(){
        $('.nav-ul-tag').find("a").each(function () {
           var nav_url = $(this).attr("href");
           if(nav_url == pathname || nav_url == url){
               $(this).parent().addClass("select-link");
           }
         })
    });
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
        //    window.location = "https://140.237.73.123:8088/zz-sso-server-web/static/webPlugin/资源中心-用户操作手册.doc";
        })
    });
</script>

<div id="pf-hd">
    <span class="pf-logo">
        <img src="/static/images/blocks1.png" align="absmiddle"/>  漳浦生态汇聚平台
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="/static/images/main/user.png" alt="">
        </div>
        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
        <i class="iconfont xiala">&#xe607;</i>

        <div class="pf-user-panel">
            <ul class="pf-user-opt">
                <li class="hide">
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <li class="pf-modify-pwd hide" id="editpass">
                    <a href="#" >
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload" class="hide">
                    <a href="#" >
                        <i class="iconfont">&#xe670;</i>
                        <span class="pf-opt-name">下载操作手册</span>
                    </a>
                </li>
                <li class="pf-logout" id="loginOut">
                    <a href="#" >
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <#--  当导航只有一级开始-->

    <div  class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag" id="second">
                <li>
                    <a href="${request.contextPath}/zphb/index" target="_self">
                        <span class="title">首页</span>
                    </a>
                </li>
                <li><#-- class="select-link"-->
                    <a href="${request.contextPath}/zphb/zpCameraMap" target="_self">
                        <span class="title">环保一张图</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/zphb/zpCommandCenter" target="_blank">
                        <span class="title">指挥调度</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/zphb/zhangPuPollutionDataMap" target="_self">
                        <span class="title">污染源数据</span>
                    </a>

                </li>

            </ul>
        </div>
        <div class="nav-menu-tag hide">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>

</div>
