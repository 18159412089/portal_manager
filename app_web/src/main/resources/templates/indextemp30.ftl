<!DOCTYPE html>
<html lang="en"  class="real-body">
<head>
    <title>污染源实时动态数据222</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudData.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
</head>
<style>
    .window{border-width: 3px;border-radius: 5px;}
    .window, .window .window-body {border-color: #3aa1d9;}
     .panel.window.panel-htop .panel-header{border-color: #328bc1;background: #1e609e;}
     .window, .window .window-body{border-color: #3aa1d9;}
     .window .panel-body {background-color: #1e609e !important;}
     .window-shadow{background: #1e609e;-webkit-box-shadow: -1px 0px 1px 0px #1e609e; }
     .tabs li{border-color: #3aa1d9;}
     .tabs-title{color: white}
     .tabs-header, .tabs-tool{background-color: #3aa1d9;}
     .tabs li a.tabs-inner{ border-color: #3aa1d9;}
     .tabs li.tabs-selected{border-top-color: #3aa1d9;}
     .tabs li.tabs-selected a.tabs-inner{ background: #1e65a3;border-top-color: #00a65a;background-color: #1e65a3;}
     .datagrid .datagrid-pager.pagination .pagination-info{display: none}
     .alone-pollution .window-proxy-mask, .window-mask{    background: rgba(0,0,0,0.1); }
     .datagrid-htable, .home-ranking-list .datagrid-btable, .home-ranking-list .datagrid-ftable{color: #d4dbe5;}
    .easyui-dialog .textbox-label{color: white !important;}
     .inline-radio-box{
        color: white;
    }
</style>
<!-- body -->
<body>
<div class="pollution-real-body info-real-body ">
    <#--    头部---->
    <div class="home-real-head">
        <div class="real-head-left">
            <span> <i><img src="${request.contextPath}/static/images/new-img/tips-icon.png" alt=""/></i> 截止2019年10月30日共排查各类污染源企业3463个</span>
        </div>
        <div class="real-head-title">
            <span>污染源实时动态数据</span>
        </div>
        <div class="real-head-right">
            <a class="real-but">进入</a>
        </div>
    </div>
    <#--内容-->
    <div class="info-real-content">
     <#--类型-->
        <div class="entry-type-list">
           <div class="entry-type-item">
               <span class="name">污染源企业</span>
               <p> <span>5935</span> 个</p>

               <#-- ------边框线------->
               <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
               <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
               <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
               <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
               <#-- ------边框 ------->
           </div>

            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p> <span>5935</span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
                <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p> <span>5935</span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
                <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p> <span>5935</span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
                <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p> <span>5935</span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
                <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>

            <div class="entry-type-item">
                <span class="name">污染源企业</span>
                <p> <span>5935</span> 个</p>
                <#-- ------边框线------->
                <div class="left-top-border"><img src="${request.contextPath}/static/images/new-img/left-top.png" alt=""/></div>
                <div class="right-top-border"><img src="${request.contextPath}/static/images/new-img/right-top.png" alt=""/></div>
                <div class="left-bottom-border"><img src="${request.contextPath}/static/images/new-img/left-bottom.png" alt=""/></div>
                <div class="right-bottom-border"><img src="${request.contextPath}/static/images/new-img/right-bottom.png" alt=""/></div>
                <#-- ------边框 ------->
            </div>
        </div>

        <form id="searchForm1" style="margin: 20px 0">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="行政区">行政区:</label>
                <input class="easyui-combobox" name="regionName"  prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="污染源类型">污染源类型：</label>
                <input class="easyui-combobox" name="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="污染源类型">污染源种类：</label>
                <input class="easyui-combobox" name="pointName"   prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="企业">企业：</label>
                <input class="easyui-textbox" name="pointName"  prompt="全部"
                       style="width:200px;"/>
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-arrow_refresh_small'"
               onclick="doReset()">重置</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'"  >导出excel</a>
        </form>

       <div class="table-head">
           <span>属地责任</span>
           <span>属地责任</span>
       </div>
        <div class="data-table-box">
            <div class="home-ranking-list">
                <!-- 数据列表-->
                <table id="monitoringDetailsTable" class="easyui-datagrid" url=""
                       style="height:100%"
                       data-options="
							  rownumbers:false,
							            singleSelect:false,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                    <thead>
                    <tr>
                        <th align="center" field="type" width="10%">种类</th>
                        <th align="center" field="value" width="12%">企业名称</th>
                        <th align="center" field="AQI" width="10%">责任单位</th>
                        <th align="center" field="AQI2" width="15%">责任人及联系方式</th>
                        <th align="center" field="type1" width="10%">配合责任单位</th>
                        <th align="center" field="value2" width="13%">负责人及联系方式</th>
                        <th align="center" field="AQI3" width="10%">配合责任单位</th>
                        <th align="center" field="AQI4" width="12%">负责人及联系方式</th>
                        <th align="center" field="type5" width="10%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    <tr>
                        <td><span>涉VOCs行业 </span></td>
                        <td><span>漳州豪鑫成日用品有限公司</span></td>
                        <td><span>南坑街道</span></td>
                        <td><span>韩纯武15006087686</span></td>
                        <td><span>芗城生态环境局 </span></td>
                        <td><span>方亮，李佳文，2920172</span></td>
                        <td><span>区市场监管局</span></td>
                        <td><span>郭本水  陈伟斌 13489606606</span></td>
                        <td> <a class="see-tag">查看</a></td>
                    </tr>
                    </tbody>
                </table>
                <!-- 数据列表 over-->
            </div>
        </div>



    </div>


    <div id="infoDlg" class="easyui-dialog" style="width:900px;height:610px;background:white;"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
        <div class="panel-group-container real-panel-group" style="padding: 0">
            <div id="tt" class="easyui-tabs" style="width:898px;height:552px;">
                <div title="详情" >
                    <div class="panel-group-container" >
                        <div class="panel-group-top"><span id="">南靖上洋</span>
                            <span class="fr" id="">
                                  <span  class="name-tag">纬度：</span>
                                  <span  class="font-tag" id="wd">4646</span>

                                  <span  class="name-tag">经度：</span>
                                 <span  class="font-tag" id="jd">11111</span>
                    </span>
                        </div>
                        <div class="panel-group-body">
                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>企业详情</span>
                                    <a class="fr link-tag">查看一企一档</a>
                                </div>
                                <div class="row-item">
                                    <div class="col-xs-6  copies" >
                                        <span  class="name-tag">污染源类型：</span>
                                        <span  class="font-tag" id="wrylx">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                    <div class="col-xs-6 copies" >
                                        <span  class="name-tag">污染源类型：</span>
                                        <span  class="font-tag" id="wryzl">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                </div>

                                <div class="row-item">
                                    <div class="col-xs-6  copies " >
                                        <span  class="name-tag">区县：</span>
                                        <span  class="font-tag" id="qx">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                    <div class="col-xs-6 copies" >
                                        <span  class="name-tag">乡镇：</span>
                                        <span  class="font-tag" id="xz">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                </div>

                                <div class="row-item">
                                    <div class="col-xs-6  copies " >
                                        <span  class="name-tag">地址：</span>
                                        <span  class="font-tag" id="dz">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                </div>

                                <div class="row-item">
                                    <div class="col-xs-6  copies " >
                                        <span  class="name-tag">经度：</span>
                                        <span  class="font-tag" id="jd">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                    <div class="col-xs-6 copies" >
                                        <span  class="name-tag">纬度：</span>
                                        <span  class="font-tag" id="wd">大气交付伙食费水立方空间是开发商</span>
                                    </div>
                                </div>
                            </div>

                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>企业详情</span>
                                </div>
                                <div class="existence-bug-box">
                                    <i class="icon iconcustom icon-fengxian4"></i> <span>存在问题：未办理环评手续</span>
                                </div>
                                <div class="row">
                                    <span class="col-xs-12">存在问题：未办理环评手续</span>
                                </div>
                                <div class="row">
                                    <span  class="col-xs-12">整改措施：明确分类处置措施并完成整治。</span>
                                </div>
                                <div class="row">
                                    <span  class="col-xs-12">治理项目：“散乱污”工业企业污染专项整治</span>
                                </div>

                                <!--面板主内容-->
                                <div class="speed-info-title">完成目标</div>
                                <div class="speed-info-part">
                                    <div class="time-axis-container">
                                        <ul>
                                            <li class="item highlight">
                                                <div href="" class="time-axis-box">
                                                    <div class="step">
                                                        <span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>
                                                        <span class="button-tag fr" >已完成</span>
                                                    </div>
                                                    <div class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                        自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                                </div>
                                            </li>
                                            <li class="item highlight">
                                                <div href="" class="time-axis-box">
                                                    <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>
                                                        <span class="button-tag fr red" >未完成</span>
                                                    </div>
                                                    <div class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                        自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!--面板主内容 over-->

                            </div>

                            <div class="sewage-info-table">


                            </div>

                            <div class="panel-tex-part">
                                <div class="panel-tex-head">
                                    <span>企业详情</span>
                                </div>
                                <div class="row-item">
                                    <div class="col-xs-4  copies" >
                                        <span  class="name-tag">属地责任单位：</span>
                                        <span  class="font-tag" id="wrylx">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">责任人：</span>
                                        <span  class="font-tag" id="wryzl">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">联系方式：</span>
                                        <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                    </div>
                                </div>

                                <div class="row-item">
                                    <div class="col-xs-4  copies" >
                                        <span  class="name-tag">属地责任单位：</span>
                                        <span  class="font-tag" id="wrylx">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">责任人：</span>
                                        <span  class="font-tag" id="wryzl">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">联系方式：</span>
                                        <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                    </div>
                                </div>
                                <div class="row-item">
                                    <div class="col-xs-4  copies" >
                                        <span  class="name-tag">属地责任单位：</span>
                                        <span  class="font-tag" id="wrylx">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">责任人：</span>
                                        <span  class="font-tag" id="wryzl">龙山镇</span>
                                    </div>
                                    <div class="col-xs-4 copies" >
                                        <span  class="name-tag">联系方式：</span>
                                        <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#--            <div title="Tab2" >tab2</div>-->
                    <#--            <div title="Tab3" >-->
                    <#--                tab3-->
                    <#--            </div>-->
                </div>
                <div title="整改时间轴" >
                    <div class="panel-group-container" >
                        <div class="speed-info-title">治理项目 “散乱污”</div>
                        <div class="speed-info-part"  style="padding: 15px;">
                            <div class="time-axis-container">
                                <ul>
                                    <li class="item highlight">
                                        <div class="time-axis-part">
                                            <div class="time-axis-head">
                                                <span>上传时间：2019年9月20日16时10分</span>
                                                <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                                <a class="fr common-upload-tag" >
                                                    <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                            </div>
                                            <div class="time-axis-content">
                                                <div class="img-box">

                                                </div>
                                            </div>
                                            <p>描述：</p>
                                            <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                        </div>
                                    </li>
                                    <li class="item highlight">
                                        <div class="time-axis-part">
                                            <div class="time-axis-head">
                                                <span>上传时间：2019年9月20日16时10分</span>
                                                <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                                <a class="fr common-upload-tag" >
                                                    <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                            </div>
                                            <div class="time-axis-content">
                                                <div class="img-box">

                                                </div>
                                            </div>
                                            <p>描述：</p>
                                            <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- dialog4 -->
    <div id="infoDlg4" class="easyui-dialog" style="width:900px;height:610px;background:white;"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
        <div id="tt" class="easyui-tabs" style="width:898px;height:550px;">
            <div title="废气监测" >
                <#-- 自动监控小时-->
                <div id="tt2" class="easyui-tabs" style="width:898px;">

                    <div title="自动监控小时" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="" class="searchBar">
                                <form id="searchForm1">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">排口名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">污染物：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>

                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期"> &nbsp;&nbsp;监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>

                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar="#"
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                        <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                        <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                        <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                        <th data-options="field:'code5'" width="14.3%">检测值</th>
                                        <th data-options="field:'code6'" width="14.3%">单位</th>
                                        <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 监督性监测-->
                    <div title="监督性监测" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="" class="searchBar">
                                <form id="searchForm1">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>


                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'">查询</a>
                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:400px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                        <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                        <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                        <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                        <th data-options="field:'code5'" width="14.3%">检测值</th>
                                        <th data-options="field:'code6'" width="14.3%">单位</th>
                                        <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 自行监测-->
                    <div title="自行监测" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="" class="searchBar">
                                <form id="searchForm1">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto; vertical-align: middle" title="监测类型">监测类型：</label>
                                        <div class="inline-radio-box">
                                            <input  type="radio"> <label>自行监测</label>   <input  type="radio"> <label>手工监测</label>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">&nbsp;&nbsp;&nbsp;项目名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>
                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="10%">监测日期</th>
                                        <th data-options="field:'code1'" width="10%">监测状态</th>
                                        <th data-options="field:'code2'" width="10%">监测日期</th>
                                        <th data-options="field:'code3'" width="10%">项目名称</th>
                                        <th data-options="field:'code4'" width="10%">是否停产</th>
                                        <th data-options="field:'code5'" width="10%">监测值</th>
                                        <th data-options="field:'code6'" width="10%">限值</th>
                                        <th data-options="field:'code7'" width="10%">是否达标</th>
                                        <th data-options="field:'code7'" width="10%">超标倍数</th>
                                        <th data-options="field:'code7'" width="10%">备注</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 自动监控日-->
                    <div title="自动监控日" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="searchBar1" class="searchBar">
                                <form >
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="排口名称">排口名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="污染物">污染物：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                      >查询</a>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期：</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>

                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar="#"
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="16.7%">排口名称</th>
                                        <th data-options="field:'code2'" width="16.7%">监测时间</th>
                                        <th data-options="field:'code3'" width="16.7%">污染物</th>
                                        <th data-options="field:'code4'" width="16.7%">监测值</th>
                                        <th data-options="field:'code5'" width="16.7%">标准值</th>
                                        <th data-options="field:'code6'" width="16.7%">是否超标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div title="废水监测" >
                <div id="tt2" class="easyui-tabs " style="width:898px;">

                    <div title="自动监控小时" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="searchBar1" class="searchBar">
                                <form id="">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">排口名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">污染物：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>

                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期"> &nbsp;&nbsp;监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>

                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                        <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                        <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                        <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                        <th data-options="field:'code5'" width="14.3%">检测值</th>
                                        <th data-options="field:'code6'" width="14.3%">单位</th>
                                        <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 监督性监测-->
                    <div title="监督性监测" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div  class="searchBar">
                                <form id="searchForm1">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>


                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>
                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:400px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                        <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                        <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                        <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                        <th data-options="field:'code5'" width="14.3%">检测值</th>
                                        <th data-options="field:'code6'" width="14.3%">单位</th>
                                        <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 自行监测-->
                    <div title="自行监测" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="" class="searchBar">
                                <form id="searchForm1">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto; vertical-align: middle" title="监测类型">监测类型：</label>
                                        <div class="inline-radio-box">
                                            <input  type="radio"> <label>自行监测</label>   <input  type="radio"> <label>手工监测</label>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">&nbsp;&nbsp;&nbsp;项目名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>
                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="10%">监测日期</th>
                                        <th data-options="field:'code1'" width="10%">监测状态</th>
                                        <th data-options="field:'code2'" width="10%">监测日期</th>
                                        <th data-options="field:'code3'" width="10%">项目名称</th>
                                        <th data-options="field:'code4'" width="10%">是否停产</th>
                                        <th data-options="field:'code5'" width="10%">监测值</th>
                                        <th data-options="field:'code6'" width="10%">限值</th>
                                        <th data-options="field:'code7'" width="10%">是否达标</th>
                                        <th data-options="field:'code7'" width="10%">超标倍数</th>
                                        <th data-options="field:'code7'" width="10%">备注</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <#-- 自动监控日-->
                    <div title="自动监控日" >
                        <div class="panel-group-container" style="padding:10px 10px 0 10px">
                            <div id="" class="searchBar">
                                <form id="">
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="排口名称">排口名称：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto" title="污染物">污染物：</label>
                                        <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                               style="width:100px;"/>
                                    </div>
                                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                      >查询</a>
                                    <div class="inline-block">
                                        <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期：</label>
                                        <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                    </div>

                                </form>
                            </div>
                        </div>
                        <div class="panel-group-container">
                            <div class="easyui-table-light">
                                <table  class="easyui-datagrid"
                                        style="width: 100%;height:370px;" toolbar=""
                                        url=""
                                        data-options="
							            rownumbers:false,
							            singleSelect:true,
							            striped:false,
							            autoRowHeight:false,
							            pagination:true,
							            pageSize:10,
							            nowrap:false">
                                    <thead>
                                    <tr>
                                        <th data-options="field:'code1'" width="16.7%">排口名称</th>
                                        <th data-options="field:'code2'" width="16.7%">监测时间</th>
                                        <th data-options="field:'code3'" width="16.7%">污染物</th>
                                        <th data-options="field:'code4'" width="16.7%">监测值</th>
                                        <th data-options="field:'code5'" width="16.7%">标准值</th>
                                        <th data-options="field:'code6'" width="16.7%">是否超标</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
<!-- dialog1 -->

</body>


<script>
    $(document).ready(function(){

       $(".see-tag").on("click",function () {
           $("#infoDlg").dialog('open').dialog('center').dialog('setTitle', '详情');
       })

        $(".link-tag").on("click",function () {
            $("#infoDlg4").dialog('open').dialog('center').dialog('setTitle', '详情');


        })

    })

</script>
</html>