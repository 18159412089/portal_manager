<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>点位信息配置</title>
</head>
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<!-- datagrid -->
<div class="easyui-layout" fit=true >

    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">项目名称:</label>
                <input id="queryProjectName" name="name" class="easyui-combobox" style="width:200px;" label=""
                       data-options="
            	required:false,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION',
            	valueField:'id',
            	textField:'name'"/>
                <label class="control-label">备注:</label>
                <input type="text" id="disgribe" name="disgribe" class="easyui-textbox" style="width:156px;">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newActach()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editActach()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'"
           onclick="deleteActach()">删除</a>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:90%;" toolbar="#toolbar"
           data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            nowrap:false,
            pagination:true,
            pageSize:10,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="picture" hidden></th>
            <th field="video" hidden></th>
            <th field="projname" width="120px" formatter="Ams.tooltipFormat">项目名称</th>
            <th field="picname" width="120px" formatter="formatPic">整改前后图片对比</th>
            <th field="vedioname" width="120px" formatter="formatVideo">整改视频</th>
            <th field="longitude" width="60px">经度</th>
            <th field="latitude" width="60px">纬度</th>
            <th field="remark" width="60px" formatter="Ams.tooltipFormat">备注</th>
            <th field="disgribe" width="250px" formatter="Ams.tooltipFormat">描述</th>
            <th field="createDate" width="100px" formatter="Ams.timeDateFormat">上报时间</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <input value="${pointCode!}" id="pointCodeId" type="hidden">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="uuid" name="uuid" hidden="true"/>
        <input id="projname" name="projname" hidden="true"/>

        <div style="margin-bottom:10px">
            <input id="projId" name="name" class="easyui-combobox" style="width:200px;" label="项目:"
                   data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION',
            	valueField:'id',
            	textField:'name'"/>
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="整改前后图片:"
                   data-options="buttonText:'选择文件',accept:'image/gif,image/jp2,image/jpeg,application/pdf,image/png'"
                   style="width:100%"
                   onchange="onchange(newVal,oldVal)" id="picFile" name="picFile"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="picname" id="picnameid" class="easyui-textbox" label="图片名称:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="整改视频:" data-options="buttonText:'选择文件',accept:'audio/mp4, video/mp4'"
                   style="width:100%"
                   onchange="onchange(newVal,oldVal)" id="videoFile" name="videoFile"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="vedioname" id="videonameid" class="easyui-textbox" label="视频名称:"
                   style="width:100%">
        </div>

        <div style="margin-bottom:10px">
            <input name="longitude" class="easyui-textbox" data-options="label:'经度:'" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="latitude" class="easyui-textbox" data-options="label:'纬度:'" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'备注:'" prompt="可输入所属地点区分"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="disgribe" class="easyui-textbox" data-options="label:'描述:'" multiline="true"
                   style="width:100%;height:120px">
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
<input type="hidden" id="authority" value="${authority!}">
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });

    $(function () {
        doSearch();
    });

    /**
     * 格式化图片显示
     */
    function formatPic(value, row, index) {
        if (!Ams.isNoEmpty(row.picture)) return "-";
        return "<div>" + Ams.setImageDown() + "<a href='/environment/waterAttachment/download/" + row.picture + "/2" +
            "' class='easyui-linkbutton' target='_blank'>" + row.picname + "</a></div>";
    }

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
        $('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
    }

    /**
     * 新增
     * @type {string}
     */
    var url = '';

    function newActach() {
        $('#fm').form('clear');
        $("#picFile").filebox({prompt: ''});
        $('#videoFile').filebox({prompt: ''});
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增附件');
        $("#file").filebox({required: true});
        url = Ams.ctxPath + '/enviromonit/distributeMap/save';
    }

    $('#picFile').filebox({
        onChange: function (newValue, oldValue) {
            var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#picnameid').textbox('setValue', filename);
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
     * 编辑
     * @type {string}
     */
    function editActach() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改附件信息');
            $('#fm').form('load', row);
            $("#picFile").filebox({required: false});
            $('#videoFile').filebox({required: false});
            $("#picFile").filebox({prompt: row.picname});
            $('#videoFile').filebox({prompt: row.vedioname});
            url = Ams.ctxPath + '/enviromonit/distributeMap/save';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    /**
     * 删除
     * @type {string}
     */
    function deleteActach() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    var loadIndex = '';
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/enviromonit/distributeMap/delete',
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
        $("#projname").val($("#projId").combobox('getText'));
        var loadIndex = '';
        loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
                layer.close(loadIndex);

            }
        });
    }

    /**
     * 查询
     * @type {string}
     */
    function doSearch() {
        $('#dg').datagrid({
            url: "/enviromonit/distributeMap/getFilePage",
            queryParams: {
                name: $("#queryProjectName").combobox('getValue'),
                disgribe: $("#disgribe").val()
            }
        })
    }


    /**
     * 重置
     * @type {string}
     */
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>