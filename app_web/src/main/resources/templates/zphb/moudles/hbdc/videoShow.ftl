
<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload>您的浏览器不支持 video 标签。</video>
</div>

<script>

    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });
    /**
     * 视频播放
     */
    function play(mongoid) {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/zphb/environment/waterAttachment/download/' + mongoid + '/3');
    }

</script>