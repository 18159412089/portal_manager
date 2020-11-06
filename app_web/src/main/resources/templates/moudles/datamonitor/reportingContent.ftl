<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>查看汇报</title>
</head>
<body>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"/>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" lay-filter="component-form-group">
                <div class="layui-form-item">
                    <div>${reporting.content}</div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">汇报人：</label>
                    <span class="layui-form-mid layui-word-aux">${reporting.username}</span>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">汇报时间：</label>
                    <span class="layui-form-mid layui-word-aux">${reporting.createTime}</span>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${request.contextPath}/static/plugin/jquery-easyui/jquery.min.js"></script>
<script src="${request.contextPath}/static/layui/layui.all.js"></script>
<script src="${request.contextPath}/static/NIM_Web_Demo-master/webdemo/im/js/util.js"></script>
</body>
</html>
