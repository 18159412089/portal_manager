<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<style>
 .nav-box{ float: left;}
 #pf-hd .pf-logo{    border-right: 1px solid #45b97c; }
 .nav-box >ul >li{position: relative;  float: left;min-width: 110px;}
 .nav-box >ul >li >a{ width: 100%; display: inline-block; text-align: center; color:white;font-size:15px;height:70px;}
 .nav-box >ul >li >a i{display: inline-block;font-size: 28px;margin-top: 10px;}
 .nav-box >ul >li >a span{display: inline-block;width:100%}
 .nav-box >ul >li.active>a{
            color:#4a4a4a;background: #fff;
            -webkit-box-shadow:none;
            -moz-box-shadow:none;
            box-shadow:none;
        }
 .nav-box >ul >li.active>a{background:#eef3ee;}
 .nav-box >ul >li:hover a{ background-color: white; color:#504f4f}
 .nav-box >ul >li:hover >.second-level{display: block}
 .nav-box >ul >li >.second-level{position: absolute;top: 70px;left: 0;display: none;box-shadow: 2px 2px 8px #e3e3e3; overflow: hidden;}
 .nav-box >ul >li >.many-columns {width:516px;background-color: white}
 .nav-box >ul >li >.second-level li{ background-color:white;width: 258px;float: left;}
 .nav-box >ul >li >.second-level li >a{display: inline-block;padding: 14px 12px; width:100%}
 .nav-box >ul >li >.second-level li >a:hover{background-color:#7ccda4 }
 .nav-box >ul >li >.second-level li >a:hover i{color:white}
 .nav-box >ul >li >.second-level li >a:hover span{color:white}
 .nav-box >ul >li >.second-level li >a i{font-size:28px;border:0px;float:left;}
 .nav-box >ul >li >.second-level li >a span{ display: inline-block;  margin-left: 15px;overflow: hidden;font-size:16px;float: left }
 .nav-box-one{display: none}
 .nav-container{display: inline-block}
 .switch-tag{    display: inline-block;  color: #bbb8b8;  height: 70px;  padding: 14px 0;width: 24px;margin-left: 20px;}
 .switch-tag span{
     display: inline-block;
     width: 24px;
     float: left;
     font-size: 16px;
     padding: 2px 0;
     text-align: center;
     cursor: pointer;
     background-color: #fbfbfb;
     border-top-left-radius: 4px;
     border-top-right-radius: 4px;
 }
 .switch-tag span:nth-child(2){
     margin-top: 4px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
     border-bottom-left-radius: 4px;
     border-bottom-right-radius: 4px;
 }
 .switch-tag span:hover{
     color: #45b97c !important;
 }

 @media screen and (max-width: 1450px){
     .nav-box >ul >li{
         min-width: 96px;
     }
 }
</style>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"></link>
<script src="${request.contextPath}/static/js/toolbar.js"></script>

<div id="pf-hd" style="position: absolute;width:100%;min-width: 1340px;">
    <span class="pf-logo">
        <img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
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
                    <a href="#" >
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
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
            <ul>
                <li>
                    <a href="${request.contextPath}/index" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li class="active">
                    <a href="${request.contextPath}/environment/hugeData" target="_blank">
                        <i class="icon iconcustom icon-daping1"></i>
                        <span class="title">大屏展示</span>
                    </a>
                </li>
                <li class="active">
                    <a href="${request.contextPath}/enviromonit/water/nationalSurfaceWater" target="_blank">
                        <i class="icon iconcustom icon-ditu1"></i>
                        <span class="title">水环境</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/airEnvironment" target="_blank">
                        <i class="icon iconcustom icon-ditu1"></i>
                        <span class="title">大气环境</span>
                    </a>
                </li>
                <li>
                    <a  href="${request.contextPath}/epa/epaMonitorMap.do?menu=applicationServiceMenu"  target="_blank">
                        <i class="icon iconcustom icon-ditu1"></i>
                        <span class="title">应用服务</span>
                    </a>
                </li>
                <li>

                    <a  href="${request.contextPath}/env/mainPage/main.do?type=AQI&menu=dataServiceMenu" target="_blank">
                        <i class="icon iconcustom icon-huanjing3"></i>
                        <span class="title">数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-huanjing3"></i>
                        <span class="title">目标责任</span>
                    </a>

                    <ul class="second-level">
                        <!-- <li class="item-link">
                            <a href="#" tab_id="d4" >
                            <i class="icon iconcustom icon-zichan3"></i>
                            <span class="title">督察地图</span>
                            </a>
                        </li> -->
                        <li class="item-link">
                            <a href="${request.contextPath}/environment/rectifition/show?authority=1" tab_id="d4"  target="_blank">
                                <i class="icon iconcustom icon-zichan3"></i>
                                <span class="title">突出生态环境问题</span>
                            </a>
                        </li>
                        <li class="item-link">
                            <a href="${request.contextPath}/environment/attach/environmentAttachDisplay?authority=1" tab_id="d4"  target="_blank">
                                <i class="icon iconcustom icon-zichan3"></i>
                                <span class="title">八闽快讯(一本账)</span>
                            </a>
                        </li>
                        <li class="item-link">
                            <a href="${request.contextPath}/jobSchedule/cliqueBuild" title="党政工作"  tab_id="d4"  target="_blank">
                                <i class="icon iconcustom icon-zichan3"></i>
                                <span class="title">党政工作</span>
                            </a>
                        </li>
                        <li class="item-link">
                            <a href="${request.contextPath}/indextemp7">
                                <i class="icon iconcustom icon-tousu1"></i>
                                <span class="title">月度汇报</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                	<a href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank">
                		<i class="icon iconcustom icon-huanjing2"></i>
                		<span class="title">网格化</span>
                	</a>
                </li>
                <li>
                    <a href="${request.contextPath}/manage" target="_blank">
                        <i class="icon iconcustom icon-leibie2"></i>
                        <span class="title">系统管理</span>
                    </a>
                </li>
                <!-- 数据维护 -->
                <#-- <@sec.authorize access="hasRole('ROLE_CITY') OR hasRole('ROLE_TOWN') OR !hasRole('ROLE_LEADER')"> -->
            <@sec.authorize access="hasRole('ROLE_CITY') OR hasRole('ROLE_TOWN') OR hasRole('ROLE_LEADER')">
                <li>
                    <a href="#" >
                        <i class="icon iconcustom icon-leibie2"></i>
                        <span class="title">数据录入</span>
                    </a>
                    <ul class="second-level">
                        <!-- <@sec.authorize access="!hasRole('ROLE_CITY') AND !hasRole('ROLE_TOWN')"> -->
                            <li class="item-link">
                                <a href="${request.contextPath}/environment/rectifition/show" tab_id="d4"  target="_blank">
                                    <i class="icon iconcustom icon-zichan3"></i>
                                    <span class="title">突出生态环境问题</span>
                                </a>
                            </li>
                            <li class="item-link">
                                <a href="${request.contextPath}/environment/attach/environmentAttachDisplay" tab_id="d4"  target="_blank">
                                    <i class="icon iconcustom icon-zichan3"></i>
                                    <span class="title">八闽快讯(一本账)</span>
                                </a>
                            </li>
                        <!-- </@sec.authorize>
                        <@sec.authorize access="hasRole('ROLE_CITY') OR hasRole('ROLE_TOWN')"> -->
                            <li class="item-link">
                                <a href="${request.contextPath}/env/mainPage/main.do?type=addRiverData" tab_id="d4" title="小流域数据维护" target="_blank">
                                    <i class="icon iconcustom icon-zichan3"></i>
                                    <span class="title">小流域数据维护</span>
                                </a>
                            </li>
                        <!-- </@sec.authorize> -->
                    </ul>
                </li>
            </@sec.authorize>
            </ul>
        </div>
    </div>


</div>

<script>
    $(".switch-top-icon").click(function () {
        $(".nav-box-one").show();
        $(".nav-box-two").hide();
    })
    $(".switch-bottom-icon").click(function () {
        $(".nav-box-one").hide();
        $(".nav-box-two").show();
    })
    $('.nav-container').find('li').each(function() {
			if($(this).find('a')[0].href == window.location.href) {
				$(this).addClass("active");
			} else {
				$(this).removeClass("active");
			}
			$(this).click(function() {
				if($(this).find('a')[0].href == window.location.href) {
					return false;
				}
            })
		});
</script>