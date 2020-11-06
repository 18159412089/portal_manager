<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#setting number_format="computer">

<#macro deptCommotree name id="" required="false" label="" labelPosition="left" panelHeight="200" panelMaxHeight="" panelMinHeight="" multiple="false" editable="true" style="width:100%" pid="" cascadeCheck="true" enable="1" onChange="">
<#assign editableparam><#if multiple=="true">false<#else>${editable}</#if></#assign>
<#assign dataoptions><#if cascadeCheck!="">cascadeCheck:${cascadeCheck},</#if><#if onChange!="">onChange:${onChange},</#if>url:'${request.contextPath}/sys/dept/getDeptTree?<#if enable=="1">enable=1<#else>enable=2</#if><#if pid!="">&id=${pid}</#if>',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if multiple!=''>,multiple:${multiple}</#if><#if editable!=''>,editable:${editableparam}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" class="easyui-combotree" data-options="${dataoptions}" style="${style}">
</#macro>

<#macro deptSynCommotree name id="" required="false" label="" labelPosition="left" panelHeight="200" panelMaxHeight="" panelMinHeight="" multiple="false" editable="true" style="width:100%" pid="" cascadeCheck="true" enable="1" onChange="">
    <#assign editableparam><#if multiple=="true">false<#else>${editable}</#if></#assign>
    <#assign dataoptions><#if cascadeCheck!="">cascadeCheck:${cascadeCheck},</#if><#if onChange!="">onChange:${onChange},</#if>url:'${request.contextPath}/sys/dept/getSynDeptTree?<#if enable=="1">enable=1<#else>enable=2</#if><#if pid!="">&id=${pid}</#if>',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if multiple!=''>,multiple:${multiple}</#if><#if editable!=''>,editable:${editableparam}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if></#assign>
    <input <#if id!="">id="${id}"</#if> name="${name}" class="easyui-combotree" data-options="${dataoptions}" style="${style}">
</#macro>

<#macro CommonCodetree name id="" required="false" label="" labelPosition="left" panelHeight="200" panelMaxHeight="" panelMinHeight="" multiple="false" editable="true" style="width:100%" pid="" cascadeCheck="true" enable="1" onChange="">
    <#assign editableparam><#if multiple=="true">false<#else>${editable}</#if></#assign>
    <#assign dataoptions><#if cascadeCheck!="">cascadeCheck:${cascadeCheck},</#if><#if onChange!="">onChange:${onChange},</#if>url:'${request.contextPath}/enviromonit/commonCode/getAllTree',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if multiple!=''>,multiple:${multiple}</#if><#if editable!=''>,editable:${editableparam}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if></#assign>
    <input <#if id!="">id="${id}"</#if> name="${name}" class="easyui-combotree" data-options="${dataoptions}" style="${style}">
</#macro>

<#macro userCommotree name id="" required="false" label="" labelPosition="left" panelHeight="200" panelMaxHeight="" panelMinHeight="" multiple="false" editable="true" style="width:100%" pid="" cascadeCheck="true" enable="1" onChange="">
<#assign editableparam><#if multiple=="true">false<#else>${editable}</#if></#assign>
<#assign multipleparam><#if multiple=="true">function(node){if (node.type == 'u'){return true;}}<#else>${multiple}</#if></#assign>
<#assign onBeforeSelectparam><#if multiple=="false">function(node){if (node.type == 'u'){return true;} return false;}</#if></#assign>
<#assign dataoptions><#if cascadeCheck!="">cascadeCheck:${cascadeCheck},</#if><#if onChange!="">onChange:${onChange},</#if><#if multiple=="false">onBeforeSelect:${onBeforeSelectparam},</#if>url:'${request.contextPath}/sys/dept/getDeptUserTree?<#if enable=="1">enable=1<#else>enable=2</#if><#if pid!="">&id=${pid}<#else>&id=</#if>',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if multiple!=''>,multiple:${multipleparam}</#if><#if editable!=''>,editable:${editableparam}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" class="easyui-combotree" data-options="${dataoptions}" style="${style}" >
</#macro>

<#macro dictionaryCommobox name labelWidth="" id="" required="false" label="" value="" labelPosition="left" panelHeight="auto" panelMaxHeight="" panelMinHeight="" editable="true" style="width:100%" type="" onChange="">
    <#assign dataoptions><#if onChange!="">onChange:${onChange},</#if>valueField:'id',textField:'text',url:'${request.contextPath}/sys/dict/getDictData?type=${type}',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if editable!=''>,editable:${editable}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if><#if labelWidth!=''>,labelWidth:${labelWidth}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" <#if value!="">value="${value}"</#if> class="easyui-combobox"
       style="${style}" data-options="${dataoptions}">
</#macro>

<#macro menuCommobox name labelWidth="" id="" required="false" label="" value="" labelPosition="left" panelHeight="auto" panelMaxHeight="" panelMinHeight="" editable="false" style="width:100%" type="" onChange="">
    <#assign dataoptions><#if onChange!="">onChange:${onChange},</#if>valueField:'id',textField:'text',url:'${request.contextPath}/menus/getMenuData?menu=${type}',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if editable!=''>,editable:${editable}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if><#if labelWidth!=''>,labelWidth:${labelWidth}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" <#if value!="">value="${value}"</#if> class="easyui-combobox"
       style="${style}" data-options="${dataoptions}">
</#macro>

<#macro menuCommoboxs name labelWidth="" id="" required="false" label="" value="" labelPosition="left" panelHeight="auto" panelMaxHeight="" panelMinHeight="" editable="false" style="width:100%" type="" onChange="">
    <#assign dataoptions><#if onChange!="">onChange:${onChange},</#if>multiple:true,valueField:'id',textField:'text',url:'${request.contextPath}/menus/getMenuData?menu=${type}',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if editable!=''>,editable:${editable}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if><#if labelWidth!=''>,labelWidth:${labelWidth}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" <#if value!="">value="${value}"</#if> class="easyui-combobox"
       style="${style}" data-options="${dataoptions}">
</#macro>

<#macro equipementTypeCommotree name id="" required="false" label="" labelPosition="left" panelHeight="200" panelMaxHeight="" panelMinHeight="" multiple="false" editable="true" style="width:100%" pid="" cascadeCheck="true" enable="1" onChange="">
<#assign editableparam><#if multiple=="true">false<#else>${editable}</#if></#assign>
<#assign dataoptions><#if cascadeCheck!="">cascadeCheck:${cascadeCheck},</#if><#if onChange!="">onChange:${onChange},</#if>url:'${request.contextPath}/equipment/type/getTypeTree?<#if enable=="1">enable=1<#else>enable=2</#if><#if pid!="">&id=${pid}</#if>',method:'get'<#if required!=''>,required:${required}</#if><#if label!=''>,label:'${label}'</#if><#if labelPosition!=''>,labelPosition:'${labelPosition}'</#if><#if multiple!=''>,multiple:${multiple}</#if><#if editable!=''>,editable:${editableparam}</#if>,panelHeight:'${panelHeight}'<#if panelMaxHeight!=''>,panelMaxHeight:${panelMaxHeight}</#if><#if panelMinHeight!=''>,panelMinHeight:${panelMinHeight}</#if></#assign>
<input <#if id!="">id="${id}"</#if> name="${name}" class="easyui-combotree" data-options="${dataoptions}" style="${style}">
</#macro>