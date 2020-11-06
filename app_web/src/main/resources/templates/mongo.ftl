<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>mongo附件测试</title>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/green/easyui.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/icon.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/IconExtension.css"/>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
    <script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="${request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/bootstrap/bootstrap.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/webuploader/webuploader.css"/>
    <script src="${request.contextPath}/static/plugin/bootstrap/bootstrap.min.js"></script>
    <script src="${request.contextPath}/static/plugin/webuploader/webuploader.min.js"></script>
    <script src="${request.contextPath}/static/plugin/viewer/viewer.min.js"></script>
    <script src="${request.contextPath}/static/common/Ams.js"></script>
    <script src="${request.contextPath}/static/common/web-upload-object.js"></script>

</head>
<body>
<#--图片预览-->
<#--<div>-->
<#--<img src="${request.contextPath}/file/download/xxxxxxxx">-->
<#--</div>-->
<#--图片上传-->
<#--<div>-->
<#--<img src="${request.contextPath}/file/download/xxxxxxxx">-->
<#--</div>-->
<#--普通页面单文件上传-->
<#--普通页面多文件上传-->
<#--datagrid上传-->
<#--对话框上传-->
<#--<div>-->
<#--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-disk_upload'"-->
<#--onclick="fileUploadDlg()">文件上传</a>-->
<#--</div>-->
<#--<div id="dlg" class="easyui-dialog" style="width:500px;"-->
<#--data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">-->
<#--<form id="ff" method="post" enctype="multipart/form-data" style="padding:20px 50px">-->
<#--<table>-->
<#--<tr>-->
<#--<td>请选择文件</td>-->
<#--<td width="5px;"></td>-->
<#--<td><input type="file" id="file" name="file" class="easyui-filebox"></td>-->
<#--<td></td>-->
<#--</tr>-->
<#--<tr>-->
<#--<td colspan="4"><label id="fileName"></label></td>-->
<#--</tr>-->
<#--</table>-->
<#--</form>-->
<#--</div>-->
<#--<div id="dlg-buttons">-->
<#--<a href="javascript:void(0)" class="easyui-linkbutton c6" data-options="iconCls:'icon-ok'"-->
<#--onclick="uploadFile()"-->
<#--style="width:90px">上传</a>-->
<#--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"-->
<#--onclick="javascript:$('#dlg').dialog('close')" style="width:90px">关闭</a>-->
<#--</div>-->
<#--webuploader上传-->
<div class="form-group">
    <label class="col-sm-3 control-label head-scu-label">${name!''}</label>
    <div class="col-sm-4">
        <div id="img_content" class="col-sm-4">
            <div id="imgPreId">
                <div><img width="100px" height="100px"></div>
            </div>
        </div>
    </div>
    <div class="col-sm-2">
        <div class="head-scu-btn upload-btn" id="imgBtnId">
            <i class="fa fa-upload"></i>&nbsp;上传
        </div>
    </div>
    <input type="hidden" id="img" value="${avatarImg!''}"/>
</div>
<div class="hr-line-dashed"></div>
<h3>使用webuploader进行文件的上传</h3>
    <div>
        <div id="uploader" class="wu-example">
            <!--待上传的文件列表，用来存放文件信息-->
            <div id="thelist" class="uploader-list"></div>
            <div class="btns">
                <div id="picker">选择文件</div>
                <button id="ctlBtn" class="btn btn-default">开始上传</button>
            </div>
        </div>
        
    </div>
</body>
</html>
<script type="text/javascript" src="/static/js/file_upload.js"></script>
<script type="text/javascript">
    Ams.addCtx("${request.contextPath}");

	$.function(){
		if('${mongoAttachFile}'!=null){
			alert('${mongoAttachFile}');
		}
		//var s='${mongoAttachFile}';
	}

    $(function () {
        // 初始化图片上传
        var imgId = 'b075300f-f378-45c6-a20a-af5ab3526534';
        $('#img_content').find('img').attr('src', "${request.contextPath}/file/download/" + imgId);
        var avatarUp = new $ImageWebUpload("img");
        avatarUp.setUploadBarId("progressBar");
        avatarUp.init();
    });

    // function fileUploadDlg() {
    //     $('#dlg').dialog('open').dialog('center').dialog('setTitle', '文件上传');
    // }
    //
    // function uploadFile() {
    //     $("#ff").form('submit', {
    //         url: '/file/upload',
    //         data: $("#ff").serialize(),
    //         onSubmit: function () {
    //             $("#file").filebox({
    //                 onChange: function (e) {
    //                     var file = $(this).next().find('input[id^="filebox_file_id_"]');
    //                 }
    //             });
    //         },
    //         success: function (result) {
    //             debugger;
    //             console.log(result);
    //             $("#fileName").val(result.fileName);
    //             $.messager.show({
    //                 title: '提示框',
    //                 msg: '上传成功',
    //                 timeout: 500,
    //                 showType: 'show',
    //                 style: {
    //                     right: '',
    //                     top: document.body.scrollTop + document.documentElement.scrollTop,
    //                     bottom: ''
    //                 }
    //             });
    //             $('#dlg').dialog('close');
    //         }
    //     });
    // }
</script>