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
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>
    <#include "/supervisionMenu.ftl">
<#else>
    <#include "/inputSupervisionMenu.ftl">
</#if>-->

<#include "/zphb/moudles/hbdc/hbdcToolbar.ftl">
<input style="display: none;" id="authority" value="${authority!}">
<input style="display: none;" id="chartIndex" value="${chartIndex!}">
<input style="display: none;" id="chartIndex_first" value="0">

<div style="position:absolute;top:70px;left:0;right: 0;bottom: 0;">
    <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:100%;">
        <#--<div title="整改汇总图表" style="display:none;">
            <iframe id="chartShow" src="/zphb/environment/rectifition/rectifitionListChart"
                    style="width:100%;height:100%;"></iframe>
        </div>-->
        <div title="整改汇总报表" style="overflow:auto;display:none;">
            <iframe id="rectifitionList" name="rectifitionList" style="width:100%;height:100%;"></iframe>
        </div>
    </div>
</div>
<script>


    var authority = $("#authority").val();
    var pid = $("#pid").val();
    var srcStr = '';
    if (authority == '1') {
        srcStr = '/zphb/environment/rectifition?pid='+pid+'&authority=1';
    } else {
        srcStr = '/zphb/environment/rectifition?pid='+pid+'&authority=2';
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
            if (title == "整改汇总报表") {
                $("#chartIndex").val(1)
                var frame = document.getElementById('rectifitionList');
                frame.src = srcStr;
            }
            if (title == "整改汇总图表") {
                var frame = document.getElementById('chartShow');
                frame.src = "/zphb/environment/rectifition/rectifitionListChart";
                if ($("#chartIndex_first").val() == 0) {
                    $("#chartIndex_first").val(1);
                } else {
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
        window.location.href = '/zphb/environment/rectifition/rectifitionListIntex?pid='+pid+'&chartIndex=' + $("#chartIndex").val() + strAuthority;
    }

    $(function () {
        if ($("#chartIndex").val() == 0) {
            $("#tt").tabs("select", 0)
        } else if ($("#chartIndex").val() == 1) {
            $("#tt").tabs("select", 1)
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
