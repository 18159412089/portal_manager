<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>公共代码</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div class="easyui-layout" fit=true>
    <div data-options="region: 'west',title:'资源目录',split: true" style="width:15%;height: 100%;">
        <div id="resourceDataTree" class="easyui-tree">
        </div>
    </div>
    <div id="resPageDiv" data-options="region: 'center',title:'资源目录服务',split: true" style="width:85%;height: 100%;">
        <iframe id="iframeContent" style="width: 100%;height: 100%;padding:10px;"></iframe>
    </div>
</div>
<!-- <div class="easyui-layout" fit=true>
    <div data-options="region: 'west',split: true" style="width:15%;height: 100%;">
        <div class="easyui-panel" title="资源目录" fit=true>
	        <div id="resourceDataTree" class="easyui-tree"></div>
	    </div>
        
    </div>
    <div id="resPageDiv" data-options="region: 'center',split: true" style="width:85%;height: 100%;">
    	<div class="easyui-panel" title="资源目录服务" fit=true>
    		<iframe id="iframeContent" style="width: 100%;height: 100%"></iframe>
    	</div>        
    </div>
</div> -->


<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }

    var resourceDataTree = null;
    resourceDataTree = $('#resourceDataTree').tree({
        url:'${request.contextPath}/env/resource/getMenuTree',
        animate: false,//是否显示动画效果
        lines: false,//是否显示树线条
        data: null,//要加载的节点数据
        onClick: function(node){
            if(node.url != "#"){
                $("#iframeContent").attr("src",node.url);
                $("#resPageDiv").panel('setTitle',node.name);
            }
        }
    });


</script>
</body>
</html>