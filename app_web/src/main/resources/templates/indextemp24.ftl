<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>污水处理厂详情</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>

<link rel="stylesheet" href="${request.contextPath}/static/css/animate.min.css" >
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/wow.min.js"></script>
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

<#--<--------内容------->
<div class="region-content">


<#--<---地图 --->
 <div class="map-left border-style">
      <div class="map-title">
          <h3> <a><i class="icon iconcustom icon-fanhui5"></i> 九龙江流域</a>  </h3>
          <img style="width: 100%;max-width: 900px;" src="${request.contextPath}/static/images/pollute/map_img.png">
      </div>

 <#--<---详情 --->
        <div class="tagging-item">
            <p><img src="${request.contextPath}/static/images/pollute/icon-img1.png"></p>
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

<#--<------>
	<div class="region-right">
         <div class="handle-data">
            <div class="handle-left">
                 <div class="part-one border-style">
                     <h3><a>县城污水处理厂</a></h3>
                     <div class="tex">
                         <a>建设日期：2017</a>
                     </div>
                     <div class="tex">
                         <a>设计规模：3万m³/日</a>
                     </div>
                     <div class="tex">
                         <a>占地面积：6.5亩</a>
                     </div>
                     <div class="tex">
                         <a>执行标准：一级A标准</a>
                     </div>
                 </div>
                 <div class="part-one border-style part-height" >
                    <h3><a>数据分析</a></h3>
                     <div class="overflow-box">
                         <div class="tex">
                             <div class="row"><span>今日已处理：41</span> </div>
                             <div id="barChart1" style="height: 20px;"></div>
                             <div class="row"><span>0</span> <span>w</span> </div>
                         </div>
                         <div class="tex">
                             <div class="row"><span>今日排放：5.2</span>  <span>处理能力不足</span> </div>
                             <div id="barChart2" style="height: 20px;"></div>
                             <div class="row"><span>0</span> <span>w</span> </div>
                         </div>
                         <div class="tex">
                             <div  id="barChart" style="height: 70px; width: 100%"></div>
                         </div>
                     </div>

                </div>
            </div>

             <div class="handle-right  border-style" >
                 <div class="table-box">
                     <h3><a>处理厂辐射企业 <span>（4个）</span> </a></h3>
                     <div class="content">
                          <div class="table-head">
                             <span>企业名称</span>
                             <span>排放(吨)</span>
                         </div>
                          <div class="roll">
                            <table>
                                <tr>
                                    <td><a>长泰县连胜纸业</a></td>
                                    <td><a>223324</a></td>
                                </tr>
                                <tr>
                                    <td><a>东墩污水处理</a></td>
                                    <td><a>3366636</a></td>
                                </tr>
                                <tr>
                                    <td><a>山鹰联盛纸业</a></td>
                                    <td><a>6336333</a></td>
                                </tr>
                                <tr>
                                    <td><a>上板污水处理厂</a></td>
                                    <td><a>3222203</a></td>
                                </tr>
                            </table>
                        </div>
                         <div class="tex">
                             <div  id="barChart4" style="height: 70px; width: 100%"></div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
        <div class="video-part">
           <div class="video-item"></div>
            <div class="video-item"></div>
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
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    /*打开dialog*/
    function dialogOpen(target){
        var sWidth=$(target).dialog('panel').outerWidth();
        var pWidth=$(target).dialog('panel').parent().outerWidth();
        var sHeight=$(target).dialog('panel').outerHeight();
        var pHeight=$(target).dialog('panel').parent().outerHeight();

        sWidth=sWidth<pWidth?sWidth:pWidth-40;
        sHeight=sHeight<pHeight?sHeight:pHeight-40;

        var sLeft=(pWidth-sWidth)/2;
        var sTop=(pHeight-sHeight)/2;

        $(target).dialog('open').panel('resize',{
            width: sWidth,
            height: sHeight,
            left:sLeft,
            top:sTop
        });
    }

    var labelSetting = {
        show: true,
        position: 'top',
        textStyle: {
            fontSize: 12,
            color:'#ffffff',
        },formatter:'{a}：{c}%'
    };


    var fullBgBar = {
        name:"full_bg",
        type: 'bar',
        itemStyle: {
            normal: {
                color: '#fff',
                barBorderRadius: 6,
                opacity:0.05
            }
        },
        barWidth:'12',
        barGap: '-100%', // Make series be overlap
        data: [100],
        zlevel:-1,
        animation: false

    };
    var barGrid={
        top:'80',
        left: '20',
        right: '20',
        containLabel: true
    };
    var barYAxis={
        data: ['reindeer'],
        inverse: true,
        axisLine: {show: false},
        axisTick: {show: false},
        axisLabel:{show: false},
        axisPointer: {show: false}
    };
    var barXAxis={
        splitLine: {show: false},
        axisLabel: {show: false},
        axisTick: {show: false},
        axisLine: {show: false}
    };
    $(function () {

        var barChart = echarts.init(document.getElementById('barChart'));
        var barOption ={
            legend: {
                itemWidth: 12,
                itemHeight: 12,
                selectedMode: false,
                data: ['金属物', '有机物','化学物','微生物','放射性','其他'],
                textStyle:{
                    color:'#fff',
                }
            },
            grid: barGrid,
            yAxis: barYAxis,
            xAxis: barXAxis,
            series: [
                {
                    name: '金属物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#49b949',
                            barBorderRadius: [6, 0, 0, 6]//第一个显示的数据
                        }
                    },
                    data: [12]
                },{
                    name: '有机物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#2ba4e9',
                        }
                    },
                    data: [12]
                },{
                    name: '化学物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#fe8a57',
                        }
                    },
                    data: [2]
                },{
                    name: '微生物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#ffa800',
                        }
                    },
                    data: [12]
                },{
                    name: '放射性',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#ea83aa',
                        }
                    },
                    data: [12]
                },{
                    name: '其他',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#687dbf',
                            barBorderRadius: [0, 6, 6, 0]//最后一个显示的数据
                        }
                    },
                    data: [12]
                },fullBgBar


            ],
        };
        barChart.setOption(barOption);


        var barChart4 = echarts.init(document.getElementById('barChart4'));
        var barOption4 ={
            legend: {
                itemWidth: 12,
                itemHeight: 12,
                selectedMode: false,
                data: ['工业', '农业','生活','其他'],
                textStyle:{
                    color:'#fff',
                }
            },
            grid: barGrid,
            yAxis: barYAxis,
            xAxis: barXAxis,
            series: [
                {
                    name: '工业',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#49b949',
                            barBorderRadius: [6, 0, 0, 6]//第一个显示的数据
                        }
                    },
                    data: [20]
                },{
                    name: '农业',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#ffa800',
                        }
                    },
                    data: [20]
                },{
                    name: '生活',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#ea83aa',
                        }
                    },
                    data: [30]
                },{
                    name: '其他',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    emphasis:{
                        label:labelSetting
                    },
                    itemStyle:{
                        normal:{
                            color:'#687dbf',
                            barBorderRadius: [0, 6, 6, 0]//最后一个显示的数据
                        }
                    },
                    data: [30]
                },fullBgBar


            ],
        };
        barChart4.setOption(barOption4);

        /*--------------------------------------------------------------*/
        var barChart1 = echarts.init(document.getElementById('barChart1'));
        var barOption1 ={
            grid: {
                left: '20',
                right: '20'
            },
            yAxis: barYAxis,
            xAxis: barXAxis,
            series: [
                {
                    name: '金属物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    itemStyle:{
                        normal:{
                            color:'#e14a83',
                            barBorderRadius: 6
                        }
                    },
                    data: [60]
                },fullBgBar

            ],
        };
        barChart1.setOption(barOption1);


        var barChart2 = echarts.init(document.getElementById('barChart2'));
        var barOption2 ={
            grid: {
                left: '20',
                right: '20'
            },
            yAxis: barYAxis,
            xAxis: barXAxis,
            series: [
                {
                    name: '金属物',
                    type: 'bar',
                    stack: 'one',
                    barWidth:'12',
                    itemStyle:{
                        normal:{
                            color:'#49b949',
                            barBorderRadius: 6
                        }
                    },
                    data: [60]
                },fullBgBar

            ],
        };
        barChart2.setOption(barOption2);
        //打开弹窗
        //dialogOpen('#dd');
        window.onresize = function () {
            barChart.resize();
            barChart2.resize();
            barChart3.resize();
            barChart4.resize();
        }

    });

</script>
</html>