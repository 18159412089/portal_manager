
var obj;//当前点击的对象
function showDetail(info) {
    obj = info;
    document.getElementById('mc').innerHTML = '<span style="font-weight:bold">名称：</span>' + Ams.formatNUll(info.mc);
    document.getElementById('czwt').innerHTML = '<span style="font-weight:bold">存在问题：</span>' + Ams.formatNUll(info.czwt);
    document.getElementById('zgcs').innerHTML = '<span style="font-weight:bold">整改措施：</span>' + Ams.formatNUll(info.zgcs);
    document.getElementById('zlxm').innerHTML = '<span style="font-weight:bold">治理项目：</span>' + Ams.formatNUll(info.zlxm);
    document.getElementById('wryzl').innerHTML = '<span style="font-weight:bold">污染源种类：</span>' + Ams.formatNUll(info.wryzl);
    document.getElementById('wrylx').innerHTML = '<span style="font-weight:bold">污染源类型：</span>' + Ams.formatNUll(info.wrylx);
    document.getElementById('wcmb201912').innerHTML = Ams.formatNUll(info.wcmb201912);
    document.getElementById('wcmb202006').innerHTML = Ams.formatNUll(info.wcmb202006);
    document.getElementById('wcmb202012').innerHTML = Ams.formatNUll(info.wcmb202012);
    document.getElementById('sdzrZrdw').innerHTML = '<span style="font-weight:bold">属地责任单位：</span>' + Ams.formatNUll(info.bmzrZrdw);
    document.getElementById('bmzrZrdw').innerHTML = '<span style="font-weight:bold">部门责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);
    document.getElementById('bmzrPhzrdw').innerHTML = '<span style="font-weight:bold">配合责任单位：</span>' + Ams.formatNUll(info.bmzrPhzrdw);

    document.getElementById('qx').innerHTML = '<span style="font-weight:bold">单位：</span>' + Ams.formatNUll(info.dw);
    document.getElementById('xz').innerHTML = '<span style="font-weight:bold">乡镇：</span>' + Ams.formatNUll(info.xz);
    document.getElementById('dz').innerHTML = '<span style="font-weight:bold">地址：</span>' + Ams.formatNUll(info.dz);
    document.getElementById('jd').innerHTML = '<span style="font-weight:bold">经度：</span>' + Ams.formatNUll(info.jd);
    document.getElementById('wd').innerHTML = '<span style="font-weight:bold">纬度：</span>' + Ams.formatNUll(info.wd);
    document.getElementById('bz').innerHTML = '<span style="font-weight:bold">备注：</span>' + Ams.formatNUll(info.bz);

    var sdzrdwZrrlxfsArr = formatPhoneAndName(info.sdzrdwZrrlxfs);
    var phzrdwZrrlxfsArr = formatPhoneAndName(info.phzrdwZrrlxfs);
    var bmzrdwZrrlxfsArr = formatPhoneAndName(info.bmzrdwZrrlxfs);
    var ph_lxfs = '-';
    var s = '、';
    var newChar = ",";
    if (Ams.isNoEmpty(phzrdwZrrlxfsArr[1])) {
        ph_lxfs = phzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + phzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + phzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    var sd_lxfs = '-';
    if (Ams.isNoEmpty(sdzrdwZrrlxfsArr[1])) {
        sd_lxfs = sdzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + sdzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + sdzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    var bm_lxfs = '-';
    if (Ams.isNoEmpty(bmzrdwZrrlxfsArr[1])) {
        bm_lxfs = bmzrdwZrrlxfsArr[1] + '<a class="sewage-send-tag"> <li title="短信发送" onclick="sendMsg(\'' + bmzrdwZrrlxfsArr[0].replace(new RegExp(s, 'g'), newChar) + '\',\'' + bmzrdwZrrlxfsArr[1].replace(new RegExp(s, 'g'), newChar) + '\')" class="iconcustom icon-xinxi2"></li></a>';
    }

    document.getElementById('ph_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(phzrdwZrrlxfsArr[0]);
    document.getElementById('ph_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + ph_lxfs;
    document.getElementById('sd_fzr').innerHTML = '<span style="font-weight:bold">负责人：</span>' + Ams.formatNUll(sdzrdwZrrlxfsArr[0]);
    document.getElementById('sd_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + sd_lxfs;
    document.getElementById('bm_fzr').innerHTML = '<span style="font-weight:bold">责任人：</span>' + Ams.formatNUll(bmzrdwZrrlxfsArr[0]);
    document.getElementById('bm_lxfs').innerHTML = '<span style="font-weight:bold">联系方式：</span>' + bm_lxfs;
    $('#infoDlg').dialog('open').dialog('center').dialog('setTitle', '详情');
    findTimelineData();
}

/**
 * 短信发送
 * @param obj
 */
function sendMsg(person, phone) {
    Ams.sendMassageToUser(phone, person);
}

function formatPhoneAndName(str) {
    var newName = "";
    var newPhone = "";
    var reg = /[\u4e00-\u9fa5]/g;
    var newPhoneAndName = new Array();
    if (Ams.isNoEmpty(str)) {
        var strs = str.split(',');
        for (var i = 0; i < strs.length; i++) {
            if (i < strs.length - 1) {
                newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('') + "、" : '';
                if (Ams.isNoEmpty(strs[i].replace(/[^0-9]/ig, ""))) newPhone += strs[i].replace(/[^0-9]/ig, "") + "、";
            } else {
                newName += Ams.isNoEmpty(strs[i].match(reg)) ? strs[i].match(reg).join('') : '';
                newPhone += strs[i].replace(/[^0-9]/ig, "");
            }
        }
    }
    newPhoneAndName.push(newName);
    newPhoneAndName.push(newPhone);
    return newPhoneAndName;
}


/**
 * 保存
 * @type {string}
 */
function saveActach() {
    $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
    $('#source').val('cityPollutionMapInfo');
    $('#mcid').val(obj.mc);
    $('#jdid').val(obj.jd);
    $('#wdid').val(obj.wd);
    $('#fm').form('submit', {
        url: Ams.ctxPath + '/env/pollution2/save',
        iframe: false,
        onSubmit: function () {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close');	// hide progress bar while the form is invalid
            }
            return isValid;
        },
        success: function (result) {
            var result = JSON.parse(result);
            if (result.type == 'E') {
                layer.msg(result.message);
            } else {
                $('#uploadDlg').dialog('close');
                layer.msg('操作成功！');
                findTimelineData();
            }
            $('#fm').form('clear');
            $.messager.progress('close');
        }
    });
}

$('#picFile').filebox({
    onChange: function (newValue, oldValue) {
        var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
        var filename = newValue.substring(0, newValue.lastIndexOf('.'));
        $('#picnameid').textbox('setValue', filename);
    }
});

function findTimelineData() {
    $.ajax({
        type: 'POST',
        url: Ams.ctxPath + '/env/pollution2/findTimelineData',
        data: {
            'mc': obj.mc,
            'jd': obj.jd,
            'wd': obj.wd,
            'source': 'cityPollutionMapInfo'

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
            var list = result.allTimeLineData;
            var html = '';
            var pic;
            var suffix;
            var pic;
            var img;
            html += '<div class="time-axis-container">';
            html += '<ul>';
            for (var obj in list) {

                html += '<li class="item highlight">';
                html += '<div class="time-axis-part">';
                html += '<div class="time-axis-head">';
                html += '<span>上传时间：' + Ams.timeDateFormat(list[obj].createDate) + '</span>';
                html += '<a class="delete-tag" onclick="deleteActach(\'' + list[obj].uuid + '\',\'' + list[obj].picture + '\')"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>';
                html += '</div>';
                html += '<div class="time-axis-content">';
                html += '<div class="img-box">';

                pic = list[obj].picname;
                suffix = pic == null ? '' : pic.substring(pic.lastIndexOf('.') + 1, pic.length).toLowerCase();
                if (suffix == 'mp4' || suffix == 'mp3') {
                    img = '<img style="cursor: pointer" title="点击播放" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/VIDEO.jpg" width="100%;">'
                } else if (suffix == 'pdf') {
                    img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/PDF.jpg" width="100%;">'
                } else if (suffix == 'rar' || suffix == 'zip') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/rar.png" width="100%;">'
                } else if (suffix == 'doc' || suffix == 'docx') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/WORD.jpg" width="100%;">'
                } else if (suffix == 'xls' || suffix == 'xlsx') {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/excel.jpg" width="100%;">'
                } else if (suffix == 'bmp' || suffix == 'png' || suffix == 'gif' || suffix == 'jpg') {
                    img = '<img style="cursor: pointer" title="点击查看" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/environment/waterAttachment/download/' + list[obj].picture + '/3" width="100%;">';
                } else {
                    img = '<img style="cursor: pointer" title="点击下载" class="bigImg" onclick="showBigImg(this,\'' + list[obj].picture + '\',\'' + list[obj].picname + '\')" src="/static/images/attachment/other.jpg" width="100%;">'
                }
                html += img;
                html += '</div>';
                html += '</div>';
                html += '<p>描述：</p>';
                html += '<p>' + Ams.formatNUll(list[obj].describe) + '</p>';
                html += '</div>';
                html += '</li>';
            }
            html += '</ul>';
            html += '</div>';

            $('#timeData').html(html);
            if (result.type == 'E') {
                layer.msg(result.message);
            }
        },
        dataType: 'json'
    });
}

/**
 * 删除
 * @type {string}
 */
function deleteActach(uuid, picid) {
    $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
        if (r) {
            $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
            var loadIndex = '';
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/pollution2/deleteActach',
                data: {
                    'uuid': uuid,
                    "picture": picid
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
                        layer.msg(result.message);
                    } else {
                        findTimelineData();
                        layer.msg('操作成功');
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
}

//图片放大
function showBigImg(idthis, picid, picname) {
    picname = picname.substring(picname.lastIndexOf('.') + 1, picname.length);
    if (picname == 'mp4') {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/debrief/StandingBook/browse/' + picid);
    } else {
        window.open('/debrief/StandingBook/browse/' + picid);
    }
    // imgShow("#outerdiv", "#innerdiv", "#bigimg", idthis);

}

// 播放
function play(mongoid) {
    $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
    //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
    $('#video').attr("src", Ams.ctxPath + '/debrief/StandingBook/browse/' + mongoid);
}

var myVideo = document.getElementById("video");//获取video对象
// 关闭视频后关闭声音
$("#videoDlg").dialog({
    onClose: function () {
        myVideo.pause();
    }
});
