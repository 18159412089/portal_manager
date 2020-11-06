/**
 * web-upload 工具类
 *
 * 约定：
 * 上传按钮的id = 图片隐藏域id + 'BtnId'
 * 图片预览框的id = 图片隐藏域id + 'PreId'
 *
 */
(function () {

    var $ImageWebUpload = function (pictureId) {
        this.pictureId = pictureId;
        this.uploadBtnId = pictureId + "BtnId";
        this.uploadPreId = pictureId + "PreId";
        this.uploadUrl = Ams.ctxPath + '/file/upload';
        this.fileSizeLimit = 100 * 1024 * 1024;
        this.picWidth = 800;
        this.picHeight = 800;
        this.uploadBarId = null;
    };

    $ImageWebUpload.prototype = {
        /**
         * 初始化webUploader
         */
        init: function () {
            var uploader = this.create();
            this.bindEvent(uploader);
            this.previewImg();
            return uploader;
        },

        /**
         * 创建webuploader对象onFileDequeued
         */
        create: function () {
            var webUploader = WebUploader.create({
                auto: true,
                pick: {
                    id: '#' + this.uploadBtnId,
                    multiple: false,// 只上传一个
                },
                accept: {
                    title: 'Images',
                    extensions: 'gif,jpg,jpeg,bmp,png',
                    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
                },
                swf: Ams.ctxPath
                + '/static/plugin/webuploader/Uploader.swf',
                disableGlobalDnd: true,
                duplicate: true,
                server: this.uploadUrl,
                fileSingleSizeLimit: this.fileSizeLimit
            });

            return webUploader;
        },

        /**
         * 绑定事件
         */
        bindEvent: function (bindedObj) {
            var me = this;
            bindedObj.on('fileQueued', function (file) {
                var $li = $('<div><img width="100px" height="100px"></div>');
                var $img = $li.find('img');

                $("#" + me.uploadPreId).html($li);

                // 生成缩略图
                bindedObj.makeThumb(file, function (error, src) {
                    if (error) {
                        $img.replaceWith('<span>不能预览</span>');
                        return;
                    }
                    $img.attr('src', src);
                }, me.picWidth, me.picHeight);
            });

            // 文件上传过程中创建进度条实时显示。
            bindedObj.on('uploadProgress', function (file, percentage) {
                $("#" + me.uploadBarId).css("width", percentage * 100 + "%");
            });

            // 文件上传成功，给item添加成功class, 用样式标记上传成功。
            bindedObj.on('uploadSuccess', function (file, response) {
                Ams.success("上传成功");
                $("#" + me.pictureId).val(response.data.fileName);
                $('#img_content').find('img').attr('src', response.data.url);
            });

            // 文件上传失败，显示上传出错。
            bindedObj.on('uploadError', function (file) {
                Ams.error("上传失败");
            });

            // 其他错误
            bindedObj.on('error', function (type) {
                if ("Q_EXCEED_SIZE_LIMIT" == type) {
                    Ams.error("文件大小超出了限制");
                } else if ("Q_TYPE_DENIED" == type) {
                    Ams.error("文件类型不满足");
                } else if ("Q_EXCEED_NUM_LIMIT" == type) {
                    Ams.error("上传数量超过限制");
                } else if ("F_DUPLICATE" == type) {
                    Ams.error("图片选择重复");
                } else {
                    Ams.error("上传过程中出错");
                }
            });

            // 完成上传完了，成功或者失败
            bindedObj.on('uploadComplete', function (file) {
            });
        },

        /**
         * 设置图片上传的进度条的id
         */
        setUploadBarId: function (id) {
            this.uploadBarId = id;
        },

        /**
         * 预览图片
         */
        previewImg: function () {
            var options = {
                url: 'data-original'
            };
            var viewer = new Viewer(document.getElementById('img_content'), options);
        }
    };

    window.$ImageWebUpload = $ImageWebUpload;

}());