<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<div id="map" class="easyui-dialog" title="地图取点"  style="width:900px;background:#ADADAD;height:600px;"
     data-options="closed:true,modal:true,border:'thin',
		buttons:[
    {text:'确定',handler:ok},
    {text:'取消',handler:function(){
		$('#map').dialog('close');
    	remove(point);
    }}
     
    ]">
    <div id="mapDiv" class="map-wrapper" style="width:900px;height:450px;"></div>
    <input type="text" id="searchPoint" value="" />
	<input type="button" value="搜索" onclick="search();" />
    经度<input type="text" id="lng" value="" disabled="disabled" style="background:#CCCCCC"/>
    纬度<input type="text" id="lat" value="" disabled="disabled" style="background:#CCCCCC"/>

</div>