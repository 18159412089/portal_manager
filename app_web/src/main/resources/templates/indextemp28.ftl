<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en" class="min-data">
<head>
    <title>环保督察-整改汇总表</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>

<body class="wrap-color" >
<#include "/decorators/header.ftl"/>
<div class="hzb-content-wrap">
    <div class="dc-info-box ">
        <p id="timeid">截至2019年10月22日</p>
        <div class="entry-list seven-box">
            <div class="entry-item" style="width: 25% !important;">
                <span>我市信访件问题</span>
                <p><i id="zyhb">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>阶段性结办</span>
                <p><i id="swqd">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>已结办</span>
                <p><i id="wdxs">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>已销号</span>
                <p><i id="ddxs">0</i> 个</p>
            </div>


        </div>
    </div>


    <form id="searchForm1">

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="车辆方向">关键字:</label>
            <span class="textbox" >
                <input id="_easyui_textbox_input1" type="text" class="textbox-text validatebox-text textbox-prompt" autocomplete="off" tabindex="" placeholder="请输入关键字" >
            </span>
        </div>
        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="车辆方向">受理编号:</label>
            <span class="textbox" >
                <input id="_easyui_textbox_input1" type="text" class="textbox-text validatebox-text textbox-prompt" autocomplete="off" tabindex="" placeholder="请输入受理编号" >
            </span>
        </div>
        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="车辆方向">牵头责任单位:</label>
            <span class="textbox" >
                <input id="_easyui_textbox_input1" type="text" class="textbox-text validatebox-text textbox-prompt" autocomplete="off" tabindex="" placeholder="请输入牵头责任单位" >
            </span>
        </div>


        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="污染类型">污染类型:</label>
            <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName" prompt="请选择污染类型" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">行政区：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="请选择行政区" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>


        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">结办状态：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">是否重点件：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">轮次：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">是否属实：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">是否重复件：</label>
            <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>


        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
           onclick="doSearch()">查询</a>
        <a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-arrow_refresh_small'"
           onclick="doReset()">重置</a>
        <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
           onclick="doReset()">导出EXCEL</a>

    </form>


      <div class="details-info-box" id="divTable">
        <ul class="tit-entry-box">
            <li class="alone-tag" > <span>全部</span></li>
            <li  class=""><span>阶段性结办</span><a class="radius-tag" id="overTal">10</a></li>
        </ul>


        <div class="details-text">
            <h5>受理编号：D2FJ201908120086
                <div class="operation-box  info-tag">详情 <i class="icon iconcustom icon-zhedie4"></i></div>
            </h5>
            <div class="part-font">
                <div class="item-row">
                    <span>基本情况</span>
                    <p> 石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下雨天道路泥泞影响村民通行</p>
                </div>
                <div class="item-row">
                    <span>核实情况</span>
                    <p>经核查，信访件反映的洗砂场实为漳州市芗城区黄英琪沙土场，该洗砂场生产废水循环使用，但进场主干道存在坑洼泥泞现象，部分堆场围挡、导流沟未完成建设，雨天可能造成沙土流失。洗砂场周边无农田，未闻到异味。</p>
                </div>

                <div class="item-row"><span>整改措施</span>
                    <p>
                        立即按要求排气扇开关上张贴警示条，警示不得随意开头 ，承诺今后在未发生特殊应急情况下绝不开启该消防排风扇。 芗城区将继续加大对该娱乐中心的监督检查，确保该娱乐中心的上述排风扇在非应急情况不得擅自开启。
                    </p>
                </div>

                <div class="item-row"><span> 处理情况</span>
                    <p>  1.芗城生态环境局责令该洗砂场加强对进场主干道路面的日常维护，同时加快导流沟、堆场围挡建设等工作进度。 2.相关部门加强跟踪督促，发现违法问题立即依法查处。</p>
                </div>

                <div class="item-row"><span> 最新整改情况</span>
                    <p>已完成成品区导流沟，围堰的建设，并对进出场主干道路面进行铺装硬化。</p>
                </div>
            </div>

            <div class="part-date alone-info" style="display: none">
                <div class="item">
                    <p> <span> 原始排序编码</span>YSBM03900</p>
                    <p> <span>行政区域</span>芗城区</p>
                </div>
                <div class="item">
                    <p> <span>污染类型</span> 大气</p>
                    <p> <span>是否属实</span> 部分属实</p>
                </div><div class="item">
                    <p> <span>责令整改（家次）</span> 1</p>
                    <p><span> 罚款金额（万元）</span> 0.2</p>
                </div>
                <div class="item">
                    <p><span>是否重点件</span>是</p>
                    <p>
                        <span>牵头责任单位</span>芗城生态环境局
                    </p>
                </div>
                <div class="item">
                    <p><span>联络人</span><span >王子杰</span> </p>
                    <p> <span>联系电话</span><span title="2022-12-31">15960682273</span></p>
                </div>


                <div class="item">
                    <p><span>所属网格</span>芗城区石亭镇</p>
                    <p>
                        <span>网格员</span>洪利民
                    </p>
                </div>
                <div class="item">
                    <p><span>网格员手机号码</span>13960081858</p>
                    <p><span>轮次</span>第一轮2017年</p>
                </div>
                <div class="item">
                    <p><span>更新时间</span>2019-09-29</p>
                    <p><span>轮次</span>第一轮2017年</p>
                </div>
                <div class="item">
                    <p><span>重复关联件编号</span>X2FJ201907280028</p>
                </div>
            </div>
            <div class="footer-font color-tag1"><span>已销号</span></div>
        </div>

          <div class="details-text">
              <h5>受理编号：D2FJ201908120086
                  <div class="operation-box  info-tag">详情 <i class="icon iconcustom icon-zhedie4"></i></div>
              </h5>
              <div class="part-font">
                  <div class="item-row">
                      <span>基本情况</span>
                      <p> 石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下雨天道路泥泞影响村民通行</p>
                  </div>
                  <div class="item-row">
                      <span>核实情况</span>
                      <p>经核查，信访件反映的洗砂场实为漳州市芗城区黄英琪沙土场，该洗砂场生产废水循环使用，但进场主干道存在坑洼泥泞现象，部分堆场围挡、导流沟未完成建设，雨天可能造成沙土流失。洗砂场周边无农田，未闻到异味。</p>
                  </div>

                  <div class="item-row"><span>整改措施</span>
                      <p>
                          立即按要求排气扇开关上张贴警示条，警示不得随意开头 ，承诺今后在未发生特殊应急情况下绝不开启该消防排风扇。 芗城区将继续加大对该娱乐中心的监督检查，确保该娱乐中心的上述排风扇在非应急情况不得擅自开启。
                      </p>
                  </div>

                  <div class="item-row"><span> 处理情况</span>
                      <p>  1.芗城生态环境局责令该洗砂场加强对进场主干道路面的日常维护，同时加快导流沟、堆场围挡建设等工作进度。 2.相关部门加强跟踪督促，发现违法问题立即依法查处。</p>
                  </div>

                  <div class="item-row"><span> 最新整改情况</span>
                      <p>已完成成品区导流沟，围堰的建设，并对进出场主干道路面进行铺装硬化。</p>
                  </div>
              </div>

              <div class="part-date alone-info" style="display: none">
                  <div class="item">
                      <p> <span> 原始排序编码</span>YSBM03900</p>
                      <p> <span>行政区域</span>芗城区</p>
                  </div>
                  <div class="item">
                      <p> <span>污染类型</span> 大气</p>
                      <p> <span>是否属实</span> 部分属实</p>
                  </div><div class="item">
                      <p> <span>责令整改（家次）</span> 1</p>
                      <p><span> 罚款金额（万元）</span> 0.2</p>
                  </div>
                  <div class="item">
                      <p><span>是否重点件</span>是</p>
                      <p>
                          <span>牵头责任单位</span>芗城生态环境局
                      </p>
                  </div>
                  <div class="item">
                      <p><span>联络人</span><span >王子杰</span> </p>
                      <p> <span>联系电话</span><span title="2022-12-31">15960682273</span></p>
                  </div>


                  <div class="item">
                      <p><span>所属网格</span>芗城区石亭镇</p>
                      <p>
                          <span>网格员</span>洪利民
                      </p>
                  </div>
                  <div class="item">
                      <p><span>网格员手机号码</span>13960081858</p>
                  </div>
                  <div class="item">
                      <p><span>更新时间</span>2019-09-29</p>
                      <p><span>轮次</span>第一轮2017年</p>
                  </div>
                  <div class="item">
                      <p><span>重复关联件编号</span>X2FJ201907280028</p>
                  </div>
              </div>
              <div class="footer-font color-tag1"><span>已销号</span></div>
          </div>


</div>
</div>
<#--分页容器-->
<div id="page-container" class="page-container">
    <div id="demo0"></div>
</div>

</body>
<script>
    /**
     * 分页栏
     */
    layui.use(['laypage', 'layer'], function(){
        var laypage = layui.laypage
            ,layer = layui.layer;
        //总页数低于页码总数
        laypage.render({
            elem: 'demo0'
            ,theme:'#45b97c'
            ,count: 50 //数据总数
        });
    })

    // * 阶段性结办切换

    $(".tit-entry-box li").click(function () {
        $(".tit-entry-box li").removeClass("alone-tag")
        $(this).addClass("alone-tag")
    })


    $(".info-tag").click(function () {
        var parentVal =$(this).parent().parent().find(".part-date");
        if (parentVal.hasClass("open")){
            parentVal.removeClass("open");
            parentVal.hide();
        }else {
            parentVal.addClass("open");
            parentVal.show();
        }


    })
</script>
</html>
