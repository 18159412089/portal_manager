<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="pf-hd" style="position: absolute;width:100%;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云 - 大气环境
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
                <li class="pf-modify-pwd" id="editpass">
                    <a href="#">
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload">
                    <a href="#" >
                        <i class="iconfont">&#xe670;</i>
                        <span class="pf-opt-name">下载操作手册</span>
                    </a>
                </li>
                <li class="pf-logout" id="loginOut">
                    <a href="#">
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="nav-container">
        <div class="nav-box">
            <ul class="nav-ul-tag">
                <li>
                    <a href="${request.contextPath}/index" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <div class="title">首页</div>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/airEnvironment" tab_id="d4" title="空气质量">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">大气环境服务</span>
                    </a>
                </li>
                <li class="item-link">
                    <a href="${request.contextPath}/env/mainPage/main.do?type=newAirDataService&menu=airEnvironmentMenu"
                       tab_id="d4" title="数据服务" target="_self">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/environment/debrief/airIndex" tab_id="d4" title="大气环境汇报">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">大气环境汇报</span>
                    </a>
                </li>
                <li>
                    <a href="http://carbon.nju.edu.cn/cn/" tab_id="d4" title="空气质量预报" target="_blank">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">空气质量预报</span>
                    </a>
                </li>

                <li>
                    <a href="http://www.weather.com.cn/weather/101230601.shtml" tab_id="d4" title="漳州天气网"
                       target="_blank">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">漳州天气网</span>
                    </a>
                </li>

                <li>
                    <a href="https://www.windy.com/?24.513,117.656,5,i:pressure" tab_id="d4" title="Windy MAP"
                       target="_blank">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">风向地图</span>
                    </a>
                </li>
                <li class="item-link">
                    <a href="https://airwise.zc12369.com/" tab_id="d4" title="AIR WISE" target="_blank">
                        <i class="icon iconcustom icon-huanjing2"></i>
                        <span class="title">AIR WISE</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="nav-menu-tag">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/poc/menu.js" charset="utf-8"></script>
<script>

</script>