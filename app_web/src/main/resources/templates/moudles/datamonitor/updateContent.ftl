<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>修改汇报</title>
</head>
<body>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" lay-filter="component-form-group">
                <div class="layui-form-item">
                    <div>
                        <h1>汇报内容</h1>
                        <script id="editor1" type="text/plain" style="width:900px;height:600px;"></script>
                        </div>
                        </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">汇报人：</label>
                    <div class="layui-inline">
                        <div class="layui-input-inline">
                            <select name="modules" lay-verify="required" lay-search="" id="userSearch">

                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">汇报时间：</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" id="createTime" placeholder="yyyy-MM-dd HH:mm:ss" value="${reporting.createTime}">
                        </div>
                    </div>
                    <div style="margin: 5% auto; text-align: center;">
                        <button class="layui-btn" onclick="update()">保存</button>
                    </div>
            </form>
        </div>
    </div>
</div>
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
<script src="${request.contextPath}/static/layui/layui.all.js"></script>
<script src="${request.contextPath}/static/NIM_Web_Demo-master/webdemo/im/js/util.js"></script>
<script type="text/javascript" charset="utf-8" src="${request.contextPath}/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${request.contextPath}/static/ueditor/ueditor.all.min.js"> </script>
<script>
    var ue = UE.getEditor('editor1');
    var layedit;
    var index;
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //日期时间选择器
        laydate.render({
            elem: '#createTime',
            type: 'datetime',
            trigger: 'click'
        });
    });
    var userName = '<@sec.authentication property="principal.name"/>'
    $("#userName").text(userName);
    $("#createTime").text(new Date().Format("yyyy-MM-dd"));

    function update() {
        var userId = jQuery("#userSearch  option:selected").val();
        $.ajax({
            type: "POST",
            url: "${request.contextPath}/dataMonitor/DataMonitor/saveReporting",
            async: false,
            dataType: "json",
            data: {
                uuid: '${reporting.uuid}',
                userId: userId,
                content: UE.getEditor('editor1').getContent(),
                time: $("#createTime").val()
            },
            success: function (data) {
                if (data.status == 200) {
                    window.parent.location.href="${request.contextPath}/dataMonitor/DataMonitor/reporting"
                } else {
                    layer.msg('服务器出了点问题');
                }
            }
        });

    }

    function findUser() {
        layui.use(['form', 'upload', 'layer'], function () {
            var form = layui.form;
            $.ajax({
                type: "GET",
                url: "${request.contextPath}/sys/user/findList",
                async: false,
                dataType: "json",
                data: "data",
                success: function (data) {
                    var content = "";
                    content += "<option value='${reporting.userId}'>${reporting.username}</option>"
                    for (var i = 0; i < data.length; i++) {
                        content += "<option value='" + data[i][0] + "'>" + data[i][1] + "</option>"
                    }
                    $("#userSearch").append(content);
                    //重新渲染select
                    form.render('select');
                }
            });
        });
    }
    findUser();
    setTimeout(function () {
        UE.getEditor('editor1').setContent('${reporting.content}', false);
    },666)
</script>
</body>
</html>
