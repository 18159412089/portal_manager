<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>风险源信息</title>
</head>

<body>
	<#include "/common/loadingDiv.ftl"/>
     <div id="pf-bd">
        <!-- tab -->
        <div id="pf-sider">
        	<h2 class="pf-model-name">
		        <span class="iconfont">&#xe64a;</span>
		        <span class="pf-name">系统菜单</span>
		        <span class="toggle-icon"></span>
	        </h2>
            <!-- treegride -->
            <ul id="tg" class="easyui-tree" data-options="url:'${request.contextPath}/risk/mainPage/testData.do<#if type??>?type=${type!}</#if>'"></ul>
        </div>
        <!-- main -->
        <div id="pf-page">
            <div id="tabs" class="easyui-tabs1" border="false" style="height: 100%;">
            	<!-- 
                <div title="水环境"  style="overflow:hidden; color:red;">
                    <iframe  id="mapIframe" style="width:100%;height:100%;padding:10px;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;"
                             src="${request.contextPath}/map/ermMainMap/monitorMap"></iframe>
                </div>
            	-->
            </div>
        </div>
    </div>
    <!-- menu -->
	<div id="mm" class="easyui-menu" style="width:150px;">
	    <div id="mm-tabupdate">刷新</div>
	    <div class="menu-sep"></div>
	    <div id="mm-tabclose">关闭</div>
	    <div id="mm-tabcloseall">全部关闭</div>
	    <div id="mm-tabcloseother">除此之外全部关闭</div>
	    <div class="menu-sep"></div>
	    <div id="mm-tabcloseright">当前页右侧全部关闭</div>
	    <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
	</div>
	<script src='${request.contextPath}/static/js/main.js'></script>
<script>
    $('#tg').tree({
        onClick: function (node) {
        	if(undefined==node.url){
        		return;
        	}
        	if(node.url!='#'){
            	addTab(node.name, node.url, "icon-2012081511767");
        	}else{
        		addTab(node.name, "${request.contextPath}/todo", "icon-2012081511767");
        	}
        },
        onLoadSuccess: function (node, data) {
                if (data.length > 0) {
                    //找到第一个元素
                    var value = {};
                    var n = $('#tg').tree('find', data[0].children[0].id);
                    value = data[0];
                    //console.log(value.children);
                    while(true){
                        if(value.children == null){
                            $('#tg').tree('select', n.target);
                            addTab(n.name, "${request.contextPath}"+n.url, "icon-2012081511767");
                            break;
                        }
                        else if(value.children.length>0){
                            n = $('#tg').tree('find', value.children[0].id);
                            value = value.children[0]
                        }
                    }
                }
        }  
    });

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
</script>
</body>
</html>