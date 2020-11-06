<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<head>
    <title>环保督察-信访管理</title>
    <style type="text/css">

    	/*.window-shadow{*/
    		/*display: none !important;*/
    	/*}*/

        html{
            min-width: auto!important;
        }
        .textbox{
            border: 1px solid #45b97c !important;
        }
        #toolbar .textbox-text{
            background-color: #f3f8f6;
        }

    </style>
</head>
<body style=" background-color: #f3f8f6;">
    <#include "/common/loadingDiv.ftl"/>
    <#include "/decorators/header.ftl"/>
    <#include "/passwordModify.ftl">
<#--    <#if authority??>-->
<#--        <#include "/supervisionMenu.ftl">-->
<#--    <#else>-->
<#--        <#include "/inputSupervisionMenu.ftl">-->
<#--    </#if>-->
    <#include "/zphb/moudles/hbdc/hbdcToolbar.ftl">
<!-- datagrid -->
<input type="hidden" id="authority" value="${authority!}">
<div class="easyui-layout"  id="myPrint">

    <div class="dc-content-box">
        <input type="hidden" id="authority" value="${authority!}"  />
        <div class="data-display-container" style="padding: 0px;padding-top: 15px;padding-bottom: 10px;">
            <div class="dc-info-box">
                <p id="timeId">截至2019年5月6日</p>
                <div class="entry-list">
                        <span class="entry-item" style="font-size: 20px;text-align: center">信访件调查处理情况报告<i style="color: #00aa00" id="total">0</i>个</span>
                </div>
            </div>
        <#--<div id="message" style="padding:10px; width: 100%;text-align: center;font-size: 120%;font-weight: bold;color:white;background-color:#676767;"></div>-->
        </div>
        <div id="toolbar">
            <div style="padding:3px;background-color: #f3f8f6;padding: 3px; border-bottom: none" id="searchBar" >
                <form id="searchForm">
                    <label class="control-label">信访件编号:</label>
                    <input id="queryProjectName" name="queryProjectName" class="easyui-textbox"  style="width:200px;">
                <a type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
                    <a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newActach()" >新增</a>
                    <a href="#" class="easyui-linkbutton btn-purple" data-options="iconCls:'icon-save'" onclick="exportBatch()">批量导入</a>
                    <#--<a href="#" class="easyui-linkbutton btn-purple" data-options="iconCls:'icon-edit'" onclick="editActach()">修改</a>
                    <a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'"
                       onclick="deleteActach()">删除</a>-->
                <#--<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-redo'" onclick="exportExl()">导出EXCEL</a>-->
            </form>
        </div>
    </div>
    <div class="easyui-layout"  style="padding-bottom:70px;margin-left:0px;">
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
            data-options="
            queryParams : '',
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            pagination:true,
            pageSize:10,
            pageList:[10,20,30]">
                <thead>
                <tr>
                    <th field="describe" width="220px" formatter="Ams.tooltipFormat">信访件编号</th>
                    <th field="picname" width="220px" formatter="formatPic">信访件名称</th>
                    <th field="name" width="220px" >关联项目</th>
                    <th field="updateDate" width="220px" formatter="Ams.timeDateFormat">上传时间</th>
                    <th field="operate" width="220px" Resizable=false formatter="formatOperate">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
    <!-- dialog1 -->
    <div id="dlg" class="easyui-dialog" style="width:500px"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <input id="uuid" name="uuid" hidden="true"/>
            <input id="source" name="source" value="letterManage" hidden/>

            <div style="margin-bottom:10px">
                <input class="easyui-filebox" label="文件:"
                       data-options="buttonText:'选择文件',accept:'image/gif,image/jp2,image/jpeg,application/pdf,image/png'"
                       style="width:100%"
                       onchange="onchange(newVal,oldVal)" id="picFile" name="picFile"/>
            </div>
            <div style="margin-bottom:10px">
                <input name="picname" id="picnameid" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="文件名称:"
                       style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input id="projId" name="describe" class="easyui-textbox"  style="width:200px;" label="信访件编号:" />
            </div>
             <div style="margin-bottom:10px">
                 <input id="pkid" name="pkid" class="easyui-combobox" style="width:200px;" label="关联项目:"
                        data-options="
            	required:false,
            	url:'${request.contextPath}/zphb/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_03&relation=ENVIRONMEENT_RECTIFITION',
            	valueField:'id',
            	textField:'name'"/>
            </div>

            <div style="margin-bottom:10px;display: none">
                <input class="easyui-filebox" label="整改视频:" data-options="buttonText:'选择文件',accept:'audio/mp4, video/mp4'"
                       style="width:100%"
                       onchange="onchange(newVal,oldVal)" id="videoFile" name="videoFile"/>
            </div>
            <div style="margin-bottom:10px;display: none">
                <input name="vedioname" id="videonameid" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="视频名称:"
                       style="width:100%">
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
    <div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;"
         data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
        <video id="video" style="withd:auto;height:99%;" controls="controls" preload>您的浏览器不支持 video 标签。</video>
    </div>

    <!-- dialog2 批量导入 -->
    <div id="dlg2" class="easyui-dialog" style="width:500px"
         data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
        <form id="fm2" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <input name="uuid" hidden="true"/>
            <input name="source" value="letterManage" hidden/>

            <div style="margin-bottom:10px">
                <input type="easyui-filebox" label="文件:"
                       data-options="buttonText:'选择文件'"
                       style="width:100%"
                       id="picFiles"
                       multiple="true"
                       name="picFiles" required="required"/>
            </div>
        </form>
    </div>
    <div id="dlg2-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveBatch()"
           style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="$('#dlg2').dialog('close')" style="width:90px">取消</a>
    </div>
<script>
	function formatOperate(value,row,index){
        var rowData=JSON.stringify(row);
        return "<div>"+Ams.setImageEdit()+"<a href='javascript:void(0)' class='easyui-linkbutton' onClick='editActach("+rowData+")')\">编辑</a>" +
            "&nbsp;&nbsp;&nbsp;"+Ams.setImageDelete()+"<a href='#' class='easyui-linkbutton' onclick='deleteActach("+rowData+")'>删除</a></div>";
		return "";
	}
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            doSearch();
            $("#timeId").text("截至" + Ams.dateFormat(new Date(), "yyyy年MM月dd日"));
        });
    };
    Ams.inputText_enterKeyEvent("queryProjectName", doSearch);
    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });

    /**
     * 格式化视频显示
     */
    function formatVideo(value, row, index) {
        if (!Ams.isNoEmpty(row.video)) return "-";
        return "<div>" + Ams.setImageDown() + "<a href='javascript:onClick=play(\"" + row.video + "\")' class='easyui-linkbutton'>" + row.vedioname + "</a></div>";
    }


    /**
     * 视频播放
     */
    function play(mongoid) {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/zphb/environment/waterAttachment/download/' + mongoid + '/3');
    }

    /**
     * 新增
     * @type {string}
     */
    var url = '';

    function newActach() {
        $('#fm').form('clear');
        $('#projId').textbox('setValue','');
        $('#picnameid').textbox('setValue','');
        $("#picFile").filebox({prompt: ''});
        $('#videoFile').filebox({prompt: ''});
        $("#source").val("letterManage");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增附件');
        $("#file").filebox({required: true});
    }

    $('#picFile').filebox({
        onChange: function (newValue, oldValue) {
            // var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            // var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#picnameid').textbox('setValue', newValue);
            $('#projId').textbox('setValue', newValue.substring(0, newValue.indexOf('号')+1));
        }
    });
    $('#videoFile').filebox({
        onChange: function (newValue, oldValue) {
            var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#videonameid').textbox('setValue', filename);
        }
    });

    /**
     * 格式化图片显示
     */
    function formatPic(value, row, index) {
        if (!Ams.isNoEmpty(row.picture)) return "-";
        var name = row.picname;
        name = name.substring(name.lastIndexOf('.')+1,name.length);
        if(name == 'pdf'||name == 'png'||name == 'jpg'){
            return "<div>" + Ams.setImageSee() + "<a href='/environment/waterAttachment/download/" + row.picture + "/2" +
                "' class='easyui-linkbutton' target='_blank'>" + row.picname + "</a></div>";
        }else if(name == 'mp4' || name == 'mp3'){
            return "<div>" + Ams.setImageSee() + "<a href='javascript:onClick=play(\"" + row.picture + "\")' class='easyui-linkbutton'>" + row.picname + "</a></div>";
        }else {
            return "<div>" + Ams.setImageDown() + "<a href='/debrief/StandingBook/download/" + row.picture +
                "' class='easyui-linkbutton' target='_blank'>" + row.picname + "</a></div>";
        }
    }

    /**
     * 编辑
     * @type {string}
     */
    function editActach(row) {
        if (row) {
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改附件信息');
            $('#fm').form('load', row);
            $("#source").val("letterManage");
            $("#picFile").filebox({required: false});
            $('#videoFile').filebox({required: false});
            $("#picFile").filebox({prompt: row.picname});
            $('#videoFile').filebox({prompt: row.vedioname});
            url = Ams.ctxPath + '/enviromonit/airConstructionSite/save';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    /**
     * 编辑
     * @type {string}
     */
    function exportBatch() {
            $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '批量导入附件信息');
            $("#picFiles").filebox({required: true});
            url = Ams.ctxPath + '/enviromonit/airConstructionSite/saveAttachBatch';
    }

    /**
     * 删除
     * @type {string}
     */
    function deleteActach(row) {
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    var loadIndex = '';
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/enviromonit/airConstructionSite/delete',
                        data: {
                            'uuid': row.uuid,
                            "pictureId": row.picture,
                            "videoId": row.video
                        },
                        beforeSend: function () {
                            loadIndex = layer.load(1, {
                                shade: [0.1, '#fff']
                            });
                        },
                        complete: function () {
                            layer.close(loadIndex);
                        },
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                                Ams.success('操作成功');
                            }
                        },
                        error: function () {
                            $.messager.progress('close');
                            $.messager.show({
                                title: '错误',
                                msg: '删除失败！'
                            });
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    /**
     * 保存
     * @type {string}
     */
    function saveActach() {
        if (Ams.isNoEmpty($('#pkid').val())){
            $.ajax({
                type : "post",
                url : "/enviromonit/airConstructionSite/checkPkidExist",
                async : false,
                data: {
                    pkid:$('#pkid').val(),
                    uuid:$('#uuid').val()

                },
                success : function(result) {
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        if (result.message == '此项目已存在附件！') {
                            $.messager.confirm("提示信息", result.message+"是否替换附件？", function (r) {
                                if (r) {
                                    changeFile();
                                }
                            });
                        }else {
                            overCheck();
                        }
                    }

                },
                error : function() {
                },
                dataType : 'json'
            });
        }else{
            overCheck();
        }

    }

    function overCheck(){
        $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
        $('#fm').form('submit', {
            url: Ams.ctxPath + '/enviromonit/airConstructionSite/save',
            iframe: false,
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (result) {
                $('#fm').form('clear');
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
                $.messager.progress('close');
            }
        });

    }


    function changeFile(){
        $.ajax({
            type : "post",
            url : "/enviromonit/airConstructionSite/changeFile",
            async : false,
            data: {
                pkid:$('#pkid').val()
            },
            success : function(result) {
                if (result.type == 'E') {
                    Ams.error(result.message);
                }else{
                    overCheck();
                }
            },
            error : function() {
            },
            dataType : 'json'
        });
    }

    /**
     * 保存 [批量导入文件]
     * @type {string}
     */
    function saveBatch() {
        $.messager.progress({title: '提示', msg: '批量附件保存中，请耐心等待......', text: ''});
        $('#fm2').form('submit', {
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
                $('#fm2').form('clear');
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg2').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
                $.messager.progress('close');
            }
        });
    }

    /**
     * 查询
     * @type {string}
     */
    function doSearch() {
        $('#dg').datagrid({
            url: "/zphb/environment/letterManage/getFileAttachPage",
            queryParams: {
                describe: $("#queryProjectName").val(),
                source:'letterManage'
            },onLoadSuccess : function(data){
                $("#total").text(data.total);
            },onDblClickRow: function (index, row) {
                editActach(row);
            }
        })
    }

    /**
     * 重置
     */
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }

</script>
</body>
</html>