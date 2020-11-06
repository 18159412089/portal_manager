<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>环保督察-具体台账</title>
</head>
<body style="background-color: #f3f8f6">
    <#include "/common/loadingDiv.ftl"/>
    <#include "/decorators/header.ftl"/>
    <#include "/passwordModify.ftl">
   <#-- <#if authority??>
    <#include "/supervisionMenu.ftl">
    <#else>
    <#include "/inputSupervisionMenu.ftl">
    </#if>-->
    <#include "/secondToolbar.ftl">
    <style>
        html{
            height: auto !important;
            overflow: auto!important;
        }
        #myPrint{
            width: 100%;
            padding: 70px 40px 84px 40px ;
        }
        .data-display-container{
            background-color: #f3f8f6;
        }
        .datagrid-wrap >.datagrid-view{
            display: inline-block;
            width: 100% !important;
            padding: 0 30px;
            background-color: white;
            box-sizing: border-box;
        }
        #toolbar .textbox-text{
            background-color: #f3f8f6;
        }
        .textbox{
            border: 1px solid #45b97c;
        }

         .alone-button{
              background: #51a1fa !important;
              border-color: #51a1fa !important;
         }

        @media screen and (min-width: 1200px) {
            body {
                background-color: brown;
            }
        }
        /*平板电脑与小屏电脑之间的分辨率*/
        @media screen and (min-width: 768px) and (max-width:979px) {
            body {
                background-color: blue;
            }
        }
        /*横向放置的手机和竖向放置的平板之间的分辨率*/
        @media screen and (max-width:767px) {
            body {
                background-color: blueviolet;
            }
        }

        /*竖向放置的手机以及分别率*/
        @media screen and (max-width: 480px) {
            body {
                background-color: black;
            }
        }
    </style>
<!-- datagrid -->
<input style="display: none;" id="authority" value="${authority!}">
<div  id="myPrint" class="easyui-layout" fit=false  style="padding-top:0px;">
    <div id="toolbar">
    	<div class="data-display-container">
	        <div class="title">
	            <span>漳州市环保督察具体台账</span>
                <a onclick="Ams.doPrint('myPrint')" id="printImg" class="printing-button" style=" cursor:pointer;display: inline-block;float: right;font-size: 14px;
                width: 98px; line-height: 40px;color: white; background-color: #45b97c; border-radius: 3px;margin-right: 50px;margin-top: 10px;text-align: center;" >
                    <span style="font-size: 28px; vertical-align: middle" class="icon iconcustom" /></span> 打印
                </a>
	        </div>
    	</div>
        <div  style="display: inline-block; background-color: white;width: 100%; background-color: #f3f8f6;">
            <div style="padding:0px;border-bottom: none!important;" id="searchBar">
                <form id="searchForm">
                    <label class="control-label" id="name">文件夹名称：</label>
                    <input type="text" id="standingBookName" name="standingBookName" class="easyui-textbox" style="width:156px;">
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
                </form>
            </div>
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" id="newActach" data-options="iconCls:'icon-add'" onclick="newActach()">上传文件</a>
        </@sec.authorize>
        </div>




    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/debrief/StandingBook/list" data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            pagination:true,
            pagination:true,
            pageSize:20,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="name" width="120px" data-options="formatter:newFolder">台账</th>
        </tr>
        </thead>
    </table>
<!-- 引入底部文字提示 main -->
    <#include "/moudles/debriefing/tips-font.ftl"/>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="uuid" name="uuid" hidden="true"/>
        <input id="pointName" name="pointName" hidden="true"/>
        <div style="margin-bottom:10px">
        <div style="margin-bottom:10px">
            <select name="type" class="easyui-combobox" data-options="required:true,editable:false" id="bigClass" label="大类:"
                    style="width:100%">
                <option value="0">一本账</option>
                <option value="1">环境督察</option>
            </select>
        </div>
            <input class="easyui-combobox" name="relationTableId" id="subClass" label="小类:" required="true"
                data-options="

                        method:'get',
                        editable:false,
                        valueField:'id',
                        textField:'text',
                        multiple:false,
                        panelHeight:'350px'"
                        style="width:100%">
        </div>
        <div style="margin-bottom:10px">
        <input class=" easyui-linkbutton btn-blue" label="上传文件:" data-options="required:true,buttonText:'选择文件',accept:''" style="width:100%"
             id="file" name="file"/>
        </div>

    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveActach()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload >您的浏览器不支持 video 标签。</video>
</div>

<script>
    // 0为文件夹 1为 文件
	var f = 0; 
	// 大类 
	var bigClass ="" ;
	// 小类
	var subClass ="";
	var folderName = "";
	var fileName = "";
    var myVideo = document.getElementById("video");//获取video对象
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    $(function(){
        //doSearch();
        var authority=$("#authority").val();
        if(authority=='1'){
            $("#newActach").hide();
        }
        $('#bigClass').combobox({
	        onChange: function (newValue, oldValue) {
	           if(!newValue ==""){
	               console.log(newValue);
	                $('#subClass').combobox({
			            url:'/debrief/StandingBook/getSubClassName?type='+newValue,
			            valueField:'uuid',
			            textField:'name'
			        });
	           }
	        }
        });

        // 关闭视频后关闭声音
        $("#videoDlg").dialog({
            onClose: function () {
                myVideo.pause();
            }
        });

    });
    

    
    $('#dg').datagrid({
        //单击事件   
            onClickRow:function(rowIndex,rowData){
                 var id = rowData.uuid;
                 if( f== 0) {
                     folderName = $("#standingBookName").textbox('getValue');
                     $("#searchBar").find("#searchForm").form('clear');
                     $("#standingBookName").textbox('setValue',fileName);
                     $('#name').text('文件名称：')
                        $('#dg').datagrid({
	                    url:'${request.contextPath}/debrief/StandingBook/attachmentList',
		                queryParams: {
		                    relationTableId : id,
		                    fileName : $("#standingBookName").textbox('getValue')
		                },
                        columns:[[
                            {field:'fileName',title:'文件名  &nbsp;&nbsp;&nbsp;上一级(<a href="javascript:void(0)" onclick ="back()" style="cursor:hand">'+rowData.name+'<a/>)',width:80,formatter:newFile},
                            {field:'opera',title:'操作',width:60,formatter:operation}
                        ]]
                    });
                    //doSearch();
                    console.log(rowData.relation);
                    if(rowData.relation == 'ENVIRONMEENT_RECTIFITION'){
                       bigClass = '1';
                    }else if(rowData.relation == 'task'){
                       bigClass = '0';
                    }
                    subClass = id;
                    f = 1; 
                 }
                 
            }
        });
    
   
    // 新增
    function newActach() {
       
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增文件');
        
        $('#fm').form('clear');
        if(f==1){
            $('#bigClass').combobox('setValue',bigClass);
            $('#subClass').combobox('setValue',subClass);
        }
        $("#file").filebox({required:true});
        
        url = Ams.ctxPath + '/debrief/StandingBook/save';
    }
    // 保存
    function saveActach() {
        //$("#pointName").val($("#pointCode").combobox('getText'));
        $.messager.progress({title: '提示', msg: '文件保存中请稍候......', text: ''});
        $('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $.messager.progress('close');
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
            },
            dataType: 'text/html'
        });
        doSearch();
    }
    // 查询
    function doSearch() {
        if(f == 0){
            $('#dg').datagrid({
                url:'${request.contextPath}/debrief/StandingBook/list',
                queryParams: {
                    name : $("#standingBookName").textbox('getValue')
                }
            });
        }else if(f==1){
            $('#dg').datagrid({
                url:'${request.contextPath}/debrief/StandingBook/attachmentList',
                queryParams: {
                    relationTableId : subClass,
                    fileName : $("#standingBookName").textbox('getValue')
                }
            });
        }
    }
    // 重置
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
    
    // 操作 
    function operation(val, row, index) {
        var html ="<div>";
        var name = row.fileName;
        name = name.substring(name.lastIndexOf('.')+1,name.length);
        if(name == 'mp4'){
            html += Ams.setImageSee()+"<a href='javascript:onClick=play(\""+row.mongoid+"\")' class='easyui-linkbutton'>查看</a>&emsp;"
        }else if(name == 'pdf'||name == 'png'||name == 'jpg'){
            html +=Ams.setImageSee()+"<a href='/debrief/StandingBook/browse/"+row.mongoid
            + "' class='easyui-linkbutton' target='_blank'>查看</a>&emsp;";
        }    
        html +=Ams.setImageDown()+ "<a href='/debrief/StandingBook/download/"+row.mongoid
            + "' class='easyui-linkbutton' target='_blank'>下载</a></div>";
        return html;
    }
    
    // 播放
    function play(mongoid){
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
        $('#video').attr("src", Ams.ctxPath+'/debrief/StandingBook/browse/'+mongoid);
    }
    // 文件夹
    function newFolder(val, row, index) {
        var html ='<div><img width="25px" heigth="25px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/attachment.png">'+ row.name+'<div>';
        return html
    }
    // 文件
    function newFile(val, row, index) {
        var name = row.fileName;
        var html = "";
        name = name.substring(name.lastIndexOf('.')+1,name.length);
        html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/white.png">'+ row.fileName+'<div>';
        if ('pdf'==name){
            html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/pdf.png">'+ row.fileName+'<div>';
        }else if('word'==name){
            html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/word.png">'+ row.fileName+'<div>';
        }else if('xls'==name ||'xlsx'==name){
            html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/xls.png">'+ row.fileName+'<div>';
        }else if('png'==name ||'jpg'==name){
            html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/png.png">'+ row.fileName+'<div>';
        }else if('mp4'==name ||'mp3'==name){
            html ='<div><img width="20px" heigth="20px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/mp4.png">'+ row.fileName+'<div>';
        }
        return html
    }
    // 返回
    function back(){
        fileName = $("#standingBookName").val();
        $("#searchBar").find("#searchForm").form('clear');
        
		$("#standingBookName").textbox('setValue',folderName);
		$('#name').text('文件夹名称：')
		$('#dg').datagrid({
		            
                url:'${request.contextPath}/debrief/StandingBook/list',
                queryParams: {
                    name : folderName
                },
	            columns:[[
	                {field:'name',title:'台账',width:80,formatter:newFolder}
	            ]]
		});
		f = 0;
		//doSearch();
    }
</script>
</body>
</html>