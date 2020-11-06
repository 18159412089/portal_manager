<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>断面详情</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
<#--<  头部>-->
<#--<  头部>-->
<div id="pf-hd"  class="pf-head">
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
                <li id="omDownload">
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
            <ul class="nav-ul-tag">
                <li class="select-link">
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-shouye1"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li >
                    <a href="#" target="_self">
                        <i class="icon iconcustom icon-gongzuoguanli1"></i>
                        <span class="title">水环境服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-fenzhi"></i>
                        <span class="title"> 污染溯源</span>
                    </a>
                </li>
                <li>
                    <a href="#" target="_blank">
                        <i class="icon iconcustom icon-shuju2""></i>
                        <span class="title"> 数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="icon iconcustom icon-jianguan1"></i>
                        <span class="title"> 总体情况</span>
                    </a>
                </li>
                <li>
                    <a  href="#"  target="_blank">
                        <i class="icon iconcustom icon-jibenxinxi1"></i>
                        <span class="title">一河一策</span>
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

<div class="region-content">
    <div class="map-left border-style">
      <div class="map-title">
          <h3><a href="/environment/pollutionTraceability/detail" style="text-decoration:none">
              <i class="icon iconcustom icon-fanhui5"></i> 返回 </a> </h3>
          <img style="width: 100%;max-width: 900px;" src="${request.contextPath}/static/images/pollute/map_img.png">
      </div>
        <div class="tagging-item">
           <h5>华安县三达水务有限公司</h5>
            <div class="row">
                <span>吨数：5万吨</span>
            </div>
            <div class="row">
               <span> 农业:</span>
              <div class="speed-box min-speed">
                <div class="speed-row"><span class="tag violet" style="width: 20%"></span></div>
              </div>
            </div>

            <div class="row">
                <span> 农业:</span>
                <div class="speed-box min-speed">
                    <div class="speed-row"><span class="tag pink" style="width: 50%"></span></div>
                </div>
            </div>

            <div class="row">
                <span> 农业:</span>
                <div class="speed-box min-speed">
                    <div class="speed-row"><span class="tag yellow" style="width: 30%"></span></div>
                </div>
            </div>
        </div>
	</div>

	<div class="region-right">
        <div class="region-info">
            <div class="item border-style">
                <h3> <a>国控断面 <i> <img src="${request.contextPath}/static/images/pollute/icon-img3.png"></i></a> </h3>
                <div class="info-data">
                    <div class="tex">
                        <a>浦南水文站</a>
                        <div class="speed-box">
                            <p>金属物 12%</p>
                            <div  class="speed-row">
                                <div class="tag green" style="width: 20%">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>有机物20%</p>
                            <div  class="speed-row">
                                <div class="tag orange" style="width: 30%">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>化学物 18%</p>
                            <div  class="speed-row">
                                <div class="tag yellow" style="width: 40%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                       <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>微生物 18%</p>
                            <div  class="speed-row">
                                <div class="tag pink" style="width: 60%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                        <#--<a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>放射物 12%</p>
                            <div  class="speed-row">
                                <div class="tag violet" style="width: 70%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tex">
                       <#-- <a>龙津溪洛宾国控断面</a>-->
                        <div class="speed-box">
                            <p>其他 20%</p>
                            <div  class="speed-row">
                                <div class="tag"></div>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<div class="item border-style">
                <h3> <a>污水处理厂 <i> <img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a> </h3>
                <div class="info-data">
                    <div class="info-data">
                        <div class="tex">
                            <a href="/indextemp24">华安县三达水务有限公司</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">长泰西区污水处理厂（长泰县三达水务有限公司）</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">漳州市西区污水处理厂</a>
                        </div>
                        <div class="tex">
                            <a href="javascript:void(0)">南靖高新污水处理厂（西部水务（漳州）有限公司）</a>
                        </div>
                    </div>
                </div>
			</div>
			<div class="item border-style">
                <h3> <a>常规排口 <i> <img src="${request.contextPath}/static/images/pollute/icon-img2.png"></i></a> </h3>
                <div class="info-data">
                    <div class="tex">
                        <a href="javascript:void(0)">福建立兴食品有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">漳州盈晟纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建荣信纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建省联盛纸业有限责任公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">大闽食品（漳州）有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">龙海市榜山民政三星造纸厂</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">龙海市信达纸业有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">漳州片仔癀药业股份有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">福建龙溪轴承（集团）股份有限公司</a>
                    </div>
                </div>
			</div>
		</div>

		<div class="chart-box">
            <h3> 数据分析 <span></span></h3>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 yellow">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <#--<div class="name">南靖上洋</div>-->
                            <p>4</p>
                        </div>
                    </div>
                </div>
                <p>国控断面</p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 blue">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                           <#-- <div class="name">南靖上洋</div>-->
                            <p>4</p>
                        </div>
                    </div>
                </div>
                <p>污水处理厂</p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-1 green">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <#--<div class="name">南靖上洋</div>-->
                            <p>9</p>
                        </div>
                    </div>
                </div>
                <p>常规排口</p>
            </div>
		</div>
	</div>

</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
</script>
</html>