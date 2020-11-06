<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>区域</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>
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
          <h3> <a><i class="icon iconcustom icon-fanhui5"></i> 九龙江流域</a>  </h3>

          <img style="width: 100%;max-width: 900px;" src="${request.contextPath}/static/images/pollute/map_img.png">
      </div>
        <div class="tagging-item">
            <p><img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a></p>
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
                        <a href="indextemp23">浦南水文站</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">长泰洛宾</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">上板</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">南靖靖城桥</a>
                    </div>
                </div>
            </div>
			<div class="item border-style">
				<h3> <a>污水处理厂 <i> <img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a> </h3>
                <div class="info-data">
                    <div class="tex">
                        <a href="indextemp23">华安县三达水务有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">长泰西区污水处理厂（长泰县三达水务有限公司）</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">漳州市西区污水处理厂</a>
                    </div>
                    <div class="tex">
                        <a href="indextemp23">南靖高新污水处理厂（西部水务（漳州）有限公司）</a>
                    </div>
                </div>
			</div>
			<div class="item border-style">
				<h3> <a>水闸 <i> <img src="${request.contextPath}/static/images/pollute/icon-img2.png"></i></a> </h3>
                <div class="info-data">
                    <#--<div class="tex">
                        <a href="indextemp23">龙津溪洛宾国控断面</a>
                    </div>-->

                </div>
			</div>
		</div>

		<div class="chart-box">
            <#--<h3>  <span></span></h3>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 blue">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="abasinrea"></div>
                            <span>4</span>
                           &lt;#&ndash; <div class="name">北溪/龙津溪</div>&ndash;&gt;
                        </div>
                    </div>
                </div>
                <p>国控断面</p>
            </div>-->
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 green">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span>4</span>
                            <#--<div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>国控断面 </p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 green">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span>4</span>
                            <#--<div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>污水处理厂 </p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 purple">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span>无</span>
                            <#--<div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>水闸 </p>
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
//    $(function () {
//        /*---------------------------------------漳州市周统计-------------------------------------------*/
//
//        var dataPieCharts = echarts.init(document.getElementById('dataPieCharts'));
//
//        var dataPieChartsOption= {
//            title : {
//                text: '国控断面',
//                x:'center',
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//            },
//
//            legend: {
//                orient: 'horizontal',
//                top:240,
//                left: 'center',
//                data: ['西溪200个','北溪300个','南溪500个'],
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//
//
//            },
//            series : [
//                {
//                    name: '访问来源',
//                    type: 'pie',
//                    radius : '62%',
//                    center: ['50%', '46%'],
//                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
//                    data:[
//                        {value:200, name:'西溪200个'},
//                        {value:300, name:'北溪300个'},
//                        {value:500, name:'南溪500个'},
//                    ],
//                    itemStyle: {
//                        emphasis: {
//                            shadowBlur: 10,
//                            shadowOffsetX: 0,
//                            shadowColor: 'rgba(0, 0, 0, 0.5)'
//                        }
//                    }
//                }
//            ]
//        };
//        dataPieCharts.setOption(dataPieChartsOption);
//
//
//        var dataPieCharts2 = echarts.init(document.getElementById('dataPieCharts2'));
//        var dataPieChartsOption2= {
//            title : {
//                text: '国控断面',
//                x:'center',
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//            },
//            legend: {
//                orient: 'horizontal',
//                top:240,
//                left: 'center',
//                data: ['西溪200个','北溪300个','南溪500个'],
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//
//
//            },
//            series : [
//                {
//                    name: '访问来源',
//                    type: 'pie',
//                    radius : '62%',
//                    center: ['50%', '46%'],
//                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
//                    data:[
//                        {value:200, name:'西溪200个'},
//                        {value:300, name:'北溪300个'},
//                        {value:500, name:'南溪500个'},
//                    ],
//                    itemStyle: {
//                        emphasis: {
//                            shadowBlur: 10,
//                            shadowOffsetX: 0,
//                            shadowColor: 'rgba(0, 0, 0, 0.5)'
//                        }
//                    }
//                }
//            ]
//        };
//        dataPieCharts2.setOption(dataPieChartsOption2);
//
//        var dataPieCharts3 = echarts.init(document.getElementById('dataPieCharts3'));
//        var dataPieChartsOption3= {
//            title : {
//                text: '国控断面',
//                x:'center',
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//            },
//            legend: {
//                orient: 'horizontal',
//                top:240,
//                left: 'center',
//                data: ['西溪200个','北溪300个','南溪500个'],
//                textStyle: { //图例文字的样式
//                    color: '#fff',
//                    fontSize: 13
//                },
//
//
//            },
//            series : [
//                {
//                    name: '访问来源',
//                    type: 'pie',
//                    radius : '62%',
//                    center: ['50%', '46%'],
//                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
//                    data:[
//                        {value:200, name:'西溪200个'},
//                        {value:300, name:'北溪300个'},
//                        {value:500, name:'南溪500个'},
//                    ],
//                    itemStyle: {
//                        emphasis: {
//                            shadowBlur: 10,
//                            shadowOffsetX: 0,
//                            shadowColor: 'rgba(0, 0, 0, 0.5)'
//                        }
//                    }
//                }
//            ]
//        };
//        dataPieCharts3.setOption(dataPieChartsOption3);
//
//        window.onresize = function () {
//            dataPieCharts.resize();
//            dataPieCharts2.resize();
//            dataPieCharts3.resize();
//        }
//    });




</script>
</html>