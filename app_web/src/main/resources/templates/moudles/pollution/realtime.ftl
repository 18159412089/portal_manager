<!DOCTYPE html>
<html lang="en" class="real-body">
<head>
    <title>污染源实时动态数据</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudData.css"/>
</head>
<style>
    .home-ranking-list .panel-body{
        background: rgba(255, 255, 255, 0);
    }
    .home-ranking-list .datagrid-header, .home-ranking-list .datagrid-td-rownumber, .home-ranking-list .panel-header{
        background: rgba(255, 255, 255, 0);
    }
</style>
<!-- body -->
<body >
<div class="pollution-real-body ">
    <#--    头部---->
    <div class="home-real-head">
        <div class="real-head-left">
            <span id="tj"> <i><img src="${request.contextPath}/static/images/new-img/tips-icon.png" alt=""/></i> 截止2019年10月30日共排查各类污染源企业3463个</span>
        </div>
        <div class="real-head-title">
            <span>污染源实时动态数据</span>
        </div>
        <div class="real-head-right">
            <a class="real-but" href="${request.contextPath}/env/pollution2/pollutionInfo?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">进入</a>
            <a class="real-but" style="margin-left: 0" href="${request.contextPath}/env/pollution2/pollutionDataShow">汇总表</a>
        </div>
    </div>
    <#--内容-->
    <div class="real-content">
        <#-- ------左 数据表格------->
        <div class="real-data-info fl">

            <#-- ------边框线------->
            <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/border1.png" alt=""/></div>
            <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/border2.png" alt=""/></div>
            <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/border3.png" alt=""/></div>
            <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/border4.png" alt=""/></div>
            <#-- ------边框 ------->

            <div class="real-data-title">
                <span>县级实时更新</span>
            </div>
            <div class="home-air-panel" id="qxRanking">
                <div class="home-air-panel-body">
                    <div class="data-table-box ">
                        <div class="home-ranking-list">
                            <!-- 数据列表-->
                            <table id="qxTable" class="easyui-datagrid" url="" style="height:100%" data-options="
                                    singleSelect:true,
                                    fit:true,
                                    fitColumns:true,
                                    pagination:false">
                                <thead>
                                <tr>
                                    <th align="center" field="rownum" width="100" formatter="numStyle">序号</th>
                                    <th align="center" field="qx" width="180">区县</th>
                                    <th align="center" field="count" width="100">个数</th>
                                    <th align="center" field="time" width="200">最后更新时间</th>
                                </tr>
                                </thead>
                            </table>
                            <!-- 数据列表 over-->
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>

            </div>
        </div>

        <#-- ------污染源种类------->
        <div class="real-data-center">
            <div class="real-data-title">
                <span>污染源种类</span>
            </div>
            <div class="circular-data-box">

                <div class="circular-row ">
                    <div class="circular-item  fl">
                        <div class="entry-name entry-name3">
                            <a class="tex" target="_blank" href="/env/pollution2/pollutionInfos?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">
                                <p>水环境污染源</p>
                                <span id="s">22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse3 alont-tag">
                            <span id="ssgyqy">持证矿山(45)</span>
                        </div>



                    </div>

                    <div class="circular-item  fr">
                        <div class="entry-name entry-name4">
                            <a class="tex" target="_blank" href="/env/pollution2/pollutionInfodq?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">
                                <p>大气环境污染源</p>
                                <span id="dq">22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse4">
                            <span id="slwqy">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4">
                            <span id="fdlydy">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4 upward-left-tag">
                            <span id="vocs">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4 upward-right-tag">
                            <span id="gjyqy">持证矿山(45)</span>
                        </div>


                    </div>
                </div>

                <div class="circular-row ">
                    <div class="circular-item" style="margin: 0 auto">

                        <div class="entry-name entry-name5">
                            <a class="tex" target="_blank" href="/env/pollution2/pollutionInfotr?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">
                                <p>土壤环境污染源</p>
                                <span id="tr">22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse5">
                            <span id="gygf">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse5">
                            <span id="gywxfw">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse5 upward-right-tag">
                            <span id="sghfc">持证矿山(45)</span>
                        </div>

                    </div>

                </div>

                <div class="circular-row ">
                    <div class="circular-item copies-two fl">
                        <#--生态-->
                        <div class="entry-name entry-name1">
                            <a class="tex" target="_blank" href="/env/pollution2/pollutionInfost?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">
                                <p>生态环境污染源</p>
                                <span id="st">22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse1">
                            <span id="czks">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse1">
                            <span id="sbchy">持证矿山(45)</span>
                        </div>

                    </div>

                    <div class="circular-item copies-two fr">

                        <#--生态-->
                        <div class="entry-name entry-name2">
                            <a class="tex" target="_blank" href="/env/pollution2/pollutionInfohy?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea">
                                <p>海洋环境污染源</p>
                                <span id="hy">22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse2">
                            <span id="hypwk">持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse2">
                            <span id="rhpwk">持证矿山(45)</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <#-- ------右 数据表格------->
        <div class="real-data-info fr">
            <#-- ------边框线------->
            <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/border1.png" alt=""/></div>
            <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/border2.png" alt=""/></div>
            <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/border3.png" alt=""/></div>
            <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/border4.png" alt=""/></div>
            <#-- ------边框 ------->

            <div class="real-data-title">
                <span>市直实时更新</span>
            </div>
            <div class="home-air-panel" id="monitoringDetails">

                <div class="home-air-panel-body" id="deptRanking">
                    <div class="data-table-box" >
                        <div class="home-ranking-list">
                            <!-- 数据列表-->
                            <table id="deptTable" class="easyui-datagrid" url=""
                                   style="height:100%"
                                   data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
                                <thead>
                                <tr>
                                    <th align="center" field="rownum" width="100" formatter="numStyle">序号</th>
                                    <th align="center" field="dw" width="180">直属单位</th>
                                    <th align="center" field="count" width="100">个数</th>
                                    <th align="center" field="time" width="200">最后更新时间</th>
                                </tr>
                                </thead>
                            </table>
                            <!-- 数据列表 over-->
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>

            </div>
        </div>
    </div>
</div>

</body>
<script>

    function whichAnimationEvent(el){
        var t;
        var animations = {
            'animation':'animationend',
            'OAnimation':'oAnimationEnd',
            'MozAnimation':'animationend',
            'WebkitAnimation':'webkitAnimationEnd',
            'MsAnimation':'msAnimationEnd'
        }
        for(t in animations){
            if( el.style[t] !== undefined ){
                return animations[t];
            }
        }
    }

    $(function () {
        rankingQX();
        rankingDept();
        getTotal();
        // /*--------------------定时动画--------------------------*/
        // $("#monitoringDetails .ani").each(function(index){
        //     var $t=$(this);
        //     var el=$t.get(0);
        //     var animationEvent=whichAnimationEvent(el);
        //     animationEvent && el.addEventListener(animationEvent, function() {
        //         $t.removeClass("ani-extrusion");
        //     });
        //     setTimeout(function(){
        //         $t.addClass("ani-extrusion");
        //     },1000*index);
        //     var myVar=setInterval(function(){
        //         setTimeout(function(){
        //             $t.addClass("ani-extrusion");
        //         },1000*index);
        //     },4000);
        // });



    });

    setInterval(interval, 1000*60*10);

    function interval(){
        rankingQX();
        rankingDept();
        console.info(1)
    }

    function getTotal(){
        $.ajax({
            type: 'POST',
            url: '${request.contextPath}/env/pollution2/realtime/getwryzl',
            success: function (result) {
                var st = 0;
                var hy = 0;
                var s = 0;
                var dq = 0;
                var tr = 0;
                for(var i=0;i<result.length;i++) {
                    if (result[i].lx == '生态污染源'){
                        if (result[i].zl == '石板材行业'){
                            $('#sbchy').html(result[i].zl+"("+result[i].count+")")
                            st += result[i].count;
                        }
                        if (result[i].zl == '持证矿山'){
                            $('#czks').html(result[i].zl+"("+result[i].count+")")
                            st += result[i].count;
                        }
                    }
                    if (result[i].lx == '海洋污染源'){
                        if (result[i].zl == '海洋排污口'){
                            $('#hypwk').html(result[i].zl+"("+result[i].count+")")
                            hy += result[i].count;
                        }
                        if (result[i].zl == '涉海工业固废'){
                            $('#rhpwk').html(result[i].zl+"("+result[i].count+")")
                            hy += result[i].count;
                        }
                    }
                    if (result[i].lx == '水污染源'){
                        if (result[i].zl == '涉水工业企业'){
                            $('#ssgyqy').html(result[i].zl+"("+result[i].count+")")
                            s += result[i].count;
                        }
                    }
                    if (result[i].lx == '大气污染源'){
                        if (result[i].zl == '散乱污企业'){
                            $('#slwqy').html(result[i].zl+"("+result[i].count+")")
                            dq += result[i].count;
                        }
                        if (result[i].zl == '非道路移动源'){
                            $('#fdlydy').html(result[i].zl+"("+result[i].count+")")
                            dq += result[i].count;
                        }
                        if (result[i].zl == 'VOCs企业'){
                            $('#vocs').html(result[i].zl+"("+result[i].count+")")
                            dq += result[i].count;
                        }
                        if (result[i].zl == '高架源企业'){
                            $('#gjyqy').html(result[i].zl+"("+result[i].count+")")
                            dq += result[i].count;
                        }
                    }
                    if (result[i].lx == '土壤污染源'){
                        if (result[i].zl == '工业固废'){
                            $('#gygf').html(result[i].zl+"("+result[i].count+")")
                            tr += result[i].count;
                        }
                        if (result[i].zl == '工业危险废物'){
                            $('#gywxfw').html(result[i].zl+"("+result[i].count+")")
                            tr += result[i].count;
                        }
                        if (result[i].zl == '三格化粪池'){
                            $('#sghfc').html(result[i].zl+"("+result[i].count+")")
                            tr += result[i].count;
                        }
                    }
                }
                $('#hy').text(hy);
                $('#st').text(st);
                $('#s').text(s);
                $('#dq').text(dq);
                $('#tr').text(tr);
                $('#tj').html('<i><img src="${request.contextPath}/static/images/new-img/tips-icon.png" alt=""/></i> 截止'
                    +Ams.dateFormat(new Date())+'共排查各类污染源企业'+(hy+st+s+dq+tr)+'个')
            },
            dataType: 'json'
        });
    }

    function rankingQX(){
        $('#qxTable').datagrid({
            url: Ams.ctxPath+'/env/pollution2/realtime/getRealTimeUpdateByQX',
            onLoadSuccess:function(){
                loopScrollOdj("qxRanking",50,40);
            },
            onDblClickRow: function (rowIndex, rowData) {
               window.open("/env/pollution2/pollutionDepartment?qx="+encodeURIComponent(rowData.qx)+"&type=notdept")
            }
        });

    }

    function rankingDept(){
        $('#deptTable').datagrid({
            url: Ams.ctxPath+'/env/pollution2/realtime/getRealTimeUpdateByDept',
            onLoadSuccess:function(){
                loopScrollOdj("deptRanking",50,40);
            },
            onDblClickRow: function (index, row) {
                window.open("/env/pollution2/cityPollution?pid=8cc443b5-53d2-4db0-b2f7-f0901df961ea");
            }
        });

    }

    //序号文字样式
    function numStyle(value,row,index){
        return  '<span class="ranking">'+value+'</span>';
    }

    /*---简单循环滚动---*/
    function loopScroll($obj,offset,speed){
        setTimeout(function(){
            $obj.animate({scrollTop:offset},speed,'linear',function(){
                $obj.scrollTop(0);
            });
        },1000);

    }
    function loopScrollOdj(objname,speed,delay) {
        var obj,offset;
        delay=delay?delay:0;
        this.obj = obj = $("#"+objname+" .home-ranking-list .datagrid-body");
        this.objC = this.obj.children(".datagrid-btable");
        this.offset = offset = this.objC.height()-this.obj.height()+delay;
        this.speed = speed = speed*this.offset;
        this.lFunction = function(){
            loopScroll(this.obj,this.offset,this.speed);
        }
        this.lFunction();
        this.Scroll=self.setInterval(function(){
            loopScroll(obj,offset,speed)
        },this.speed);
        this.clearScroll=function(){
            clearInterval(this.Scroll);
        };
    }

</script>

</html>