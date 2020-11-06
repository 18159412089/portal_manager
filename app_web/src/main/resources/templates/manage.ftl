<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title> 系统管理—<#if titleName?? && titleName != "">${titleName}<#else>漳州生态云</#if></title>
    <link rel="shortcut icon" href="${request.contextPath}/static/logo.ico">
<#-- uimaker主题-->
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/easyui.css"/>
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/icon.css"/>
<#-- bootstrap主题-->
<#--<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/bootstrap/easyui.css"/>-->
<#-- default主题-->
<#--<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/default/easyui.css"/>-->
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/icon.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/index.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/IconExtension.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/base.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/platform.css"/>

    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="${request.contextPath}/static/plugin/echarts/echarts.min.js"></script>
    <script src='${request.contextPath}/static/js/index.js'></script>
    <script src="${request.contextPath}/static/common/Ams.js"></script>

    <script type="text/javascript">

        Ams.addCtx("${request.contextPath}");

        // 获取当前用户的菜单
        var menus = eval('${titles}');


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
        });
        //弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
        function msgShow(title, msgString, msgType) {
            $.messager.alert(title, msgString, msgType);
        }
    </script>
    
</head>
<!-- body -->
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
<noscript>
    <div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
        <img src="${request.contextPath}/static/images/noscript.gif" alt='抱歉，请开启脚本支持！'/>
    </div>
</noscript>
<div class="container">
<!-- hearder -->
<div id="pf-hd">
	<div region="north" split="true" border="false">	
	    <span class="pf-logo">
	   		<a href="${request.contextPath}/index"><img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/></a>
            <#if titleName?? && titleName != "">
                ${titleName}
                <#else>
                漳州生态云
            </#if>
	    </span>
	    <div class="pf-user">
            <div class="pf-user-photo">
                <img src="${request.contextPath}/static/images/main/user.png" alt="">
            </div>            
            <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
            <i class="iconfont xiala">&#xe607;</i>

            <div class="pf-user-panel">
                <ul class="pf-user-opt">
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont">&#xe60d;</i>
                            <span class="pf-opt-name">用户信息</span>
                        </a>
                    </li>
                    <li class="pf-modify-pwd">
                    	<a href="#" id="editpass">
							<i class="iconfont">&#xe634;</i>
                            <span class="pf-opt-name">修改密码</span>
                        </a>                         
                    </li>
                    <li class="pf-logout">
                         <a href="#" id="loginOut">
                            <i class="iconfont">&#xe60e;</i>
                            <span class="pf-opt-name">退出</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
	    
	    <div class="pf-nav-wrap">
	        <div class="pf-nav-ww">
	          <ul class="pf-nav" id="topMenu"></ul>
	        </div>
			<!--翻页 -->
	        <a href="javascript:;" class="pf-nav-prev disabled iconfont">&#xe606;</a>
	        <a href="javascript:;" class="pf-nav-next iconfont">&#xe607;</a>
	      </div>
	</div>
</div>
<div id="pf-bd">
	<!-- tab -->
	<div id="pf-sider">
		<h2 class="pf-model-name">
	        <span class="iconfont">&#xe64a;</span>
	        <span class="pf-name">系统菜单</span>
	        <span class="toggle-icon"></span>
        </h2>
		<div id="nav" class="easyui-accordion" border="false">
	        <!--  导航内容 -->
	        
	    </div>
	</div>	
	<!-- main -->
	<div id="pf-page">
	    <div id="tabs" class="easyui-tabs1" border="false">
	        <div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; ">
	            <h1 style="font-size:24px;">欢迎使用漳州环保数据资源中心</h1>
	        </div>
	    </div>
	</div>
	
	
</div>

	<!-- footer -->
	<div id="pf-ft">
		<div class="system-name">
	      <i class="iconfont">&#xe6fe;</i>
	      <span>厦门智慧指间科技有限公司</span>
	    </div>
	    <div class="copyright-name">
	      <#--<span>CopyRight&nbsp;2018&nbsp;&nbsp;厦门智慧指间科技有限公司&nbsp;版权所有</span>-->
	      <i class="iconfont" >&#xe6ff;</i>
	    </div>
	</div>
</div>

<!--修改密码窗口-->
<div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding=3>
                <tr>
                    <td>新密码：</td>
                    <td><input id="txtNewPass" type="Password" class="pwd"/></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input id="txtRePass" type="Password" class="pwd"/></td>
                </tr>
            </table>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">
                确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
        </div>
    </div>
</div>

<!-- menu -->
<div id="mm" class="easyui-menu" style="width:150px;">
    <div id="mm-tabupdate">刷新</div>
    <div class="menu-sep"></div>
    <div id="mm-tabclose">关闭</div>
    <div id="mm-tabcloseall">全部关闭</div>
    <div id="mm-tabcloseother">除此之外全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright">当前页右侧全部关闭</div>
    <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
</div>

</body>
</html>
