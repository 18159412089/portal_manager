<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en" class="min-data">
<head>
    <title>环保督察-整改汇总表</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>
<script src="${request.contextPath}/static/layui/layui.js"></script>

<#--<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>-->

<body class="wrap-color">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>
    <#include "/supervisionMenu.ftl">
<#else>
    <#include "/inputSupervisionMenu.ftl">
</#if>-->

<#include "/secondToolbar.ftl">
<input style="display: none;" id="authority" value="${authority!}">
<input style="display: none;" id="chartIndex" value="${chartIndex!}">
<input style="display: none;" id="chartIndex_first" value="0">

<div style="position:absolute;top:70px;left:0;right: 0;bottom: 0;">
    <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:100%;">
        <div title="整改汇总图表" style="display:none;">
            <iframe id="chartShow" src="/environment/rectifition/rectifitionListChart"
                    style="width:100%;height:100%;"></iframe>
        </div>
        <div title="整改汇总第 1 轮" style="overflow:auto;display:none;">
            <iframe id="rectifitionList" name="rectifitionList" style="width:100%;height:100%;"></iframe>
        </div>
        <div title="整改汇总第 2 轮" style="overflow:auto;display:none;">
            <iframe id="rectifitionList2" name="rectifitionList2" style="width:100%;height:100%;"></iframe>
        </div>
        <div title="华东督察整改进展汇总表" style="overflow:auto;display:none;">
            <iframe id="rectifitionList3" name="rectifitionList3" style="width:100%;height:100%;"></iframe>
        </div>
    </div>
</div>
<script>


    var authority = $("#authority").val();
    var pid = $("#pid").val();
    var srcStr = '';
    var srcStr2 = '';
    if (authority == '1') {
        srcStr = '/environment/rectifition?pid='+pid+'&authority=1&num=1';
        srcStr2 = '/environment/rectifition?pid='+pid+'&authority=1&num=2';
        srcStr3 = '/environment/rectifition/hd?pid='+pid+'&authority=1&num=100';
    } else {
        srcStr = '/environment/rectifition?pid='+pid+'&authority=2&num=1';
        srcStr2 = '/environment/rectifition?pid='+pid+'&authority=2&num=2';
        srcStr3 = '/environment/rectifition/hd?pid='+pid+'&authority=2&num=100';
    }
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    //解决样式加载不全问题
    $('#tt').tabs({
        border: false,
        onSelect: function (title) {
            if (title == "整改汇总第 1 轮") {
                $("#chartIndex").val(1)
                var frame = document.getElementById('rectifitionList');
                frame.src = srcStr;
            }
            if (title == "整改汇总第 2 轮") {
                $("#chartIndex").val(2)
                var frame = document.getElementById('rectifitionList2');
                frame.src = srcStr2;
            }
             if (title == "华东督察整改进展汇总表") {
                $("#chartIndex").val(100)
                var frame = document.getElementById('rectifitionList3');
                frame.src = srcStr3;
            }

            if (title == "整改汇总图表") {
                var frame = document.getElementById('chartShow');
                frame.src = "/environment/rectifition/rectifitionListChart";
                if ($("#chartIndex_first").val() == 0) {
                    $("#chartIndex_first").val(1);
                } else if($("#chartIndex").val()==1){
                    $("#chartIndex").val(1)
                }else if($("#chartIndex").val()==2){
                    $("#chartIndex").val(2)
                }else if($("#chartIndex").val()==100){
                    $("#chartIndex").val(100)
                }else {
                    $("#chartIndex").val(0)
                }
            }
        }
    });

    function enterEdit() {

        var strAuthority = '';
        if (authority == '1') {
            strAuthority = "&authority=2";
        } else {
            strAuthority = "&authority=1"
        }
        window.location.href = '/environment/rectifition/rectifitionListIntex?pid='+pid+'&chartIndex=' + $("#chartIndex").val() + strAuthority+'&num=' + $("#chartIndex").val();
    }

    $(function () {
        if ($("#chartIndex").val() == 0) {
            $("#tt").tabs("select", 0)
        } else if ($("#chartIndex").val() == 1) {
            $("#tt").tabs("select", 1)
        } else if ($("#chartIndex").val() == 2) {
            $("#tt").tabs("select", 2)
        }else if ($("#chartIndex").val() == 100) {
            $("#tt").tabs("select", 3)
        }

        $('.navbar').find('li').each(function() {
            if ($(this).find('a')[0].href.indexOf("rectifitionListIntex")!=-1){
                $(this).addClass("active");

            }
        })
    })
</script>
</body>
</html>
