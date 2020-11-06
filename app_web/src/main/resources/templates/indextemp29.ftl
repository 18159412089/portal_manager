<!DOCTYPE html>
<html lang="en"  class="real-body">
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
<body>
<div class="pollution-real-body ">
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
            <div class="home-air-panel" id="monitoringDetails">

                <div class="home-air-panel-body">
                    <div class="data-table-box ">
                        <div class="home-ranking-list">
                            <!-- 数据列表-->
                            <table id="monitoringDetailsTable" class="easyui-datagrid" url=""
                                   style="height:100%"
                                   data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
                                <thead>
                                <tr>
                                    <th align="center" field="type" width="100">序号</th>
                                    <th align="center" field="value" width="180">城区</th>
                                    <th align="center" field="AQI" width="100">个数</th>
                                    <th align="center" field="AQI2" width="200">最后更新时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>



                                </tbody>
                            </table>
                            <!-- 数据列表 over-->
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>

            </div>
            <#--          <!-- 数据列表&ndash;&gt;-->
            <#--          <table  class="easyui-datagrid" url=""-->
            <#--                 style="height:100%"-->
            <#--                 data-options="-->
            <#--							singleSelect:true,-->
            <#--							fit:true,-->
            <#--							fitColumns:true,-->
            <#--							pagination:false">-->
            <#--              <thead>-->
            <#--              <tr>-->
            <#--                  <th align="center" field="type" width="80">序号</th>-->
            <#--                  <th align="center" field="value" width="150">城区</th>-->
            <#--                  <th align="center" field="AQI" width="100">个数</th>-->
            <#--                  <th align="center" field="AQI2" width="120">最后更新时间</th>-->
            <#--              </tr>-->
            <#--              </thead>-->
            <#--              <tbody>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">2</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">3</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">4</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">5</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">6</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->

            <#--              </tbody>-->
            <#--          </table>-->
            <#--          <!-- 数据列表 over&ndash;&gt;-->
        </div>

        <#-- ------污染源种类------->
        <div class="real-data-center">
            <div class="real-data-title">
                <span>县级实时更新</span>
            </div>
            <div class="circular-data-box">

                <div class="circular-row ">
                    <div class="circular-item  fl">
                        <#--生态-->
                        <div class="entry-name entry-name1">
                            <a class="tex">
                                <p>生态环境污染源</p>
                                <span>22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse1">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse1">
                            <span>持证矿山(45)</span>
                        </div>
                    </div>

                    <div class="circular-item  fr">
                        <#--生态-->
                        <div class="entry-name entry-name2">
                            <a class="tex">
                                <p>生态环境污染源</p>
                                <span>22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse2">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse2">
                            <span>持证矿山(45)</span>
                        </div>
                    </div>
                </div>

                <div class="circular-row ">
                    <div class="circular-item" style="margin: 0 auto">

                        <div class="entry-name entry-name3">
                            <a class="tex">
                                <p>生态环境污染源</p>
                                <span>22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse3 alont-tag">
                            <span>持证矿山(45)</span>
                        </div>
                    </div>

                </div>

                <div class="circular-row ">
                    <div class="circular-item copies-two fl">

                        <div class="entry-name entry-name4">
                            <a class="tex">
                                <p>生态环境污染源</p>
                                <span>22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse4">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4 upward-left-tag">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse4 upward-right-tag">
                            <span>持证矿山(45)</span>
                        </div>
                    </div>

                    <div class="circular-item copies-two fr">

                        <div class="entry-name entry-name5">
                            <a class="tex">
                                <p>生态环境污染源</p>
                                <span>22</span>
                            </a>
                        </div>
                        <div class="ellipse-tag ellipse5">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse5">
                            <span>持证矿山(45)</span>
                        </div>
                        <div class="ellipse-tag ellipse5 upward-right-tag">
                            <span>持证矿山(45)</span>
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
                <span>县级实时更新</span>
            </div>
            <div class="home-air-panel" id="monitoringDetails">

                <div class="home-air-panel-body">
                    <div class="data-table-box" >
                        <div class="home-ranking-list">
                            <!-- 数据列表-->
                            <table id="monitoringDetailsTable" class="easyui-datagrid" url=""
                                   style="height:100%"
                                   data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
                                <thead>
                                <tr>
                                    <th align="center" field="type" width="100">序号</th>
                                    <th align="center" field="value" width="180">城区</th>
                                    <th align="center" field="AQI" width="100">个数</th>
                                    <th align="center" field="AQI2" width="200">最后更新时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td><span>1</span></td>
                                    <td>南靖靖城桥</td>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>



                                </tbody>
                            </table>
                            <!-- 数据列表 over-->
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>

            </div>
            <#--          <!-- 数据列表&ndash;&gt;-->
            <#--          <table  class="easyui-datagrid" url=""-->
            <#--                 style="height:100%"-->
            <#--                 data-options="-->
            <#--							singleSelect:true,-->
            <#--							fit:true,-->
            <#--							fitColumns:true,-->
            <#--							pagination:false">-->
            <#--              <thead>-->
            <#--              <tr>-->
            <#--                  <th align="center" field="type" width="80">序号</th>-->
            <#--                  <th align="center" field="value" width="150">城区</th>-->
            <#--                  <th align="center" field="AQI" width="100">个数</th>-->
            <#--                  <th align="center" field="AQI2" width="120">最后更新时间</th>-->
            <#--              </tr>-->
            <#--              </thead>-->
            <#--              <tbody>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">1</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">2</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">3</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">4</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">5</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">6</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->
            <#--              <tr>-->
            <#--                  <td><span class="ranking">7</span></td>-->
            <#--                  <td>南靖靖城桥</td>-->
            <#--                  <td>5</td>-->
            <#--                  <td>5</td>-->
            <#--              </tr>-->

            <#--              </tbody>-->
            <#--          </table>-->
            <#--          <!-- 数据列表 over&ndash;&gt;-->
        </div>
    </div>
</div>
</body>
<script>

    /*---简单循环滚动---*/
    function loopScroll($obj,offset,speed){
        $obj.animate({scrollTop:offset},speed,'linear',function(){
            $obj.scrollTop(0);
        });
    }
    function loopScrollOdj(objname,speed,delay) {
        var obj,offset;
        delay=delay?delay:0;
        this.obj = obj = $("#"+objname+" .home-ranking-list .datagrid-body");
        this.objC = this.obj.children(".datagrid-btable");
        this.offset = offset = this.objC.height()-this.obj.height()+delay;
        /* this.speed = speed = speed*$("#"+objname+"Table").datagrid("getData").total; */
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

        /*简单循环滚动-开始*/
        var loopScrollOdj2 = new loopScrollOdj("monitoringDetails",50,40);


        /*--------------------定时动画--------------------------*/
        $("#monitoringDetails .ani").each(function(index){
            var $t=$(this);
            var el=$t.get(0);
            var animationEvent=whichAnimationEvent(el);
            animationEvent && el.addEventListener(animationEvent, function() {
                $t.removeClass("ani-extrusion");
            });
            setTimeout(function(){
                $t.addClass("ani-extrusion");
            },1000*index);
            var myVar=setInterval(function(){
                setTimeout(function(){
                    $t.addClass("ani-extrusion");
                },1000*index);
            },4000);
        });



    });
    $(".real-data-title").on("click",function () {
        alert("点击了")
    })

</script>

</html>