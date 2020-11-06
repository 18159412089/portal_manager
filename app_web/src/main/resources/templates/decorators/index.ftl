<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html>
    <#include "header.ftl">
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
<noscript>
    <div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
        <img src="${request.contextPath}/static/images/noscript.gif" alt='抱歉，请开启脚本支持！'/>
    </div>
</noscript>
<div class="container">
    <!-- hearder -->
        <#--<#if menu??&& menu=="waterEnvironmentMenu">
        <#include "/waterEnvironmentMenu.ftl"> 
        <#elseif (menu??&&menu=="dataServiceMenu")>
        <#include "/dataServiceMenu.ftl"> 
        <#elseif menu??&&menu=="applicationServiceMenu">
        <#include "/applicationServiceMenu.ftl"> 
        <#elseif menu??&&menu=="airEnvironmentMenu">
        <#include "/airEnvironmentMenu.ftl">
        <#else>
           <#include "/secondToolbar.ftl">
        </#if>-->
    <#include "/secondToolbar.ftl">
    <div>
    <sitemesh:write property='body'/>
    </div>
    <!-- footer -->
  
    
    <#include "footer.ftl">
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
            <a id="btnEp" class="easyui-linkbutton btn-primary" href="javascript:void(0)">
                确定</a> <a id="btnCancel" class="easyui-linkbutton" href="javascript:void(0)">取消</a>
        </div>
    </div>
</div>
</body>
</html>