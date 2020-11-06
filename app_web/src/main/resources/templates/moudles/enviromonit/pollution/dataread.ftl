<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>数据调阅</title>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
	<div id="pf-bd">
        <!-- tab -->
        <div id="pf-sider">
        	<input class="easyui-searchbox" data-options="searcher:searchTree,prompt:'搜索企业'" id="searchText" style="width: 220px; height: 32px;"></input>
	        <!-- treegride -->
	        <ul id="tg" class="easyui-tree" data-options="url:'${request.contextPath}/env/pollution/point/pointTree'"></ul>
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
	<script src='${request.contextPath}/static/js/main.js'></script>
<script>
	$.parser.onComplete = function() {
		$("#loadingDiv").fadeOut("normal", function() {
			$(this).remove();
		});
	};
	
	$('#tg').tree({
        onClick: function (node) {
        	if(node.children == null) {
            	addTab(node.name, "${request.contextPath}/env/pollution/factor/getColumn?uuid="+node.id, "icon-2012081511767");
        	}
        }
    });
	
	function expandParent(node){
		var parent = node;
		var t = true;
		do {
			parent = $('#tg').tree('getParent',parent.target);
			if(parent){
				t=true;
				$('#tg').tree('expand', parent.target);
			}else{
				t=false;
			}
		}while (t);
	}
	
	function selectNode(node){
		$('#tg').tree('select', node.target);
	}
	
	//树查询
	function searchTree(){
		 var parentNode=$('#tg').tree('getRoots');
		 var searchCon = $("#searchText").val();
		 var children; 
	     for(var i=0;i<parentNode.length;i++){
	         children = $('#tg').tree('getChildren',parentNode[i].target);
	         if(children){
	             for(var j=0;j<children.length;j++){
	            	 if(children[j].text.indexOf(searchCon)>=0||children[j].id.indexOf(searchCon)>=0){
	            		 selectNode(children[j]);
	            		 expandParent(children[j]);
	            	}
	             }
	         }else{ 
	             if(parentNode[i].text.indexOf(searchCon)||children[j].id.indexOf(searchCon)>=0>=0){ 
	                 selectNode(parentNode[i]); 
	                 expandParent(parentNode[i]); 
	                 return; 
	             } 
	         } 
	     }
	}
</script>
</body>
</html>