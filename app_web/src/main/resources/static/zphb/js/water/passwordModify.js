function openPwd() {
    $('#w').window({
        title: '修改密码',
        width: 400,
        modal: true,
        shadow: true,
        closed: true,
        height: 170,
        resizable: false
    });
}

//关闭登录窗口
function closePwd() {

    $('#w').window('close');
}

//修改密码
function editPwd() {

    var $newPwd = $('#txtNewPass');
    var $repeatPwd = $('#txtRePass');

    if ($newPwd.val() == '') {
        msgShow('系统提示', '请输入密码！', 'warning');
        return false;
    }
    if ($repeatPwd.val() == '') {
        msgShow('系统提示', '请在一次输入密码！', 'warning');
        return false;
    }

    if ($newPwd.val() != $repeatPwd.val()) {
        msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
        return false;
    }

    $.post('/sys/user/editPwd?newPwd=' + $newPwd.val(), function (data) {
        location.href = '/loginOut';
    })

}

//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
    $.messager.alert(title, msgString, msgType);
}

$(function () {
    openPwd();
    $('#editpass').click(function () {
        $('#w').window('open');
    });
})