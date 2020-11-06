<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en" class="min-data">
<head>
    <title>环保督察信访件-整改汇总表</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>

<body class="wrap-color">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<div class="hzb-content-wrap">
    <div class="dc-info-box ">
        <p id="timeid">截至2019年10月22日</p>
        <div class="entry-list seven-box">
            <div class="entry-item" style="width: 25% !important;">
                <span id="qx">我市信访件问题</span>
                <p><i id="sum">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>阶段性结办</span>
                <p><i id="jdxjb">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>已结办</span>
                <p><i id="yjb">0</i> 个</p>
            </div>
            <div class="entry-item" style="width: 25% !important;">
                <span>已销号</span>
                <p><i id="yxh">0</i> 个</p>
            </div>


        </div>
    </div>


    <form id="searchForm1">

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="关键字">关键字:</label>
            <span class="textbox">
                <input id="dcqjdchsqk" name="dcqjclqk" type="text" class="textbox-text validatebox-text textbox-prompt"
                       autocomplete="off" tabindex="" placeholder="请输入关键字">
            </span>
        </div>
        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="受理编号">受理编号:</label>
            <span class="textbox">
                <input  id="slbh" name="slbh" type="text" class="textbox-text validatebox-text textbox-prompt"
                        autocomplete="off" tabindex="" placeholder="请输入受理编号">
            </span>
        </div>
        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="牵头责任单位">牵头责任单位:</label>
            <span class="textbox">
                <input id="qtzrdw" name="qtzrdw" type="text" class="textbox-text validatebox-text textbox-prompt"
                       autocomplete="off" tabindex="" placeholder="请输入牵头责任单位">
            </span>
        </div>


        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="污染类型">污染类型:</label>
            <input class="easyui-combobox" name="wrlx" id="wrlx" prompt="请选择污染类型"
                   data-options="
                                        valueField:'id',
                                        textField:'name',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="行政区">行政区：</label>
            <input class="easyui-combobox" name="xzqy" value="${name!}" id="xzqy" prompt="请选择行政区"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=xzqy',
                                        valueField:'xzqy',
                                        textField:'xzqy',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>


        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="办结状态">办结状态：</label>
            <input class="easyui-combobox" name="bjzt" value="${state!}" id="bjzt" prompt="全部"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=bjzt',
                                        valueField:'bjzt',
                                        textField:'bjzt',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="是否重点件">是否重点件：</label>
            <input class="easyui-combobox" name="sfzdj" id="sfzdj" prompt="全部"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfzdj',
                                        valueField:'sfzdj',
                                        textField:'sfzdj',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="轮次">轮次：</label>
            <input class="easyui-combobox" name="lc" value="${lc!}" id="lc" prompt="全部"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=lc',
                                        valueField:'lc',
                                        textField:'lc',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="是否属实">是否属实：</label>
            <input class="easyui-combobox" name="sfss" id="sfss" prompt="全部"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfss',
                                        valueField:'sfss',
                                        textField:'sfss',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>

        <div class="inline-block mt20 mr6">
            <label class="textbox-label textbox-label-before" title="是否重复件">是否重复件：</label>
            <input class="easyui-combobox" name="sfcf" id="sfcf" prompt="全部"
                   data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfcf',
                                        valueField:'sfcf',
                                        textField:'sfcf',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                   style="width:200px;"/>
        </div>


        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
           onclick="doSearch1()">查询</a>
        <a class="easyui-linkbutton btn-red" data-options="iconCls:'icon-arrow_refresh_small'"
           onclick="doReset()">重置</a>
        <a class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newInfo()">新增</a>
        <a class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
           onclick="exportExl()">导出EXCEL</a>


    </form>


    <div class="details-info-box" id="divTable">

    </div>

</div>
<#--分页容器-->
<div id="page-container" class="page-container">
    <div id="demo0"></div>
</div>

<div id="dlg"  class="easyui-dialog" style="width:990px;height: 600px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <table class="table insp-table">
            <input  name="uuid" hidden="true"/>
            <tbody class="form-table">
            <tr>
                <td class="title tr">原始排序编码</td>
                <td class="con">
                    <input name="yspxbm" data-options="validType:'maxLength[64]'" id="yspxbm" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">受理编号</td>
                <td class="con">
                    <input name="slbh"   data-options="validType:'maxLength[64]'" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">交办问题基本情况</td>
                <td class="con">
                    <input name="jbwtjbqk" id="jbwtjbqk" data-options="validType:'maxLength[1000]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">行政区域</td>
                <td class="con">
                    <#-- <input name="xzqy" data-options="validType:'maxLength[64]'" class="easyui-textbox"
                            style="width:100%">-->
                    <input class="easyui-combobox" name="xzqy" value="${name!}"   prompt="请选择行政区"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=xzqy',
                                        valueField:'xzqy',
                                        textField:'xzqy',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td class="title tr">污染类型</td>
                <td class="con">
                    <#-- <input name="wrlx"  data-options="validType:'maxLength[64]'"
                            class="easyui-textbox"
                            style="width:100%">-->
                    <input class="easyui-combobox" id="wrlxEdit" name="wrlx"   prompt="请选择污染类型"
                           data-options="

                                        valueField:'id',
                                        textField:'name',
									method:'get',
									editable:false,
									multiple:true,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">督察期间调查核实情况</td>
                <td class="con">
                    <input name="dcqjdchsqk" data-options="validType:'maxLength[2550]'" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">是否属实</td>
                <td class="con">
                    <#-- <input name="sfss" data-options="validType:'maxLength[64]'" class="easyui-textbox"
                            style="width:100%">-->
                    <input class="easyui-combobox" name="sfss"   prompt="-"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfss',
                                        valueField:'sfss',
                                        textField:'sfss',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">整改目标及整改措施</td>
                <td class="con">
                    <input name="zgmbjzgcs" data-options="validType:'maxLength[4000]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">督察期间处理情况</td>
                <td class="con">
                    <input name="dcqjclqk" data-options="validType:'maxLength[4000]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">最新整改情况</td>
                <td class="con">
                    <input name="zxzgqk" data-options="validType:'maxLength[2000]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">办结状态</td>
                <td class="con">
                    <#--<input name="bjzt" data-options="validType:'maxLength[64]'"
                           class="easyui-textbox"
                           style="width:100%">-->
                    <input class="easyui-combobox" name="bjzt" value="${state!}"   prompt="-"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=bjzt',
                                        valueField:'bjzt',
                                        textField:'bjzt',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">责令整改（家次）</td>
                <td class="con">
                    <input name="zlzg"  data-options="validType:'maxLength[64]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">罚款金额（万元）</td>
                <td class="con">
                    <input name="fkje" data-options="validType:'maxLength[64]'"
                           class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">是否重点件</td>
                <td class="con">
                    <#--<input name="sfzdj" id="status" data-options="validType:'maxLength[4]'"
                           class="easyui-textbox"
                           style="width:100%">-->
                    <input class="easyui-combobox" name="sfzdj" id="sfzdj" prompt="-"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfzdj',
                                        valueField:'sfzdj',
                                        textField:'sfzdj',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td class="title tr">挂钩省市县领导情况</td>
                <td class="con">
                    <input name="ggssxldqk" class="easyui-textbox"
                           data-options="validType:'maxLength[500]'"
                           style="width:100%"></td>
                <td class="title tr">牵头责任单位</td>
                <td class="con">
                    <input name="qtzrdw" class="easyui-textbox"
                           data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">联络人</td>
                <td class="con">
                    <input name="llr" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%"></td>
                <td class="title tr">联系电话</td>
                <td class="con">
                    <input name="lxdh" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">所属网格</td>
                <td class="con">
                    <input name="shwg" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%"></td>
                <td class="title tr">网格员</td>
                <td class="con">
                    <input name="wgy" class="easyui-textbox" data-options="validType:'maxLength[64]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">网格员手机号码</td>
                <td class="con">
                    <input name="wgsjhm" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
                <td class="title tr">轮次</td>
                <td class="con">
                    <#--<input name="lc" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">-->
                    <input class="easyui-combobox" name="lc" value="${pointCode!}"   prompt="-"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=lc',
                                        valueField:'lc',
                                        textField:'lc',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
            </tr>

            <tr>
                <td class="title tr">是否重复件</td>
                <td class="con">
                    <#--  <input name="bz" class="easyui-textbox" data-options="validType:'maxLength[4]'"
                             style="width:100%">-->
                    <input class="easyui-combobox" name="sfcf"  prompt="-"
                           data-options="
									url:'${request.contextPath}/environment/letter/getTypeList?type=sfcf',
                                        valueField:'sfcf',
                                        textField:'sfcf',
									method:'get',
									editable:false,
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">重复关联件编号</td>
                <td class="con">
                    <input name="sfgljbh" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">验收情况</td>
                <td class="con">
                    <input name="ysqk" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
                <td class="title tr">合并编号</td>
                <td class="con">
                    <input name="hbbh" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">立案处罚（家次）</td>
                <td class="con">
                    <input name="lacf" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
                <td class="title tr">立案侦查（件次）</td>
                <td class="con">
                    <input name="lazc" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">刑事拘留（人次）</td>
                <td class="con">
                    <input name="xsjl" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
                <td class="title tr">行政拘留（人次）</td>
                <td class="con">
                    <input name="xzjl" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">约谈（人次）</td>
                <td class="con">
                    <input name="yt" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
                <td class="title tr">问责（人次）</td>
                <td class="con">
                    <input name="wz" class="easyui-textbox" data-options="validType:'maxLength[32]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">问责情况</td>
                <td class="con">
                    <input name="wzqk" class="easyui-textbox" data-options="validType:'maxLength[1000]'"
                           style="width:100%">
                </td>
                <td class="title tr">经度</td>
                <td class="con">
                    <input name="jd" class="easyui-textbox" data-options="validType:'maxLength[64]'"
                           prompt="例:117.89858366"    style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">纬度</td>
                <td class="con">
                    <input name="wd" class="easyui-textbox" data-options="validType:'maxLength[64]'"
                           prompt="例:24.3232333"      style="width:100%">
                </td>

                <td class="title tr"></td>
                <td class="con">

                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveInfo()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>


</body>
<script>
    /**
     * 分页栏
     */
    layui.use(['laypage', 'layer'], function () {
        var laypage = layui.laypage
            , layer = layui.layer;
        //总页数低于页码总数
        laypage.render({
            elem: 'demo0'
            , theme: '#45b97c'
            , count: 50 //数据总数
        });
    })
    var xzqyName;
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            if ("${name!}" == "漳州市") {
                xzqyName = "福建省漳州市";
            } else if ("${name!}" == '') {
                xzqyName = '';
            }else {
                xzqyName = "福建省漳州市" + "${name!}";
            }
            $("#xzqy").combobox('setValue',xzqyName);
            setWrlx();
            $(this).remove();
            doSearch1();
        });
    };
    function setWrlx(){
        var wrlxArr = new Array();
        wrlxArr.push({
            "id": '水',
            "name": '水'
        });
        wrlxArr.push({
            "id": '大气',
            "name": '大气'
        });
        wrlxArr.push({
            "id": '生态',
            "name": '生态'
        });
        wrlxArr.push({
            "id": '噪音',
            "name": '噪音'
        });
        wrlxArr.push({
            "id": '土壤',
            "name": '土壤'
        });
        wrlxArr.push({
            "id": '其他污染',
            "name": '其他污染'
        });
        $('#wrlx').combobox('loadData', wrlxArr);
        $('#wrlxEdit').combobox('loadData', wrlxArr);
    }
    // * 阶段性结办切换

    $(".tit-entry-box li").click(function () {
        $(".tit-entry-box li").removeClass("alone-tag")
        $(this).addClass("alone-tag")
    })

    /**
     * 导出excel
     */
    function exportExl(){
        window.location.href = "${request.contextPath}/environment/letter/allLetterlist?export=yes"+
            "&page="+ 1 +
            "&limit="+999999 +
            "&slbh="+$("#slbh").val() +
            "&qtzrdw="+$("#qtzrdw").val() +
            "&wrlx="+$("#wrlx").val() +
            "&xzqy="+$("#xzqy").val() +
            "&bjzt="+$("#bjzt").val() +
            "&sfzdj="+$("#sfzdj").val() +
            "&lc="+$("#lc").val() +
            "&sfss="+$("#sfss").val() +
            "&dcqjclqk="+$("#dcqjdchsqk").val() +
            "&sfcf="+$("#sfcf").val();
    }

    /**
     * 主界面拼接表格
     */
    function rowTable(data) {
        var text = "";
        var dataVal = '';
        divRowsCount = data.count;
        var color = "footer-font color-tag2";
        for (var i = 0; i < data.data.length; i++) {
            dataVal = data.data[i];
            if (Ams.formatNUll(dataVal.bjzt) == '已办结') {
                color = "footer-font";
            }else if (Ams.formatNUll(dataVal.bjzt)== '已销号'){
                color = "footer-font color-tag1";

            }
            text += " <div class=\"details-text\">";
            text += "            <h5>受理编号：" + Ams.formatNUll(dataVal.slbh);

            text += "            <div class='but-part'>"+opera(dataVal)+"</div>";
            text += "            </h5>";
            text += "            <div class=\"part-font\">";
            text += "                <div class=\"item-row\">";
            text += "                    <span>基本情况</span>";
            text += "                    <p> "+Ams.formatNUll(dataVal.jbwtjbqk)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item-row\">";
            text += "                    <span>核实情况</span>";
            text += "                    <p>";
            text += "                       "+Ams.formatNUll(dataVal.dcqjdchsqk)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item-row\"><span>整改措施</span>";
            text += "                    <p>";
            text +=    Ams.formatNUll(dataVal.zgmbjzgcs)                   ;
            text += "                    </p>";
            text += "                </div>";
            text += "";
            text += "                <div class=\"item-row\"><span> 处理情况</span>";
            text += "                    <p>  "+Ams.formatNUll(dataVal.dcqjclqk)+"</p>";
            text += "                </div>";
            text += "";
            text += "                <div class=\"item-row\"><span> 最新整改情况</span>";
            text += "                    <p> "+Ams.formatNUll(dataVal.zxzgqk)+"</p>";
            text += "                </div>";
            text += "            </div>";
            text += "";
            text += "            <div class=\"part-date alone-info\" style=\"display: none\">";
            text += "                <div class=\"item\">";
            text += "                    <p><span> 原始排序编码</span> "+Ams.formatNUll(dataVal.yspxbm)+"</p>";
            text += "                    <p><span>行政区域</span> "+Ams.formatNUll(dataVal.xzqy)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>污染类型</span>  "+Ams.formatNUll(dataVal.wrlx)+"</p>";
            text += "                    <p><span>是否属实</span>  "+Ams.formatNUll(dataVal.sfss)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>责令整改（家次）</span>  "+Ams.formatNUll(dataVal.zlzg)+"</p>";
            text += "                    <p><span> 罚款金额（万元）</span>  "+Ams.formatNUll(dataVal.fkje)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>是否重点件</span> "+Ams.formatNUll(dataVal.sfzdj)+"</p>";
            text += "                    <p>";
            text += "                        <span>牵头责任单位</span> "+Ams.formatNUll(dataVal.qtzrdw)+"";
            text += "                    </p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>联络人</span><span> "+Ams.formatNUll(dataVal.lrl)+"</span></p>";
            text += "                    <p><span>联系电话</span><span title=\"2022-12-31\"> "+Ams.formatNUll(dataVal.lxdh)+"</span></p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>所属网格</span> "+Ams.formatNUll(dataVal.sswl)+"</p>";
            text += "                    <p>";
            text += "                        <span>网格员</span> "+Ams.formatNUll(dataVal.wgy)+"";
            text += "                    </p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>网格员手机号码</span> "+Ams.formatNUll(dataVal.wgysjhm)+"</p>";
            text += "                    <p><span>轮次</span> "+Ams.formatNUll(dataVal.lc)+"</p>";
            text += "                </div>";
            text += "                <div class=\"item\">";
            text += "                    <p><span>更新时间</span>"+Ams.timeDateFormat(dataVal.updateDate)+"</p>";
            text += "                    <p><span>重复关联件编号</span> "+Ams.formatNUll(dataVal.sfgljbh)+"</p>";
            text += "                </div>";
            text += "            </div>";
            text += "            <div class=\""+color+"\"><span> "+Ams.formatNUll(dataVal.bjzt)+"</span></div>";
            text += "        </div>";

        }
        $("#divTable div").remove();
        $("#divTable").append(text);
        if (divRowsCount != divRowsCountSecond) {
            getLayTable(divRowsCount);
        }
    }


    $(".details-info-box").on("click",".info-tag",function () {
        var parentVal = $(this).parent().parent().parent().find(".part-date");
        if (parentVal.hasClass("open")) {
            parentVal.removeClass("open");
            parentVal.hide();
            $(this).find("i").removeClass("icon-zhedie2")
            $(this).find("i").addClass("icon-zhedie4")
        } else {
            parentVal.addClass("open");
            parentVal.show();
            $(this).find("i").removeClass("icon-zhedie4")
            $(this).find("i").addClass("icon-zhedie2")
        }
    })






    /**
     * 分页栏
     */
    function getLayTable(count){
        layui.use('laypage', function(){
            var laypage = layui.laypage;
            //执行一个laypage实例
            laypage.render({
                elem: 'page-container', //注意，这里的 test1 是 ID，不用加 # 号
                count: count,//数据总数，从服务端得到
                theme:'#45b97c',
                jump:function(object,first){
                    divpage=object.curr;
                    divRowsCountSecond=count;

                    if(!first){
                        window.location.href='#';
                        getDataShow('');

                    }

                }
            });
        });
    }

    /**
     * 重置按钮
     */
    function doReset() {
        // $("#searchForm1").form('clear');
        $("#slbh").val('');
        $("#qtzrdw").val('');
        $("#wrlx").combobox('clear');
        $("#xzqy").combobox('clear');
        $("#bjzt").combobox('clear');
        $("#sfzdj").combobox('clear');
        $("#lc").combobox('clear');
        $("#sfss").combobox('clear');
        $("#dcqjdchsqk").val('');//关键字
        $("#sfcf").combobox('clear');
        doSearch1();
    }

    /**
     * 查询所有
     */
    function doSearch1() {
        info();
        // getOverTal();
        getDataShow('');
    }

    /**
     * 统计
     */
    function info() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/letter/getCount',
            data: {
                lc:$("#lc").val()
            },
            success: function (result) {
                $('#timeid').text("截至" + Ams.dateFormat(new Date(), "yyyy年MM月dd日"));
                $('#sum').text(Ams.formatNullForZero(result.size));
                $('#qx').text((Ams.isNoEmpty(result.qx)==true?result.qx:'我市')+'信访件问题');
                $('#jdxjb').text(Ams.formatNullForZero(result["阶段性办结"]));
                $('#yjb').text(Ams.formatNullForZero(result["已办结"]));
                $('#yxh').text(Ams.formatNullForZero(result["已销号"]));

            },
            dataType: 'json'
        });
    }

    /**
     * 获取超时总条数
     */
    function getOverTal() {
        var url = Ams.ctxPath + '/environment/letter/allLetterlist';
        var param = {
            "page": 1,
            "limit": 99999,
            'bjzt': '阶段性办结'
        }
        $.ajax({
            type: 'POST',
            url: url,
            data: param,
            success: function (data) {
                $('#overTal').text(data.count);
            },
            dataType: 'json'
        });
    }
    var divpage=1;
    var divRowsCount=0;
    var divRowsCountSecond=0;
    /**
     * 全部跟整改时间延期
     */
    function getDataShow(flag) {
        var param;
        if ('1' == showAllFlag) {
            param = {
                "page": divpage,
                "limit": 10,
                "slbh": $("#slbh").val(),
                "qtzrdw": $("#qtzrdw").val(),
                "wrlx": $("#wrlx").val(),
                "xzqy": $("#xzqy").val(),
                "bjzt": $("#bjzt").val(),
                "sfzdj": $("#sfzdj").val(),
                "lc": $("#lc").val(),
                "sfss": $("#sfss").val(),
                "dcqjclqk": $("#dcqjdchsqk").val(),//关键字
                "sfcf": $("#sfcf").val(),
                export:flag
            }
        } else {
            param = {
                "page": divpage,
                "limit": 10,
                "slbh": $("#slbh").val(),
                "qtzrdw": $("#qtzrdw").val(),
                "wrlx": $("#wrlx").val(),
                "xzqy": $("#xzqy").val(),
                "bjzt": '阶段性办结',
                "sfzdj": $("#sfzdj").val(),
                "lc": $("#lc").val(),
                "sfss": $("#sfss").val(),
                "dcqjclqk": $("#dcqjdchsqk").val(),//关键字
                "sfcf": $("#sfcf").val(),
                export:flag
            }
        }
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/letter/allLetterlist',
            data: param,
            success: function (data) {
                console.log(data);
                rowTable(data);
            },
            dataType: 'json'
        });
    }
    /**
     *  全部跟超时按钮点击
     */
    var showAllFlag ='1';
    function getBtn(flag){
        if ('all' == flag) {
            showAllFlag = '1';
        }else {
            showAllFlag = '0';
        }
        doSearch1();
    }

    //===============================新增删除编辑
    //操作
    function opera(dataVal) {
        var rowData=JSON.stringify(dataVal);

        return " <a class='but' href='javascript:void(0)' onclick='editInfo("+ rowData+")'> 编辑</a> <a class='but red' href='javascript:void(0)' onclick=\"del('" + dataVal.uuid + "')\"> 删除</a> <div class=\"operation-box  info-tag\">详情 <i class=\"icon iconcustom icon-zhedie4\"></i></div>";
    }

    function saveInfo() {
        $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    $.messager.alert('错误提示', result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
                doSearch1();
                $.messager.progress('close');
            }
        });
    }

    /**
     * 新增
     * @type {string}
     */
    var url = '';

    function newInfo() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增信访件信息');
        url = Ams.ctxPath + '/environment/letter/save';
    }

    /**
     * 编辑
     * @type {string}
     */
    function editInfo(row) {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改信访件信息');
        $('#fm').form('load', row);
        url = Ams.ctxPath + '/environment/letter/save';
    }

    /**
     * 删除
     */
    function del(uuid) {
        $.messager.confirm("提示信息", "确认删除？", function (r) {
            if (r) {
                $.ajax({
                    type: 'POST',
                    url: Ams.ctxPath + '/environment/letter/delete',
                    data: {
                        'uuid': uuid
                    },
                    success: function (result) {
                        var result = eval(result);
                        if (result.type == 'E') {
                            layer.msg(result.message, {icon: 2});
                        } else {
                            doSearch1();
                            layer.msg(result.message, {icon: 1});
                        }
                    },
                    dataType: 'json'
                });
            }
        });

    }
</script>
</html>
